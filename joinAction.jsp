<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>
<%@ page import = "java.io.PrintWriter"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" /> 
<jsp:setProperty name="user" property="userPassword" /> 
<jsp:setProperty name="user" property="userName" /> 
<jsp:setProperty name="user" property="userGender" /> 
<jsp:setProperty name="user" property="userEmail" /> 
<jsp:setProperty name="user" property="userschool" /> 

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/LOGIN.css">
    <title>LOGIN</title>
</head>
<body>
    <%
	    String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		} //한번 로그인 하거나 회원가입 한 회원은 다시 못들어오게 하는 그시기 
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어 있습니다')");
			script.println("locarion href = 'main.jsp'");
			script.println("</script");
		}//이 제어문을 통해서 다시 로그인이 될 수 없도록 막음
        
        if (user.getUserID() == null || user.getUserEmaill() == null || user.getUserPassword() == null || user.getUserGender() == null || user.getUserschool() == null || user.getUserName() == null) {

            // 바로 응답을 반환하여 뒤로 가기 처리
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('입력이 안 된 사항이 있습니다');");
            script.println("history.back();");
            script.println("</script>");
            script.close();  // 응답 종료 메소드 
            return;  // 페이지 처리를 중단
        } else {
            UserDAO userDAO = new UserDAO(); // 데이터베이스 접근 객체 생성
            int result = userDAO.join(user); // 가입 처리 결과 받기

            if (result == -1) {
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('이미 존재하는 아이디 입니다');");
                script.println("history.back();");
                script.println("</script>");
            } else {
            	session.setAttribute("userID",user.getUserID());
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("location.href = 'main.jsp';"); // 메인 페이지로 이동
                script.println("</script>");
            }
        }
    %>
    <script src="js/LOGIN.js"></script>
</body>
</html>
