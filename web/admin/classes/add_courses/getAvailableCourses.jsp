<%-- 
    Document   : getAvailableCourses
    Created on : 12-Jul-2024, 7:22:38 pm
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
        String sql = "SELECT c.id, c.name, c.description, c.weeks, c.maximum_capacity " +
                     "FROM courses c " +
                     "LEFT JOIN class_courses cc ON c.id = cc.courseid AND cc.classname = ? " +
                     "WHERE cc.courseid IS NULL";
        ps = conn.prepareStatement(sql);
        ps.setString(1, classname);
        rs = ps.executeQuery();
        while (rs.next()) {
            String courseid = rs.getString("id");
            String name = rs.getString("name");
            String description = rs.getString("description");
            long weeks = rs.getLong("weeks");
            long maxCapacity = rs.getLong("maximum_capacity");
%>
<tr>
    <td><%= courseid %></td>
    <td><%= name %></td>
    <td><%= description %></td>
    <td><%= weeks %></td>
    <td><%= maxCapacity %></td>
    <td>
        <button class="btn btn-success" onclick="confirmAdd('<%= courseid %>', '<%= name %>')">
            <i class="bi bi-plus-lg"></i>
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

