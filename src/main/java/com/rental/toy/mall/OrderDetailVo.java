package com.rental.toy.mall;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderDetailVo {
	int o_d_no;
	int order_no;
	int mt_no;
	int order_qty;
	int total_price;
	
	String order_status;
	String order_date;
	int u_m_no;
	String delivery_name;
	String delivery_address;
	String delivery_phone;
	String order_comment;
	
	String mt_name;
	String mt_publisher;
	int mt_price;
	int mt_quantity;
	String mt_photo;


}
