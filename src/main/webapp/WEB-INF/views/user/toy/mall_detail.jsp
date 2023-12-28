<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="com.rental.toy.user.member.UserMemberVo"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/user/toy_detail.css' />" rel="stylesheet" type="text/css">


</head>
<body>

	<jsp:include page="../../common/commonjq.jsp" />

	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
		
			<div class="word">
			
				<h3>${mallToyVo.mt_name}</h3>
				<div>(<i class="fa-solid fa-cart-shopping"></i>:장바구니 / <i class="fa-solid fa-bag-shopping"></i>:구매하기)</div>
				
			</div>
			
			<div class="toy_detail">
			
				<ul>
					<li>
						<img src="<c:url value="/toyUploadImg/${mallToyVo.mt_photo}"/>" alt="${mallToyVo.mt_photo}">
					</li>
					<li>
						<table>
							<tr class="mt_name" data-bmno="${mallToyVo.mt_no}">
								<td>장난감명</td >
								<td>${mallToyVo.mt_name}</td>
							</tr>
							<tr class="mt_publisher">
								<td>제작사</td>
								<td>${mallToyVo.mt_publisher}</td>
							</tr>
							<tr class="mt_price">
								<td>가격</td>
								<td>${mallToyVo.mt_price}</td>
							</tr>
							<tr class="mt_detail">
								<td>상세내용</td>
								<td>${mallToyVo.mt_detail}</td>
							</tr>
						</table>
					</li>
				</ul>
			</div>
			<div class="buttons">
				<div class="buttons_L">	
					<a class="back_button" href="javascript:void(0);" onclick="Back()"><i class="fa-solid fa-rotate-left"></i></a>
				</div>
				<div class="buttons_R">
					<button type="button" class="cart_button" data-bmno="${mallToyVo.mt_no}"><i class="fa-solid fa-cart-shopping"></i></button>
					<button type="button" class="purchase_button"><i class="fa-solid fa-bag-shopping"></i></button>
					
				
				</div>
			</div>
		</div>
		<div id="modalOuter">
			<div id="modalInner">
			    <div class="infoText">
			    	<p>해당 상품을 장바구니에<br> 담았습니다.</p>
			    </div>
			    <div class="cartIcon">
					<i class="fa-solid fa-cart-shopping"></i>
				</div>
				<div class="close">
			    	<i class="fa-solid fa-xmark"></i>
			    </div>
			</div>
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	<script>
	
	    let user_no = "${loginedUserMemberVo.u_m_no}"
		jQ(".buttons .cart_button").on('click', function(){
			if (!user_no) {
				user_no = 0;
			} 
			let mt_data = {
					mt_photo : jQ(".toy_detail ul li:nth-child(1)").find("img").attr("alt"),
					mt_name : jQ(".toy_detail .mt_name td:nth-child(2)").text(),
					mt_publisher : jQ(".toy_detail .mt_publisher td:nth-child(2)").text(),
					mt_price : jQ(".toy_detail .mt_price td:nth-child(2)").text(),
					mt_no : jQ(this).attr("data-bmno"),			

			}
			console.log(mt_data)
			jQ("#modalOuter").fadeIn(300);
			jQ.ajax({
					type :"POST",
					contentType : "application/json; charset=UTF-8",
					url : "${pageContext.request.contextPath}/toy/user/cartIn/"+user_no,
					data : JSON.stringify(mt_data),
					success : function(){
					},
					error : function(error){
						console.log(error)
					}
			})
		})
		jQ("#modalOuter").on("click", ".close i, .moveBtn a:nth-child(2)", function(){
			jQ("#modalOuter").fadeOut(300);
		})
		</script>
	<script>
     function Back() {
         window.history.back();
     }
	</script>
	<script>
	jQ(".purchase_button").on("click", function(){
		let mt_list = 0;
		let count = 0;
		if (!user_no){
			location.href = "${pageContext.request.contextPath}/user/member/loginForm"
			return false;
		}
		mt_list = jQ('.mt_name').attr("data-bmno")
		location.href = "${pageContext.request.contextPath}/toy/user/orderForm?mtNos=" + mt_list;
	})
</script>

</body>
</html>