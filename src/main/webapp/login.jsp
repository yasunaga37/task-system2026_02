<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ログイン | コンビニタスク管理システム</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .login-container { max-width: 400px; margin-top: 100px; }
        .card { border: none; border-radius: 1rem; box-shadow: 0 0.5rem 1rem 0 rgba(0, 0, 0, 0.1); }
    </style>
</head>
<body>

<div class="container login-container">
    <div class="card p-4">
        <div class="card-body">
            <h3 class="card-title text-center mb-4">Task Manager</h3>
            <h6 class="text-muted text-center mb-4">コンビニ運営タスク管理</h6>
            
            <%-- ログインエラー時のメッセージ表示 --%>
            <% if (request.getAttribute("errorMsg") != null) { %>
                <div class="alert alert-danger p-2 small" role="alert">
                    <%= request.getAttribute("errorMsg") %>
                </div>
            <% } %>

            <form action="LoginServlet" method="post">
                <div class="mb-3">
                    <label for="userId" class="form-label small">ユーザーID</label>
                    <input type="text" class="form-control" id="userId" name="userId" required autofocus>
                </div>
                <div class="mb-4">
                    <label for="password" class="form-label small">パスワード</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary py-2">ログイン</button>
                </div>
            </form>
        </div>
    </div>
    <p class="text-center text-muted mt-4 small">&copy; 2026 Convenience Chain Co., Ltd.</p>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>