package interceptor;

import pojo.User;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Arrays;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		HttpSession session = request.getSession();
		String[] noNeedAuthPage = new String[]{
				"/home",
				"/searchProduct",
				"/sortProduct",
				"/showProduct",
				"/loginPage",
				"/login",
				"/validate",
				"/registerPage",
				"/register",
				"/registerSuccessPage",
				"/test",
				"/checkLogin",
				"/admin"
		};
		String uri = request.getRequestURI();
		if (!Arrays.asList(noNeedAuthPage).contains(uri)) {
			User user = (User) session.getAttribute("user");
			if (null == user) {
				response.sendRedirect("/loginPage");
				return false;
			}
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}
}
