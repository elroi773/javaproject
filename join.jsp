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

        /* 기본 스타일 */
        body {
            font-family: 'GmarketSansMedium', sans-serif;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: rgb(229, 219, 151);
            background-color: #f3f3f3;
            overflow: hidden;
        }

        /* 상단 링크 (필요 시 HTML에 추가) */
        .top-link {
            position: absolute;
            top: 10px;
            left: 50%;
            transform: translateX(-50%);
            font-family: 'GmarketSansMedium', sans-serif;
            font-size: 1.2rem;
            color: #4cae4f;
            margin: 10px 0;
            z-index: 100;
            text-decoration: none;
        }

        /* 회원가입 컨테이너 */
        .signup-container {
            width: 300px;
            text-align: center;
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            animation: fadeIn 1.5s ease-in-out;
        }

        /* 회원가입 제목 */
        .signup-title {
            font-size: 2.5rem;
            color: #4cae4f;
            margin-bottom: 20px;
            letter-spacing: 0.1em;
            animation: glow 2s infinite alternate;
        }

        /* 입력 필드 */
        .signup-input {
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

        /* 버튼 */
        .signup-button {
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
            font-family: 'GmarketSansMedium', sans-serif;
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

        .signup-button:hover {
            background-color: #3e8e41;
        }

        /* 에러 메시지 */
        .error-message {
            color: #ff3333;
            font-size: 0.9rem;
            margin-top: 10px;
            font-family: 'GmarketSansMedium', sans-serif;
        }

        /* 애니메이션 */
        @keyframes glow {
            0% { text-shadow: 0 0 5px #4cae4f, 0 0 10px #4cae4f, 0 0 15px #4cae4f; }
            100% { text-shadow: 0 0 10px #4cae4f, 0 0 20px #4cae4f, 0 0 30px #4cae4f; }
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* 반응형 디자인 */
        @media (max-width: 600px) {
            .signup-container {
                width: 90%;
            }
        }@font-face {
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
            
            <!-- 이메일 인증 버튼 -->
            <button type="button" class="signup-button" onclick="redirectToVerification()">이메일 인증</button>
            
            <!-- 가입하기 버튼 -->
            <button type="submit" class="signup-button">가입하기</button>
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
        window.onload = function() {
            if (sessionStorage.getItem('userID') && sessionStorage.getItem('userPassword') && sessionStorage.getItem('userSchool') && sessionStorage.getItem('userEmail')) {
                // 세션에 저장된 정보를 폼에 채워넣기
                document.getElementById('userID').value = sessionStorage.getItem('userID');
                document.getElementById('userPassword').value = sessionStorage.getItem('userPassword');
                document.getElementById('userSchool').value = sessionStorage.getItem('userSchool');
                document.getElementById('userEmail').value = sessionStorage.getItem('userEmail');
            }
        };
    </script>
</body>
</html>
