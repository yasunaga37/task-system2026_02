<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><nav class="navbar navbar-expand-lg navbar-light"
	style="background-color: #e3f2fd;">
	<div class="container">
		<a class="navbar-brand fw-bold text-primary" href="TaskListServlet">
			<i class="bi bi-clipboard-check me-2"></i>タスク管理
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarNav">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav me-auto">
				<li class="nav-item"><a class="nav-link" href="TaskListServlet">タスク一覧</a>
				</li>
				<li class="nav-item"><a class="nav-link"
					href="TaskRegisterServlet">タスク登録</a></li>
			</ul>
			<div class="d-flex align-items-center">
				<span class="navbar-text text-secondary me-3"> <i
					class="bi bi-person-circle"></i> ${loginUser.userName} 様
				</span> <a href="LogoutServlet" class="btn btn-outline-primary btn-sm">ログアウト</a>
			</div>
		</div>
	</div>
</nav>