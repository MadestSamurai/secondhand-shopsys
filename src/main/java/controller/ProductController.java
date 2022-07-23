package controller;

import pojo.Category;
import pojo.Product;
import pojo.ProductImage;
import service.CategoryService;
import service.ProductImageService;
import service.ProductService;
import service.PropertyValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class ProductController {

	@Autowired
	CategoryService categoryService;

	@Autowired
	ProductService productService;

	@Autowired
	ProductImageService productImageService;

	@Autowired
	PropertyValueService propertyValueService;

	@RequestMapping("/listProduct")
	public String list(Model model, Integer category_id) {
		List<Product> products = productService.list(category_id);
		model.addAttribute("products", products);
		Category category = categoryService.get(category_id);
		model.addAttribute("category", category);
		return "/admin/listProduct.jsp";
	}

	@RequestMapping("/addProduct")
	public String add(Product product) {
		productService.add(product);

		// 创建新的 Product 时默认创建 5 个对应的 ProductImage 数据
		ProductImage productImage = new ProductImage();
		productImage.setProduct_id(product.getId());
		for (int i = 1; i <= 5; i++) {
			productImageService.add(productImage);
		}

		return "redirect:listProduct?category_id=" + product.getCategory_id();
	}

	@RequestMapping("/deleteProduct")
	public String delete(Integer id, HttpServletRequest request) {

		// 在删除产品的时候将对应的 5 个 ProductImage 数据也删除了
		productImageService.deleteByProductId(id);
		// 同时删除目录下的相关文件
		String path = request.getSession().getServletContext().getRealPath("" + id);
		deleteDir(new File(path));

		// 删除外键对应的数据
		propertyValueService.deleteByProductId(id);

		int category_id = productService.get(id).getCategory_id();
		productService.delete(id);

		return "redirect:listProduct?category_id=" + category_id;
	}

	private static boolean deleteDir(File dir) {
		if (dir.isDirectory()) {
			String[] children = dir.list();
			//递归删除目录中的子目录下
			for (int i = 0; i < children.length; i++) {
				boolean success = deleteDir(new File(dir, children[i]));
				if (!success) {
					return false;
				}
			}
		}
		return dir.delete();
	}

	@RequestMapping("/editProduct")
	public String edit(Integer id, Model model) {
		Product product = productService.get(id);
		model.addAttribute("product", product);
		Category category = categoryService.get(product.getCategory_id());
		model.addAttribute("category", category);
		return "/admin/editProduct.jsp";
	}

	@RequestMapping("/updateProduct")
	public String update(Product product) {
		productService.update(product);
		return "redirect:listProduct?category_id=" + product.getCategory_id();
	}
}
