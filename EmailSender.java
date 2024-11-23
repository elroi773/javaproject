package email;

import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;
import javax.mail.*;
import javax.mail.internet.*;
import java.security.SecureRandom;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class EmailSender {

    // 인증 코드를 저장할 맵 (테스트용. 실제 서비스에서는 Redis나 DB를 사용하는 것이 좋습니다.)
    private static final ConcurrentHashMap<String, String> codeStore = new ConcurrentHashMap<>();

    /**
     * 이메일 전송 메서드
     */
    public static void sendEmail(String recipient, String subject, String content) throws MessagingException {
        final String host = "smtp.gmail.com";   // 이메일 서버 주소
        final String port = "587";             // TLS 포트 번호
        final String username = "eraaa080423@gmail.com"; // 발신자 이메일 주소
        final String password = "ajpo else dvmn wgnk";   // 발신자 앱 비밀번호

        // SMTP 설정
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // 세션 생성
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            // 이메일 내용 구성
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject(subject);
            message.setText(content);

            // 이메일 전송
            Transport.send(message);
            System.out.println("이메일 전송 성공!");

        } catch (MessagingException e) {
            e.printStackTrace();
            throw new MessagingException("이메일 전송 실패", e);
        }
    }

    /**
     * 인증 코드 생성 메서드
     */
    public static String generateVerificationCode() {
        SecureRandom random = new SecureRandom();
        return String.format("%06d", random.nextInt(1000000)); // 6자리 랜덤 숫자
    }

    //이메일 확인 
    public static boolean isValidEmail(String email) {
        // 도메인 확인
    	 if (!email.endsWith("@e-mirim.hs.kr")) {
             return false; // 도메인이 맞지 않으면 false 반환
         }

         // 이메일 정규식: 첫 글자 s 또는 d, 뒤에 숫자 두 개, 두 자리 숫자 범위 검사
         String emailRegex = "^[sd]\\d{2}[0-7][0-2]\\d{2}@e-mirim\\.hs\\.kr$";
         Pattern pattern = Pattern.compile(emailRegex);
         Matcher matcher = pattern.matcher(email);
         
         return matcher.matches(); // 정규식이 일치하면 true 반환
     }

    /**
     * 인증 코드 전송 메서드
     */
    public static void sendVerificationCode(String recipient) throws MessagingException {
        if (!isValidEmail(recipient)) {
            throw new MessagingException("잘못된 이메일 형식: " + recipient);
        }

        String code = generateVerificationCode();
        codeStore.put(recipient, code); // 인증 코드 저장

        String subject = "이메일 인증 코드";
        String content = "인증 코드: " + code + "\n이 코드를 입력하여 인증을 완료하세요.";

        sendEmail(recipient, subject, content);
    }

    /**
     * 인증 코드 검증 메서드
     */
    public static boolean verifyCode(String recipient, String inputCode) {
        String storedCode = codeStore.get(recipient);
        return storedCode != null && storedCode.equals(inputCode);
    }

    /**
     * 메인 메서드 (테스트용)
     */
    public static void main(String[] args) {
        try {
            String testEmail = "s2457@e-mirim.hs.kr"; // 테스트용 이메일

            // 인증 코드 전송
            sendVerificationCode(testEmail);

            // 예시로 사용자가 입력한 코드를 검증하는 로직
            String userInputCode = "123456"; // 사용자가 입력했다고 가정한 인증 코드
            if (verifyCode(testEmail, userInputCode)) {
                System.out.println("인증 성공!");
            } else {
                System.out.println("인증 실패!");
            }
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
