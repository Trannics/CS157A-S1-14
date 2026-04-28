import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class CreateLabelServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int projectId = Integer.parseInt(request.getParameter("project_id"));
        String labelName = request.getParameter("label_name");
        String color = request.getParameter("color");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/team14",
                "taskme_app",
                "taskme123"
            );

            String sql = "INSERT INTO labels (project_id, label_name, color) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, projectId);
            stmt.setString(2, labelName);
            stmt.setString(3, color);

            stmt.executeUpdate();

            stmt.close();
            conn.close();

            response.sendRedirect("project?id=" + projectId);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error creating label: " + e.getMessage());
        }
    }
}