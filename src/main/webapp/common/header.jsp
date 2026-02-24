<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top shadow">
    <div class="container">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <a class="navbar-brand" href="TaskListServlet">
            <span class="badge bg-primary me-2">CV</span> Task Manager
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="TaskListServlet">タスク一覧</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="TaskRegisterServlet">タスク登録</a>
                </li>
            </ul>
            <div class="d-flex align-items-center">
                <span class="navbar-text text-white me-3">
                    <i class="bi bi-person-circle"></i> ${loginUser.userName} 様
                </span>
                <a href="LogoutServlet" class="btn btn-outline-light btn-sm">ログアウト</a>
            </div>
        </div>
    </div>
</nav>