package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

// すべてのURL（/*）に対して実行する
@WebFilter("/*")
public class EncodingFilter implements Filter {
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
		String path = ((HttpServletRequest)request).getServletPath();
		if (path.matches(".*\\.(css|js|jpg|png|gif)$")) {
		    chain.doFilter(request, response); // 何もしないで次へ
		    return;
		}

		// リクエストとレスポンスの文字コードを設定
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		// 次の処理（別のフィルターやサーブレット）へ渡す
		chain.doFilter(request, response);
	}
}
