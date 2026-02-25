package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.TaskDAO;

/**
 * Servlet implementation class TaskStatusUpdateServlet
 */
@WebServlet("/TaskStatusUpdateServlet")
public class TaskStatusUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TaskStatusUpdateServlet() {
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
		// 1. パラメータ（taskId, statusCode）を取得
		String taskIdStr = request.getParameter("taskId");
		String statusCode = request.getParameter("statusCode");

		if (taskIdStr != null && statusCode != null) {
			try {
				int taskId = Integer.parseInt(taskIdStr);

				// 2. DAOを呼び出してステータスを更新
				TaskDAO dao = new TaskDAO();
				dao.updateStatus(taskId, statusCode);
				
			    // セッションにメッセージを保存
			    HttpSession session = request.getSession();
			    if ("90".equals(statusCode)) {
			        session.setAttribute("successMsg", "タスクを完了にしました！お疲れ様でした。");
			    } else {
			        session.setAttribute("successMsg", "ステータスを更新しました。");
			    }

				// 3. 更新完了後、元の詳細画面へリダイレクト
				response.sendRedirect("TaskDetailServlet?taskId=" + taskId);
				return;

			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}

		// パラメータ不正などの場合は一覧へ戻す
		response.sendRedirect("TaskListServlet");
	}

}
