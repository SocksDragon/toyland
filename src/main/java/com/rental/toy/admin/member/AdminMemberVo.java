package com.rental.toy.admin.member;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminMemberVo {

	int a_m_no;         	// ������ȸ�� ������ȣ(�ڵ�������)
	int a_m_approval;   	// ��ް����� ���� ����(�⺻�� 0) 
	String a_m_id;      	// ������ ���̵�
	String a_m_pw;  		// ������ ��й�ȣ
	String a_m_name;    	// ������ �̸�
	String a_m_gender;		// ������ ����
	String a_m_mail;		// ������ �̸���
	String a_m_phone;		// ������ ����ó
	String a_m_reg_date;	// ������ �����(������)
	String a_m_mod_date;	// ������ ������(����������)
	
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
