<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>토이랜드::장난감 렌탈 서비스</title>

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/register_toy_form.css' />" rel="stylesheet" type="text/css">

<script type="text/javascript">

	function registerToyForm() {
		let form = document.register_toy_form;
		let t_name = form.t_name.value;
		let t_publisher = form.t_publisher.value;
		
		if (t_name == '') {
			alert('장난감 명을 입력하세요.');
			t_name.focus();
		} else if (t_publisher == '') {
			alert('제작사를 입력하세요');
			t_publisher.focus();
		} else if (form.file.value == '') {
			alert('사진을 추가하세요.');
			form.t_thumbnail.focus();
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
				<h3>장난감 등록</h3>
			</div>

	
			<div class="register_toy_form">
				<form action="<c:url value='/toy/admin/registerToyConfirm' />" name="register_toy_form" method="post" enctype="multipart/form-data">
					<input type="text" name="t_name" placeholder="장난감명"> <br>
					<input type="text" name="t_publisher" placeholder="제조사명"> <br>
					<select name="t_type">
						<option value="">분류</option>
						<option value="doll">인형</option>
						<option value="robot">로봇</option>
						<option value="character">캐릭터</option>
						<option value="car">자동차</option>
						<option value="baby">영유아</option>
						<option value="block">블록</option>
					</select><br>
					<input type="file" name="file"><br>
					<input type="button" value="등록" onclick="registerToyForm();"> 
					<input type="reset"	value="취소">
					
				</form>
				
			</div>
		
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
</body>
</html>