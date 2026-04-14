<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Timestamp, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Edit Project - TaskME</title>
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
    input, textarea {
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
        Integer projectId  = (Integer)   request.getAttribute("projectId");
        String projectName = (String)    request.getAttribute("projectName");
        String description = (String)    request.getAttribute("description");
        Timestamp dueDate  = (Timestamp) request.getAttribute("dueDate");

        if (description == null) description = "";

        String dueDateValue = "";
        if (dueDate != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            dueDateValue = sdf.format(dueDate);
        }
      %>

      <div class="title">Edit Project</div>
      <div class="sub">Update the details for <strong><%= projectName %></strong>.</div>

      <form method="post" action="edit-project">
        <input type="hidden" name="projectId" value="<%= projectId %>" />

        <div>
          <label>Project Name</label>
          <input name="projectName" value="<%= projectName %>" required />
        </div>

        <div>
          <label>Description</label>
          <textarea name="description"><%= description %></textarea>
        </div>

        <div>
          <label>Due Date</label>
          <input type="datetime-local" name="dueDate" value="<%= dueDateValue %>" />
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
