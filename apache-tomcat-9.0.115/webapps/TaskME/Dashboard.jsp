<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>TaskMe Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    * {box-sizing: border-box; margin: 0; padding: 0;}
    body {font-family: 'Inter', sans-serif; background: #f9fafb; color: #111;}

    nav {
      display: flex; justify-content: space-between; align-items: center;
      padding: 16px 40px; background: #fff; border-bottom: 1px solid #e5e7eb;
    }

    .logo {font-size: 1.25rem; font-weight: 700;}
    .logo span {color: #16a34a;}

    .container {
      max-width: 900px;
      margin: 60px auto;
      padding: 0 24px;
    }

    .card {
      background: #fff;
      border: 1px solid #e5e7eb;
      border-radius: 12px;
      padding: 32px;
    }

    h1 {margin-bottom: 12px;}
    p {color: #6b7280; line-height: 1.6; margin-bottom: 10px;}

    .project {
      border: 1px solid #e5e7eb;
      border-radius: 10px;
      padding: 16px;
      margin-top: 14px;
      background: #fff;
    }
    .project-title {font-weight: 600; font-size: 1.05rem; margin-bottom: 6px;}
    .meta {color: #6b7280; font-size: 0.95rem;}
    .link {display:inline-block; margin-top: 10px; text-decoration:none; color:#16a34a; font-weight:600;}
    .toplinks a {text-decoration:none; color:#111; margin-left: 14px; font-weight:500;}


.btn {
    display:inline-block;
    margin-top: 12px;
    padding: 10px 12px;
    border-radius: 10px;
    border: 1px solid #16a34a;
    background: #16a34a;
    color: #fff;
    font-weight: 800;
    text-decoration: none;
  }


  </style>
</head>
<body>
  <nav>
    <div class="logo">Task<span>ME</span></div>
    <div class="toplinks">
      <a href="dashboard">Home</a>
      <a href="account">Account</a>
      <a href="logout">Logout</a>
    </div>
  </nav>

  <div class="container">
    <div class="card">
      <h1>Welcome to TaskME</h1>

      <%
        String firstName = (String) session.getAttribute("firstName");
        if (firstName != null) {
      %>
        <p>You are logged in as <strong><%= firstName %></strong>.</p>
      <%
        } else {
      %>
        <p>You are logged in.</p>
      <%
        }
      %>

      <p style="margin-top:14px; font-weight:600; color:#111;">Your Projects</p>
<a class="btn" href="create-project">+ Create Project</a>
      <%
        // DashboardServlet sends: List<Object[]>
        // row = [0]=Project_ID, [1]=Project_Name, [2]=Due_Date, [3]=Role
        SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd hh:mm a");
        List<?> projects = (List<?>) request.getAttribute("projects");

        if (projects == null || projects.isEmpty()) {
      %>
        <p style="margin-top:10px;">No projects yet.</p>
      <%
        } else {
          for (Object obj : projects) {
            Object[] row = (Object[]) obj;
      %>
        <div class="project">
          <div class="project-title"><%= row[1] %></div>
          <div class="meta">Role: <%= row[3] %></div>
          <div class="meta">Due: <%= (row[2] == null ? "N/A" : fmt.format(row[2])) %></div>
          <a class="link" href="project?id=<%= row[0] %>">Open Project -></a>
        </div>
      <%
          }
        }
      %>

    </div>
  </div>
</body>
</html>