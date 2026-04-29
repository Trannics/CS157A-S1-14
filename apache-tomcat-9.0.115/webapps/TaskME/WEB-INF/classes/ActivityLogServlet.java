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
                        if (rs.next()) role = rs.getString("Role");
                    }
                }

                if (!"ADMIN".equals(role)) {
                    response.getWriter().println("Access denied: only admins can view activity log.");
                    return;
                }

                try (PreparedStatement ps = con.prepareStatement(
                    "SELECT al.Log_ID, u.First_Name, u.Last_Name, " +
                    "       al.Action_Type, al.Entity_Type, al.Entity_ID, al.Occurred_At, " +
                    "       t.Task_Title, " +
                    "       eu.First_Name AS EFirst, eu.Last_Name AS ELast, " +
                    "       ep.Project_Name " +
                    "FROM activity_log al " +
                    "JOIN users u ON al.User_ID = u.User_ID " +
                    "LEFT JOIN tasks t   ON al.Entity_Type = 'Task'    AND t.Task_ID    = al.Entity_ID " +
                    "LEFT JOIN users eu  ON al.Entity_Type = 'User'    AND eu.User_ID   = al.Entity_ID " +
                    "LEFT JOIN projects ep ON al.Entity_Type = 'Project' AND ep.Project_ID = al.Entity_ID " +
                    "WHERE al.Project_ID = ? " +
                    "ORDER BY al.Occurred_At DESC"
                )) {
                    ps.setInt(1, projectId);

                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            String action     = rs.getString("Action_Type");
                            String entityType = rs.getString("Entity_Type");
                            int    entityId   = rs.getInt("Entity_ID");
                            String taskTitle  = rs.getString("Task_Title");
                            String eFirst     = rs.getString("EFirst");
                            String eLast      = rs.getString("ELast");
                            String projName   = rs.getString("Project_Name");

                            String description = buildDescription(
                                action, entityType, entityId, taskTitle,
                                eFirst, eLast, projName
                            );

                            logs.add(new Object[] {
                                rs.getInt("Log_ID"),
                                rs.getString("First_Name") + " " + rs.getString("Last_Name"),
                                description,
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

    private String buildDescription(String action, String entityType, int entityId,
                                    String taskTitle, String eFirst, String eLast,
                                    String projName) {
        String entityName;
        if ("Task".equals(entityType)) {
            entityName = (taskTitle != null) ? taskTitle : "Task #" + entityId;
        } else if ("User".equals(entityType)) {
            entityName = (eFirst != null) ? eFirst + " " + eLast : "User #" + entityId;
        } else if ("Project".equals(entityType)) {
            entityName = (projName != null) ? projName : "Project #" + entityId;
        } else {
            entityName = entityType + " #" + entityId;
        }

        switch (action) {
            case "CREATE":         return "Created " + entityType.toLowerCase() + ": " + entityName;
            case "UPDATE":         return "Updated " + entityType.toLowerCase() + ": " + entityName;
            case "DELETE":         return "Deleted " + entityType.toLowerCase() + ": " + entityName;
            case "ADD_MEMBER":     return "Added member: " + entityName;
            case "REMOVE_MEMBER":  return "Removed member: " + entityName;
            case "COMMENT":        return "Commented on task: " + entityName;
            case "EDIT_COMMENT":   return "Edited comment on task: " + entityName;
            case "DELETE_COMMENT": return "Deleted comment on task: " + entityName;
            default:               return action + " — " + entityName;
        }
    }
}
