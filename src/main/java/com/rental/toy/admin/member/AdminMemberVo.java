package com.rental.toy.admin.member;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminMemberVo {

	int a_m_no;         	// 관리자회원 고유번호(자동증가값)
	int a_m_approval;   	// 고급관리자 승인 여부(기본값 0) 
	String a_m_id;      	// 관리자 아이디
	String a_m_pw;  		// 관리자 비밀번호
	String a_m_name;    	// 관리자 이름
	String a_m_gender;		// 관리자 성별
	String a_m_mail;		// 관리자 이메일
	String a_m_phone;		// 관리자 연락처
	String a_m_reg_date;	// 관리자 등록일(가입일)
	String a_m_mod_date;	// 관리자 수정일(정보수정일)
	
	int u_m_no;
	String u_m_id;
	String u_m_pw;
	String u_m_name;
	String u_m_gender;
	String u_m_mail;
	String u_m_phone;
	String u_m_reg_date;
	String u_m_mod_date;
	String u_m_zipcode;
	String u_m_address;
	String u_m_address_sub;
}
