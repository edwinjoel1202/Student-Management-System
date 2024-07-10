<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Course</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/adminDeleteCourses.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1 class="text-center mb-4">Delete Course</h1>
        <div class="form-container">
            <form id="searchForm" method="POST" class="row g-3 justify-content-center">
                <div class="col-md-6">
                    <label for="courseId" class="form-label">Select Course</label>
                    <select name="courseId" class="form-control" id="courseId" required>
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
                                    String id = rs.getString("id").trim();
                                    String name = rs.getString("name").trim();
                        %>
                                    <option value="<%= id %>"><%= name %> (<%= id %>)</option>
                        <%
                                }
                            } catch (SQLException e) {
                                out.println("<option disabled>Error fetching courses</option>");
                            } finally {
                                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                                if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                            }
                        %>
                    </select>
                </div>
                <div class="col-12 text-center">
                    <button type="submit" class="btn btn-primary">Search Course</button>
                </div>
            </form>
        </div>
    </div>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("courseId") != null && request.getParameter("courseIdToDelete") == null) {
            String courseId = request.getParameter("courseId");

            

            try {
                conn = databaseConnection.getConnection();

                // Query to retrieve course details based on courseId
                String courseSql = "SELECT id, name, description, weeks, maximum_capacity FROM courses WHERE id = ?";
                ps = conn.prepareStatement(courseSql);
                ps.setString(1, courseId);
                rs = ps.executeQuery();

                boolean hasData = false;
    %>
    <div class="container mt-4">
        <h2 class="text-center mb-4">Course Details</h2>
        <form id="deleteForm" method="POST">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Course ID</th>
                        <th>Course Name</th>
                        <th>Description</th>
                        <th>Weeks</th>
                        <th>Maximum Capacity</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        while (rs.next()) {
                            hasData = true;
                    %>
                    <tr>
                        <td><%= rs.getString("id") %></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("description") %></td>
                        <td><%= rs.getInt("weeks") %></td>
                        <td><%= rs.getInt("maximum_capacity") %></td>
                    </tr>
                    <%
                        }
                        if (!hasData) {
                            out.println("<tr><td colspan='5' class='text-center'>No data found for Course ID " + courseId + "</td></tr>");
                        }
                    %>
                </tbody>
            </table>
            <div class="text-center mt-4">
                <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirmDeleteModal">Delete Course</button>
                <a href="adminViewCourses.jsp" class="btn btn-secondary">Cancel</a>
                <input type="hidden" name="courseIdToDelete" value="<%= courseId %>">
            </div>
        </form>
    </div>
    <% 
            } catch (SQLException e) {
                out.println("<div class='alert alert-danger text-center'>Database Error: " + e.getMessage() + "</div>");
            } finally {
                // Close resources
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        } else if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("courseIdToDelete") != null) {
            String courseIdToDelete = request.getParameter("courseIdToDelete");

            

            try {
                conn = databaseConnection.getConnection();

                // Delete queries
                String deleteUserCoursesSql = "DELETE FROM user_courses WHERE id=?";
                ps = conn.prepareStatement(deleteUserCoursesSql);
                ps.setString(1, courseIdToDelete);
                int result1 = ps.executeUpdate();

                String deleteCourseSql = "DELETE FROM courses WHERE id=?";
                ps = conn.prepareStatement(deleteCourseSql);
                ps.setString(1, courseIdToDelete);
                int result2 = ps.executeUpdate();

                // Check deletion results
                if (result1 != 0 && result2 != 0) {
                    %>
                    <div class='alert alert-success text-center'>Course deleted successfully!</div>
                    <script>
                        setTimeout(function() {
                            window.location.href = 'adminViewCourses.jsp';
                        }, 3000);
                    </script>
                    <%
                } else {
                    out.println("<div class='alert alert-danger text-center'>Failed to delete course details.</div>");
                }
            } catch (SQLException e) {
                out.println("<div class='alert alert-danger text-center'>Database Error: " + e.getMessage() + "</div>");
            } finally {
                // Close resources
                if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        }
    %>

    <!-- Confirmation Modal -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmDeleteModalLabel">Confirm Deletion</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Are you sure you want to permanently delete this course?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" onclick="submitDeleteForm()">Delete</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function submitDeleteForm() {
            document.getElementById('deleteForm').submit();
        }
    </script>
</body>
</html>
