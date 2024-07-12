<%-- 
    Document   : adminViewCoursesInClass
    Created on : 12-Jul-2024, 7:42:14 pm
    Author     : edwin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<!DOCTYPE html>
<html>
<head>
    <title>View Courses in Class</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">View Courses in Class</h2>
        <form method="post">
            <div class="mb-3">
                <label for="classname" class="form-label">Select Class</label>
                <select class="form-select" id="classname" name="classname" required>
                    <option value="">Choose...</option>
                    <%
                        Connection conn = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT DISTINCT classname FROM class_courses";
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();
                            while (rs.next()) {
                                String classname = rs.getString("classname");
                                out.println("<option value='" + classname + "'>" + classname + "</option>");
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
            <button type="submit" class="btn btn-primary">View Courses</button>
        </form>

        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String selectedClassname = request.getParameter("classname");
                if (selectedClassname != null && !selectedClassname.isEmpty()) {
                    Connection conn2 = null;
                    PreparedStatement ps2 = null;
                    ResultSet rs2 = null;
                    try {
                        conn2 = databaseConnection.getConnection();
                        String sql2 = "SELECT * FROM class_courses WHERE classname = ?";
                        ps2 = conn2.prepareStatement(sql2);
                        ps2.setString(1, selectedClassname);
                        rs2 = ps2.executeQuery();
        %>
                        <table class="table table-striped mt-4">
                            <thead>
                                <tr>
                                    <th>Class Name</th>
                                    <th>Course ID</th>
                                    <th>Faculty ID</th>
                                    <th>Faculty Name</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    while (rs2.next()) {
                                        String classname = rs2.getString("classname");
                                        String courseid = rs2.getString("courseid");
                                        String facultyid = rs2.getString("facultyid");
                                        String facultyname = rs2.getString("facultyname");
                                %>
                                    <tr>
                                        <td><%= classname %></td>
                                        <td><%= courseid %></td>
                                        <td><%= facultyid %></td>
                                        <td><%= facultyname %></td>
                                    </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
        <%
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        if (rs2 != null) rs2.close();
                        if (ps2 != null) ps2.close();
                        if (conn2 != null) conn2.close();
                    }
                }
            }
        %>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


