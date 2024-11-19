<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page session="true" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>커뮤니티 게시판</title>
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

        .post-form {
            margin-bottom: 40px;
        }

        .post-form input, .post-form textarea {
            font-family: 'GmarketSansMedium';
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .post-form button {
            font-family: 'GmarketSansMedium';
            padding: 10px 20px;
            background-color: #4cae4f;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .post-form button:hover {
            background-color: #45a048;
        }

        .posts {
            margin-top: 20px;
        }

        .post {
            border-bottom: 1px solid #ccc;
            padding: 20px 0;
        }

        .post h3 {
            font-family: 'GmarketSansMedium';
            margin: 0;
            color: #4cae4f;
        }

        .post p {
            font-family: 'GmarketSansMedium';
            margin: 10px 0;
            color: #666;
        }

        .post .author {
            font-size: 0.9em;
            color: #999;
        }

        /* 익명/노익명 버튼 스타일 */
        .anonymous-toggle {
            margin: 10px 0;
            display: flex;
            justify-content: space-between;
        }

        .anonymous-toggle button {
            font-family: 'GmarketSansMedium';
            padding: 10px 20px;
            background-color: #ccc;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        .anonymous-toggle button.active {
            background-color: #4cae4f;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="post-form">
            <h2>새 게시물 작성하기</h2>
            <form id="post-form" method="POST" action="savePost.jsp">
                <input type="text" id="post-title" name="title" placeholder="제목을 입력하세요" required>
                <textarea id="post-content" name="content" rows="5" placeholder="내용을 입력하세요" required></textarea>
                <button type="submit">게시하기</button>
            </form>
        </div>

        <div class="anonymous-toggle">
            <button id="anonymous-btn" onclick="toggleAnonymous(true)">익명</button>
            <button id="no-anonymous-btn" class="active" onclick="toggleAnonymous(false)">노익명</button>
        </div>

        <div id="user-info">
            로그인된 사용자: <span id="logged-in-user">
                <% 
                HttpSession session = request.getSession(false);
                if (session != null) {
                    String userID = (String) session.getAttribute("userID");
                } else {
                    out.print("로그인되지 않았습니다.");
                }
ut.print("로그인되지 않았습니다.");
                    }
                %>
            </span>
        </div>
    </div>

    <script>
        // 로그인된 사용자 이름 설정
        let loggedInUser = '<%= session.getAttribute("userID") != null ? session.getAttribute("userID") : "로그인되지 않았습니다." %>';
        document.getElementById('logged-in-user').innerText = loggedInUser;

        // 익명 여부를 저장하는 변수
        let isAnonymous = false;

        // 익명/노익명 버튼 활성화 상태 전환 및 사용자 이름 변경
        function toggleAnonymous(anonymous) {
            isAnonymous = anonymous;
            if (anonymous) {
                document.getElementById('anonymous-btn').classList.add('active');
                document.getElementById('no-anonymous-btn').classList.remove('active');
                document.getElementById('logged-in-user').innerText = '익명';  // 익명일 때 이름을 '익명'으로 설정
            } else {
                document.getElementById('anonymous-btn').classList.remove('active');
                document.getElementById('no-anonymous-btn').classList.add('active');
                document.getElementById('logged-in-user').innerText = loggedInUser;  // 노익명일 때 원래 사용자 이름으로 설정
            }
        }

        // 폼 제출 전 작성자 이름 설정
        const postForm = document.getElementById('post-form');
        postForm.onsubmit = function () {
            const authorName = isAnonymous ? '익명' : loggedInUser;
            const authorInput = document.createElement('input');
            authorInput.type = 'hidden';
            authorInput.name = 'author';
            authorInput.value = authorName;

            postForm.appendChild(authorInput);
        };
    </script>
</body>
</html>
