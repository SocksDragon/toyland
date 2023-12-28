package com.rental.toy.mall.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.rental.toy.user.member.UserMemberVo;
import com.rental.toy.mall.OrderVo;
import com.rental.toy.mall.OrderDetailVo;
import com.rental.toy.mall.CartToyVo;
import com.rental.toy.mall.MallToyVo;
import com.rental.toy.mall.NoticeVo;
import com.rental.toy.mall.RentalToyVo;
import com.rental.toy.mall.admin.util.UploadFileService;

@Controller
@RequestMapping("/toy/user")
public class ToyController {
	
	@Autowired
	ToyService toyService;
	
	@Autowired
	UploadFileService uploadFileService;
	
	//판매전체리스트(메인)
	@GetMapping("/mallToyAll")
	public String mallToyAll(Model model) {
		String nextPage = "user/toy/mall_toy_list";
		List<MallToyVo> mallToyListAll = null;
		mallToyListAll = toyService.mallToyListAll();
		model.addAttribute("mallToyListAll", mallToyListAll);
		return nextPage;
	}	
	
	//판매전체리스트(검색)
	@GetMapping("/mallToySearchAll")
	public String mallToySearchAll(Model model) {
		String nextPage = "user/toy/mall_toy_list_all";
		List<MallToyVo> mallToyListAll = null;
		mallToyListAll = toyService.mallToyListAll();
		model.addAttribute("mallToyListAll", mallToyListAll);
		return nextPage;
	}	
	
		
	//판매전체 타입별 
	@GetMapping("/mallToyType")
	public String mallToyType(@RequestParam("mt_type") String mt_type, Model model) {
		String nextPage = "user/toy/mall_toy_list_type";
		List<MallToyVo> mallToyListAll = null;
		mallToyListAll = toyService.mallToyListType(mt_type);
		model.addAttribute("mallToyListAll", mallToyListAll);
		model.addAttribute("mt_type", mt_type);
		return nextPage;
	}
	
	//장남감 검색
	@GetMapping("/searchToyConfirm")
	public String searchToyConfirm(MallToyVo mallToyVo, Model model) {
		String nextPage = "user/toy/search_toy";
		List<MallToyVo> mallToyVos = toyService.searchToyConfirm(mallToyVo);
		model.addAttribute("mallToyVos", mallToyVos);
		return nextPage;
	}

	//mall상세
	@GetMapping("/mallDetail")
	public String mallDetail(@RequestParam("mt_no") int mt_no, Model model) {
		String nextPage = "user/toy/mall_detail";
		MallToyVo mallToyVo = toyService.toyDetail(mt_no);
		model.addAttribute("mallToyVo", mallToyVo);
		return nextPage;
	}

	//rental상세
	@GetMapping("/rentalDetail")
	public String rentalDetail(@RequestParam("rt_no") int rt_no, Model model) {
		String nextPage = "user/toy/rental_detail";
		RentalToyVo rentalToyVo = toyService.rentalDetail(rt_no);
		model.addAttribute("rentalToyVo", rentalToyVo);
		return nextPage;
	}	
	

	//대여전체리스트(메인)
	@GetMapping("/rentalToyAll")
	public String rentalToyAll(Model model) {
		String nextPage = "user/toy/rental_toy_list";
		List<RentalToyVo> rentalToyListAll = null;
		rentalToyListAll = toyService.rentalToyListAll();
		model.addAttribute("rentalToyListAll", rentalToyListAll);
		return nextPage;
	}	
	
	//대여전체리스트(검색)
	@GetMapping("/rentalToySearchAll")
	public String rentalToySearchAll(Model model) {
		String nextPage = "user/toy/rental_toy_list_all";
		List<RentalToyVo> rentalToyListAll = null;
		rentalToyListAll = toyService.rentalToyListAll();
		model.addAttribute("rentalToyListAll", rentalToyListAll);
		return nextPage;
	}	
	
	//공지사항 리스트(이동)
	@GetMapping("/toyNotice")
	public String toyNotice() {
		String nextPage = "user/toy/notice_list";
		return nextPage;
	}
	//공지 리스트 내용
	@RequestMapping(value="/allToyNotice", method= {RequestMethod.POST, RequestMethod.GET})
	public String allToyNotice(Model model) {
		List<NoticeVo> noticeVos = toyService.allToyNotice();
		model.addAttribute("noticeVos", noticeVos);
		return "user/toy/allNoticeList";
	}
	
	//공지 상세
	@GetMapping("/noticeDetail")
	public String noticeDetail(@RequestParam("n_name") String n_name, Model model) {
		String nextPage = "user/toy/notice_detail";
		NoticeVo noticeVo = toyService.noticeDetail(n_name);
		model.addAttribute("noticeVo", noticeVo);
		return nextPage;
	}
	
	//장바구니 페이지 이동
	@GetMapping("/cartPage")
	public String cartPage() {
		String nextPage = "user/toy/cart_page";
		return nextPage;
	}
	
	//장바구니 넣기
	@RequestMapping(value="/cartIn/{user_no}", method = {RequestMethod.POST, RequestMethod.GET})
	public void cartIn(@RequestBody CartToyVo cartToyVo, 
			@PathVariable("user_no") int user_no, HttpSession session) {
		List<CartToyVo> cartToyVos = new ArrayList<>();
		if (user_no>0) {
			if (session.getAttribute("cartList")!=null) {
				cartToyVos = (List<CartToyVo>) session.getAttribute("cartList");
				cartToyVo.setCart_qty(1);
				cartToyVos.add(cartToyVo);
				List<CartToyVo> distinctCartList = removeDuplicates(cartToyVos, user_no);
				session.setAttribute("cartList", distinctCartList);
				int result = toyService.cartSessionInsert(distinctCartList);
				if (result>0) {
					session.removeAttribute("cartList");
				}
			} else {
				cartToyVo.setU_m_no(user_no);
				cartToyVo.setCart_qty(1);
				int result = toyService.cartInsert(cartToyVo);
			}
		} else {
			if (session.getAttribute("cartList")!=null) {
				cartToyVos = (List<CartToyVo>) session.getAttribute("cartList");
				cartToyVo.setCart_qty(1);
				cartToyVos.add(cartToyVo);
				List<CartToyVo> distinctCartList = removeDuplicates(cartToyVos, user_no);
				session.setAttribute("cartList", distinctCartList);
			} else {
				cartToyVo.setCart_qty(1);
				cartToyVos.add(cartToyVo);
				session.setAttribute("cartList", cartToyVos);
				session.setMaxInactiveInterval(60*30);
			}
		}
	}
	
	//장바구니 리스트	
	@RequestMapping(value="/cartList/{user_no}", method = {RequestMethod.POST, RequestMethod.GET})
	public String cartList(@PathVariable("user_no") int user_no, HttpSession session, Model model) {
		String nextPage = "user/toy/cart_list";
		List<CartToyVo> cartToyVos = new ArrayList<>();
		if (user_no>0) {
			if (session.getAttribute("cartList")!=null) {
				cartToyVos = (List<CartToyVo>) session.getAttribute("cartList");
				for (int i=0; i<cartToyVos.size(); i++) {
					cartToyVos.get(i).setU_m_no(user_no);
				}
				int result = toyService.cartSessionInsert(cartToyVos);
				if (result>0) {
					cartToyVos = toyService.cartSelectUser(user_no);
					session.removeAttribute("cartList");
				}
			} else {
				cartToyVos = toyService.cartSelectUser(user_no);
			}
		} else {
			if (session.getAttribute("cartList")!=null) {
				cartToyVos = (List<CartToyVo>) session.getAttribute("cartList");
			} 
		}
		model.addAttribute("cartToyVos", cartToyVos);
		return nextPage;
	}
		
	//장바구니 리스트 제거
	private List<CartToyVo> removeDuplicates(List<CartToyVo> cartList, int user_no) {
		Set<Integer> mtNos = new HashSet<>();
		List<CartToyVo> distinctCartList = new ArrayList<>();
		
		for (CartToyVo cartToyVo : cartList) {
			if (mtNos.add(cartToyVo.getMt_no())) {
				cartToyVo.setU_m_no(user_no);
				distinctCartList.add(cartToyVo);
			}
		}
		
		return distinctCartList;
	}
	
	@RequestMapping(value="/cartQty/{user_no}", method = {RequestMethod.POST, RequestMethod.GET})
	public void cartQty(@RequestBody CartToyVo cartToyVo, 
			@PathVariable("user_no") int user_no, HttpSession session) {
		List<CartToyVo> cartToyVos = new ArrayList<>();
		if (user_no>0) {
			cartToyVo.setU_m_no(user_no);
			toyService.updateQty(cartToyVo);
		} else {
			cartToyVos = (List<CartToyVo>) session.getAttribute("cartList");
			for (CartToyVo item : cartToyVos) {
				if (item.getMt_no()==cartToyVo.getMt_no()) {
					item.setCart_qty(cartToyVo.getCart_qty());
					break;
				}
			}
			session.setAttribute("cartList", cartToyVos);
		}
	}

	@RequestMapping(value="/cartDelete/{user_no}", method = {RequestMethod.POST, RequestMethod.GET})
	public String cartDelete(@RequestBody CartToyVo cartToyVo, 
			@PathVariable("user_no") int user_no, HttpSession session, Model model) {
		String nextPage = "user/toy/cart_list";
		List<CartToyVo> cartToyVos = new ArrayList<>();
		if (user_no>0) {
			cartToyVo.setU_m_no(user_no);
			int result = toyService.removeCart(cartToyVo);
			cartToyVos = toyService.cartSelectUser(user_no);
		} else {
			cartToyVos = (List<CartToyVo>) session.getAttribute("cartList");
			for (CartToyVo item : cartToyVos) {
				if (item.getMt_no()==cartToyVo.getMt_no()) {
					cartToyVos.remove(item);
					break;
				}
			}
			session.setAttribute("cartList", cartToyVos);
		}
		model.addAttribute("cartToyVos", cartToyVos);
		return nextPage;
	}
	//결제 페이지 이동(수정필요)
	@GetMapping("/purchase")
	public String purchase() {
		String nextPage = "user/toy/cart_page";
		return nextPage;
	}
	
	@RequestMapping("/orderForm")
    public String orderForm(@RequestParam(name="mtNos") String mtNos, Model model) {
		String nextPage = "user/toy/order_form";
		model.addAttribute("mtNos", mtNos);
        return nextPage; 
    }
	
	@PostMapping("/orderFormList/{mtNos}")
	public String orderFormList(@PathVariable("mtNos") String mtNos, Model model, HttpSession session) {
		String nextPage = "user/toy/order_list";
        String[] mtList = mtNos.split(",");
		List<Map<String, Integer>> cartCheckList = new ArrayList<>();
		List<CartToyVo> orderCheckList = new ArrayList<>();
		UserMemberVo loginedUserMemberVo = (UserMemberVo) session.getAttribute("loginedUserMemberVo");
	    for (int i=0; i<mtList.length; i++) {
	    	Map<String, Integer> map = new HashMap<>();
	    	map.put("mt_no", Integer.parseInt(mtList[i]));
	    	map.put("u_m_no", loginedUserMemberVo.getU_m_no());
	    	cartCheckList.add(map);
	    }
	    orderCheckList = toyService.orderList(cartCheckList);
	    model.addAttribute("cartToyVos", orderCheckList);
	    model.addAttribute("mtList", mtList);
	    return nextPage;
	}
	
	
	@Transactional
	@PostMapping("/purchaseRequest")
	public String puchaseRequest(@ModelAttribute OrderVo orderVo, Model model) {
		List<OrderDetailVo> orderDetailVos = new ArrayList<>();
		List<CartToyVo> cartToyVos = new ArrayList<>();
		System.out.println("umno"+orderVo.getOrder_nos());
		toyService.purchase(orderVo);
		
		for (int i=0; i<orderVo.getOrder_nos().size(); i++) {
			int order_no = orderVo.getOrder_no();
			int order_nos = orderVo.getOrder_nos().get(i);
            int order_qtys = orderVo.getOrder_qtys().get(i);
            OrderDetailVo newOrderDetailVo = new OrderDetailVo();
            newOrderDetailVo.setOrder_no(order_no);
            newOrderDetailVo.setMt_no(order_nos);
            newOrderDetailVo.setOrder_qty(order_qtys);
            orderDetailVos.add(newOrderDetailVo);
		}
		toyService.orderDetailInsert(orderDetailVos);
		toyService.inventoryUpdate(orderDetailVos);
		
		for (int i=0; i<orderVo.getOrder_nos().size(); i++) {
            int u_m_no = orderVo.getU_m_no();
            System.out.println("u)m"+u_m_no);
			int order_nos = orderVo.getOrder_nos().get(i);
			CartToyVo newCartToyVo = new CartToyVo();
			newCartToyVo.setU_m_no(u_m_no);
            newCartToyVo.setMt_no(order_nos);
            cartToyVos.add(newCartToyVo);
		}
	    toyService.cartDelete(cartToyVos);
	    
	    return "redirect:/toy/user/orderConfirm";
	}
	
	
	@GetMapping("/orderConfirm")
	public String orderConfirm(HttpSession session, Model model) {
		String nextPage = "user/toy/order_confirm";
		List<OrderVo> orderVos = new ArrayList<>();
		UserMemberVo loginedUserMemberVo = (UserMemberVo) session.getAttribute("loginedUserMemberVo");
		orderVos = toyService.orderUserSelect(loginedUserMemberVo.getU_m_no());
		model.addAttribute("orderVos", orderVos);
		return nextPage;
	}
	
	//주문내역 확인
	@GetMapping("/purchaseCheck")
	public String purchaseCheck() {
		String nextPage = "redirect:/toy/user/orderConfirm";
		return nextPage;
	}
	
	@RequestMapping(value="/purchaseDelete/{user_no}", method = {RequestMethod.POST, RequestMethod.GET})
	public String purchaseDelete(@RequestBody OrderVo orderVo, 
			@PathVariable("user_no") int user_no, HttpSession session, Model model) {
		String nextPage = "user/toy/order_confirm";
		List<OrderVo> orderVos = new ArrayList<>();
		if (user_no>0) {
			orderVo.setU_m_no(user_no);
			int result = toyService.removePurchase(orderVo);
			orderVos = toyService.orderUserSelect(user_no);
		} else {
			orderVos = (List<OrderVo>) session.getAttribute("purchaseList");
			for (OrderVo item : orderVos) {
				if (item.getOrder_no()==orderVo.getOrder_no()) {
					orderVos.remove(item);
					break;
				}
			}
			session.setAttribute("purchaseList", orderVos);
		}
		model.addAttribute("orderVos", orderVos);
		return nextPage;
	}
	
}
