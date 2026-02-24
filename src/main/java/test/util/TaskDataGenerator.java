package test.util;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.time.LocalDate;
import java.util.Random;
import java.util.concurrent.ThreadLocalRandom;

public class TaskDataGenerator {
	// 接続情報
	private static final String URL = "jdbc:mysql://localhost:3306/task_db2026_02";
	private static final String USER = "admin2026";
	private static final String PASS = "admin2026";

	public static void main(String[] args) {
		try (Connection conn = DriverManager.getConnection(URL, USER, PASS)) {
			System.out.println("データ生成を開始します...");

			// 50件のタスクを生成
			for (int i = 1; i <= 50; i++) {
				int taskId = insertRandomTask(conn, i);

				// 1つのタスクに対して0～100件のコメントを生成
				int commentCount = new Random().nextInt(101);
				generateCommentsForTask(conn, taskId, commentCount);
			}

			System.out.println("50件のタスクと付随するコメントの生成が完了しました！");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private static int insertRandomTask(Connection conn, int index) throws SQLException {
		String sql = "INSERT INTO t_task (task_name, category_id, limit_date, user_id, status_code, memo, delete_flg) VALUES (?, ?, ?, ?, ?, ?, '0')";

		try (PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			Random rand = new Random();

			pstmt.setString(1, "自動生成タスク No." + index);
			pstmt.setInt(2, rand.nextInt(5) + 1); // カテゴリ 1～5

			// 現在から前後30日のランダムな日付
			long minDay = LocalDate.now().minusDays(30).toEpochDay();
			long maxDay = LocalDate.now().plusDays(30).toEpochDay();
			long randomDay = ThreadLocalRandom.current().nextLong(minDay, maxDay);
			pstmt.setDate(3, Date.valueOf(LocalDate.ofEpochDay(randomDay)));

			String[] users = { "0001", "0002", "0003" };
			pstmt.setString(4, users[rand.nextInt(users.length)]);

			String[] statuses = { "00", "10", "50", "90" };
			pstmt.setString(5, statuses[rand.nextInt(statuses.length)]);

			pstmt.setString(6, "これは自動生成されたテストデータです。詳細は後ほど追記します。");

			pstmt.executeUpdate();

			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next())
				return rs.getInt(1);
		}
		return -1;
	}

	private static void generateCommentsForTask(Connection conn, int taskId, int count) throws SQLException {
		String sql = "INSERT INTO t_comment (task_id, parent_comment_id, user_id, comment_body, delete_flg) VALUES (?, ?, ?, ?, '0')";

		Integer lastCommentId = null; // スレッドを模倣するため、時々直前のコメントを親にする

		try (PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			for (int i = 0; i < count; i++) {
				pstmt.setInt(1, taskId);

				// 30%の確率で前のコメントへの返信（親コメントIDを設定）にする
				if (lastCommentId != null && new Random().nextInt(10) < 3) {
					pstmt.setInt(2, lastCommentId);
				} else {
					pstmt.setNull(2, Types.INTEGER);
				}

				String[] users = { "0001", "0002", "0003", "admin" };
				pstmt.setString(3, users[new Random().nextInt(users.length)]);
				pstmt.setString(4, "テストコメント #" + (i + 1) + " (Task ID:" + taskId + "への発言)");

				pstmt.executeUpdate();

				ResultSet rs = pstmt.getGeneratedKeys();
				if (rs.next()) {
					lastCommentId = rs.getInt(1);
				}
			}
		}
	}

}
