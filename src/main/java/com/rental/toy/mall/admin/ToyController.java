package com.rental.toy.mall.admin;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.rental.toy.admin.member.AdminMemberVo;
import com.rental.toy.mall.CartToyVo;
import com.rental.toy.mall.MallToyVo;
import com.rental.toy.mall.NoticeVo;
import com.rental.toy.mall.OrderDetailVo;
import com.rental.toy.mall.OrderVo;
import com.rental.toy.mall.RentalToyVo;
import com.rental.toy.mall.admin.util.UploadFileService;

@Controller
@RequestMapping("/toy/admin")
public class ToyController {
	
	@Autowired
	ToyService toyService;
	
	@Autowired
	UploadFileService uploadFileService;
	
	
	//�峲�����(�뿩��)
	@GetMapping("/rentalToyForm")
	public String rentalToyForm() {
		String nextPage = "admin/toy/rental_toy_form";
		return nextPage;
	}

	//�峲�����(�뿩)
	@PostMapping("/rentalToyConfirm")
	public String rentalToyConfirm(RentalToyVo rentalToyVo, @RequestParam("file") MultipartFile file) {
		String nextPage = "admin/toy/register_toy_ok";
		String savedFileName = uploadFileService.upload(file);
		if (savedFileName != null) {
			rentalToyVo.setRt_photo(savedFileName);
			int result = toyService.rentalToyConfirm(rentalToyVo);
			if (result <= 0)
				nextPage = "admin/toy/register_toy_ng";
		} else {
			nextPage = "admin/toy/register_toy_ng";
		}
		return nextPage;
	}
	
	//�峲�����(�Ǹ���)
	@GetMapping("/mallToyForm")
	public String mallToyForm() {
		String nextPage = "admin/toy/mall_toy_form";
		return nextPage;
	}
	
	//�峲�����(�Ǹ�)
	@PostMapping("/toyMallConfirm")
	public String toyMallConfirm(MallToyVo mallToyVo, @RequestParam("file") MultipartFile file) {
		String nextPage = "admin/toy/register_toy_ok";
		String savedFileName = uploadFileService.upload(file);
		if (savedFileName != null) {
			mallToyVo.setMt_photo(savedFileName);
			int result = toyService.toyMallConfirm(mallToyVo);
			if (result <= 0)
				nextPage = "admin/toy/register_toy_ng";
		} else {
			nextPage = "admin/toy/register_toy_ng";
		}
		return nextPage;
	}
	
	//�뿩 ����Ʈ(�̵�)
	@GetMapping("/rentalAllToys")
	public String rentalAllToys() {
		String nextPage = "admin/toy/full_list_rental_toys";
		return nextPage;
	}
	
	//�뿩 ����Ʈ ����
	@RequestMapping(value="/allRentaltoys", method= {RequestMethod.POST, RequestMethod.GET})
	public String allRentaltoys(Model model) {
		List<RentalToyVo> rentalToyVos = toyService.allRentaltoys();
		model.addAttribute("rentalToyVos", rentalToyVos);
		return "admin/toy/allToyRentalList";
	}
	
	//�Ǹ� ����Ʈ(�̵�)
	@GetMapping("/mallAllToys")
	public String mallAllToys() {
		String nextPage = "admin/toy/full_list_mall_toys";
		return nextPage;
	}
	
	//�Ǹ� ����Ʈ ����
	@RequestMapping(value="/allMalltoys", method= {RequestMethod.POST, RequestMethod.GET})
	public String allMalltoys(Model model) {
		List<MallToyVo> mallToyVos = toyService.allMalltoys();
		model.addAttribute("mallToyVos", mallToyVos);
		return "admin/toy/allToyMallList";
	}
	
	//�峲�� �˻�
	@GetMapping("/searchToyConfirm")
	public String searchToyConfirm(MallToyVo mallToyVo, Model model) {
		String nextPage = "admin/toy/search_toy";
		List<MallToyVo> mallToyVos = toyService.searchToyConfirm(mallToyVo);
		model.addAttribute("mallToyVos", mallToyVos);
		return nextPage;
	}
	
	
	@GetMapping("/toyDetail")
	public String toyDetail(@RequestParam("mt_no") int mt_no, Model model) {
		String nextPage = "admin/toy/toy_detail";
		MallToyVo mallToyVo = toyService.toyDetail(mt_no);
		model.addAttribute("mallToyVo", mallToyVo);
		return nextPage;
	}
	
	//�Ǹ����� ������ 
	@GetMapping("/modifyToyForm")
	public String modifyToyForm(@RequestParam("mt_no") int mt_no, 
								 Model model, 
								 HttpSession session) {
		String nextPage = "admin/toy/modify_toy_form";
		AdminMemberVo loginedAdminMemberVo = (AdminMemberVo) session.getAttribute("loginedAdminMemberVo");
		if (loginedAdminMemberVo == null)
			return "redirect:/admin/member/loginForm";
		
		MallToyVo mallToyVo = toyService.modifyToyForm(mt_no);
		model.addAttribute("mallToyVo", mallToyVo);
		return nextPage;
	}
	
	
	
	//�Ǹ����� �����Ϸ�
	@PostMapping("/modifyToyConfirm")
	public String modifyToyConfirm(MallToyVo mallToyVo, 
									@RequestParam("file") MultipartFile file, 
									HttpSession session) {
		String nextPage = "admin/toy/modify_toy_ok";
		
		AdminMemberVo loginedAdminMemberVo = (AdminMemberVo) session.getAttribute("loginedAdminMemberVo");
		if (loginedAdminMemberVo == null)
			return "redirect:/admin/member/loginForm";
		
		if (!file.getOriginalFilename().equals("")) {
			String savedFileName = uploadFileService.upload(file);
			if (savedFileName != null)
				mallToyVo.setMt_photo(savedFileName);
		}
		
		int result = toyService.modifyToyConfirm(mallToyVo);
		
		if (result <= 0)
			nextPage = "admin/toy/modify_toy_ng";
		return nextPage;
	}
	
	//�ǸŸ���Ʈ����
	@GetMapping("/deleteToyConfirm")
	public String deleteToyConfirm(@RequestParam("photo") String mt_photo,
									@RequestParam("no") int mt_no,
									HttpSession session) {
		String nextPage = "admin/toy/delete_toy_ok";
		AdminMemberVo loginedAdminMemberVo = (AdminMemberVo) session.getAttribute("loginedAdminMemberVo");
		if (loginedAdminMemberVo == null)
			return "redirect:/admin/member/loginForm";
		int result = toyService.deleteToyConfirm(mt_no);
		String deleteFile = "C:\\library\\upload\\"+mt_photo;
		if (result <= 0) {
			nextPage = "admin/toy/delete_toy_ng";
		} else {
			File file = new File(deleteFile);
			file.delete();
		}
		return nextPage;
	}
	
	//�뿩����Ʈ����
	@GetMapping("/deleteToyConfirmRental")
	public String deleteToyConfirmRental(@RequestParam("photo") String rt_photo,
									@RequestParam("no") int rt_no,
									HttpSession session) {
		String nextPage = "admin/toy/delete_toy_ok";
		AdminMemberVo loginedAdminMemberVo = (AdminMemberVo) session.getAttribute("loginedAdminMemberVo");
		if (loginedAdminMemberVo == null)
			return "redirect:/admin/member/loginForm";
		int result = toyService.deleteToyConfirmRental(rt_no);
		String deleteFile = "C:\\library\\upload\\"+rt_photo;
		if (result <= 0) {
			nextPage = "admin/toy/delete_toy_ng";
		} else {
			File file = new File(deleteFile);
			file.delete();
		}
		return nextPage;
	}
	
	//�������� ����Ʈ(�̵�)
	@GetMapping("/toyNotice")
	public String toyNotice() {
		String nextPage = "admin/toy/notice_list";
		return nextPage;
	}
	
	//���� ����Ʈ ����
	@RequestMapping(value="/allToyNotice", method= {RequestMethod.POST, RequestMethod.GET})
	public String allToyNotice(Model model) {
		List<NoticeVo> noticeVos = toyService.allToyNotice();
		model.addAttribute("noticeVos", noticeVos);
		return "admin/toy/allNoticeList";
	}
	
	//�������(�Ǹ���)
	@GetMapping("/noticeForm")
	public String noticeForm() {
		String nextPage = "admin/toy/notice_form";
		return nextPage;
	}
		
	//�峲�����(�Ǹ�)
	@PostMapping("/noticeConfirm")
	public String noticeConfirm(NoticeVo noticeVo) {
		String nextPage = "admin/toy/register_toy_ok";
			int result = toyService.noticeConfirm(noticeVo);
			if (result <= 0)
				nextPage = "admin/toy/register_toy_ng";
		return nextPage;
	}
		
	
	@GetMapping("/noticeDetail")
	public String noticeDetail(@RequestParam("n_name") String n_name, Model model) {
		String nextPage = "admin/toy/notice_detail";
		NoticeVo noticeVo = toyService.noticeDetail(n_name);
		model.addAttribute("noticeVo", noticeVo);
		return nextPage;
	}
	
	//�������� ������ 
	@GetMapping("/modifyNoticeForm")
	public String modifyNoticeForm(@RequestParam("n_no") int n_no, 
								 Model model, 
								 HttpSession session) {
		String nextPage = "admin/toy/modify_notice_form";
		AdminMemberVo loginedAdminMemberVo = (AdminMemberVo) session.getAttribute("loginedAdminMemberVo");
		if (loginedAdminMemberVo == null)
			return "redirect:/admin/member/loginForm";
		
		NoticeVo noticeVo = toyService.modifyNoticeForm(n_no);
		model.addAttribute("noticeVo", noticeVo);
		return nextPage;
	}
	
	
	//�������� �����Ϸ�
	@PostMapping("/modifyNoticeConfirm")
	public String modifyNoticeConfirm(NoticeVo noticeVo, 
									HttpSession session) {
		String nextPage = "admin/toy/modify_toy_ok";
		
		AdminMemberVo loginedAdminMemberVo = (AdminMemberVo) session.getAttribute("loginedAdminMemberVo");
		if (loginedAdminMemberVo == null)
			return "redirect:/admin/member/loginForm";
		
		int result = toyService.modifyNoticeConfirm(noticeVo);
		
		if (result <= 0)
			nextPage = "admin/toy/modify_toy_ng";
		return nextPage;
	}
	
	//�������� ����
	@GetMapping("/deleteNoticeConfirm")
	public String deleteNoticeConfirm(@RequestParam("no") int n_no,
									HttpSession session) {
		String nextPage = "admin/toy/delete_toy_ok";
		AdminMemberVo loginedAdminMemberVo = (AdminMemberVo) session.getAttribute("loginedAdminMemberVo");
		if (loginedAdminMemberVo == null)
			return "redirect:/admin/member/loginForm";
		int result = toyService.deleteNoticeConfirm(n_no);
		if (result <= 0) {
			nextPage = "admin/toy/delete_toy_ng";
		} 
		return nextPage;
	}
	
	
		//�� �ֹ����� Ȯ��
		@GetMapping("/purchaseCheck")
		public String purchaseCheck(Model model) {
			String nextPage = "admin/toy/order_confirm";
			List<OrderVo> orderVos = toyService.allToyOrder();
			model.addAttribute("orderVos", orderVos);
			return nextPage;
		}
		
		//�Ա� ���ι�ư
		@GetMapping("/setAdminApproval")
		public String setAdminApproval(@RequestParam("order_no") int order_no ) {
			String nextPage = "redirect:/toy/admin/purchaseCheck";
			toyService.setAdminApproval(order_no);
			return nextPage;	
		}
		
		
		//�� �ֹ����� ������
		@GetMapping("/orderDetail")
		public String orderDetail(@RequestParam("order_no") int order_no, Model model) {
			String nextPage = "admin/toy/order_confirm_detail";
			List<OrderVo> orderVos = toyService.allToyOrderDetail(order_no);
			model.addAttribute("orderVos", orderVos);
			return nextPage;
		}
		
		

		
		
		
	
	
}
