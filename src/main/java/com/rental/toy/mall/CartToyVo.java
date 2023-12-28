package com.rental.toy.mall;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CartToyVo {
	int cart_no;
	int mt_no;
	int u_m_no;
	int cart_qty;

	String mt_name;
	String mt_publisher;
	String mt_type;
	int mt_price;
	int mt_quantity;
	String mt_photo;
	String mt_reg_date;
	String mt_mod_date;
	String mt_detail;
	
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
