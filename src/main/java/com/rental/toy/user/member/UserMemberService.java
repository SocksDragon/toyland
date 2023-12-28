package com.rental.toy.user.member;

import java.security.SecureRandom;
import java.util.Date;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;

import com.rental.toy.admin.member.AdminMemberVo;
import com.rental.toy.user.member.UserMemberVo;

@Service
public class UserMemberService {

	final static public int USER_ACCOUNT_ALREADY_EXIST = 0;
	final static public int USER_ACCOUNT_CREATE_SUCCESS = 1;
	final static public int USER_ACCOUNT_CREATE_FAIL = -1;
	
	@Autowired
	UserMemberDao userMemberDao;
	
	@Autowired
	JavaMailSenderImpl javaMailSenderImpl;

		
	//중복 아이디체크
	public boolean idCheck(String u_m_id) {
		return userMemberDao.isUserMember(u_m_id);
	}

	//회원가입완료
	public int createAccountConfirm(UserMemberVo userMemberVo) {
		
		boolean isMember = userMemberDao.isUserMember(userMemberVo.getU_m_id());
		
		if (!isMember) {
			int result = userMemberDao.insertUserAccount(userMemberVo);
			
			if (result > 0)
				return USER_ACCOUNT_CREATE_SUCCESS;
			else
				return USER_ACCOUNT_CREATE_FAIL;
		} else {
			return USER_ACCOUNT_ALREADY_EXIST;
		}
	}
	
	//로그인 성공
	public UserMemberVo loginConfirm(UserMemberVo userMemberVo) {
		UserMemberVo loginUserMemberVo = userMemberDao.selectUser(userMemberVo);
		return loginUserMemberVo;
	}
	
	//정보변경
	public int modifyAccountConfirm(UserMemberVo userMemberVo) {
		return userMemberDao.updateUserAccount(userMemberVo);
	}

	//정보변경(로그인정보확인)
	public UserMemberVo getLoginedUserMemberVo(int u_m_no) {
		return userMemberDao.selectUsers(u_m_no);
	}
	
	//비밀번호 재설정
	public int findPasswordConfirm(UserMemberVo userMemberVo) {
		UserMemberVo selectedUserMemberVo = userMemberDao.selectUser(userMemberVo.getU_m_id(), userMemberVo.getU_m_name(), userMemberVo.getU_m_mail());
		int result = 0;
		if (selectedUserMemberVo != null) {
			String newPassword = createNewPassword();
			System.out.println(newPassword);
			result = userMemberDao.updatePassword(userMemberVo.getU_m_id(), newPassword);
			if (result > 0)
				sendNewPasswordByMail(userMemberVo.getU_m_mail(), newPassword);
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
