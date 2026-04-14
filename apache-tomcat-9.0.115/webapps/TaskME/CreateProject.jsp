<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Create Project - TaskME</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    * {box-sizing:border-box; margin:0; padding:0;}
    body {font-family:'Inter', sans-serif; background:#f9fafb; color:#111;}
    nav {display:flex; justify-content:space-between; align-items:center; padding:16px 40px; background:#fff; border-bottom:1px solid #e5e7eb;}
    .logo {font-size:1.25rem; font-weight:700;}
    .logo span {color:#16a34a;}
    .toplinks a {text-decoration:none; color:#111; margin-left:14px; font-weight:500;}

    .container {max-width: 900px; margin: 40px auto; padding: 0 24px;}
    .card {background:#fff; border:1px solid #e5e7eb; border-radius:12px; padding:24px; margin-bottom:14px;}
    .title {font-size:1.5rem; font-weight:800; margin-bottom:8px;}
    .sub {color:#6b7280; line-height:1.6; margin-bottom:16px;}

    form {display:grid; gap:12px;}
    label {font-weight:800; font-size:0.92rem; margin-bottom:6px; display:block;}
    input, textarea, select {
      width:100%; padding:10px 12px; border:1px solid #e5e7eb; border-radius:10px;
      font-family:inherit; font-size:0.95rem; background:#fff; outline:none;
    }
    textarea {min-height:110px; resize:vertical;}
    .row {display:grid; grid-template-columns: 1fr 1fr; gap:12px;}

    .actions {display:flex; gap:10px; margin-top:6px;}
    .btn {
      padding:10px 12px; border-radius:10px; border:1px solid #16a34a; background:#16a34a;
      color:#fff; font-weight:800; text-decoration:none; text-align:center; cursor:pointer;
    }
    .btn.secondary {background:#fff; color:#111; border:1px solid #e5e7eb; font-weight:800;}
    .pill {display:inline-block; padding:6px 10px; border-radius:999px; border:1px solid #e5e7eb; background:#fff; font-weight:800;}
    .hint {color:#6b7280; font-size:0.92rem;}
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
      <div class="title">Create Project</div>
      <div class="sub">Create a new project, then invite users underneath.</div>

      <form method="post" action="create-project">
        <div>
          <label>Project Name</label>
          <input name="projectName" placeholder="e.g., TaskMe Sprint 1" required />
        </div>

        <div>
          <label>Description</label>
          <textarea name="description" placeholder="Optional details..."></textarea>
        </div>

        <div class="row">
          <div>
            <label>Due Date</label>
            <input type="datetime-local" name="dueDate" />
          </div>
          <div>
            <label class="hint">Tip</label>
            <div class="hint">After creating, you’ll get a project id and can invite members below.</div>
          </div>
        </div>

        <div class="actions">
          <button class="btn" type="submit">Create Project</button>
          <a class="btn secondary" href="dashboard">Cancel</a>
        </div>
      </form>
    </div>

    <%
      String pid = (String) request.getAttribute("projectId");
      if (pid == null) pid = request.getParameter("projectId");
    %>

    <div class="card">
      <div class="title" style="font-size:1.2rem;">Invite Users</div>

      <%
        if (pid == null || pid.trim().isEmpty()) {
      %>
        <div class="hint">Create a project first. After creation, this section will activate.</div>
      <%
        } else {
      %>
        <div class="sub" style="margin-bottom:10px;">
          Project ID: <span class="pill"><%= pid %></span>
        </div>

        <form method="post" action="invite-user">
          <input type="hidden" name="projectId" value="<%= pid %>" />

          <div class="row">
            <div>
              <label>User Email</label>
              <input name="email" placeholder="e.g., teammate@sjsu.edu" required />
            </div>
            <div>
              <label>Role</label>
              <select name="role">
                <option value="MEMBER" selected>MEMBER</option>
                <option value="COMMENT_ONLY">COMMENT_ONLY</option>
                <option value="ADMIN">ADMIN</option>
              </select>
            </div>
          </div>

          <div class="actions">
            <button class="btn" type="submit">Send Invite</button>
            <a class="btn secondary" href="project?id=<%= pid %>">Open Project</a>
          </div>
        </form>
      <%
        }
      %>
    </div>
  </div>
</body>
</html>