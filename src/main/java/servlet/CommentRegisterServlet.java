package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.CommentBean;
import bean.UserBean;
import dao.CommentDAO;

/**
 * Servlet implementation class CommentRegisterServlet
 */
@WebServlet("/CommentRegisterServlet")
public class CommentRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CommentRegisterServlet() {
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
		// 1. パラメータの取得
		String taskIdStr = request.getParameter("taskId");
		String commentBody = request.getParameter("commentBody");

		// セッションからログインユーザー情報を取得
		HttpSession session = request.getSession();
		UserBean user = (UserBean) session.getAttribute("loginUser");

		if (taskIdStr != null && user != null) {
			int taskId = Integer.parseInt(taskIdStr);

			// 2. Beanに値をセット
			CommentBean comment = new CommentBean();
			comment.setTaskId(taskId);
			comment.setUserId(user.getUserId());
			comment.setCommentBody(commentBody);

			// 3. DAOで保存
			CommentDAO dao = new CommentDAO();
			dao.insert(comment);

			// 4. 元のタスク詳細画面へリダイレクト（taskIdをパラメータに付ける）
			response.sendRedirect("TaskDetailServlet?taskId=" + taskId);
		} else {
			// エラー時やセッション切れ時はログイン画面へ
			response.sendRedirect("login.jsp");
		}
	}

}
