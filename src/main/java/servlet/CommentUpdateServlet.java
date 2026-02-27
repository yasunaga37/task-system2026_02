package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CommentDAO;

/**
 * Servlet implementation class CommentUpdateServlet
 */
@WebServlet("/CommentUpdateServlet")
public class CommentUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CommentUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 * コメントの更新処理を行う
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int commentId = Integer.parseInt(request.getParameter("commentId"));
        String taskId = request.getParameter("taskId");
        String commentBody = request.getParameter("commentBody");

        CommentDAO dao = new CommentDAO();
        dao.updateComment(commentId, commentBody);

        response.sendRedirect("TaskDetailServlet?taskId=" + taskId);
	}

}
