package com.rental.toy.mall.user;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rental.toy.mall.CartToyVo;
import com.rental.toy.mall.MallToyVo;
import com.rental.toy.mall.NoticeVo;
import com.rental.toy.mall.OrderDetailVo;
import com.rental.toy.mall.OrderVo;
import com.rental.toy.mall.RentalToyVo;


@Service
public class ToyService {
	
	@Autowired
	ToyDao toyDao;

	final static public int TOY_NAME_ALREADY_EXIST = 0; 
	final static public int TOY_REGISTER_SUCCESS = 1;	 
	final static public int TOY_REGISTER_FAIL = -1;	 
	
	
	public List<MallToyVo> mallToyListAll() {
		return toyDao.mallToyListAll();
	}

	public List<MallToyVo> mallToyListType(String mt_type) {
		return toyDao.mallToyListType(mt_type);
	}

	public List<MallToyVo> searchToyConfirm(MallToyVo mallToyVo) {
		return toyDao.selectToysBySearch(mallToyVo);
	}

	public MallToyVo toyDetail(int mt_no) {
		return toyDao.selectToy(mt_no);
	}
	
	public RentalToyVo rentalDetail(int rt_no) {
		return toyDao.selectRental(rt_no);
	}
	
	public List<RentalToyVo> rentalToyListAll() {
		return toyDao.rentalToyListAll();
	}

	public List<NoticeVo> allToyNotice() {
		return toyDao.allToyNotice();
	}

	public NoticeVo noticeDetail(String n_name) {
		return toyDao.noticeDetail(n_name);
	}
	
	public int cartSessionInsert(List<CartToyVo> distinctCartList) {
		return toyDao.cartSessionInsert(distinctCartList);
	}

	public int cartInsert(CartToyVo cartToyVo) {
		return toyDao.cartInsert(cartToyVo);
	}
	
	public List<CartToyVo> cartSelectUser(int user_no) {
		return toyDao.cartSelectUser(user_no);
	}

	public void updateQty(CartToyVo cartToyVo) {
		toyDao.updateQty(cartToyVo);
	}

	public int removeCart(CartToyVo cartToyVo) {
		return toyDao.removeCart(cartToyVo);
	}

	public List<CartToyVo> orderList(List<Map<String, Integer>> cartCheckList) {
		return toyDao.orderList(cartCheckList);
	}

	public int purchase(OrderVo orderVo) {
		return toyDao.purchase(orderVo);
	}

	public int orderDetailInsert(List<OrderDetailVo> orderDetailVos) {
		return toyDao.orderDetailInsert(orderDetailVos);
	}

	public void inventoryUpdate(List<OrderDetailVo> orderDetailVos) {
		toyDao.inventoryUpdate(orderDetailVos);
	}

	public void cartDelete(List<CartToyVo> cartToyVos) {
		toyDao.cartDelete(cartToyVos);
		
	}

	public List<OrderVo> orderUserSelect(int u_m_no) {
		return toyDao.orderUserSelect(u_m_no);
	}

	public List<OrderVo> orderDetail(int order_no) {
		return toyDao.orderDetail(order_no);
	}

	public void orderCancel(int order_no) {
		toyDao.orderCancel(order_no);
		
	}

	public int removePurchase(OrderVo orderVo) {
		return toyDao.removePurchase(orderVo);
	}




	
	

	
	
}
