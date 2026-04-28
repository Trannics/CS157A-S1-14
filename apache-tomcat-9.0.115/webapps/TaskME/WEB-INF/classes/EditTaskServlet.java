import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

@MultipartConfig
public class EditTaskServlet extends HttpServlet {

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

        String tidStr = request.getParameter("taskId");
        String pidStr = request.getParameter("projectId");
        if (tidStr == null || pidStr == null) {
            response.getWriter().println("Missing taskId or projectId");
            return;
        }

        int taskId, projectId;
        try {
            taskId    = Integer.parseInt(tidStr);
            projectId = Integer.parseInt(pidStr);
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid taskId or projectId");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                // Membership + role check
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
                    response.getWriter().println("Access denied: not a member of this project.");
                    return;
                }
                if ("COMMENT_ONLY".equals(role)) {
                    response.getWriter().println("Access denied: COMMENT_ONLY users cannot edit tasks.");
                    return;
                }

                // Fetch task
                String taskTitle = null, taskDesc = null, status = null;
                Timestamp dueDate = null;
                int priority = 2;

                try (PreparedStatement ps = con.prepareStatement(
                    "SELECT Task_Title, Task_Description, Due_Date, Status, Priority " +
                    "FROM tasks WHERE Task_ID=? AND Project_ID=?"
                )) {
                    ps.setInt(1, taskId);
                    ps.setInt(2, projectId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            taskTitle = rs.getString("Task_Title");
                            taskDesc  = rs.getString("Task_Description");
                            dueDate   = rs.getTimestamp("Due_Date");
                            status    = rs.getString("Status");
                            priority  = rs.getInt("Priority");
                        }
                    }
                }

                if (taskTitle == null) {
                    response.getWriter().println("Task not found.");
                    return;
                }

                // Project name for display
                String projectName = null;
                try (PreparedStatement ps = con.prepareStatement(
                    "SELECT Project_Name FROM projects WHERE Project_ID=?"
                )) {
                    ps.setInt(1, projectId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) projectName = rs.getString("Project_Name");
                    }
                }

                request.setAttribute("taskId",      taskId);
                request.setAttribute("projectId",   projectId);
                request.setAttribute("projectName", projectName);
                request.setAttribute("role",        role);
                request.setAttribute("taskTitle",   taskTitle);
                request.setAttribute("taskDesc",    taskDesc);
                request.setAttribute("dueDate",     dueDate);
                request.setAttribute("status",      status);
                request.setAttribute("priority",    priority);

                request.getRequestDispatcher("EditTask.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("EditTask page error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Log-In-Page.html");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        String tidStr      = request.getParameter("taskId");
        String pidStr      = request.getParameter("projectId");
        String title       = request.getParameter("title");
        String description = request.getParameter("description");
        String dueLocal    = request.getParameter("dueDate");
        String priorityStr = request.getParameter("priority");
        String status      = request.getParameter("status");
        String labelIdStr  = request.getParameter("label_id");

        if (tidStr == null || pidStr == null || title == null || title.trim().isEmpty()) {
            response.getWriter().println("Missing required fields.");
            return;
        }

        int taskId, projectId;
        try {
            taskId    = Integer.parseInt(tidStr);
            projectId = Integer.parseInt(pidStr);
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid taskId or projectId");
            return;
        }

        int priority = 2;
        try {
            priority = Integer.parseInt(priorityStr);
            if (priority < 1) priority = 1;
            if (priority > 3) priority = 3;
        } catch (Exception ignored) {}

        if (status == null || status.trim().isEmpty()) status = "TODO";

        Timestamp dueTs = null;
        if (dueLocal != null && !dueLocal.trim().isEmpty()) {
            String s = dueLocal.replace('T', ' ');
            if (s.length() == 16) s = s + ":00";
            try { dueTs = Timestamp.valueOf(s); } catch (IllegalArgumentException ignored) {}
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                // Membership + role check
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

                if (role == null || "COMMENT_ONLY".equals(role)) {
                    response.getWriter().println("Access denied: cannot edit task.");
                    return;
                }

                // Update task
                try (PreparedStatement ps = con.prepareStatement(
                    "UPDATE tasks SET Task_Title=?, Task_Description=?, Due_Date=?, Status=?, Priority=? " +
                    "WHERE Task_ID=? AND Project_ID=?"
                )) {
                    ps.setString(1, title.trim());
                    ps.setString(2, description == null ? null : description.trim());
                    if (dueTs == null) ps.setNull(3, Types.TIMESTAMP);
                    else               ps.setTimestamp(3, dueTs);
                    ps.setString(4, status);
                    ps.setInt(5, priority);
                    ps.setInt(6, taskId);
                    ps.setInt(7, projectId);
                    ps.executeUpdate();
                }

                // ===== ATTACHMENT UPLOAD =====
                Part filePart = request.getPart("attachment");

                if (filePart != null && filePart.getSize() > 0) {

                    String fileName = filePart.getSubmittedFileName();

                    String uploadPath = getServletContext().getRealPath("") + "uploads/";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdir();

                    String filePath = uploadPath + fileName;
                    filePart.write(filePath);

                    try (PreparedStatement psAttach = con.prepareStatement(
                        "INSERT INTO attachments (task_id, file_name, file_path) VALUES (?, ?, ?)"
                    )) {
                        psAttach.setInt(1, taskId);
                        psAttach.setString(2, fileName);
                        psAttach.setString(3, "uploads/" + fileName);
                        psAttach.executeUpdate();
                    }
                }
                
                try (PreparedStatement deleteOld = con.prepareStatement(
                    "DELETE FROM task_labels WHERE task_id = ?"
                )) {
                    deleteOld.setInt(1, taskId);
                    deleteOld.executeUpdate();
                }
                
                if (labelIdStr != null && !labelIdStr.isEmpty()) {
                    try (PreparedStatement addLabel = con.prepareStatement(
                        "INSERT INTO task_labels (task_id, label_id) VALUES (?, ?)"
                    )) {
                        addLabel.setInt(1, taskId);
                        addLabel.setInt(2, Integer.parseInt(labelIdStr));
                        addLabel.executeUpdate();
                    }
                }

                response.sendRedirect("project?id=" + projectId);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("EditTask submit error: " + e.getMessage());
        }
    }
}