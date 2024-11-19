<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.sql.*" %>
<%@ page session="true" %> 

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/LOGIN.css">
<title>LOGIN RESULT</title>
</head>
<body>
    <%
        String userID = request.getParameter("userID");
        String userPassword = request.getParameter("userPassword");

        if (userID == null || userPassword == null || userID.isEmpty() || userPassword.isEmpty()) {
            out.println("<h2>아이디와 비밀번호를 모두 입력해주세요.</h2>");
            return;
        }

        UserDAO userDAO = new UserDAO();
        int result = -2;
        try {
            result = userDAO.login(userID, userPassword);
        } catch (Exception e) {
            e.printStackTrace(); // 콘솔에 출력
            out.println("<h2>로그인 처리 중 오류가 발생했습니다. 관리자에게 문의하세요.</h2>");
            return;
        }

        if (result == 1) {
            session.setAttribute("userID", userID);
            response.sendRedirect("main.jsp");
            return;
        } else if (result == 0) {
            out.println("<h2>비밀번호가 틀렸습니다.</h2>");
        } else if (result == -1) {
            out.println("<h2>존재하지 않는 아이디입니다.</h2>");
        } else {
            out.println("<h2>로그인 중 오류가 발생했습니다. 다시 시도해 주세요.</h2>");
        }
    %>
</body>
</html>
