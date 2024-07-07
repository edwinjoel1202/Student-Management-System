<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin - Students Section</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/admin/adminStudents.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h1 class="text-center mb-4">Students Management</h1>
                <div class="d-flex justify-content-around mb-4">
                    <a href="students/adminAddStudents.jsp" class="btn btn-success">Add New Student</a>
                    <a href="students/adminViewStudents.jsp" class="btn btn-success">View/Edit Students</a>
                    <a href="students/adminEnrollStudents.jsp" class="btn btn-success">Enroll Students in Courses</a>
                    <a href="students/adminDeleteStudents.jsp" class="btn btn-success">Delete Students</a>
                    <a href="students/adminSearchStudents.jsp" class="btn btn-success">Search Students</a>
                </div>
            </div>
        </div>
        <!-- Bootstrap JS and dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
