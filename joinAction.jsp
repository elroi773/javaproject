<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>

<%
    String userID = request.getParameter("userID");
    String userPassword = request.getParameter("userPassword");
    String userSchool = request.getParameter("userSchool");
    String userEmail = request.getParameter("userEmail");

    // 입력값이 비어 있으면 처리
    if (userID == null || userID.trim().isEmpty() || 
        userPassword == null || userPassword.trim().isEmpty() ||
        userSchool == null || userSchool.trim().isEmpty() ||
        userEmail == null || userEmail.trim().isEmpty()) {
        out.println("<script>alert('모든 필드를 입력해야 합니다.'); history.back();</script>");
        return;
    }

    // 데이터베이스 연결
    Connection conn = null;
    PreparedStatement pstmt = null;
    String sql = "INSERT INTO users (userID, userPassword, userSchool, userEmail) VALUES (?, ?, ?, ?)";

    try {
        // MySQL 드라이버 로드 및 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs", "root", "Mysql4344!");

        // SQL 실행
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userID);
        pstmt.setString(2, userPassword);
        pstmt.setString(3, userSchool);
        pstmt.setString(4, userEmail);

        int result = pstmt.executeUpdate();

        if (result > 0) {
            response.sendRedirect("login.jsp");
        } else {
            out.println("<script>alert('회원가입 실패! 다시 시도해주세요.'); history.back();</script>");
        }
    } catch (Exception e) {
    	e.printStackTrace();
        out.println("<script>alert('오류가 발생했습니다. 관리자에게 문의하세요.'); history.back();</script>");
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
