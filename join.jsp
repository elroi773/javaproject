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
            <button type="submit" class="signup-button">이메일 인증</button>
        </form>
    </div>

    <script>
    
	    let isEmailVerified = false; // 이메일 인증 여부
	
	    function verifyEmail() {
	        // 인증 로직 성공 시 호출
	        isEmailVerified = true;
	        alert("이메일 인증에 성공했습니다!");
	    }
	
	    document.getElementById('signupForm').addEventListener('submit', function (event) {
	        if (!isEmailVerified) {
	            event.preventDefault();
	            alert("이메일 인증을 완료해주세요.");
	        }
	    });
</script>

        });
    </script>
</body>
</html>
