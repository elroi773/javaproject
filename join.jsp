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
            background-color: #f3f3f3;
        }
        .signup-container {
            width: 300px;
            text-align: center;
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        .signup-title {
            font-size: 2.5rem;
            color: #4cae4f;
            margin-bottom: 20px;
        }
        .signup-input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            background: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }
        .signup-button {
            width: 100%;
            padding: 10px;
            margin: 20px 0;
            background-color: #4cae4f;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            color: white;
            cursor: pointer;
        }
        .signup-button:hover {
            background-color: #3e8e41;
        }
        .error-message {
            color: red;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <h1 class="signup-title">회원가입</h1>
        <form id="signupForm" action="joinAction.jsp" method="post">
            <input type="text" id="userID" name="userID" placeholder="아이디" class="signup-input" required>
            <input type="password" id="userPassword" name="userPassword" placeholder="비밀번호" class="signup-input" required>
            <input type="text" id="userSchool" name="userSchool" placeholder="학교" class="signup-input" required>
            <input type="email" id="userEmail" name="userEmail" placeholder="이메일" class="signup-input" required>
            <p id="errorMessage" class="error-message" style="display: none;">올바른 이메일 주소를 입력해주세요.</p>
            <button type="button" class="signup-button" onclick="redirectToVerification()">가입하기</button>
        </form>
    </div>

    <script>
        function redirectToVerification() {
            // 이메일을 임시 저장할 수 있도록 sessionStorage에 저장
            let userID = document.getElementById('userID').value;
            let userPassword = document.getElementById('userPassword').value;
            let userSchool = document.getElementById('userSchool').value;
            let userEmail = document.getElementById('userEmail').value;
            
            sessionStorage.setItem('userID', userID);
            sessionStorage.setItem('userPassword', userPassword);
            sessionStorage.setItem('userSchool', userSchool);
            sessionStorage.setItem('userEmail', userEmail);

            // 이메일 인증 페이지로 이동
            window.location.href = 'email.jsp'; // 실제 이메일 인증 페이지 URL로 변경
        }

        // 인증 완료 후 페이지 복귀
        function completeRegistration() {
            let userID = sessionStorage.getItem('userID');
            let userPassword = sessionStorage.getItem('userPassword');
            let userSchool = sessionStorage.getItem('userSchool');
            let userEmail = sessionStorage.getItem('userEmail');

            // 사용자가 인증을 완료하고 나면 회원가입 폼에 다시 채우고 제출
            document.getElementById('userID').value = userID;
            document.getElementById('userPassword').value = userPassword;
            document.getElementById('userSchool').value = userSchool;
            document.getElementById('userEmail').value = userEmail;

            // 예시: 자동으로 제출하도록 할 수도 있습니다.
            // document.getElementById('signupForm').submit();
        }
    </script>
</body>
</html>
