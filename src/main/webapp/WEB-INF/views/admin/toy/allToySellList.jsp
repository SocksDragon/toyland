<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table>
	<thead>
		<tr>
			<th>장난감명</th>
			<th>제작사</th>
			<th>장난감타입</th>
			<th>상품가격</th>
			<th>남은수량</th>
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
				<td>${item.mt_price}원</td>				
				<td>${item.mt_quantity}</td>
			</tr>
		</c:forEach>
		
	</tbody>
</table>