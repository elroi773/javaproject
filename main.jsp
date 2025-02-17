<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    request.setCharacterEncoding("UTF-8");  // 요청의 문자셋을 UTF-8로 설정
    response.setCharacterEncoding("UTF-8"); // 응답의 문자셋을 UTF-8로 설정
%>




<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>
    <style>
        @font-face {
		    font-family: 'GmarketSansMedium';
		    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		
		body {
		    font-family: 'GmarketSansMedium', Arial, sans-serif;
		    background-color: #f9f9f9;
		    margin: 0;
		    padding: 0;
		    color: #333;
		}
		
		.container {
		    width: 80%;
		    max-width: 1200px;
		    margin: 40px auto;
		    background-color: #ffffff;
		    border-radius: 10px;
		    overflow: hidden;
		    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
		}
		
		.header {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    padding: 15px 30px;
		    background-color: #4caf50;
		    color: white;
		    border-bottom: 2px solid #388e3c;
		}
		
		.header h1 {
		    margin: 0;
		    font-size: 1.8em;
		}
		
		.header .user-info {
		    font-size: 1em;
		    background: rgba(255, 255, 255, 0.2);
		    padding: 5px 15px;
		    border-radius: 20px;
		}
		
		.header a {
		    text-decoration: none;
		    color: white;
		    font-size: 1em;
		    padding: 8px 15px;
		    background-color: #388e3c;
		    border-radius: 5px;
		    transition: background-color 0.3s ease;
		}
		
		.header a:hover {
		    background-color: #2d6b2e;
		}
		
		.posts {
		    padding: 20px;
		    border-top: 1px solid #ddd;
		}
		
		.post {
		    margin-bottom: 20px;
		    padding: 15px 20px;
		    background-color: #f7f7f7;
		    border: 1px solid #ddd;
		    border-radius: 8px;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		    transition: transform 0.2s ease, box-shadow 0.2s ease;
		}
		
		.post:hover {
		    transform: translateY(-3px);
		    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
		}
		
		.post h3 {
		    margin: 0 0 10px;
		    font-size: 1.4em;
		    color: #4caf50;
		}
		
		.post p {
		    margin: 5px 0;
		    color: #555;
		    line-height: 1.6;
		}
		
		.post .author {
		    font-size: 0.9em;
		    color: #888;
		}
		
		.post .date {
		    font-size: 0.8em;
		    color: #aaa;
		    margin-top: 10px;
		}
		
		button {
			padding-left:30px;
		    display: inline-block;
		    padding: 12px 20px;
		    font-size: 16px;
		    color: white;
		    background-color: #4caf50;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    text-align: center;
		    margin: 20px 0;
		    text-decoration: none;
		    transition: background-color 0.3s ease, transform 0.2s ease;
		    font-family: 'GmarketSansMedium', Arial, sans-serif;
		}
		
		button:hover {
		    background-color: #388e3c;
		    transform: translateY(-2px);
		}
		
		footer {
		    text-align: center;
		    padding: 10px 20px;
		    background-color: #f4f4f4;
		    color: #777;
		    font-size: 0.9em;
		    border-top: 1px solid #ddd;
		    margin-top: 40px;
		}

    </style>
</head>
<body>
    <%
    
    	response.setCharacterEncoding("UTF-8");
    	
        HttpSession session5 = request.getSession();
        String userID = (String) session.getAttribute("userID");

        if (userID == null || userID.isEmpty()) {
    %>
        <script>
            alert("로그인이 필요합니다.");
            location.href = "login.jsp";
        </script>
    <%
            return;
        }
    %>
    <div class="header">
        <h1>미림 마이스터고 게시판</h1>
		 <div class="user-info">
		    로그인된 사용자: <%= 
		        String userID = (String) session.getAttribute("userID");
		        if (userID != null) {  // null 체크
		            userID = new String(userID.getBytes("ISO-8859-1"), "UTF-8");  // 인코딩 변환
		            out.println(userID);  // userID를 출력
		        } else {
		            out.println("로그인된 사용자 정보 없음");
		        }
		    %>
		</div>
        <a href="logoutAction.jsp">로그아웃</a>
    </div>
    <form action="write.jsp" method="get">
            <button type="submit">글 쓰러가기</button>
        </form>
    <div class="container">
        <div class="posts" id="posts">
            <% 
                // DB 연결 변수
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    // DB 연결 설정
                    String dbURL = "jdbc:mysql://localhost:3306/bbs"; // 데이터베이스 URL
                    String dbUser = "root"; // DB 사용자명
                    String dbPass = "Mysql4344!"; // DB 비밀번호
                    Class.forName("com.mysql.cj.jdbc.Driver"); // JDBC 드라이버 로드
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPass); // DB 연결

                    // 게시글 조회 쿼리
                    String selectSql = "SELECT * FROM posts ORDER BY created_at DESC";
                    stmt = conn.prepareStatement(selectSql);
                    rs = stmt.executeQuery();

                    // 게시글 출력
                    while (rs.next()) {
                        String postUserID = rs.getString("userID");
                        String content = rs.getString("content");
                        Date createdAt = rs.getTimestamp("created_at");

                        out.println("<div class='post'>");
                        out.println("<h3>" + content + "</h3>");
                        out.println("<p class='author'>작성자: " + postUserID + "</p>");
                        out.println("<p class='date'>작성일: " + createdAt + "</p>");
                        out.println("</div>");
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<h3>게시글을 불러오는 데 오류가 발생했습니다.</h3>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>
        
    </div>
</body>
</html>
