package email;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailSender {

    public static void sendEmail(String recipient, String subject, String content) throws MessagingException {
        final String host = "smtp.gmail.com";   // 이메일 서버 주소 (Gmail)
        final String port = "587";               // 포트 번호 (TLS를 위한 587 포트)
        final String username = "eraaa080423@gmail.com"; // 발신자 이메일 주소
        final String password = "ajpo else dvmn wgnk";    // 발신자 이메일 비밀번호 (앱 비밀번호 사용)

        // Properties 객체 설정 이게 서버 통신 설정하는데 사용됨
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);                    // SMTP 서버 주소
        properties.put("mail.smtp.port", port);                    // 포트 번호
        properties.put("mail.smtp.auth", "true");                  // 인증 필요
        properties.put("mail.smtp.starttls.enable", "true");       // TLS 보안 연결

        // Session 객체 생성 (인증 정보 포함)
        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password); // 이메일 인증 정보
            }
        });

        try {
            // 이메일 내용 설정
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username)); // 발신자 이메일 주소
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient)); // 수신자 이메일 주소
            message.setSubject(subject);  // 이메일 제목
            message.setText(content);     // 이메일 본문 내용

            // 이메일 전송
            Transport.send(message);
            System.out.println("이메일 전송 성공!");

        } catch (MessagingException e) {
            e.printStackTrace();
            throw new MessagingException("이메일 전송 실패", e);
        }
    }

    public static void main(String[] args) {
        try {
            sendEmail("recipient@example.com", "인증 코드", "여기에 인증 코드를 입력하세요.");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
