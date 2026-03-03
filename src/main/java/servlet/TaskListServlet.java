package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.StatusBean;
import bean.TaskBean;
import bean.UserBean;
import dao.StatusDAO;
import dao.TaskDAO;
import dao.UserDAO;

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

		// 2. 検索パラメータ（担当者ID）の取得
		// <select name="searchUser"> の値を受け取ります
		String userIdStr = request.getParameter("searchUser");
		String searchUserId = null;
		
		if (userIdStr != null && !userIdStr.isEmpty()) {
			searchUserId = userIdStr.trim();
		}
		
		// 2. 検索パラメータ（ステータスコード）の取得
		// <select name="searchStatus"> の値を受け取ります
		String statusCode = request.getParameter("searchStatus");
		String searchStatusCode = null;
		
		if (statusCode != null && !statusCode.isEmpty()) {
			searchStatusCode = statusCode.trim();
		}

		// 3. データ取得
		TaskDAO taskDao = new TaskDAO();
		UserDAO userDao = new UserDAO();
		StatusDAO statusDao = new StatusDAO();
		
		// 絞り込み条件を引数に渡してタスク一覧を取得
		List<TaskBean> taskList = null;
		
		if (searchUserId == null && searchStatusCode == null) {
			taskList = taskDao.findAll();
		} else if (searchUserId != null  && !searchUserId.isEmpty() && searchStatusCode == null) {
			taskList = taskDao.findByUserId(searchUserId);
		} else if (searchStatusCode != null && !searchStatusCode.isEmpty() && searchUserId == null) {
			taskList = taskDao.findByStatusCode(searchStatusCode);
		} else {
			taskList = taskDao.findAll();
		}
		
		// プルダウン表示用の全ユーザーリストを取得
		List<UserBean> userList = userDao.findAll();
		
		// プルダウン表示用のステータスのリストを取得
		List<StatusBean> statusList = statusDao.findAll(); 

		// 4. JSPへ渡す
		request.setAttribute("taskList", taskList);
		request.setAttribute("userList", userList); // プルダウン用
		request.setAttribute("statusList", statusList); // プルダウン用
//		request.setAttribute("selectedUserId", searchUserId); // 検索条件の保持用
//		request.setAttribute("selectedStatusCode", searchStatusCode); // 検索条件の保持用

		request.getRequestDispatcher("taskList.jsp").forward(request, response);
	}
}