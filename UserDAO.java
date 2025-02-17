package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.SQLException;

public class UserDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    private static final Logger logger = Logger.getLogger(UserDAO.class.getName());

    public UserDAO() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/bbs";
            String dbID = "root";
            String dbPassword = "Mysql4344!"; // 본인의 데이터베이스 비밀번호로 변경
            Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL 8.x 드라이버
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Database connection failed", e);
        }
    }

    // 로그인 메서드
    public int login(String userID, String userPassword) {
        String SQL = "SELECT userPassword FROM user WHERE userID = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                if (rs.getString("userPassword").equals(userPassword)) {
                    return 1; // 로그인 성공
                } else {
                    return 0; // 비밀번호 틀림
                }
            }
            return -1; // userID가 존재하지 않음
        } catch (SQLException e) {
            e.printStackTrace();
            return -2; // 데이터베이스 오류
        }
    }

    // 회원가입 메서드
    public int join(User user) {
        // 아이디 중복 확인
        if (isUserIDExist(user.getUserID())) {
            logger.log(Level.WARNING, "User ID already exists: " + user.getUserID());
            return -1; // 이미 존재하는 ID일 경우 처리
        }

        String SQL = "INSERT INTO user (userID, userPassword, userSchool, userEmail) VALUES (?, ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserSchool());
            pstmt.setString(4, user.getUserEmail());
            return pstmt.executeUpdate(); // 정상적인 회원가입
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "User registration failed: " + e.getMessage(), e);
            throw new RuntimeException("Database error during user registration", e);
        }
    }

    // 아이디 중복 체크 메서드
    public boolean isUserIDExist(String userID) {
        String SQL = "SELECT * FROM user WHERE userID = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            return rs.next(); // 존재하면 true 반환
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Error checking user ID", e);
            return false;
        }
    }
}
