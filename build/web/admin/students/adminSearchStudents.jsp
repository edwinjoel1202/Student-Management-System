<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Student Details</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/adminViewStudents.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">View Student Details</h1>
        <form method="post" class="row g-3 justify-content-center mb-4">
            <div class="col-md-6">
                <label for="registernumber" class="form-label">Enter Register Number</label>
                <input type="text" name="registernumber" class="form-control" id="registernumber" placeholder="Register Number" required>
            </div>
            <div class="col-4 text-center">
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </form>

        <%
            String registernumber = request.getParameter("registernumber");
            if (registernumber != null && !registernumber.trim().isEmpty()) {
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    conn = databaseConnection.getConnection();
                    String sql = "SELECT * FROM user_personal_details WHERE regno = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, registernumber);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        String fname = rs.getString("fname");
                        String lname = rs.getString("lname");
                        String rollno = rs.getString("rollno");
                        String email = rs.getString("email");
                        String phone = rs.getString("phone");
                        Date dob = rs.getDate("dob");
                        String address = rs.getString("address");
                        String bloodgroup = rs.getString("bloodgroup");
                        String dayorhostel = rs.getString("dayorhostel");

                        String fathersname = "";
                        String mothersname = "";
                        float tenthmark = 0.0f;
                        float twelfthmark = 0.0f;

                        sql = "SELECT * FROM user_family_details WHERE rollno = ?";
                        ps = conn.prepareStatement(sql);
                        ps.setString(1, rollno);
                        rs = ps.executeQuery();
                        if (rs.next()) {
                            fathersname = rs.getString("fathersname");
                            mothersname = rs.getString("mothersname");
                        }

                        sql = "SELECT * FROM user_school_details WHERE rollno = ?";
                        ps = conn.prepareStatement(sql);
                        ps.setString(1, rollno);
                        rs = ps.executeQuery();
                        if (rs.next()) {
                            tenthmark = rs.getFloat("tenthmark");
                            twelfthmark = rs.getFloat("twelfthmark");
                        }
        %>

        <div id="student-details" class="text-center">
            <h2 class="mb-4">Student Details</h2>
            <table class="table table-bordered w-50 mx-auto">
                <tbody>
                    <tr>
                        <th>First Name</th>
                        <td><%= fname %></td>
                    </tr>
                    <tr>
                        <th>Last Name</th>
                        <td><%= lname %></td>
                    </tr>
                    <tr>
                        <th>Roll No</th>
                        <td><%= rollno %></td>
                    </tr>
                    <tr>
                        <th>Register Number</th>
                        <td><%= registernumber %></td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td><%= email %></td>
                    </tr>
                    <tr>
                        <th>Phone Number</th>
                        <td><%= phone %></td>
                    </tr>
                    <tr>
                        <th>Date of Birth</th>
                        <td><%= dob %></td>
                    </tr>
                    <tr>
                        <th>Address</th>
                        <td><%= address %></td>
                    </tr>
                    <tr>
                        <th>Father's Name</th>
                        <td><%= fathersname %></td>
                    </tr>
                    <tr>
                        <th>Mother's Name</th>
                        <td><%= mothersname %></td>
                    </tr>
                    <tr>
                        <th>10th Mark (%)</th>
                        <td><%= tenthmark %></td>
                    </tr>
                    <tr>
                        <th>12th Mark (%)</th>
                        <td><%= twelfthmark %></td>
                    </tr>
                    <tr>
                        <th>Blood Group</th>
                        <td><%= bloodgroup %></td>
                    </tr>
                    <tr>
                        <th>Day Scholar/Hosteller</th>
                        <td><%= dayorhostel %></td>
                    </tr>
                </tbody>
            </table>
            <button class="btn btn-danger mt-3" onclick="closeDetails()">Close</button>
        </div>

        <script>
            function closeDetails() {
                document.getElementById('student-details').style.display = 'none';
                document.getElementById('registernumber').value = '';
            }
        </script>

        <%
                    } else {
                        out.println("<div class='alert alert-danger text-center'>Student with Register Number " + registernumber + " not found.</div>");
                    }
                } catch (SQLException e) {
                    out.println("<div class='alert alert-danger text-center'>Database Error: " + e.getMessage() + "</div>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                    if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            }
        %>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
