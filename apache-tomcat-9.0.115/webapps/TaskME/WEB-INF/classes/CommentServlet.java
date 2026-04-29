import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class CommentServlet extends HttpServlet {

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

        String action      = request.getParameter("action");
        String pidStr      = request.getParameter("projectId");
        String tidStr      = request.getParameter("taskId");
        String cidStr      = request.getParameter("commentId");
        String commentText = request.getParameter("commentText");

        if (pidStr == null || tidStr == null || action == null) {
            response.getWriter().println("Missing required parameters.");
            return;
        }

        int projectId, taskId;
        try {
            projectId = Integer.parseInt(pidStr);
            taskId    = Integer.parseInt(tidStr);
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid projectId or taskId.");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                // All roles (ADMIN, MEMBER, COMMENT_ONLY) may comment — just verify membership
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

                if (role == null) {
                    response.getWriter().println("Access denied: not a project member.");
                    return;
                }

                String redirect = "project?id=" + projectId + "&commentTask=" + taskId;

                // ── ADD ─────────────────────────────────────────────────────────
                if ("add".equals(action)) {
                    if (commentText == null || commentText.trim().isEmpty()) {
                        response.sendRedirect(redirect);
                        return;
                    }
                    // Verify task belongs to this project and grab its title
                    String taskTitle = null;
                    try (PreparedStatement ps = con.prepareStatement(
                        "SELECT Task_Title FROM tasks WHERE Task_ID=? AND Project_ID=?"
                    )) {
                        ps.setInt(1, taskId);
                        ps.setInt(2, projectId);
                        try (ResultSet rs = ps.executeQuery()) {
                            if (rs.next()) taskTitle = rs.getString("Task_Title");
                        }
                    }
                    if (taskTitle == null) {
                        response.getWriter().println("Task not found.");
                        return;
                    }
                    try (PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO comments (Task_ID, User_ID, Comment_Text) VALUES (?, ?, ?)"
                    )) {
                        ps.setInt(1, taskId);
                        ps.setInt(2, userId);
                        ps.setString(3, commentText.trim());
                        ps.executeUpdate();
                    }
                    try (PreparedStatement logPs = con.prepareStatement(
                        "INSERT INTO activity_log (Project_ID, User_ID, Action_Type, Entity_Type, Entity_ID) VALUES (?, ?, ?, ?, ?)"
                    )) {
                        logPs.setInt(1, projectId);
                        logPs.setInt(2, userId);
                        logPs.setString(3, "COMMENT");
                        logPs.setString(4, "Task");
                        logPs.setInt(5, taskId);
                        logPs.executeUpdate();
                    }
                    // Notify all other project members
                    try (PreparedStatement notifPs = con.prepareStatement(
                        "INSERT INTO notifications (User_ID, Message, Triggering_Entity_Type, Triggering_Entity_ID) " +
                        "SELECT pm.User_ID, ?, 'Task', ? FROM project_memberships pm WHERE pm.Project_ID=? AND pm.User_ID!=?"
                    )) {
                        notifPs.setString(1, "New comment on task: " + taskTitle);
                        notifPs.setInt(2, taskId);
                        notifPs.setInt(3, projectId);
                        notifPs.setInt(4, userId);
                        notifPs.executeUpdate();
                    }
                    response.sendRedirect(redirect);

                // ── EDIT ─────────────────────────────────────────────────────────
                } else if ("edit".equals(action)) {
                    if (cidStr == null || commentText == null || commentText.trim().isEmpty()) {
                        response.sendRedirect(redirect);
                        return;
                    }
                    int commentId = Integer.parseInt(cidStr);

                    // Only the comment owner may edit
                    Integer ownerId = null;
                    try (PreparedStatement ps = con.prepareStatement(
                        "SELECT User_ID FROM comments WHERE Comment_ID=? AND Task_ID=?"
                    )) {
                        ps.setInt(1, commentId);
                        ps.setInt(2, taskId);
                        try (ResultSet rs = ps.executeQuery()) {
                            if (rs.next()) ownerId = rs.getInt("User_ID");
                        }
                    }
                    if (ownerId == null || ownerId != userId) {
                        response.getWriter().println("Access denied: you can only edit your own comments.");
                        return;
                    }
                    try (PreparedStatement ps = con.prepareStatement(
                        "UPDATE comments SET Comment_Text=? WHERE Comment_ID=?"
                    )) {
                        ps.setString(1, commentText.trim());
                        ps.setInt(2, commentId);
                        ps.executeUpdate();
                    }
                    try (PreparedStatement logPs = con.prepareStatement(
                        "INSERT INTO activity_log (Project_ID, User_ID, Action_Type, Entity_Type, Entity_ID) VALUES (?, ?, ?, ?, ?)"
                    )) {
                        logPs.setInt(1, projectId);
                        logPs.setInt(2, userId);
                        logPs.setString(3, "EDIT_COMMENT");
                        logPs.setString(4, "Task");
                        logPs.setInt(5, taskId);
                        logPs.executeUpdate();
                    }
                    response.sendRedirect(redirect);

                // ── DELETE ────────────────────────────────────────────────────────
                } else if ("delete".equals(action)) {
                    if (cidStr == null) {
                        response.sendRedirect(redirect);
                        return;
                    }
                    int commentId = Integer.parseInt(cidStr);

                    // Owner may delete; ADMIN may also delete any comment
                    Integer ownerId = null;
                    try (PreparedStatement ps = con.prepareStatement(
                        "SELECT User_ID FROM comments WHERE Comment_ID=? AND Task_ID=?"
                    )) {
                        ps.setInt(1, commentId);
                        ps.setInt(2, taskId);
                        try (ResultSet rs = ps.executeQuery()) {
                            if (rs.next()) ownerId = rs.getInt("User_ID");
                        }
                    }
                    if (ownerId == null) {
                        response.sendRedirect(redirect);
                        return;
                    }
                    boolean isAdmin = "ADMIN".equals(role);
                    if (!isAdmin && ownerId != userId) {
                        response.getWriter().println("Access denied: you can only delete your own comments.");
                        return;
                    }
                    try (PreparedStatement ps = con.prepareStatement(
                        "DELETE FROM comments WHERE Comment_ID=?"
                    )) {
                        ps.setInt(1, commentId);
                        ps.executeUpdate();
                    }
                    try (PreparedStatement logPs = con.prepareStatement(
                        "INSERT INTO activity_log (Project_ID, User_ID, Action_Type, Entity_Type, Entity_ID) VALUES (?, ?, ?, ?, ?)"
                    )) {
                        logPs.setInt(1, projectId);
                        logPs.setInt(2, userId);
                        logPs.setString(3, "DELETE_COMMENT");
                        logPs.setString(4, "Task");
                        logPs.setInt(5, taskId);
                        logPs.executeUpdate();
                    }
                    response.sendRedirect(redirect);

                } else {
                    response.getWriter().println("Unknown action.");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Comment error: " + e.getMessage());
        }
    }
}