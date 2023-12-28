<%@ page import="com.rental.toy.admin.member.AdminMemberVo" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="<c:url value='/resources/css/admin/include/nav.css' />" rel="stylesheet" type="text/css">

<script type="text/javascript">

	function searchToyForm() {
		
		let form = document.search_toy_form;
		
		if (form.mt_name.value == '') {
			alert('원하시는 장난감 명을 입력해주세요.');
			form.mt_name.focus();
		} else {
			form.submit();
		}
	}
</script>


<nav>
	<div id="nav_wrap">
	
	    <%
	       AdminMemberVo loginedAdminMemberVo  = (AdminMemberVo) session.getAttribute("loginedAdminMemberVo");
	       if (loginedAdminMemberVo != null) {
	    %>
	    
	    <div class="menu">
			<ul>
				<li><a href="<c:url value='/admin/member/modifyAccountForm' />">정보수정</a></li>
				<li><a href="<c:url value='/admin/member/logoutConfirm' />">로그아웃</a></li>
			</ul>
		</div>
	    
	    <% 	   
	       } else {
	    %>
	    
	    <div class="menu">
			<ul>
				<li><a href="<c:url value='/admin/member/loginForm' />">로그인</a></li>
				<li><a href="<c:url value='/admin/member/createAccountForm' />">회원가입</a></li>
			</ul>
		</div>  
	    
	    <%
	       }
	    %>
	
		
		<div id="logo_wrap">
		<div class="logo">
   			<a href="<c:url value='/admin' />"><img src="<c:url value='/resources/img/user/toyland_log.jpg' />"></a>
   		</div>
		<div class="search">
			<form action="<c:url value='/toy/admin/searchToyConfirm' />" name="search_toy_form" method="get">
				<input type="text" name="mt_name" placeholder="원하시는 장난감 명을 입력해주세요.">
				<button type="button" class="btn" onclick="searchToyForm();">
					<i class="fa-solid fa-magnifying-glass"></i>
				</button>
			</form>
		</div>
	</div>
	<div id="nav_menu">
		<ul>

			<c:if test="${loginedAdminMemberVo.a_m_id == 'seonghoseo'}">
				<li><a href="<c:url value='/admin/member/listupAdmin' />">관리자목록</a></li>
				<li><a href="<c:url value='/admin/member/listupUser' />">고객목록</a></li>
				<%-- <li><a href="<c:url value='/toy/admin/rentalAllToys' />">대여리스트</a></li> --%>
				<li><a href="<c:url value='/toy/admin/mallAllToys' />">판매리스트</a></li>
				<li><a href="<c:url value='/toy/admin/purchaseCheck' />">주문내역</a></li>
				<li><a href="<c:url value='/toy/admin/toyNotice' />">공지사항</a></li>
			</c:if>
		</ul>
	</div>
	
	
		
	</div>
</nav>