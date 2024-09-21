<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Exam Schedule</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/adminCreateExamSchedule.css" rel="stylesheet">
    <style>
        .form-label {
            font-weight: bold;
        }
    </style>
    <script>
        function updateCourseName() {
            var courseId = document.getElementById("course_id").value;
            var courseNameField = document.getElementById("course_name");

            if (courseId) {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "getCourseName.jsp?courseid=" + encodeURIComponent(courseId), true);
                xhr.onload = function () {
                    if (xhr.status === 200) {
                        courseNameField.value = xhr.responseText;
                    } else {
                        courseNameField.value = "Error loading course name";
                    }
                };
                xhr.send();
            } else {
                courseNameField.value = "";
            }
        }

        function updateCourses() {
            var className = document.getElementById("class_name").value;
            var courseDropdown = document.getElementById("course_id");

            if (className) {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "getCoursesByClass.jsp?classname=" + encodeURIComponent(className), true);
                xhr.onload = function () {
                    if (xhr.status === 200) {
                        var courses = JSON.parse(xhr.responseText);
                        courseDropdown.innerHTML = '<option value="">Select Course</option>';
                        courses.forEach(function (course) {
                            var option = document.createElement("option");
                            option.value = course.id;
                            option.text = course.id + " - " + course.name;
                            courseDropdown.add(option);
                        });
                    } else {
                        courseDropdown.innerHTML = '<option value="">Error loading courses</option>';
                    }
                };
                xhr.send();
            } else {
                courseDropdown.innerHTML = '<option value="">Select Course</option>';
            }
        }

        function confirmSave(event) {
            event.preventDefault(); // Prevent the default form submission

            var form = event.target;
            var formData = new FormData(form);
            var confirmation = confirm("Are you sure you want to save the schedule?");

            if (confirmation) {
                var xhr = new XMLHttpRequest();
                xhr.open("POST", form.action, false);
                xhr.onload = function() {
                    if (xhr.status === 200) {
                        // Success: Show success message
                        alert("Exam schedule saved successfully!");
                        form.reset(); // Optional: reset form fields
                    } else {
                        // Failure: Show failure message
                        alert("Failed to save exam schedule. Please try again.");
                    }
                };
                xhr.onerror = function() {
                    // Error during the request: Show error message
                    alert("An error occurred while saving the exam schedule. Please check your network connection and try again.");
                };
                xhr.send(formData);
            }
        }
    </script>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Create Exam Schedule</h1>
        <% 
        // Extract form parameters
        String courseId = request.getParameter("course_id");
        String courseName = request.getParameter("course_name");
        String examDateStr = request.getParameter("exam_date");
        String startTime = request.getParameter("start_time");
        String endTime = request.getParameter("end_time");
        String examType = request.getParameter("exam_type");
        String examinerId = request.getParameter("examiner_id");
        String totalDurationStr = request.getParameter("total_duration");
        String maxMarksStr = request.getParameter("max_marks");
        String className = request.getParameter("class_name");
        String hallNo = request.getParameter("hall_no");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = databaseConnection.getConnection();
            conn.setAutoCommit(false); // Start transaction

            // Convert date and number strings
            Date examDate = null;
            int duration = 0;
            int marks = 0;

            if (examDateStr != null && !examDateStr.isEmpty()) {
                examDate = Date.valueOf(examDateStr);
            }

            if (totalDurationStr != null && !totalDurationStr.isEmpty()) {
                duration = Integer.parseInt(totalDurationStr);
            }

            if (maxMarksStr != null && !maxMarksStr.isEmpty()) {
                marks = Integer.parseInt(maxMarksStr);
            }

            String sql = "INSERT INTO exam_schedule (courseid, coursename, exam_date, start_time, end_time, exam_type, examinerid, total_duration, maximum_marks, class_name, hall_no) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, courseId);
            ps.setString(2, courseName);
            ps.setDate(3, examDate);
            ps.setString(4, startTime);
            ps.setString(5, endTime);
            ps.setString(6, examType);
            ps.setString(7, examinerId);
            ps.setInt(8, duration);
            ps.setInt(9, marks);
            ps.setString(10, className);
            ps.setString(11, hallNo);

            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                conn.commit(); // Commit transaction if successful
                out.println("<p>Exam schedule inserted successfully.</p>");
            } else {
                conn.rollback(); // Rollback transaction if no rows affected
                out.println("<p>Failed to insert exam schedule. Please try again.</p>");
            }
        } catch (SQLException e) {
            if (conn != null) try { conn.rollback(); } catch (SQLException ignore) {}
            out.println("<p>Error occurred while inserting exam schedule: " + e.getMessage() + "</p>");
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
        %>
        <form method="post"  class="row g-3 justify-content-center" onsubmit="confirmSave(event)">
            <div class="col-md-6">
                <label for="course_id" class="form-label">Course ID</label>
                <select name="course_id" class="form-control" id="course_id" required onchange="updateCourseName()">
                    <option value="">Select Course</option>
                    <%
                        ResultSet rs = null;
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT id, name FROM courses";
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();
                            while (rs.next()) {
                                String id = rs.getString("id");
                                String name = rs.getString("name");
                                out.println("<option value='" + id + "'>" + id + " - " + name + "</option>");
                            }
                        } catch (SQLException e) {
                            out.println("<option value=''>Error loading courses</option>");
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                        }
                    %>
                </select>
            </div>
            <div class="col-md-6">
                <label for="course_name" class="form-label">Course Name</label>
                <input type="text" name="course_name" class="form-control" id="course_name" required readonly>
            </div>
            <div class="col-md-6">
                <label for="exam_date" class="form-label">Exam Date</label>
                <input type="date" name="exam_date" class="form-control" id="exam_date" required>
            </div>
            <div class="col-md-6">
                <label for="start_time" class="form-label">Start Time</label>
                <input type="time" name="start_time" class="form-control" id="start_time" required>
            </div>
            <div class="col-md-6">
                <label for="end_time" class="form-label">End Time</label>
                <input type="time" name="end_time" class="form-control" id="end_time" required>
            </div>
            <div class="col-md-6">
                <label for="exam_type" class="form-label">Exam Type</label>
                <select name="exam_type" class="form-control" id="exam_type" required>
                    <option value="Semester">Semester</option>
                    <option value="Midterm">Internal</option>
                    <option value="Final">Final</option>
                </select>
            </div>
            <div class="col-md-6">
                <label for="examiner_id" class="form-label">Examiner Name</label>
                <select name="examiner_id" class="form-control" id="examiner_id" required>
                    <option value="">Select Examiner</option>
                    <%
                        ResultSet rsExaminers = null;
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT facultyid, facultyname FROM faculties WHERE facultyid NOT IN (SELECT examinerid FROM exam_schedule)";
                            ps = conn.prepareStatement(sql);
                            rsExaminers = ps.executeQuery();
                            while (rsExaminers.next()) {
                                String facultyId = rsExaminers.getString("facultyid");
                                String facultyName = rsExaminers.getString("facultyname");
                                out.println("<option value='" + facultyId + "'>" + facultyName + "</option>");
                            }
                        } catch (SQLException e) {
                            out.println("<option value=''>Error loading examiners</option>");
                        } finally {
                            if (rsExaminers != null) try { rsExaminers.close(); } catch (SQLException ignore) {}
                            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                        }
                    %>
                </select>
            </div>
            <div class="col-md-6">
                <label for="total_duration" class="form-label">Total Duration (minutes)</label>
                <input type="number" name="total_duration" class="form-control" id="total_duration">
            </div>
            <div class="col-md-6">
                <label for="max_marks" class="form-label">Maximum Marks</label>
                <input type="number" name="max_marks" class="form-control" id="max_marks">
            </div>
            <div class="col-md-6">
                <label for="class_name" class="form-label">Class Name</label>
                <select name="class_name" class="form-control" id="class_name" required onchange="updateCourses()">
                    <option value="">Select Class</option>
                    <%
                        ResultSet rsClasses = null;
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT classname FROM classes";
                            ps = conn.prepareStatement(sql);
                            rsClasses = ps.executeQuery();
                            while (rsClasses.next()) {
                                String name = rsClasses.getString("classname");
                                out.println("<option value='" + name + "'>" + name + "</option>");
                            }
                        } catch (SQLException e) {
                            out.println("<option value=''>Error loading classes</option>");
                        } finally {
                            if (rsClasses != null) try { rsClasses.close(); } catch (SQLException ignore) {}
                            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                        }
                    %>
                </select>
            </div>
                 <div class="col-md-6">
                    <label for="number_of_students" class="form-label">Number of Students</label>
                    <input type="text" name="number_of_students" class="form-control" id="number_of_students" required>
                </div>
            <div class="col-md-6">
                <label for="hall_no" class="form-label">Hall No</label>
                <select name="hall_no" class="form-control" id="hall_no" required>
                    <option value="">Select Hall</option>
                    <%
                        ResultSet rsHalls = null;
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT classname FROM classes"; // Assuming halls are listed similarly to classes
                            ps = conn.prepareStatement(sql);
                            rsHalls = ps.executeQuery();
                            while (rsHalls.next()) {
                                String name = rsHalls.getString("classname");
                                out.println("<option value='" + name + "'>" + name + "</option>");
                            }
                        } catch (SQLException e) {
                            out.println("<option value=''>Error loading halls</option>");
                        } finally {
                            if (rsHalls != null) try { rsHalls.close(); } catch (SQLException ignore) {}
                            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                        }
                    %>
                </select>
            </div>
            <div class="col-md-12 text-center">
                <button type="submit" class="btn btn-primary" onclick="confirmSave(event)">Save Schedule</button>
            </div>
        </form>
    </div>
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>