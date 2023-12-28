package com.rental.toy.user.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rental.toy.user.member.UserMemberVo;
import com.rental.toy.admin.member.AdminMemberVo;
import com.rental.toy.user.member.UserMemberService;


@Controller
@RequestMapping("/user/member")
public class UserMemberController {
	
	@Autowired
	UserMemberService userMemberService;
	
	
	//회원가입폼
	@GetMapping("/createAccountForm")
	public String createAccountForm() {
		String nextPage = "user/member/create_account_form";
		return nextPage;
	}
	
	//아이디중복체크
	@ResponseBody
	@RequestMapping(value="/idCheck/{umid}", method = {RequestMethod.POST, RequestMethod.GET})
	public Map<String, Boolean> idCheck(@PathVariable("umid") String u_m_id) {
		Map<String, Boolean> resultMap = new HashMap<String, Boolean>();
		boolean isMember = userMemberService.idCheck(u_m_id);
		resultMap.put("result", isMember);
		return resultMap;
	}
	
	//회원가입 완료
	@PostMapping("/createAccountConfirm")
	public String createAccountConfirm(UserMemberVo userMemberVo) {
		String nextPage = "user/member/create_account_ok";
		int result = userMemberService.createAccountConfirm(userMemberVo);
		if (result <= 0)
			nextPage = "user/member/create_account_ng";
		return nextPage;
	}
	
	//로그인폼
	@GetMapping("/loginForm")	
	public String loginForm() {
		String nextPage = "user/member/login_form";
		return nextPage;
	}
	
	//로그인 성공
	@PostMapping("/loginConfirm")
	public String loginConfirm(UserMemberVo userMemberVo, HttpSession session) {
		String nextPage = "user/member/login_ok";
		UserMemberVo loginedUserMemberVo = userMemberService.loginConfirm(userMemberVo);
		if (loginedUserMemberVo==null) {
			nextPage = "user/member/login_ng";
		} else {
			session.setAttribute("loginedUserMemberVo", loginedUserMemberVo);
			session.setMaxInactiveInterval(60 * 30);   // 세션 최대 유지시간 60*30=1800초(30분)
		}
		return nextPage;
	}
	
	//로그아웃
	@GetMapping("/logoutConfirm")
	public String logoutConfirm(HttpSession session) {
		String nextPage = "redirect:/user";
		session.invalidate();
		return nextPage;
	}
	
	//유저 정보변경폼
	@GetMapping("/modifyAccountForm")
	public String modifyAccountForm(HttpSession session) {
		String nextPage = "user/member/modify_account_form";
		return nextPage;
	}
	
	//유저 정보변경
	@PostMapping("/modifyAccountConfirm")
	public String modifyAccountConfirm(UserMemberVo userMemberVo, HttpSession session) {
		String nextPage = "user/member/modify_account_ok";
		int result = userMemberService.modifyAccountConfirm(userMemberVo);
		if (result > 0) {
			UserMemberVo logineduserMemberVo = userMemberService.getLoginedUserMemberVo(userMemberVo.getU_m_no());
			session.setAttribute("logineduserMemberVo", logineduserMemberVo);
			session.setMaxInactiveInterval(60 * 30);
		} else {
			nextPage = "user/member/modify_account_ng";
		}
		return nextPage;
	}
	
	
	//비밀번호 재설정 폼
	@GetMapping("/findPasswordForm")
	public String findePasswordForm() {
		String nextPage = "user/member/find_password_form";
		return nextPage;
	}
	
	//비밀번호 재설정 완료
	@PostMapping("/findPasswordConfirm")
	public String findPasswordConfirm(UserMemberVo userMemberVo) {
		String nextPage = "user/member/find_password_ok";
		int result = userMemberService.findPasswordConfirm(userMemberVo);
		if (result <= 0)
			nextPage = "user/member/find_password_ng";
		return nextPage;
	}
	

}
