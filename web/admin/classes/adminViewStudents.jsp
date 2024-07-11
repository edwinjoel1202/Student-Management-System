<%-- 
    Document   : adminViewStudents
    Created on : 09-Jul-2024, 12:48:13 pm
    Author     : edwin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View Students in Class</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">View Students in Class</h1>
        
        <div class="table-responsive">
            <table class="table table-striped table-success table-responsive">
                <thead>
                    <tr>
                        <th>Register Number</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        String classname = request.getParameter("classname");
                        Connection conn = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;

                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT u.regno, u.fname, u.lname, u.email " +
                                         "FROM user_personal_details u INNER JOIN user_class_details uc ON u.regno = uc.regno " +
                                         "WHERE uc.classname = ?";
                            ps = conn.prepareStatement(sql);
                            ps.setString(1, classname);
                            rs = ps.executeQuery();

                            while (rs.next()) {
                                String regno = rs.getString("regno");
                                String fname = rs.getString("fname");
                                String lname = rs.getString("lname");
                                String email = rs.getString("email");
                    %>
                                <tr>
                                    <td><%= regno %></td>
                                    <td><%= fname %></td>
                                    <td><%= lname %></td>
                                    <td><%= email %></td>
                                </tr>
                    <% 
                            }
                        } catch (SQLException e) {
                            out.println("<tr><td colspan='4'>Database Error: " + e.getMessage() + "</td></tr>");
                        } finally {
                            try { if (rs != null) rs.close(); } catch (SQLException e) { /* ignored */ }
                            try { if (ps != null) ps.close(); } catch (SQLException e) { /* ignored */ }
                            try { if (conn != null) conn.close(); } catch (SQLException e) { /* ignored */ }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>