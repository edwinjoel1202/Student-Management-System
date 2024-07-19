<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<%
    String classname = request.getParameter("class");
    int numberOfStudents = 0;

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = databaseConnection.getConnection();
        String sql = "SELECT noofstudents FROM classes WHERE classname = ?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, classname);
        rs = ps.executeQuery();

        if (rs.next()) {
            numberOfStudents = rs.getInt("noofstudents");
        }
    } catch (SQLException e) {
        numberOfStudents = 0; // Handle the error gracefully
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }

    // Create a JSON response
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    out.print("{\"count\": " + numberOfStudents + "}");
    out.flush();
%>
