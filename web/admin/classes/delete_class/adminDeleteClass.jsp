<%-- 
    Document   : adminDeleteClass
    Created on : 12-Jul-2024, 7:46:29 am
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
    <title>Delete Class</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Delete Class</h1>
        
        <div class="table-responsive">
            <table class="table table-striped table-bordered table-hover text-center">
                <thead class="table-dark">
                    <tr>
                        <th>Class Name</th>
                        <th>Class Incharge</th>
                        <th>No. of Students</th>
                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        Connection conn = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT c.classname, i.name AS incharge_name, c.noofstudents, c.inchargeid " +
                                         "FROM classes c INNER JOIN incharges i ON c.inchargeid = i.id";
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();
                            while (rs.next()) {
                                String classname = rs.getString("classname");
                                String inchargeName = rs.getString("incharge_name");
                                int noOfStudents = rs.getInt("noofstudents");
                                String inchargeId = rs.getString("inchargeid");
                    %>
                    <tr>
                        <td><%= classname %></td>
                        <td><%= inchargeName %></td>
                        <td><%= noOfStudents %></td>
                        <td>
                            <button class="btn btn-danger" onclick="confirmDelete('<%= classname %>', '<%= inchargeId %>')">
                                <i class="bi bi-trash"></i>
                            </button>
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
        </div>
        
        <!-- Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete the class <span id="classToDelete"></span> permanently?
                        <div class="alert alert-danger mt-3 d-none" id="errorMsg"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-danger" id="deleteConfirmBtn">Delete</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    
    <script>
        let classnameToDelete = '';
        let inchargeIdToUpdate = '';

        function confirmDelete(classname, inchargeId) {
            classnameToDelete = classname;
            inchargeIdToUpdate = inchargeId;
            document.getElementById('classToDelete').textContent = classname;
            document.getElementById('errorMsg').classList.add('d-none');
            var deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
            deleteModal.show();
        }
        
        document.getElementById('deleteConfirmBtn').addEventListener('click', function() {
            deleteClass(classnameToDelete, inchargeIdToUpdate);
        });

        function deleteClass(classname, inchargeId) {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'deleteClass.jsp', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onload = function() {
                var response = JSON.parse(xhr.responseText);
                if (xhr.status === 200 && response.success) {
                    location.reload();
                } else {
                    document.getElementById('errorMsg').textContent = response.message;
                    document.getElementById('errorMsg').classList.remove('d-none');
                }
            };
            xhr.send('classname=' + classname + '&inchargeId=' + inchargeId);
        }
    </script>
</body>
</html>



