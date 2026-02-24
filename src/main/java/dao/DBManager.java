package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBManager {
	private static final String URL = "jdbc:mysql://localhost:3306/task_db2026_02";
	private static final String USER = "admin2026";
	private static final String PASS = "admin2026";

	public static Connection getConnection() throws SQLException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			throw new SQLException(e);
		}
		return DriverManager.getConnection(URL, USER, PASS);
	}
}
