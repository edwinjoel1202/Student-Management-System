<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Students</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/adminViewStudents.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">View Student Details</h1>
        <form method="post" action="adminViewStudents.jsp" class="row g-3 justify-content-center mb-4">
            <div class="col-md-6">
                <label for="registernumber" class="form-label">Enter Register Number</label>
                <input type="text" name="registernumber" class="form-control" id="registernumber" placeholder="Register Number" required>
            </div>
            <div class="col-4 text-center">
                <button type="submit" class="btn btn-primary">View Student</button>
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
                        String fname = rs.getString("fname").trim();
                        String lname = rs.getString("lname").trim();
                        String rollno = rs.getString("rollno").trim();
                        String email = rs.getString("email").trim();
                        String phone = rs.getString("phone").trim();
                        Date dob = rs.getDate("dob");
                        String address = rs.getString("address").trim();
                        String bloodgroup = rs.getString("bloodgroup").trim();
                        String dayorhostel = rs.getString("dayorhostel").trim();

                        String fathersname = "";
                        String mothersname = "";
                        float tenthmark = 0.0f;
                        float twelfthmark = 0.0f;

                        sql = "SELECT * FROM user_family_details WHERE rollno = ?";
                        ps = conn.prepareStatement(sql);
                        ps.setString(1, rollno);
                        rs = ps.executeQuery();
                        if (rs.next()) {
                            fathersname = rs.getString("fathersname").trim();
                            mothersname = rs.getString("mothersname").trim();
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
            <button class="btn btn-warning mt-3" id="edit-button">Edit Data</button>
        </div>

        <div id="edit-form" style="display: none;">
            <h2>Edit Student Details</h2>
            <form method="post" action="adminUpdateStudents.jsp" class="row g-3">
                <div class="col-md-6">
                    <label for="firstname" class="form-label">First Name</label>
                    <input type="text" name="firstname" class="form-control" id="firstname" value="<%= fname %>" required>
                </div>
                <div class="col-md-6">
                    <label for="lastname" class="form-label">Last Name</label>
                    <input type="text" name="lastname" class="form-control" id="lastname" value="<%= lname %>" required>
                </div>
                <div class="col-md-6">
                    <label for="rollno" class="form-label">Roll No</label>
                    <input type="text" name="rollno" class="form-control" id="rollno" value="<%= rollno %>" readonly>
                </div>
                <div class="col-md-6">
                    <label for="registernumber" class="form-label">Register Number</label>
                    <input type="text" name="registernumber" class="form-control" id="registernumber" value="<%= registernumber %>" readonly>
                </div>
                <div class="col-md-6">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" id="email" value="<%= email %>" required>
                </div>
                <div class="col-md-6">
                    <label for="phone" class="form-label">Phone Number</label>
                    <input type="tel" name="phone" class="form-control" id="phone" value="<%= phone %>" required>
                </div>
                <div class="col-md-6">
                    <label for="dob" class="form-label">Date of Birth</label>
                    <input type="date" name="dob" class="form-control" id="dob" value="<%= dob %>" required>
                </div>
                <div class="col-md-6">
                    <label for="address" class="form-label">Address</label>
                    <input type="text" name="address" class="form-control" id="address" value="<%= address %>" required>
                </div>
                <div class="col-md-6">
                    <label for="fathersname" class="form-label">Father's Name</label>
                    <input type="text" name="fathersname" class="form-control" id="fathersname" value="<%= fathersname %>" required>
                </div>
                <div class="col-md-6">
                    <label for="mothersname" class="form-label">Mother's Name</label>
                    <input type="text" name="mothersname" class="form-control" id="mothersname" value="<%= mothersname %>" required>
                </div>
                <div class="col-md-6">
                    <label for="tenthmark" class="form-label">10th Mark (%)</label>
                    <input type="number" step="0.01" name="tenthmark" class="form-control" id="tenthmark" value="<%= tenthmark %>" required>
                </div>
                <div class="col-md-6">
                    <label for="twelfthmark" class="form-label">12th Mark (%)</label>
                    <input type="number" step="0.01" name="twelfthmark" class="form-control" id="twelfthmark" value="<%= twelfthmark %>" required>
                </div>
                <div class="col-md-6">
                    <label for="bloodgroup" class="form-label">Blood Group</label>
                    <select name="bloodgroup" class="form-select" id="bloodgroup" required>
                        <option value="" disabled selected>Select</option>
                        <option value="A+" <%= bloodgroup.equals("A+") ? "selected" : "" %>>A+</option>
                        <option value="A-" <%= bloodgroup.equals("A-") ? "selected" : "" %>>A-</option>
                        <option value="B+" <%= bloodgroup.equals("B+") ? "selected" : "" %>>B+</option>
                        <option value="B-" <%= bloodgroup.equals("B-") ? "selected" : "" %>>B-</option>
                        <option value="AB+" <%= bloodgroup.equals("AB+") ? "selected" : "" %>>AB+</option>
                        <option value="AB-" <%= bloodgroup.equals("AB-") ? "selected" : "" %>>AB-</option>
                        <option value="O+" <%= bloodgroup.equals("O+") ? "selected" : "" %>>O+</option>
                        <option value="O-" <%= bloodgroup.equals("O-") ? "selected" : "" %>>O-</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label for="dayhosteller" class="form-label">Day Scholar/Hosteller</label>
                    <select name="dayhosteller" class="form-select" id="dayhosteller" required>
                        <option value="" disabled selected>Select</option>
                        <option value="day" <%= dayorhostel.equals("day") ? "selected" : "" %>>Day Scholar</option>
                        <option value="hosteller" <%= dayorhostel.equals("hosteller") ? "selected" : "" %>>Hosteller</option>
                    </select>
                </div>
                <div class="col-4 text-center">
                    <button type="submit" class="btn btn-success">Update Student</button>
                </div>
            </form>
        </div>

        <script>
            document.getElementById('edit-button').addEventListener('click', function() {
                document.getElementById('student-details').style.display = 'none';
                document.getElementById('edit-form').style.display = 'block';
            });
        </script>

        <%
                    } else {
                        out.println("<div class='alert alert-danger text-center'>No student found with the given register number.</div>");
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
