<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>TaskMe Project</title>
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

    .container {max-width: 1200px; margin: 40px auto; padding: 0 24px;}

    .layout {
      display:grid;
      grid-template-columns: 1fr 320px;
      gap: 18px;
      align-items:start;
    }

    .card {
      background:#fff;
      border:1px solid #e5e7eb;
      border-radius:12px;
      padding:18px;
    }

    .header {
      background:#fff; border:1px solid #e5e7eb; border-radius:12px; padding:24px;
      display:flex; gap:16px; justify-content:space-between; align-items:flex-start;
      margin-bottom: 18px;
    }
    .title {font-size:1.6rem; font-weight:800; margin-bottom:6px;}
    .sub {color:#6b7280; line-height:1.6;}
    .pill {
      display:inline-block; padding:6px 10px; border-radius:999px;
      border:1px solid #e5e7eb; background:#fff; color:#111; font-weight:700; font-size:0.9rem;
    }

    .section-title {font-weight:800; margin: 0 0 10px; color:#111;}

    .group {margin-bottom: 18px;}
    .group-head {display:flex; align-items:center; gap:10px; margin-bottom:10px;}
    .tag {
      display:inline-block;
      padding:6px 10px;
      border-radius:999px;
      border:1px solid #e5e7eb;
      font-weight:800;
      font-size:0.85rem;
      background:#fff;
    }
    .tag.p3 {border-color:#16a34a;}
    .tag.p2 {border-color:#e9c46a;}
    .tag.p1 {border-color:#f4a261;}
    .muted {color:#6b7280; font-size:0.92rem;}

    .grid {
      display:grid;
      grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
      gap: 14px;
      justify-items: center;
      align-items: stretch;
    }

    .task {
      width: 100%;
      max-width: 380px;
      background:#fff;
      border:1px solid #e5e7eb;
      border-radius:12px;
      padding:16px;
    }

    .task-top {display:flex; justify-content:space-between; gap:10px; align-items:flex-start;}
    .task-title {font-weight:800; font-size:1.05rem; margin-bottom:6px;}
    .meta {color:#6b7280; font-size:0.92rem; line-height:1.4;}
    .badge {
      display:inline-block;
      padding:6px 10px;
      border-radius:999px;
      border:1px solid #e5e7eb;
      font-weight:800;
      font-size:0.85rem;
      white-space:nowrap;
    }
    .badge.p3 {border-color:#16a34a;}
    .badge.p2 {border-color:#e9c46a;}
    .badge.p1 {border-color:#f4a261;}

    .status {margin-top:10px; font-weight:700;}
    .status small {font-weight:500; color:#6b7280;}

    .empty {
      background:#fff; border:1px dashed #e5e7eb; border-radius:12px;
      padding:18px; color:#6b7280; text-align:center;
    }

    /* Right panel */
    .side h3 {font-size:1rem; margin-bottom:10px;}
    .side-row {display:flex; justify-content:space-between; gap:12px; padding:10px 0; border-bottom:1px solid #f0f1f3;}
    .side-row:last-child {border-bottom:none;}
    .btn {
      display:block; width:100%;
      margin-top:12px;
      padding:10px 12px;
      border-radius:10px;
      border:1px solid #16a34a;
      background:#16a34a;
      color:#fff;
      font-weight:800;
      text-decoration:none;
      text-align:center;
    }
    .btn.secondary {
      background:#fff;
      color:#111;
      border:1px solid #e5e7eb;
      font-weight:700;
    }

    /* Invite collapse */
    .invite-box {
      margin-top: 12px;
      padding-top: 12px;
      border-top: 1px solid #f0f1f3;
      display: none;
    }
    .invite-box.open { display: block; }

    .field { margin-top: 10px; }
    .field label {
      font-weight: 800;
      font-size: 0.92rem;
      display: block;
      margin-bottom: 6px;
    }
    .field input, .field select {
      width: 100%;
      padding: 10px 12px;
      border: 1px solid #e5e7eb;
      border-radius: 10px;
      font-family: inherit;
      font-size: 0.95rem;
      background: #fff;
    }
    .btn-row { display:flex; gap:10px; margin-top:12px; }
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

    <%
      Integer projectId = (Integer) request.getAttribute("projectId");
      String projectName = (String) request.getAttribute("projectName");
      String description = (String) request.getAttribute("description");
      java.sql.Timestamp dueDate = (java.sql.Timestamp) request.getAttribute("dueDate");
      java.sql.Timestamp createdAt = (java.sql.Timestamp) request.getAttribute("createdAt");
      String role = (String) request.getAttribute("role");
      List<?> tasks = (List<?>) request.getAttribute("tasks");
      boolean isAdmin = (role != null && role.equals("ADMIN"));
    %>

    <div class="header">
      <div>
        <div class="title"><%= projectName %></div>
        <div class="sub">
          <%= (description == null || description.trim().isEmpty()) ? "No description provided." : description %>
        </div>
        <div class="sub" style="margin-top:8px;">
          Due: <strong><%= (dueDate == null ? "N/A" : dueDate.toString()) %></strong>
        </div>
      </div>
      <div>
        <div class="pill">Role: <%= role %></div>
      </div>
    </div>

    <div class="layout">
      <!-- LEFT: Task groups -->
      <div class="card">
        <div class="section-title">Tasks</div>

        <%
          if (tasks == null || tasks.isEmpty()) {
        %>
          <div class="empty">No tasks yet for this project.</div>
        <%
          } else {
            List<Object[]> p3 = new ArrayList<>();
            List<Object[]> p2 = new ArrayList<>();
            List<Object[]> p1 = new ArrayList<>();

            for (Object obj : tasks) {
              Object[] row = (Object[]) obj;
              int priority = (Integer) row[5];
              if (priority >= 3) p3.add(row);
              else if (priority == 2) p2.add(row);
              else p1.add(row);
            }
        %>

          <% if (!p3.isEmpty()) { %>
            <div class="group">
              <div class="group-head"><span class="tag p3">P3</span><span class="muted">High priority</span></div>
              <div class="grid">
                <% for (Object[] row : p3) { %>
                  <div class="task">
                    <div class="task-top">
                      <div>
                        <div class="task-title"><%= row[1] %></div>
                        <div class="meta"><%= (row[2] == null || row[2].toString().trim().isEmpty()) ? "No description." : row[2] %></div>
                      </div>
                      <div class="badge p3">P3</div>
                    </div>
                    <div class="status">
                      <%= row[4] %> <small>- Due: <%= (row[3] == null ? "N/A" : row[3].toString()) %></small>
                    </div>
                  </div>
                <% } %>
              </div>
            </div>
          <% } %>

          <% if (!p2.isEmpty()) { %>
            <div class="group">
              <div class="group-head"><span class="tag p2">P2</span><span class="muted">Medium priority</span></div>
              <div class="grid">
                <% for (Object[] row : p2) { %>
                  <div class="task">
                    <div class="task-top">
                      <div>
                        <div class="task-title"><%= row[1] %></div>
                        <div class="meta"><%= (row[2] == null || row[2].toString().trim().isEmpty()) ? "No description." : row[2] %></div>
                      </div>
                      <div class="badge p2">P2</div>
                    </div>
                    <div class="status">
                      <%= row[4] %> <small>- Due: <%= (row[3] == null ? "N/A" : row[3].toString()) %></small>
                    </div>
                  </div>
                <% } %>
              </div>
            </div>
          <% } %>

          <% if (!p1.isEmpty()) { %>
            <div class="group">
              <div class="group-head"><span class="tag p1">P1</span><span class="muted">Low priority</span></div>
              <div class="grid">
                <% for (Object[] row : p1) { %>
                  <div class="task">
                    <div class="task-top">
                      <div>
                        <div class="task-title"><%= row[1] %></div>
                        <div class="meta"><%= (row[2] == null || row[2].toString().trim().isEmpty()) ? "No description." : row[2] %></div>
                      </div>
                      <div class="badge p1">P1</div>
                    </div>
                    <div class="status">
                      <%= row[4] %> <small>- Due: <%= (row[3] == null ? "N/A" : row[3].toString()) %></small>
                    </div>
                  </div>
                <% } %>
              </div>
            </div>
          <% } %>

        <%
          } // end tasks not empty
        %>

      </div>

      <!-- RIGHT: flat panel -->
      <div class="card side">
        <h3>Project Info</h3>

        <div class="side-row">
          <div class="muted">Role</div>
          <div class="pill"><%= role %></div>
        </div>

        <div class="side-row">
          <div class="muted">Created</div>
          <div><%= (createdAt == null ? "N/A" : createdAt.toString()) %></div>
        </div>

        <div class="side-row">
          <div class="muted">Due</div>
          <div><%= (dueDate == null ? "N/A" : dueDate.toString()) %></div>
        </div>

        <a class="btn" href="create-task?projectId=<%= projectId %>">Create Task</a>

        <% if (isAdmin) { %>
          <a class="btn secondary" href="javascript:void(0)" onclick="toggleInvite()" style="margin-top:10px;">
            Invite User
          </a>

          <div id="inviteBox" class="invite-box">
            <form method="post" action="invite-user">
              <input type="hidden" name="projectId" value="<%= projectId %>" />

              <div class="field">
                <label>User Email</label>
                <input name="email" placeholder="teammate@sjsu.edu" required />
              </div>

              <div class="field">
                <label>Role</label>
                <select name="role">
                  <option value="MEMBER" selected>MEMBER</option>
                  <option value="COMMENT_ONLY">COMMENT_ONLY</option>
                  <option value="ADMIN">ADMIN</option>
                </select>
              </div>

              <div class="btn-row">
                <button class="btn" type="submit" style="margin-top:0;">Send Invite</button>
                <a class="btn secondary" href="javascript:void(0)" onclick="toggleInvite()" style="margin-top:0; width:100%;">
                  Close
                </a>
              </div>
            </form>
          </div>
        <% } %>

        <a class="btn secondary" href="dashboard" style="margin-top:10px;">Back to Dashboard</a>
      </div>

    </div>

  </div>

  <script>
    function toggleInvite() {
      const box = document.getElementById("inviteBox");
      if (!box) return;
      box.classList.toggle("open");
    }
  </script>
</body>
</html>