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
            String dbPassword = "Mysql4344!";
            Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL 8.x 드라이버로 변경
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Database connection failed", e);
        }
    }

    public int join(User user) {
        String SQL = "INSERT INTO user (userID, userPassword, userSchool, userEmail) VALUES(?, ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserSchool());
            pstmt.setString(4, user.getUserEmail());
            return pstmt.executeUpdate();
        } catch (SQLException e) {
        	logger.log(Level.SEVERE, "User registration failed: " + e.getMessage(), e);  // 로그에 예외 정보 기록
            throw new RuntimeException("Database error during user registration", e); // 예외 던지기
        }

    }
}
