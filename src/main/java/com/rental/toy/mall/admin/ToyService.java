package com.rental.toy.mall.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rental.toy.mall.MallToyVo;
import com.rental.toy.mall.NoticeVo;
import com.rental.toy.mall.OrderVo;
import com.rental.toy.mall.RentalToyVo;


@Service
public class ToyService {
	
	@Autowired
	ToyDao toyDao;

	final static public int TOY_NAME_ALREADY_EXIST = 0; 
	final static public int TOY_REGISTER_SUCCESS = 1;	 
	final static public int TOY_REGISTER_FAIL = -1;	 
	
	//장난감 대여 등록 증복체크 rt_name
	public int rentalToyConfirm(RentalToyVo rentalToyVo) {
		boolean rtname = toyDao.rtname(rentalToyVo.getRt_name());
		if (!rtname) {
			int result = toyDao.insertRentalToy(rentalToyVo);
			if (result > 0)
				return TOY_REGISTER_SUCCESS;
			else
				return TOY_REGISTER_FAIL;
		} else {
			return TOY_NAME_ALREADY_EXIST;
		}
	}

	//장난감 판매 등록 증복체크 mt_name
	public int toyMallConfirm(MallToyVo mallToyVo) {
		boolean mtname = toyDao.mtname(mallToyVo.getMt_name());
		if (!mtname) {
			int result = toyDao.insertMallToy(mallToyVo);
			if (result > 0)
				return TOY_REGISTER_SUCCESS;
			else
				return TOY_REGISTER_FAIL;
		} else {
			return TOY_NAME_ALREADY_EXIST;
		}
	}

	public List<RentalToyVo> allRentaltoys() {
		return toyDao.allRentaltoys();

	}

	public List<MallToyVo> allMalltoys() {
		return toyDao.allMalltoys();
	}

	
	//장난감 검색
	public List<MallToyVo> searchToyConfirm(MallToyVo mallToyVo) {
		return toyDao.selectToysBySearch(mallToyVo);
	}

	public MallToyVo toyDetail(int mt_no) {
		return toyDao.selectToy(mt_no);
	}

	public MallToyVo modifyToyForm(int mt_no) {
		return toyDao.selectToy(mt_no);
	}

	public int modifyToyConfirm(MallToyVo mallToyVo) {
		return toyDao.updateToy(mallToyVo);
	}

	public int deleteToyConfirm(int mt_no) {
		return toyDao.deleteToy(mt_no);
	}
	
	public int deleteToyConfirmRental(int rt_no) {
		return toyDao.deleteToyRental(rt_no);
	}

	public List<NoticeVo> allToyNotice() {
		return toyDao.allToyNotice();
	}

	public NoticeVo noticeDetail(String n_name) {
		return toyDao.noticeDetail(n_name);
	}
	
	//공지등록 등록
	public int noticeConfirm(NoticeVo noticeVo) {
		int result = toyDao.insertNotice(noticeVo);
		if (result > 0) {
			return TOY_REGISTER_SUCCESS;
		} else {
			return TOY_REGISTER_FAIL;
		} 
	}

	//공지사항 수정폼이동
	public NoticeVo modifyNoticeForm(int n_no) {
		return toyDao.selectNotice(n_no);

	}
	
	//공지사항 수정완료버튼
	public int modifyNoticeConfirm(NoticeVo noticeVo) {
		return toyDao.updateNotice(noticeVo);
	
	}

	//공지사항 삭제버튼
	public int deleteNoticeConfirm(int n_no) {
		return toyDao.deleteNotice(n_no);
	}

	public List<OrderVo> allToyOrder() {
		return toyDao.allToyOrder();
	}

	public void setAdminApproval(int order_no) {
		toyDao.setAdminApproval(order_no);
	}

	public List<OrderVo> allToyOrderDetail(int order_no) {
		return toyDao.allToyOrderDetail(order_no);

	}


	
	
}
