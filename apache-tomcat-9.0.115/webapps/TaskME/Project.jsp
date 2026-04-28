<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
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

    /* Task action buttons */
    .task-actions {display:flex; gap:8px; margin-top:12px;}
    .btn-task {
      padding:5px 12px;
      border-radius:8px;
      font-size:0.82rem;
      font-weight:700;
      font-family:inherit;
      cursor:pointer;
      text-decoration:none;
      text-align:center;
      border:1px solid #e5e7eb;
      background:#fff;
      color:#111;
    }
    .btn-task.edit   {border-color:#16a34a; color:#16a34a;}
    .btn-task.delete {border-color:#ef4444; color:#ef4444; background:#fff;}

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
    .btn.danger {
      background:#fff;
      color:#ef4444;
      border:1px solid #ef4444;
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

    .input-error { border-color:#ef4444 !important; }
    .field-error {
      color:#ef4444;
      font-size:0.85rem;
      margin-top:5px;
    }
    /*label*/
    .labels-section {
  margin-top: 14px;
  padding-top: 12px;
  border-top: 1px solid #f0f1f3;
}

.labels-header h3 {
  margin: 0;
  font-size: 1rem;
  font-weight: 800;
}

.labels-header p {
  margin: 4px 0 10px;
  color: #6b7280;
  font-size: 0.82rem;
  line-height: 1.3;
}

.labels-card {
  padding: 12px;
  border: 1px solid #e5e7eb;
  border-radius: 10px;
  background: #fff;
}

.labels-card h4 {
  margin: 0 0 8px;
  font-size: 0.88rem;
  font-weight: 800;
}

.label-form {
  display: grid;
  gap: 8px;
}

.label-input,
.label-select {
  width: 100%;
  height: 36px;
  padding: 0 10px;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  font-size: 0.85rem;
  font-family: inherit;
  background: #fff;
}

.label-btn {
  width: 100%;
  height: 36px;
  padding: 0 12px;
  border: none;
  border-radius: 8px;
  background: #16a34a;
  color: white;
  font-size: 0.85rem;
  font-weight: 800;
  cursor: pointer;
  font-family: inherit;
}

    /* Members list */
    .members-section { margin-top:18px; padding-top:14px; border-top:1px solid #f0f1f3; }
    .members-title { font-weight:800; font-size:0.92rem; margin-bottom:10px; color:#111; }
    .member-row {
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:8px;
      padding:8px 0;
      border-bottom:1px solid #f0f1f3;
    }
    .member-row:last-child { border-bottom:none; }
    .member-info { flex:1; min-width:0; }
    .member-name { font-weight:700; font-size:0.92rem; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
    .member-email { font-size:0.78rem; color:#6b7280; white-space:nowrap; overflow:hidden; text-overflow:ellipsis; }
    .member-role-badge {
      font-size:0.72rem;
      font-weight:700;
      padding:2px 7px;
      border-radius:999px;
      border:1px solid #e5e7eb;
      white-space:nowrap;
      color:#6b7280;
    }
    .btn-remove {
      padding:4px 10px;
      border-radius:7px;
      font-size:0.78rem;
      font-weight:700;
      font-family:inherit;
      cursor:pointer;
      border:1px solid #ef4444;
      color:#ef4444;
      background:#fff;
      white-space:nowrap;
    }
    .btn-remove:hover { background:#fef2f2; }

    /* ── Comment modal ───────────────────────────────────────────── */
    .modal-overlay {
      display:none; position:fixed; inset:0;
      background:rgba(0,0,0,0.45); z-index:1000;
      align-items:center; justify-content:center;
    }
    .modal-overlay.open { display:flex; }
    .modal-card {
      background:#fff; border-radius:14px;
      width:100%; max-width:560px; max-height:82vh;
      display:flex; flex-direction:column;
      margin:20px; box-shadow:0 8px 32px rgba(0,0,0,0.18);
    }
    .modal-header {
      display:flex; justify-content:space-between; align-items:flex-start;
      padding:18px 20px 14px; border-bottom:1px solid #e5e7eb; flex-shrink:0;
    }
    .modal-header-title { font-weight:800; font-size:1rem; margin-bottom:2px; }
    .modal-header-sub   { font-size:0.8rem; color:#6b7280; }
    .modal-close {
      background:none; border:none; font-size:1.4rem; line-height:1;
      cursor:pointer; color:#6b7280; padding:0 4px; flex-shrink:0;
    }
    .modal-close:hover { color:#111; }
    .modal-body { overflow-y:auto; padding:14px 20px; flex:1; }
    .modal-footer {
      padding:14px 20px; border-top:1px solid #e5e7eb; flex-shrink:0;
    }

    .no-comments { color:#6b7280; font-size:0.9rem; text-align:center; padding:18px 0; }

    .comment-item { padding:10px 0; border-bottom:1px solid #f0f1f3; }
    .comment-item:last-child { border-bottom:none; }
    .comment-meta { font-size:0.8rem; color:#6b7280; margin-bottom:4px; }
    .comment-meta strong { color:#111; font-weight:700; }
    .comment-text { font-size:0.92rem; line-height:1.5; white-space:pre-wrap; }
    .comment-actions { display:flex; gap:6px; margin-top:7px; }
    .btn-ca {
      padding:3px 9px; font-size:0.78rem; font-weight:700;
      border-radius:6px; cursor:pointer; border:1px solid #e5e7eb;
      background:#fff; font-family:inherit;
    }
    .btn-ca.edit   { border-color:#16a34a; color:#16a34a; }
    .btn-ca.delete { border-color:#ef4444; color:#ef4444; }

    .comment-edit-form { display:none; margin-top:8px; }
    .comment-edit-form textarea {
      width:100%; padding:8px 10px; border:1px solid #e5e7eb; border-radius:8px;
      font-family:inherit; font-size:0.9rem; resize:vertical; min-height:60px; outline:none;
    }
    .edit-form-actions { display:flex; gap:6px; margin-top:6px; }

    .add-comment-form textarea {
      width:100%; padding:10px 12px; border:1px solid #e5e7eb; border-radius:10px;
      font-family:inherit; font-size:0.92rem; resize:vertical; min-height:70px;
      outline:none; margin-bottom:8px;
    }
    .add-comment-form textarea:focus { border-color:#16a34a; }
    .btn-add-comment {
      padding:8px 14px; border-radius:9px; border:1px solid #16a34a;
      background:#16a34a; color:#fff; font-weight:800;
      font-family:inherit; font-size:0.88rem; cursor:pointer;
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

    <%
      SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd hh:mm a");
      Integer projectId    = (Integer) request.getAttribute("projectId");
      String projectName   = (String)  request.getAttribute("projectName");
      String description   = (String)  request.getAttribute("description");
      java.sql.Timestamp dueDate   = (java.sql.Timestamp) request.getAttribute("dueDate");
      java.sql.Timestamp createdAt = (java.sql.Timestamp) request.getAttribute("createdAt");
      String role          = (String)  request.getAttribute("role");
      List<?> tasks        = (List<?>)  request.getAttribute("tasks");
      Integer currentUserId = (Integer) request.getAttribute("currentUserId");

      boolean isAdmin  = "ADMIN".equals(role);
      boolean isMember = "MEMBER".equals(role);
      boolean canCreateTask = isAdmin || isMember;

      @SuppressWarnings("unchecked")
      java.util.Map<Integer, java.util.List<Object[]>> commentMap =
          (java.util.Map<Integer, java.util.List<Object[]>>) request.getAttribute("commentMap");
      String commentTaskId = (String) request.getAttribute("commentTaskId");
    %>

    <div class="header">
      <div>
        <div class="title"><%= projectName %></div>
        <div class="sub">
          <%= (description == null || description.trim().isEmpty()) ? "No description provided." : description %>
        </div>
        <div class="sub" style="margin-top:8px;">
          Due: <strong><%= (dueDate == null ? "N/A" : fmt.format(dueDate)) %></strong>
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
                <% for (Object[] row : p3) {
                     boolean canModify = isAdmin || isMember;
                     int tId = (Integer) row[0];
                     java.util.List<Object[]> tComments = (commentMap != null && commentMap.containsKey(tId))
                         ? commentMap.get(tId) : new java.util.ArrayList<>();
                %>
                  <div class="task">
                    <div class="task-top">
                      <div>
                        <div class="task-title"><%= row[1] %></div>
                        <div class="meta"><%= (row[2] == null || row[2].toString().trim().isEmpty()) ? "No description." : row[2] %></div>
                      </div>
                      <div class="badge p3">P3</div>
                    </div>
                    <div class="status">
                      <%= row[4] %> <small>- Due: <%= (row[3] == null ? "N/A" : fmt.format(row[3])) %></small>
                    </div>
                    
                    <%
                      try {
                          Class.forName("com.mysql.cj.jdbc.Driver");
                    
                          java.sql.Connection labelConn = java.sql.DriverManager.getConnection(
                              "jdbc:mysql://localhost:3306/team14",
                              "taskme_app",
                              "taskme123"
                          );
                    
                          java.sql.PreparedStatement labelStmt = labelConn.prepareStatement(
                              "SELECT l.label_name, l.color " +
                              "FROM labels l " +
                              "JOIN task_labels tl ON l.label_id = tl.label_id " +
                              "WHERE tl.task_id = ?"
                          );
                    
                          labelStmt.setInt(1, tId);
                    
                          java.sql.ResultSet labelRs = labelStmt.executeQuery();
                    %>
                    
                    <div style="margin-top:10px; display:flex; gap:6px; flex-wrap:wrap;">
                      <% while (labelRs.next()) { %>
                        <span style="
                          background:<%= labelRs.getString("color") %>;
                          padding:4px 10px;
                          border-radius:999px;
                          font-size:0.75rem;
                          font-weight:700;
                        ">
                          <%= labelRs.getString("label_name") %>
                        </span>
                      <% } %>
                    </div>
                    
                    <%
                          labelRs.close();
                          labelStmt.close();
                          labelConn.close();
                    
                      } catch (Exception e) {
                          out.println("Label error: " + e.getMessage());
                      }
                    %>
                    
                    <div class="task-actions">
                      <% if (canModify) { %>
                      <a class="btn-task edit" href="edit-task?taskId=<%= tId %>&projectId=<%= projectId %>">Edit</a>
                      <form method="post" action="delete-task" onsubmit="return confirm('Delete this task?');" style="margin:0;">
                        <input type="hidden" name="taskId"    value="<%= tId %>" />
                        <input type="hidden" name="projectId" value="<%= projectId %>" />
                        <button class="btn-task delete" type="submit" style="font-family:inherit;font-size:inherit;">Delete</button>
                      </form>
                      <% } %>
                      <button class="btn-task" onclick="openModal(<%= tId %>)" style="font-family:inherit;font-size:inherit;">
                        Comments (<%= tComments.size() %>)
                      </button>
                    </div>
                  </div>
                  <%-- Modal for task <%= tId %> --%>
                  <%@ include file="CommentModal.jspf" %>
                <% } %>
              </div>
            </div>
          <% } %>

          <% if (!p2.isEmpty()) { %>
            <div class="group">
              <div class="group-head"><span class="tag p2">P2</span><span class="muted">Medium priority</span></div>
              <div class="grid">
                <% for (Object[] row : p2) {
                     boolean canModify = isAdmin || isMember;
                     int tId = (Integer) row[0];
                     java.util.List<Object[]> tComments = (commentMap != null && commentMap.containsKey(tId))
                         ? commentMap.get(tId) : new java.util.ArrayList<>();
                %>
                  <div class="task">
                    <div class="task-top">
                      <div>
                        <div class="task-title"><%= row[1] %></div>
                        <div class="meta"><%= (row[2] == null || row[2].toString().trim().isEmpty()) ? "No description." : row[2] %></div>
                      </div>
                      <div class="badge p2">P2</div>
                    </div>
                    <div class="status">
                      <%= row[4] %> <small>- Due: <%= (row[3] == null ? "N/A" : fmt.format(row[3])) %></small>
                    </div>
                    
                    <%
                      try {
                          Class.forName("com.mysql.cj.jdbc.Driver");
                    
                          java.sql.Connection labelConn = java.sql.DriverManager.getConnection(
                              "jdbc:mysql://localhost:3306/team14",
                              "taskme_app",
                              "taskme123"
                          );
                    
                          java.sql.PreparedStatement labelStmt = labelConn.prepareStatement(
                              "SELECT l.label_name, l.color " +
                              "FROM labels l " +
                              "JOIN task_labels tl ON l.label_id = tl.label_id " +
                              "WHERE tl.task_id = ?"
                          );
                    
                          labelStmt.setInt(1, tId);
                    
                          java.sql.ResultSet labelRs = labelStmt.executeQuery();
                    %>
                    
                    <div style="margin-top:10px; display:flex; gap:6px; flex-wrap:wrap;">
                      <% while (labelRs.next()) { %>
                        <span style="
                          background:<%= labelRs.getString("color") %>;
                          padding:4px 10px;
                          border-radius:999px;
                          font-size:0.75rem;
                          font-weight:700;
                        ">
                          <%= labelRs.getString("label_name") %>
                        </span>
                      <% } %>
                    </div>
                    
                    <%
                          labelRs.close();
                          labelStmt.close();
                          labelConn.close();
                    
                      } catch (Exception e) {
                          out.println("Label error: " + e.getMessage());
                      }
                    %>
                    <div class="task-actions">
                      <% if (canModify) { %>
                      <a class="btn-task edit" href="edit-task?taskId=<%= tId %>&projectId=<%= projectId %>">Edit</a>
                      <form method="post" action="delete-task" onsubmit="return confirm('Delete this task?');" style="margin:0;">
                        <input type="hidden" name="taskId"    value="<%= tId %>" />
                        <input type="hidden" name="projectId" value="<%= projectId %>" />
                        <button class="btn-task delete" type="submit" style="font-family:inherit;font-size:inherit;">Delete</button>
                      </form>
                      <% } %>
                      <button class="btn-task" onclick="openModal(<%= tId %>)" style="font-family:inherit;font-size:inherit;">
                        Comments (<%= tComments.size() %>)
                      </button>
                    </div>
                  </div>
                  <%-- Modal for task <%= tId %> --%>
                  <%@ include file="CommentModal.jspf" %>
                <% } %>
              </div>
            </div>
          <% } %>

          <% if (!p1.isEmpty()) { %>
            <div class="group">
              <div class="group-head"><span class="tag p1">P1</span><span class="muted">Low priority</span></div>
              <div class="grid">
                <% for (Object[] row : p1) {
                     boolean canModify = isAdmin || isMember;
                     int tId = (Integer) row[0];
                     java.util.List<Object[]> tComments = (commentMap != null && commentMap.containsKey(tId))
                         ? commentMap.get(tId) : new java.util.ArrayList<>();
                %>
                  <div class="task">
                    <div class="task-top">
                      <div>
                        <div class="task-title"><%= row[1] %></div>
                        <div class="meta"><%= (row[2] == null || row[2].toString().trim().isEmpty()) ? "No description." : row[2] %></div>
                      </div>
                      <div class="badge p1">P1</div>
                    </div>
                    <div class="status">
                      <%= row[4] %> <small>- Due: <%= (row[3] == null ? "N/A" : fmt.format(row[3])) %></small>
                    </div>
                    
                    <%
                      try {
                          Class.forName("com.mysql.cj.jdbc.Driver");
                    
                          java.sql.Connection labelConn = java.sql.DriverManager.getConnection(
                              "jdbc:mysql://localhost:3306/team14",
                              "taskme_app",
                              "taskme123"
                          );
                    
                          java.sql.PreparedStatement labelStmt = labelConn.prepareStatement(
                              "SELECT l.label_name, l.color " +
                              "FROM labels l " +
                              "JOIN task_labels tl ON l.label_id = tl.label_id " +
                              "WHERE tl.task_id = ?"
                          );
                    
                          labelStmt.setInt(1, tId);
                    
                          java.sql.ResultSet labelRs = labelStmt.executeQuery();
                    %>
                    
                    <div style="margin-top:10px; display:flex; gap:6px; flex-wrap:wrap;">
                      <% while (labelRs.next()) { %>
                        <span style="
                          background:<%= labelRs.getString("color") %>;
                          padding:4px 10px;
                          border-radius:999px;
                          font-size:0.75rem;
                          font-weight:700;
                        ">
                          <%= labelRs.getString("label_name") %>
                        </span>
                      <% } %>
                    </div>
                    
                    <%
                          labelRs.close();
                          labelStmt.close();
                          labelConn.close();
                    
                      } catch (Exception e) {
                          out.println("Label error: " + e.getMessage());
                      }
                    %>
                    <div class="task-actions">
                      <% if (canModify) { %>
                      <a class="btn-task edit" href="edit-task?taskId=<%= tId %>&projectId=<%= projectId %>">Edit</a>
                      <form method="post" action="delete-task" onsubmit="return confirm('Delete this task?');" style="margin:0;">
                        <input type="hidden" name="taskId"    value="<%= tId %>" />
                        <input type="hidden" name="projectId" value="<%= projectId %>" />
                        <button class="btn-task delete" type="submit" style="font-family:inherit;font-size:inherit;">Delete</button>
                      </form>
                      <% } %>
                      <button class="btn-task" onclick="openModal(<%= tId %>)" style="font-family:inherit;font-size:inherit;">
                        Comments (<%= tComments.size() %>)
                      </button>
                    </div>
                  </div>
                  <%-- Modal for task <%= tId %> --%>
                  <%@ include file="CommentModal.jspf" %>
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
          <div><%= (createdAt == null ? "N/A" : fmt.format(createdAt)) %></div>
        </div>

        <div class="side-row">
          <div class="muted">Due</div>
          <div><%= (dueDate == null ? "N/A" : fmt.format(dueDate)) %></div>
        </div>

        <%-- Create Task: ADMIN and MEMBER only --%>
        <% if (canCreateTask) { %>
          <a class="btn" href="create-task?projectId=<%= projectId %>">Create Task</a>
        <% } %>
        
        <a class="btn secondary" href="activity-log?projectId=<%= projectId %>" style="margin-top:10px;">
          View Activity Log
        </a>

        <div class="labels-section">
          <div class="labels-header">
            <div>
              <h3>Labels</h3>
              <p>Create and manage labels for this project</p>
            </div>
          </div>
        
          <div class="labels-card">
            <h4>Create New Label</h4>
        
            <form action="<%= request.getContextPath() %>/CreateLabelServlet" method="post" class="label-form">
              <input type="hidden" name="project_id" value="<%= projectId %>">
        
              <input 
                type="text" 
                name="label_name" 
                placeholder="Label name" 
                required
                class="label-input"
              >
        
              <select name="color" class="label-select">
                <option value="#ffcccc">Red</option>
                <option value="#ccffcc">Green</option>
                <option value="#ccccff">Blue</option>
                <option value="#ffffcc">Yellow</option>
                <option value="#e6ccff">Purple</option>
              </select>
        
              <button type="submit" class="label-btn">Add Label</button>
            </form>
          </div>
        </div>

        <%-- Admin-only project controls --%>
        <% if (isAdmin) {
             String inviteError = (String) request.getAttribute("inviteError");
             String inviteEmail = (String) request.getAttribute("inviteEmail");
             String inviteRole  = (String) request.getAttribute("inviteRole");
             if (inviteEmail == null) inviteEmail = "";
             if (inviteRole  == null) inviteRole  = "MEMBER";
             boolean inviteOpen = (inviteError != null);

             String inviteMsg = "";
             if ("not_found".equals(inviteError)) {
               inviteMsg = "No account found with that email address.";
             } else if ("already_member".equals(inviteError)) {
               inviteMsg = "That user is already a member of this project.";
             }
        %>
          <a class="btn secondary" href="edit-project?projectId=<%= projectId %>" style="margin-top:10px;">
            Edit Project
          </a>

          <form method="post" action="delete-project"
                onsubmit="return confirm('Permanently delete this project and all its tasks?');"
                style="margin:0;">
            <input type="hidden" name="projectId" value="<%= projectId %>" />
            <button class="btn danger" type="submit" style="margin-top:10px; font-family:inherit; font-size:inherit;">Delete Project</button>
          </form>

          <a class="btn secondary" href="javascript:void(0)" onclick="toggleInvite()" style="margin-top:10px;">
            Invite User
          </a>

          <div id="inviteBox" class="invite-box <%= inviteOpen ? "open" : "" %>">
            <form method="post" action="invite-user">
              <input type="hidden" name="projectId" value="<%= projectId %>" />

              <div class="field">
                <label>User Email</label>
                <input name="email"
                       placeholder="teammate@sjsu.edu"
                       value="<%= inviteEmail %>"
                       class="<%= inviteMsg.isEmpty() ? "" : "input-error" %>"
                       required />
                <% if (!inviteMsg.isEmpty()) { %>
                  <div class="field-error"><%= inviteMsg %></div>
                <% } %>
              </div>

              <div class="field">
                <label>Role</label>
                <select name="role">
                  <option value="MEMBER"       <%= "MEMBER".equals(inviteRole)       ? "selected" : "" %>>MEMBER</option>
                  <option value="COMMENT_ONLY" <%= "COMMENT_ONLY".equals(inviteRole) ? "selected" : "" %>>COMMENT_ONLY</option>
                  <option value="ADMIN"        <%= "ADMIN".equals(inviteRole)        ? "selected" : "" %>>ADMIN</option>
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

        <%-- Members list --%>
        <%
          List<?> members = (List<?>) request.getAttribute("members");
          if (members != null && !members.isEmpty()) {
        %>
        <div class="members-section">
          <div class="members-title">Members (<%= members.size() %>)</div>
          <%
            for (Object obj : members) {
              Object[] m = (Object[]) obj;
              int    mId    = (Integer) m[0];
              String mFirst = (String)  m[1];
              String mLast  = (String)  m[2];
              String mEmail = (String)  m[3];
              String mRole  = (String)  m[4];
              boolean isSelf = (mId == currentUserId);
          %>
          <div class="member-row">
            <div class="member-info">
              <div class="member-name"><%= mFirst %> <%= mLast %></div>
              <div class="member-email"><%= mEmail %></div>
            </div>
            <span class="member-role-badge"><%= mRole %></span>
            <% if (isAdmin && !isSelf) { %>
            <form method="post" action="remove-member"
                  onsubmit="return confirm('Remove <%= mFirst %> from this project?');"
                  style="margin:0;">
              <input type="hidden" name="projectId"    value="<%= projectId %>" />
              <input type="hidden" name="targetUserId" value="<%= mId %>" />
              <button class="btn-remove" type="submit">Remove</button>
            </form>
            <% } %>
          </div>
          <%
            }
          %>
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

    function openModal(taskId) {
      const m = document.getElementById("modal-" + taskId);
      if (!m) return;
      m.classList.add("open");
      document.body.style.overflow = "hidden";
    }
    function closeModal(taskId) {
      const m = document.getElementById("modal-" + taskId);
      if (!m) return;
      m.classList.remove("open");
      document.body.style.overflow = "";
    }
    function startEdit(commentId) {
      document.getElementById("ctext-"   + commentId).style.display = "none";
      document.getElementById("cact-"    + commentId).style.display = "none";
      document.getElementById("cedit-"   + commentId).style.display = "block";
    }
    function cancelEdit(commentId) {
      document.getElementById("ctext-"   + commentId).style.display = "";
      document.getElementById("cact-"    + commentId).style.display = "";
      document.getElementById("cedit-"   + commentId).style.display = "none";
    }

    // Auto-open modal after a comment action redirect
    (function () {
      const tid = "<%= commentTaskId != null ? commentTaskId : "" %>";
      if (tid) openModal(parseInt(tid, 10));
    })();
  </script>
</body>
</html>