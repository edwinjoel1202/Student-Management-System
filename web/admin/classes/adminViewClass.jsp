<%-- 
    Document   : adminViewClasse
    Created on : 07-Jul-2024, 9:24:27 pm
    Author     : edwin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View Classes</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">View Classes</h1>
        
        <div class="table-responsive">
            <table class="table table-stripped table-success table-responsive">
                <thead>
                    <tr>
                        <th>Class Name</th>
                        <th>Class Incharge ID</th>
                        <th>Class Incharge Name</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        Connection conn = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT c.classname, i.id AS incharge_id, i.name AS incharge_name " +
                                         "FROM classes c INNER JOIN incharges i ON c.inchargeid = i.id";
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();

                            while (rs.next()) {
                                String className = rs.getString("classname");
                                String inchargeId = rs.getString("incharge_id");
                                String inchargeName = rs.getString("incharge_name");
                    %>
                                <tr>
                                    <td><%= className %></td>
                                    <td><%= inchargeId %></td>
                                    <td><%= inchargeName %></td>
                                </tr>
                    <% 
                            }
                        } catch (SQLException e) {
                            out.println("<tr><td colspan='3'>Database Error: " + e.getMessage() + "</td></tr>");
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
