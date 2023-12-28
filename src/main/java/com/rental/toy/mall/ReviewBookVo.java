package com.rental.toy.mall;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewBookVo {
	int rev_no;
	String rev_content;
	String rev_reg_date;
	String rev_mod_date;

	int b_no;
	String b_thumbnail;
	String b_name;
	String b_author;	
	String b_publisher;
	String b_publish_year;
	String b_isbn;
	String b_call_number;
	int b_rental_able;
	String b_reg_date;
	String b_mod_date;
	int rev_b_no_count;
	int like_b_no_count;


	int u_m_no;
	String u_m_id;
	String u_m_pw;
	String u_m_name;
	String u_m_gender;
	String u_m_mail;
	String u_m_phone;
	String u_m_reg_date;
	String u_m_mod_date;


}
