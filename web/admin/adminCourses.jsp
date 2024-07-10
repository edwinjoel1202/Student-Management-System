<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin - Courses Section</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/admin/adminCourses.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h1 class="text-center mb-4">Courses Management</h1>
                <div class="d-flex justify-content-around mb-4">
                    <a href="courses/adminAddCourses.jsp" class="btn btn-success">Add New Course</a>
                    <a href="courses/adminViewCourses.jsp" class="btn btn-success">View/Edit Courses</a>
                    <a href="courses/adminDeleteCourses.jsp" class="btn btn-success">Delete Courses</a>
                    <a href="courses/adminSearchCourses.jsp" class="btn btn-success">Search Courses</a>
                </div>
            </div>
        </div>
        <!-- Bootstrap JS and dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
