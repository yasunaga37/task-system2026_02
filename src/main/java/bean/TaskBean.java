package bean;

import java.io.Serializable;
import java.sql.Date;

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

	// ゲッター・セッター（Eclipseの機能「ソース > ゲッターおよびセッターの生成」で作成してください）
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
}