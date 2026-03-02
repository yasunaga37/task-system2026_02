<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>タスク一覧 | コンビニ管理</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
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
		<div class="container mt-5">
			<div class="card shadow-sm mx-auto" style="max-width: 700px;">
				<div class="card-header bg-success text-white">
					<h5 class="mb-0">タスクの編集 taskId#${task.taskId}</h5>
				</div>
				<div class="card-body">
					<form action="TaskEditServlet" method="post">
						<input type="hidden" name="taskId" value="${task.taskId}">

						<div class="mb-3">
							<label class="form-label fw-bold">タスク名</label> <input type="text"
								name="taskName" class="form-control" value="${task.taskName}"
								required>
						</div>

						<div class="row mb-3">
							<div class="col-md-6">
								<label class="form-label fw-bold">カテゴリ</label> <select
									name="categoryId" class="form-select">
									<c:forEach var="cat" items="${categoryList}">
										<%-- カテゴリIDが一致する場合のみ selected を付与 --%>
										<option value="${cat.categoryId}"
											${cat.categoryId == task.categoryId ? 'selected' : ''}>
											${cat.categoryName}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-md-6">
								<label class="form-label fw-bold">ステータス</label> <select
									name="statusCode" class="form-select">
									<%-- ステータスコードが一致する場合のみ selected を付与 --%>
									<option value="00" ${task.statusCode == '00' ? 'selected' : ''}>未着手</option>
									<option value="10" ${task.statusCode == '10' ? 'selected' : ''}>確認中</option>
									<option value="50" ${task.statusCode == '50' ? 'selected' : ''}>対応中</option>
									<option value="90" ${task.statusCode == '90' ? 'selected' : ''}>完了</option>
								</select>
							</div>
						</div>

						<div class="mb-3">
							<label class="form-label fw-bold">期限日</label> <input type="date"
								name="limitDate" class="form-control" value="${task.limitDate}"
								required>
						</div>

						<div class="mb-4">
							<label class="form-label fw-bold">備考</label>
							<textarea name="memo" class="form-control" rows="4">${task.memo}</textarea>
						</div>

						<%-- ボタンエリアの修正 --%>
						<div class="mt-4 pt-3 border-top">
							<div class="d-flex justify-content-between align-items-center">
								<%-- 左側：キャンセルと更新（メインのアクション） --%>
								<div>
									<a href="TaskDetailServlet?taskId=${task.taskId}"
										class="btn btn-outline-secondary me-2"> キャンセル </a>
									<button type="submit" class="btn btn-success px-4">
										<i class="bi bi-check-lg"></i> 更新保存
									</button>
								</div>

								<%-- 右側：削除（破壊的なアクションなので離す） --%>
								<%-- 編集用フォームとは別に、削除用のPOSTフォームを用意します --%>
							</div>
						</div>
					</form>
					<%-- 編集用フォームの終了 --%>

                    <%-- 削除用フォーム（カードのボディ内、編集フォームの外に配置） --%>
		            <div class="d-flex justify-content-end mt-2">
		                <form action="TaskDeleteServlet" method="post" 
		                      onsubmit="return confirm('このタスクを削除しますか？\n削除すると一覧には表示されなくなります。');">
		                    <input type="hidden" name="taskId" value="${task.taskId}">
		                    <button type="submit" class="btn btn-outline-danger btn-sm">
		                        <i class="bi bi-trash"></i> タスクを削除
		                    </button>
		                </form>
		            </div>	
				</div> <%-- card-body の終了 --%>
			</div>
		</div>

	</main>

	<%@ include file="/common/footer.jsp"%>

	<script 	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>