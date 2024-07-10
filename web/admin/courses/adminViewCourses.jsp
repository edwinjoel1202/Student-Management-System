<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Courses</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/adminViewCourses.css" rel="stylesheet">
    <style>
        .table-bordered th, .table-bordered td {
            border: 2px solid black;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Edit Course Details</h1>
        <form method="post" class="row g-3 justify-content-center mb-4">
            <div class="col-md-6">
                <label for="coursecode" class="form-label">Select Course Code</label>
                <select name="coursecode" class="form-control" id="coursecode" required>
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
            <div class="col-4 text-center mt-5">
                <button type="submit" class="btn btn-primary">View Course</button>
            </div>
        </form>

        <%
            String coursecode = request.getParameter("coursecode");
            if (coursecode != null && !coursecode.trim().isEmpty()) {
                Connection conn2 = null;
                PreparedStatement ps2 = null;
                ResultSet rs2 = null;

                try {
                    conn2 = databaseConnection.getConnection();
                    String sql2 = "SELECT * FROM courses WHERE id = ?";
                    ps2 = conn2.prepareStatement(sql2);
                    ps2.setString(1, coursecode);
                    rs2 = ps2.executeQuery();

                    if (rs2.next()) {
                        String name = rs2.getString("name").trim();
                        String description = rs2.getString("description").trim();
                        int weeks = rs2.getInt("weeks");
                        int maximum_capacity = rs2.getInt("maximum_capacity");
                        
                        %>

                        <div id="course-details" class="text-center">
                            <h2 class="mb-4">Course Details</h2>
                            <table class="table table-bordered table-striped table-hover w-50 mx-auto">
                                <tbody>
                                    <tr>
                                        <th>Course Code</th>
                                        <td><%= coursecode %></td>
                                    </tr>
                                    <tr>
                                        <th>Course Name</th>
                                        <td><%= name %></td>
                                    </tr>
                                    <tr>
                                        <th>Description</th>
                                        <td><%= description %></td>
                                    </tr>
                                    <tr>
                                        <th>Duration (Weeks)</th>
                                        <td><%= weeks %></td>
                                    </tr>
                                    <tr>
                                        <th>Maximum Capacity</th>
                                        <td><%= maximum_capacity %></td>
                                    </tr>
                                </tbody>
                            </table>
                            <button class="btn btn-warning mt-3" id="edit-button">Edit Data</button>
                        </div>

                        <div id="edit-form" style="display: none;">
                            <h2>Edit Course Details</h2>
                            <form method="post" action="adminUpdateCourses.jsp" class="row g-3">
                                <div class="col-md-6">
                                    <label for="coursecode" class="form-label">Course Code</label>
                                    <input type="text" name="coursecode" class="form-control" id="coursecode" value="<%= coursecode %>" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label for="coursename" class="form-label">Course Name</label>
                                    <input type="text" name="coursename" class="form-control" id="coursename" value="<%= name %>" required>
                                </div>
                                <div class="col-md-12">
                                    <label for="description" class="form-label">Description</label>
                                    <textarea name="description" class="form-control" id="description" rows="3" required><%= description %></textarea>
                                </div>
                                <div class="col-md-6">
                                    <label for="weeks" class="form-label">Duration (Weeks)</label>
                                    <input type="number" name="weeks" class="form-control" id="weeks" value="<%= weeks %>" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="maximum_capacity" class="form-label">Maximum Capacity</label>
                                    <input type="number" name="maximum_capacity" class="form-control" id="maximum_capacity" value="<%= maximum_capacity %>" required>
                                </div>
                                <div class="col-4 text-center">
                                    <button type="submit" class="btn btn-success">Update Course</button>
                                </div>
                            </form>
                        </div>

                        <script>
                            document.getElementById('edit-button').addEventListener('click', function() {
                                document.getElementById('course-details').style.display = 'none';
                                document.getElementById('edit-form').style.display = 'block';
                            });
                        </script>

                        <%
                    } else {
                        out.println("<div class='alert alert-danger text-center'>No course found with the given course code.</div>");
                    }
                } catch (SQLException e) {
                    out.println("<div class='alert alert-danger text-center'>Database Error: " + e.getMessage() + "</div>");
                } finally {
                    if (rs2 != null) try { rs2.close(); } catch (SQLException ignore) {}
                    if (ps2 != null) try { ps2.close(); } catch (SQLException ignore) {}
                    if (conn2 != null) try { conn2.close(); } catch (SQLException ignore) {}
                }
            }
        %>
    </div>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
