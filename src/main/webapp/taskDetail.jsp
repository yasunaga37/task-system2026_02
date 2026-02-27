<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>タスク一覧 | コンビニ管理</title>
	<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<style>
		/* 固定ヘッダー・フッターにコンテンツが被らないための調整 */
		body {
			padding-top: 70px; /* ヘッダーの高さ分 */
			padding-bottom: 60px; /* フッターの高さ分 */
		}
	</style>
</head>
<body class="bg-light">

	<%@ include file="/common/header.jsp"%>

	<main class="container">

		<!-- 成功メッセージの表示 -->
		<div class="container mt-3">
			<c:if test="${not empty successMsg}">
				<div
					class="alert alert-success alert-dismissible fade show shadow-sm"
					role="alert">
					<i class="bi bi-check-circle-fill me-2"></i> ${successMsg}
					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				</div>
				<%-- 一度表示したらセッションから削除する --%>
				<c:remove var="successMsg" scope="session" />
			</c:if>
		</div>

		<div class="card mb-4 shadow-sm">
			<div 	class="card-header bg-dark text-white d-flex justify-content-between">
				<span>タスク詳細 #${task.taskId}</span> 
				<span class="badge ${task.categoryColorClass}">${task.categoryName}</span>
			</div>
			<div class="card-body">
				<%-- タスク名とボタンを横並びにする --%>
				<div class="d-flex align-items-center mb-4 gap-3">
					<%-- 既存の h3 スタイルを維持 --%>
					<h3 class="card-title fw-bold mb-0">${task.taskName}</h3>

					<div class="d-flex gap-2">
						<%-- 編集ボタン：編集画面へ遷移する --%>
						<a href="TaskEditServlet?taskId=${task.taskId}"
							class="btn btn-sm btn-outline-primary"> 
							<i class="bi bi-pencil-square"></i> 編集する
						</a>

						<%-- 完了ボタン：TaskStatusUpdateServlet に statusCode=90 を送る --%>
						<c:if test="${task.statusCode != '90'}">
							<form action="TaskStatusUpdateServlet" method="post"
								style="display: inline;"
								onsubmit="return confirm('このタスクを完了にしてもよろしいですか？');">
								<input type="hidden" name="taskId" value="${task.taskId}">
								<%-- 完了コード '90' を送信 --%>
								<input type="hidden" name="statusCode" value="90">
								<button type="submit" class="btn btn-sm btn-success">
									<i class="bi bi-check-lg"></i> 完了する
								</button>
							</form>
						</c:if>
					</div>
				</div>

				<p class="text-muted mb-0">
				<div class="mb-3">
					<label class="form-label text-muted small">担当者</label><i class="bi bi-person-fill"></i> ${task.userName} 様
					&nbsp;&nbsp;&nbsp;&nbsp;期限：${task.limitDate} / 	&nbsp;&nbsp;ステータス：${task.statusName}
				</div>
				</p>
				<hr>
				<div class="card-text border p-3 bg-light rounded" style="white-space: pre-wrap;">${task.memo}</div>
			</div>
		</div>

		<div class="card shadow-sm">
			<div class="card-header bg-light fw-bold">コメント・進捗報告</div>
			<div class="card-body">
				<c:forEach var="comment" items="${commentList}">
					<%-- 階層(level)に応じて左側の余白（margin-left）を計算して付与 --%>
					<div class="mb-3 border-start ps-3" style="margin-left: ${(comment.level - 1) * 3}rem;">
						<%-- ユーザー名と日時の表示 --%>
						<div class="d-flex justify-content-between small text-muted">
							<span><i class="bi bi-shop"></i> ${comment.userName} さん</span> 
							<span>${comment.updateDatetime}</span>
						</div>

						<%-- コメント本文：IDを付与してJSから操作可能にする --%>
						<p class="mb-1" id="comment-text-${comment.commentId}">${comment.commentBody}</p>

						<%-- アクションボタン（返信・編集・削除） --%>
						<div class="d-flex gap-2">
							<button class="btn btn-sm btn-link p-0 text-decoration-none"
								onclick="toggleReplyForm(${comment.commentId}, '${comment.userName}')">返信</button>

							<c:if test="${loginUser.userId == comment.userId}">
								<span class="text-muted">|</span>
								<button
									class="btn btn-sm btn-link p-0 text-decoration-none text-secondary"
									onclick="showEditForm(${comment.commentId})">編集</button>

								<form action="CommentDeleteServlet" method="post"
									onsubmit="return confirm('コメントを削除しますか？');"
									style="display: inline;">
									<input type="hidden" name="commentId" value="${comment.commentId}"> 
									<input type="hidden" name="taskId" value="${task.taskId}">
									<button type="submit"
										class="btn btn-sm btn-link p-0 text-decoration-none text-danger">削除</button>
								</form>
							</c:if>
						</div>

						<%-- 返信入力フォーム（既存のものをそのまま維持） --%>
						<div id="replyForm-${comment.commentId}" style="display: none;" class="mt-2">
							<form action="CommentRegisterServlet" method="post">
								<input type="hidden" name="taskId" value="${task.taskId}">
								<input type="hidden" name="parentCommentId" value="${comment.commentId}">
								<div class="input-group">
									<input type="text" name="commentBody"
										id="replyInput-${comment.commentId}"
										class="form-control form-control-sm" placeholder="返信を入力...">
									<button class="btn btn-sm btn-outline-primary" type="submit">送信</button>
								</div>
							</form>
						</div>
					</div>
				</c:forEach>

				<script>
				// 引数に userName を追加
				// 返信フォームの表示・非表示を切り替える関数
				function toggleReplyForm(id, userName) {
				    const form = document.getElementById('replyForm-' + id);
				    const input = document.getElementById('replyInput-' + id);
				    
				    if (form.style.display === 'none') {
				        form.style.display = 'block';
				        // 入力欄が空の場合だけ、宛名をセットする
				        if (input.value === '') {
				            input.value = '@' + userName + ' 様 ';
				        }
				        input.focus(); // すぐに打ち込めるようにフォーカスを当てる
				    } else {
				        form.style.display = 'none';
				    }
				}

				// 編集フォームを表示する関数
				function showEditForm(commentId) {
				    const textElement = document.getElementById('comment-text-' + commentId);
				    const currentText = textElement.innerText;
				    
				    // テキストを編集用のフォームに置き換える
				    textElement.innerHTML = `
				        <form action="CommentUpdateServlet" method="post" class="mt-2">
				            <input type="hidden" name="commentId" value="${commentId}">
				            <input type="hidden" name="taskId" value="${task.taskId}">
				            <div class="input-group">
				                <input type="text" name="commentBody" class="form-control form-control-sm" value="${currentText}">
				                <button class="btn btn-sm btn-primary" type="submit">更新</button>
				                <button class="btn btn-sm btn-outline-secondary" type="button" onclick="location.reload()">キャンセル</button>
				            </div>
				        </form>
				    `;
				}
			</script>

				<form action="CommentRegisterServlet" method="post" class="mt-4">
					<input type="hidden" name="taskId" value="${task.taskId}">
					<div class="mb-3">
						<textarea name="commentBody" class="form-control" rows="3"
							placeholder="進捗報告やコメントを入力してください" required></textarea>
					</div>
					<div class="text-end">
						<button type="submit" class="btn btn-primary px-4"><i class="bi bi-send"></i> 送信する</button>
					</div>
				</form>
			</div>
		</div>
	</main>

	<%@ include file="/common/footer.jsp"%>

	<script 	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>