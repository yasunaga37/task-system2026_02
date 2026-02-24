package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.UserBean;
import dao.UserDAO;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. 入力値の取得
		request.setCharacterEncoding("UTF-8");
		String userId = request.getParameter("userId");
		String pass = request.getParameter("password");

		// 2. 認証処理
		UserDAO dao = new UserDAO();
		UserBean user = dao.login(userId, pass);

		if (user != null) {
			// ログイン成功：セッションに保存して一覧画面へ
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", user);
			response.sendRedirect("TaskListServlet");
		} else {
			// ログイン失敗：エラーメッセージを持ってログイン画面に戻る
			request.setAttribute("errorMsg", "ユーザーIDまたはパスワードが正しくありません。");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
}
