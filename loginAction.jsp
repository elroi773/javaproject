<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page session="true" %> 

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/LOGIN.css">
    <title>LOGIN RESULT</title>
</head>
<body>
    <%
        String userID = request.getParameter("username");
        String userPassword = request.getParameter("password");

        if (userID == null || userPassword == null || userID.isEmpty() || userPassword.isEmpty()) {
            out.println("<h2>아이디와 비밀번호를 모두 입력해주세요.</h2>");
        } else {
            // 로그인 성공 처리
            session.setAttribute("userID", userID);  // 세션에 userID 저장
            out.println("<h2>로그인 성공!</h2>");
            response.sendRedirect("main.jsp");  // 로그인 후 main.jsp로 리디렉션
        }
    %>
</body>
</html>
