<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이메일 인증</title>
    <script type="text/javascript"
        src="https://cdn.jsdelivr.net/npm/@emailjs/browser@3/dist/email.min.js">
    </script>
    <style>
        @font-face {
            font-family: 'GmarketSansMedium';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }
        body {
            font-family: 'GmarketSansMedium';
            background-color: #ffffff;
            color: rgb(229, 219, 151);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            text-align: center;
            font-family: 'GmarketSansMedium';
            background: rgba(255, 255, 255, 0.1);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            width: 300px;
            animation: fadeIn 1.5s ease-in-out;
        }
        h1, h2 {
            color: #4cae4f;
            margin-bottom: 20px;
        }
        input[type="text"], input[type="button"] {
            font-family: 'GmarketSansMedium';
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 10px;
            border: none;
            font-size: 1rem;
            outline: none;
            color: #4cae4f;
            background: rgba(255, 255, 255, 0.1);
            transition: background 0.3s ease;
        }
        input[type="text"]:focus {
            background: rgba(255, 255, 255, 0.2);
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
        }
        input[type="button"] {
            font-family: 'GmarketSansMedium';
            background-color: #4cae4f;
            color: white;
            cursor: pointer;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        input[type="button"]::before {
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
        input[type="button"]:hover::before {
            opacity: 1;
            top: 0;
            left: 0;
            transform: rotate(0deg);
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <h1>이메일 인증</h1>
    <div>
        <input id="email" placeholder="이메일"><br>
        <input id="name" placeholder="이름"><br>
        <input type="button" onclick="send();" value="메일 보내기"><br><br>
        
        <h2>인증번호 확인</h2>
        <input id="verificationCodeInput"><br>
        <input type="button" onclick="verify();" value="인증번호 확인">
    </div>
</body>
<script>
    emailjs.init("UygOBJObCFbHWOLzb");

    let verificationCode;  // 전역 변수로 인증번호를 저장

    function send() {
        let email = document.getElementById("email").value;
        let name = document.getElementById("name").value;

        // 6자리 랜덤 인증번호 생성 및 저장
        verificationCode = Math.floor(100000 + Math.random() * 900000);

        let params = {
            'email': email,
            'name': name,
            'content': verificationCode // 인증번호를 content로 보냄
        };

        emailjs.send("service_g6iu7xz", "template_003kqyx", params)
            .then(response => {
                console.log("메일 전송 성공", response.status, response.text);
                alert("인증번호가 이메일로 전송되었습니다.");
            })
            .catch(error => {
                console.log("메일 전송 실패", error);
            });
    }

    function verify() {
        // 사용자가 입력한 인증번호
        let userCode = document.getElementById("verificationCodeInput").value;

        // 입력된 인증번호와 생성된 인증번호 비교
        if (userCode == verificationCode) {
            alert("인증 성공!");
            window.location.href = "join.jsp"; // 인증 성공 시 join.jsp로 이동
        } else {
            alert("인증 실패. 인증번호가 일치하지 않습니다.");
        }
    }
</script>
</html>