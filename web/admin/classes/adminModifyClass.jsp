<%-- 
    Document   : adminModifyClass
    Created on : 08-Jul-2024, 7:33:44 pm
    Author     : edwin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="com.student.util.databaseConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modify Class</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Modify Class</h1>
        
        <!-- Select Class Form -->
        <form method="post">
            <div class="form-group mb-3">
                <label for="selectedClass" class="form-label">Select Class</label>
                <select id="selectedClass" name="selectedClass" class="form-select" required>
                    <!-- Add options dynamically from database -->
                    <%
                        Connection conn = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT classname FROM classes";
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();
                            while (rs.next()) {
                                String classname = rs.getString("classname");
                    %>
                                <option value="<%= classname.trim() %>"><%= classname.trim() %></option>
                    <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) rs.close();
                            if (ps != null) ps.close();
                            if (conn != null) conn.close();
                        }
                    %>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">View Class</button>
        </form>
        
        <%
            if ("post".equalsIgnoreCase(request.getMethod()) && request.getParameter("selectedClass") != null) {
                String selectedClass = request.getParameter("selectedClass").trim();
                String currentInchargeName = "";
                String currentInchargeId = "";

                try {
                    conn = databaseConnection.getConnection();
                    String sql = "SELECT c.classname, c.inchargeid AS incharge_id, i.name AS incharge_name " +
                                 "FROM classes c INNER JOIN incharges i ON c.inchargeid = i.id " +
                                 "WHERE c.classname = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, selectedClass);
                    rs = ps.executeQuery();
                    if (rs.next()) {
                        currentInchargeId = rs.getString("incharge_id");
                        currentInchargeName = rs.getString("incharge_name");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                }
        %>
        
        <!-- Class Details Form -->
        <h2 class="text-center mt-5 mb-4">Modify Details for <%= selectedClass %></h2>
        <form method="post" action="adminUpdateClass.jsp">
            <input type="hidden" name="selectedClass" value="<%= selectedClass %>">
            <div class="form-group mb-3">
                <label for="classname" class="form-label">Class Name</label>
                <input type="text" id="classname" name="classname" class="form-control" value="<%= selectedClass %>" required>
            </div>
            <div class="form-group mb-3">
                <label for="incharge" class="form-label">Class Incharge</label>
                <select id="incharge" name="incharge" class="form-select" required>
                    <option value="<%= currentInchargeId %>"><%= currentInchargeId %> - <%= currentInchargeName %> (Current)</option>
                    <!-- Add options dynamically from database -->
                    <%
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT id, name FROM incharges WHERE \"isClassIncharge\" = false";
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();
                            while (rs.next()) {
                                String id = rs.getString("id");
                                String name = rs.getString("name");
                    %>
                                <option value="<%= id %>"><%= id %> - <%= name %></option>
                    <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) rs.close();
                            if (ps != null) ps.close();
                            if (conn != null) conn.close();
                        }
                    %>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Update Class</button>
        </form>

        <%
            }
        %>
    </div>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
