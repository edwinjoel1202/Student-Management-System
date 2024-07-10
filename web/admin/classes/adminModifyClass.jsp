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
                                <option value="<%= classname %>"><%= classname %></option>
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
                String selectedClass = request.getParameter("selectedClass");
                String currentInchargeName = "";
                int currentInchargeId = 0;

                try {
                    conn = databaseConnection.getConnection();
                    String sql = "SELECT c.classname, c.inchargeid AS incharge_id, i.fname, i.lname " +
                                 "FROM classes c INNER JOIN user_personal_details i ON c.incharge_id = i.id " +
                                 "WHERE c.classname = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, selectedClass);
                    rs = ps.executeQuery();
                    if (rs.next()) {
                        currentInchargeId = rs.getInt("incharge_id");
                        currentInchargeName = rs.getString("fname") + " " + rs.getString("lname");
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
        <form method="post">
            <input type="hidden" name="selectedClass" value="<%= selectedClass %>">
            <div class="form-group mb-3">
                <label for="classname" class="form-label">Class Name</label>
                <input type="text" id="classname" name="classname" class="form-control" value="<%= selectedClass %>" required>
            </div>
            <div class="form-group mb-3">
                <label for="incharge" class="form-label">Class Incharge</label>
                <select id="incharge" name="incharge" class="form-select" required>
                    <option value="<%= currentInchargeId %>"><%= currentInchargeName %> (Current)</option>
                    <!-- Add options dynamically from database -->
                    <%
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT id, fname, lname FROM user_personal_details WHERE isClassIncharge = false";
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();
                            while (rs.next()) {
                                int id = rs.getInt("id");
                                String fname = rs.getString("fname");
                                String lname = rs.getString("lname");
                                String fullName = fname + " " + lname;
                    %>
                                <option value="<%= id %>"><%= fullName %></option>
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
            <div class="form-group mb-3">
                <label for="description" class="form-label">Class Description</label>
                <textarea id="description" name="description" class="form-control" rows="3"></textarea>
            </div>
            <div class="form-group mb-3">
                <label for="timetable" class="form-label">Class Timetable</label>
                <textarea id="timetable" name="timetable" class="form-control" rows="3"></textarea>
            </div>
            <button type="submit" class="btn btn-primary">Update Class</button>
        </form>

        <h2 class="text-center mt-5 mb-4">Add/Remove Students</h2>
        <form method="post" action="adminModifyClass.jsp">
            <input type="hidden" name="selectedClass" value="<%= selectedClass %>">
            <div class="form-group mb-3">
                <label for="students" class="form-label">Add/Remove Students</label>
                <select id="students" name="students" class="form-select" multiple>
                    <!-- Add options dynamically from database -->
                    <%
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT regno, fname, lname FROM user_personal_details";
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();
                            while (rs.next()) {
                                String regno = rs.getString("regno");
                                String fname = rs.getString("fname");
                                String lname = rs.getString("lname");
                                String fullName = fname + " " + lname;
                    %>
                                <option value="<%= regno %>"><%= fullName %> (<%= regno %>)</option>
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
            <button type="submit" class="btn btn-primary">Update Students</button>
        </form>

        <%
            }
        %>
    </div>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


