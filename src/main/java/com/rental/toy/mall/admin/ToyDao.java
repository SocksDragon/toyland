package com.rental.toy.mall.admin;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.rental.toy.mall.MallToyVo;
import com.rental.toy.mall.NoticeVo;
import com.rental.toy.mall.OrderVo;
import com.rental.toy.mall.RentalToyVo;


@Component
public class ToyDao {

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	private SqlSession sqlSession;

	//대여리스트등록 이름 중복값 확인
	public boolean rtname(String rt_name) {
		String sql =  "SELECT COUNT(*) FROM tbl_rental_toy "
						+ "WHERE rt_name = ?";
		int result = jdbcTemplate.queryForObject(sql, Integer.class, rt_name);
		return result > 0 ? true : false;

	}
	
	//대여리스트등록
	public int insertRentalToy(RentalToyVo rentalToyVo) {
		String sql = "INSERT INTO tbl_rental_toy(";
		sql += " rt_name, ";
		sql += " rt_publisher, ";
		sql += " rt_type, ";
		sql += " rt_photo, ";
		sql += " rt_reg_date, rt_mod_date,";
		sql += " rt_return_day,";
		sql += " rt_detail)";
		sql += " VALUES(?, ?, ?, ?, NOW(), NOW(), ?, ?)";
		
		int result = -1;
		
		try {
			result = jdbcTemplate.update(sql,
										rentalToyVo.getRt_name(),
										rentalToyVo.getRt_publisher(),
										rentalToyVo.getRt_type(),
										rentalToyVo.getRt_photo(),
										rentalToyVo.getRt_return_day(),
										rentalToyVo.getRt_detail()
										);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(result);
		return result;
	}


	//판매리스트 등록 이름 중복값 확인
	public boolean mtname(String mt_name) {
		String sql =  "SELECT COUNT(*) FROM tbl_mall_toy "
					+ "WHERE mt_name = ?";
			int result = jdbcTemplate.queryForObject(sql, Integer.class, mt_name);
			return result > 0 ? true : false;
	}
	//판매리스트 등록
	public int insertMallToy(MallToyVo mallToyVo) {
		String sql = "INSERT INTO tbl_mall_toy(";
		sql += " mt_name, ";
		sql += " mt_publisher, ";
		sql += " mt_type, ";
		sql += " mt_price, ";
		sql += " mt_quantity, ";
		sql += " mt_photo, ";
		sql += " mt_reg_date, mt_mod_date,";
		sql += " mt_detail)";
		sql += " VALUES(?, ?, ?, ?, ?, ?, NOW(), NOW(), ?)";
		
		int result = -1;
		
		try {
			result = jdbcTemplate.update(sql,
											mallToyVo.getMt_name(), 
											mallToyVo.getMt_publisher(), 
											mallToyVo.getMt_type(), 
											mallToyVo.getMt_price(),  
											mallToyVo.getMt_quantity(),											
											mallToyVo.getMt_photo(),
											mallToyVo.getMt_detail()
											);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(result);
		return result;
	}

	//대여 리스트
	public List<RentalToyVo> allRentaltoys() {
		String sql =  "SELECT * FROM tbl_rental_toy "
					+ "ORDER BY rt_reg_date DESC";
		List<RentalToyVo> rentalToyVos = new ArrayList<RentalToyVo>();
		try {
			
			RowMapper<RentalToyVo> rowMapper = BeanPropertyRowMapper.newInstance(RentalToyVo.class);
			rentalToyVos = jdbcTemplate.query(sql, rowMapper);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
	
	return rentalToyVos.size() > 0 ? rentalToyVos : null;
	}

	//판매리스트
	public List<MallToyVo> allMalltoys() {
		String sql =  "SELECT * FROM tbl_mall_toy "
					+ "ORDER BY mt_no ";
		List<MallToyVo> mallToyVos = new ArrayList<MallToyVo>();
		try {
			RowMapper<MallToyVo> rowMapper = BeanPropertyRowMapper.newInstance(MallToyVo.class);
			mallToyVos = jdbcTemplate.query(sql, rowMapper);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	return mallToyVos.size() > 0 ? mallToyVos : null;
	}

	
	//장난감 검색
	public List<MallToyVo> selectToysBySearch(MallToyVo mallToyVo) {
		String sql =  "SELECT * FROM tbl_mall_toy "
					+ "WHERE mt_name LIKE ? "
					+ "ORDER BY mt_no DESC";
	
	List<MallToyVo> mallToyVos = null;
	
		try {
			RowMapper<MallToyVo> rowMapper = BeanPropertyRowMapper.newInstance(MallToyVo.class);
			mallToyVos = jdbcTemplate.query(sql, rowMapper, "%" + mallToyVo.getMt_name() + "%");
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
	
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

	public int updateToy(MallToyVo mallToyVo) {
			
			List<String> args = new ArrayList<String>();
			
			String sql =  "UPDATE tbl_mall_toy SET ";
				   if (mallToyVo.getMt_photo() != null) {
					   sql += "mt_photo = ?, ";
					   args.add(mallToyVo.getMt_photo());
				   }
				   
				   sql += "mt_publisher = ?, ";
				   args.add(mallToyVo.getMt_publisher());
				   
				   sql += "mt_type = ?, ";
				   args.add(mallToyVo.getMt_type());
				   
				   sql += "mt_price = ?, ";
				   args.add(Integer.toString(mallToyVo.getMt_price()));
				   
				   sql += "mt_quantity = ?, ";
				   args.add(Integer.toString(mallToyVo.getMt_quantity()));
				   
				   sql += "mt_detail = ?, ";
				   args.add(mallToyVo.getMt_detail());
				   
				   sql += "mt_mod_date = NOW() ";

				   sql += "WHERE mt_no = ?";
				   args.add(Integer.toString(mallToyVo.getMt_no()));
			
			int result = -1;
			
			try {
				result = jdbcTemplate.update(sql, args.toArray());
			} catch (Exception e) {
				e.printStackTrace();
			}
			return result;
	}

	public int deleteToy(int mt_no) {
		String sql =  "DELETE FROM tbl_mall_toy "
				+ "WHERE mt_no = ?";
		int result = -1;
		try {
			result = jdbcTemplate.update(sql, mt_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
	return result;
	}

	public int deleteToyRental(int rt_no) {
		String sql =  "DELETE FROM tbl_rental_toy "
				+ "WHERE rt_no = ?";
		int result = -1;
		try {
			result = jdbcTemplate.update(sql, rt_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
	return result;
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
	
	//공지사항 상세페이지 이동
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


	public int insertNotice(NoticeVo noticeVo) {
		
		String sql = "INSERT INTO tbl_notice(";
			sql += " n_name, ";
			sql += " n_content, ";
			sql += " a_m_name, ";
			sql += " n_reg_date, n_mod_date,";
			sql += " n_hit)";
			sql += " VALUES(?, ?, ?, NOW(), NOW(), ?)";
			
			int result = -1;
			
			try {
				result = jdbcTemplate.update(sql,
												noticeVo.getN_name(), 
												noticeVo.getN_content(), 
												noticeVo.getA_m_name(), 
												noticeVo.getN_hit()
												);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return result;
	}

	public NoticeVo selectNotice(int n_no) {
		String sql = "SELECT * FROM tbl_notice WHERE n_no = ?";
		List<NoticeVo> noticeVos = null;
		
		try {
			RowMapper<NoticeVo> rowMapper = BeanPropertyRowMapper.newInstance(NoticeVo.class);
			noticeVos = jdbcTemplate.query(sql, rowMapper, n_no);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return noticeVos.size() > 0 ? noticeVos.get(0) : null;


	}

	public int updateNotice(NoticeVo noticeVo) {
			
		List<String> args = new ArrayList<String>();
		
		String sql = "UPDATE tbl_notice SET ";
			  			   
			   sql += "n_name = ?, ";
			   args.add(noticeVo.getN_name());
			   
			   sql += "n_content = ?, ";
			   args.add(noticeVo.getN_content());
			   
			   sql += "n_mod_date = NOW() ";

			   sql += "WHERE n_no = ?";
			   args.add(Integer.toString(noticeVo.getN_no()));
		
		int result = -1;
		
		try {
			result = jdbcTemplate.update(sql, args.toArray());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	
	}

	public int deleteNotice(int n_no) {
		String sql =  "DELETE FROM tbl_notice "
					+ "WHERE n_no = ?";
			int result = -1;
			try {
				result = jdbcTemplate.update(sql, n_no);
			} catch (Exception e) {
				e.printStackTrace();
			}
		return result;
	}

	public List<OrderVo> allToyOrder() {
		List<OrderVo> orderVos = null;
		orderVos = sqlSession.selectList("mapper.toy.allToyOrder");
		return orderVos;
	}
	
	public int setAdminApproval(int order_no) {
		int result = -1;
		result = sqlSession.update("mapper.toy.setAdminApproval", order_no);
		return result;
	}
	
	public List<OrderVo> allToyOrderDetail(int order_no) {
		List<OrderVo> orderVos = null;
		orderVos = sqlSession.selectList("mapper.toy.allToyOrderDetail", order_no);
		return orderVos;
	}

	
	
		
		
			
	
	
	
	
	
	


	
}
