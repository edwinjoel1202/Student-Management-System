<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add New Course</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/admin/courses/adminAddCourses.css" rel="stylesheet">
   
</head>
<body>
    <div class="container">
        <h1 class="text-center">Add New Course</h1>
        <div class="form-container">
            <form id="addCourseForm" action="adminAddCourses.jsp" method="post">
                <div class="form-group">
                    <label for="courseName">Course Name</label>
                    <input type="text" class="form-control" id="courseName" name="courseName" required>
                </div>
                <div class="form-group">
                    <label for="courseId">Course ID</label>
                    <input type="text" class="form-control" id="courseId" name="courseId" required>
                </div>
                <div class="form-group">
                    <label for="courseDescription">Course Description</label>
                    <textarea class="form-control" id="courseDescription" name="courseDescription" rows="3" required></textarea>
                </div>
                <div class="form-group">
                    <label for="duration">Duration (in weeks)</label>
                    <input type="number" class="form-control" id="duration" name="duration" required>
                </div>
                <div class="form-group">
                    <label for="maxEnrollment">Maximum Enrollment Capacity</label>
                    <input type="number" class="form-control" id="maxEnrollment" name="maxEnrollment" required>
                </div>
                <div class="btn-container">
                    <button type="button" class="btn btn-success" onclick="confirmAddCourse()">Add</button>
                    <a href="adminViewCourses.jsp" class="btn btn-danger">Cancel</a>
                </div>
            </form>
        </div>
    </div>
    
    <!-- Popup Confirmation -->
    <div class="popup-overlay" id="popup-overlay"></div>
    <div class="popup" id="popup">
        <h3>Confirm Addition</h3>
        <p>Are you sure you want to add this course?</p>
        <div class="popup-buttons">
            <button class="popup-button confirm-button btn btn-success" onclick="addCourse()">Confirm</button>
            <button class="popup-button cancel-button btn btn-danger" onclick="closePopup()">Cancel</button>
        </div>
    </div>
    
    <script>
        function confirmAddCourse() {
            document.getElementById('popup-overlay').style.display = 'block';
            document.getElementById('popup').style.display = 'block';
        }

        function closePopup() {
            document.getElementById('popup-overlay').style.display = 'none';
            document.getElementById('popup').style.display = 'none';
        }

        function addCourse() {
            document.getElementById('addCourseForm').submit();
        }
    </script>
    
    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            Connection conn = null;
            PreparedStatement ps = null;
            
            String course_Name = request.getParameter("courseName");
            String course_Id = request.getParameter("courseId");
            String course_Description = request.getParameter("courseDescription");
            int duration = Integer.parseInt(request.getParameter("duration"));
            int max_Enrollment = Integer.parseInt(request.getParameter("maxEnrollment"));
            
            String courses_sql = "INSERT INTO courses (id, name, description, weeks, maximum_capacity) VALUES (?, ?, ?, ?, ?)";
            
            try {
                conn = databaseConnection.getConnection();
                ps = conn.prepareStatement(courses_sql);
                ps.setString(1, course_Id);
                ps.setString(2, course_Name);
                ps.setString(3, course_Description);
                ps.setInt(4, duration);
                ps.setInt(5, max_Enrollment);
                
                int rows = ps.executeUpdate();
                
                if (rows > 0) {
                    out.println("<script>alert('Course Added Successfully!')</script>");
                } else {
                    out.println("<script>alert('Error occurred!')</script>");
                }
            } catch (SQLException e) {
                out.println("<div class='alert alert-danger' role='alert'>Database Error: " + e.getMessage() + "</div>");
            } catch (Exception e) {
                out.println("<div class='alert alert-danger' role='alert'>Error: " + e.getMessage() + "</div>");
            } finally {
                if (ps != null) {
                    try {
                        ps.close();
                    } catch (SQLException e) {
                        out.println("<div class='alert alert-danger' role='alert'>Error closing PreparedStatement: " + e.getMessage() + "</div>");
                    }
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        out.println("<div class='alert alert-danger' role='alert'>Error closing Connection: " + e.getMessage() + "</div>");
                    }
                }
            }
        }
    %>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
