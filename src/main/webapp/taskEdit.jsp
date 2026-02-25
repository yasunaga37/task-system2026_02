<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>タスク一覧 | コンビニ管理</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* 固定ヘッダー・フッターにコンテンツが被らないための調整 */
        body {
            padding-top: 70px;    /* ヘッダーの高さ分 */
            padding-bottom: 60px; /* フッターの高さ分 */
        }
    </style>
</head>
<body class="bg-light">

    <%@ include file="/common/header.jsp" %>

    <main class="container">
	    <div class="container mt-5">
	    <div class="card shadow-sm mx-auto" style="max-width: 700px;">
	        <div class="card-header bg-success text-white">
	            <h5 class="mb-0">タスクの編集</h5>
	        </div>
	        <div class="card-body">
	            <form action="TaskEditServlet" method="post">
	                <input type="hidden" name="taskId" value="${task.taskId}">
	                
	                <div class="mb-3">
	                    <label class="form-label fw-bold">タスク名</label>
	                    <input type="text" name="taskName" class="form-control" value="${task.taskName}" required>
	                </div>
	
	                <div class="row mb-3">
	                    <div class="col-md-6">
	                        <label class="form-label fw-bold">カテゴリ</label>
	                        <select name="categoryId" class="form-select">
							    <c:forEach var="cat" items="${categoryList}">
							        <%-- カテゴリIDが一致する場合のみ selected を付与 --%>
							        <option value="${cat.categoryId}" ${cat.categoryId == task.categoryId ? 'selected' : ''}>
							            ${cat.categoryName}
							        </option>
							    </c:forEach>
							</select>
	                    </div>
	                    <div class="col-md-6">
	                        <label class="form-label fw-bold">ステータス</label>
							<select name="statusCode" class="form-select">
							    <%-- ステータスコードが一致する場合のみ selected を付与 --%>
							    <option value="00" ${task.statusCode == '00' ? 'selected' : ''}>未着手</option>
							    <option value="10" ${task.statusCode == '10' ? 'selected' : ''}>確認中</option>
							    <option value="50" ${task.statusCode == '50' ? 'selected' : ''}>対応中</option>
							    <option value="90" ${task.statusCode == '90' ? 'selected' : ''}>完了</option>
							</select>
	                    </div>
	                </div>
	
	                <div class="mb-3">
	                    <label class="form-label fw-bold">期限日</label>
	                    <input type="date" name="limitDate" class="form-control" value="${task.limitDate}" required>
	                </div>
	
	                <div class="mb-4">
	                    <label class="form-label fw-bold">備考</label>
	                    <textarea name="memo" class="form-control" rows="4">${task.memo}</textarea>
	                </div>
	
	                <div class="d-flex justify-content-between">
	                    <a href="TaskDetailServlet?taskId=${task.taskId}" class="btn btn-outline-secondary">キャンセル</a>
	                    <button type="submit" class="btn btn-success px-4">更新保存</button>
	                </div>
	            </form>
	        </div>
	    </div>
	</div>
    
    </main>

    <%@ include file="/common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>