package com.rental.toy.mall;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CartBookVo {
	int cart_no;
	int bm_no;
	int u_m_no;
	int cart_qty;

	String bm_name;
	String bm_author;
	String bm_publisher;
	String bm_isbn;
	int bm_price;
	int bm_quantity;
	String bm_photo0;
	String bm_photo1;
	String bm_photo2;
	
	String u_m_id;
	String u_m_pw;
	String u_m_name;
	String u_m_gender;
	String u_m_mail;
	String u_m_phone;
	String u_m_reg_date;
	String u_m_mod_date;
}
