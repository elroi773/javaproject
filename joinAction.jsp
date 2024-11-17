<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<%
    // 사용자 입력값 가져오기
    String userID = request.getParameter("userID");
    String userPassword = request.getParameter("userPassword");
    String userSchool = request.getParameter("userSchool");
    String userEmail = request.getParameter("userEmail");

    Connection conn = null;
    PreparedStatement pstmt = null;
    String sql = "INSERT INTO users (userID, userPassword, userSchool, userEmail) VALUES (?, ?, ?, ?)";

    try {
        // 데이터베이스 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourDatabase", "root", "Mysql4344!");

        // SQL 실행
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userID);
        pstmt.setString(2, userPassword);
        pstmt.setString(3, userSchool);
        pstmt.setString(4, userEmail);

        int result = pstmt.executeUpdate(); // INSERT 실행

        if (result > 0) {
            out.println("<script>alert('회원가입 성공!'); location.href='login.jsp';</script>");
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
