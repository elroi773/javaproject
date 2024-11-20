<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>

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
            font-family: 'GmarketSansMedium';
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
        }

        .post {
            border-bottom: 1px solid #ccc;
            padding: 20px 0;
        }

        .post h3 {
            margin: 0;
            color: #4cae4f;
        }

        .post p {
            margin: 10px 0;
            color: #666;
        }

        .post .author {
            font-size: 0.9em;
            color: #999;
        }

        .post .date {
            font-size: 0.8em;
            color: #bbb;
        }

        button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #4cae4f;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            transition: background-color 0.3s ease;
            font-family: 'GmarketSansMedium';
        }

        button:hover {
            background-color: #388e3c;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>미림 마이스터고 게시판</h1>
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
                        String userID = rs.getString("userID");
                        String content = rs.getString("content");
                        Date createdAt = rs.getTimestamp("created_at");

                        out.println("<div class='post'>");
                        out.println("<h3>" + content + "</h3>");
                        out.println("<p class='author'>작성자: " + userID + "</p>");
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
        <form action="write.jsp" method="get">
            <button type="submit">글 쓰러가기</button>
        </form>
    </div>
</body>
</html>
