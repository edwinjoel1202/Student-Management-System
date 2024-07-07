<%-- 
    Document   : adminDeleteStudents
    Created on : 05-Jul-2024, 8:58:22 pm
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
    <title>Delete Student</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/adminDeleteStudents.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Delete Student</h1>
        <form id="deleteForm" method="POST" class="row g-3 justify-content-center">
            <div class="col-md-6">
                <label for="regno" class="form-label">Register Number</label>
                <input type="text" name="regno" class="form-control" id="regno" placeholder="Enter Register Number" required>
            </div>
            <div class="col-12 text-center">
                <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirmDeleteModal">Delete Student</button>
            </div>
        </form>
    </div>

    <!-- Confirmation Modal -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmDeleteModalLabel">Confirm Deletion</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Are you sure you want to permanently delete this student?
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

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String regno = request.getParameter("regno");

            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                conn = databaseConnection.getConnection();
                
                // Query to retrieve rollno based on regno
                String rollnoSql = "SELECT rollno FROM user_personal_details WHERE regno=?";
                ps = conn.prepareStatement(rollnoSql);
                ps.setString(1, regno);
                rs = ps.executeQuery();
                
                String rollno = null;
                if (rs.next()) {
                    rollno = rs.getString("rollno");
                } else {
                    out.println("<div class='alert alert-danger text-center'>Student with Register Number " + regno + " not found.</div>");
                    return; // Exit if student not found
                }

                // Delete queries
                String deletePersonalDetailsSql = "DELETE FROM user_personal_details WHERE regno=?";
                ps = conn.prepareStatement(deletePersonalDetailsSql);
                ps.setString(1, regno);
                int result1 = ps.executeUpdate();

                String deleteFamilyDetailsSql = "DELETE FROM user_family_details WHERE rollno=?";
                ps = conn.prepareStatement(deleteFamilyDetailsSql);
                ps.setString(1, rollno);
                int result2 = ps.executeUpdate();

                String deleteSchoolDetailsSql = "DELETE FROM user_school_details WHERE rollno=?";
                ps = conn.prepareStatement(deleteSchoolDetailsSql);
                ps.setString(1, rollno);
                int result3 = ps.executeUpdate();

                // Check deletion results
                if (result1 > 0 && result2 > 0 && result3 > 0) {
    %>
    <script>
        alert('Student deleted successfully!');
        setTimeout(function() {
            window.location.href = 'adminStudents.jsp';
        }, 3000);
    </script>
    <%
                } else {
                    out.println("<div class='alert alert-danger text-center'>Failed to delete student details.</div>");
                }
            } catch (SQLException e) {
                out.println("<div class='alert alert-danger text-center'>Database Error: " + e.getMessage() + "</div>");
            } finally {
                // Close resources
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
        }
    %>
</body>
</html>
