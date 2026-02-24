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
        <div class="bg-white p-4 shadow-sm rounded">
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
    </main>

    <%@ include file="/common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>