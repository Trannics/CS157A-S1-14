import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class DeleteTaskServlet extends HttpServlet {

    private static final String DB_URL  = "jdbc:mysql://localhost:3306/team14";
    private static final String DB_USER = "taskme_app";
    private static final String DB_PASS = "taskme123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Log-In-Page.html");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        String tidStr = request.getParameter("taskId");
        String pidStr = request.getParameter("projectId");

        if (tidStr == null || pidStr == null) {
            response.getWriter().println("Missing taskId or projectId");
            return;
        }

        int taskId, projectId;
        try {
            taskId    = Integer.parseInt(tidStr);
            projectId = Integer.parseInt(pidStr);
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid taskId or projectId");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                // Membership + role check
                String role = null;
                try (PreparedStatement ps = con.prepareStatement(
                    "SELECT Role FROM project_memberships WHERE Project_ID=? AND User_ID=?"
                )) {
                    ps.setInt(1, projectId);
                    ps.setInt(2, userId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) role = rs.getString("Role");
                    }
                }

                if (role == null || "COMMENT_ONLY".equals(role)) {
                    response.getWriter().println("Access denied: cannot delete task.");
                    return;
                }

                // Records title before deletion for the notification message
                String taskTitle = "Task #" + taskId;
                try (PreparedStatement ps = con.prepareStatement(
                    "SELECT Task_Title FROM tasks WHERE Task_ID=? AND Project_ID=?"
                )) {
                    ps.setInt(1, taskId);
                    ps.setInt(2, projectId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) taskTitle = rs.getString("Task_Title");
                    }
                }

                // Delete task (FK cascade handles assignments, comments, etc.)
                try (PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM tasks WHERE Task_ID=? AND Project_ID=?"
                )) {
                    ps.setInt(1, taskId);
                    ps.setInt(2, projectId);
                    ps.executeUpdate();
                }

                try (PreparedStatement logPs = con.prepareStatement(
                    "INSERT INTO activity_log (Project_ID, User_ID, Action_Type, Entity_Type, Entity_ID) VALUES (?, ?, ?, ?, ?)"
                )) {
                    logPs.setInt(1, projectId);
                    logPs.setInt(2, userId);
                    logPs.setString(3, "DELETE");
                    logPs.setString(4, "Task");
                    logPs.setInt(5, taskId);
                    logPs.executeUpdate();
                }

                // Notify all other project members
                try (PreparedStatement notifPs = con.prepareStatement(
                    "INSERT INTO notifications (User_ID, Message, Triggering_Entity_Type, Triggering_Entity_ID) " +
                    "SELECT pm.User_ID, ?, 'Task', ? FROM project_memberships pm WHERE pm.Project_ID=? AND pm.User_ID!=?"
                )) {
                    notifPs.setString(1, "Task deleted: " + taskTitle);
                    notifPs.setInt(2, taskId);
                    notifPs.setInt(3, projectId);
                    notifPs.setInt(4, userId);
                    notifPs.executeUpdate();
                }

                response.sendRedirect("project?id=" + projectId);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("DeleteTask error: " + e.getMessage());
        }
    }
}