import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class RemoveMemberServlet extends HttpServlet {

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

        int requesterId = (int) session.getAttribute("userId");

        String pidStr    = request.getParameter("projectId");
        String targetStr = request.getParameter("targetUserId");

        if (pidStr == null || targetStr == null) {
            response.getWriter().println("Missing projectId or targetUserId.");
            return;
        }

        int projectId, targetUserId;
        try {
            projectId    = Integer.parseInt(pidStr);
            targetUserId = Integer.parseInt(targetStr);
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid projectId or targetUserId.");
            return;
        }

        // Cannot remove yourself
        if (targetUserId == requesterId) {
            response.getWriter().println("You cannot remove yourself from the project.");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                // Requester must be ADMIN
                String requesterRole = null;
                try (PreparedStatement ps = con.prepareStatement(
                    "SELECT Role FROM project_memberships WHERE Project_ID=? AND User_ID=?"
                )) {
                    ps.setInt(1, projectId);
                    ps.setInt(2, requesterId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) requesterRole = rs.getString("Role");
                    }
                }

                if (!"ADMIN".equals(requesterRole)) {
                    response.getWriter().println("Access denied: only ADMIN can remove members.");
                    return;
                }

                // Remove the target membership
                try (PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM project_memberships WHERE Project_ID=? AND User_ID=?"
                )) {
                    ps.setInt(1, projectId);
                    ps.setInt(2, targetUserId);
                    ps.executeUpdate();
                }

                response.sendRedirect("project?id=" + projectId);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("RemoveMember error: " + e.getMessage());
        }
    }
}