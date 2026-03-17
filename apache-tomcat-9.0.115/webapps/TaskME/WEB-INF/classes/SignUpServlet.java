import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class SignUpServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String first = request.getParameter("firstname");
        String last = request.getParameter("lastname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/Task-ME",
                "root",
                "HeyTea9812!"
            );

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users (first_name, last_name, email, password) VALUES (?, ?, ?, ?)"
            );

            ps.setString(1, first);
            ps.setString(2, last);
            ps.setString(3, email);
            ps.setString(4, password);

            ps.executeUpdate();

            response.sendRedirect("Log-In-Page.html");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
