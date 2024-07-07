<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.student.util.databaseConnection"%>
<%
    String rollno = request.getParameter("rollno");
    String fname = request.getParameter("firstname");
    String lname = request.getParameter("lastname");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String dob = request.getParameter("dob");
    String address = request.getParameter("address");
    String fathersname = request.getParameter("fathersname");
    String mothersname = request.getParameter("mothersname");
    String tenthmark = request.getParameter("tenthmark");
    String twelfthmark = request.getParameter("twelfthmark");
    String bloodgroup = request.getParameter("bloodgroup");
    String dayhosteller = request.getParameter("dayhosteller");

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        conn = databaseConnection.getConnection();
        
        String sql = "UPDATE user_personal_details SET fname=?, lname=?, email=?, phone=?, dob=?, address=?, bloodgroup=?, dayorhostel=? WHERE rollno=?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, fname);
        ps.setString(2, lname);
        ps.setString(3, email);
        ps.setString(4, phone);
        ps.setDate(5, Date.valueOf(dob));
        ps.setString(6, address);
        ps.setString(7, bloodgroup);
        ps.setString(8, dayhosteller);
        ps.setString(9, rollno);
        int query1 = ps.executeUpdate();

        sql = "UPDATE user_family_details SET fathersname=?, mothersname=? WHERE rollno=?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, fathersname);
        ps.setString(2, mothersname);
        ps.setString(3, rollno);
        int query2 = ps.executeUpdate();

        sql = "UPDATE user_school_details SET tenthmark=?, twelfthmark=? WHERE rollno=?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, tenthmark);
        ps.setString(2, twelfthmark);
        ps.setString(3, rollno);
        int query3 = ps.executeUpdate();

        if (query1 > 0 && query2 > 0 && query3 > 0) {
            %>
        <script>
            alert('Update successful!');
            window.location.href = 'adminViewStudents.jsp';
        </script>
        <%
        } else {
            out.println("<div class='alert alert-danger text-center'>Error in updating student details.</div>");
        }
    } catch (SQLException e) {
        out.println("<div class='alert alert-danger text-center'>Database Error: " + e.getMessage() + "</div>");
    } finally {
        if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
