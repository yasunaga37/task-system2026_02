package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.TaskBean;
import dao.TaskDAO;

@WebServlet("/TaskListServlet")
public class TaskListServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. ログインチェック
		HttpSession session = request.getSession();
		if (session.getAttribute("loginUser") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		// 2. データ取得
		TaskDAO dao = new TaskDAO();
		List<TaskBean> taskList = dao.findAll();

		// 3. JSPへ渡す
		request.setAttribute("taskList", taskList);
		request.getRequestDispatcher("taskList.jsp").forward(request, response);
	}
}