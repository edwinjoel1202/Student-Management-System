<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Courses</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/adminSearchCourses.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Search Courses by ID</h1>
        <form method="post" class="row g-3 justify-content-center mb-4">
            <div class="col-md-6">
                <label for="courseid" class="form-label">Select Course</label>
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
            <div class="col-4 text-center">
                <button type="submit" class="btn btn-primary mt-4">Search</button>
            </div>
        </form>

        <% 
            String courseid = request.getParameter("courseid");
            if (courseid != null && !courseid.trim().isEmpty()) {

                try {
                    conn = databaseConnection.getConnection();
                    String sql = "SELECT * FROM courses WHERE id = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, courseid);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        String name = rs.getString("name");
                        String description = rs.getString("description");
                        long weeks = rs.getLong("weeks");
                        long maximumCapacity = rs.getLong("maximum_capacity");

        %>
        <div id="course-details" class="text-center">
            <h2 class="mb-4">Course Details</h2>
            <table class="table table-bordered w-50 mx-auto">
                <tbody>
                    <tr>
                        <th>Course Name</th>
                        <td><%= name %></td>
                    </tr>
                    <tr>
                        <th>Description</th>
                        <td><%= description %></td>
                    </tr>
                    <tr>
                        <th>Weeks</th>
                        <td><%= weeks %></td>
                    </tr>
                    <tr>
                        <th>Maximum Capacity</th>
                        <td><%= maximumCapacity %></td>
                    </tr>
                </tbody>
            </table>
            <button class="btn btn-danger mt-3" onclick="closeDetails()">Close</button>
        </div>

        <script>
            function closeDetails() {
                document.getElementById('course-details').style.display = 'none';
                document.getElementById('courseid').value = '';
            }
        </script>

        <% 
                    } else {
                        out.println("<div class='alert alert-danger text-center'>Course with ID " + courseid + " not found.</div>");
                    }
                } catch (SQLException e) {
                    out.println("<div class='alert alert-danger text-center'>Database Error: " + e.getMessage() + "</div>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                    if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            }
        %>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
