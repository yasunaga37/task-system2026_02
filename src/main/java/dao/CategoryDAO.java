package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.CategoryBean;

public class CategoryDAO {
	/**
	 * すべてのカテゴリを取得します。
	 * @return カテゴリBeanのリスト
	 */
	public List<CategoryBean> findAll() {
		List<CategoryBean> list = new ArrayList<>();
		String sql = "SELECT * FROM m_category ORDER BY category_id ASC";

		try (Connection conn = DBManager.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				CategoryBean bean = new CategoryBean();
				bean.setCategoryId(rs.getInt("category_id"));
				bean.setCategoryName(rs.getString("category_name"));
				list.add(bean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
}
