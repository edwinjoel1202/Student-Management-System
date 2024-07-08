<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Students to Class</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Add Students to Class</h1>
        
        <form method="post">
            <div class="mb-3">
                <h4><label for="classSelection" class="form-label mb-2">Class Selection:</label></h4>
                <select name="classSelection" class="form-select" id="classSelection" required>
                    <option value="" disabled selected>Select Class</option>
                    <% 
                        // Fetch class names and incharge names
                        Connection conn = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT classname, name FROM classes INNER JOIN incharges ON classes.inchargeid = incharges.id";
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();

                            while (rs.next()) {
                                String classname = rs.getString("classname");
                                String inchargeName = rs.getString("name");
                    %>
                                <option value="<%= classname %>"><%= classname %> - <%= inchargeName %></option>
                    <% 
                            }
                        } catch (SQLException e) {
                            out.println("<option value='' disabled>Error retrieving classes</option>");
                        } finally {
                            try { if (rs != null) rs.close(); } catch (SQLException e) { /* ignored */ }
                            try { if (ps != null) ps.close(); } catch (SQLException e) { /* ignored */ }
                            try { if (conn != null) conn.close(); } catch (SQLException e) { /* ignored */ }
                        }
                    %>
                </select>
            </div>
            
            
            <div class="row mt-5">
                <div class="col-md-12">
                    <h2>Select Students</h2>
                    <div class="table-responsive mt-4">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Select</th>
                                    <th>Register Number</th>
                                    <th>First Name</th>
                                    <th>Last Name</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    String selectedClass = request.getParameter("classSelection");
                                    try {
                                        conn = databaseConnection.getConnection();
                                        String sql = "SELECT regno, fname, lname FROM user_personal_details "
                                        + "WHERE regno NOT IN (SELECT regno FROM user_class_details)";
                                        ps = conn.prepareStatement(sql);
                                        rs = ps.executeQuery();

                                        while (rs.next()) {
                                            String regno = rs.getString("regno");
                                            String fname = rs.getString("fname");
                                            String lname = rs.getString("lname");
                                %>
                                            <tr>
                                                <td><input type="checkbox" name="selectedStudents" value="<%= regno %>"></td>
                                                <td><%= regno %></td>
                                                <td><%= fname %></td>
                                                <td><%= lname %></td>
                                            </tr>
                                <% 
                                        }
                                    } catch (SQLException e) {
                                        out.println("<tr><td colspan='4'>Database Error: " + e.getMessage() + "</td></tr>");
                                    } finally {
                                        try { if (rs != null) rs.close(); } catch (SQLException e) { /* ignored */ }
                                        try { if (ps != null) ps.close(); } catch (SQLException e) { /* ignored */ }
                                        try { if (conn != null) conn.close(); } catch (SQLException e) { /* ignored */ }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <button type="submit" class="btn btn-primary">Add Students</button>
        </form>
        
        <% 
            // Handling form submission to add students to class
            if ("post".equalsIgnoreCase(request.getMethod())) {
                String className = request.getParameter("classSelection");
                String[] selectedStudents = request.getParameterValues("selectedStudents");
                
                if (className != null && selectedStudents != null && selectedStudents.length > 0) {
                    try {
                        conn = databaseConnection.getConnection();
                        // Insert selected students into user_class_details
                        String insertSQL = "INSERT INTO user_class_details (regno, classname) VALUES (?, ?)";
                        PreparedStatement insertPS = conn.prepareStatement(insertSQL);
                        
                        for (String regno : selectedStudents) {
                            insertPS.setString(1, regno);
                            insertPS.setString(2, className);
                            insertPS.executeUpdate();
                        }
                        
                        // Update noofstudents in classes table
                        String updateSQL = "UPDATE classes SET noofstudents = COALESCE(noofstudents, 0) + ? WHERE classname = ?";
                        PreparedStatement updatePS = conn.prepareStatement(updateSQL);
                        updatePS.setInt(1, selectedStudents.length);
                        updatePS.setString(2, className);
                        updatePS.executeUpdate();
                        
                        // Close resources
                        if (insertPS != null) insertPS.close();
                        if (updatePS != null) updatePS.close();
                    } catch (SQLException e) {
                        out.println("<div class='alert alert-danger' role='alert'>Database Error: " + e.getMessage() + "</div>");
                    } finally {
                        try { if (conn != null) conn.close(); } catch (SQLException e) { /* ignored */ }
                    }
                    
                    // Show success message
                    out.println("<div class='alert alert-success mt-3' role='alert'>Successfully added " + selectedStudents.length + " students to " + className + "</div>");
                } else {
                    out.println("<div class='alert alert-warning mt-3' role='alert'>Please select students and a class to add them.</div>");
                }
            }
        %>
        
    </div>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
