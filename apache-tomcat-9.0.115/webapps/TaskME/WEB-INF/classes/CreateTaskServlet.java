import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class CreateTaskServlet extends HttpServlet {

    private static final String DB_URL  = "jdbc:mysql://localhost:3306/team14";
    private static final String DB_USER = "taskme_app";
    private static final String DB_PASS = "taskme123";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        // Must be logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Log-In-Page.html");
            return;
        }

        String pid = request.getParameter("projectId");
        if (pid == null) {
            response.getWriter().println("Missing projectId");
            return;
        }

        int projectId;
        try {
            projectId = Integer.parseInt(pid);
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid projectId");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        // Check membership + role
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

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
                    response.getWriter().println("Access denied: not a member of this project.");
                    return;
                }

                if ("COMMENT_ONLY".equals(role)) {
                    response.getWriter().println("Access denied: COMMENT_ONLY users cannot create tasks.");
                    return;
                }

                // Optional: show project name on the form
                String projectName = null;
                try (PreparedStatement ps = con.prepareStatement(
                    "SELECT Project_Name FROM projects WHERE Project_ID=?"
                )) {
                    ps.setInt(1, projectId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) projectName = rs.getString("Project_Name");
                    }
                }

                request.setAttribute("projectId", projectId);
                request.setAttribute("projectName", projectName);
                request.setAttribute("role", role);

                request.getRequestDispatcher("CreateTask.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("CreateTask page error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        // Must be logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Log-In-Page.html");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        // Read inputs
        String pid = request.getParameter("projectId");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String dueLocal = request.getParameter("dueDate"); // from datetime-local
        String priorityStr = request.getParameter("priority");
        String status = request.getParameter("status");

        if (pid == null || title == null || title.trim().isEmpty()) {
            response.getWriter().println("Missing required fields.");
            return;
        }

        int projectId;
        try {
            projectId = Integer.parseInt(pid);
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid projectId");
            return;
        }

        int priority = 2;
        try {
            priority = Integer.parseInt(priorityStr);
            if (priority < 1) priority = 1;
            if (priority > 3) priority = 3;
        } catch (Exception ignored) {}

        if (status == null || status.trim().isEmpty()) status = "TODO";

        // Convert due date if provided
        Timestamp dueTs = null;
        if (dueLocal != null && !dueLocal.trim().isEmpty()) {
            // dueLocal format: "YYYY-MM-DDTHH:MM"
            String s = dueLocal.replace('T', ' ');
            if (s.length() == 16) s = s + ":00";
            try {
                dueTs = Timestamp.valueOf(s);
            } catch (IllegalArgumentException ignored) {}
        }

        // Check membership + role again (security)
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

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
                    response.getWriter().println("Access denied: cannot create task.");
                    return;
                }

                // Insert task
                try (PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO tasks (Project_ID, Task_Title, Task_Description, Due_Date, Status, Priority, Created_By) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)"
                )) {
                    ps.setInt(1, projectId);
                    ps.setString(2, title.trim());
                    ps.setString(3, (description == null ? null : description.trim()));
                    if (dueTs == null) ps.setNull(4, Types.TIMESTAMP);
                    else ps.setTimestamp(4, dueTs);
                    ps.setString(5, status);
                    ps.setInt(6, priority);
                    ps.setInt(7, userId);

                    ps.executeUpdate();
                }

                // Back to project page
                response.sendRedirect("project?id=" + projectId);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("CreateTask submit error: " + e.getMessage());
        }
    }
}