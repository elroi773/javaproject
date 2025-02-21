<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    int postID = Integer.parseInt(request.getParameter("postID"));

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        String dbURL = "jdbc:mysql://localhost:3306/bbs";
        String dbUser = "root";
        String dbPass = "Mysql4344!";
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // 게시글 정보 불러오기
        String sql = "SELECT * FROM posts WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, postID);
        rs = stmt.executeQuery();

        if (rs.next()) {
%>
            <h2><%= rs.getString("content") %></h2>
            <p>작성자: <%= rs.getString("userID") %></p>
            <p>작성일: <%= rs.getTimestamp("created_at") %></p>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); if (stmt != null) stmt.close(); if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<h3>댓글</h3>
<form action="addComment.jsp" method="post">
    <input type="hidden" name="postID" value="<%= postID %>">
    <input type="text" name="content" placeholder="댓글을 입력하세요..." required>
    <button type="submit">댓글 작성</button>
</form>

<%
    // 댓글 가져오기
    // 기존 코드 활용 가능
%>
