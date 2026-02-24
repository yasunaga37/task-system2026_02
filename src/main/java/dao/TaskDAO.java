package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.TaskBean;

public class TaskDAO {
	public List<TaskBean> findAll() {
		List<TaskBean> list = new ArrayList<>();
		String sql = "SELECT t.*, c.category_name, s.status_name " +
				"FROM t_task t " +
				"JOIN m_category c ON t.category_id = c.category_id " +
				"JOIN m_status s ON t.status_code = s.status_code " +
				"WHERE t.delete_flg = '0' " + // 論理削除フィルタ
				"ORDER BY t.limit_date ASC";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				TaskBean task = new TaskBean();
				task.setTaskId(rs.getInt("task_id"));
				task.setTaskName(rs.getString("task_name"));
				task.setCategoryName(rs.getString("category_name"));
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
}
