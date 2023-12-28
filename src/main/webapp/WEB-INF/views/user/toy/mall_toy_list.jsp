<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link href="<c:url value='/resources/css/user/toy_mall.css' />"
	rel="stylesheet" type="text/css">

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


<script>
    $(document).ready(function() {
        // Show bottom 15 list items
        var listItems = $('.mallList li');
        var totalItems = listItems.length;
        
        if (totalItems > 15) {
            listItems.slice(0, totalItems - 15).hide();
        }
    });
</script>
