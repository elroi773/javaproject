// 회원가입 버튼 클릭 시 실행되는 함수
function submitSignup() {
    var username = document.getElementById('username').value.trim();
    var email = document.getElementById('email').value.trim();
    var password = document.getElementById('password').value.trim();
    var confirmPassword = document.getElementById('confirmPassword').value.trim();
    var errorMessage = document.getElementById('errorMessage');

    // 유효성 검사: 모든 필드가 입력되었는지 확인
    if (username === "" || email === "" || password === "" || confirmPassword === "" || password !== confirmPassword) {
        errorMessage.style.display = 'block'; // 오류 메시지 표시
        document.querySelector('.signup-container').classList.add('shake'); // 흔들리는 애니메이션 추가
        setTimeout(() => {
            document.querySelector('.signup-container').classList.remove('shake'); // 애니메이션 제거
        }, 500);
    } else {
        errorMessage.style.display = 'none'; // 오류 메시지 숨김
        // 회원가입 성공 시 추가 기능 구현 (서버 요청 등)
        alert('회원가입 성공!');
    }
}

(function(){
    emailjs.init("UygOBJObCFbHWOLzb");
})();

let verificationCode = "";

function sendVerificationCode(){
    verificationCode = Math.floor(100000 + Math.random() * 900000).toString();
    
    emailjs.send("service_g6iu7xz","template_003kqyx",{
        user_email: document.getElementById("userEmail").value,
                verification_code: verificationCode
            }).then((response) => {
                alert("인증번호가 전송되었습니다.");
                document.getElementById("verificationField").style.display = "block";
            }).catch((error) => {
                alert("인증번호 전송에 실패했습니다.");
                console.error("EmailJS Error:", error);
            });
    
}

function verifyCode() {
    const inputCode = document.getElementById("verificationCode").value;
    if (inputCode === verificationCode) {
        alert("인증에 성공하였습니다.");
    } else {
        alert("인증번호가 올바르지 않습니다.");
    }
}



