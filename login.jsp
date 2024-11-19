<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/LOGIN.css">
<title>LOGIN</title>
<link rel="stylesheet" href="css/LOGIN.css">

</head>
<body>
	<div class="login-container">
        <h1 class="login-title">대신 전해드립니다</h1>
        <form id="loginForm" class="login-form" action="loginAction.jsp" method="POST">
           <input type="text" id="username" name="username" placeholder="아이디" class="login-input">
			<input type="password" id="password" name="password" placeholder="비밀번호" class="login-input">
            <button type="button" onclick="submitLogin()" class="login-button">로그인</button>
            <p id="errorMessage" class="error-message" style="display: none;">아이디 또는 비밀번호를 확인하세요</p>
        </form>
    </div>
    <script src="js/LOGIN.js"></script>
</body>
</html>
