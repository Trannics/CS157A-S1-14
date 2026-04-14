import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class CreateProjectServlet extends HttpServlet {

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

        // If redirected after create, show projectId in invite section
        String pid = request.getParameter("projectId");
        if (pid != null) request.setAttribute("projectId", pid);

        request.getRequestDispatcher("CreateProject.jsp").forward(request, response);
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

        String name = request.getParameter("projectName");
        String desc = request.getParameter("description");
        String dueLocal = request.getParameter("dueDate"); // datetime-local

        if (name == null || name.trim().isEmpty()) {
            response.getWriter().println("Project name is required.");
            return;
        }

        Timestamp dueTs = null;
        if (dueLocal != null && !dueLocal.trim().isEmpty()) {
            String s = dueLocal.replace('T', ' ');
            if (s.length() == 16) s = s + ":00";
            try { dueTs = Timestamp.valueOf(s); } catch (Exception ignored) {}
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                // Create project
                int newProjectId;
                try (PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO projects (Project_Name, Description, Due_Date, Creator_User_ID) VALUES (?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS
                )) {
                    ps.setString(1, name.trim());
                    if (desc == null || desc.trim().isEmpty()) ps.setNull(2, Types.LONGVARCHAR);
                    else ps.setString(2, desc.trim());

                    if (dueTs == null) ps.setNull(3, Types.TIMESTAMP);
                    else ps.setTimestamp(3, dueTs);

                    ps.setInt(4, userId);
                    ps.executeUpdate();

                    try (ResultSet keys = ps.getGeneratedKeys()) {
                        if (!keys.next()) {
                            response.getWriter().println("Failed to create project.");
                            return;
                        }
                        newProjectId = keys.getInt(1);
                    }
                }

                // Ensure creator is ADMIN in memberships (safe even if trigger exists)
                try (PreparedStatement ps = con.prepareStatement(
                    "INSERT IGNORE INTO project_memberships (Project_ID, User_ID, Role) VALUES (?, ?, 'ADMIN')"
                )) {
                    ps.setInt(1, newProjectId);
                    ps.setInt(2, userId);
                    ps.executeUpdate();
                }

                // Go back to create-project page with invite section active
                response.sendRedirect("create-project?projectId=" + newProjectId);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("CreateProject error: " + e.getMessage());
        }
    }
}