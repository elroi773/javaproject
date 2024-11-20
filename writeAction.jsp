<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 폼 데이터 받기
    String content = request.getParameter("content");
    String isAnonymous = request.getParameter("isAnonymous"); // 익명 여부
    String userID = request.getParameter("userID");

    // 익명 여부에 따른 userID 처리
    if ("yes".equals(isAnonymous)) {
        userID = "익명";
    }

    Connection conn = null;
    PreparedStatement stmt = null;

    if (content != null && !content.isEmpty() && userID != null) {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/bbs?characterEncoding=UTF-8&useUnicode=true";
            String dbUser = "root";
            String dbPass = "Mysql4344!";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            String insertSql = "INSERT INTO posts (userID, content, created_at) VALUES (?, ?, NOW())";
            stmt = conn.prepareStatement(insertSql);
            stmt.setString(1, userID);
            stmt.setString(2, content);
            stmt.executeUpdate();

            response.sendRedirect("main.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>게시글 작성 중 오류가 발생했습니다.</h3>");
        } finally {
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    } else {
        out.println("<h3>입력된 내용이 없습니다. 다시 시도해 주세요.</h3>");
    }
%>
