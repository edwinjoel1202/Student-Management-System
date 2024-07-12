<%-- 
    Document   : deleteClass
    Created on : 12-Jul-2024, 7:47:27 am
    Author     : edwin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="com.student.util.databaseConnection" %>
<%
    String classname = request.getParameter("classname");
    String inchargeId = request.getParameter("inchargeId");

    Connection conn = null;
    PreparedStatement ps = null;
    boolean success = false;
    String message = "Unknown error";

    try {
        conn = databaseConnection.getConnection();
        conn.setAutoCommit(false);
        
        // Delete from user_class_details table
        String deleteFromUserClassDetails = "DELETE FROM user_class_details WHERE classname = ?";
        ps = conn.prepareStatement(deleteFromUserClassDetails);
        ps.setString(1, classname);
        ps.executeUpdate();
        ps.close();
        
        // Delete from classes table
        String deleteFromClasses = "DELETE FROM classes WHERE classname = ?";
        ps = conn.prepareStatement(deleteFromClasses);
        ps.setString(1, classname);
        ps.executeUpdate();
        ps.close();
        
        // Update isClassIncharge field in incharges table
        String updateIncharge = "UPDATE incharges SET \"isClassIncharge\" = false WHERE id = ?";
        ps = conn.prepareStatement(updateIncharge);
        ps.setString(1, inchargeId);
        ps.executeUpdate();
        
        conn.commit();
        success = true;
        message = "Class deleted successfully";
    } catch (SQLException e) {
        if (conn != null) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        e.printStackTrace();
        message = "SQLException: " + e.getMessage();
    } catch (Exception e) {
        if (conn != null) {
            try {
                conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        e.printStackTrace();
        message = "Exception: " + e.getMessage();
    } finally {
        if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
    response.setContentType("application/json");
    response.getWriter().write("{\"success\":" + success + ", \"message\":\"" + message + "\"}");
%>



