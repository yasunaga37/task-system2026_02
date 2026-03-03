package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.TaskBean;

/**
 * タスクに関するデータアクセスオブジェクト
 */
public class TaskDAO {

	/**
	 * タスクを全件取得する
	 * @return タスクのリスト
	 */
	public List<TaskBean> findAll() {
		List<TaskBean> list = new ArrayList<>();
		// ステータスコードの昇順（00→10→50→90）、その次に期限日の昇順で並べる
		String sql = "SELECT t.*, c.category_name, s.status_name, u.user_name " +
				"FROM t_task t " +
				"JOIN m_category c ON t.category_id = c.category_id " +
				"JOIN m_status s ON t.status_code = s.status_code " +
				"JOIN m_user u ON t.user_id = u.user_id " +
				"WHERE t.delete_flg = '0' " + // 論理削除フィルタ
				"ORDER BY t.status_code ASC, t.limit_date ASC";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				TaskBean task = new TaskBean();
				task.setTaskId(rs.getInt("task_id"));
				task.setTaskName(rs.getString("task_name"));
				task.setCategoryId(rs.getInt("category_id"));
				task.setCategoryName(rs.getString("category_name"));
				task.setUserName(rs.getString("user_name"));
				task.setLimitDate(rs.getDate("limit_date"));
				task.setStatusCode(rs.getString("status_code"));
				task.setStatusName(rs.getString("status_name"));
				list.add(task);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * タスクを新規登録する
	 * @param task 登録するタスクの情報
	 */
	public void insert(TaskBean task) {
		String sql = "INSERT INTO t_task (task_name, category_id, limit_date, user_id, status_code, memo, delete_flg) "
				+
				"VALUES (?, ?, ?, ?, ?, ?, '0')";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, task.getTaskName());
			pstmt.setInt(2, task.getCategoryId());
			pstmt.setDate(3, task.getLimitDate());
			pstmt.setString(4, task.getUserId());
			pstmt.setString(5, task.getStatusCode());
			pstmt.setString(6, task.getMemo());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 特定のIDのタスク1件を、マスタデータと結合して取得するメソッド
	 * @param taskId
	 * @return TaskBean
	 */
	public TaskBean findByPk(int taskId) {
		TaskBean task = null;
		String sql = "SELECT t.*, c.category_name, s.status_name, u.user_name  " +
				"FROM t_task t " +
				"JOIN m_category c ON t.category_id = c.category_id " +
				"JOIN m_status s ON t.status_code = s.status_code " +
				"JOIN m_user u ON t.user_id = u.user_id " +
				"WHERE t.task_id = ? AND t.delete_flg = '0'";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, taskId);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					task = new TaskBean();
					task.setTaskId(rs.getInt("task_id"));
					task.setTaskName(rs.getString("task_name"));
					task.setCategoryId(rs.getInt("category_id"));
					task.setCategoryName(rs.getString("category_name"));
					task.setLimitDate(rs.getDate("limit_date"));
					task.setStatusCode(rs.getString("status_code"));
					task.setStatusName(rs.getString("status_name"));
					task.setMemo(rs.getString("memo"));
					task.setUserName(rs.getString("user_name"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return task;
	}

	/**
	 * タスクを更新する
	 * @param task 更新するタスクの情報
	 */
	public void update(TaskBean task) {
		String sql = "UPDATE t_task SET task_name = ?, category_id = ?, limit_date = ?, " +
				"status_code = ?, memo = ?, update_datetime = CURRENT_TIMESTAMP " +
				"WHERE task_id = ?";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, task.getTaskName());
			pstmt.setInt(2, task.getCategoryId());
			pstmt.setDate(3, task.getLimitDate());
			pstmt.setString(4, task.getStatusCode());
			pstmt.setString(5, task.getMemo());
			pstmt.setInt(6, task.getTaskId());

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 指定したタスクのステータスのみを更新します。
	 * @param taskId
	 * @param statusCode
	 */
	public void updateStatus(int taskId, String statusCode) {
		String sql = "UPDATE t_task SET status_code = ?, update_datetime = CURRENT_TIMESTAMP WHERE task_id = ?";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setString(1, statusCode);
			pstmt.setInt(2, taskId);

			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 	ユーザーIDを指定して、そのユーザーが担当しているタスクを全件取得するメソッド
	 * @param searchUserId
	 * @return List<TaskBean>
	 */
	public List<TaskBean> findByUserId(String searchUserId) {
		List<TaskBean> list = new ArrayList<>();
		StringBuilder sql = new StringBuilder(
				"SELECT t.*, u.user_name, c.category_name, s.status_name " +
						"FROM t_task t " +
						"JOIN m_user u ON t.user_id = u.user_id " +
						"JOIN m_category c ON t.category_id = c.category_id " +
						"JOIN m_status s ON t.status_code = s.status_code " +
						"WHERE t.delete_flg = '0' ");

		if (searchUserId != null && searchUserId != "") {
			sql.append("AND t.user_id = ? ");
		}

		sql.append("ORDER BY t.status_code ASC, t.limit_date ASC");

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

			if (searchUserId != null && searchUserId != "") {
				pstmt.setString(1, searchUserId);
			}

			// ★ここから追加：結果セットを取得してループでリストに追加する
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					TaskBean bean = new TaskBean();
					bean.setTaskId(rs.getInt("task_id"));
					bean.setTaskName(rs.getString("task_name"));
					bean.setLimitDate(rs.getDate("limit_date"));
					bean.setUserId(rs.getString("user_id")); // String型の場合は rs.getString
					bean.setUserName(rs.getString("user_name"));
					bean.setCategoryId(rs.getInt("category_id"));
					bean.setCategoryName(rs.getString("category_name"));
					bean.setStatusCode(rs.getString("status_code"));
					bean.setStatusName(rs.getString("status_name"));

					list.add(bean);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * ステータスコードを条件にタスクを取得する
	 * @param searchStatusCode 検索するステータスコード
	 * @return タスクのリスト
	 */
	public List<TaskBean> findByStatusCode(String searchStatusCode) {
		List<TaskBean> list = new ArrayList<>();

		StringBuilder sql = new StringBuilder("SELECT t.*, c.category_name, s.status_name, u.user_name " +
				"FROM t_task t " +
				"JOIN m_category c ON t.category_id = c.category_id " +
				"JOIN m_status s ON t.status_code = s.status_code " +
				"JOIN m_user u ON t.user_id = u.user_id " +
				"WHERE t.delete_flg = '0' ");

		if (searchStatusCode != null && !searchStatusCode.isEmpty()) {
			sql.append("AND t.status_code = ? ");
		}
		sql.append("ORDER BY t.status_code ASC, t.limit_date ASC");

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

			pstmt.setString(1, searchStatusCode); // ステータスコードをセット

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					TaskBean task = new TaskBean();
					task.setTaskId(rs.getInt("task_id"));
					task.setTaskName(rs.getString("task_name"));
					task.setCategoryId(rs.getInt("category_id"));
					task.setCategoryName(rs.getString("category_name"));
					task.setUserName(rs.getString("user_name"));
					task.setLimitDate(rs.getDate("limit_date"));
					task.setStatusCode(rs.getString("status_code"));
					task.setStatusName(rs.getString("status_name"));
					list.add(task);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * カテゴリIDを条件にタスクを取得する
	 * @param categoryId 検索するカテゴリID
	 * @return タスクのリスト
	 */
	public List<TaskBean> findByCategoryId(int categoryId) {
		List<TaskBean> list = new ArrayList<>();
		StringBuilder sql = new StringBuilder("SELECT t.*, c.category_name, s.status_name, u.user_name " +
				"FROM t_task t " +
				"JOIN m_category c ON t.category_id = c.category_id " +
				"JOIN m_status s ON t.status_code = s.status_code " +
				"JOIN m_user u ON t.user_id = u.user_id " +
				"WHERE t.delete_flg = '0' ");

		if (categoryId > 0) {
			sql.append("AND t.category_id = ? ");
		}
		sql.append("ORDER BY t.status_code ASC, t.limit_date ASC");

		//		String sql = "SELECT t.*, c.category_name, s.status_name, u.user_name " +
		//				"FROM t_task t " +
		//				"JOIN m_category c ON t.category_id = c.category_id " +
		//				"JOIN m_status s ON t.status_code = s.status_code " +
		//				"JOIN m_user u ON t.user_id = u.user_id " +
		//				"WHERE t.delete_flg = '0' AND t.category_id = ? " + // カテゴリIDで絞り込み
		//				"ORDER BY t.status_code ASC, t.limit_date ASC";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

			pstmt.setInt(1, categoryId); // カテゴリIDをセット

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					TaskBean task = new TaskBean();
					task.setTaskId(rs.getInt("task_id"));
					task.setTaskName(rs.getString("task_name"));
					task.setCategoryId(rs.getInt("category_id"));
					task.setCategoryName(rs.getString("category_name"));
					task.setUserName(rs.getString("user_name"));
					task.setLimitDate(rs.getDate("limit_date"));
					task.setStatusCode(rs.getString("status_code"));
					task.setStatusName(rs.getString("status_name"));
					list.add(task);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * タスクを論理削除する
	 * @param taskId 削除対象のタスクID
	 */
	public void delete(int taskId) {
		// delete_flg を '1' に更新し、更新日時も現在時刻にする
		String sql = "UPDATE t_task SET delete_flg = '1', update_datetime = NOW() WHERE task_id = ?";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, taskId);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 複数の条件を組み合わせてタスクを取得するメソッド
	 * @param categoryId カテゴリID（nullや0の場合は条件に含めない）
	 * @param userId ユーザーID（nullや空文字の場合は条件に含めない）
	 * @param statusCode ステータスコード（nullや空文字の場合は条件に含めない）
	 * @return 条件に合致するタスクのリスト
	 */
	public List<TaskBean> findByConditions(Integer categoryId, String userId, String statusCode) {
		List<TaskBean> list = new ArrayList<>();
		StringBuilder sql = new StringBuilder("SELECT t.*, c.category_name, s.status_name, u.user_name " +
				"FROM t_task t " +
				"JOIN m_category c ON t.category_id = c.category_id " +
				"JOIN m_status s ON t.status_code = s.status_code " +
				"JOIN m_user u ON t.user_id = u.user_id " +
				"WHERE t.delete_flg = '0'");

		List<Object> params = new ArrayList<>();

		if (categoryId != null && categoryId > 0) {
			sql.append(" AND t.category_id = ?");
			params.add(categoryId);
		}
		if (userId != null && !userId.isEmpty()) {
			sql.append(" AND t.user_id = ?");
			params.add(userId);
		}
		if (statusCode != null && !statusCode.isEmpty()) {
			sql.append(" AND t.status_code = ?");
			params.add(statusCode);
		}

		sql.append(" ORDER BY t.status_code ASC, t.limit_date ASC");

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

			for (int i = 0; i < params.size(); i++) {
				pstmt.setObject(i + 1, params.get(i));
			}

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					TaskBean task = new TaskBean();
					task.setTaskId(rs.getInt("task_id"));
					task.setTaskName(rs.getString("task_name"));
					task.setCategoryId(rs.getInt("category_id"));
					task.setCategoryName(rs.getString("category_name"));
					task.setUserName(rs.getString("user_name"));
					task.setLimitDate(rs.getDate("limit_date"));
					task.setStatusCode(rs.getString("status_code"));
					task.setStatusName(rs.getString("status_name"));
					list.add(task);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

}
