<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.rental.toy.mall.MallToyVo"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/user/toy_mall.css' />" rel="stylesheet" type="text/css">

</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
			<div class="word">
				<h3>판매 리스트</h3>
			</div>
			
			<div class="mallToyList">
				<ul class="mallList">
					<c:forEach var="item" items="${mallToyVos}">
						<li>
							<div class="originBox">
								<div class="photo">
									<c:url value='/toy/user/mallDetail' var='detail_url'>
									<c:param name='mt_no' value='${item.mt_no}' />
									</c:url>
									<a href="${detail_url}">
										<img src="<c:url value='/toyUploadImg/${item.mt_photo}' />"
												alt="${item.mt_photo}">
									</a>
								</div>
								<div class="info">
									<p>${item.mt_name}</p>
									<p class="price" data-price="${item.mt_price}">${mt_price}원</p>
								</div>
							</div>	
						</li>
					</c:forEach>
				</ul>						
			</div>	
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />

</body>
</html>