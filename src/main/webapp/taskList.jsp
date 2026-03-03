<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>タスク一覧 | コンビニ管理</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="bg-light">

	<%@ include file="/common/header.jsp"%>

	<main class="container-fluid px-4">
		<div class="bg-white p-2 shadow-sm rounded mb-2">
		    <%-- d-flex で横並び、align-items-center で上下中央揃え、gap-3 で要素間の隙間を確保 --%>
		    <div class="d-flex align-items-center gap-3">
		        
		        <%-- 1. タイトル（改行しないよう text-nowrap を追加） --%>
		        <h4 class="mb-0 text-nowrap" style="font-size: 1.2rem;">
		            <i class="bi bi-list-task"></i> タスク一覧
		        </h4>
		
		        <%-- 2. 検索フォーム（flex-grow-1 で余ったスペースを使い切る） --%>
		        <form action="TaskListServlet" method="get" id="searchForm" class="d-flex align-items-center gap-2 flex-grow-1">
		            
		            <div class="input-group input-group-sm" style="width: auto;">
                        <span class="input-group-text bg-light">カテゴリ</span>
                        <select name="searchCategory" id="searchCategory" class="form-select" style="min-width: 120px;"
                            onchange="clearOtherAndSubmit('category')">
                            <option value="">すべて</option>
                            <c:forEach var="category" items="${categoryList}">
                                <option value="${category.categoryId}" ${param.searchCategory == category.categoryId ? 'selected' : ''}>
                                    ${category.categoryName}
                                </option>
                            </c:forEach>
                         </select>
		            	</div>
		            
		            <div class="input-group input-group-sm" style="width: auto;">
		                <span class="input-group-text bg-light">担当者</span>
		                <select name="searchUser" id="searchUser" class="form-select" style="min-width: 120px;"
					        onchange="clearOtherAndSubmit('user')">
		                    <option value="">すべて</option>
		                    <c:forEach var="user" items="${userList}">
		                        <option value="${user.userId}" ${param.searchUser == user.userId ? 'selected' : ''}>
		                            ${user.userName}
		                        </option>
		                    </c:forEach>
		                </select>
		            </div>
		
		            <div class="input-group input-group-sm" style="width: auto;">
		                <span class="input-group-text bg-light">ステータス</span>
		                <select name="searchStatus" id="searchStatus" class="form-select" onchange="clearOtherAndSubmit('status')">
				            <option value="">すべて</option>
				            <c:forEach var="status" items="${statusList}">
				                <option value="${status.statusCode}" 
				                    ${param.searchStatus == status.statusCode ? 'selected' : ''}>
				                    ${status.statusName}
				                </option>
				            </c:forEach>
				        </select>
		            </div>
		
<!-- 		            <button type="submit" class="btn btn-sm btn-primary text-nowrap"> -->
<!-- 		                <i class="bi bi-search"></i> 検索 -->
<!-- 		            </button> -->
		            <button type="button" class="btn btn-sm btn-outline-secondary"
						onclick="resetForm()">クリア
					</button>
		            
		            <%-- 新規登録ボタンもこの列の右端に寄せる場合は ms-auto を使う --%>
		            <a href="TaskRegisterServlet" class="btn btn-sm btn-success text-nowrap ms-auto">
		                <i class="bi bi-plus-lg"></i> 新規登録
		            </a>
		        </form>
		    </div>
		</div>

		<div class="table-wrapper shadow-sm">
			<table class="table table-hover table-sm mb-0">
				<thead class="table-light">
					<tr>
						<th>TaskID</th>
						<th>期限</th>
						<th>カテゴリ</th>
						<th>担当者</th>
						<th>タスク名</th>
						<th>ステータス</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="task" items="${taskList}">
						<tr>
							<%-- 状態に応じたクラス名を決定 --%>
							<c:set var="status" value="${task.deadlineStatus}" />
						<tr class="${status == 'muted' ? 'text-muted' : ''}">
							<td>${task.taskId}</td>
							<td
								class="
							            ${status == 'danger' ? 'text-danger fw-bold' : ''} 
							            ${status == 'warning' ? 'text-warning fw-bold' : ''}">
								<c:choose>
									<c:when test="${status == 'danger'}">
										<i class="bi bi-exclamation-triangle-fill"></i>
									</c:when>
									<c:when test="${status == 'warning'}">
										<i class="bi bi-clock-fill"></i>
									</c:when>
								</c:choose> ${task.limitDate}
							</td>
							<td><c:choose>
									<%-- contains を使うか、ID判定にすると確実です --%>
									<c:when test="${task.categoryId == 1}">
										<!-- 販売促進　色未定 -->
										<c:set var="categoryColor"
											value="bg-info-subtle text-primary-emphasis" />
									</c:when>
									<c:when test="${task.categoryId == 2}">
										<!-- 設備修理　色未定 -->
										<c:set var="categoryColor"
											value="bg-primary-subtle text-primary-emphasis" />
									</c:when>
									<c:when test="${task.categoryId == 3}">
										<!-- 清掃・衛生　清潔感のあるグリーン -->
										<c:set var="categoryColor"
											value="bg-success-subtle text-success-emphasis" />
									</c:when>
									<c:when test="${task.categoryId == 4}">
										<!-- 報告事項　警戒を促すピンク/レッド -->
										<c:set var="categoryColor"
											value="bg-danger-subtle text-danger-emphasis" />
									</c:when>
									<c:when test="${task.categoryId == 5}">
										<!-- 緊急連絡　警戒を促すピンク/レッド -->
										<c:set var="categoryColor"
											value="bg-danger-subtle text-danger-emphasis" />
									</c:when>
									<c:when test="${task.categoryId == 8}">
										<!-- 接客・レジ　信頼感のあるブルー -->
										<c:set var="categoryColor"
											value="bg-primary-subtle text-primary-emphasis" />
									</c:when>
									<c:when test="${task.categoryId == 9}">
										<!-- 発注・在庫　注意を引くイエロー/オレンジ -->
										<c:set var="categoryColor"
											value="bg-warning-subtle text-primary-emphasis" />
									</c:when>
									<c:when test="${task.categoryId == 10}">
										<!-- 売場・POP　鮮やかなライトブルー -->
										<c:set var="categoryColor"
											value="bg-info-subtle text-primary-emphasis" />
									</c:when>
									<c:when test="${task.categoryId == 11}">
										<!-- 事務・管理　落ち着いたグレー -->
										<c:set var="categoryColor"
											value="bg-secondary-subtle text-primary-emphasis" />
									</c:when>
									<c:otherwise>
										<%-- どれにも当てはまらない場合はグレー --%>
										<c:set var="categoryColor"
											value="bg-secondary-subtle text-secondary-emphasis" />
									</c:otherwise>
								</c:choose> <span class="badge rounded-pill ${categoryColor}">
									${task.categoryName} </span></td>

							<td><i class="bi-geo-alt small border">${task.userName}</i></td>

							<%-- 完了済みはタスク名に打ち消し線を入れるなどのアレンジも可能 --%>
							<td
								class="${status == 'muted' ? 'text-decoration-line-through' : ''}">
								${task.taskName}</td>

							<td>
								<%-- ステータスのバッジ表示 --%> <%-- ステータスコードに応じた色分け設定 --%> <c:choose>
									<%-- 完了 (90) の場合：パステルグレー --%>
									<c:when test="${task.statusCode == '90'}">
										<c:set var="statusClass"
											value="bg-secondary-subtle text-secondary-emphasis" />
									</c:when>

									<%-- 未着手 (10など) の場合：濃い赤や黄色など（注意を引く） --%>
									<c:when test="${task.statusCode == '00'}">
										<c:set var="statusClass" value="bg-danger text-white" />
									</c:when>

									<%-- 進行中 (20など) の場合：濃い青（活動的） --%>
									<c:when test="${task.statusCode == '10'}">
										<c:set var="statusClass" value="bg-primary text-white" />
									</c:when>

									<%-- その他：濃いグレーなど --%>
									<c:otherwise>
										<c:set var="statusClass" value="bg-secondary text-white" />
									</c:otherwise>
								</c:choose> <%-- 決定したクラスを適用してバッジを表示 --%> <span
								class="badge rounded-pill ${statusClass}">
									${task.statusName} </span>
							</td>
							<td><a href="TaskDetailServlet?taskId=${task.taskId}"
								class="btn btn-sm btn-outline-primary">詳細</a> 
								<a href="TaskEditServlet?taskId=${task.taskId}"
								class="btn btn-sm btn-outline-primary">編集</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		</div>
	</main>

	<%@ include file="/common/footer.jsp"%>

	<script src="${pageContext.request.contextPath}/js/script.js"></script>

	<script 	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>