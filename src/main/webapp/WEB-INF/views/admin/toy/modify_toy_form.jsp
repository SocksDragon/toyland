<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/modify_toy_form.css' />" rel="stylesheet" type="text/css">

<script type="text/javascript">

	function modifyToyForm() {
		
		let form = document.modify_toy_form;
		let mt_name = form.mt_name.value;
		let mt_publisher = form.mt_publisher.value;
		let mt_price = form.mt_price.value;
		let mt_quantity = form.mt_quantity.value;
		if (mt_name == '') {
			alert('장난감 명을 입력하세요.');
			mt_name.focus();
		} else if (mt_publisher == '') {
			alert('제조사를 입력하세요.');
			mt_publisher.focus();
		} else if (mt_price == '') {
			alert('가격을 입력하세요.');
			mt_price.focus();
		} else if (mt_quantity == '') {
			alert('수량을 입력하세요.');
			mt_quantity.focus();
		} else if (form.file.value == '') {
			alert('사진을 추가하세요.');
			form.mt_photo.focus();
		} else {
			form.submit();

		}
	
		
	}

</script>

</head>
<body>
<jsp:include page="../../common/commonjq.jsp" />
	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
		
			<div class="word">
			
				<h3>장난감 판매 등록 수정</h3>

				
			</div>
		
			<div class="modify_toy_form">
			
				<form action="<c:url value='/toy/admin/modifyToyConfirm' />" name="modify_toy_form" method="post" enctype="multipart/form-data">
				
					<input type="hidden" name="mt_no" value="${mallToyVo.mt_no}">
					
					<input type="text" 		name="mt_name" 		value="${mallToyVo.mt_name}" readonly disabled> <br>
					<input type="text" 		name="mt_publisher" value="${mallToyVo.mt_publisher}" placeholder="제조사명"> <br>
					<input type="text"		name="mt_price"		placeholder="가격"> <br>
					<input type="text"		name="mt_quantity"	placeholder="수량"> <br>
					<select name="mt_type">
						<option value="">분류</option>
						<option value="인형">인형</option>
						<option value="캐릭터">캐릭터</option>
						<option value="자동차">자동차</option>
						<option value="영유아">영유아</option>
						<option value="블록">블록</option>
					</select><br>
					<input type="file" 		name="file" 	class="files"> <br>
					<textarea name="mt_detail" 	placeholder="제품상세내용"></textarea> <br>
					<input type="button"	value="수정"     onclick="modifyToyForm()"> 
					<input type="reset"		value="취소">
					
				</form>
				
			</div>
		
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
</body>
</html>