import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class LoginServlet extends HttpServlet {

    private static final String DB_URL  = "jdbc:mysql://localhost:3306/team14";
    private static final String DB_USER = "taskme_app";
    private static final String DB_PASS = "taskme123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password"); // demo (stored in Password_Hash column)

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                PreparedStatement ps = con.prepareStatement(
                    "SELECT User_ID, First_Name, Last_Name " +
                    "FROM users " +
                    "WHERE Email = ? AND Password_Hash = ?"
                );
                ps.setString(1, email);
                ps.setString(2, password);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    int userId = rs.getInt("User_ID");

                    HttpSession session = request.getSession(true);
                    session.setAttribute("userId", userId);
                    session.setAttribute("firstName", rs.getString("First_Name"));
                    session.setAttribute("lastName", rs.getString("Last_Name"));

                    response.sendRedirect("dashboard");
                } else {
                    response.getWriter().println("Invalid email or password.");
                }

                rs.close();
                ps.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Login error: " + e.getMessage());
        }
    }
}