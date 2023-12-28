package com.rental.toy.admin.member;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.rental.toy.admin.member.AdminMemberVo;
import com.rental.toy.user.member.UserMemberVo;
import com.rental.toy.admin.member.AdminMemberService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;


@Controller
@RequestMapping("/admin/member")
public class AdminMemberController {
	
	@Autowired
	AdminMemberService adminMemberService;
	
	//아이디중복체크
	@ResponseBody
	@RequestMapping(value="/idCheck/{amid}", method = {RequestMethod.POST, RequestMethod.GET})
	public Map<String, Boolean> idCheck(@PathVariable("amid") String a_m_id) {
		Map<String, Boolean> resultMap = new HashMap<String, Boolean>();
		boolean isMember = adminMemberService.idCheck(a_m_id);
		resultMap.put("result", isMember);
		return resultMap;
	}
	
	//회원가입폼
	@GetMapping("/createAccountForm")
	public String createAccountForm() {
		System.out.println("[AdminMemberController] createAccountForm()");
		String nextPage = "admin/member/create_account_form";
		return nextPage;	
	}
	
	//회원가입 성공
	@PostMapping("/createAccountConfirm")
	public String createAccountConfirm(AdminMemberVo adminMemberVo){
		String nextPage = "admin/member/create_account_ok";
		int result = adminMemberService.createAccountConfirm(adminMemberVo);
		if (result <= 0) {
			nextPage = "admin/member/create_account_ng";
		}
		return nextPage;
	}
	
	//로그인폼
	@GetMapping("/loginForm")	
	public String loginForm() {
		String nextPage = "admin/member/login_form";
		return nextPage;
	}
	
	//로그인 성공
	@PostMapping("/loginConfirm")
	public String loginConfirm(AdminMemberVo adminMemberVo, HttpSession session) {
		String nextPage = "admin/member/login_ok";
		AdminMemberVo loginedAdminMemberVo = adminMemberService.loginConfirm(adminMemberVo);
		if (loginedAdminMemberVo==null) {
			nextPage = "admin/member/login_ng";
		} else {
			session.setAttribute("loginedAdminMemberVo", loginedAdminMemberVo);
			session.setMaxInactiveInterval(60 * 30);   // 세션 최대 유지시간 60*30=1800초(30분)
		}
		return nextPage;
	}
	
	//로그아웃
	@GetMapping("/logoutConfirm")
	public String logoutConfirm(HttpSession session) {
		String nextPage = "redirect:/admin";
		session.invalidate();
		return nextPage;
	}
	
	//어드민 정보변경폼
	@GetMapping("/modifyAccountForm")
	public String modifyAccountForm(HttpSession session) {
		String nextPage = "admin/member/modify_account_form";
		return nextPage;
	}
	
	//어드민 정보변경
	@PostMapping("/modifyAccountConfirm")
	public String modifyAccountConfirm(AdminMemberVo adminMemberVo, HttpSession session) {
		String nextPage = "admin/member/modify_account_ok";
		int result = adminMemberService.modifyAccountConfirm(adminMemberVo);
		if (result > 0) {
			AdminMemberVo loginedAdminMemberVo = adminMemberService.getLoginedAdminMemberVo(adminMemberVo.getA_m_no());
			session.setAttribute("loginedAdminMemberVo", loginedAdminMemberVo);
			session.setMaxInactiveInterval(60 * 30);
		} else {
			nextPage = "admin/member/modify_account_ng";
		}
		return nextPage;
	}
	
	//어드민 리스트
	@GetMapping("/listupAdmin")
	public ModelAndView listupAdmin() {
		String nextPage = "admin/member/listup_admins";
		List<AdminMemberVo> adminMemberVos = adminMemberService.listupAdmin();
		
		ModelAndView modelAndView = new ModelAndView();	
		modelAndView.setViewName(nextPage);
		modelAndView.addObject("adminMemberVos", adminMemberVos);
		
		return modelAndView;
	}
	
	//유저 리스트
	@GetMapping("/listupUser")
	public ModelAndView listupUser() {
		String nextPage = "admin/member/listup_users";
		List<AdminMemberVo> adminMemberVos = adminMemberService.listupUser();
		
		ModelAndView modelAndView = new ModelAndView();	
		modelAndView.setViewName(nextPage);
		modelAndView.addObject("adminMemberVos", adminMemberVos);
		
		return modelAndView;
	}
	
	//비밀번호 재설정 폼
	@GetMapping("/findPasswordForm")
	public String findePasswordForm() {
		String nextPage = "admin/member/find_password_form";
		return nextPage;
	}
	
	//비밀번호 재설정 완료
	@PostMapping("/findPasswordConfirm")
	public String findPasswordConfirm(AdminMemberVo adminMemberVo) {
		String nextPage = "admin/member/find_password_ok";
		int result = adminMemberService.findPasswordConfirm(adminMemberVo);
		if (result <= 0)
			nextPage = "admin/member/find_password_ng";
		return nextPage;
	}
	
	
}