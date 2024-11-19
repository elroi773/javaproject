<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="java.util.*" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>



<%
    // 회원가입 정보 받기
   String userID = request.getParameter("userID");
    String userPassword = request.getParameter("userPassword");
    String userSchool = request.getParameter("userSchool");
    String userEmail = request.getParameter("userEmail");

    User user = new User();
    user.setUserID(userID);
    user.setUserPassword(userPassword);
    user.setUserSchool(userSchool);
    user.setUserEmail(userEmail);

    UserDAO dao = new UserDAO();
    int result = dao.join(user);  // 사용자 정보를 DB에 저장

    if(result > 0) {
        out.println("<script>alert('회원가입이 완료되었습니다.'); window.location='login.jsp';</script>");
    } else {
        out.println("<script>alert('회원가입에 실패했습니다.'); history.back();</script>");
    }
%>
