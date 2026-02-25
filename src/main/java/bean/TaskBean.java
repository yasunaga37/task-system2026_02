package bean;

import java.io.Serializable;
import java.sql.Date;
import java.time.LocalDate;

public class TaskBean implements Serializable {
	private int taskId;
	private String taskName;
	private int categoryId;
	private String categoryName; // m_categoryから取得
	private Date limitDate;
	private String userId;
	private String statusCode;
	private String statusName; // m_statusから取得
	private String memo;

	public TaskBean() {
	}

	public int getTaskId() {
		return taskId;
	}

	public void setTaskId(int taskId) {
		this.taskId = taskId;
	}

	public String getTaskName() {
		return taskName;
	}

	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public Date getLimitDate() {
		return limitDate;
	}

	public void setLimitDate(Date limitDate) {
		this.limitDate = limitDate;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	
	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	/**
	 * 
	 * @return カテゴリーIDに応じたBootstrapの背景色クラスを返す
	 */
	public String getCategoryColorClass() {
		switch (this.categoryId) {
		case 1:
			return "bg-primary"; // 青
		case 2:
			return "bg-warning text-dark"; // 黄
		case 3:
			return "bg-info text-dark"; // 水色
		case 4:
			return "bg-success"; // 緑
		case 5:
			return "bg-danger"; // 赤
		default:
			return "bg-secondary"; // 灰
		}
	}
	
	/**
	 * ステータスコードに応じた色情報を返すメソッド
	 * @return ステータスコードに応じたBootstrapの背景色クラスを返す
	 */
	public String getStatusColorClass() {
	    switch (this.statusCode) {
	        case "00": return "bg-secondary";
	        case "10": return "bg-warning text-dark";
	        case "50": return "bg-primary";
	        case "90": return "bg-dark";
	        default: return "bg-light text-dark";
	    }
	}


	/**
	 * タスクが期限切れかどうかを判定する
	 * @return 期限切れならtrue、そうでなければfalse
	 */
	public boolean isOverdue() {
		if (this.limitDate == null || "90".equals(this.statusCode)) {
			return false; // 期限未設定、または完了済みなら強調しない
		}
		// 現在の日付を取得
		LocalDate today = LocalDate.now();
		// limitDate (java.sql.Date) を LocalDate に変換して比較
		LocalDate limit = this.limitDate.toLocalDate();

		return limit.isBefore(today); // 今日より前なら true
	}

	
	/**
	 * タスクの期限状態に応じたBootstrapのクラスを返す
	 * @return 期限切れなら "danger"、今日が期限なら "warning"、完了済みなら "muted"、それ以外は ""
	 */
	public String getDeadlineStatus() {
		// 完了済みの場合は一律「muted」
		if ("90".equals(this.statusCode)) {
			return "muted";
		}

		if (this.limitDate == null) {
			return "";
		}

		LocalDate today = LocalDate.now();
		LocalDate limit = this.limitDate.toLocalDate();

		if (limit.isBefore(today)) {
			return "danger"; // 期限切れ
		} else if (limit.isEqual(today)) {
			return "warning"; // 今日が期限
		}

		return ""; // 期限内（正常）
	}

}