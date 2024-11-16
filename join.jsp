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
        <form id="signupForm" class="signup-form" action="email.jsp" method="get" onsubmit="saveInputs()">
            <input type="text" id="username" placeholder="아이디" class="signup-input">
            <input type="password" id="password" placeholder="비밀번호" class="signup-input">
            <input type="password" id="confirmPassword" placeholder="비밀번호 확인" class="signup-input">
            <input type="text" id="userschool" placeholder="학교" class="signup-input">
            <input type="email" id="email" placeholder="이메일" class="signup-input">
            <button type="submit" class="signup-button">이메일 인증하러 가기</button>
            <button type="button" onclick="submitSignup()" class="signup-button">가입하기</button>
            <p id="errorMessage" class="error-message" style="display: none;">모든 필드를 채워주세요</p>
        </form>
    </div>
    
    <script>
        // 입력된 데이터 저장 함수
        function saveInputs() {
            localStorage.setItem('username', document.getElementById('username').value);
            localStorage.setItem('password', document.getElementById('password').value);
            localStorage.setItem('confirmPassword', document.getElementById('confirmPassword').value);
            localStorage.setItem('userschool', document.getElementById('userschool').value);
            localStorage.setItem('email', document.getElementById('email').value);
        }

        // 페이지 로드 시 데이터 복원 함수
        function loadInputs() {
            document.getElementById('username').value = localStorage.getItem('username') || '';
            document.getElementById('password').value = localStorage.getItem('password') || '';
            document.getElementById('confirmPassword').value = localStorage.getItem('confirmPassword') || '';
            document.getElementById('userschool').value = localStorage.getItem('userschool') || '';
            document.getElementById('email').value = localStorage.getItem('email') || '';
        }

        // 회원가입 유효성 검사 함수
        function submitSignup() {
            var username = document.getElementById('username').value.trim();
            var password = document.getElementById('password').value.trim();
            var confirmPassword = document.getElementById('confirmPassword').value.trim();
            var errorMessage = document.getElementById('errorMessage');

            if (username === "" || password === "" || confirmPassword === "" || password !== confirmPassword) {
                errorMessage.style.display = 'block';
                document.querySelector('.signup-container').classList.add('shake');
                setTimeout(() => {
                    document.querySelector('.signup-container').classList.remove('shake');
                }, 500);
            } else {
                errorMessage.style.display = 'none';
                alert('회원가입 성공!');
                localStorage.clear();  // 성공 후 데이터 삭제
            }
        }

        // 페이지 로드 시 데이터 복원
        window.onload = loadInputs;
    </script>
</body>
</html>