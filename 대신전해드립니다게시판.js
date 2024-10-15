// 로그인된 사용자 이름 설정 (예: 로그인 시 서버에서 전달받은 사용자 이름)
let loggedInUser = '홍길동';
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

// 게시물 제출 함수
function submitPost() {
    const title = document.getElementById('post-title').value;
    const content = document.getElementById('post-content').value;

    if (title.trim() === '' || content.trim() === '') {
        alert("제목과 내용을 입력해주세요.");
        return;
    }

    // 작성자 이름 설정 (익명 여부에 따라 다르게 표시)
    const authorName = isAnonymous ? '익명' : loggedInUser;

    // 데이터를 새로운 페이지로 전송
    window.location.href = `대신전해드립니다게시판게시화면.html?title=${encodeURIComponent(title)}&content=${encodeURIComponent(content)}&author=${encodeURIComponent(authorName)}`;
}
