<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="com.student.util.databaseConnection" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create New Class</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../../css/admin/classes/adminCreateClass.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Create New Class</h1>
        <form method="post" action="adminCreateClass.jsp" class="mt-4">
            <div class="form-group">
                <label for="classname" class="form-label">Class Name:</label>
                <input type="text" id="classname" name="classname" class="form-control" required>
            </div>

            <div class="form-group">
                <label for="classincharge" class="form-label">Class Incharge:</label>
                <select id="classincharge" name="classincharge" class="form-control" required>
                    <option value="">Select Class Incharge</option>
                    <% 
                        Connection conn = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;

                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT id, name FROM incharges WHERE \"isClassIncharge\" = false order by id";
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();

                            while (rs.next()) {
                                String id = rs.getString("id");
                                String name = rs.getString("name");
                                out.println("<option value='" + id + "'>" + id + " - " + name + "</option>");
                            }
                        } catch (SQLException e) {
                            out.println("<option value=''>Database Error</option>");
                        }
                    %>
                </select>
            </div>

            <button type="submit" class="btn btn-primary">Add Class</button>
        </form>

        <% 
            if ("post".equalsIgnoreCase(request.getMethod())) {
                String classname = request.getParameter("classname");
                String inchargeid = request.getParameter("classincharge");
                String sql = "INSERT INTO classes (classname, inchargeid) VALUES (?, ?)";
                String triggerSQL = "UPDATE incharges SET \"isClassIncharge\" = true where id = ?";
                
                try {
                    conn = databaseConnection.getConnection();
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, classname);
                    ps.setString(2, inchargeid);
                    int rowsAffected1 = ps.executeUpdate();
                       
                    ps = conn.prepareStatement(triggerSQL);
                    ps.setString(1, inchargeid);
                    int rowAffected2 = ps.executeUpdate();

                    if (rowsAffected1 > 0 && rowAffected2 > 0) {
                        out.println("<div class='alert alert-success text-center mt-4'>Class added successfully!</div>");  
                    } else {
                        out.println("<div class='alert alert-danger text-center mt-4'>Failed to add class.</div>");
                    }
                } catch (SQLException e) {
                    out.println("<div class='alert alert-danger text-center mt-4'>Database Error: " + e.getMessage() + "</div>");
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) { /* ignored */ }
                    try { if (ps != null) ps.close(); } catch (SQLException e) { /* ignored */ }
                    try { if (conn != null) conn.close(); } catch (SQLException e) { /* ignored */ }
                }
            }
        %>
    </div>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
