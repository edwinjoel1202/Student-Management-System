<%-- 
    Document   : adminRemoveStudentsFromClass
    Created on : 12-Jul-2024, 8:07:46 am
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
    <title>Remove Students from Class</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.5.0/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Remove Students from Class</h1>

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
            <button type="button" class="btn btn-primary" onclick="fetchStudents()">View Class</button>
        </form>

        <!-- Students Table -->
        <div class="mt-4">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Reg No</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody id="studentsTable">
                    <!-- Students will be loaded here via AJAX -->
                </tbody>
            </table>
        </div>

        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete student <span id="studentName"></span> from this class?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-danger" id="confirmDeleteButton">Delete</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function fetchStudents() {
            var classname = document.getElementById('selectedClass').value;
            if (classname) {
                var xhr = new XMLHttpRequest();
                xhr.open('GET', 'getStudents.jsp?classname=' + classname, true);
                xhr.onload = function() {
                    if (this.status === 200) {
                        document.getElementById('studentsTable').innerHTML = this.responseText;
                    }
                };
                xhr.send();
            }
        }

        function confirmDelete(regno, name) {
            document.getElementById('studentName').textContent = name;
            var confirmDeleteButton = document.getElementById('confirmDeleteButton');
            confirmDeleteButton.onclick = function() {
                deleteStudent(regno);
            };
            var deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
            deleteModal.show();
        }

        function deleteStudent(regno) {
            var classname = document.getElementById('selectedClass').value;
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'deleteStudents.jsp', true);
            xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
            xhr.onload = function() {
                if (this.status === 200) {
                    fetchStudents();
                    var deleteModal = bootstrap.Modal.getInstance(document.getElementById('deleteModal'));
                    deleteModal.hide();
                } else {
                    alert('Failed to delete student');
                }
            };
            xhr.send('regno=' + regno + '&classname=' + classname);
        }
    </script>
</body>
</html>



