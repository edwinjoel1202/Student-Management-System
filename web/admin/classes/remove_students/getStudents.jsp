<%-- 
    Document   : getStudents
    Created on : 12-Jul-2024, 8:11:15 am
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
        String sql = "SELECT up.regno, up.fname, up.lname, up.email " +
                     "FROM user_personal_details up " +
                     "INNER JOIN user_class_details uc ON up.regno = uc.regno " +
                     "WHERE uc.classname = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, classname);
        rs = ps.executeQuery();
        while (rs.next()) {
            String regno = rs.getString("regno");
            String fname = rs.getString("fname");
            String lname = rs.getString("lname");
            String email = rs.getString("email");
%>
<tr>
    <td><%= regno %></td>
    <td><%= fname %> <%= lname %></td>
    <td><%= email %></td>
    <td>
        <button class="btn btn-danger" onclick="confirmDelete('<%= regno %>', '<%= fname %> <%= lname %>')">
            <i class="bi bi-trash"></i>
        </button>
    </td>
</tr>
<%
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>



