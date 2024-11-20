package user;

public class User {
    private String userID;
    private String userPassword;
    private String userSchool;
    private String userEmail;
    private String userName;  // 이름 추가

    // getters and setters
    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserSchool() {
        return userSchool;
    }

    public void setUserSchool(String userSchool) {
        this.userSchool = userSchool;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserName() {  // 이름 getter 추가
        return userName;
    }

    public void setUserName(String userName) {  // 이름 setter 추가
        this.userName = userName;
    }
}
