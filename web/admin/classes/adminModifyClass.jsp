

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="com.student.util.databaseConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modify Class</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Modify Class</h1>
        
        <!-- Select Class Form -->
        <form method="post">
            <div class="form-group mb-3">
                <label for="selectedClass" class="form-label">Select Class</label>
                <select id="selectedClass" name="selectedClass" class="form-select" required>
                    <!-- Add options dynamically from database -->
                    <%
                        Connection conn = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT classname FROM classes order by classname";
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();
                            while (rs.next()) {
                                String classname = rs.getString("classname");
                    %>
                                <option value="<%= classname.trim() %>"><%= classname.trim() %></option>
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
            <button type="submit" class="btn btn-primary">View Class</button>
        </form>
        
        <%
            if ("post".equalsIgnoreCase(request.getMethod()) && request.getParameter("selectedClass") != null) {
                String selectedClass = request.getParameter("selectedClass").trim();
                String currentInchargeName = "";
                String currentInchargeId = "";

                try {
                    conn = databaseConnection.getConnection();
                    String sql = "SELECT c.classname, c.inchargeid AS incharge_id, i.name AS incharge_name " +
                                 "FROM classes c INNER JOIN incharges i ON c.inchargeid = i.id " +
                                 "WHERE c.classname = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, selectedClass);
                    rs = ps.executeQuery();
                    if (rs.next()) {
                        currentInchargeId = rs.getString("incharge_id");
                        currentInchargeName = rs.getString("incharge_name");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                }
        %>
        
        <!-- Class Details Form -->
        <h2 class="text-center mt-5 mb-4">Modify Details for <%= selectedClass %></h2>
        <form method="post" action="adminModifyClass.jsp">
            <input type="hidden" name="selectedClass" value="<%= selectedClass %>">
            <div class="form-group mb-3">
                <label for="classname" class="form-label">Class Name</label>
                <input type="text" id="classname" name="classname" class="form-control" value="<%= selectedClass %>" required>
            </div>
            <div class="form-group mb-3">
                <label for="incharge" class="form-label">Class Incharge</label>
                <select id="incharge" name="incharge" class="form-select" required>
                    <option value="<%= currentInchargeId %>"><%= currentInchargeId %> - <%= currentInchargeName %> (Current)</option>
                    <!-- Add options dynamically from database -->
                    <%
                        try {
                            conn = databaseConnection.getConnection();
                            String sql = "SELECT id, name FROM incharges WHERE \"isClassIncharge\" = false order by id";
                            ps = conn.prepareStatement(sql);
                            rs = ps.executeQuery();
                            while (rs.next()) {
                                String id = rs.getString("id");
                                String name = rs.getString("name");
                    %>
                                <option value="<%= id %>"><%= id %> - <%= name %></option>
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
            <button type="submit" name="modifyClass" class="btn btn-primary">Modify Class</button>
        </form>

        <%
                if (request.getParameter("modifyClass") != null) {
                    String newClassname = request.getParameter("classname");
                    String newInchargeId = request.getParameter("incharge");

                    try {
                        conn = databaseConnection.getConnection();
                        conn.setAutoCommit(false);

                        // Get the current incharge ID
                        String sqlGetCurrentIncharge = "SELECT inchargeid FROM classes WHERE classname = ?";
                        ps = conn.prepareStatement(sqlGetCurrentIncharge);
                        ps.setString(1, selectedClass);
                        ResultSet rsIncharge = ps.executeQuery();
                        if (rsIncharge.next()) {
                            currentInchargeId = rsIncharge.getString("inchargeid");
                        }
                        rsIncharge.close();
                        ps.close();

                        // Update the class details
                        String sqlUpdateClass = "UPDATE classes SET classname = ?, inchargeid = ? WHERE classname = ?";
                        ps = conn.prepareStatement(sqlUpdateClass);
                        ps.setString(1, newClassname);
                        ps.setString(2, newInchargeId);
                        ps.setString(3, selectedClass);
                        ps.executeUpdate();
                        ps.close();

                        // Update the old incharge's status
                        String sqlUpdateOldIncharge = "UPDATE incharges SET \"isClassIncharge\" = false WHERE id = ?";
                        ps = conn.prepareStatement(sqlUpdateOldIncharge);
                        ps.setString(1, currentInchargeId);
                        ps.executeUpdate();
                        ps.close();

                        // Update the new incharge's status
                        String sqlUpdateNewIncharge = "UPDATE incharges SET \"isClassIncharge\" = true WHERE id = ?";
                        ps = conn.prepareStatement(sqlUpdateNewIncharge);
                        ps.setString(1, newInchargeId);
                        ps.executeUpdate();
                        ps.close();

                        conn.commit();
                        out.println("<div class='alert alert-success mt-3'>Class updated successfully.</div>");
                    } catch (SQLException e) {
                        if (conn != null) {
                            try {
                                conn.rollback();
                            } catch (SQLException ex) {
                                ex.printStackTrace();
                            }
                        }
                        e.printStackTrace();
                        out.println("<div class='alert alert-danger mt-3'>Error updating class. Please try again.</div>");
                    } finally {
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    }
                }
            }
        %>
    </div>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
