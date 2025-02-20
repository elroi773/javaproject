<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>대신 전해드립니다 index</title>
	<style>
		@font-face {
		    font-family: 'GmarketSansMedium';
		    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		*{
		    font-family: 'GmarketSansMedium';
		}
		body {
		    margin: 0;
		    height: 100vh;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    font-family: 'Roboto', sans-serif;
		    color: white;
		    overflow: hidden;
		}
		
		/* 로그인 컨테이너 스타일 */
		.login-container {
		    text-align: center;
		    background: rgba(255, 255, 255, 0.1);
		    padding: 30px;
		    border-radius: 15px;
		    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
		    animation: fadeIn 1.5s ease-in-out;
		    width: 400px;
		    height: 450px;
		}
		
		/* 타이틀에 쌈뽕 스타일 적용 */
		.login-title {
		    font-size: 2.5rem;
		    color: #1b361b; /* 녹색 타이틀 */
		    letter-spacing: 0.1em;
		    margin-bottom: 20px;
		}
		
		.others{
		    margin-top: 20px;
		    gap: 5px;
		    color: #1b361b;
		}
		
		/* 글로우 애니메이션 */
		@keyframes glow {
		    0% { text-shadow: 0 0 5px #4cae4f, 0 0 10px #4cae4f, 0 0 15px #4cae4f; }
		    100% { text-shadow: 0 0 10px #4cae4f, 0 0 20px #4cae4f, 0 0 30px #4cae4f; }
		}
		
		/* 입력 필드 스타일 */
		.login-input {
		    width: 100%;
		    padding: 15px;
		    margin: 10px 0;
		    background: rgba(255, 255, 255, 0.1);
		    border: none;
		    border-radius: 10px;
		    color: white;
		    font-size: 1rem;
		    transition: all 0.3s ease;
		    outline: none;
		}
		
		/* 입력 필드 포커스 시 효과 */
		.login-input:focus {
		    background: rgba(255, 255, 255, 0.2);
		    box-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
		}
		
		/* 버튼 스타일 */
		.login-button {
		    width: 100%;
		    padding: 15px;
		    margin: 20px 0;
		    background-color: #4cae4f; /* 버튼에 녹색 사용 */
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
		.login-button::before {
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
		
		.login-button:hover::before {
		    opacity: 1;
		    top: 0;
		    left: 0;
		    transform: rotate(0deg);
		}
		
		/* 에러 메시지 스타일 */
		.error-message {
		    color: #ff3333;
		    font-size: 0.9rem;
		    margin-top: 10px;
		}
		
		/* 로그인 폼이 나타나는 애니메이션 */
		@keyframes fadeIn {
		    from { opacity: 0; transform: translateY(-20px); }
		    to { opacity: 1; transform: translateY(0); }
		}
		
		/* 모바일 대응 */
		@media (max-width: 600px) {
		    .login-container {
		        width: 90%;
		    }
		}
	</style>
</head>

<body>
    <div class="login-container">
        <h1 class="login-title">대신 전해드립니다</h1>
        <form id="loginForm" class="login-form">
            <input type="text" id="username" placeholder="아이디" class="login-input">
            <input type="password" id="password" placeholder="비밀번호" class="login-input">
            <button type="button" onclick="submitLogin()" class="login-button">로그인</button>
            <p id="errorMessage" class="error-message" style="display: none;">아이디 또는 비밀번호를 확인하세요</p>
        </form>
        <div class="others">
            <a href="대신전해드립니다회원가입수정.html">회원가입하러가기</a>
            <a href="대신전해드립니다index.html">아이디 찾기</a>
            <a href="대신전해드립니다index.html">비밀번호 찾기</a>
        </div>
    </div>
    <div class="title">
        <h1>대신전해드립니다</h1>
    </div>
    <script src="Login.js"></script>
</body>

</html>