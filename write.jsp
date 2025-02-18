<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    request.setCharacterEncoding("UTF-8");

    // 로그인된 userID 가져오기
    HttpSession session5 = request.getSession(false);
    String userID = (session5 != null) ? (String) session5.getAttribute("userID") : null;

    // userID가 존재하고, 한글이 깨질 경우 변환
    if (userID != null) {
        userID = new String(userID.getBytes("ISO-8859-1"), "UTF-8");
    }
%>
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

        textarea {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .btn {
            flex: 1;
            margin: 0 5px;
            padding: 10px 20px;
            background-color: #4cae4f;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            text-align: center;
        }

        .btn:hover {
            background-color: #45a048;
        }

        .btn.selected {
            background-color: #3b8f3e;
        }

        button {
            font-family: 'GmarketSansMedium';
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

        #content {
            font-family: 'GmarketSansMedium';
        }
    </style>
    <script>
        function selectMode(isAnonymous) {
            document.getElementById('btn-anonymous').classList.remove('selected');
            document.getElementById('btn-userid').classList.remove('selected');
            if (isAnonymous === 'yes') {
                document.getElementById('btn-anonymous').classList.add('selected');
            } else {
                document.getElementById('btn-userid').classList.add('selected');
            }

            document.getElementById('isAnonymousInput').value = isAnonymous;
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>게시글 작성폼</h2>
        <form action="writeAction.jsp" method="post">
            <label for="content">글 내용:</label>
            <textarea id="content" name="content" rows="5" placeholder="내용을 입력하세요" required></textarea>

            <div class="current-name">
                <% if (userID != null) { %>
                    <p><strong>작성자:</strong> <%= userID %></p>
                    <input type="hidden" name="userID" value="<%= userID %>">

                    <!-- 익명/노익명 버튼 -->
                    <div class="button-group">
                        <button type="button" class="btn" id="btn-userid" onclick="selectMode('no')">노익명 (사용자명 사용)</button>
                        <button type="button" class="btn" id="btn-anonymous" onclick="selectMode('yes')">익명</button>
                    </div>
                    
                    <input type="hidden" id="isAnonymousInput" name="isAnonymous" value="no">
                <% } else { %>
                    <p>로그인되지 않은 상태입니다. 글 작성 시 익명으로 작성됩니다.</p>
                    <input type="hidden" name="userID" value="익명">
                    <input type="hidden" name="isAnonymous" value="yes">
                <% } %>
            </div>

            <button type="submit">작성 완료</button>
        </form>
    </div>
</body>
</html>
