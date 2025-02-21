<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

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
		    width: 90%;
		    max-width: 1200px;
		    margin: 40px auto;
		    background-color: #ffffff;
		    border-radius: 10px;
		    overflow: hidden;
		    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
		    padding: 20px;
		}
		
		/* 헤더 */
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
		
		/* 게시물 목록 */
		.posts {
		    display: grid;
		    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
		    gap: 20px;
		    margin-top: 20px;
		}
		
		.post {
		    padding: 20px;
		    background-color: #f7f7f7;
		    border: 1px solid #ddd;
		    border-radius: 8px;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		    transition: transform 0.2s ease, box-shadow 0.2s ease;
		    display: flex;
		    flex-direction: column;
		    justify-content: space-between;
		}
		
		.post:hover {
		    transform: translateY(-3px);
		    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
		}
		
		.post h3 {
		    font-size: 1.4em;
		    color: #4caf50;
		    margin-bottom: 10px;
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
		
		/* 글쓰기 버튼 */
		button {
		    display: block;
		    width: 200px;
		    padding: 12px;
		    font-size: 16px;
		    color: white;
		    background-color: #4caf50;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    margin: 20px auto;
		    text-align: center;
		    transition: background-color 0.3s ease, transform 0.2s ease;
		    font-family: 'GmarketSansMedium', Arial, sans-serif;
		}
		
		button:hover {
		    background-color: #388e3c;
		    transform: translateY(-2px);
		}
		
		/* 푸터 */
		footer {
		    text-align: center;
		    padding: 10px 20px;
		    background-color: #f4f4f4;
		    color: #777;
		    font-size: 0.9em;
		    border-top: 1px solid #ddd;
		    margin-top: 40px;
		}
		
		/* 반응형 디자인 */
		@media screen and (max-width: 768px) {
		    .header {
		        flex-direction: column;
		        text-align: center;
		    }
		
		    .header h1 {
		        font-size: 1.5em;
		        margin-bottom: 10px;
		    }
		
		    .header .user-info {
		        font-size: 0.9em;
		        padding: 3px 10px;
		    }
		
		    .posts {
		        grid-template-columns: 1fr;
		    }
		
		    .post h3 {
		        font-size: 1.2em;
		    }
		
		    button {
		        width: 100%;
		    }
		}


    </style>
</head>
<body>
<div class="header">
        <h1>미림 마이스터고 게시판</h1>
        <div class="user-info">
            <%
                if (userID != null) { // null 체크
                    userID = new String(userID.getBytes("ISO-8859-1"), "UTF-8"); // 인코딩 변환
            %>
                    로그인된 사용자: <%= userID %>
            <%
                } else {
            %>
                    로그인되지 않았습니다.
            <%
                }
            %>
        </div>
        <a href="logoutAction.jsp">로그아웃</a>
    </div>
    <form action="write.jsp" method="get">
        <button type="submit">글 쓰러가기</button>
    </form>
<div class="container">
    <h1>게시판</h1>
    
    <div class="posts">
        <% 
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            
            try {
                String dbURL = "jdbc:mysql://localhost:3306/bbs";
                String dbUser = "root";
                String dbPass = "Mysql4344!";
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

                String selectSql = "SELECT * FROM posts ORDER BY created_at DESC";
                stmt = conn.prepareStatement(selectSql);
                rs = stmt.executeQuery();

                while (rs.next()) {
                    int postID = rs.getInt("id");
                    String postUserID = rs.getString("userID");
                    String content = rs.getString("content");
                    Date createdAt = rs.getTimestamp("created_at");
        %>
                    <div class="post">
                        <h3><a href="post.jsp?postID=<%= postID %>"><%= content %></a></h3>
                        <p class="author">작성자: <%= postUserID %></p>
                        <p class="date">작성일: <%= createdAt %></p>
                    </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>게시글을 불러오는 중 오류가 발생했습니다.</p>");
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
</body>
</html>
