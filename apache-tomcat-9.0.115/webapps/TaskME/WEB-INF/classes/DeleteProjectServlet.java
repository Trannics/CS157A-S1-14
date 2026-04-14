import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class DeleteProjectServlet extends HttpServlet {

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

        String pidStr = request.getParameter("projectId");
        if (pidStr == null) {
            response.getWriter().println("Missing projectId");
            return;
        }

        int projectId;
        try {
            projectId = Integer.parseInt(pidStr);
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid projectId");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                // Only ADMIN can delete project
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

                if (!"ADMIN".equals(role)) {
                    response.getWriter().println("Access denied: only ADMIN can delete a project.");
                    return;
                }

                // Delete project (FK cascade removes memberships, tasks, comments, etc.)
                try (PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM projects WHERE Project_ID=?"
                )) {
                    ps.setInt(1, projectId);
                    ps.executeUpdate();
                }

                response.sendRedirect("dashboard");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("DeleteProject error: " + e.getMessage());
        }
    }
}