<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Account - TaskME</title>
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

    .container {max-width:520px; margin:48px auto; padding:0 24px; display:flex; flex-direction:column; gap:20px;}

    .card {background:#fff; border:1px solid #e5e7eb; border-radius:12px; padding:28px;}
    .card-title {font-size:1.15rem; font-weight:800; margin-bottom:4px;}
    .card-sub   {font-size:0.88rem; color:#6b7280; margin-bottom:20px;}

    .user-info  {font-size:1rem; font-weight:700; margin-bottom:2px;}
    .user-email {font-size:0.88rem; color:#6b7280;}

    form {display:grid; gap:0;}
    label {display:block; font-size:0.875rem; font-weight:600; margin-bottom:5px; color:#374151; margin-top:14px;}
    label:first-of-type {margin-top:0;}
    input[type=password] {
      width:100%; padding:10px 14px; border:1px solid #d1d5db;
      border-radius:6px; font-size:0.875rem; font-family:'Inter', sans-serif;
      outline:none; color:#111;
    }
    input[type=password]:focus {border-color:#16a34a;}
    input.input-error {border-color:#ef4444;}

    .field-error {color:#ef4444; font-size:0.78rem; margin-top:5px;}
    .field-hint  {font-size:0.75rem; color:#9ca3af; margin-top:5px;}

    .success-banner {
      background:#f0fdf4; border:1px solid #bbf7d0; border-radius:8px;
      padding:10px 14px; color:#15803d; font-size:0.88rem; font-weight:600;
      margin-bottom:16px;
    }

    .btn-submit {
      width:100%; padding:11px; background:#16a34a; color:#fff;
      border:none; border-radius:6px; font-size:0.9rem; font-weight:700;
      cursor:pointer; font-family:'Inter', sans-serif; margin-top:18px;
    }
    .btn-submit:hover {background:#15803d;}

    .divider {border:none; border-top:1px solid #e5e7eb; margin:0;}

    .danger-zone .card-title {color:#ef4444;}
    .danger-zone .card-sub   {margin-bottom:16px;}
    .btn-danger {
      width:100%; padding:11px; background:#fff; color:#ef4444;
      border:1px solid #ef4444; border-radius:6px; font-size:0.9rem; font-weight:700;
      cursor:pointer; font-family:'Inter', sans-serif;
    }
    .btn-danger:hover {background:#fef2f2;}
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
    String firstName = (String) request.getAttribute("firstName");
    String lastName  = (String) request.getAttribute("lastName");
    String email     = (String) request.getAttribute("email");
    String error     = (String) request.getAttribute("error");
    String success   = (String) request.getAttribute("success");

    // Map error codes to per-field placement
    boolean errWrongPassword  = "wrong_password".equals(error);
    boolean errTooShort       = "too_short".equals(error);
    boolean errMismatch       = "mismatch".equals(error);
    boolean errSamePassword   = "same_password".equals(error);
    boolean errMissingFields  = "missing_fields".equals(error);
    boolean successPwChanged  = "password_changed".equals(success);
  %>

  <!-- ── Profile card ──────────────────────────────────────────────── -->
  <div class="card">
    <div class="card-title">My Account</div>
    <div class="card-sub">Logged in as</div>
    <div class="user-info"><%= firstName %> <%= lastName %></div>
    <div class="user-email"><%= email %></div>
  </div>

  <!-- ── Change password card ──────────────────────────────────────── -->
  <div class="card">
    <div class="card-title">Change Password</div>
    <div class="card-sub">Your new password must be at least 8 characters.</div>

    <% if (successPwChanged) { %>
      <div class="success-banner">Password updated successfully.</div>
    <% } %>

    <form action="account" method="post" onsubmit="return validatePassword()">
      <input type="hidden" name="action" value="change-password" />

      <label for="currentPassword">Current Password</label>
      <input type="password" id="currentPassword" name="currentPassword"
             placeholder="••••••••"
             class="<%= errWrongPassword || errSamePassword || errMissingFields ? "input-error" : "" %>" />
      <% if (errWrongPassword) { %>
        <div class="field-error">Current password is incorrect.</div>
      <% } else if (errSamePassword) { %>
        <div class="field-error">New password must be different from your current password.</div>
      <% } else if (errMissingFields) { %>
        <div class="field-error">All fields are required.</div>
      <% } %>

      <label for="newPassword">New Password</label>
      <input type="password" id="newPassword" name="newPassword"
             placeholder="••••••••"
             class="<%= errTooShort ? "input-error" : "" %>" />
      <div class="field-hint">Must be at least 8 characters.</div>
      <% if (errTooShort) { %>
        <div class="field-error">Password must be at least 8 characters.</div>
      <% } %>

      <label for="confirmPassword">Confirm New Password</label>
      <input type="password" id="confirmPassword" name="confirmPassword"
             placeholder="••••••••"
             class="<%= errMismatch ? "input-error" : "" %>" />
      <% if (errMismatch) { %>
        <div class="field-error">Passwords do not match.</div>
      <% } %>

      <button class="btn-submit" type="submit">Update Password</button>
    </form>
  </div>

  <!-- ── Danger zone card ──────────────────────────────────────────── -->
  <div class="card danger-zone">
    <div class="card-title">Delete Account</div>
    <div class="card-sub">
      This permanently deletes your account. Any projects where you are an
      admin will also be deleted along with all their tasks and data.
      This action cannot be undone.
    </div>
    <form action="account" method="post"
          onsubmit="return confirm('Are you sure you want to permanently delete your account? This cannot be undone.');">
      <input type="hidden" name="action" value="delete-account" />
      <button class="btn-danger" type="submit">Delete My Account</button>
    </form>
  </div>

</div>

<script>
  function validatePassword() {
    // Clear previous JS errors
    ['currentPassword','newPassword','confirmPassword'].forEach(id => {
      const el = document.getElementById(id);
      el.classList.remove('input-error');
      const err = document.getElementById(id + '-js-err');
      if (err) err.remove();
    });

    const cur  = document.getElementById('currentPassword');
    const nw   = document.getElementById('newPassword');
    const conf = document.getElementById('confirmPassword');
    let ok = true;

    function showErr(el, msg) {
      el.classList.add('input-error');
      const p = document.createElement('p');
      p.id = el.id + '-js-err';
      p.className = 'field-error';
      p.textContent = msg;
      el.after(p);
      ok = false;
    }

    if (!cur.value.trim())  showErr(cur,  'This field is required.');
    if (!nw.value.trim())   showErr(nw,   'This field is required.');
    if (!conf.value.trim()) showErr(conf, 'This field is required.');
    if (!ok) return false;

    if (nw.value.length < 8) {
      showErr(nw, 'Password must be at least 8 characters.');
      return false;
    }
    if (nw.value !== conf.value) {
      showErr(conf, 'Passwords do not match.');
      return false;
    }
    return true;
  }
</script>

</body>
</html>
