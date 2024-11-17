<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <style>
        @font-face {
            font-family: 'GmarketSansMedium';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }
        body {
            font-family: 'GmarketSansMedium';
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: rgb(229, 219, 151);
            overflow: hidden;
        }
        .top-link {
            position: absolute;
            top: 0;
            left: 50%;
            transform: translateX(-50%);
            font-family: 'GmarketSansMedium';
            font-size: 1.2rem;
            color: #4cae4f;
            margin: 10px 0;
            z-index: 100;
        }
        .signup-container {
            width: 300px;
            text-align: center;
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            animation: fadeIn 1.5s ease-in-out;
        }
        .signup-title {
            font-family: 'GmarketSansMedium';
            font-size: 2.5rem;
            color: #4cae4f;
            letter-spacing: 0.1em;
            margin-bottom: 20px;
        }
        @keyframes glow {
            0% { text-shadow: 0 0 5px #4cae4f, 0 0 10px #4cae4f, 0 0 15px #4cae4f; }
            100% { text-shadow: 0 0 10px #4cae4f, 0 0 20px #4cae4f, 0 0 30px #4cae4f; }
        }
        .signup-input {
            font-family: 'GmarketSansMedium';
            width: 100%;
            padding: 15px;
            margin: 10px 0;
            background: rgba(255, 255, 255, 0.1);
            border: none;
            border-radius: 10px;
            color: #4cae4f;
            font-size: 1rem;
            transition: all 0.3s ease;
            outline: none;
        }
        .signup-input:focus {
            background: rgba(255, 255, 255, 0.2);
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
        }
        .signup-button {
            font-family: 'GmarketSansMedium';
            width: 100%;
            padding: 15px;
            margin: 20px 0;
            background-color: #4cae4f;
            border: none;
            border-radius: 10px;
            font-size: 1.2rem;
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        .signup-button::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.5), transparent);
            transition: 0.5s;
            transform: rotate(45deg);
            opacity: 0;
        }
        .signup-button:hover::before {
            opacity: 1;
            top: 0;
            left: 0;
            transform: rotate(0deg);
        }
        .error-message {
            font-family: 'GmarketSansMedium';
            color: #ff3333;
            font-size: 0.9rem;
            margin-top: 10px;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @media (max-width: 600px) {
            .signup-container {
                width: 90%;
            }
        }
    </style>
</head>
<body>
     <div class="signup-container">
        <h1 class="signup-title">회원가입</h1>
        
		
		<form id="signupForm" class="signup-form" action="joinAction.jsp" method="post">
    <input type="text" id="userID" name="userID" placeholder="아이디" class="signup-input" required>
    <input type="password" id="userPassword" name="userPassword" placeholder="비밀번호" class="signup-input" required>
    <input type="text" id="userSchool" name="userSchool" placeholder="학교" class="signup-input" required>
    <input type="email" id="userEmail" name="userEmail" placeholder="이메일" class="signup-input" required>  

    <!-- 이메일 인증 버튼 -->
    <button type="button" class="signup-button" onclick="submitForm()">이메일 인증하러 가기</button>

    <!-- 가입하기 버튼 -->
    <button type="submit" class="signup-button" onclick="submitSignup()">가입하기</button>
    <p id="errorMessage" class="error-message" style="display: none;">모든 필드를 채워주세요</p>
</form>

<script>
    function saveInputs() {
        localStorage.setItem('userID', document.getElementById('userID').value);
        localStorage.setItem('userPassword', document.getElementById('userPassword').value);
        localStorage.setItem('userSchool', document.getElementById('userSchool').value);
        localStorage.setItem('userEmail', document.getElementById('userEmail').value);
    }
	console.log(userID);
    function submitForm() {
        // 폼을 'email.jsp'로 제출
        var form = document.getElementById('signupForm');
        form.action = 'email.jsp';
        saveInputs();
        form.submit();
    }

    function loadInputs() {
        document.getElementById('userID').value = localStorage.getItem('userID') || '';
        document.getElementById('userPassword').value = localStorage.getItem('userPassword') || '';
        document.getElementById('userSchool').value = localStorage.getItem('userSchool') || '';
        document.getElementById('userEmail').value = localStorage.getItem('userEmail') || '';
    }

    function submitSignup() {
        var userID = document.getElementById('userID').value.trim();
        var userPassword = document.getElementById('userPassword').value.trim();
        var errorMessage = document.getElementById('errorMessage');

        if (userID === "" || userPassword === "") {
            errorMessage.style.display = 'block';
        } else {
            errorMessage.style.display = 'none';
            alert('회원가입 성공!');
            localStorage.clear();
        }
    }

    window.onload = loadInputs;
</script>

</body>
</html>