<%-- 
    Document   : adminUpdateFaculties
    Created on : 19-Jul-2024, 9:24:40 am
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
    <title>Update Faculties</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Update Faculties</h1>
        <%
            String selectedClass = request.getParameter("selectedClass");

            Connection conn = null;
            PreparedStatement psUpdate = null;
            ResultSet rs = null;
            boolean updateSuccess = true;

            try {
                conn = databaseConnection.getConnection();
                conn.setAutoCommit(false);

                // Update class_courses table
                String sqlCourses = "SELECT courseid FROM class_courses WHERE classname = ?";
                psUpdate = conn.prepareStatement(sqlCourses);
                psUpdate.setString(1, selectedClass);
                rs = psUpdate.executeQuery();

                while (rs.next()) {
                    String courseid = rs.getString("courseid");
                    String newFacultyId = request.getParameter("faculty_" + courseid);

                    String updateSql = "UPDATE class_courses SET facultyid = ?, facultyname = " +
                                       "(SELECT facultyname FROM faculties WHERE facultyid = ?) " +
                                       "WHERE classname = ? AND courseid = ?";
                    psUpdate = conn.prepareStatement(updateSql);
                    psUpdate.setString(1, newFacultyId);
                    psUpdate.setString(2, newFacultyId);
                    psUpdate.setString(3, selectedClass);
                    psUpdate.setString(4, courseid);
                    psUpdate.executeUpdate();
                }

                conn.commit();
            } catch (SQLException e) {
                updateSuccess = false;
                if (conn != null) {
                    try {
                        conn.rollback();
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                }
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (psUpdate != null) psUpdate.close();
                if (conn != null) conn.close();
            }

            if (updateSuccess) {
        %>
            <div class="alert alert-success text-center" role="alert">
                Successfully updated!
            </div>
        <%
            } else {
        %>
            <div class="alert alert-danger text-center" role="alert">
                Update failed. Please try again.
            </div>
        <%
            }
        %>
        <div class="text-center">
            <a href="adminModifyFaculties.jsp" class="btn btn-primary">Back to Modify Faculties</a>
        </div>
    </div>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
