package servlet;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.TaskBean;
import bean.UserBean;
import dao.CategoryDAO;
import dao.TaskDAO;

/**
 * Servlet implementation class TaskRegisterServlet
 */
@WebServlet("/TaskRegisterServlet")
public class TaskRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TaskRegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // カテゴリ一覧をDBから取得（プルダウン用）
        CategoryDAO categoryDao = new CategoryDAO();
        request.setAttribute("categoryList", categoryDao.findAll());
        
        // 今日をデフォルトの期限日としてセット
        request.setAttribute("today", LocalDate.now().toString());        
        request.getRequestDispatcher("taskRegister.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. パラメータ取得（EncodingFilterがあるため、setCharacterEncodingは不要）
        String taskName = request.getParameter("taskName");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        Date limitDate = Date.valueOf(request.getParameter("limitDate"));
        String memo = request.getParameter("memo");
        
        // セッションからログインユーザーIDを取得
        UserBean user = (UserBean) request.getSession().getAttribute("loginUser");

        // 2. Beanにセット
        TaskBean task = new TaskBean();
        task.setTaskName(taskName);
        task.setCategoryId(categoryId);
        task.setLimitDate(limitDate);
        task.setMemo(memo);
        task.setUserId(user.getUserId());
        task.setStatusCode("00"); // 未着手で固定

        // 3. DAOで保存
        TaskDAO dao = new TaskDAO();
        dao.insert(task);

        // 4. 一覧へリダイレクト
        response.sendRedirect("TaskListServlet");
	}

}
