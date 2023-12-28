<%@ page language="java" 
		 contentType="text/html; charset=UTF-8"
    	 pageEncoding="UTF-8" 
    	 import="com.rental.toy.user.member.UserMemberVo"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/user/photo_review.css' />" rel="stylesheet" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>


</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		<div id="section_wrap">
			<div class="word">
				<h3>도서 포토후기</h3>
			</div>
			<div class="photo_review_form">
				<form id="photoReview" name="photoReview">
					<input type="text"		name="pr_name" 			placeholder="도서명"> <br>
					<input type="text"		name="pr_author" 		placeholder="저자"> <br>
					<input type="text"		name="pr_publisher"		placeholder="출판사"> <br>
					<input type="file"		name="pr_photo0"			class="files"> <br>
					<input type="file"		name="pr_photo1"			class="files"> <br>
					<input type="file"		name="pr_photo2"			class="files"> <br>
					<input type="button"	value="전송" 			onclick="photoReviewForm();">
					<input type="reset"		value="취소">
				</form>
			</div>
			<div class="photoReviewList"> </div>
		</div>
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
	<script>
	$.noConflict();
	var jQ = jQuery;
	let form = document.photoReview;
	let user_no = "${loginedUserMemberVo.u_m_no}"
	const formData = new FormData();
	
	jQ.ajax({
		type:"GET",
		contentType:"application/json; charset=UTC-8",
		url:"${pageContext.request.contextPath}/book/user/photoReviewAll",
		success:function(rdata){
			jQ('.photoReviewList').html(rdata)
		},
		error:function(error){
			console.log(error)					
		}
	})
	
		function photoReviewForm() {
		
		if (!user_no){
			alert("로그인을 하세요.")
			return false
		} else if (form.pr_name.value=="") {
			alert("도서명을 입력하세요.")
			return false
		} 
		
		let data = {
			u_m_no : user_no,
			pr_name : form.pr_name.value,
			pr_author : form.pr_author.value,
			pr_publisher : form.pr_publisher.value
		}
		let fileInput = jQ(".files")
		for(let i=0; i<fileInput.length; i++){
			if(fileInput[i].files.length>0){
				for(let j=0; j<fileInput[i].files.length; j++){
					formData.append("file", jQ('.files')[i].files[j])
				}
			}
		}

		
		formData.append("key", new Blob([JSON.stringify(data)], {type:"application/json"}))		
		
		 form.pr_name.value="";
		form.pr_author.value="";
		form.pr_publisher.value="";
		form.pr_photo0.value="";
		form.pr_photo1.value="";
		form.pr_photo2.value="";

		jQ.ajax({
				type:"POST",
				enctype:"multipart/form-data",
				url:"${pageContext.request.contextPath}/book/user/photoReviewInsert",
				data: formData,
				contentType: false,
				processData: false,
				cache: false,
				success:function(rdata){
					jQ('.photoReviewList').html(rdata)
				},
				error:function(error){
					console.log(error)					
				}
			})
	}

	
	</script>
	

</body>
</html>