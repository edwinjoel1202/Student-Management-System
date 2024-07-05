<%-- 
    Document   : Register
    Created on : 03-Jul-2024, 12:25:34 pm
    Author     : edwin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link rel="stylesheet" href="css/register.css">
    </head>
    <body>
        <div class="container">
            <h1>Register</h1>
            <form method="post">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="phonenumber">Phone Number</label>
                    <input type="tel" id="phonenumber" name="phonenumber" required>
                </div>
                <div class="form-group">
                    <label for="role">Role</label>
                    <select id="role" name="role" required>
                        <option value="User">User</option>
                        <option value="Admin">Admin</option>
                    </select>
                </div>
                <button type="submit" class="btn">Register</button>
            </form>
            <p class="login-link">Already registered? <a href="Login.jsp">Login</a></p>
        </div>

        <% 
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                Connection conn = null;
                PreparedStatement ps = null;

                String name = request.getParameter("name");
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String email = request.getParameter("email");
                String phonenumber = request.getParameter("phonenumber");
                String role = request.getParameter("role");

                try {
                    conn = databaseConnection.getConnection();
                    String sql = "INSERT INTO " + (role.equals("Admin") ? "admin_details" : "user_details") + 
                                 " (name, username, password, email, phone) VALUES(?, ?, ?, ?, ?)";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, name);
                    ps.setString(2, username);
                    ps.setString(3, password);
                    ps.setString(4, email);
                    ps.setString(5, phonenumber);
                    int rowsAffected = ps.executeUpdate();
                    
                    if (rowsAffected > 0) {
                        
                        databaseConnection.closeConnection();
                        ps.close();
                        response.sendRedirect("Login.jsp");
                        out.println("<script>alert('Registration Successful!');</script>");
                    } else {
                        out.println("<script>alert('Registration Failed. Please try again.');</script>");
                    }
                } catch (SQLException e) {
                    out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
                    e.printStackTrace();
                } 
            }
        %>
    </body>
</html>
