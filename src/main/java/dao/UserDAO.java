package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.UserBean;

public class UserDAO {

	/**
	 * ログイン処理
	 * @param userId ユーザーID
	 * @param password パスワード
	 * @return ログイン成功時はUserBean、失敗時はnull
	 */
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

	/**
	 * 全ユーザーの一覧を取得する（プルダウン用）
	 * @return ユーザー情報のリスト
	 */
	public List<UserBean> findAll() {
		List<UserBean> list = new ArrayList<>();
		// 削除フラグがある場合は、有効なユーザーのみ取得するように WHERE 句を追加
		String sql = "SELECT user_id, user_name FROM m_user ORDER BY user_id ASC";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				UserBean bean = new UserBean();
				bean.setUserId(rs.getString("user_id"));
				bean.setUserName(rs.getString("user_name"));
				list.add(bean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

}
