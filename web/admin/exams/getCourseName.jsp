<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<%
    String courseid = request.getParameter("courseid");

    if (courseid != null && !courseid.isEmpty()) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = databaseConnection.getConnection();
            String sql = "SELECT name FROM courses WHERE id = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, courseid);
            rs = ps.executeQuery();
            if (rs.next()) {
                String courseName = rs.getString("name");
                out.print(courseName);
            } else {
                out.print("Course name not found");
            }
        } catch (SQLException e) {
            out.print("Error: " + e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    } else {
        out.print("Invalid course ID");
    }
%>
