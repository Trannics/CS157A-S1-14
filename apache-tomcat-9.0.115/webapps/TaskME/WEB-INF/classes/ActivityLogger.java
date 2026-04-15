import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ActivityLogger {
    public static void log(Connection con, int projectId, int userId,
                           String actionType, String entityType, int entityId) throws SQLException {
        String sql = "INSERT INTO activity_log (Project_ID, User_ID, Action_Type, Entity_Type, Entity_ID) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, projectId);
        ps.setInt(2, userId);
        ps.setString(3, actionType);
        ps.setString(4, entityType);
        ps.setInt(5, entityId);
        ps.executeUpdate();
        ps.close();
    }
}