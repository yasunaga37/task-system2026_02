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
 * 返信フォームの表示切り替え
 * @param {string} id - コメントID等
 * @param {string} userName - 返信先ユーザー名
 */
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

/**
 * 編集フォームの表示
 * @param {string} commentId - コメントID
 * @param {string} taskId - タスクID（JSPから渡す）
 */
function showEditForm(commentId, taskId) {
	const textElement = document.getElementById('comment-text-' + commentId);
	if (!textElement) return;

	const currentText = textElement.innerText;

	// 外部JSファイルなので、EL式の退避（\${}）は不要になり、
	// 純粋なJavaScriptのテンプレートリテラルとして記述できます。
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

/**
 * 片方のセレクトが変更されたら、もう片方をクリアして submit
 */
function clearOtherAndSubmit(changed) {
	const category = document.getElementById('searchCategory');
    const user = document.getElementById('searchUser');
    const status = document.getElementById('searchStatus');

	if (changed === 'category') {
	    if (status) status.selectedIndex = 0;
		if (user) user.selectedIndex = 0;
	} else if (changed === 'user') {
		if (category) category.selectedIndex = 0;
        if (status) status.selectedIndex = 0;		
    } else if (changed === 'status') {
		if (category) category.selectedIndex = 0;
        if (user) user.selectedIndex = 0;
    }

    document.getElementById('searchForm').submit();
}

