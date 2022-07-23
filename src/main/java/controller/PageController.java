package controller;

import pojo.OrderItem;
import service.OrderItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("")
public class PageController {
	@Autowired
	OrderItemService orderItemService;

	@RequestMapping("/loginPage")
	public String loginPage() {
		return "/loginPage.jsp";
	}

	@RequestMapping("/registerSuccessPage")
	public String registerSuccessPage() {
		return "/registerSuccessPage.jsp";
	}

	@RequestMapping("/registerPage")
	public String registerPage() {
		return "/registerPage.jsp";
	}

	@RequestMapping("/test")
	public String testPage(Model model) {
		List<OrderItem> orderItems = orderItemService.getByOrderId(1);
		model.addAttribute("orderItems", orderItems);
		return "/buyPage.jsp";
	}

	@RequestMapping("/payPage")
	public String payPage() {
		return "/alipay.jsp";
	}

	@RequestMapping("/admin")
	public String admin() {
		return "/admin/index.jsp";
	}
}
