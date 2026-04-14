import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class EditProjectServlet extends HttpServlet {

    private static final String DB_URL  = "jdbc:mysql://localhost:3306/team14";
    private static final String DB_USER = "taskme_app";
    private static final String DB_PASS = "taskme123";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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

                // Only ADMIN can edit project
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
                    response.getWriter().println("Access denied: only ADMIN can edit a project.");
                    return;
                }

                // Fetch project details
                String projectName = null, description = null;
                Timestamp dueDate = null;

                try (PreparedStatement ps = con.prepareStatement(
                    "SELECT Project_Name, Description, Due_Date FROM projects WHERE Project_ID=?"
                )) {
                    ps.setInt(1, projectId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            projectName = rs.getString("Project_Name");
                            description = rs.getString("Description");
                            dueDate     = rs.getTimestamp("Due_Date");
                        }
                    }
                }

                if (projectName == null) {
                    response.getWriter().println("Project not found.");
                    return;
                }

                request.setAttribute("projectId",   projectId);
                request.setAttribute("projectName", projectName);
                request.setAttribute("description", description);
                request.setAttribute("dueDate",     dueDate);

                request.getRequestDispatcher("EditProject.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("EditProject page error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Log-In-Page.html");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        String pidStr       = request.getParameter("projectId");
        String name         = request.getParameter("projectName");
        String description  = request.getParameter("description");
        String dueLocal     = request.getParameter("dueDate");

        if (pidStr == null || name == null || name.trim().isEmpty()) {
            response.getWriter().println("Missing required fields.");
            return;
        }

        int projectId;
        try {
            projectId = Integer.parseInt(pidStr);
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid projectId");
            return;
        }

        Timestamp dueTs = null;
        if (dueLocal != null && !dueLocal.trim().isEmpty()) {
            String s = dueLocal.replace('T', ' ');
            if (s.length() == 16) s = s + ":00";
            try { dueTs = Timestamp.valueOf(s); } catch (IllegalArgumentException ignored) {}
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                // Only ADMIN can edit project
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
                    response.getWriter().println("Access denied: only ADMIN can edit a project.");
                    return;
                }

                // Update project
                try (PreparedStatement ps = con.prepareStatement(
                    "UPDATE projects SET Project_Name=?, Description=?, Due_Date=? WHERE Project_ID=?"
                )) {
                    ps.setString(1, name.trim());
                    if (description == null || description.trim().isEmpty()) ps.setNull(2, Types.LONGVARCHAR);
                    else ps.setString(2, description.trim());
                    if (dueTs == null) ps.setNull(3, Types.TIMESTAMP);
                    else               ps.setTimestamp(3, dueTs);
                    ps.setInt(4, projectId);
                    ps.executeUpdate();
                }

                response.sendRedirect("project?id=" + projectId);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("EditProject submit error: " + e.getMessage());
        }
    }
}