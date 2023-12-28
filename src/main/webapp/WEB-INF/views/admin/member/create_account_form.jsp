<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/create_account_form.css' />" rel="stylesheet" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script>
	function createAccountForm(){
		let form = document.create_account_form;
		if (form.a_m_id.value == '') {
			alert('아이디를 입력하세요.');
			form.a_m_id.focus();
		} else if (form.a_m_pw.value == '') {
			alert('비밀번호를 입력하세요.');
			form.a_m_pw.focus();
		} else if (form.a_m_pw_again.value == '') {
			alert('다시 비밀번호를 입력하세요.');
			form.a_m_pw_again.focus();
		} else if (form.a_m_pw.value != form.a_m_pw_again.value) {
			alert('비밀번호를 다시확인해주세요.');
			form.a_m_pw.focus();
		} else if (form.a_m_name.value == '') {
			alert('성명을 입력하세요.');
			form.a_m_name.focus();
		} else if (form.a_m_gender.value == '') {
			alert('성별을 선택하세요.');
			form.a_m_gender.focus();
		}  else if (form.a_m_mail.value == '') {
			alert('이메일주소를 입력하세요.');
			form.a_m_mail.focus();
		} else if (form.a_m_phone.value == '') {
			alert('연락처를 입력하세요.');
			form.a_m_phone.focus();
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
				<h3>회 원 가 입</h3>
			</div>
			<div class="create_account_form">
				<form action="<c:url value='/admin/member/createAccountConfirm' />" name="create_account_form" method="post">
					<input type="text" name="a_m_id" placeholder="아이디"> <br>
					<p id="idable"></p>
					<input type="password" name="a_m_pw" placeholder="비밀번호"> <br>
					<input type="password" name="a_m_pw_again" placeholder="비밀번호 확인"> <br>
					<input type="text" name="a_m_name" placeholder="관리자성명"> <br>
					<select name="a_m_gender">
						<option value="">성별</option>
						<option value="M">남성</option>
						<option value="W">여성</option>
					</select> <br>
					<input type="email" name="a_m_mail" placeholder="이메일" ><br>
					<input type="text" name="a_m_phone" placeholder="연락처"> <br>
					<input type="button" value="가입하기" onclick="createAccountForm();"> 
					<input type="reset" value="취소" onclick="Back()"> 
				</form>
			</div>
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
	
  	<script>
	    $.noConflict();
	    var jQ = jQuery;
    	jQ("input[name=a_m_id]").on("blur", function(){
			let amid = jQ(this).val();
			if (!amid) return;
			//let form = { amid : amid  }
			jQ.ajax({
				url:"${pageContext.request.contextPath}/admin/member/idCheck/"+amid,
				type : "GET",
				dataType : "json",
				contentType : 'application/json; charset=utf-8',
				success : function(rdata){	   // { result : isMember }
					console.log(rdata.result)
					let result = rdata.result;
					if (result) {
						jQ("#idable").text("중복된 아이디입니다.").css("color", "blue");
					} else {
						jQ("#idable").text("가능한 아이디입니다.").css("color", "red");
					}
				},
				error : function(error){
					alert(error)
				}
			})
		})	
	</script>
	<script>
     function Back() {
         window.history.back();
     }
</script>
</body>
</html>