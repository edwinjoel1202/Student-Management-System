<%-- 
    Document   : deleteStudents
    Created on : 12-Jul-2024, 8:42:45 am
    Author     : edwin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<%
    String regno = request.getParameter("regno");
    String classname = request.getParameter("classname");
    Connection conn = null;
    PreparedStatement ps = null;

    try {
        conn = databaseConnection.getConnection();

        // Delete student from the user_class_details table
        String sql = "DELETE FROM user_class_details WHERE regno = ? AND classname = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, regno);
        ps.setString(2, classname);
        int rowsDeleted = ps.executeUpdate();
        ps.close();

        // Update number of students in the classes table
        sql = "UPDATE classes SET noofstudents = noofstudents - 1 WHERE classname = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, classname);
        ps.executeUpdate();
        ps.close();

        if (rowsDeleted > 0) {
            response.setStatus(200);
            out.print("Student deleted successfully");
        } else {
            response.setStatus(500);
            out.print("Failed to delete student");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.setStatus(500);
        out.print("Failed to delete student");
    } finally {
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>

