import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class AccountServlet extends HttpServlet {

    private static final String DB_URL  = "jdbc:mysql://localhost:3306/team14";
    private static final String DB_USER = "taskme_app";
    private static final String DB_PASS = "taskme123";

    // ── GET: render account page ─────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Log-In-Page.html");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                String firstName = null, lastName = null, email = null;
                try (PreparedStatement ps = con.prepareStatement(
                    "SELECT First_Name, Last_Name, Email FROM users WHERE User_ID=?"
                )) {
                    ps.setInt(1, userId);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            firstName = rs.getString("First_Name");
                            lastName  = rs.getString("Last_Name");
                            email     = rs.getString("Email");
                        }
                    }
                }

                request.setAttribute("firstName", firstName);
                request.setAttribute("lastName",  lastName);
                request.setAttribute("email",     email);

                // Pass through feedback params from a previous redirect
                request.setAttribute("error",   request.getParameter("error"));
                request.setAttribute("success", request.getParameter("success"));

                request.getRequestDispatcher("Account.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Account page error: " + e.getMessage());
        }
    }

    // ── POST: change-password or delete-account ──────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("Log-In-Page.html");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String action = request.getParameter("action");

        if ("change-password".equals(action)) {
            handleChangePassword(userId, request, response);
        } else if ("delete-account".equals(action)) {
            handleDeleteAccount(userId, session, request, response);
        } else {
            response.sendRedirect("account");
        }
    }

    // ── Change password ──────────────────────────────────────────────────────
    private void handleChangePassword(int userId,
            HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String currentPassword = request.getParameter("currentPassword");
        String newPassword     = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Client-side should catch these, but guard server-side too
        if (currentPassword == null || newPassword == null || confirmPassword == null
                || currentPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            response.sendRedirect("account?error=missing_fields");
            return;
        }

        if (newPassword.length() < 8) {
            response.sendRedirect("account?error=too_short");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("account?error=mismatch");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                // Verify current password
                boolean correct = false;
                try (PreparedStatement ps = con.prepareStatement(
                    "SELECT 1 FROM users WHERE User_ID=? AND Password_Hash=?"
                )) {
                    ps.setInt(1, userId);
                    ps.setString(2, currentPassword);
                    try (ResultSet rs = ps.executeQuery()) { correct = rs.next(); }
                }

                if (!correct) {
                    response.sendRedirect("account?error=wrong_password");
                    return;
                }

                if (newPassword.equals(currentPassword)) {
                    response.sendRedirect("account?error=same_password");
                    return;
                }

                try (PreparedStatement ps = con.prepareStatement(
                    "UPDATE users SET Password_Hash=? WHERE User_ID=?"
                )) {
                    ps.setString(1, newPassword);
                    ps.setInt(2, userId);
                    ps.executeUpdate();
                }

                response.sendRedirect("account?success=password_changed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Change password error: " + e.getMessage());
        }
    }

    // ── Delete account ───────────────────────────────────────────────────────
    private void handleDeleteAccount(int userId, HttpSession session,
            HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                // Delete every project where this user is ADMIN
                // (FK cascade removes tasks, memberships, comments, etc. from those projects)
                List<Integer> adminProjectIds = new ArrayList<>();
                try (PreparedStatement ps = con.prepareStatement(
                    "SELECT Project_ID FROM project_memberships WHERE User_ID=? AND Role='ADMIN'"
                )) {
                    ps.setInt(1, userId);
                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) adminProjectIds.add(rs.getInt("Project_ID"));
                    }
                }

                for (int pid : adminProjectIds) {
                    try (PreparedStatement ps = con.prepareStatement(
                        "DELETE FROM projects WHERE Project_ID=?"
                    )) {
                        ps.setInt(1, pid);
                        ps.executeUpdate();
                    }
                }

                // Delete user (FK cascade removes remaining non-admin memberships,
                // activity_log entries, notifications, etc.)
                try (PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM users WHERE User_ID=?"
                )) {
                    ps.setInt(1, userId);
                    ps.executeUpdate();
                }

                session.invalidate();
                response.sendRedirect("Log-In-Page.html");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Delete account error: " + e.getMessage());
        }
    }
}
