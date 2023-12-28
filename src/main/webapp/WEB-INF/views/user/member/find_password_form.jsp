<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">

<link href="<c:url value='/resources/css/user/find_password_form.css' />" rel="stylesheet" type="text/css">

<script type="text/javascript">

	function findPasswordForm() {
		console.log('findPasswordForm() CALLED!!');
		
		let form = document.find_password_form;
		
		if (form.u_m_id.value == '') {
			alert('아이디를 입력하세요.');
			form.u_m_id.focus();
			
		} else if (form.u_m_name.value == '') {
			alert('성명을 입력하세요.');
			form.u_m_name.focus();
			
		} else if (form.u_m_mail.value == '') {
			alert('이메일주소를 입력하세요.');
			form.u_m_mail.focus();
			
		} else {
			form.submit();
			
		}
		
	}
</script>
<script>
     function Back() {
         window.history.back();
     }
</script>

</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
		
			<div class="word">
			
				<h3>비밀번호 재설정</h3>
				<p>(이메일으로 임시 비밀번호를 전달합니다.)</p>
				
			</div>
			
			<div class="find_password_form">
			
				<form action="<c:url value='/user/member/findPasswordConfirm' />" name="find_password_form" method="post">
					
					<input type="text" name="u_m_id" placeholder="아이디"> <br>
					<input type="text" name="u_m_name" placeholder="성명"> <br>
					<input type="text" name="u_m_mail" placeholder="이메일"> <br>
					<input type="button" value="이메일발송" onclick="findPasswordForm();"> 
					<input type="reset" value="취소" onclick="Back()">
					
				</form>
				
			</div>
			
			<div class="create_account_login">
				
				<a href="<c:url value='/user/member/createAccountForm' />">회원가입</a>
				<a href="<c:url value='/user/member/loginForm' />">로그인</a>
				
			</div>
		
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
</body>
</html>