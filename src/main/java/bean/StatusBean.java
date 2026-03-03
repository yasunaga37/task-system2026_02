package bean;

import java.io.Serializable;

/**
 * ステータス情報を保持するBean
 */
public class StatusBean implements Serializable {
	private String statusCode; // ステータスコード (例: 00, 10, 90)
	private String statusName; // ステータス名 (例: 未着手, 進行中, 完了)

	public StatusBean() {
	}

	public StatusBean(String statusCode, String statusName) {
		this.statusCode = statusCode;
		this.statusName = statusName;
	}

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}
}
