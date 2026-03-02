/**
 * 検索フォームのリセット（一覧画面用）
 */
function resetForm() {
	const form = document.getElementById('searchForm');
	if (form) {
		// 全てのselect要素を初期選択（一番上）に戻す
		form.querySelectorAll('select').forEach(select => select.selectedIndex = 0);
		form.submit();
	}
}

/**
 * コメント編集モードへの切り替え（詳細画面用）
 */
function editComment(commentId, taskId) {
	const textElement = document.getElementById('comment-text-' + commentId);
	const currentText = textElement.innerText;

	textElement.innerHTML = `
        <form action="CommentUpdateServlet" method="post" class="mt-2">
            <input type="hidden" name="commentId" value="${commentId}">
            <input type="hidden" name="taskId" value="${taskId}">
            <div class="input-group">
                <input type="text" name="commentBody" class="form-control form-control-sm" value="${currentText}">
                <button class="btn btn-sm btn-primary" type="submit">更新</button>
                <button class="btn btn-sm btn-outline-secondary" type="button" onclick="location.reload()">キャンセル</button>
            </div>
        </form>
    `;
}