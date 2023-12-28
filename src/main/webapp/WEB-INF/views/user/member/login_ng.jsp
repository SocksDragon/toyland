<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">

<link href="<c:url value='/resources/css/user/login_result.css' />" rel="stylesheet" type="text/css">

</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
		
			<div class="word">
			
				<h3>로그인실패!!</h3>
				<span>다시 로그인해 보시기 바랍니다.</span>
				
			</div>
			
			<div class="others">
				
				<a href="<c:url value='/user/member/createAccountForm' />">회원가입</a>
				<a href="<c:url value='/user/member/loginForm' />">로그인</a>
				<a href="<c:url value='/user/member/findPasswordForm' />">비밀번호재설정</a>
				
			</div>
		
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
</body>
</html>