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
