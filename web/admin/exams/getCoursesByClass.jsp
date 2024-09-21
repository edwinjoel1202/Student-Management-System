<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, com.student.util.databaseConnection"%>
<%
    String className = request.getParameter("classname");
    if (className != null && !className.isEmpty()) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = databaseConnection.getConnection();
            String sql = "SELECT c.id, c.name FROM courses c JOIN class_courses cc ON c.id = cc.courseid WHERE cc.classname = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, className);
            rs = ps.executeQuery();
            
            StringBuilder json = new StringBuilder("[");
            boolean first = true;
            while (rs.next()) {
                if (!first) {
                    json.append(",");
                }
                json.append("{");
                json.append("\"id\":\"").append(rs.getString("id")).append("\",");
                json.append("\"name\":\"").append(rs.getString("name")).append("\"");
                json.append("}");
                first = false;
            }
            json.append("]");
            
            response.getWriter().write(json.toString());
        } catch (SQLException e) {
            response.getWriter().write("[]");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    } else {
        response.getWriter().write("[]");
    }
%>
