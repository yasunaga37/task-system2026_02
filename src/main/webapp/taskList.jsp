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
        
        /* ★追加：テーブルを囲むコンテナに高さを指定し、スクロールを許可する */
	    .table-wrapper {
	        max-height: 65vh; /* 画面の高さの65%を表示エリアにする（調整可） */
	        overflow-y: auto; /* 縦スクロールを有効にする */
	        border: 1px solid #dee2e6;
	        border-radius: 4px;
	    }
	
	    /* ★追加：見出し行を固定する */
	    .table-wrapper thead th {
	        position: sticky;
	        top: 0;
	        z-index: 10;
	        background-color: #f8f9fa !important; /* 背景色（table-lightと合わせる） */
	        box-shadow: 0 2px 2px -1px rgba(0,0,0,0.1); /* 境界を分かりやすくする影 */
	    }
    </style>
</head>
<body class="bg-light">

    <%@ include file="/common/header.jsp" %>

    <main class="container">
        <div class="bg-white p-4 shadow-sm rounded">
		    <h5 class="mb-4">タスク一覧</h5>
		    
		    <!-- ★追加：検索フォーム -->
		    <div class="card mb-4 border-0 shadow-sm">
			    <div class="card-body bg-light rounded">
			        <form action="TaskListServlet" method="get" class="row g-3 align-items-end">
			            <div class="col-md-3">
			                <label class="form-label small fw-bold">担当者</label>
			                <select name="searchUser" class="form-select">
			                    <option value="">すべて表示</option>
			                    <c:forEach var="user" items="${userList}">
			                        <option value="${user.userId}" ${user.userId == selectedUserId ? 'selected' : ''}>
			                            ${user.userName}
			                        </option>
			                    </c:forEach>
			                </select>
			            </div>
			
			            <div class="col-md-3">
			                <label class="form-label small fw-bold">カテゴリ</label>
			                <select class="form-select" disabled>
			                    <option>準備中...</option>
			                </select>
			            </div>
			            
			            <div class="col-md-2">
						    <button type="submit" class="btn btn-primary w-100">
						        <i class="bi bi-search"></i> 検索
						    </button>
						</div>
						<div class="col-md-2">
							<button type="button" class="btn btn-outline-secondary w-100" onclick="resetForm()">
							    クリア
							</button>
			            </div>
			            
			        </form>
			    </div>
			</div>
		    
		    <div class="table-wrapper">
			    <table class="table table-hover">
			        <thead class="table-light">
			            <tr>
			            		<th>TaskID</th>
			                <th>期限</th>
			                <th>カテゴリ</th>
			                <th>担当者</th>
			                <th>タスク名</th>
			                <th>ステータス</th>
			                <th>操作</th>
			            </tr>
			        </thead>
			        <tbody>
			            <c:forEach var="task" items="${taskList}">
			                <tr>
			                    <%-- 状態に応じたクラス名を決定 --%>
							    <c:set var="status" value="${task.deadlineStatus}" />
							    
							    <tr class="${status == 'muted' ? 'text-muted' : ''}">
							    		<td>${task.taskId}</td>
							        <td class="
							            ${status == 'danger' ? 'text-danger fw-bold' : ''} 
							            ${status == 'warning' ? 'text-warning fw-bold' : ''}">
							            <c:choose>
							                <c:when test="${status == 'danger'}">
							                    <i class="bi bi-exclamation-triangle-fill"></i> </c:when>
							                <c:when test="${status == 'warning'}">
							                    <i class="bi bi-clock-fill"></i> </c:when>
							            </c:choose>
							            ${task.limitDate}
							        </td>
										<td>
										    <c:choose>
										        <%-- contains を使うか、ID判定にすると確実です --%>
										        <c:when test="${task.categoryId == 1}"><!-- 販売促進　色未定 -->
										            <c:set var="categoryColor" value="bg-info-subtle text-primary-emphasis" />
										        </c:when>
										        <c:when test="${task.categoryId == 2}"><!-- 設備修理　色未定 -->
										            <c:set var="categoryColor" value="bg-primary-subtle text-primary-emphasis" />
										        </c:when>
										        <c:when test="${task.categoryId == 3}"><!-- 清掃・衛生　清潔感のあるグリーン -->
										            <c:set var="categoryColor" value="bg-success-subtle text-success-emphasis" />
										        </c:when>
										        <c:when test="${task.categoryId == 4}"><!-- 報告事項　警戒を促すピンク/レッド -->
										            <c:set var="categoryColor" value="bg-danger-subtle text-danger-emphasis" />
										        </c:when>
										        <c:when test="${task.categoryId == 5}"><!-- 緊急連絡　警戒を促すピンク/レッド -->
										            <c:set var="categoryColor" value="bg-danger-subtle text-danger-emphasis" />
										        </c:when>
										        <c:when test="${task.categoryId == 8}"><!-- 接客・レジ　信頼感のあるブルー -->
										            <c:set var="categoryColor" value="bg-primary-subtle text-primary-emphasis" />
										        </c:when>
										        <c:when test="${task.categoryId == 9}"><!-- 発注・在庫　注意を引くイエロー/オレンジ -->
										            <c:set var="categoryColor" value="bg-warning-subtle text-primary-emphasis" />
										        </c:when>
										        <c:when test="${task.categoryId == 10}"><!-- 売場・POP　鮮やかなライトブルー -->
										            <c:set var="categoryColor" value="bg-info-subtle text-primary-emphasis" />
										        </c:when>
										        <c:when test="${task.categoryId == 11}"><!-- 事務・管理　落ち着いたグレー -->
										            <c:set var="categoryColor" value="bg-secondary-subtle text-primary-emphasis" />
										        </c:when>
										        <c:otherwise>
										            <%-- どれにも当てはまらない場合はグレー --%>
										            <c:set var="categoryColor" value="bg-secondary-subtle text-secondary-emphasis" />
										        </c:otherwise>
										    </c:choose>
										    
										    <span class="badge rounded-pill ${categoryColor}">
										        ${task.categoryName}
										    </span>
										</td>
							        	
							        <td><i class="bi-geo-alt small border">${task.userName}</i></td>
							        
							        <%-- 完了済みはタスク名に打ち消し線を入れるなどのアレンジも可能 --%>
							        <td class="${status == 'muted' ? 'text-decoration-line-through' : ''}">
							            ${task.taskName}
							        </td>
							
							        <td>
	 						            <%-- ステータスのバッジ表示 --%>
									    <%-- ステータスコードに応じた色分け設定 --%>
									    <c:choose>
									        <%-- 完了 (90) の場合：パステルグレー --%>
									        <c:when test="${task.statusCode == '90'}">
									            <c:set var="statusClass" value="bg-secondary-subtle text-secondary-emphasis" />
									        </c:when>
									        
									        <%-- 未着手 (10など) の場合：濃い赤や黄色など（注意を引く） --%>
									        <c:when test="${task.statusCode == '00'}">
									            <c:set var="statusClass" value="bg-danger text-white" />
									        </c:when>
									        
									        <%-- 進行中 (20など) の場合：濃い青（活動的） --%>
									        <c:when test="${task.statusCode == '10'}">
									            <c:set var="statusClass" value="bg-primary text-white" />
									        </c:when>
									        
									        <%-- その他：濃いグレーなど --%>
									        <c:otherwise>
									            <c:set var="statusClass" value="bg-secondary text-white" />
									        </c:otherwise>
									    </c:choose>
									    
									    <%-- 決定したクラスを適用してバッジを表示 --%>
									    <span class="badge rounded-pill ${statusClass}">
									        ${task.statusName}
									    </span>
							        </td>
			                    <td>
			                    		<a href="TaskDetailServlet?taskId=${task.taskId}" class="btn btn-sm btn-outline-primary">詳細</a>
			                        <a href="TaskEditServlet?taskId=${task.taskId}" class="btn btn-sm btn-outline-primary">編集</a>
			                    </td>
			                </tr>
			            </c:forEach>
			        </tbody>
			    </table>
			  </div>
		</div>
    </main>

    <%@ include file="/common/footer.jsp" %>
    
    <script>
		function resetForm() {
		    // セレクトボックスを一番上の「すべて表示」にする
		    document.querySelector('select[name="searchUser"]').selectedIndex = 0;
		    // そのまま検索を実行して一覧を更新する
		    document.querySelector('form').submit();
		}
	</script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>