package controller;

import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.*;
import service.*;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;

@Controller
public class ForeController {

	@Autowired
	CategoryService categoryService;

	@Autowired
	ReferalLinkService referalLinkService;

	@Autowired
	ProductService productService;

	@Autowired
	PropertyValueService propertyValueService;

	@Autowired
	ReviewService reviewService;

	@Autowired
	UserService userService;

	@Autowired
	OrderItemService orderItemService;

	@Autowired
	OrderService orderService;


	@RequestMapping("/home")
	public String home(Model model) {
		List<Category> categories = categoryService.list();
		productService.fill(categories);
		productService.fillByRow(categories);
		List<ReferalLink> links = referalLinkService.listAll();

		model.addAttribute("categories", categories);
		model.addAttribute("links", links);

		return "/index.jsp";
	}

	@RequestMapping("/showProduct")
	public String showProduct(Model model, Integer product_id) {
		Product product = productService.get(product_id);
		productService.setReviewCount(product);
		model.addAttribute("product", product);
		List<PropertyValue> propertyValues = propertyValueService.listByProductId(product_id);
		model.addAttribute("propertyValues", propertyValues);
		List<Review> reviews = reviewService.listByProductId(product_id);
		model.addAttribute("reviews", reviews);
		return "/product.jsp";
	}

	@RequestMapping("/searchProduct")
	public String searchProduct(Model model, String keyword) {

		PageHelper.offsetPage(0, 20);
		List<Product> products = productService.search(keyword);
		for (Product product : products) {
			product.setReviewCount(reviewService.getCount(product.getId()));
		}
		model.addAttribute("products", products);
		return "/searchResult.jsp";
	}

	@RequestMapping("/sortProduct")
	public String sortProduct(Model model, String sort, String keyword) {
		List<Product> products = productService.search(keyword);
		for (Product product : products) {
			product.setReviewCount(reviewService.getCount(product.getId()));
		}
		if (null != sort) {
			switch (sort) {
				case "all":
					Collections.sort(products, Comparator.comparing(Product::getSaleXReviewCount));
					break;
				case "reviewCount":
					Collections.sort(products, Comparator.comparing(Product::getReviewCount));
					break;
				case "date":
//					Collections.sort(products, comparing(Product::get));
					break;
				case "sale":
					Collections.sort(products, Comparator.comparing(Product::getSale));
					break;
				case "price":
					Collections.sort(products, Comparator.comparing(Product::getPrice));
					break;
			}
		}
		model.addAttribute("products", products);

		return "/searchResult.jsp";
	}

	private int width = 60;
	private int height = 20;

	private int codeCount = 4;
	private int x = 0;
	private int fontHeight;
	private int codeY;
	// 数据字典,避开易混淆的字母和数字
	char[] codeSequence = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'm', 'n', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'M', 'N', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '2', '3', '4', '5', '6', '7', '8', '9'};

	@RequestMapping("/validate")
	public void validate(HttpServletRequest request, HttpServletResponse response) throws IOException {
		Random random = new Random();

		x = width / (codeCount + 1);
		fontHeight = height - 2;
		codeY = height - 4;

		BufferedImage buffImg = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		Graphics2D g = buffImg.createGraphics();
		g.setColor(Color.WHITE);
		g.fillRect(0, 0, width, height);
		Font font = new Font("Fixedsys", Font.PLAIN, fontHeight);
		g.setFont(font);
		g.setColor(Color.BLACK);
		g.drawRect(0, 0, width - 1, height - 1);
		g.setColor(Color.BLACK);
		for (int i = 0; i < 8; i++) {
			int x = random.nextInt(width);
			int y = random.nextInt(height);
			int xl = random.nextInt(8);
			int yl = random.nextInt(8);
			g.drawLine(x, y, x + xl, y + yl);
		}

		// 生成随机数
		StringBuffer randomCode = new StringBuffer();
		int red = 0, green = 0, blue = 0;
		for (int i = 0; i < codeCount; i++) {
			String strRand = String.valueOf(codeSequence[random.nextInt(54)]);
			red = random.nextInt(255);
			green = random.nextInt(255);
			blue = random.nextInt(255);
			g.setColor(new Color(red, green, blue));
			g.drawString(strRand, (i + 1) * x, codeY);
			randomCode.append(strRand);
		}

		// 随机数放在 session 中
		HttpSession session = request.getSession();
		System.out.println(randomCode);
		session.setAttribute("validateCode", randomCode.toString());

		// 输出图片，禁止图像缓存
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setContentType("image/jpeg");

		ServletOutputStream out = response.getOutputStream();
		ImageIO.write(buffImg, "jpeg", out);
		out.flush();
		out.close();
	}

	@RequestMapping("/login")
	public String login(Model model,
						@RequestParam("name") String name,
						@RequestParam("password") String password,
						@RequestParam("VCode") String VCode,
						HttpSession session) {
		String validateCode = (String) session.getAttribute("validateCode");
		if (VCode.equalsIgnoreCase(validateCode)) {
			User user = userService.get(name, password);
			if (null == user) {
				model.addAttribute("msg", "账号密码错误");
				return "/loginPage.jsp";
			}
			session.setAttribute("user", user);
			return "redirect:home";
		} else {
			model.addAttribute("msg", "验证码错误");
			return "/loginPage.jsp";
		}
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("user");
		return "redirect:home";
	}

	@RequestMapping("/register")
	public String register(Model model, User user) {
		String name = user.getName();
		boolean exist = userService.isExist(name);

		if (exist) {
			String msg = "用户名已经被占用，不能使用";
			model.addAttribute("msg", msg);
			model.addAttribute("username", user.getName());
			return "/registerPage.jsp";
		}
		userService.add(user);

		return "/registerSuccessPage.jsp";
	}

	@RequestMapping("/buyone")
	public String buyone(Integer product_id, Integer number, HttpSession session) {
		Product product = productService.get(product_id);
		int orderItemId = 0;

		User user = (User) session.getAttribute("user");
		boolean found = false;
		List<OrderItem> orderItems = orderItemService.listByUserId(user.getId());
		for (OrderItem orderItem : orderItems) {
			if (orderItem.getProduct_id().intValue() == product.getId().intValue()) {
				orderItem.setNumber(orderItem.getNumber() + number);
				orderItemService.update(orderItem);
				orderItemId = orderItem.getId();
				break;
			}
		}

		if (!found) {
			OrderItem orderItem = new OrderItem();
			orderItem.setUser_id(user.getId());
			orderItem.setNumber(number);
			orderItem.setProduct_id(product_id);
			orderItemService.add(orderItem);
			orderItemId = orderItem.getId();
		}

		return "redirect:buy?orderItemId=" + orderItemId;
	}

	@RequestMapping("/buy")
	public String buy(Model model, String[] orderItemId, HttpSession session) {
		List<OrderItem> orderItems = new ArrayList<>();
		float total = 0;

		for (String strId : orderItemId) {
			int id = Integer.parseInt(strId);
			OrderItem oi = orderItemService.getById(id);
			total += oi.getProduct().getPrice() * oi.getNumber();
			orderItems.add(oi);
		}

		session.setAttribute("orderItems", orderItems);
		model.addAttribute("total", total);
		return "/buyPage.jsp";
	}

	@RequestMapping("/createOrder")
	public String createOrder(Model model, Order order, HttpSession session) {
		User user = (User) session.getAttribute("user");
		String orderCode = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date());
		order.setOrder_code(orderCode);
		order.setCreate_date(new Date());
		order.setUser_id(user.getId());
		order.setStatus(OrderService.waitPay);
		List<OrderItem> orderItems = (List<OrderItem>) session.getAttribute("orderItems");
		float total = orderService.add(order, orderItems);
		return "redirect:payPage?order_id=" + order.getId() + "&total=" + total;
	}

	@RequestMapping("/payed")
	public String payed(int order_id, float total, Model model) {
		Order order = orderService.get(order_id);
		order.setStatus(OrderService.waitDelivery);
		order.setPay_date(new Date());
		orderService.update(order);
		model.addAttribute("o", order);
		return "/payed.jsp";
	}

	@RequestMapping("/addCart")
	@ResponseBody
	public String addCart(int product_id, int num, Model model, HttpSession session) {
		Product p = productService.get(product_id);
		User user = (User) session.getAttribute("user");
		boolean found = false;

		List<OrderItem> ois = orderItemService.listByUserId(user.getId());
		for (OrderItem oi : ois) {
			if (oi.getProduct().getId().intValue() == p.getId().intValue()) {
				oi.setNumber(oi.getNumber() + num);
				orderItemService.update(oi);
				found = true;
				break;
			}
		}

		if (!found) {
			OrderItem oi = new OrderItem();
			oi.setUser_id(user.getId());
			oi.setNumber(num);
			oi.setProduct_id(product_id);
			orderItemService.add(oi);
		}

		return "success";
	}

	@RequestMapping("/cart")
	public String cart(Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		List<OrderItem> orderItems = orderItemService.listForCart(user.getId());
		model.addAttribute("orderItems", orderItems);
		return "/cart.jsp";
	}

	@RequestMapping("/checkLogin")
	@ResponseBody
	public String checkLogin(HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (null != user)
			return "success";
		return "fail";
	}

	@RequestMapping("/changeOrderItem")
	@ResponseBody
	public String changeOrderItem(Model model, HttpSession session, int product_id, int number) {
		User user = (User) session.getAttribute("user");
		if (null == user)
			return "fail";

		List<OrderItem> ois = orderItemService.listByUserId(user.getId());
		for (OrderItem oi : ois) {
			if (oi.getProduct().getId().intValue() == product_id) {
				oi.setNumber(number);
				orderItemService.update(oi);
				break;
			}
		}
		return "success";
	}

	@RequestMapping("/deleteOrderItem")
	@ResponseBody
	public String deleteOrderItem(Model model, HttpSession session, Integer orderItemId) {
		User user = (User) session.getAttribute("user");
		if (null == user)
			return "fail";
		orderItemService.delete(orderItemId);
		return "success";
	}

	@RequestMapping("/bought")
	public String bought(Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		List<Order> orders = orderService.list(user.getId(), OrderService.delete);
		orderItemService.fill(orders);
		model.addAttribute("orders", orders);

		return "/bought.jsp";
	}

	@RequestMapping("/confirmPay")
	public String confirmPay(Model model, Integer order_id) {
		Order order = orderService.get(order_id);
		orderItemService.fill(order);
		model.addAttribute("order", order);
		return "/confirmPay.jsp";
	}

	@RequestMapping("orderConfirmed")
	public String orderConfirmed(Model model, Integer order_id) {
		Order o = orderService.get(order_id);
		o.setStatus(OrderService.waitReview);
		o.setConfirm_date(new Date());
		orderService.update(o);
		return "/orderConfirmedPage.jsp";
	}

	@RequestMapping("deleteOrder")
	@ResponseBody
	public String deleteOrder(Model model, Integer order_id) {
		Order o = orderService.get(order_id);
		o.setStatus(OrderService.delete);
		orderService.update(o);
		return "success";
	}

	@RequestMapping("review")
	public String review(Model model, Integer order_id) {
		Order order = orderService.get(order_id);
		orderItemService.fill(order);
		Product product = order.getOrderItems().get(0).getProduct();
		List<Review> reviews = reviewService.listByProductId(product.getId());
		productService.setReviewCount(product);
		model.addAttribute("product", product);
		model.addAttribute("order", order);
		model.addAttribute("reviews", reviews);
		return "/reviewPage.jsp";
	}

	@RequestMapping("doreview")
	public String doreview(Model model, HttpSession session,
						   @RequestParam("order_id") Integer order_id,
						   @RequestParam("product_id") Integer product_id,
						   String content) {

		Order order = orderService.get(order_id);
		order.setStatus(OrderService.finish);
		orderService.update(order);

		User user = (User) session.getAttribute("user");
		Review review = new Review();
		review.setContent(content);
		review.setProduct_id(product_id);
		review.setCreateDate(new Date());
		review.setUser_id(user.getId());
		reviewService.add(review);

		return "redirect:review?order_id=" + order_id + "&showonly=true";
	}

}
