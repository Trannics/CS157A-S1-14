import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class SignUpServlet extends HttpServlet {

    private static final String DB_URL  = "jdbc:mysql://localhost:3306/team14";
    private static final String DB_USER = "taskme_app";
    private static final String DB_PASS = "taskme123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String first = request.getParameter("firstname");
        String last  = request.getParameter("lastname");
        String email = request.getParameter("email");
        String password = request.getParameter("password"); // demo

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO users (First_Name, Last_Name, Email, Password_Hash) " +
                    "VALUES (?, ?, ?, ?)"
                );

                ps.setString(1, first);
                ps.setString(2, last);
                ps.setString(3, email);
                ps.setString(4, password);

                ps.executeUpdate();
                ps.close();

                response.sendRedirect("Log-In-Page.html");
            }

        } catch (SQLIntegrityConstraintViolationException dup) {
            response.getWriter().println("That email is already registered.");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Signup error: " + e.getMessage());
        }
    }
}