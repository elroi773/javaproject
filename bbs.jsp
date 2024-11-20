<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
        }

        button:hover {
            background-color: #388e3c;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>미림 마이스터고 대신 전해드립니다 </h1>
        <div class="posts" id="posts">
            <% 
                // URL 파라미터를 자바로 처리
                String title = request.getParameter("title");
                String content = request.getParameter("content");
                String author = request.getParameter("author");

                // 게시물이 있을 경우
                if (title != null && content != null && author != null) {
                    Date currentDate = new Date();
                    String formattedDate = currentDate.toString(); // 현재 시간

                    out.println("<div class='post'>");
                    out.println("<h3>" + title + "</h3>");
                    out.println("<p>" + content + "</p>");
                    out.println("<p class='author'>작성자: " + author + "</p>");
                    out.println("<p class='date'>작성일: " + formattedDate + "</p>");
                    out.println("</div>");
                }
            %>
        </div>
    </div>

    <form action="write.jsp" method="get">
    	<button type="submit">글 쓰러가기</button>
	</form>


</body>
</html>
