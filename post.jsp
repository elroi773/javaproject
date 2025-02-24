<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // postID 값을 request에서 가져옴
    String postIDParam = request.getParameter("postID");
    int currentPostID = 0; // 기본값 설정

    if (postIDParam != null && !postIDParam.isEmpty()) {
        currentPostID = Integer.parseInt(postIDParam);
    } else {
%>
    <script>
        alert("잘못된 접근입니다.");
        location.href = "main.jsp";
    </script>
<%
        return;
    }
%>

<%
    request.setCharacterEncoding("UTF-8");

    int postID = Integer.parseInt(request.getParameter("postID"));

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        String dbURL = "jdbc:mysql://localhost:3306/bbs";
        String dbUser = "root";
        String dbPass = "Mysql4344!";
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

        // 게시글 정보 불러오기
        String sql = "SELECT * FROM posts WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, postID);
        rs = stmt.executeQuery();

        if (rs.next()) {
%>
            <h2><%= rs.getString("content") %></h2>
            <p>작성자: <%= rs.getString("userID") %></p>
            <p>작성일: <%= rs.getTimestamp("created_at") %></p>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); if (stmt != null) stmt.close(); if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
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
   		margin: 20px;
	    padding: 20px;
	    background-color: #f8f9fa;
	}
	
	h2 {
	    color: #333;
	    border-bottom: 2px solid #ddd;
	    padding-bottom: 10px;
	}
	
	p {
	    color: #555;
	}
	
	form {
	    margin-top: 15px;
	}
	
	input[type="text"] {
	    width: 80%;
	    padding: 8px;
	    border: 1px solid #ccc;
	    border-radius: 5px;
	}
	
	button {
	    background-color: #007bff;
	    color: white;
	    border: none;
	    padding: 8px 12px;
	    margin-left: 5px;
	    cursor: pointer;
	    border-radius: 5px;
	}
	
	button:hover {
	    background-color: #0056b3;
	}
	
	.comment-container {
	    margin-top: 20px;
	    padding: 10px;
	    background: #fff;
	    border-radius: 5px;
	    box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
	}
		
</style>
<h3>댓글</h3>
<form action="addComment.jsp" method="post">
	<input type="hidden" name="postID" value="<%= currentPostID %>">
    <input type="text" name="content" placeholder="댓글을 입력하세요..." required>
    <button type="submit">댓글 작성</button>
</form>


<%
    // 댓글 가져오기
    // 기존 코드 활용 가능
%>
