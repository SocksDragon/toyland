<%@ page import="com.rental.toy.admin.member.AdminMemberVo" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/login_result.css' />" rel="stylesheet" type="text/css">

</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
		
			<div class="word">
			
				<h3>로그인 성공!!</h3>
				
			</div>
			
			<div class="others">
			<c:choose>
			    <c:when test="${loginedAdminMemberVo.a_m_id == 'seonghoseo'}">
					<a href="<c:url value='/admin/member/listupAdmin' />">관리자목록</a>
					<a href="<c:url value='/admin/member/listupUser' />">고객목록</a>
					<a href="<c:url value='/toy/admin/mallAllToys' />">판매리스트</a>
					<a href="<c:url value='/toy/admin/purchaseCheck' />">주문내역</a>
					<a href="<c:url value='/toy/admin/toyNotice' />">공지사항</a>			    </c:when>
			    <c:otherwise>
					<%-- <a href="<c:url value='/toy/admin/rentalAllToys' />">대여리스트</a> --%>
					<a href="<c:url value='/toy/admin/mallAllToys' />">판매리스트</a>			    </c:otherwise>
			</c:choose>
			</div>
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
</body>
</html>