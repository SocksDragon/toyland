<%@page import="java.util.List"%>
<%@page import="com.rental.toy.mall.RentalToyVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/full_list_of_toys.css' />" rel="stylesheet" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script type="text/javascript">
	function deleteToy(rt_no, rt_name, rt_photo) {
		let result = confirm('장난감(' + rt_name + ')를(을) 정말 삭제 하시겠습니까?');
		if (result)
		location.href = "<c:url value='/toy/admin/deleteToyConfirmRental?no="+rt_no+"&photo="+rt_photo+"'/>";
}
</script>
</head>
<body>
	<jsp:include page="../../include/header.jsp" />
	<jsp:include page="../include/nav.jsp" />
	<section>
		<div id="section_wrap">
			<div class="word">
				<h3>대여 상품 리스트</h3>
				<c:if test="${loginedAdminMemberVo.a_m_id == 'seonghoseo'}">
				<a href="<c:url value='/toy/admin/rentalToyForm' />" class="btn_add_rental"><i class="fa-solid fa-plus"></i></a>
				</c:if>
			</div>
			<div class="rental_toy_list">
		
			</div>
		</div>
	</section>
	<jsp:include page="../../include/footer.jsp" />
	
	 <script>
		$.noConflict();
	    var jQ = jQuery;
	    jQ.ajax({
	        url : "${pageContext.request.contextPath}/toy/admin/allRentaltoys",
	        type : "GET",
	       success:function(rdata){
	        	console.log(rdata)
	        	jQ('.rental_toy_list').html(rdata);
	        },
	        error:function(error){
	        	alert(error)
	        }
		})
	</script> 	
	
</body>
</html>