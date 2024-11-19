package user;

public class User {
    private String userID;
    private String userPassword;
    private String userSchool;
    private String userEmail;

    
    public User(String userID, String userPassword, String userSchool, String userEmail) {
        this.userID = userID;
        this.userPassword = userPassword;
        this.userSchool = userSchool;
        this.userEmail = userEmail;
    }

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
    
}
