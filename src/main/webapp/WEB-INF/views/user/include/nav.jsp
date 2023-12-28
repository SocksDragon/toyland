<%@ page import="com.rental.toy.user.member.UserMemberVo" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="<c:url value='/resources/css/user/include/nav.css' />" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script type="text/javascript">
	function searchToyForm() {
		let form = document.search_toy_form;
		if (form.mt_name.value == '') {
			alert('장난감 명을 입력해 주세요.');
			form.mt_name.focus();
		} else {
			form.submit();
		}
	}
</script>

<nav>
	<div id="nav_wrap">
	    <%
	       UserMemberVo loginedUserMemberVo  = (UserMemberVo) session.getAttribute("loginedUserMemberVo");
	       if (loginedUserMemberVo != null) {
	    %>
	    <div class="menu">
			<ul>
				<li>
					<div class=menu_btn>
					<a href="<c:url value='/user/member/logoutConfirm' />">
						<img src="<c:url value='/resources/img/user/login.jpg' />"><br>로그아웃
					</a> 
					</div>
				</li>
				<li>
					<div class=menu_btn>
					<a href="<c:url value='/user/member/modifyAccountForm' />">
						<img src="<c:url value='/resources/img/user/signup.jpg' />"><br>정보수정
					</a>
					</div>
				</li>
				<li>
					<div class=menu_btn>
					<a href="<c:url value='/toy/user/purchaseCheck' />">
						<img src="<c:url value='/resources/img/user/purchase.png' />"><br>주문내역
					</a>
					</div>
				</li>
				<li>
					<div class=menu_btn>
					<a href="<c:url value='/toy/user/cartPage' />">
						<img src="<c:url value='/resources/img/user/cart.jpg' />"><br>장바구니
					</a>
					</div>
				</li>
				<li>
					<div class=menu_btn>
					<a href="<c:url value='/toy/user/toyNotice' />">
						<img src="<c:url value='/resources/img/user/notice.png' />"><br>공지사항
					</a>
					</div>
				</li>
			</ul>
		</div>
	    <% 	   
	       } else {
	    %>
	    <div class="menu">
			<ul>
				<li><div class=menu_btn>
					<a href="<c:url value='/user/member/loginForm' />">
						<img src="<c:url value='/resources/img/user/login.jpg' />"><br>로그인
					</a> 
					</div>
				</li>
				<li>
					<div class=menu_btn>
					<a href="<c:url value='/user/member/createAccountForm' />">
						<img src="<c:url value='/resources/img/user/signup.jpg' />"><br>회원가입
					</a>
					</div>
				</li>
				<li>
					<div class=menu_btn>
					<a href="<c:url value='/toy/user/cartPage' />">
						<img src="<c:url value='/resources/img/user/cart.jpg' />"><br>장바구니
					</a>
					</div>
				</li>
				<li>
					<div class=menu_btn>
					<a href="<c:url value='/toy/user/toyNotice' />">
						<img src="<c:url value='/resources/img/user/notice.png' />"><br>공지사항
					</a>
					</div>
				</li>
			</ul>
		</div>  
	    <%
	       }
	    %>
   	</div>
	<div id="logo_wrap">
		<div class="logo">
   			<a href="<c:url value='/user' />"><img src="<c:url value='/resources/img/user/toyland_log.jpg' />"></a>
   		</div>
		<div class="search">
			<form action="<c:url value='/toy/user/searchToyConfirm' />" name="search_toy_form" method="get">
				<input type="text" name="mt_name" placeholder="원하시는 장난감 명을 입력해주세요.">
				<button type="button" class="btn" onclick="searchToyForm();">
					<i class="fa-solid fa-magnifying-glass"></i>
				</button>
			</form>
		</div>
	</div>
	<div id="nav_menu">
		<ul>
			<li><a href="<c:url value='/toy/user/mallToyType?mt_type=인형' />">인형</a></li>
			<li><a href="<c:url value='/toy/user/mallToyType?mt_type=캐릭터' />">캐릭터</a></li>
			<li><a href="<c:url value='/toy/user/mallToyType?mt_type=자동차' />">자동차</a></li>
			<li><a href="<c:url value='/toy/user/mallToyType?mt_type=영유아' />">영유아</a></li>
			<li><a href="<c:url value='/toy/user/mallToyType?mt_type=블록' />">블록</a></li>
			<!--  <li><a href="<c:url value='/toy/user/rentalToySearchAll' />">대여</a></li>-->
			
		</ul>
	</div>
	
</nav>