<%@ page import="com.rental.toy.admin.member.AdminMemberVo" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/home.css' />" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<script type="text/javascript">

	function loginForm() {
	
		let form = document.login_form;
		
		if (form.a_m_id.value == '') {
			alert('아이디를 입력하세요.');
			form.a_m_id.focus();
			
		} else if (form.a_m_pw.value == '') {
			alert('비밀번호를 입력하세요.');
			form.a_m_pw.focus();
			
		} else {
			form.submit();
			
		}
		
	}

</script>
</head>
<body>
	
	<jsp:include page="../include/header.jsp" />
	
	<jsp:include page="./include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
			<div class="word">
				<h3><i class="fa-solid fa-user-tie"></i><br>
					어드민 페이지 입니다.
				</h3>
			</div>
		 <%
	       AdminMemberVo loginedAdminMemberVo  = (AdminMemberVo) session.getAttribute("loginedAdminMemberVo");
	       if (loginedAdminMemberVo != null) {
    	%>
    		<div class="login_result">
    		<c:choose>
			    <c:when test="${loginedAdminMemberVo.a_m_id == 'seonghoseo'}">
					<a href="<c:url value='/admin/member/listupAdmin' />">관리자목록</a>
					<a href="<c:url value='/admin/member/listupUser' />">고객목록</a>
					<a href="<c:url value='/toy/admin/rentalAllToys' />">대여리스트</a>
					<a href="<c:url value='/toy/admin/mallAllToys' />">판매리스트</a>
					<a href="<c:url value='/toy/admin/toyNotice' />">공지사항</a>			    
				</c:when>
			    <c:otherwise>
					<a href="<c:url value='/toy/admin/rentalAllToys' />">대여리스트</a>
					<a href="<c:url value='/toy/admin/mallAllToys' />">판매리스트</a>			    
				</c:otherwise>
			</c:choose>
			</div>
    	
    	 <% 	   
	       } else {
	    %>
			<div class="login_form">
				<form action="<c:url value='/admin/member/loginConfirm' />" name="login_form" method="post">
					<input type="text"		name="a_m_id" 		placeholder="아이디"> <br>
					<input type="password"	name="a_m_pw" 		placeholder="비밀번호"> <br>
					<input type="button"	value="로그인" 		onclick="loginForm();"> 
					<input type="reset"		value="취소">
				</form>
			</div>
			
			<div class="find_password_create_account">
				<a href="<c:url value='/admin/member/findPasswordForm' />">비밀번호 재설정</a>
				<a href="<c:url value='/admin/member/createAccountForm' />">회원가입</a>
			</div>
		</div>
	  <%
	       }
	    %>
	
		
	</section>
	
	<jsp:include page="../include/footer.jsp" />
	
</body>
</html>