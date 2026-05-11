import java.io.*;
import java.net.URLEncoder;
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

        String email    = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                // Fetch by email only — password comparison is done in Java
                int    userId    = -1;
                String storedHash = null;
                String firstName = null, lastName = null;

                try (PreparedStatement ps = con.prepareStatement(
                    "SELECT User_ID, Password_Hash, First_Name, Last_Name FROM users WHERE Email=?"
                )) {
                    ps.setString(1, email);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            userId     = rs.getInt("User_ID");
                            storedHash = rs.getString("Password_Hash");
                            firstName  = rs.getString("First_Name");
                            lastName   = rs.getString("Last_Name");
                        }
                    }
                }

                if (storedHash == null || !PasswordUtil.verify(password, storedHash)) {
                    response.sendRedirect("Log-In-Page.html?error=1&email="
                        + URLEncoder.encode(email == null ? "" : email, "UTF-8"));
                    return;
                }

                // Auto-migrate legacy plaintext passwords on first successful login
                if (!storedHash.contains(":")) {
                    try (PreparedStatement ps = con.prepareStatement(
                        "UPDATE users SET Password_Hash=? WHERE User_ID=?"
                    )) {
                        ps.setString(1, PasswordUtil.hash(password));
                        ps.setInt(2, userId);
                        ps.executeUpdate();
                    }
                }

                HttpSession session = request.getSession(true);
                session.setAttribute("userId",    userId);
                session.setAttribute("firstName", firstName);
                session.setAttribute("lastName",  lastName);

                response.sendRedirect("dashboard");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Login error: " + e.getMessage());
        }
    }
}
