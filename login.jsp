<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/LOGIN.css">
    <title>LOGIN</title>
    <style>
    	/* login.css */

/* 전체 페이지 스타일 */
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

/* 로그인 컨테이너 */
.login-container {
    width: 100%;
    max-width: 400px;
    margin: 100px auto;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

/* 로그인 타이틀 */
.login-title {
    text-align: center;
    font-size: 24px;
    margin-bottom: 20px;
    color: #333;
}

/* 로그인 폼 */
.login-form {
    display: flex;
    flex-direction: column;
}

/* 입력 필드 */
.login-input {
    padding: 12px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 16px;
    width: 100%;
    box-sizing: border-box;
    color:#4CAF50;
}

/* 로그인 버튼 */
.login-button {
    padding: 12px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    font-size: 16px;
    cursor: pointer;
    width: 100%;
}

.login-button:hover {
    background-color: #45a049;
}

/* 에러 메시지 */
.error-message {
    color: red;
    text-align: center;
    font-size: 14px;
    display: none;
}

input{
	color:#4CAF50;
}
    	
    </style>
</head>
<body>
    <div class="login-container">
        <h1 class="login-title">대신 전해드립니다</h1>
        <form id="loginForm" class="login-form" action="loginAction.jsp" method="POST">
            <input type="text" id="username" name="username" placeholder="아이디" class="login-input">
            <input type="password" id="password" name="password" placeholder="비밀번호" class="login-input">
            <button type="submit" class="login-button">로그인</button>
            <p id="errorMessage" class="error-message" style="display: none;">아이디 또는 비밀번호를 확인하세요</p>
        </form>
    </div>
    <script src="js/LOGIN.js"></script>
</body>
</html>
