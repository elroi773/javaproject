package email;

import javax.servlet.http.HttpSession;

public class VerifyCode {

    /**
     * 세션에 저장된 인증번호와 사용자가 입력한 인증번호를 검증합니다.
     *
     * @param session       사용자의 세션 객체
     * @param enteredCode   사용자가 입력한 인증번호
     * @return              인증 성공 여부 (true: 성공, false: 실패)
     */
    public static boolean verify(HttpSession session, String enteredCode) {
        if (session == null || enteredCode == null || enteredCode.isEmpty()) {
            return false; // 세션 또는 입력된 코드가 null/빈값인 경우 실패
        }

        // 세션에서 인증번호를 가져옴
        String verificationCode = (String) session.getAttribute("verificationCode");

        if (verificationCode == null) {
            return false; // 인증번호가 세션에 없으면 실패
        }

        // 입력한 인증번호와 세션의 인증번호를 비교
        return verificationCode.equals(enteredCode);
    }
}
