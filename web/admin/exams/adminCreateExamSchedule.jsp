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
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Create Exam Schedule</h1>
        <% 
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String courseid = request.getParameter("courseid");
                String coursename = request.getParameter("coursename");
                String examdate = request.getParameter("examdate");
                String starttime = request.getParameter("starttime");
                String endtime = request.getParameter("endtime");
                String examtype = request.getParameter("examtype");
                String examinername = request.getParameter("examinername");
                String totalduration = request.getParameter("totalduration");
                String maximum_marks = request.getParameter("maximum_marks");
                String classname = request.getParameter("class");
                String number_of_students = request.getParameter("number_of_students");

                Connection conn = null;
                PreparedStatement ps = null;

                try {
                    conn = databaseConnection.getConnection();
                    String sql = "INSERT INTO exam_schedule (courseid, coursename, examdate, starttime, endtime, examtype, examinername, totalduration, maximum_marks, classname, number_of_students) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, courseid);
                    ps.setString(2, coursename);
                    ps.setDate(3, Date.valueOf(examdate));
                    ps.setTime(4, Time.valueOf(starttime));
                    ps.setTime(5, Time.valueOf(endtime));
                    ps.setString(6, examtype);
                    ps.setString(7, examinername);
                    ps.setInt(8, Integer.parseInt(totalduration));
                    ps.setInt(9, Integer.parseInt(maximum_marks));
                    ps.setString(10, classname);
                    ps.setInt(11, Integer.parseInt(number_of_students));

                    int result = ps.executeUpdate();
                    if (result > 0) {
                        out.println("<div class='alert alert-success'>Exam schedule saved successfully!</div>");
                    } else {
                        out.println("<div class='alert alert-danger'>Failed to save exam schedule!</div>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                } finally {
                    if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            }
        %>
        <form method="post" class="row g-3 justify-content-center">
            <div class="col-md-6">
                <label for="courseid" class="form-label">Course ID</label>
                <select name="courseid" class="form-control" id="courseid" required>
                    <option value="">Select Course</option>
                    <%
                        Connection conn = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT id, name FROM courses";
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();
                            while (rs.next()) {
                                String courseId = rs.getString("id");
                                String courseName = rs.getString("name");
                                out.println("<option value='" + courseId + "'>" + courseId + " - " + courseName + "</option>");
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
                <label for="coursename" class="form-label">Course Name</label>
                <input type="text" name="coursename" class="form-control" id="coursename" required readonly>
            </div>
            <div class="col-md-6">
                <label for="examdate" class="form-label">Exam Date</label>
                <input type="date" name="examdate" class="form-control" id="examdate" required>
            </div>
            <div class="col-md-6">
                <label for="starttime" class="form-label">Start Time</label>
                <input type="time" name="starttime" class="form-control" id="starttime" required>
            </div>
            <div class="col-md-6">
                <label for="endtime" class="form-label">End Time</label>
                <input type="time" name="endtime" class="form-control" id="endtime" required>
            </div>
            <div class="col-md-6">
                <label for="examtype" class="form-label">Exam Type</label>
                <select name="examtype" class="form-control" id="examtype" required>
                    <option value="Semester">Semester</option>
                    <option value="Internal">Internal</option>
                </select>
            </div>
            <div class="col-md-6">
                <label for="examinername" class="form-label">Examiner Name</label>
                <select name="examinername" class="form-control" id="examinername" required>
                    <option value="">Select Examiner</option>
                    <%
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT facultyid, facultyname FROM faculties WHERE facultyid NOT IN (SELECT examinerid FROM exam_schedule)";
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();
                            while (rs.next()) {
                                String facultyId = rs.getString("facultyid");
                                String facultyName = rs.getString("facultyname");
                                out.println("<option value='" + facultyId + "'>" + facultyName + "</option>");
                            }
                        } catch (SQLException e) {
                            out.println("<option value=''>Error loading examiners</option>");
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                        }
                    %>
                </select>
            </div>
            <div class="col-md-6">
                <label for="totalduration" class="form-label">Total Duration (minutes)</label>
                <input type="number" name="totalduration" class="form-control" id="totalduration" required>
            </div>
            <div class="col-md-6">
                <label for="maximum_marks" class="form-label">Maximum Marks</label>
                <input type="number" name="maximum_marks" class="form-control" id="maximum_marks" required>
            </div>
            <div class="col-md-6">
                <label for="class" class="form-label">Class No</label>
                <select name="class" class="form-control" id="class" required>
                    <option value="">Select Class</option>
                    <%
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT classname FROM classes";
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();
                            while (rs.next()) {
                                String className = rs.getString("classname");
                                out.println("<option value='" + className + "'>" + className + "</option>");
                            }
                        } catch (SQLException e) {
                            out.println("<option value=''>Error loading classes</option>");
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                        }
                    %>
                </select>
            </div>
            <div class="col-md-6">
                <label for="number_of_students" class="form-label">Number of Students</label>
                <input type="text" name="number_of_students" class="form-control" id="number_of_students" required readonly>
            </div>
            <div class="col-12 text-center">
                <button type="submit" class="btn btn-primary">Save Exam Schedule</button>
            </div>
        </form>
    </div>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById("courseid").addEventListener("change", function() {
            var selectedCourse = this.options[this.selectedIndex];
            var courseName = selectedCourse.text.split(" - ")[1];
            document.getElementById("coursename").value = courseName;
        });

        document.getElementById("class").addEventListener("change", function() {
            var className = this.value;
            fetch('adminGetStudentCount.jsp?class=' + className)
                .then(response => response.json())
                .then(data => {
                    document.getElementById("number_of_students").value = data.count;
                })
                .catch(error => console.error('Error:', error));
        });
    </script>
</body>
</html>
