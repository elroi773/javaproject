<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    request.setCharacterEncoding("UTF-8");

    HttpSession session5 = request.getSession();
    String userID = (String) session5.getAttribute("userID");

    if (userID == null || userID.isEmpty()) {
%>
    <script>
        alert("로그인이 필요합니다.");
        location.href = "login.jsp";
    </script>
<%
        return;
    }

    int postID = Integer.parseInt(request.getParameter("postID"));
    String content = request.getParameter("content");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        String dbURL = "jdbc:mysql://localhost:3306/bbs";
        String dbUser = "root";
        String dbPass = "Mysql4344!";
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        String insertSql = "INSERT INTO comments (postID, userID, content) VALUES (?, ?, ?)";
        stmt = conn.prepareStatement(insertSql);
        stmt.setInt(1, postID);
        stmt.setString(2, userID);
        stmt.setString(3, content);

        int result = stmt.executeUpdate();

        if (result > 0) {
%>
            <script>
                alert("댓글이 등록되었습니다.");
                location.hr
