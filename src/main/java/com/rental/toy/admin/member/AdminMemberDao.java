package com.rental.toy.admin.member;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.rental.toy.admin.member.AdminMemberVo;
import com.rental.toy.user.member.UserMemberVo;

import org.springframework.security.crypto.password.PasswordEncoder;

import org.apache.ibatis.session.SqlSession;
import org.springframework.dao.DataAccessException;


@Component
public class AdminMemberDao {
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
	private SqlSession sqlSession;

	public boolean isAdminMember(String a_m_id) throws DataAccessException { 
		int result = 0;
		result = sqlSession.selectOne("mapper.adminMember.idCheck", a_m_id);
		return result > 0 ? true : false;
	}
	
	public int insertAdminAccount(AdminMemberVo adminMemberVo) throws DataAccessException { 
		int result = -1;
		adminMemberVo.setA_m_pw(passwordEncoder.encode( adminMemberVo.getA_m_pw()));
		result = sqlSession.insert("mapper.adminMember.insertAdminAccount", adminMemberVo);
		return result;
	}

	public AdminMemberVo selectAdmin(AdminMemberVo adminMemberVo) throws DataAccessException { 
	    List<AdminMemberVo> adminMemberVos = new ArrayList<>();
	    adminMemberVos = sqlSession.selectList("mapper.adminMember.selectAdmin", adminMemberVo.getA_m_id());

	    if (adminMemberVos != null && adminMemberVos.size() > 0) {
	        if (!passwordEncoder.matches(adminMemberVo.getA_m_pw(), adminMemberVos.get(0).getA_m_pw())){
	            adminMemberVos.clear();
	        }
	    }

	    return adminMemberVos.size() > 0 ? adminMemberVos.get(0) : null;
	}

	//어드민 리스트
	public List<AdminMemberVo> selectAdminList() throws DataAccessException { 
		List<AdminMemberVo> adminMemberVos = null;
		adminMemberVos = sqlSession.selectList("mapper.adminMember.selectAdminList");
		return adminMemberVos;
	}
	
	//유저 리스트
	public List<AdminMemberVo> selectUserList() throws DataAccessException {
		List<AdminMemberVo> adminMemberVos = null;
		adminMemberVos = sqlSession.selectList("mapper.adminMember.selectUserList");
		return adminMemberVos;
	}

	
	//정보변경1
	public int updateAdminAccount(AdminMemberVo adminMemberVo) {
		int result = -1;
		adminMemberVo.setA_m_pw(passwordEncoder.encode(adminMemberVo.getA_m_pw()));
		result = sqlSession.update("mapper.adminMember.updateAdminAccount", adminMemberVo);
		return result;
	}

	////정보변경2(로그인정보확인)
	public AdminMemberVo selectAdmins(int a_m_no) {
		List<AdminMemberVo> adminMemberVos = new ArrayList<AdminMemberVo>();
		adminMemberVos = sqlSession.selectList("mapper.adminMember.selectAdmins", a_m_no);
		return adminMemberVos.size() > 0 ? adminMemberVos.get(0) : null;
	}

	public AdminMemberVo selectAdmin(String a_m_id, String a_m_name, String a_m_mail) throws DataAccessException { 
		List<AdminMemberVo> adminMemberVos = new ArrayList<AdminMemberVo>();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("a_m_id", a_m_id);
		map.put("a_m_name", a_m_name);
		map.put("a_m_mail", a_m_mail);
		adminMemberVos = sqlSession.selectList("mapper.adminMember.selectAdminFind", map);
		return adminMemberVos.size()>0 ? adminMemberVos.get(0) : null;   
	}

	public int updatePassword(String a_m_id, String newPassword) {
		String sql =  "UPDATE tbl_admin_member SET "
					+ "a_m_pw = ?,  a_m_mod_date = NOW() "
					+ "WHERE a_m_id = ?";
		int result = -1;
		try {
			result = jdbcTemplate.update(sql, passwordEncoder.encode(newPassword), a_m_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}








}
