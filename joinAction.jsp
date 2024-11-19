<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>

<%
    String userEmail = request.getParameter("email");
    String userName = request.getParameter("name");
    String userID = request.getParameter("userID");
    String userPassword = request.getParameter("userPassword");
    String userSchool = request.getParameter("userSchool");

   

    // 회원가입 정보 객체 생성 및 값 설정
    User user = new User();
    user.setUserID(userID);
    user.setUserPassword(userPassword);
    user.setUserSchool(userSchool);
    user.setUserEmail(userEmail);
    user.setUserName(userName);

    // DB에 저장
    UserDAO dao = new UserDAO();
    int result = dao.join(user);

    // 결과에 따른 처리
    if(result > 0) {
        out.println("<script>alert('회원가입이 완료되었습니다.'); window.location='main.jsp';</script>");
    } else {
        out.println("<script>alert('회원가입에 실패했습니다.'); history.back();</script>");
    }
%>
