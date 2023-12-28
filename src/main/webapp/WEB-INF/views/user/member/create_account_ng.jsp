<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/user/create_account_result.css' />" rel="stylesheet" type="text/css">

</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
		
			<div class="word">
			
				<h3>회원가입에 실패하셨습니다!!<br>다시 회원가입을 진행해 주시기 바랍니다.</h3>
				
			</div>
			
			<div class="others">
				
				<a href="<c:url value='/user/member/createAccountForm' />">회원가입</a>
				
			</div>
		
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
</body>
</html>