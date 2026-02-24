package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bean.UserBean;

public class UserDAO {
	public UserBean login(String userId, String password) {
		UserBean user = null;
		// delete_flg='0'（有効なユーザー）のみを対象とする
		String sql = "SELECT * FROM m_user WHERE user_id = ? AND password = ? AND delete_flg = '0'";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, userId);
			pstmt.setString(2, password);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					user = new UserBean();
					user.setUserId(rs.getString("user_id"));
					user.setUserName(rs.getString("user_name"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}
}
