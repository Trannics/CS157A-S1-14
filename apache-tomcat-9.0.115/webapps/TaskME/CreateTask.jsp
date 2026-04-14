<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Create Task - TaskME</title>
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

    .row {display:grid; grid-template-columns: 1fr 1fr; gap:12px;}
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
        Integer projectId = (Integer) request.getAttribute("projectId");
        String projectName = (String) request.getAttribute("projectName");
        String role = (String) request.getAttribute("role");
      %>

      <div class="title">Create Task</div>
      <div class="sub">
        Project: <strong><%= (projectName == null ? ("#" + projectId) : projectName) %></strong>
        <span class="hint"> (Role: <%= role %>)</span>
      </div>

      <form method="post" action="create-task">
        <input type="hidden" name="projectId" value="<%= projectId %>" />

        <div>
          <label>Task Title</label>
          <input name="title" placeholder="e.g., Add login session handling" required />
        </div>

        <div>
          <label>Description</label>
          <textarea name="description" placeholder="Optional details..."></textarea>
        </div>

        <div class="row3">
          <div>
            <label>Priority</label>
            <select name="priority">
              <option value="3">P3 (High)</option>
              <option value="2" selected>P2 (Medium)</option>
              <option value="1">P1 (Low)</option>
            </select>
          </div>

          <div>
            <label>Status</label>
            <select name="status">
              <option value="TODO" selected>TODO</option>
              <option value="IN_PROGRESS">IN_PROGRESS</option>
              <option value="DONE">DONE</option>
            </select>
          </div>

          <div>
            <label>Due Date</label>
            <input type="datetime-local" name="dueDate" />
          </div>
        </div>

        <div class="actions">
          <button class="btn" type="submit">Create Task</button>
          <a class="btn secondary" href="project?id=<%= projectId %>">Cancel</a>
        </div>
      </form>
    </div>
  </div>

</body>
</html>