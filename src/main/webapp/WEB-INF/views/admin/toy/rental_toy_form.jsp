<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>토이랜드::장난감 판매 & 대여 서비스</title>

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/rental_toy_form.css' />" rel="stylesheet" type="text/css">

<script type="text/javascript">

	function rentalToyForm() {
		let form = document.rental_toy_form;
		let rt_name = form.rt_name.value;
		let rt_publisher = form.rt_publisher.value;
		
		if (rt_name == '') {
			alert('장난감 명을 입력하세요.');
			rt_name.focus();
		} else if (rt_publisher == '') {
			alert('제조사를 입력하세요');
			rt_publisher.focus();
		} else if (form.file.value == '') {
			alert('사진을 추가하세요.');
			form.rt_thumbnail.focus();
		} else {
			form.submit();
		}
		
	}

</script>

</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
			<div class="word">
				<h3>장난감 대여등록</h3>
			</div>

	
			<div class="rental_toy_form">
				<form action="<c:url value='/toy/admin/rentalToyConfirm' />" name="rental_toy_form" method="post" enctype="multipart/form-data">
					<input type="text" name="rt_name" placeholder="장난감명"> <br>
					<input type="text" name="rt_publisher" placeholder="제조사명"> <br>
					<select name="rt_type">
						<option value="">분류</option>
						<option value="인형">인형</option>
						<option value="캐릭터">캐릭터</option>
						<option value="자동차">자동차</option>
						<option value="영유아">영유아</option>
						<option value="블록">블록</option>
					</select><br>
					<input type="text" name="rt_return_day" placeholder="반납일"> <br>
					<input type="file" name="file"><br>
					<textarea name="rt_detail" 	placeholder="제품상세내용"></textarea> <br>
					<input type="button" value="등록" onclick="rentalToyForm();"> 
					<input type="reset"	value="취소">
					
				</form>
				
			</div>
		
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
</body>
</html>