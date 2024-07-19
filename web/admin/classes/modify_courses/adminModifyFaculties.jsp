<%-- 
    Document   : adminModifyFaculties
    Created on : 19-Jul-2024, 9:24:16 am
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
    <title>Modify Faculties</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Modify Faculties</h1>
        
        <!-- Select Class Form -->
        <form method="post" action="adminModifyFaculties.jsp">
            <div class="form-group mb-3">
                <label for="selectedClass" class="form-label">Select Class</label>
                <select id="selectedClass" name="selectedClass" class="form-select" required>
                    <option value="">Select Class</option>
                    <!-- Add options dynamically from database -->
                    <%
                        Connection conn = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT DISTINCT classname FROM classes";
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
        %>
        
        <!-- Class Courses Table -->
        <h2 class="text-center mt-5 mb-4">Modify Faculties for <%= selectedClass %></h2>
        <form method="post" action="adminUpdateFaculties.jsp">
            <input type="hidden" name="selectedClass" value="<%= selectedClass %>">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Course ID</th>
                        <th>Course Name</th>
                        <th>Faculty Assigned</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT cc.courseid, c.name as coursename, cc.facultyid, cc.facultyname " +
                                         "FROM class_courses cc " +
                                         "JOIN courses c ON cc.courseid = c.id " +
                                         "WHERE cc.classname = ?";
                            ps = conn.prepareStatement(sql);
                            ps.setString(1, selectedClass);
                            rs = ps.executeQuery();
                            while (rs.next()) {
                                String courseid = rs.getString("courseid");
                                String coursename = rs.getString("coursename");
                                String facultyid = rs.getString("facultyid");
                                String facultyname = rs.getString("facultyname");
                    %>
                    <tr>
                        <td><%= courseid %></td>
                        <td><%= coursename %></td>
                        <td>
                            <select name="faculty_<%= courseid %>" class="form-select">
                                <option value="<%= facultyid %>"><%= facultyid %> - <%= facultyname %> (Current)</option>
                                <!-- Add options dynamically from database -->
                                <%
                                    try {
                                        String sqlFaculties = "SELECT facultyid, facultyname FROM faculties";
                                        PreparedStatement psFaculties = conn.prepareStatement(sqlFaculties);
                                        ResultSet rsFaculties = psFaculties.executeQuery();
                                        while (rsFaculties.next()) {
                                            String fid = rsFaculties.getString("facultyid");
                                            String fname = rsFaculties.getString("facultyname");
                                %>
                                <option value="<%= fid %>"><%= fid %> - <%= fname %></option>
                                <%
                                        }
                                        rsFaculties.close();
                                        psFaculties.close();
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
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
                </tbody>
            </table>
            <button type="submit" class="btn btn-primary">Update</button>
        </form>
        <%
            }
        %>
    </div>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

