package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	//Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public PurchaseController() {
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
			
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	//@RequestMapping("/addPurchase.do")
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public String addPurchase(@ModelAttribute("search")Search search,HttpSession session,@ModelAttribute("product")Product product,  @ModelAttribute("purchase") Purchase purchase, Model model) throws Exception{
		System.out.println("/addPurchase.do");
		
		User user = (User) session.getAttribute("user");
		Product product2 = productService.getProduct(product.getProdNo());
		System.out.println("purchase : "+ purchase);
		System.out.println("product : "+ product2);
		System.out.println("user : "+ user);
		Purchase purchaseDomain = purchase;
		purchaseDomain.setBuyer(user);
		purchaseDomain.setPurchaseProd(product2);
		purchaseDomain.setTranCode("1");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		purchaseService.addPurchase(purchaseDomain);
		
		model.addAttribute("search", search);
		model.addAttribute("purchase", purchase);
		model.addAttribute("menu", "search");
		model.addAttribute("User", user);
		
		return "forward:/purchase/AddPurchase.jsp";
	}
	
	
	//@RequestMapping("/addPurchaseView.do")
	@RequestMapping(value="addPurchaseView", method=RequestMethod.GET)
	public String addPurchaseView(HttpSession session, HttpServletRequest request, @RequestParam("prodNo")int prodNo, Model model) throws Exception{
		
		System.out.println("/addPurchaseView.do");
		System.out.println("prodNo : " + prodNo);
		System.out.println(productService.getProduct(prodNo));
		Product product = productService.getProduct(prodNo);
		System.out.println("product : "+ product);
		model.addAttribute("product", product);
		
		return "forward:/purchase/AddPurchaseView.jsp";
	}
	
	//@RequestMapping("/getPurchase.do")
	@RequestMapping(value="getPurchase", method=RequestMethod.GET)
	public String getPurchase(@RequestParam("tranNo")int tranNo, Model model) throws Exception{
		
		System.out.println("/getPurchase.do");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/GetPurchase.jsp";
	}
	
	//@RequestMapping("/listPurchase.do")
	@RequestMapping(value="listPurchase")
	public String listPurchase(HttpSession session, Model model, @ModelAttribute("search")Search search, HttpServletRequest request)throws Exception{
		System.out.println("/listPurchase.do");
		
		User user = (User) session.getAttribute("user");
		
		String id = user.getUserId();
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=purchaseService.getPurchaseList(search, id);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/purchase/ListPurchase.jsp";
	}
	
	//@RequestMapping("/updatePurchaseView.do")
	@RequestMapping(value="updatePurchaseView", method=RequestMethod.GET)
	public String updatePurchaseView(@RequestParam("tranNo")int tranNo, Model model)throws Exception{
		
		System.out.println("/updatePurchaseView.do");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
	
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/UpdatePurchaseView.jsp";
	}
	
	
	//@RequestMapping("/updateTranCode.do")
	@RequestMapping(value="updateTranCode", method=RequestMethod.GET)
	public String updateTranCode(@RequestParam("prodNo")int prodNo, @RequestParam("tranCode")String tranCode, @ModelAttribute("search")Search search, HttpSession session,  Model model)throws Exception{
		
		System.out.println("/updateTranCode.do");
		
		User user = (User)session.getAttribute("user");
		String id = user.getUserId();
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Purchase purchase = purchaseService.getPurchase2(prodNo);
		purchaseService.updateTranCode(purchase);
		Map<String , Object> map=purchaseService.getPurchaseList(search, id);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		model.addAttribute("list", map.get("list2"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", "search");
		
		return "forward:/purchase/ListPurchase.jsp";
	}
	
	
	//@RequestMapping("/updateTranCodeByProd.do")
	@RequestMapping(value="updateTranCodeByProd", method=RequestMethod.GET)
	public String updateTranCodeByProd(@ModelAttribute("search")Search search, @RequestParam("prodNo")int prodNo, @RequestParam("tranCode")String tranCode, Model model) throws Exception{
		
		System.out.println("/updateTranCodeByprod.do");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Purchase purchase = purchaseService.getPurchase2(prodNo);
		System.out.println("purchase : "+ purchase);
		purchaseService.updateTranCode(purchase);
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("menu", "manage");
		
		return "forward:/product/ListProduct.jsp";
	}
	
	
}
