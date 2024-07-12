<%-- 
    Document   : adminAddCoursesInClass
    Created on : 12-Jul-2024, 6:48:29 pm
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
    <title>Add Courses in Class</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.5.0/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Add Courses in Class</h1>

        <!-- Select Class Form -->
        <form id="classForm" method="post">
            <div class="form-group mb-3">
                <label for="selectedClass" class="form-label">Select Class</label>
                <select id="selectedClass" name="selectedClass" class="form-select" required>
                    <option value="">Select a class</option>
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
            <button type="button" class="btn btn-primary" onclick="fetchCourses()">Add Course to this Class</button>
        </form>

        <!-- Faculties Dropdown -->
        <div id="facultySection" class="mt-3 d-none">
            <label for="selectedFaculty" class="form-label">Select Faculty</label>
            <select id="selectedFaculty" name="selectedFaculty" class="form-select" required>
                <option value="">Select a faculty</option>
                <%
                    try {
                        conn = databaseConnection.getConnection();
                        String sql = "SELECT facultyid, facultyname FROM faculties order by facultyid";
                        ps = conn.prepareStatement(sql);
                        rs = ps.executeQuery();
                        while (rs.next()) {
                            String facultyid = rs.getString("facultyid");
                            String facultyname = rs.getString("facultyname");
                %>
                            <option value="<%= facultyid %>-<%= facultyname %>"><%= facultyid %> - <%= facultyname %></option>
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

        <!-- Courses Table -->
        <div class="mt-4">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Course ID</th>
                        <th>Course Name</th>
                        <th>Description</th>
                        <th>Weeks</th>
                        <th>Maximum Capacity</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody id="coursesTable">
                    <!-- Courses will be loaded here via AJAX -->
                </tbody>
            </table>
        </div>

        <!-- Add Confirmation Modal -->
        <div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addModalLabel">Confirm Add</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to add course <span id="courseName"></span> to the class <span id="className"></span>?<br>
                        Faculty to be assigned: <span id="facultyDetails"></span>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-success" id="confirmAddButton">Add</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function fetchCourses() {
            var classname = document.getElementById('selectedClass').value;
            if (classname) {
                var xhr = new XMLHttpRequest();
                xhr.open('GET', 'getAvailableCourses.jsp?classname=' + classname, true);
                xhr.onload = function() {
                    if (this.status === 200) {
                        document.getElementById('coursesTable').innerHTML = this.responseText;
                        document.getElementById('facultySection').classList.remove('d-none');
                    }
                };
                xhr.send();
            }
        }

        function confirmAdd(courseid, coursename) {
            var classname = document.getElementById('selectedClass').value;
            var faculty = document.getElementById('selectedFaculty').value;
            document.getElementById('courseName').textContent = coursename;
            document.getElementById('className').textContent = classname;
            document.getElementById('facultyDetails').textContent = faculty;
            var confirmAddButton = document.getElementById('confirmAddButton');
            confirmAddButton.onclick = function() {
                addCourse(courseid, faculty.split('-')[0]);
            };
            var addModal = new bootstrap.Modal(document.getElementById('addModal'));
            addModal.show();
        }

        function addCourse(courseid, facultyid) {
            var classname = document.getElementById('selectedClass').value;
            var facultyname = document.getElementById('selectedFaculty').value.split('-')[1];
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'addCourseToClass.jsp', true);
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhr.onload = function() {
                if (this.status === 200) {
                    fetchCourses();
                    alert('Course added and faculty assigned successfully!');
                    var addModal = bootstrap.Modal.getInstance(document.getElementById('addModal'));
                    addModal.hide();
                } else {
                    alert('Failed to add course');
                }
            };
            xhr.send('courseid=' + courseid + '&classname=' + classname + '&facultyid=' + facultyid + '&facultyname=' + facultyname);
        }
    </script>
</body>
</html>
