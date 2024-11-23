<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="email.EmailSender" %>
<%@ page import="email.VerifyCode" %>

<%
    String userEmail = request.getParameter("userEmail");
    String enteredCode = request.getParameter("enteredCode");
    String resend = request.getParameter("resend");

    // 세션에 저장된 이메일 상태 확인
    String verificationCode = (String) session.getAttribute("verificationCode");
    Long codeGeneratedTime = (Long) session.getAttribute("codeGeneratedTime");

    // 인증번호 유효시간 설정 (5분)
    long VALIDITY_PERIOD = 5 * 60 * 1000;

    if ("true".equals(resend) || (verificationCode == null) || (codeGeneratedTime == null) || 
        (System.currentTimeMillis() - codeGeneratedTime > VALIDITY_PERIOD)) {
        try {
            // 새로운 인증번호 생성
            verificationCode = String.valueOf((int) (Math.random() * 900000) + 100000);


            // 이메일 발송
            String subject = "이메일 인증";
            String messageText = "인증 코드: " + verificationCode;
            EmailSender.sendEmail(userEmail, subject, messageText);

            // 세션에 인증번호와 생성 시간 저장
            session.setAttribute("verificationCode", verificationCode);
            session.setAttribute("codeGeneratedTime", System.currentTimeMillis());

%>
            <script>
                alert('인증 메일이 전송되었습니다. 이메일을 확인하세요.');
                window.location.href = 'email.jsp?userEmail=<%= userEmail %>'; // 리다이렉트
            </script>
<%
        } catch (Exception e) {
            e.printStackTrace();
%>
            <script>
                alert('이메일 전송 중 오류가 발생했습니다.');
            </script>
<%
        }
    } else if (enteredCode != null) {
        // 인증번호 검증
        if (VerifyCode.verify(session, enteredCode)) {
%>
            <script>
                alert('인증이 성공적으로 완료되었습니다.');
                window.location.href = 'join.jsp'; // join.jsp로 이동
            </script>
<%
        } else {
%>
            <script>
                alert('인증 코드가 잘못되었습니다.');
            </script>
<%
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이메일 인증</title>
    <style>
        /* 스타일링 부분은 그대로 유지 */<style>
        @font-face {
            font-family: 'GmarketSansMedium';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }

        body {
            font-family: 'GmarketSansMedium';
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }
        h2 {
        	font-family: 'GmarketSansMedium';
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        form {
            font-family: 'GmarketSansMedium';
            display: flex;
            flex-direction: column;
        }
        label {
            font-family: 'GmarketSansMedium';
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        input {
            font-family: 'GmarketSansMedium';
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        button {
            font-family: 'GmarketSansMedium';
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #45a049;
        }
        .note {
            font-size: 12px;
            color: #777;
            text-align: center;
            margin-top: 10px;
        }
    </style>
    </style>
</head>
<body>
    <div class="container">
        <h2>이메일 인증</h2>

        <form method="get" action="email.jsp">
            <label for="userEmail">이메일:</label>
            <input 
                type="text" 
                id="userEmail" 
                name="userEmail" 
                value="<%= request.getParameter("userEmail") != null ? request.getParameter("userEmail") : "" %>" 
                required>
            <button type="submit">인증 요청</button>
        </form>

        <form method="get" action="email.jsp">
            <label for="enteredCode">인증 코드:</label>
            <input 
                type="text" 
                id="enteredCode" 
                name="enteredCode" 
                placeholder="인증 코드 입력" 
                required>
            <button type="submit">인증 확인</button>
        </form>

        <p class="note">* 이메일을 입력한 후, 인증 코드를 확인하세요.</p>
    </div>
</body>
</html>
