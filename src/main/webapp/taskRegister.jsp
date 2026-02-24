<%@ page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>新規タスク登録 | コンビニ管理</title>
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
		    <div class="card shadow-sm mx-auto" style="max-width: 600px;">
		        <div class="card-header bg-primary text-white">
		            <h5 class="mb-0">新規タスク登録</h5>
		        </div>
		        <div class="card-body p-4">
		            <form action="TaskRegisterServlet" method="post">
		                <div class="mb-3">
		                    <label class="form-label fw-bold">タスク名</label>
		                    <input type="text" name="taskName" class="form-control" placeholder="例：アイスの在庫確認" required>
		                </div>
		
		                <div class="row">
		                    <div class="col-md-6 mb-3">
		                        <label class="form-label fw-bold">カテゴリ</label>
		                        <select name="categoryId" class="form-select">
		                            <c:forEach var="cat" items="${categoryList}">
		                                <option value="${cat.categoryId}">${cat.categoryName}</option>
		                            </c:forEach>
		                        </select>
		                    </div>
		                    <div class="col-md-6 mb-3">
		                        <label class="form-label fw-bold">期限日</label>
		                        <input type="date" name="limitDate" class="form-control" value="${today}" required>
		                    </div>
		                </div>
		
		                <div class="mb-4">
		                    <label class="form-label fw-bold">備考</label>
		                    <textarea name="memo" class="form-control" rows="3"></textarea>
		                </div>
		
		                <div class="d-flex justify-content-between">
		                    <a href="TaskListServlet" class="btn btn-outline-secondary">キャンセル</a>
		                    <button type="submit" class="btn btn-primary px-4">登録する</button>
		                </div>
		            </form>
		        </div>
		    </div>
		</div>
	</main>	

	<%@ include file="/common/footer.jsp"%>

	<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>