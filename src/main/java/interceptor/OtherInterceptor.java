package interceptor;

import pojo.OrderItem;
import pojo.User;
import service.CategoryService;
import service.OrderItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

public class OtherInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	CategoryService categoryService;
	@Autowired
	OrderItemService orderItemService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		return true;
	}

	public void postHandle(HttpServletRequest request,
						   HttpServletResponse response, Object handler,
						   ModelAndView modelAndView) throws Exception {

		/* 这里是获取购物车中一共有多少数量 */
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		int cartTotalItemNumber = 0;
		if (null != user) {
			List<OrderItem> ois = orderItemService.listForCart(user.getId());
			for (OrderItem oi : ois) {
				cartTotalItemNumber += oi.getNumber();
			}
		}
		session.setAttribute("cartTotalItemNumber", cartTotalItemNumber);
	}

	public void afterCompletion(HttpServletRequest request,
								HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

//        System.out.println("afterCompletion(), 在访问视图之后被调用");
	}
}
