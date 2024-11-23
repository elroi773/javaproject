package email;

import javax.servlet.http.HttpSession;

public class VerifyCode {

    // 세션에서 인증 코드 검증
    public static boolean verify(HttpSession session, String enteredCode) {
        // 세션에서 저장된 인증 코드 가져오기
        String storedCode = (String) session.getAttribute("verificationCode");

        // 인증 코드가 세션에 저장되어 있고, 입력한 코드와 일치하면 인증 성공
        return storedCode != null && storedCode.equals(enteredCode);
    }
}
