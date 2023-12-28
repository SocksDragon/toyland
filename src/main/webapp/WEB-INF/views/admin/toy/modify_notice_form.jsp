

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/notice.css' />" rel="stylesheet" type="text/css">

<script type="text/javascript">

	function modifyNoticeForm() {
		
		let form = document.modify_notice_form;
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
<jsp:include page="../../common/commonjq.jsp" />
	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
		
			<div class="word">
			
				<h3>공지 사항 수정</h3>

				
			</div>
		
			<div class="modify_notice_form">
			
				<form action="<c:url value='/toy/admin/modifyNoticeConfirm' />" name="modify_notice_form" method="post" enctype="multipart/form-data">
				
					<input type="hidden" name="n_no" value="${noticeVo.n_no}">
					
					<input type="text" 		name="n_name" 	placeholder="제목" value="${noticeVo.n_name}"> <br>
					<textarea name="n_content" 	placeholder="상세내용">${noticeVo.n_content}</textarea> <br>
					<input type="button"	value="수정"     onclick="modifyNoticeForm()"> 
					<input type="reset"		value="취소">
					
				</form>
				
			</div>
		
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
</body>
</html>