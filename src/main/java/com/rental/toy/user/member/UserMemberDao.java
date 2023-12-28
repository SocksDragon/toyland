package com.rental.toy.user.member;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.rental.toy.user.member.UserMemberVo;

@Component
public class UserMemberDao {

	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	PasswordEncoder passwordEncoder;

	@Autowired
	private SqlSession sqlSession;
	
	//중복 아이디체크
	public boolean isUserMember(String u_m_id) throws DataAccessException {
		int result = 0;
		result = sqlSession.selectOne("mapper.userMember.idCheck", u_m_id);
		return result > 0 ? true : false;
	}

	public int insertUserAccount(UserMemberVo userMemberVo) throws DataAccessException { 
		int result = -1;
		userMemberVo.setU_m_pw(passwordEncoder.encode(userMemberVo.getU_m_pw()));
		result = sqlSession.insert("mapper.userMember.insertUserAccount", userMemberVo);
		return result;
	}

	public UserMemberVo selectUser(UserMemberVo userMemberVo) throws DataAccessException {
		List<UserMemberVo> userMemberVos = new ArrayList<>();
		userMemberVos = sqlSession.selectList("mapper.userMember.selectUser", userMemberVo.getU_m_id());
		
	    if (userMemberVos != null && userMemberVos.size() > 0) {
			if (!passwordEncoder.matches(userMemberVo.getU_m_pw(), userMemberVos.get(0).getU_m_pw())){
			userMemberVos.clear();
			}
	    }
		return userMemberVos.size() > 0 ? userMemberVos.get(0) : null;
	}
	
	//정보변경1
	public int updateUserAccount(UserMemberVo userMemberVo) {
		int result = -1;
		userMemberVo.setU_m_pw(passwordEncoder.encode(userMemberVo.getU_m_pw()));
		result = sqlSession.update("mapper.userMember.updateUserAccount", userMemberVo);
		return result;
	}
   
	//정보변경2(로그인정보확인)
	public UserMemberVo selectUsers(int u_m_no) {
		List<UserMemberVo> userMemberVos = new ArrayList<UserMemberVo>();
		userMemberVos = sqlSession.selectList("mapper.userMember.selectUsers", u_m_no);
		return userMemberVos.size() > 0 ? userMemberVos.get(0) : null;
	}
	
	
	//비밀번호 재설정 정보확인
	public UserMemberVo selectUser(String u_m_id, String u_m_name, String u_m_mail) throws DataAccessException {
		List<UserMemberVo> userMemberVos = new ArrayList<UserMemberVo>();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("u_m_id", u_m_id);
		map.put("u_m_name", u_m_name);
		map.put("u_m_mail", u_m_mail);
		userMemberVos = sqlSession.selectList("mapper.userMember.selectUserFind", map);
		return userMemberVos.size()>0 ? userMemberVos.get(0) : null;  
	}
	
	//비밀번호 재설정 요청
	public int updatePassword(String u_m_id, String newPassword) {
		String sql =  "UPDATE tbl_user_member SET "
				+ "u_m_pw = ?,  u_m_mod_date = NOW() "
				+ "WHERE u_m_id = ?";
	int result = -1;
	try {
		result = jdbcTemplate.update(sql, passwordEncoder.encode(newPassword), u_m_id);
	} catch (Exception e) {
		e.printStackTrace();
	}
	return result;
	}


		

	
	
	
	
	
	
}
