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
	    <div class="card mb-4 shadow-sm">
	    <div class="card-header bg-dark text-white d-flex justify-content-between">
	        <span>タスク詳細 #${task.taskId}</span>
	        <span class="badge ${task.categoryColorClass}">${task.categoryName}</span>
	    </div>
	    <div class="card-body">
	        <h3 class="card-title">${task.taskName}</h3>
	        <p class="text-muted">期限：${task.limitDate} / ステータス：${task.statusName}</p>
	        <hr>
	        <p class="card-text">${task.memo}</p>
	    </div>
	</div>
	
	<div class="card shadow-sm">
	    <div class="card-header bg-light fw-bold">コメント・進捗報告</div>
	    <div class="card-body">
	        <c:forEach var="comment" items="${commentList}">
	            <div class="border-bottom mb-3 pb-2 ${comment.parentCommentId != null ? 'ms-5' : ''}">
	                <div class="d-flex justify-content-between small text-muted">
	                    <span><strong>${comment.userName}</strong> さんの発言</span>
	                    <span>${comment.updateDatetime}</span>
	                </div>
	                <div class="mt-1">${comment.commentBody}</div>
	            </div>
	        </c:forEach>
	
	        <form action="CommentRegisterServlet" method="post" class="mt-4">
	            <input type="hidden" name="taskId" value="${task.taskId}">
	            <div class="input-group">
	                <textarea name="commentBody" class="form-control" placeholder="コメントを入力..." required></textarea>
	                <button type="submit" class="btn btn-primary">送信</button>
	            </div>
	        </form>
	    </div>
	</div>
     </main>

    <%@ include file="/common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>