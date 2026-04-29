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

  .notif-wrapper { position:relative; display:inline-block; margin-right:10px; }
  .notif-btn { background:none; border:none; font-size:18px; cursor:pointer; }
  .notif-badge {
    display:inline-flex; align-items:center; justify-content:center;
    background:#dc2626; color:#fff; border-radius:999px;
    font-size:0.65rem; font-weight:700; min-width:16px; height:16px;
    padding:0 4px; margin-left:2px; vertical-align:top;
  }
  .notif-dropdown {
    display:none; position:absolute; right:0; top:32px; width:280px;
    background:#fff; border:1px solid #e5e7eb; border-radius:10px;
    padding:10px; box-shadow:0 5px 15px rgba(0,0,0,0.1); z-index:1000;
  }
  .notif-dropdown.open { display:block; }
  .notif-item { padding:8px 0; border-bottom:1px solid #eee; font-size:0.85rem; }
  .notif-item.unread { font-weight:bold; }
  .notif-empty { color:gray; font-size:0.85rem; }

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
<%
  int dashNotifUserId = (Integer) session.getAttribute("userId");
  int dashUnreadCount = 0;
  try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      try (java.sql.Connection uc = java.sql.DriverManager.getConnection(
              "jdbc:mysql://localhost:3306/team14", "taskme_app", "taskme123");
           java.sql.PreparedStatement up = uc.prepareStatement(
              "SELECT COUNT(*) FROM notifications WHERE User_ID=? AND Is_Read=0")) {
          up.setInt(1, dashNotifUserId);
          java.sql.ResultSet ur = up.executeQuery();
          if (ur.next()) dashUnreadCount = ur.getInt(1);
      }
  } catch (Exception ignored) {}
%>
  <nav>
    <div class="logo">Task<span>ME</span></div>
    <div class="toplinks">
      <div class="notif-wrapper">
        <button type="button" class="notif-btn" onclick="toggleNotifications()">
          🔔<% if (dashUnreadCount > 0) { %><span class="notif-badge" id="notifBadge"><%= dashUnreadCount %></span><% } %>
        </button>
        <div id="notifDropdown" class="notif-dropdown">
          <h4>Notifications</h4>
          <%
            try {
              Class.forName("com.mysql.cj.jdbc.Driver");
              java.sql.Connection nc = java.sql.DriverManager.getConnection(
                  "jdbc:mysql://localhost:3306/team14", "taskme_app", "taskme123");
              java.sql.PreparedStatement ns = nc.prepareStatement(
                  "SELECT Message, Created_At, Is_Read FROM notifications WHERE User_ID=? ORDER BY Created_At DESC LIMIT 10");
              ns.setInt(1, dashNotifUserId);
              java.sql.ResultSet nr = ns.executeQuery();
              boolean hasNotif = false;
              while (nr.next()) {
                hasNotif = true;
          %>
              <div class="notif-item <%= nr.getInt("Is_Read") == 0 ? "unread" : "" %>">
                <div><%= nr.getString("Message") %></div>
                <small><%= nr.getTimestamp("Created_At") %></small>
              </div>
          <%
              }
              if (!hasNotif) {
          %>
              <div class="notif-empty">No notifications</div>
          <%
              }
              nr.close(); ns.close(); nc.close();
            } catch (Exception e) { out.println("Notification error"); }
          %>
        </div>
      </div>
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
<script>
  function toggleNotifications() {
    const dropdown = document.getElementById("notifDropdown");
    if (!dropdown) return;
    const isOpen = dropdown.classList.toggle("open");
    if (isOpen) {
      fetch('notifications', { method: 'POST' }).then(() => {
        document.querySelectorAll('.notif-item.unread').forEach(el => el.classList.remove('unread'));
        const badge = document.getElementById('notifBadge');
        if (badge) badge.remove();
      });
    }
  }
</script>
</body>
</html>