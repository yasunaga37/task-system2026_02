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
    
    		<!-- 成功メッセージの表示 -->
    		<div class="container mt-3">
		    <c:if test="${not empty successMsg}">
		        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
		            <i class="bi bi-check-circle-fill me-2"></i>
		            ${successMsg}
		            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		        </div>
		        <%-- 一度表示したらセッションから削除する --%>
		        <c:remove var="successMsg" scope="session" />
		    </c:if>
		</div>
		
	    <div class="card mb-4 shadow-sm">
	    <div class="card-header bg-dark text-white d-flex justify-content-between">
	        <span>タスク詳細 #${task.taskId}</span>	        
	        <span class="badge ${task.categoryColorClass}">${task.categoryName}</span>	        
	    </div>
	    <div class="card-body">
		    <h3 class="card-title fw-bold mb-3">${task.taskName}</h3>
		    
			<div class="d-flex align-items-center mb-3">
				<a href="TaskEditServlet?taskId=${task.taskId}" class="btn btn-sm btn-outline-primary">
			        <i class="bi bi-pencil-square"></i> 編集する
			    </a>&nbsp;&nbsp;&nbsp;&nbsp;
			    <c:if test="${task.statusCode != '90'}">
			        <form action="TaskStatusUpdateServlet" method="post" class="me-2">
			            <input type="hidden" name="taskId" value="${task.taskId}">
			            <input type="hidden" name="statusCode" value="90"> <button type="submit" class="btn btn-sm btn-success">
			                <i class="bi bi-check-circle"></i> 完了にする
			            </button>
			        </form>
			    </c:if>
			</div>
		
		    <p class="text-muted mb-0">
		    		<div class="mb-3">
				    <label class="form-label text-muted small">担当者</label>
				    <i class="bi bi-person-fill"></i> ${task.userName} 様
				    &nbsp;&nbsp;&nbsp;&nbsp;期限：${task.limitDate} / &nbsp;&nbsp;ステータス：${task.statusName}
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
			    
			        <div class="d-flex justify-content-between small text-muted">
			            <%-- 名前が表示されている部分 --%>
			            <span class="comment-author"><strong>${comment.userName}</strong> さんの発言</span>
			            <span>${comment.updateDatetime}</span>
			        </div>
			        <div class="mt-1">${comment.commentId}&nbsp;&nbsp;${comment.commentBody}</div>
			        
			        <%-- 修正ポイント：全てのコメント（親・子問わず）に返信ボタンを表示する --%>
					<div class="mt-2">
					    <button class="btn btn-sm btn-link p-0 text-decoration-none"
					            onclick="toggleReplyForm(${comment.commentId}, '${comment.userName}')">
					        返信
					    </button>
					
					    <%-- 返信入力フォーム --%>
					    <div id="replyForm-${comment.commentId}" style="display:none;" class="mt-2">
					        <form action="CommentRegisterServlet" method="post">
					            <input type="hidden" name="taskId" value="${task.taskId}">
					            <%-- 重要：ここでそのコメント自体のIDを親IDとして送る --%>
					            <input type="hidden" name="parentCommentId" value="${comment.commentId}">
					            
					            <div class="input-group">
					                <input type="text" name="commentBody" id="replyInput-${comment.commentId}"
					                       class="form-control form-control-sm" placeholder="返信を入力...">
					                <button class="btn btn-sm btn-outline-primary" type="submit">送信</button>
					            </div>
					        </form>
					    </div>
					</div>
			    </div>
			</c:forEach>
			
			<script>
				// 引数に userName を追加
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
			</script>
	
	        <form action="CommentRegisterServlet" method="post" class="mt-4">
	            <input type="hidden" name="taskId" value="${task.taskId}">
			    <div class="mb-3">
			        <textarea name="commentBody" class="form-control" rows="3" placeholder="進捗報告やコメントを入力してください" required></textarea>
			    </div>
			    <div class="text-end">
			        <button type="submit" class="btn btn-primary px-4">
			            <i class="bi bi-send"></i> 送信する
			        </button>
			    </div>
	        </form>
	    </div>
	</div>
     </main>

    <%@ include file="/common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>