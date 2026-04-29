<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Activity Log</title>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: Arial, sans-serif; background: #f9fafb; color: #111; }
    nav {
      display: flex; justify-content: space-between; align-items: center;
      padding: 16px 40px; background: #fff; border-bottom: 1px solid #e5e7eb;
    }
    .logo { font-size: 1.25rem; font-weight: 700; }
    .logo span { color: #16a34a; }
    .toplinks a { text-decoration: none; color: #111; margin-left: 14px; font-weight: 500; }

    .container {
      max-width: 1100px;
      margin: 60px auto;
      padding: 0 24px;
    }

    .card {
      background: #fff;
      border: 1px solid #e5e7eb;
      border-radius: 12px;
      padding: 32px;
    }

    h1 { margin-bottom: 18px; }

    .btn {
      display: inline-block;
      margin-bottom: 20px;
      padding: 10px 12px;
      border-radius: 10px;
      border: 1px solid #16a34a;
      background: #16a34a;
      color: #fff;
      font-weight: 700;
      text-decoration: none;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
    }

    th, td {
      text-align: left;
      padding: 12px;
      border-bottom: 1px solid #e5e7eb;
    }

    th {
      background: #f3f4f6;
    }

    .empty {
      color: #6b7280;
      margin-top: 12px;
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
      <h1>Project Activity Log</h1>

      <a class="btn" href="project?id=<%= request.getAttribute("projectId") %>">← Back to Project</a>

      <%
        List<?> logs = (List<?>) request.getAttribute("logs");
        SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd hh:mm a");
      %>

      <% if (logs == null || logs.isEmpty()) { %>
        <p class="empty">No activity yet.</p>
      <% } else { %>
        <table>
          <tr>
            <th>#</th>
            <th>User</th>
            <th>Description</th>
            <th>Time</th>
          </tr>

          <%
            for (Object obj : logs) {
              Object[] row = (Object[]) obj;
          %>
            <tr>
              <td><%= row[0] %></td>
              <td><%= row[1] %></td>
              <td><%= row[2] %></td>
              <td><%= fmt.format(row[3]) %></td>
            </tr>
          <%
            }
          %>
        </table>
      <% } %>
    </div>
  </div>
</body>
</html>