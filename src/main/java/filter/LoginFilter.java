package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*") // 一旦すべてに適用し、内部で除外判定を行う
public class LoginFilter implements Filter {
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpSession session = req.getSession(false);

		// リクエストされたURL（パス）を取得
		String uri = req.getRequestURI();

		// ログインチェックを「除外」する対象（ログイン画面、ログイン実行サーブレット、CSS/画像など）
		boolean isLoginPage = uri.endsWith("login.jsp") || uri.endsWith("LoginServlet");
		boolean isStaticResource = uri.contains("/css/") || uri.contains("/js/") || uri.contains("/images/");

		if (isLoginPage || isStaticResource) {
			// 除外対象ならそのまま通す
			chain.doFilter(request, response);
		} else {
			// ログイン済みかチェック
			if (session != null && session.getAttribute("loginUser") != null) {
				// ログイン済みなら通す
				chain.doFilter(request, response);
			} else {
				// 未ログインならログイン画面へリダイレクト
				res.sendRedirect(req.getContextPath() + "/login.jsp");
			}
		}
	}
}
