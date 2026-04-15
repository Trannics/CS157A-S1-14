import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

public class ActivityLogServlet extends HttpServlet {

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
        List<Object[]> logs = new ArrayList<>();

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
                        if (rs.next()) {
                            role = rs.getString("Role");
                        }
                    }
                }

                if (!"ADMIN".equals(role)) {
                    response.getWriter().println("Access denied: only admins can view activity log.");
                    return;
                }

                try (PreparedStatement ps = con.prepareStatement(
                    "SELECT al.Log_ID, u.First_Name, u.Last_Name, al.Action_Type, al.Entity_Type, al.Entity_ID, al.Occurred_At " +
                    "FROM activity_log al " +
                    "JOIN users u ON al.User_ID = u.User_ID " +
                    "WHERE al.Project_ID = ? " +
                    "ORDER BY al.Occurred_At DESC"
                )) {
                    ps.setInt(1, projectId);

                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            logs.add(new Object[] {
                                rs.getInt("Log_ID"),
                                rs.getString("First_Name") + " " + rs.getString("Last_Name"),
                                rs.getString("Action_Type"),
                                rs.getString("Entity_Type"),
                                rs.getInt("Entity_ID"),
                                rs.getTimestamp("Occurred_At")
                            });
                        }
                    }
                }
            }

            request.setAttribute("projectId", projectId);
            request.setAttribute("logs", logs);
            request.getRequestDispatcher("ActivityLog.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Activity log error: " + e.getMessage());
        }
    }
}