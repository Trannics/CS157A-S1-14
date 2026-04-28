import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AssignLabelServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int projectId = Integer.parseInt(request.getParameter("project_id"));
        int taskId = Integer.parseInt(request.getParameter("task_id"));
        int labelId = Integer.parseInt(request.getParameter("label_id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/team14",
                "taskme_app",
                "YOUR_PASSWORD"
            );

            String sql = "INSERT IGNORE INTO task_labels (task_id, label_id) VALUES (?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, taskId);
            stmt.setInt(2, labelId);

            stmt.executeUpdate();

            stmt.close();
            conn.close();

            response.sendRedirect("Project.jsp?project_id=" + projectId);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error assigning label: " + e.getMessage());
        }
    }
}