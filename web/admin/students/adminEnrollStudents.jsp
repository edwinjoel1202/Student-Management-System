<%-- 
    Document   : adminEnrollStudents
    Created on : 05-Jul-2024, 12:40:11 pm
    Author     : edwin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enroll Student</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/adminEnrollStudents.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Enroll Student</h1>
        <form method="POST" class="row g-3 justify-content-center">
            <div class="col-md-6">
                <label for="regno" class="form-label">Student Register Number</label>
                <input type="text" name="regno" class="form-control" id="regno" placeholder="Enter Student Register Number" required>
            </div>
            <div class="col-md-6">
                <label for="courseid" class="form-label">Course ID</label>
                <input type="text" name="courseid" class="form-control" id="courseid" placeholder="Enter Course ID" required>
            </div>
            <div class="col-12 text-center">
                <button type="submit" class="btn btn-primary">Enroll Student</button>
            </div>
        </form>
        <%
            if("POST".equalsIgnoreCase(request.getMethod())) {
                Connection conn = null;
                PreparedStatement ps = null;
                try {
                    String regno = request.getParameter("regno");
                    String courseid = request.getParameter("courseid");
                    
                    String sql = "INSERT INTO user_courses (regno, id) VALUES (?, ?)";
                    
                    conn = databaseConnection.getConnection();
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, regno);
                    ps.setString(2, courseid);
                    int rowsAffected = ps.executeUpdate();
                    
                    if(rowsAffected > 0) {
                        %>
                        <script>
                            alert('Enrolled Successfully!');
                            window.location.href="../adminStudents.jsp";
                        </script>
                        <%
                    } else {
                        out.println("<div class='alert alert-danger text-center'>Error in enrolling course details.</div>");
                    }
                } catch (SQLException e) {
                    out.println("<div class='alert alert-danger text-center'>Database Error: " + e.getMessage() + "</div>");
                } finally {
                    try {
                        if(ps != null) ps.close();
                        if(conn != null) conn.close();
                    } catch (SQLException e) {
                        out.println("<div class='alert alert-danger text-center'>Error closing resources: " + e.getMessage() + "</div>");
                    }
                }
            }
        %>
    </div>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
