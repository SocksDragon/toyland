package com.rental.toy.admin.member;

import java.security.SecureRandom;
import java.util.Date;
import java.util.List;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;

import com.rental.toy.admin.member.AdminMemberDao;
import com.rental.toy.admin.member.AdminMemberVo;
import com.rental.toy.user.member.UserMemberVo;

@Service
public class AdminMemberService {
	
	final static public int ADMIN_ACCOUNT_ALREADY_EXIST = 0;
	final static public int ADMIN_ACCOUNT_CREATE_SUCCESS = 1;
	final static public int ADMIN_ACCOUNT_CREATE_FAIL = -1;
	
	@Autowired
	AdminMemberDao adminMemberDao;
	
	@Autowired
	JavaMailSenderImpl javaMailSenderImpl;
	
	
	public boolean idCheck(String a_m_id) {
		return adminMemberDao.isAdminMember(a_m_id);
	}
	
	public int createAccountConfirm(AdminMemberVo adminMemberVo){
		boolean isMember = adminMemberDao.isAdminMember(adminMemberVo.getA_m_id());
		if (!isMember) {
			int result = adminMemberDao.insertAdminAccount(adminMemberVo);
			if (result>0) {
				return ADMIN_ACCOUNT_CREATE_SUCCESS;
			} else {
				return ADMIN_ACCOUNT_CREATE_FAIL;
			}
		} else {
			return ADMIN_ACCOUNT_ALREADY_EXIST;
		}
	}	
	
	//로그인 성공
	public AdminMemberVo loginConfirm(AdminMemberVo adminMemberVo) {
		AdminMemberVo loginedAdminMemberVo = adminMemberDao.selectAdmin(adminMemberVo);
		return loginedAdminMemberVo;
	}

	//어드민 리스트
	public List<AdminMemberVo> listupAdmin(){
		return adminMemberDao.selectAdminList();
	}
	
	//유저 리스트
	public List<AdminMemberVo> listupUser() {
		return adminMemberDao.selectUserList();
	}

	//정보변경
	public int modifyAccountConfirm(AdminMemberVo adminMemberVo) {
		return adminMemberDao.updateAdminAccount(adminMemberVo);
	}
	
	//정보변경 성공
	public AdminMemberVo getLoginedAdminMemberVo(int a_m_no) {
		return adminMemberDao.selectAdmins(a_m_no);
	}

	//비밀번호 재설정
	public int findPasswordConfirm(AdminMemberVo adminMemberVo) {
		AdminMemberVo selectedAdminMemberVo = adminMemberDao.selectAdmin(adminMemberVo.getA_m_id(), adminMemberVo.getA_m_name(), adminMemberVo.getA_m_mail());
		int result = 0;
		if (selectedAdminMemberVo != null) {
			String newPassword = createNewPassword();
			System.out.println(newPassword);
			result = adminMemberDao.updatePassword(adminMemberVo.getA_m_id(), newPassword);
			if (result > 0)
				sendNewPasswordByMail(adminMemberVo.getA_m_mail(), newPassword);
		}
        return result;
	}

	private String createNewPassword() {
		char[] chars = new char[] {
				'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 
				'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 
				'u', 'v', 'w', 'x', 'y', 'z'
				};
		StringBuffer stringBuffer = new StringBuffer();
		SecureRandom secureRandom = new SecureRandom();
		secureRandom.setSeed(new Date().getTime());
		
		int index = 0;
		int length = chars.length;
		for (int i = 0; i < 8; i++) {
			index = secureRandom.nextInt(length);
		
			if (index % 2 == 0) 
				stringBuffer.append(String.valueOf(chars[index]).toUpperCase());
			else
				stringBuffer.append(String.valueOf(chars[index]).toLowerCase());
		
		}
		System.out.println("[AdminMemberService] NEW PASSWORD: " + stringBuffer.toString());
		return stringBuffer.toString();
	}
	
	private void sendNewPasswordByMail(String toMailAddr, String newPassword) {
		final MimeMessagePreparator mimeMessagePreparator = new MimeMessagePreparator() {
			
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				final MimeMessageHelper mimeMessageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
				mimeMessageHelper.setTo(toMailAddr);
				mimeMessageHelper.setSubject("[토이랜드] 새 비밀번호 안내입니다.");
				mimeMessageHelper.setText("새 비밀번호 : " + newPassword, true);
			}
		};
		javaMailSenderImpl.send(mimeMessagePreparator);
	}

	


	
	
	
}
