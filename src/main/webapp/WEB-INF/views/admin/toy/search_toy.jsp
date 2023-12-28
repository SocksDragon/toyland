<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.rental.toy.mall.MallToyVo"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/search_toy.css' />" rel="stylesheet" type="text/css">

</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
			<div class="word">
				<h3>전체 판매 리스트 목록</h3>
			</div>
			
			<div class="toy_list">
				<table>
					<thead>
						<tr>
							<th>장난감명</th>
							<th>제작사</th>
							<th>장난감타입</th>
							<th>상품가격</th>
							<th>리스트작성일시</th>
						</tr>
					</thead>
					
					<tbody>
					
						<c:forEach var="item" items="${mallToyVos}">
						<tr>
							<td>
							<c:url value='/toy/admin/toyDetail' var='detail_url'>
							<c:param name='mt_no' value='${item.mt_no}'/>
							</c:url>
							<a href="${detail_url}">${item.mt_name}</a>
							</td>
							<td>${item.mt_publisher}</td>
							<td>${item.mt_type}</td>
							<td>${item.mt_price}</td>
							<td>${item.mt_reg_date}</td>

						</tr>
						</c:forEach>
						
					</tbody>
					
				</table>
				
			</div>	
		
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />

</body>
</html>