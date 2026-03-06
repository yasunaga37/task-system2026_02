<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-light fixed-top" style="background-color: #e3f2fd;">
	<div class="container">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
            <a class="navbar-brand fw-bold text-primary" href="TaskListServlet"> 
            	<i class="bi bi-clipboard-check me-2"></i>タスク管理 
            </a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav me-auto">
				<li class="nav-item">
				    <a class="nav-link fw-bold text-primary border-primary border-2" href="TaskListServlet">
				      <i class="bi bi-list-task me-1"></i>タスク一覧
				    </a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link fw-bold text-primary border-primary border-2" href="TaskRegisterServlet">
				      <i class="bi bi-plus-circle me-1"></i>タスク登録
				    </a>
				  </li>
			</ul>
			<div class="d-flex align-items-center">
<!-- 				<span class="navbar-text text-secondary me-3">  -->
<%-- 					<i	class="bi bi-person-circle"></i> ${loginUser.userName} 様 --%>
<!-- 				</span>  -->
				<span class="navbar-text me-3">
				  <span class="badge bg-primary-subtle text-primary-emphasis border border-primary border-2 rounded-pill px-3 py-1 fs-6">
				    <i class="bi bi-person-circle me-1"></i>${loginUser.userName} 様
				  </span>
				</span>
				<a href="LogoutServlet" class="btn btn-outline-primary btn-sm" onclick="return confirm('ログアウトしますか？');">ログアウト</a>
			</div>
		</div>
	</div>
</nav>