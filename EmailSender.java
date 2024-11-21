package email;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EmailSender {
    public static void sendEmail(String recipient, String subject, String content) {
        // 메일 서버 설정
        String host = "smtp.gmail.com";
        final String username = "s2457@e-mirim.hs.kr"; // 보내는 사람 이메일
        final String password = "kim080423"; // 보내는 사람 이메일 비밀번호

        // SMTP 서버 설정
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // 세션 생성
        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            // 메일 내용 설정
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username)); // 보내는 사람
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient)); // 받는 사람
            message.setSubject(subject); // 제목
            message.setText(content); // 내용

            // 이메일 전송
            Transport.send(message);
            System.out.println("이메일이 성공적으로 발송되었습니다.");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    public static void main(String[] args) {
        String userEmail = "recipient-email@example.com";
        String subject = "인증 코드";
        String messageText = "인증 코드: 123456";

        sendEmail(userEmail, subject, messageText);
    }
}
