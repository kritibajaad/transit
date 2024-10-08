<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDateTime"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%
    String sortCriteria = request.getParameter("sortCriteria");

    ApplicationDB db = new ApplicationDB();
    Connection con = null;
    PreparedStatement pstm = null;
    ResultSet rs = null;

    try {
        con = db.getConnection();
        String sortSQL = "SELECT * FROM SearchResults ORDER BY " + sortCriteria;
        pstm = con.prepareStatement(sortSQL);
        rs = pstm.executeQuery();
        while (rs.next()) {
            String ScheduleTid = rs.getString("ScheduleTid");
            String TrainTid = rs.getString("TrainTid");
            String Linename = rs.getString("Linename");
            String OSid = rs.getString("OSid");
            Timestamp Otime = rs.getTimestamp("Otime");
            String DSid = rs.getString("DSid");
            Timestamp Dtime = rs.getTimestamp("Dtime");
            int Fare = rs.getInt("Fare");
            boolean isPast = LocalDateTime.now().isAfter(Otime.toLocalDateTime());
%>
        <div class="book" id="book<%=ScheduleTid%>" onclick="fetchScheduleDetails('<%=ScheduleTid%>')" style="<%= isPast ? "display: none;" : "" %>">
            <span class="book-title"><%=ScheduleTid%> <%=TrainTid%> <%=Linename%> <%=OSid%> <%=Otime%> <%=DSid%> <%=Dtime%> Fare: <%=Fare%></span>
        </div>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (pstm != null) pstm.close(); } catch (Exception e) { e.printStackTrace(); }
        try { if (con != null) con.close(); } catch (Exception e) { e.printStackTrace(); }
    }
%>
