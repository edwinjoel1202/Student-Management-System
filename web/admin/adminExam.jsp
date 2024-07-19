<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin - Exam Details</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/admin/adminCourses.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h1 class="text-center mb-4">Exam Details</h1>
            <div class="d-flex justify-content-around mb-4">
                <a href="exams/adminCourseList.jsp" class="btn btn-success">View Courses</a>
                <a href="exams/adminCreateExamSchedule.jsp" class="btn btn-success">Create Schedule</a>
                <a href="exams/adminViewUpdateSchedule.jsp" class="btn btn-success">View/Update Schedule</a>
                <a href="exams/adminDeleteSchedule.jsp" class="btn btn-success">Delete Schedule</a>
                <a href="exams/adminViewOverallSchedule.jsp" class="btn btn-success">View Overall Schedule</a>
            </div>
        </div>
        <!-- Bootstrap JS and dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
