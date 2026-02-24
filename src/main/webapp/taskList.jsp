<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>タスク一覧 | コンビニ管理</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container">
        <a class="navbar-brand" href="TaskListServlet">Task System</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link active" href="TaskListServlet">タスク一覧</a></li>
                <li class="nav-item"><a class="nav-link" href="TaskRegisterServlet">タスク登録</a></li>
            </ul>
            <span class="navbar-text me-3">
                ログイン中：${loginUser.userName} 様
            </span>
            <a href="LogoutServlet" class="btn btn-outline-light btn-sm">ログアウト</a>
        </div>
    </div>
</nav>

<div class="container bg-white p-4 shadow-sm rounded">
    <h2 class="mb-4">タスク一覧</h2>
    
    <table class="table table-hover">
        <thead class="table-light">
            <tr>
                <th>期限</th>
                <th>カテゴリ</th>
                <th>タスク名</th>
                <th>ステータス</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="task" items="${taskList}">
                <tr>
                    <td>${task.limitDate}</td>
                    <td><span class="badge bg-info text-dark">${task.categoryName}</span></td>
                    <td>${task.taskName}</td>
                    <td>
                        <c:choose>
                            <c:when test="${task.statusCode == '90'}"><span class="badge bg-secondary">${task.statusName}</span></c:when>
                            <c:when test="${task.statusCode == '50'}"><span class="badge bg-primary">${task.statusName}</span></c:when>
                            <c:otherwise><span class="badge bg-warning text-dark">${task.statusName}</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="TaskEditServlet?taskId=${task.taskId}" class="btn btn-sm btn-outline-primary">編集</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>