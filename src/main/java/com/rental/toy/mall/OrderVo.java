package com.rental.toy.mall;

import lombok.Setter;

import java.util.List;

import lombok.Getter;

@Getter
@Setter
public class OrderVo {

	int order_no;
	String order_status;
	String order_date;
	int u_m_no;
	String delivery_name;
	String delivery_address;
	String delivery_phone;
	String order_comment;
	String ord_bank;

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

	List<Integer> order_nos;
	List<Integer> order_qtys;
	
	int mt_no;
	String mt_name;
	String mt_publisher;
	int mt_price;
	int mt_quantity;
	String mt_photo;
	
	int order_qty;
	int total_price;
	int cnt;
	
}
