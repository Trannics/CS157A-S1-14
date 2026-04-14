import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

public class DashboardServlet extends HttpServlet {

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

        // Each row: [0]=Project_ID, [1]=Project_Name, [2]=Due_Date, [3]=Role
        List<Object[]> projects = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                PreparedStatement ps = con.prepareStatement(
                    "SELECT p.Project_ID, p.Project_Name, p.Due_Date, pm.Role " +
                    "FROM projects p " +
                    "JOIN project_memberships pm ON pm.Project_ID = p.Project_ID " +
                    "WHERE pm.User_ID = ? " +
                    "ORDER BY p.Due_Date ASC"
                );
                ps.setInt(1, userId);

                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
                    projects.add(new Object[] {
                        rs.getInt("Project_ID"),
                        rs.getString("Project_Name"),
                        rs.getTimestamp("Due_Date"),
                        rs.getString("Role")
                    });
                }

                rs.close();
                ps.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Dashboard error: " + e.getMessage());
            return;
        }

        request.setAttribute("projects", projects);
        request.getRequestDispatcher("Dashboard.jsp").forward(request, response);
    }
}