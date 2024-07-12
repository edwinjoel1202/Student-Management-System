<%-- 
    Document   : addCourseToClass
    Created on : 12-Jul-2024, 7:23:07 pm
    Author     : edwin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<%
    String courseid = request.getParameter("courseid");
    String classname = request.getParameter("classname");
    String facultyid = request.getParameter("facultyid");
    String facultyname = request.getParameter("facultyname");

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        conn = databaseConnection.getConnection();
        String sql = "INSERT INTO class_courses (classname, courseid, facultyid, facultyname) VALUES (?, ?, ?, ?)";
        ps = conn.prepareStatement(sql);
        ps.setString(1, classname);
        ps.setString(2, courseid);
        ps.setString(3, facultyid);
        ps.setString(4, facultyname);
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>

