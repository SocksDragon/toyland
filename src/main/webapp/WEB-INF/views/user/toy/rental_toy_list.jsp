<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link href="<c:url value='/resources/css/user/toy_rental.css' />"
	rel="stylesheet" type="text/css">

<ul class="rentalList">
   <c:forEach var="item" items="${rentalToyListAll}">
		<li>
			<div class="originBox">
				<div class="photo">
					<c:url value='/toy/user/rentalDetail' var='detail_url'>
					<c:param name='rt_no' value='${item.rt_no}'/>
					</c:url>
					<a href="${detail_url}"><img src="<c:url value='/toyUploadImg/${item.rt_photo}' />" alt="${item.rt_photo}"></a>
				</div>	
				<div class="info">
				    <p>${item.rt_name}</p>
				</div>
			</div>
		</li>
	</c:forEach>
</ul>


<script>
    $(document).ready(function() {
        // Show bottom 15 list items
        var listItems = $('.rentalList li');
        var totalItems = listItems.length;
        
        if (totalItems > 10) {
            listItems.slice(0, totalItems - 10).hide();
        }
    });
</script>
