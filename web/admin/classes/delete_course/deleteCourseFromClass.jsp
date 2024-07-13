<%-- 
    Document   : deleteCourseFromClass
    Created on : 13-Jul-2024, 10:29:33 am
    Author     : edwin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<%
    String courseid = request.getParameter("courseid");
    String classname = request.getParameter("classname");

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        conn = databaseConnection.getConnection();
        String sql = "DELETE FROM class_courses WHERE courseid = ? AND classname = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, courseid);
        ps.setString(2, classname);
        ps.executeUpdate();

        response.setContentType("text/plain");
        response.getWriter().write("success");
    } catch (SQLException e) {
        e.printStackTrace();
        response.setContentType("text/plain");
        response.getWriter().write("error");
    } finally {
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>

