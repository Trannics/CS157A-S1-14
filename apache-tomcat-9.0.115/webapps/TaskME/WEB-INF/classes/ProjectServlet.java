import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

public class ProjectServlet extends HttpServlet {

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

        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.getWriter().println("Missing project id.");
            return;
        }

        int projectId;
        try {
            projectId = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid project id.");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                // Membership check + role
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
                    response.getWriter().println("Access denied: you are not a member of this project.");
                    return;
                }

                // Project info
                String projectName = null;
                String description = null;
                Timestamp dueDate = null;
                Timestamp createdAt = null;

                try (PreparedStatement ps = con.prepareStatement(
                    "SELECT Project_Name, Description, Due_Date, Created_At FROM projects WHERE Project_ID=?"
                )) {
                    ps.setInt(1, projectId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            projectName = rs.getString("Project_Name");
                            description = rs.getString("Description");
                            dueDate = rs.getTimestamp("Due_Date");
                            createdAt = rs.getTimestamp("Created_At");
                        }
                    }
                }

                if (projectName == null) {
                    response.getWriter().println("Project not found.");
                    return;
                }

                // Tasks for this project (priority sorting)
                List<Object[]> tasks = new ArrayList<>();
                try (PreparedStatement ps = con.prepareStatement(
                    "SELECT Task_ID, Task_Title, Task_Description, Due_Date, Status, Priority " +
                    "FROM tasks " +
                    "WHERE Project_ID=? " +
                    "ORDER BY Priority DESC, Due_Date ASC, Task_ID ASC"
                )) {
                    ps.setInt(1, projectId);
                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            tasks.add(new Object[] {
                                rs.getInt("Task_ID"),
                                rs.getString("Task_Title"),
                                rs.getString("Task_Description"),
                                rs.getTimestamp("Due_Date"),
                                rs.getString("Status"),
                                rs.getInt("Priority")
                            });
                        }
                    }
                }

                // Pass data to JSP
                request.setAttribute("projectId", projectId);
                request.setAttribute("projectName", projectName);
                request.setAttribute("description", description);
                request.setAttribute("dueDate", dueDate);
                request.setAttribute("createdAt", createdAt);
                request.setAttribute("role", role);
                request.setAttribute("tasks", tasks);

                request.getRequestDispatcher("Project.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Project page error: " + e.getMessage());
        }
    }
}