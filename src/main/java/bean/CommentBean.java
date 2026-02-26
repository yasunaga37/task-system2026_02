package bean;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * コメントを表すJavaBean
 */
public class CommentBean implements Serializable {
    private int commentId;
    private int taskId;
    private Integer parentCommentId; // 返信の場合は親IDが入る
    private String userId;
    private String userName; // m_userと結合して取得
    private String commentBody;
	private Timestamp updateDatetime;
	private int level; // コメントの階層（0:通常コメント、1:返信）

	public int getCommentId() {
		return commentId;
	}

	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}

	public int getTaskId() {
		return taskId;
	}

	public void setTaskId(int taskId) {
		this.taskId = taskId;
	}

	public Integer getParentCommentId() {
		return parentCommentId;
	}

	public void setParentCommentId(Integer parentCommentId) {
		this.parentCommentId = parentCommentId;
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

	public String getCommentBody() {
		return commentBody;
	}

	public void setCommentBody(String commentBody) {
		this.commentBody = commentBody;
	}

	public Timestamp getUpdateDatetime() {
		return updateDatetime;
	}

	public void setUpdateDatetime(Timestamp createdAt) {
		this.updateDatetime = createdAt;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}
}
