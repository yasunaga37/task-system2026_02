package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.StatusBean;


/**
 * status_mstテーブルに対するデータアクセスオブジェクト
 */
public class StatusDAO {

	/**
	 * 全てのステータス情報を取得する
	 * @return ステータス情報のリスト
	 * @throws Exception
	 */
	public List<StatusBean> findAll()  {
		List<StatusBean> list = new ArrayList<>();

		// 共通のDAOクラスからコネクションを取得
		try (Connection con = DBManager.getConnection();
				PreparedStatement st = con.prepareStatement("SELECT * FROM m_status ORDER BY status_code")) {

			try (ResultSet rs = st.executeQuery()) {
				while (rs.next()) {
					StatusBean sb = new StatusBean();
					sb.setStatusCode(rs.getString("status_code"));
					sb.setStatusName(rs.getString("status_name"));
					list.add(sb);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}	
	
}
