<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">

<link href="<c:url value='/resources/css/user/login_form.css' />" rel="stylesheet" type="text/css">

<script type="text/javascript">

	function loginForm() {
		let form = document.login_form;
		
		if (form.u_m_id.value == '') {
			alert('아이디를 입력하세요.');
			form.u_m_id.focus();
			
		} else if (form.u_m_pw.value == '') {
			alert('비밀번호를 입력하세요.');
			form.u_m_pw.focus();
			
		} else {
			form.submit();
			
		}
		
	}

</script>

</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
			
			<div class="word">
			
				<h3>로 그 인</h3>
				
			</div>
			
			<div class="login_form">
			
				<form action="<c:url value='/user/member/loginConfirm' />" name="login_form" method="post">
					<div class="idpw">
						<input type="text"		name="u_m_id" 		placeholder="아이디"> <br>
						<input type="password"	name="u_m_pw" 		placeholder="비밀번호"> <br>
					</div>
					<div class="login_btn">
						<button type="button"	 onclick="loginForm();"> 
							<i class="fa-solid fa-right-to-bracket"></i><br>
							로그인
						</button>
					</div>

					
				</form>
				
			</div>
			
			<div class="find_password_create_account">
				
				<a href="<c:url value='/user/member/findPasswordForm' />">비밀번호 재설정</a>
				<a href="<c:url value='/user/member/createAccountForm' />">회원가입</a>
				
			</div>
		
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
</body>
</html>