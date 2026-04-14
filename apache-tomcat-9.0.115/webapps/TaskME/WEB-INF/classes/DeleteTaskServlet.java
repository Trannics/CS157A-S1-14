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

                // Delete task (FK cascade handles assignments, comments, etc.)
                try (PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM tasks WHERE Task_ID=? AND Project_ID=?"
                )) {
                    ps.setInt(1, taskId);
                    ps.setInt(2, projectId);
                    ps.executeUpdate();
                }

                response.sendRedirect("project?id=" + projectId);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("DeleteTask error: " + e.getMessage());
        }
    }
}