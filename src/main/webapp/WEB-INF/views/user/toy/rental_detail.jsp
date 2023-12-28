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



<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</head>
<body>
	<jsp:include page="../../common/commonjq.jsp" />

	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
			<div class="word">
				<h3>${rentalToyVo.rt_name}</h3>
				<div>(<i class="fa-solid fa-bag-shopping"></i>:대여하기)</div>
			</div>
			<div class="toy_detail">
			
				<ul>
					<li>
						<img src="<c:url value="/toyUploadImg/${rentalToyVo.rt_photo}"/>">
					</li>
					<li>
						<table>
							<tr>
								<td>장난감명</td >
								<td>${rentalToyVo.rt_name}</td>
							</tr>
							<tr>
								<td>제작사</td>
								<td>${rentalToyVo.rt_publisher}</td>
							</tr>
							<tr>
								<td>상세내용</td>
								<td>${rentalToyVo.rt_detail}</td>
							</tr>
							<tr>
								<td>반납일</td>
								<td>${rentalToyVo.rt_return_day}</td>
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
					<button type="button" class="purchase_button"><i class="fa-solid fa-bag-shopping"></i></button>
					
				</div>
			</div>
		</div>
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	<script>
     function Back() {
         window.history.back();
     }
	</script>
	<script>
    let user_no = "${loginedUserMemberVo.u_m_no}"
	jQ(".purchase_button").on("click", function(){
		let mt_list = []
		let count = 0
		if (!user_no){
			location.href = "${pageContext.request.contextPath}/user/member/loginForm"
			return false;
		}
		location.href = "${pageContext.request.contextPath}/toy/user/orderForm?mtNos=" + mt_list;
		
	})
	</script>
	

</body>
</html>