<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<%
    String coursecode = request.getParameter("coursecode");
    String name = request.getParameter("coursename");
    String description = request.getParameter("description");
    String weeksStr = request.getParameter("weeks");
    String maximumCapacityStr = request.getParameter("maximum_capacity");

    // Convert weeks and maximum_capacity to long (bigint)
    long weeks = Long.parseLong(weeksStr);
    long maximumCapacity = Long.parseLong(maximumCapacityStr);

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        conn = databaseConnection.getConnection();
  
        // Update courses table
        String sql = "UPDATE courses SET name=?, description=?, weeks=?, maximum_capacity=? WHERE id=?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, name);
        ps.setString(2, description);
        ps.setLong(3, weeks); // Set weeks as long (bigint)
        ps.setLong(4, maximumCapacity); // Set maximum_capacity as long (bigint)
        ps.setString(5, coursecode);
        int query4 = ps.executeUpdate();

        // Check if all updates were successful
        if (query4 > 0) {
            %>
        <script>
            alert('Update successful!');
            window.location.href = 'adminViewCourses.jsp';
        </script>
        <%
        } else {
            out.println("<div class='alert alert-danger text-center'>Error in updating course details.</div>");
        }
    } catch (SQLException e) {
        out.println("<div class='alert alert-danger text-center'>Database Error: " + e.getMessage() + "</div>");
    } catch (NumberFormatException e) {
        out.println("<div class='alert alert-danger text-center'>Invalid number format for weeks or maximum capacity.</div>");
    } finally {
        if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
