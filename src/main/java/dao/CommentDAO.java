package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.CommentBean;

/**
 * コメントに関するデータアクセスオブジェクト
 */
public class CommentDAO {
	
	/**
	 * タスクIDに紐づくコメントを全件取得する
	 * @param taskId タスクID
	 * @return コメントのリスト
	 */
	public List<CommentBean> findByTaskId(int taskId) {
		List<CommentBean> list = new ArrayList<>();
		String sql = "SELECT c.*, u.user_name FROM t_comment c " +
				"JOIN m_user u ON c.user_id = u.user_id " +
				"WHERE c.task_id = ? AND c.delete_flg = '0' " +
				"ORDER BY update_datetime ASC";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, taskId);
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					CommentBean bean = new CommentBean();
					bean.setCommentId(rs.getInt("comment_id"));
					bean.setParentCommentId((Integer) rs.getObject("parent_comment_id"));
					bean.setUserName(rs.getString("user_name"));
					bean.setCommentBody(rs.getString("comment_body"));
					bean.setupdateDatetime(rs.getTimestamp("update_datetime"));
					list.add(bean);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
}
