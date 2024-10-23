<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, javax.mail.*, javax.mail.internet.*, javax.mail.Authenticator, javax.mail.PasswordAuthentication" %>
<%@ page import="user.User, user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/LOGIN.css">
    <title>JOIN ACTION</title>
</head>
<body>
   <%
		try {
		    String userID = request.getParameter("userID");
		    String userPassword = request.getParameter("userPassword");
		    String userName = request.getParameter("userName");
		    String userGender = request.getParameter("userGender");
		    String userEmail = request.getParameter("userEmail");
		    String userSchool = request.getParameter("userschool");
		    String inputCode = request.getParameter("emailCode"); // 사용자가 입력한 인증번호
		    String sessionCode = (String) session.getAttribute("verificationCode"); // 이메일로 전송된 인증번호
		
		    // 인증번호 검증
		    if (sessionCode != null && sessionCode.equals(inputCode)) {
		        // 인증 성공 시 회원가입 처리
		        User user = new User();
		        user.setUserID(userID);
		        user.setUserPassword(userPassword);
		        user.setUserName(userName);
		        user.setUserGender(userGender);
		        user.setUserEmail(userEmail);
		        user.setUserschool(userSchool);

		        UserDAO userDAO = new UserDAO();
		        int result = userDAO.join(user);

		        if(result == 1){
		            out.println("<h2>회원가입 성공</h2>");
		            out.println("<p>"+userName+"님, 회원가입을 축하드립니다!</p>");
		        } else {
		            out.println("<h2>회원가입 실패</h2>");
		            out.println("<p>회원가입 중 오류가 발생했습니다. 다시 시도해 주세요.</p>");
		        }
		    } else {
		        // 인증 실패 시
		        out.println("<h2>인증 실패</h2>");
		        out.println("<p>이메일 인증번호가 잘못되었습니다. 다시 시도해 주세요.</p>");
		    }
		} catch (Exception e) {
		    e.printStackTrace(out);
		}
	%>
</body>
</html>
