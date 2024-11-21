package post;

import util.DBConnection; // DBConnection 클래스 경로
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDAO {
    public List<Post> getAllPosts() throws SQLException, ClassNotFoundException {
        List<Post> posts = new ArrayList<>();
        String query = "SELECT * FROM posts ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Post post = new Post();
                post.setUserID(rs.getString("userID"));
                post.setContent(rs.getString("content"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
                posts.add(post);
            }
        }
        return posts;
    }
}
