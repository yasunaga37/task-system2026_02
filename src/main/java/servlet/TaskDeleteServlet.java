package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.TaskDAO;

/**
 * Servlet implementation class TaskDeleteServlet
 */
@WebServlet("/TaskDeleteServlet")
public class TaskDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TaskDeleteServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1. ログインチェック（念のため）
		if (request.getSession().getAttribute("loginUser") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		// 2. パラメータ（taskId）の取得
		String taskIdStr = request.getParameter("taskId");
		if (taskIdStr != null) {
			int taskId = Integer.parseInt(taskIdStr);

			// 3. 論理削除の実行
			TaskDAO dao = new TaskDAO();
			dao.delete(taskId);
			// 削除完了メッセージをセッションに保存
			request.getSession().setAttribute("flash", "タスク#" + taskId + " を削除しました。");
		}

		// 4. 一覧画面へリダイレクト
		response.sendRedirect("TaskListServlet");
	}

}
