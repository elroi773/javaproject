<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    String postID = request.getParameter("postID");
    String content = request.getParameter("content");

    if (postID == null || content == null || postID.trim().isEmpty() || content.trim().isEmpty()) {
        response.sendRedirect("post.jsp?postID=" + postID + "&error=emptyComment");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        String dbURL = "jdbc:mysql://localhost:3306/bbs";
        String dbUser = "root";
        String dbPass = "Mysql4344!";
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // ✅ 서버 콘솔에서 확인 가능
        System.out.println("postID: " + postID + ", content: " + content);

        String sql = "INSERT INTO comments (post_id, content, created_at) VALUES (?, ?, NOW())";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(postID));
        pstmt.setString(2, content);
        pstmt.executeUpdate();

        response.sendRedirect("post.jsp?postID=" + postID);
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("post.jsp?postID=" + postID + "&error=dbError");
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
