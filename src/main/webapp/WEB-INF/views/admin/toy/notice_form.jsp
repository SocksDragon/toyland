<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>토이랜드::장난감 판매 & 대여 서비스</title>
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/notice.css' />" rel="stylesheet" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">

	function noticeConfirms() {
		let form = document.notice_form;
		let n_name = form.n_name.value;
		let n_content = form.n_content.value;

		if (n_name == '') {
			alert('제목을 입력하세요.');
			n_name.focus();
		} else if (n_content == '') {
			alert('내용을 입력하세요.');
			n_content.focus();
		}  else {
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
				<h3>공지사항 등록</h3>
			</div>
			
			<div class="notice_form">
				<form action="<c:url value='/toy/admin/noticeConfirm' />" name="notice_form" method="post" enctype="multipart/form-data">
					<input type="text" 		name="n_name" 		placeholder="제목"> <br>
					<input type="hidden" 	name="a_m_name" 	value="${loginedAdminMemberVo.a_m_name}"> <br>
					
					<textarea name="n_content" 	placeholder="상세내용"></textarea> <br>
					<input type="button"	value="등록"     onclick="noticeConfirms()"> 
					<input type="reset"		value="취소">
				</form>
			</div>
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />

</body>
</html>