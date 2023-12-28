<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/user/order_confirm.css' />" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="../../common/commonjq.jsp" />
	<jsp:include page="../../include/header.jsp" />
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		<div id="section_wrap">
			<div class="word">
				<h3>전체 주문 리스트</h3>
				
			</div>
			<div class="purchase_list">
				<table>
					<thead>
					<tr>
						<th>주문번호</th>
						<th>유저번호</th>
						<th>주문금액</th>
						<th>입금자명</th>
						<th>입금일자</th>
						<th>연락처</th>
						<th>주문상태</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="item" items="${orderVos}">
					<fmt:formatNumber value="${item.total_price}" type="number" var="total_price" />	
						<tr>
							<td>
								<c:url value='/toy/admin/orderDetail' var='detail_url'>
									<c:param name='order_no' value='${item.order_no}'/>
								</c:url>
								<a href="${detail_url}">${item.order_no}</a>
							</td>
							<td>${item.u_m_no}</td>
							<td class="right" data-price="${item.total_price}">${total_price}원</td>
							<td>${item.u_m_name}</td>
							<td class="right">${item.ord_bank}</td>
							<td class="right">${item.u_m_phone}</td>
							<td>
							<c:choose>
                              <c:when test="${item.order_status eq '입금대기'}">
                                   <c:url value="/toy/admin/setAdminApproval" var="approval_url">
                                      <c:param name="order_no" value="${item.order_no}" />
                                   </c:url>
                                   <a href="${approval_url}">입금대기</a>
                              </c:when>
                              <c:when test="${item.order_status eq '입금완료'}">입금완료</c:when>
                           	</c:choose>
                           	</td>
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