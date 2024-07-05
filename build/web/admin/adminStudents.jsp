<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin - Students Section</title>
        <link rel="stylesheet" href="../css/admin/adminStudents.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <h1>Students Management</h1>
            <div class="actions">
                <a href="adminStudents.jsp?action=add" class="action-btn">Add New Student</a>
                <a href="adminStudents.jsp?action=view" class="action-btn">View/Edit Students</a>
                <a href="adminStudents.jsp?action=enroll" class="action-btn">Enroll Students in Courses</a>
                <a href="adminStudents.jsp?action=delete" class="action-btn">Delete Students</a>
                <a href="adminStudents.jsp?action=search" class="action-btn">Search Students</a>
            </div>
            <div class="content">
                <%
                    String action = request.getParameter("action");
                    if (action == null) action = "";

                    switch (action) {
                        case "add":
                %>
                <h2>Add New Student</h2>
                <form action="adminStudents.jsp?action=addStudent" method="POST" class="student-form">
                    <input type="text" name="name" placeholder="Full Name" required>
                    <input type="text" name="username" placeholder="Username" required>
                    <input type="password" name="password" placeholder="Password" required>
                    <input type="email" name="email" placeholder="Email" required>
                    <input type="tel" name="phone" placeholder="Phone Number" required>
                    <button type="submit">Add Student</button>
                </form>
                <%
                    break;
                    case "view":
                %>
                <h2>View/Edit Students</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Phone Number</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // Fetch and display student data from the database
                            try {
                                Connection con = databaseConnection.getConnection();
                                Statement stmt = con.createStatement();
                                ResultSet rs = stmt.executeQuery("SELECT * FROM user_details");
                                while (rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("username") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("phone") %></td>
                            <td>
                                <a href="edit-student.jsp?id=<%= rs.getInt("id") %>">Edit</a>
                                <a href="adminStudents.jsp?action=deleteStudent&id=<%= rs.getInt("id") %>">Delete</a>
                            </td>
                        </tr>
                        <%
                                }
                                rs.close();
                                stmt.close();
                                con.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        %>
                    </tbody>
                </table>
                <%
                    break;
                    case "enroll":
                %>
                <h2>Enroll Students in Courses</h2>
                <form action="adminStudents.jsp?action=enrollStudent" method="POST" class="student-form">
                    <input type="text" name="studentId" placeholder="Student ID" required>
                    <input type="text" name="courseId" placeholder="Course ID" required>
                    <button type="submit">Enroll</button>
                </form>
                <%
                    break;
                    case "delete":
                %>
                <h2>Delete Students</h2>
                <form action="adminStudents.jsp?action=deleteStudent" method="POST" class="student-form">
                    <input type="text" name="studentId" placeholder="Student ID" required>
                    <button type="submit">Delete</button>
                </form>
                <%
                    break;
                    case "search":
                %>
                <h2>Search Students</h2>
                <form action="adminStudents.jsp?action=searchStudent" method="POST" class="student-form">
                    <input type="text" name="searchQuery" placeholder="Enter name, username, or email" required>
                    <button type="submit">Search</button>
                </form>
                <div id="searchResults">
                    <%
                        String searchQuery = request.getParameter("searchQuery");
                        if (searchQuery != null && !searchQuery.isEmpty()) {
                            try {
                                Connection con = databaseConnection.getConnection();
                                String sql = "SELECT * FROM user_details WHERE name ILIKE ? OR username ILIKE ? OR email ILIKE ?";
                                PreparedStatement ps = con.prepareStatement(sql);
                                ps.setString(1, "%" + searchQuery + "%");
                                ps.setString(2, "%" + searchQuery + "%");
                                ps.setString(3, "%" + searchQuery + "%");
                                ResultSet rs = ps.executeQuery();
                                while (rs.next()) {
                    %>
                    <p><%= rs.getString("name") %> - <%= rs.getString("username") %> - <%= rs.getString("email") %></p>
                    <%
                                }
                                rs.close();
                                ps.close();
                                con.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </div>
                <%
                    break;
                    case "addStudent":
                        // Code to add student to the database
                        String name = request.getParameter("name");
                        String username = request.getParameter("username");
                        String password = request.getParameter("password");
                        String email = request.getParameter("email");
                        String phone = request.getParameter("phone");

                        try {
                            Connection con = databaseConnection.getConnection();
                            String sql = "INSERT INTO user_details (name, username, password, email, phone) VALUES(?, ?, ?, ?, ?)";
                            PreparedStatement ps = con.prepareStatement(sql);
                            ps.setString(1, name);
                            ps.setString(2, username);
                            ps.setString(3, password);
                            ps.setString(4, email);
                            ps.setString(5, phone);

                            int rowAffected = ps.executeUpdate();

                            if (rowAffected > 0) {
                                out.println("<script>alert('Registration Successful!');</script>");
                            } else {
                                out.println("<script>alert('Registration Failed!');</script>");
                            }

                            ps.close();
                            con.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        break;
                    case "enrollStudent":
                        // Code to enroll student in a course
                        String studentId = request.getParameter("studentId");
                        String courseId = request.getParameter("courseId");

                        try {
                            Connection con = databaseConnection.getConnection();
                            String sql = "INSERT INTO course_enrollments (student_id, course_id) VALUES(?, ?)";
                            PreparedStatement ps = con.prepareStatement(sql);
                            ps.setInt(1, Integer.parseInt(studentId));
                            ps.setInt(2, Integer.parseInt(courseId));

                            int rowAffected = ps.executeUpdate();

                            if (rowAffected > 0) {
                                out.println("<script>alert('Enrollment Successful!');</script>");
                            } else {
                                out.println("<script>alert('Enrollment Failed!');</script>");
                            }

                            ps.close();
                            con.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        break;
                    case "deleteStudent":
                        // Code to delete student from the database
                        String delStudentId = request.getParameter("studentId");

                        try {
                            Connection con = databaseConnection.getConnection();
                            String sql = "DELETE FROM user_details WHERE id = ?";
                            PreparedStatement ps = con.prepareStatement(sql);
                            ps.setInt(1, Integer.parseInt(delStudentId));

                            int rowAffected = ps.executeUpdate();

                            if (rowAffected > 0) {
                                out.println("<script>alert('Deletion Successful!');</script>");
                            } else {
                                out.println("<script>alert('Deletion Failed!');</script>");
                            }

                            ps.close();
                            con.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                        break;
                    default:
                        // Default content or instructions
                        out.println("<p>Please select an action from the buttons above.</p>");
                        break;
                }
                %>
            </div>
        </div>
    </body>
</html>
