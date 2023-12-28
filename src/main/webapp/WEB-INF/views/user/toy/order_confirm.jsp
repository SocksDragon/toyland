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
				<h3>전체목록 리스트</h3>
				
			</div>
			<div class="purchase_list">
				<table>
					<thead>
					<tr>
						<th>주문번호</th>
						<th>주문일자</th>
						<th>상품명</th>
						<th>주문금액</th>
						<th>입금은행정보</th>
						<th>주문상태</th>
						<th>삭제</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="item" items="${orderVos}">
					<fmt:formatNumber value="${item.total_price}" type="number" var="total_price" />	
						<tr data-bmno="${item.order_no}">
						
							<td>${item.order_no}</td>
							<td>${item.order_date }</td>
							<td class="left">${item.mt_name } 
								<c:if test="${item.cnt > 1 }">
									<span>외 ${item.cnt-1}개</span>
								</c:if>
							</td>
							<td class="right" data-price="${item.total_price}">${total_price}원</td>
							<td class="right">${item.ord_bank }</td>
							<td>
							<c:choose>
                              <c:when test="${item.order_status eq '입금대기' }">입금대기</c:when>
                              <c:when test="${item.order_status eq '입금완료' }">입금완료</c:when>
                           	</c:choose>
                           	</td>
                           	<td>
                           	<c:if test="${item.order_status eq '입금대기' }">
                           		<button type="button" class="remove">삭제</button>
                           	</c:if>
                           	</td>
							
						</tr>
						</c:forEach>	
		       		</tbody>
				</table>
			</div>
		</div>
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	<script>
	let user_no = "${loginedUserMemberVo.u_m_no}";
	if (!user_no){
		user_no = 0;
	}

	jQ(".remove").on("click", function(){
		let answer = confirm("정말로 삭제하시겠습니까?")
		if (!answer) {
			return false;
		}
		let order_no = jQ(this).closest("tr").attr("data-bmno")
		jQ.ajax({
			type :"POST",
			contentType : "application/json; charset=UTF-8",
			url : "${pageContext.request.contextPath}/toy/user/purchaseDelete/"+user_no,
			data : JSON.stringify({order_no}),
			success : function(rdata){
				jQ(".orderFormBox").html(rdata)
				location.href = "/toy/toy/user/orderConfirm"
			},
			error : function(error){
				console.log(error)
			}
		})
	})
	</script>

</body>
</html>