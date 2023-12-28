<%@page import="com.rental.toy.admin.member.AdminMemberVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/modify_account_form.css' />" rel="stylesheet" type="text/css">
<script >
	function modifyAccountForm() {
		let form = document.modify_account_form;
		if (form.a_m_pw.value == '') {
			alert('비밀번호를 입력하세요.');
			form.a_m_pw.focus();
		}  else if (form.a_m_pw_again.value == '') {
			alert('다시 비밀번호를 입력하세요.');
			form.a_m_pw.focus();
		} else if (form.a_m_pw.value != form.a_m_pw_again.value) {
			alert('비밀번호를 다시확인해주세요.');
			form.a_m_pw.focus();
		} else if (form.a_m_name.value == '') {
			alert('성명을 입력하세요.');
			form.a_m_name.focus();
			
		} else if (form.a_m_gender.value == '') {
			alert('성별을 선택하세요.');
			form.a_m_gender.focus();
			
		} else if (form.a_m_mail.value == '') {
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
<script>
     function Back() {
         window.history.back();
     }
</script>
</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		<div id="section_wrap">
			<div class="word">
				<h3>정 보 수 정</h3>
			</div>
			<%
			AdminMemberVo loginedAdminMemberVo = (AdminMemberVo) session.getAttribute("loginedAdminMemberVo");
			%>
			<div class="modify_account_form">
				<form action="<c:url value='/admin/member/modifyAccountConfirm' />" name="modify_account_form" method="post">
					<input type="hidden" 	name="a_m_no"		value="${loginedAdminMemberVo.getA_m_no()}">
					<input type="text"		name="a_m_id" 		value="${loginedAdminMemberVo.getA_m_id()}" readonly disabled> <br>
					<input type="password"	name="a_m_pw" 		placeholder="비밀번호" > <br>
					<input type="password"  name="a_m_pw_again" placeholder="비밀번호 확인"> <br>
					<input type="text"		name="a_m_name" 	placeholder="관리자성명"> <br>
					<select name="a_m_gender">
						<option value="">성별</option>
						<option value="M" <% if (loginedAdminMemberVo.getA_m_gender().equals("M")) {%> selected <%}%>>남성</option>
						<option value="W" <% if (loginedAdminMemberVo.getA_m_gender().equals("W")) {%> selected <%}%>>여성</option>
					</select> <br>
					<input type="email"		name="a_m_mail"		placeholder="이메일" ><br>
					<input type="text"		name="a_m_phone"	placeholder="연락처"> <br>
					<input type="button"	value="정보수정"	onclick="modifyAccountForm()"> 
					<input type="button"	value="취소" 		onclick="Back()"> 
				</form>
			</div>
		</div>
	</section>

	<jsp:include page="../../include/footer.jsp" />
	
</body>
</html>