<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css">

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/user/orderForm.css' />" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

</head>
<body>

	<jsp:include page="../../common/commonjq.jsp" />

    <jsp:include page="../../include/header.jsp" />
	<jsp:include page="../include/nav.jsp" />
	<section>
		<div id="section_wrap">
			<div id="word">
				<h2>주문/결제</h2>
			</div>
			<div id="orderList">
				<h2>주문 상품 목록</h2>
				<div class="orderFormBox"></div>
			</div>
		</div>
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
	
	<script>
	    let mtNos = "${mtNos}";
		jQ.ajax({
			type :"POST",
			contentType : "application/json; charset=UTF-8",
			url : "${pageContext.request.contextPath}/toy/user/orderFormList/"+mtNos,
			success : function(rdata){
				jQ(".orderFormBox").html(rdata)
			},
			error : function(error){
				console.log(error)
			}
		})
	</script>
</body>
</html>