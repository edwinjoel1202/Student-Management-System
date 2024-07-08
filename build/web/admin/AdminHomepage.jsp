<%-- 
    Document   : AdminHomepage
    Created on : 03-Jul-2024, 9:09:42 pm
    Author     : edwin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Home</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/admin/adminHomePage.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Admin Dashboard</h1>
        <div class="row justify-content-center">
            <div class="col-md-4 col-lg-3 mb-4">
                <a href="#" class="card-link">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Quick Statistics</h5>
                            <p class="card-text">View quick stats</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 col-lg-3 mb-4">
                <a href="adminStudents.jsp" class="card-link">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Students</h5>
                            <p class="card-text">Manage students</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 col-lg-3 mb-4">
                <a href="#" class="card-link">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Courses</h5>
                            <p class="card-text">Manage courses</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 col-lg-3 mb-4">
                <a href="adminClasses.jsp" class="card-link">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Classes</h5>
                            <p class="card-text">Manage classes</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 col-lg-3 mb-4">
                <a href="#" class="card-link">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Exams & Results</h5>
                            <p class="card-text">Manage exams and view results</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 col-lg-3 mb-4">
                <a href="#" class="card-link">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Fees</h5>
                            <p class="card-text">Manage fees and payments</p>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-md-4 col-lg-3 mb-4">
                <a href="#" class="card-link">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">View Complaints</h5>
                            <p class="card-text">View and manage complaints</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

