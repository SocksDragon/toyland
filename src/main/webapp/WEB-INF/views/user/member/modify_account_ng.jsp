<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">

<link href="<c:url value='/resources/css/admin/modify_account_result.css' />" rel="stylesheet" type="text/css">

</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		<div id="section_wrap">
			<div class="word">
				<h3>정보변경에 실패하셨습니다!!<br>정보변경을 다시 진행해 주시기 바랍니다.</h3>
			</div>
		 	<div class="menu">
				<ul>
					<li><a href="<c:url value='/user/member/modifyAccountForm' />">정보변경</a></li>
				</ul>
			</div> 
		</div>
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
</body>
</html>