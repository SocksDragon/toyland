package com.rental.toy.mall.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.rental.toy.mall.CartToyVo;
import com.rental.toy.mall.MallToyVo;
import com.rental.toy.mall.NoticeVo;
import com.rental.toy.mall.OrderDetailVo;
import com.rental.toy.mall.OrderVo;
import com.rental.toy.mall.RentalToyVo;


@Component
public class ToyDao {

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	private SqlSession sqlSession;
	
	//전체리스트
	public List<MallToyVo> mallToyListAll() throws DataAccessException {
			List<MallToyVo> mallToyListAll = null;
			mallToyListAll = sqlSession.selectList("mapper.toy.mallToyListAll");
			return mallToyListAll;
	}

	//타입별 리스트
	public List<MallToyVo> mallToyListType(String mt_type) throws DataAccessException {
		List<MallToyVo> mallToyListType = null;
		mallToyListType = sqlSession.selectList("mapper.toy.mallToyListType", mt_type);
		return mallToyListType;
	}

	public List<MallToyVo> selectToysBySearch(MallToyVo mallToyVo) throws DataAccessException {
		List<MallToyVo>  mallToyVos = null;
		mallToyVos = sqlSession.selectList("mapper.toy.selectToys", mallToyVo);
		return mallToyVos.size() > 0 ? mallToyVos : null;
	}

	public MallToyVo selectToy(int mt_no) {
		String sql = "SELECT * FROM tbl_mall_toy WHERE mt_no = ?";
		List<MallToyVo> mallToyVos = null;
		try {
			RowMapper<MallToyVo> rowMapper = BeanPropertyRowMapper.newInstance(MallToyVo.class);
			mallToyVos = jdbcTemplate.query(sql, rowMapper, mt_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mallToyVos.size() > 0 ? mallToyVos.get(0) : null;
	}
	
	public RentalToyVo selectRental(int rt_no) {
		String sql = "SELECT * FROM tbl_rental_toy WHERE rt_no = ?";
		List<RentalToyVo> rentalToyVos = null;
		try {
			RowMapper<RentalToyVo> rowMapper = BeanPropertyRowMapper.newInstance(RentalToyVo.class);
			rentalToyVos = jdbcTemplate.query(sql, rowMapper, rt_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rentalToyVos.size() > 0 ? rentalToyVos.get(0) : null;
	}

	public List<RentalToyVo> rentalToyListAll() throws DataAccessException {
		List<RentalToyVo> rentalToyListAll = null;
		rentalToyListAll = sqlSession.selectList("mapper.toy.rentalToyListAll");
		return rentalToyListAll;
	}

	public List<NoticeVo> allToyNotice() {
		String sql =  "SELECT * FROM tbl_notice "
					+ "ORDER BY n_no ";
		List<NoticeVo> noticeVos = new ArrayList<NoticeVo>();
			try {
				RowMapper<NoticeVo> rowMapper = BeanPropertyRowMapper.newInstance(NoticeVo.class);
				noticeVos = jdbcTemplate.query(sql, rowMapper);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		return noticeVos.size() > 0 ? noticeVos : null;
	}

	public NoticeVo noticeDetail(String n_name) {
		String sql = "SELECT * FROM tbl_notice WHERE n_name = ?";
		List<NoticeVo> noticeVos = null;
		
		try {
			RowMapper<NoticeVo> rowMapper = BeanPropertyRowMapper.newInstance(NoticeVo.class);
			noticeVos = jdbcTemplate.query(sql, rowMapper, n_name);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return noticeVos.size() > 0 ? noticeVos.get(0) : null;
	}
	
	public int cartSessionInsert(List<CartToyVo> distinctCartList) {
		int result = -1;
		result = sqlSession.insert("mapper.toy.cartSessionInsert", distinctCartList);
		return result;
}
	
	public int cartInsert(CartToyVo cartToyVo) {
		int result = -1;
		result = sqlSession.insert("mapper.toy.cartInsertLogin", cartToyVo);
		return result;
	}
	
	

	public List<CartToyVo> cartSelectUser(int user_no) {
		List<CartToyVo> cartToyVos = new ArrayList<>();
		cartToyVos = sqlSession.selectList("mapper.toy.cartSelectUser", user_no);
		return cartToyVos;
	}

	public void updateQty(CartToyVo cartToyVo) {
			sqlSession.update("mapper.toy.updateQty", cartToyVo);	
	}

	public int removeCart(CartToyVo cartToyVo) {
		int result = -1;
		result = sqlSession.delete("mapper.toy.removeCart", cartToyVo);
		return result;
	
	}

	public List<CartToyVo> orderList(List<Map<String, Integer>> cartCheckList) {
		List<CartToyVo> orderResultList = new ArrayList<>();
		orderResultList = sqlSession.selectList("mapper.toy.orderList", cartCheckList);
		return orderResultList;
	}

	public int purchase(OrderVo orderVo) {
		int result = -1;
		result = sqlSession.insert("mapper.toy.purchase", orderVo);
		return result;
	}

	public int orderDetailInsert(List<OrderDetailVo> orderDetailVos) {
		int result = -1;
		result = sqlSession.insert("mapper.toy.orderDetailInsert", orderDetailVos);
		return result;
	}

	public void inventoryUpdate(List<OrderDetailVo> orderDetailVos) {
		for (int i=0; i<orderDetailVos.size(); i++) {
			sqlSession.update("mapper.toy.inventoryUpdate", orderDetailVos.get(i));
		}
	}

	public int cartDelete(List<CartToyVo> cartToyVos) {
		int result = -1;
		result = sqlSession.delete("mapper.toy.cartDelete", cartToyVos);
		return result;
	}

	public List<OrderVo> orderUserSelect(int u_m_no) {
		List<OrderVo> orderVos = new ArrayList<>(); 
		orderVos = sqlSession.selectList("mapper.toy.orderUserSelect", u_m_no);
		return orderVos;
	}

	public List<OrderVo> orderDetail(int order_no) {
		List<OrderVo> orderVos = new ArrayList<>();
		orderVos = sqlSession.selectList("mapper.toy.orderDetail", order_no);
		return orderVos;
	}

	public void orderCancel(int order_no) {
		sqlSession.delete("mapper.toy.orderCancel", order_no);
	}

	public int removePurchase(OrderVo orderVo) {
		int result = -1;
		result = sqlSession.delete("mapper.toy.removePurchase", orderVo);
		return result;
	}



	

	

	
	
	
	
	


	
}
