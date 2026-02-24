package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.CommentBean;
import bean.TaskBean;
import dao.CommentDAO;
import dao.TaskDAO;

/**
 * Servlet implementation class TaskDetailServlet
 */
@WebServlet("/TaskDetailServlet")
public class TaskDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TaskDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * URLパラメータから taskId を受け取り、タスク本体とコメント一覧の両方を取得します。
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int taskId = Integer.parseInt(request.getParameter("taskId"));
        
        // タスク詳細の取得
        TaskDAO taskDao = new TaskDAO();
        TaskBean task = taskDao.findByPk(taskId);
        
        // コメント一覧の取得
        CommentDAO commentDao = new CommentDAO();
        List<CommentBean> commentList = commentDao.findByTaskId(taskId);
        
        request.setAttribute("task", task);
        request.setAttribute("commentList", commentList);
        
        request.getRequestDispatcher("taskDetail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
