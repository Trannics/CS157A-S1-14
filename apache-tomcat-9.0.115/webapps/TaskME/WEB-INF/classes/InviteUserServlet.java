import java.io.*;
import java.net.URLEncoder;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class InviteUserServlet extends HttpServlet {

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

        int inviterId = (int) session.getAttribute("userId");

        String pidStr = request.getParameter("projectId");
        String email  = request.getParameter("email");
        String role   = request.getParameter("role");

        if (pidStr == null || email == null || email.trim().isEmpty()) {
            response.getWriter().println("Missing projectId or email.");
            return;
        }

        int projectId;
        try {
            projectId = Integer.parseInt(pidStr);
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid projectId.");
            return;
        }

        email = email.trim();

        if (role == null || role.trim().isEmpty()) role = "MEMBER";
        // Validate role value
        if (!role.equals("ADMIN") && !role.equals("MEMBER") && !role.equals("COMMENT_ONLY")) {
            role = "MEMBER";
        }

        // Helper to redirect back to the project page with an inline error
        final String encodedEmail = URLEncoder.encode(email, "UTF-8");
        final int pid = projectId;
        final String selectedRole = role;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                // Only ADMIN can invite
                String inviterRole = null;
                try (PreparedStatement ps = con.prepareStatement(
                    "SELECT Role FROM project_memberships WHERE Project_ID=? AND User_ID=?"
                )) {
                    ps.setInt(1, projectId);
                    ps.setInt(2, inviterId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) inviterRole = rs.getString("Role");
                    }
                }

                if (!"ADMIN".equals(inviterRole)) {
                    response.getWriter().println("Access denied: only ADMIN can invite users.");
                    return;
                }

                // Look up the invitee by email
                Integer inviteeId = null;
                try (PreparedStatement ps = con.prepareStatement(
                    "SELECT User_ID FROM users WHERE Email=?"
                )) {
                    ps.setString(1, email);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) inviteeId = rs.getInt("User_ID");
                    }
                }

                if (inviteeId == null) {
                    response.sendRedirect("project?id=" + pid
                        + "&inviteError=not_found"
                        + "&inviteEmail=" + encodedEmail
                        + "&inviteRole=" + selectedRole);
                    return;
                }

                // Check if already a member
                boolean alreadyMember = false;
                try (PreparedStatement ps = con.prepareStatement(
                    "SELECT 1 FROM project_memberships WHERE Project_ID=? AND User_ID=?"
                )) {
                    ps.setInt(1, projectId);
                    ps.setInt(2, inviteeId);
                    try (ResultSet rs = ps.executeQuery()) {
                        alreadyMember = rs.next();
                    }
                }

                if (alreadyMember) {
                    response.sendRedirect("project?id=" + pid
                        + "&inviteError=already_member"
                        + "&inviteEmail=" + encodedEmail
                        + "&inviteRole=" + selectedRole);
                    return;
                }

                // Insert membership
                try (PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO project_memberships (Project_ID, User_ID, Role) VALUES (?, ?, ?)"
                )) {
                    ps.setInt(1, projectId);
                    ps.setInt(2, inviteeId);
                    ps.setString(3, role);
                    ps.executeUpdate();
                }

                response.sendRedirect("project?id=" + projectId);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Invite error: " + e.getMessage());
        }
    }
}