package servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.TaskBean;
import dao.CategoryDAO;
import dao.TaskDAO;

/**
 * Servlet implementation class TaskEditServlet
 */
@WebServlet("/TaskEditServlet")
public class TaskEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TaskEditServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * 編集画面を表示するための処理
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int taskId = Integer.parseInt(request.getParameter("taskId"));
        
        TaskDAO taskDao = new TaskDAO();
        CategoryDAO categoryDao = new CategoryDAO();
        
        // 編集対象のタスクと、選択肢用のカテゴリ一覧・ステータス一覧を取得
        request.setAttribute("task", taskDao.findByPk(taskId));
        request.setAttribute("categoryList", categoryDao.findAll());
        // ステータスマスタ（m_status）を取得するDAOが未作成の場合は、
        // 簡易的に直接リストを送るか、StatusDAOを作成してください。
        
        request.getRequestDispatcher("taskEdit.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * 更新を実行するための処理
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TaskBean task = new TaskBean();
        task.setTaskId(Integer.parseInt(request.getParameter("taskId")));
        task.setTaskName(request.getParameter("taskName"));
        task.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
        task.setLimitDate(Date.valueOf(request.getParameter("limitDate")));
        task.setStatusCode(request.getParameter("statusCode"));
        task.setMemo(request.getParameter("memo"));

        TaskDAO dao = new TaskDAO();
        dao.update(task);

        // 更新後は詳細画面へ戻る
        response.sendRedirect("TaskDetailServlet?taskId=" + task.getTaskId());
	}

}
