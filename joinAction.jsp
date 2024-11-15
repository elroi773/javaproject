<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpSession" %>

<%@ page import="java.io.*, java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 처리</title>
</head>
<body>
    <% 
        // 폼에서 넘어온 데이터 가져오기
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String userSchool = request.getParameter("userSchool");

        // 비밀번호 확인
        if (password == null || !password.equals(confirmPassword)) {
            out.println("<p style='color: red;'>비밀번호가 일치하지 않습니다.</p>");
        } else {
            // 데이터베이스에 회원정보 저장하는 코드 (예시)
            try {
                // JDBC 연결 설정 (MySQL 예시)
                String dbUrl = "jdbc:mysql://localhost:3306/your_database";
                String dbUsername = "root";  // DB 사용자명
                String dbPassword = "your_password";  // DB 비밀번호
                Connection conn = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);

                // SQL 쿼리 실행
                String sql = "INSERT INTO users (username, password, user_school) VALUES (?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                pstmt.setString(2, password);
                pstmt.setString(3, userSchool);

                int result = pstmt.executeUpdate();  // 데이터베이스에 삽입

                if (result > 0) {
                    out.println("<p>회원가입 성공!</p>");
                    response.sendRedirect("login.jsp");  // 회원가입 후 로그인 페이지로 이동
                } else {
                    out.println("<p style='color: red;'>회원가입 실패! 다시 시도해 주세요.</p>");
                }

                pstmt.close();
                conn.close();

            } catch (Exception e) {
                out.println("<p style='color: red;'>오류가 발생했습니다. 관리자에게 문의하세요.</p>");
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
