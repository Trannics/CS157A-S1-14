<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Timestamp, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Edit Task - TaskME</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    * {box-sizing:border-box; margin:0; padding:0;}
    body {font-family:'Inter', sans-serif; background:#f9fafb; color:#111;}

    nav {
      display:flex; justify-content:space-between; align-items:center;
      padding:16px 40px; background:#fff; border-bottom:1px solid #e5e7eb;
    }
    .logo {font-size:1.25rem; font-weight:700;}
    .logo span {color:#16a34a;}
    .toplinks a {text-decoration:none; color:#111; margin-left:14px; font-weight:500;}

    .container {max-width: 900px; margin: 40px auto; padding: 0 24px;}
    .card {background:#fff; border:1px solid #e5e7eb; border-radius:12px; padding:24px;}
    .title {font-size:1.5rem; font-weight:800; margin-bottom:8px;}
    .sub {color:#6b7280; line-height:1.6; margin-bottom:16px;}

    form {display:grid; gap:12px;}
    label {font-weight:700; font-size:0.92rem; margin-bottom:6px; display:block;}
    input, textarea, select {
      width:100%;
      padding:10px 12px;
      border:1px solid #e5e7eb;
      border-radius:10px;
      font-family:inherit;
      font-size:0.95rem;
      background:#fff;
      outline:none;
    }
    textarea {min-height:110px; resize:vertical;}

    .row3 {display:grid; grid-template-columns: 1fr 1fr 1fr; gap:12px;}
    .hint {color:#6b7280; font-size:0.9rem;}

    .actions {display:flex; gap:10px; margin-top:6px;}
    .btn {
      padding:10px 12px;
      border-radius:10px;
      border:1px solid #16a34a;
      background:#16a34a;
      color:#fff;
      font-weight:800;
      text-decoration:none;
      text-align:center;
      cursor:pointer;
    }
    .btn.secondary {
      background:#fff;
      color:#111;
      border:1px solid #e5e7eb;
      font-weight:700;
    }
  </style>
</head>
<body>

  <nav>
    <div class="logo">Task<span>ME</span></div>
    <div class="toplinks">
      <a href="dashboard">Home</a>
      <a href="logout">Logout</a>
    </div>
  </nav>

  <div class="container">
    <div class="card">
      <%
        Integer taskId     = (Integer)   request.getAttribute("taskId");
        Integer projectId  = (Integer)   request.getAttribute("projectId");
        String projectName = (String)    request.getAttribute("projectName");
        String role        = (String)    request.getAttribute("role");
        String taskTitle   = (String)    request.getAttribute("taskTitle");
        String taskDesc    = (String)    request.getAttribute("taskDesc");
        Timestamp dueDate  = (Timestamp) request.getAttribute("dueDate");
        String status      = (String)    request.getAttribute("status");
        Integer priority   = (Integer)   request.getAttribute("priority");

        // Format timestamp for datetime-local input (yyyy-MM-ddTHH:mm)
        String dueDateValue = "";
        if (dueDate != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            dueDateValue = sdf.format(dueDate);
        }

        if (taskDesc == null) taskDesc = "";
        if (status   == null) status   = "TODO";
        if (priority == null) priority = 2;
      %>

      <div class="title">Edit Task</div>
      <div class="sub">
        Project: <strong><%= (projectName == null ? ("#" + projectId) : projectName) %></strong>
        <span class="hint"> (Role: <%= role %>)</span>
      </div>

      <form method="post" action="edit-task" enctype="multipart/form-data">
        <input type="hidden" name="taskId"    value="<%= taskId %>" />
        <input type="hidden" name="projectId" value="<%= projectId %>" />

        <div>
          <label>Task Title</label>
          <input name="title" value="<%= taskTitle %>" required />
        </div>

        <div>
          <label>Description</label>
          <textarea name="description"><%= taskDesc %></textarea>
        </div>

        <div class="row3">
          <div>
            <label>Priority</label>
            <select name="priority">
              <option value="3" <%= priority == 3 ? "selected" : "" %>>P3 (High)</option>
              <option value="2" <%= priority == 2 ? "selected" : "" %>>P2 (Medium)</option>
              <option value="1" <%= priority == 1 ? "selected" : "" %>>P1 (Low)</option>
            </select>
          </div>

          <div>
            <label>Status</label>
            <select name="status">
              <option value="TODO"        <%= "TODO".equals(status)        ? "selected" : "" %>>TODO</option>
              <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(status) ? "selected" : "" %>>IN_PROGRESS</option>
              <option value="DONE"        <%= "DONE".equals(status)        ? "selected" : "" %>>DONE</option>
            </select>
          </div>

          <div>
            <label>Due Date</label>
            <input type="datetime-local" name="dueDate" value="<%= dueDateValue %>" />
          </div>
        </div>
        
        <div>
          <label>Label</label>
          <select name="label_id">
            <option value="">No label</option>
        
            <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                java.sql.Connection conn2 = java.sql.DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/team14",
                    "taskme_app",
                    "taskme123"
                );
        
                java.sql.PreparedStatement ps2 = conn2.prepareStatement(
                    "SELECT label_id, label_name FROM labels WHERE project_id = ?"
                );
                ps2.setInt(1, projectId);
        
                java.sql.ResultSet rs2 = ps2.executeQuery();
        
                while (rs2.next()) {
            %>
                <option value="<%= rs2.getInt("label_id") %>">
                    <%= rs2.getString("label_name") %>
                </option>
            <%
                }
        
                rs2.close();
                ps2.close();
                conn2.close();
            } catch (Exception e) {
                out.println("Label dropdown error: " + e.getMessage());
            }
            %>
        
          </select>
        </div>

        <div>
          <label>Attachment</label>
          <input type="file" name="attachment">
        </div>

        <div class="actions">
          <button class="btn" type="submit">Save Changes</button>
          <a class="btn secondary" href="project?id=<%= projectId %>">Cancel</a>
        </div>
      </form>
    </div>
  </div>

</body>
</html>
