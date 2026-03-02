<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>タスク一覧 | コンビニ管理</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/task_edit.css">
</head>
<body class="bg-light">

	<%@ include file="/common/header.jsp"%>

	<main class="container">
		<div class="container py-4">
			<div class="card shadow-sm mx-auto" style="max-width: 700px;">
				<div class="card-header bg-success text-white">
					<h5 class="mb-0">タスクの編集</h5>
				</div>
				<div class="card-body">
					<form action="TaskEditServlet" method="post" id="editForm">
						<input type="hidden" name="taskId" value="${task.taskId}">

						<div class="mb-2">
							<label class="form-label fw-bold">タスク #${task.taskId}</label> <input type="text"
								name="taskName" class="form-control form-control-sm"
								value="${task.taskName}" required>
						</div>

						<div class="row g-3">
							<div class="col-md-6 mb-2">
								<label class="form-label fw-bold">カテゴリ</label> <select
									name="categoryId" class="form-select form-select-sm" required>
									<c:forEach var="cat" items="${categoryList}">
										<option value="${cat.categoryId}"
											${cat.categoryId == task.categoryId ? 'selected' : ''}>
											${cat.categoryName}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col-md-6 mb-2">
								<label class="form-label fw-bold">担当者</label> <select
									name="userId" class="form-select form-select-sm" required>
									<c:forEach var="user" items="${userList}">
										<option value="${user.userId}"
											${user.userId == task.userId ? 'selected' : ''}>
											${user.userName}</option>
									</c:forEach>
								</select>
							</div>

							<div class="col-md-6 mb-2">
								<label class="form-label fw-bold">ステータス</label> <select
									name="statusCode" class="form-select form-select-sm">
									<option value="00" ${task.statusCode == '00' ? 'selected' : ''}>未着手</option>
									<option value="10" ${task.statusCode == '10' ? 'selected' : ''}>確認中</option>
									<option value="50" ${task.statusCode == '50' ? 'selected' : ''}>対応中</option>
									<option value="90" ${task.statusCode == '90' ? 'selected' : ''}>完了</option>
								</select>
							</div>
							<div class="col-md-6 mb-2">
								<label class="form-label fw-bold">期限日</label> <input type="date"
									name="limitDate" class="form-control form-control-sm"
									value="${task.limitDate}" required>
							</div>
						</div>

						<div class="mb-3">
							<label class="form-label fw-bold">備考</label>
							<textarea name="memo" class="form-control form-control-sm"
								rows="2">${task.memo}</textarea>
						</div>

						<%-- ボタンエリア（先ほどの削除ボタンを含む） --%>
						<div class="pt-2 border-top">
							<div class="d-flex justify-content-between align-items-center">
								<div>
									<a href="TaskDetailServlet?taskId=${task.taskId}"
										class="btn btn-sm btn-outline-secondary me-2">キャンセル</a>
									<button type="submit" class="btn btn-sm btn-success px-4">更新保存</button>
								</div>
					</form>
					<%-- 編集フォーム終了 --%>

					<%-- 削除フォーム --%>
					<form action="TaskDeleteServlet" method="post"
						onsubmit="return confirm('削除しますか？');">
						<input type="hidden" name="taskId" value="${task.taskId}">
						<button type="submit"
							class="btn btn-link btn-sm text-danger text-decoration-none">
							<i class="bi bi-trash"></i> タスク削除
						</button>
					</form>
				</div>
			</div><%-- card-body の終了 --%>
		</div>

	</main>

	<%@ include file="/common/footer.jsp"%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>