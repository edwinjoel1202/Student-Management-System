<%-- 
    Document   : Login
    Created on : 03-Jul-2024, 12:34:45 pm
    Author     : edwin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import= "java.sql.*"%>
<%@page import= "com.student.util.databaseConnection"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="css/login.css">
    </head>
    <body>
        <div class="container">
            <h1>Login</h1>
            <form method="post">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <div class="form-group">
                    <label for="role">Role</label>
                    <select id="role" name="role" required>
                        <option value="User">User</option>
                        <option value="Admin">Admin</option>
                    </select>
                </div>
                <button type="submit" class="btn">Login</button>
            </form>
            <p class="register-link">Not registered? <a href="Register.jsp">Register</a></p>
        </div>
        <%
            if("post".equalsIgnoreCase(request.getMethod())){
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String role = request.getParameter("role"); 
                String sql = "SELECT * from " + (role.equals("Admin") ? "admin_details" : "user_details") + 
                " WHERE username = ? AND password = ?";
                
                Connection conn;
                PreparedStatement ps;
                ResultSet rs;
                
                try{
                    conn = databaseConnection.getConnection();
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, username);
                    ps.setString(2, password);
                    rs = ps.executeQuery();
                    
                    if(rs.next())
                    {
                        if(role.equals("Admin")){
                            databaseConnection.closeConnection();
                            rs.close();
                            ps.close();
                            response.sendRedirect("admin/AdminHomepage.jsp");
                        }
                        if(role.equals("User")){
                            databaseConnection.closeConnection();
                            rs.close();
                            ps.close();
                            response.sendRedirect("user/UserHomepage.jsp");
                        }
                    }else{
                        out.println("<script>alert('Invalid username or password !')</script>");
                    }
                  
                }catch(Exception e){
                    out.println("<script>alert('" + e.getMessage() + "');</script>");
                }   
            }
        %>
    </body>
</html>
