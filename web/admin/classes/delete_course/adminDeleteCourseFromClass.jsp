<%-- 
    Document   : adminDeleteCourseFromClass
    Created on : 13-Jul-2024, 10:16:31 am
    Author     : edwin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Course from Class</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.5/font/bootstrap-icons.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Delete Course from Class</h2>
        <form id="viewCoursesForm">
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

        <div id="coursesTable" class="mt-4"></div>
    </div>

    <script>
        $(document).ready(function() {
            $('#viewCoursesForm').on('submit', function(event) {
                event.preventDefault();
                var classname = $('#classname').val();
                $.ajax({
                    url: 'getCourses.jsp',
                    type: 'POST',
                    data: { classname: classname },
                    success: function(data) {
                        $('#coursesTable').html(data);
                    }
                });
            });

            $(document).on('click', '.delete-course-btn', function() {
                var courseid = $(this).data('courseid');
                var classname = $('#classname').val();
                var coursename = $(this).data('coursename');
                $('#deleteModal .modal-body').text('Are you sure you want to delete ' + coursename + ' - ' + courseid + '?');
                $('#deleteModal').data('courseid', courseid);
                $('#deleteModal').data('classname', classname);
                $('#deleteModal').modal('show');
            });

            $('#confirmDeleteBtn').on('click', function() {
                var courseid = $('#deleteModal').data('courseid');
                var classname = $('#deleteModal').data('classname');
                $.ajax({
                    url: 'deleteCourseFromClass.jsp',
                    type: 'POST',
                    data: { courseid: courseid, classname: classname },
                    success: function(response) {
                        $('#deleteModal').modal('hide');
                        $('#viewCoursesForm').submit();
                    },
                    error: function(xhr, status, error) {
                        console.error('Error deleting course:', error);
                    }
                });
            });
        });
    </script>

    <!-- Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteModalLabel">Confirm Deletion</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete this course?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn">Delete</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>



