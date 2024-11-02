<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, user.User, user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/LOGIN.css">
    <title>JOIN ACTION</title>
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
		    /*background: linear-gradient(135deg, #4cae4f, #2e7633); /* 녹색 그라데이션 */
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
		    height: 500px;
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
		
		/* 글로우 애니메이션 */
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
		
		/* 입력 필드 포커스 시 효과 */
		.signup-input:focus {
		    background: rgba(255, 255, 255, 0.2);
		    box-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
		}
		
		/* 버튼 스타일 */
		.signup-button {
		    font-family: 'GmarketSansMedium';
		    box-shadow: 30%;
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
		
		/* 버튼 네온 효과 */
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
		
		.check_email_button{
		    font-family: 'GmarketSansMedium';
		    background-color: #4cae4f;
		    color: white;
		    border-radius: 10%;
		    size: 30px;
		}
    </style>
</head>
<body>
	<div class="signup-container">
        <h1 class="signup-title">회원가입</h1>
        <form id="signupForm" class="signup-form">
            <input type="text" id="username" placeholder="아이디" class="signup-input">
            <input type="password" id="password" placeholder="비밀번호" class="signup-input">
            <input type="password" id="confirmPassword" placeholder="비밀번호 확인" class="signup-input">
            <input type="text" id="userschool" placeholder="학교" class="signup-input">
            <input type="email" id="email" placeholder="이메일" class="signup-input">
            <div class = "email_check">
                <input type = "email_check" id = "email_check" placeholder="인증번호" class = "signup-input">
                <button class = "check_email_button">인증번호 확인</button>
            </div>
            <button type="button" onclick="submitSignup()" class="signup-button">가입하기</button>
            <p id="errorMessage" class="error-message" style="display: none;">모든 필드를 채우고 비밀번호를 확인하세요</p>
        </form>
     </div>   
   <%
        String verificationCode = ""; // verificationCode 변수를 미리 선언하여 초기화합니다.
        try {
            String userID = request.getParameter("userID");
            String userPassword = request.getParameter("userPassword");
            String userName = request.getParameter("userName");
            String userGender = request.getParameter("userGender");
            String userEmail = request.getParameter("userEmail");
            String userSchool = request.getParameter("userschool");

            // 인증번호 생성 및 세션에 저장
            verificationCode = String.valueOf((int)(Math.random() * 9000) + 1000); // 1000~9999 사이의 랜덤 숫자
            session.setAttribute("verificationCode", verificationCode);

        } catch (Exception e) {
            e.printStackTrace(); // out을 제거하고 단순히 e.printStackTrace() 사용
        }
   %>

    <script>
        const userEmail = "<%= request.getParameter("userEmail") %>"; // JSP에서 JavaScript로 이메일 주소 전달
        const userName = "<%= request.getParameter("userName") %>"; // 사용자 이름도 전달
        const verificationCode = "<%= verificationCode %>"; // 인증번호 전달

        // EmailJS를 사용하여 이메일 발송
        var data = {
            service_id: 'YOUR_SERVICE_ID',
            template_id: 'YOUR_TEMPLATE_ID',
            user_id: 'YOUR_PUBLIC_KEY',
            template_params: {
                'to_email': userEmail,
                'to_name': userName,
                'message': '안녕하세요, ' + userName + '님! 이메일 인증번호는 ' + verificationCode + '입니다.'
            }
        };
         
        $.ajax('https://api.emailjs.com/api/v1.0/email/send', {
            type: 'POST',
            data: JSON.stringify(data),
            contentType: 'application/json'
        }).done(function() {
            alert('이메일이 발송되었습니다!');
        }).fail(function(error) {
            alert('오류가 발생했습니다: ' + JSON.stringify(error));
        });
    </script>
</body>
</html>
