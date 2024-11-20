<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 글 작성</title>
    <style>
        @font-face {
            font-family: 'GmarketSansMedium';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
        }

        body {
            font-family: 'GmarketSansMedium', Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
        }

        h2 {
            text-align: center;
            color: #4cae4f;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            display: block;
            margin: 10px 0 5px;
        }

        input, textarea {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            padding: 10px 20px;
            background-color: #4cae4f;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a048;
        }

        .toggle-buttons {
            display: flex;
            justify-content: center;
            margin: 10px 0;
        }

        .toggle-buttons button {
            margin: 0 10px;
            padding: 10px 20px;
            font-weight: bold;
        }

        .output {
            margin-top: 20px;
            padding: 15px;
            background-color: #eef5ee;
            border-left: 4px solid #4cae4f;
            border-radius: 5px;
        }
    </style>
</head>
<body>
     <div class="container">
        <h2>게시글 작성폼</h2>
        <form action="write.jsp" method="post">
            <label for="content">글 내용:</label>
            <textarea id="content" name="content" rows="5" placeholder="내용을 입력하세요" required></textarea>

            <div class="current-name">
                <% 
                    // 로그인된 userID 불러오기
                    HttpSession session5 = request.getSession(false);
                    String userID = (session5 != null) ? (String) session5.getAttribute("userID") : null;

                    // 로그인된 사용자일 경우 userID 출력
                    if (userID != null) { 
                %>
                    <p><strong>현재 작성자:</strong> <%= userID %></p>
                    <input type="hidden" id="userID" name="userID" value="<%= userID %>">
                <% 
                    } else {
                %>
                    <p>로그인되지 않은 상태입니다. 글 작성 시 익명으로 작성됩니다.</p>
                    <input type="hidden" id="userID" name="userID" value="익명">
                <% 
                    }
                %>
            </div>

            <button type="submit">작성 완료</button>
        </form>

       <%
		    String content = request.getParameter("content");
		    userID = request.getParameter("userID"); // 중복 선언 제거
		    if (content != null && !content.isEmpty() && userID != null) {
		        Connection conn = null;
		        PreparedStatement stmt = null;
		        try {
		            // DB 연결 설정
		            String dbURL = "jdbc:mysql://localhost:3306/bbs";
		            String dbUser = "root";
		            String dbPass = "Mysql4344!";
		            Class.forName("com.mysql.cj.jdbc.Driver"); //java 리플렉션 api 를 사용하여 특정 클래스의 이름을 문자열로 지정 해당 클래스 로드
		            conn = DriverManager.getConnection(dbURL, dbUser, dbPass); //jdbc api 를 통해 데이터베이스 연결 생성 메소드임 이걸로 sql 이랑 데이터를 주고 받을 수 잇다
		
		            // 게시글 DB에 저장
		            String insertSql = "INSERT INTO posts (userID, content, created_at) VALUES (?, ?, NOW())";
		            stmt = conn.prepareStatement(insertSql);
		            stmt.setString(1, userID);
		            stmt.setString(2, content);
		            stmt.executeUpdate();
		
		            out.println("<h3>게시글이 성공적으로 작성되었습니다.</h3>");
		        } catch (Exception e) {
		            e.printStackTrace();
		            out.println("<h3>게시글 작성 중 오류가 발생했습니다.</h3>");
		        } finally {
		            try {
		                if (stmt != null) stmt.close();
		            } catch (SQLException e) {
		                e.printStackTrace();
		            }
		            try {
		                if (conn != null) conn.close();
		            } catch (SQLException e) {
		                e.printStackTrace();
		            }
		        }
		    }
		%>

    </div>
</body>
</html>