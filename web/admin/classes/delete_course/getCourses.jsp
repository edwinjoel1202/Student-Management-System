<%-- 
    Document   : getCourses
    Created on : 13-Jul-2024, 10:29:12 am
    Author     : edwin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>

<%
    String classname = request.getParameter("classname");
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = databaseConnection.getConnection();
        String sql = "SELECT cc.courseid, c.name AS coursename, cc.facultyid, cc.facultyname " +
                     "FROM class_courses cc " +
                     "JOIN courses c ON cc.courseid = c.id " +
                     "WHERE cc.classname = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, classname);
        rs = ps.executeQuery();
%>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Course ID</th>
                    <th>Course Name</th>
                    <th>Faculty ID</th>
                    <th>Faculty Name</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (rs.next()) {
                        String courseid = rs.getString("courseid");
                        String coursename = rs.getString("coursename");
                        String facultyid = rs.getString("facultyid");
                        String facultyname = rs.getString("facultyname");
                %>
                    <tr>
                        <td><%= courseid %></td>
                        <td><%= coursename %></td>
                        <td><%= facultyid %></td>
                        <td><%= facultyname %></td>
                        <td>
                            <button type="button" class="btn btn-danger delete-course-btn" data-courseid="<%= courseid %>" data-coursename="<%= coursename %>">
                                <i class="bi bi-trash"></i>
                            </button>
                        </td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
<%
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>

