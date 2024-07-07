<%-- 
    Document   : adminAddStudents
    Created on : 05-Jul-2024, 12:34:00 pm
    Author     : edwin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<!DOCTYPE html>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Add New Student</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/admin/adminAddStudents.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h1 class="text-center mb-4">Add New Student</h1>
            <form method="POST" class="row g-3 justify-content-center">
                <div class="col-md-6">
                    <label for="firstname" class="form-label">First Name</label>
                    <input type="text" name="firstname" class="form-control" id="firstname" placeholder="First Name" required>
                </div>
                <div class="col-md-6">
                    <label for="lastname" class="form-label">Last Name</label>
                    <input type="text" name="lastname" class="form-control" id="lastname" placeholder="Last Name" required>
                </div>
                <div class="col-md-6">
                    <label for="rollno" class="form-label">Roll No</label>
                    <input type="text" name="rollno" class="form-control" id="rollno" placeholder="Roll No" required>
                </div>
                <div class="col-md-6">
                    <label for="registernumber" class="form-label">Register Number</label>
                    <input type="text" name="registernumber" class="form-control" id="registernumber" placeholder="Register Number" required>
                </div>
                <div class="col-md-6">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" id="email" placeholder="Email" required>
                </div>
                <div class="col-md-6">
                    <label for="phone" class="form-label">Phone Number</label>
                    <input type="tel" name="phone" class="form-control" id="phone" placeholder="Phone Number" required>
                </div>
                <div class="col-md-6">
                    <label for="dob" class="form-label">Date of Birth</label>
                    <input type="date" name="dob" class="form-control" id="dob" required>
                </div>
                <div class="col-md-6">
                    <label for="address" class="form-label">Address</label>
                    <input type="text" name="address" class="form-control" id="address" placeholder="Address" required>
                </div>
                <div class="col-md-6">
                    <label for="fathersname" class="form-label">Father's Name</label>
                    <input type="text" name="fathersname" class="form-control" id="fathersname" placeholder="Father's Name" required>
                </div>
                <div class="col-md-6">
                    <label for="mothersname" class="form-label">Mother's Name</label>
                    <input type="text" name="mothersname" class="form-control" id="mothersname" placeholder="Mother's Name" required>
                </div>
                <div class="col-md-6">
                    <label for="tenthmark" class="form-label">10th Mark (%)</label>
                    <input type="number" step="0.01" name="tenthmark" class="form-control" id="tenthmark" placeholder="10th Mark (%)" required>
                </div>
                <div class="col-md-6">
                    <label for="twelfthmark" class="form-label">12th Mark (%)</label>
                    <input type="number" step="0.01" name="twelfthmark" class="form-control" id="twelfthmark" placeholder="12th Mark (%)" required>
                </div>
                <div class="col-md-6">
                    <label for="bloodgroup" class="form-label">Blood Group</label>
                    <select name="bloodgroup" id="bloodgroup" class="form-select" required>
                        <option value="" selected disabled>Select Blood Group</option>
                        <option value="A+">A+</option>
                        <option value="A-">A-</option>
                        <option value="B+">B+</option>
                        <option value="B-">B-</option>
                        <option value="AB+">AB+</option>
                        <option value="AB-">AB-</option>
                        <option value="O+">O+</option>
                        <option value="O-">O-</option>
                    </select>
                </div>

                <div class="col-md-6">
                    <label for="dayhosteller" class="form-label">Day Scholar/Hosteller</label>
                    <select name="dayhosteller" class="form-select" id="dayhosteller" required>
                        <option value="" disabled selected>Select</option>
                        <option value="day">Day Scholar</option>
                        <option value="hosteller">Hosteller</option>
                    </select>
                </div>
                <div class="col-4 text-center">
                    <button type="submit" class="btn btn-success">Add Student</button>
                </div>
            </form>
        </div>
        <!-- Bootstrap JS and dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <%
        if("post".equalsIgnoreCase(request.getMethod())){
        
            Connection conn;
            PreparedStatement ps;
        
            String fname = request.getParameter("firstname");
            String lname = request.getParameter("lastname");
            String rollno = request.getParameter("rollno");
            String regno = request.getParameter("registernumber");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String dobStr = request.getParameter("dob");
            Date dob = Date.valueOf(dobStr);
            String address = request.getParameter("address");
            String fathersname = request.getParameter("fathersname");
            String mothersname = request.getParameter("mothersname");
            String tenthmark = request.getParameter("tenthmark");
            String twelfthmark = request.getParameter("twelfthmark");
            String bloodgroup = request.getParameter("bloodgroup");
            String dayorhostel = request.getParameter("dayhosteller");
            
            String user_personal_details_sql = "INSERT INTO user_personal_details (fname, lname, rollno, regno, email, phone, dob, address, bloodgroup, dayorhostel) "
            + "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            String user_family_details_sql = "INSERT INTO user_family_details (rollno, fathersname, mothersname) VALUES (?, ?, ?)";
            
            String user_school_details = "INSERT INTO user_school_details (rollno, tenthmark, twelfthmark) VALUES (?, ?, ?)";
            
            try{
                conn = databaseConnection.getConnection();
                ps = conn.prepareStatement(user_personal_details_sql);
                ps.setString(1, fname);
                ps.setString(2, lname);
                ps.setString(3, rollno);
                ps.setString(4, regno);
                ps.setString(5, email);
                ps.setString(6, phone);
                ps.setDate(7, dob);
                ps.setString(8, address);
                ps.setString(9, bloodgroup);
                ps.setString(10, dayorhostel);
                int query1 = ps.executeUpdate();
                
                ps = conn.prepareStatement(user_family_details_sql);
                ps.setString(1, rollno);
                ps.setString(2, fathersname);
                ps.setString(3, mothersname);
                int query2 = ps.executeUpdate();
                
                ps = conn.prepareStatement(user_school_details);
                ps.setString(1, rollno);
                ps.setString(2, tenthmark);
                ps.setString(3, twelfthmark);
                int query3 = ps.executeUpdate();
                
                if (query1 > 0 && query2 > 0 && query3 > 0) {
                    conn.close();
                    ps.close();
                    out.println("<script>alert('Student Added Successfully !')</script>");
        } else {
            out.println("<script>alert('Error occured !')</script>");
        }
                
            }catch (SQLException e) {
                    out.println("<div class='alert alert-danger' role='alert'>Database Error: " + e.getMessage() + "</div>");
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger' role='alert'>Error: " + e.getMessage() + "</div>");
                }
        }
    %>
    </body>
</html>

