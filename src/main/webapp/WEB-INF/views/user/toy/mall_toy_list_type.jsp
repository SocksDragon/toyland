<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="<c:url value='/resources/css/common/common.css' />"
	rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/user/toy_mall.css' />"
	rel="stylesheet" type="text/css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"
	integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</head>
<body>

	<jsp:include page="../../include/header.jsp" />

	<jsp:include page="../include/nav.jsp" />

	<section>
		<div id="section_wrap">
			<div class="word">
				<h3>${mt_type}</h3>
			</div>
			<div class="mallToyList">
				<ul class="mallList">
					<c:forEach var="item" items="${mallToyListAll}">
					<fmt:formatNumber value="${item.mt_price}" type="number" var="mt_price" />
					<li>
						<div class="originBox">
							<div class="photo">
								<c:url value='/toy/user/mallDetail' var='detail_url'>
								<c:param name='mt_no' value='${item.mt_no}'/>
								</c:url>
								<a href="${detail_url}"><img src="<c:url value='/toyUploadImg/${item.mt_photo}' />" alt="${item.mt_photo}"></a>
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