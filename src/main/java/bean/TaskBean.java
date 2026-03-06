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
	private String userName;
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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	/**
	 * 
	 * @return カテゴリーIDに応じたBootstrapの背景色クラスを返す
	 */
	public String getCategoryColorClass() {
	    switch (this.categoryId) {
        case 1: return "bg-info-subtle text-primary-emphasis";        // 販売促進    水色
        case 2: return "bg-warning-subtle text-dark-emphasis";       // 設備修理    黄
        case 3: return "bg-info-subtle text-success-emphasis";        // 清掃・衛生  水色
        case 4: return "bg-success-subtle text-warning-emphasis";  // 報告事項     緑
        case 5: return "bg-danger-subtle text-danger-emphasis";    // 緊急連絡     赤
        case 8: return "bg-primary-subtle text-primary-emphasis";  // 接客・レジ   青
        case 9: return "bg-warning-subtle text-info-emphasis";       // 発注・在庫   黄
        case 10: return "bg-info-subtle text-success-emphasis";      // 売場・POP   水色
        case 11: return "bg-secondary-subtle text-info-emphasis";   // 事務・管理   緑
        default: return "bg-secondary-subtle text-secondary-emphasis"; // その他   緑
	    }
	}

	/**
	 * ステータスコードに応じた色情報を返すメソッド
	 * @return ステータスコードに応じたBootstrapの背景色クラスを返す
	 */
	public String getStatusColorClass() {
		switch (this.statusCode) {
        case "00": return "bg-danger text-white";                            // 未着手   赤
        case "10": return "bg-info text-white";                                 // 確認中   水色  
        case "50": return "bg-primary text-white";                            // 対応中   青
        case "90": return "bg-dark-subtle text-secondary-emphasis";  // 完了     灰色
        default: return "bg-dark text-white";                                    // その他  灰色
		}
	}
	
	/**
	 * カテゴリーIDに応じたBootstrapの枠線クラスを返す
	 * @return カテゴリーIDに応じたBootstrapの枠線クラスを返す
	 */
	public String getCategoryBorderClass() {
	    switch (this.categoryId) {
	        case 1: return "border-info";       // 販売促進
	        case 2: return "border-warning";       // 設備修理
	        case 3: return "border-info";       // 清掃・衛生
	        case 4: return "border-success";        // 報告事項
	        case 5: return "border-danger";        // 緊急連絡
	        case 8: return "border-primary";       // 接客・レジ
	        case 9: return "border-warning";       // 発注・在庫
	        case 10: return "border-info";         // 売場・POP
	        case 11: return "border-secondary";    // 事務・管理
	        default: return "border-secondary";  // その他
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