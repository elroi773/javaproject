<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/LOGIN.css">
    <title>Logout</title>
</head>
<body>
    <%
        // 현재 세션 무효화
        HttpSession session5 = request.getSession(false); // 기존 세션 가져오기
        if (session != null) {
            session.invalidate(); // 세션 무효화
        }

        // 리다이렉트 처리
        response.sendRedirect("login.jsp");
    %>
</body>
</html>
