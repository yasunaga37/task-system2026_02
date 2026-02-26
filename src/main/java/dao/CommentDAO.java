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
		// MySQL 8.0以降で利用可能な再帰クエリ
		String sql = 
			    "WITH RECURSIVE comment_tree AS (" +
			    "  /* 1. 親コメントの取得時にユーザー名を結合 */" +
			    "  SELECT c.*, u.user_name, 1 AS level, CAST(c.comment_id AS CHAR(255)) AS path " +
			    "  FROM t_comment c " +
			    "  JOIN m_user u ON c.user_id = u.user_id " +
			    "  WHERE c.parent_comment_id IS NULL AND c.task_id = ? AND c.delete_flg = '0' " +
			    "  UNION ALL " +
			    "  /* 2. 返信コメントの取得時にもユーザー名を結合 */" +
			    "  SELECT c.*, u.user_name, ct.level + 1, CONCAT(ct.path, '.', c.comment_id) " +
			    "  FROM t_comment c " +
			    "  JOIN m_user u ON c.user_id = u.user_id " +
			    "  JOIN comment_tree ct ON c.parent_comment_id = ct.comment_id " +
			    "  WHERE c.delete_flg = '0' " +
			    ") " +
			    "SELECT * FROM comment_tree ORDER BY path ASC"; // path順に並べることで親子が隣接する

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, taskId);
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					CommentBean bean = new CommentBean();
					bean.setCommentId(rs.getInt("comment_id"));
					bean.setParentCommentId(rs.getInt("parent_comment_id"));
					bean.setUserName(rs.getString("user_name"));
					bean.setCommentBody(rs.getString("comment_body"));
					bean.setUpdateDatetime(rs.getTimestamp("update_datetime"));
					bean.setLevel(rs.getInt("level"));
					list.add(bean);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * コメントを新規登録する
	 * @param comment 登録するコメントの情報
	 */
	public void insert(CommentBean comment) {
		// parent_comment_id は返信機能を使わない場合は NULL が入るようにします
		String sql = "INSERT INTO t_comment (task_id, parent_comment_id, user_id, comment_body, delete_flg, update_datetime) "
				+
				"VALUES (?, ?, ?, ?, '0', CURRENT_TIMESTAMP)";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, comment.getTaskId());

			// parentCommentId が null の場合は SQL の NULL をセット
			if (comment.getParentCommentId() != null && comment.getParentCommentId() > 0) {
				pstmt.setInt(2, comment.getParentCommentId());
			} else {
				// 0 または null の場合は、DB側に正しく NULL をセットする
				pstmt.setNull(2, java.sql.Types.INTEGER);
			}

			pstmt.setString(3, comment.getUserId());
			pstmt.setString(4, comment.getCommentBody());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
