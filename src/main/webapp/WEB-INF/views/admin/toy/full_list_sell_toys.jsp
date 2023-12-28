<%@page import="java.util.List"%>
<%@page import="com.rental.toy.mall.MallToyVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/full_list_of_toys.css' />" rel="stylesheet" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		<div id="section_wrap">
			<div class="word">
				<h3>전체 판매 리스트 목록</h3>
			</div>
			<div class="sell_toy_list">
		
			</div>
		</div>
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
	 <script>
		$.noConflict();
	    var jQ = jQuery;
	    jQ.ajax({
	        url : "${pageContext.request.contextPath}/toy/admin/allSelltoys",
	        type : "GET",
	        success:function(rdata){
	        	console.log(rdata)
	        	jQ('.sell_toy_list').html(rdata);
	        },
	        error:function(error){
	        	alert(error)
	        }
		})
	</script>	 
	
</body>
</html>