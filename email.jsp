<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="email.EmailSender" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>

<%
    // 클라이언트로부터 전달받은 이메일 주소와 인증 코드
    String userEmail = request.getParameter("userEmail");
    String enteredCode = request.getParameter("enteredCode");
    String verificationCode = (String) session.getAttribute("verificationCode");

    // 이메일 정규식 패턴 (e-mirim.hs.kr 도메인만 허용)
    String emailRegex = "^[a-zA-Z0-9._%+-]+@e-mirim\\.hs\\.kr$";
    boolean isValidEmail = userEmail != null && userEmail.matches(emailRegex);

    if (userEmail != null && enteredCode != null) {
        if (enteredCode.equals(verificationCode)) {
            out.println("<script>alert('인증이 성공적으로 완료되었습니다.');</script>");
        } else {
            out.println("<script>alert('인증 코드가 잘못되었습니다.');</script>");
        }
    }

    if (userEmail != null && isValidEmail && verificationCode == null) {
        try {
            // 이메일 전송
            String subject = "이메일 인증";
            verificationCode = String.valueOf((int) (Math.random() * 900000) + 100000); // 6자리 랜덤 인증 코드
            String messageText = "인증 코드: " + verificationCode;

            // EmailSender를 사용해 이메일 전송
            EmailSender.sendEmail(userEmail, subject, messageText);

            // 세션에 인증 코드 저장
            session.setAttribute("verificationCode", verificationCode);

            // 인증 성공 메시지 출력
            out.println("<script>");
            out.println("alert('인증 메일이 전송되었습니다. 이메일을 확인하세요.');");
            out.println("window.location = 'email.jsp?userEmail=" + userEmail + "';");
            out.println("</script>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('이메일 전송 중 오류가 발생했습니다.');</script>");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이메일 인증</title>
</head>
<body>
    <h2>이메일 인증</h2>
    <form method="get" action="email.jsp">
        <label for="userEmail">이메일:</label>
        <input type="text" id="userEmail" name="userEmail" placeholder="e-mirim.hs.kr 이메일" required>
        <button type="submit">인증 요청</button>
    </form>

    <%-- 인증 코드 입력 폼 --%>
    <form method="get" action="email.jsp">
        <label for="enteredCode">인증 코드:</label>
        <input type="text" id="enteredCode" name="enteredCode" placeholder="인증 코드 입력" required>
        <button type="submit">인증 확인</button>
    </form>
</body>
</html>
