<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    String postID = request.getParameter("postID");
    String content = request.getParameter("content");

    if (postID == null || content == null || postID.isEmpty() || content.isEmpty()) {
        out.println("<script>alert('댓글 내용을 입력하세요.'); history.back();</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // ✅ MySQL 접속 정보 확인
        String dbURL = "jdbc:mysql://localhost:3306/bbs";
        String dbUser = "root";
        String dbPass = "Mysql4344!";
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // ✅ SQL 실행 전 로그 출력 (디버깅용)
        out.println("<script>console.log('postID: " + postID + ", content: " + content + "');</script>");

        String sql = "INSERT INTO comments (post_id, content, created_at) VALUES (?, ?, NOW())";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(postID));
        pstmt.setString(2, content);
        pstmt.executeUpdate();

        // ✅ 리디렉트 전 로그 출력 (디버깅용)
        out.println("<script>console.log('Redirecting to post.jsp?postID=" + postID + "');</script>");

        response.sendRedirect("post.jsp?postID=" + postID);
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('댓글 작성 중 오류 발생: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
