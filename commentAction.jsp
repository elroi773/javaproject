<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    request.setCharacterEncoding("UTF-8");

    HttpSession session5 = request.getSession();
    String userID = (String) session5.getAttribute("userID");

    if (userID == null || userID.isEmpty()) {
%>
    <script>
        alert("로그인이 필요합니다.");
        location.href = "login.jsp";
    </script>
<%
        return;
    }

    String postID = request.getParameter("postID");
    String content = request.getParameter("content");

    if (postID == null || content == null || content.trim().isEmpty()) {
%>
    <script>
        alert("댓글 내용을 입력하세요.");
        history.back();
    </script>
<%
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        String dbURL = "jdbc:mysql://localhost:3306/bbs";
        String dbUser = "root";
        String dbPass = "Mysql4344!";
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        String insertSql = "INSERT INTO comments (postID, userID, content) VALUES (?, ?, ?)";
        stmt = conn.prepareStatement(insertSql);
        stmt.setInt(1, Integer.parseInt(postID));
        stmt.setString(2, userID);
        stmt.setString(3, content);

        int result = stmt.executeUpdate();
        if (result > 0) {
%>
            <script>
                alert("댓글이 등록되었습니다.");
                location.href = "board.jsp";
            </script>
<%
        } else {
%>
            <script>
                alert("댓글 등록에 실패했습니다.");
                history.back();
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("오류가 발생했습니다.");
            history.back();
        </script>
<%
    } finally {
        try {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
	