<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin - Classes</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/admin/adminClasses.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h1 class="text-center mb-4">Classes Management</h1>
            <div class="btn-container">
                <a href="classes/adminCreateClass.jsp" class="btn btn-outline-success btn-class-option">Create New Class</a>
                <a href="classes/adminViewClass.jsp" class="btn btn-outline-success btn-class-option">View Classes</a>
                <a href="classes/adminModifyClass.jsp" class="btn btn-outline-success btn-class-option">Modify Class</a>
            </div>
            <div class="btn-container mt-5">
                <a href="classes/add_courses/adminAddCoursesInClass.jsp" class="btn btn-outline-success btn-class-option">Add course in Class</a>
                <a href="classes/delete_course/adminDeleteCourseFromClass.jsp" class="btn btn-outline-success btn-class-option">Remove courses from Class</a>
                <a href="classes/adminViewCoursesInClass.jsp" class="btn btn-outline-success btn-class-option">View Courses in class</a>
            </div><div class="btn-container mt-5">
                 <a href="classes/modify_courses/adminModifyFaculties.jsp" class="btn btn-outline-success btn-class-option">Change Faculties in Class</a> 
                <a href="classes/adminAddStudents.jsp" class="btn btn-outline-success btn-class-option">Add Students</a>
                <a href="classes/remove_students/adminRemoveStudentsFromClass.jsp" class="btn btn-outline-success btn-class-option">Remove Students from Class</a>
            </div>
            </div><div class="btn-container mt-5">
                <a href="classes/adminClassTimetables.jsp" class="btn btn-outline-primary btn-class-option">Class Time Tables</a>
                <a href="classes/delete_class/adminDeleteClass.jsp" class="btn btn-outline-success btn-class-option">Delete Class</a>
            </div>
        </div>
        <!-- Bootstrap JS and dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
