<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">

<link href="<c:url value='/resources/css/user/modify_account_form.css' />" rel="stylesheet" type="text/css">

<script type="text/javascript">

	function modifyAccountForm() {
		console.log('modifyAccountForm() CALLED!!');
		
		let form = document.modify_account_form;
		
		if (form.u_m_pw.value == '') {
			alert('비밀번호를 입력하세요.');
			form.u_m_pw.focus();
		}  else if (form.u_m_pw_again.value == '') {
			alert('다시 비밀번호를 입력하세요.');
			form.u_m_pw.focus();
		} else if (form.u_m_pw.value != form.u_m_pw_again.value) {
			alert('비밀번호를 다시확인해주세요.');
			form.u_m_pw.focus();
		} else if (form.u_m_name.value == '') {
			alert('성명을 입력하세요.');
			form.u_m_name.focus();
		} else if (form.u_m_gender.value == '') {
			alert('성별을 선택하세요.');
			form.u_m_gender.focus();
		} else if (form.u_m_mail.value == '') {
			alert('이메일주소를 입력하세요.');
			form.u_m_mail.focus();
		} else if (form.u_m_phone.value == '') {
			alert('연락처를 입력하세요.');
			form.u_m_phone.focus();
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
			<div class="modify_account_form">
				<form action="<c:url value='/user/member/modifyAccountConfirm' />" name="modify_account_form" method="post">
					<div class="form_wrap">
						<input type="hidden" name="u_m_no" value="${loginedUserMemberVo.u_m_no}">
						<div class="form_title">
							아이디
						</div>
						<div class="form_content">		
							<input type="text" name="u_m_id" value="${loginedUserMemberVo.u_m_id}" readonly disabled> <br>
						</div>
						<div class="form_title">
							비밀번호<span style="color:red">*</span>
						</div>
						<div class="form_content">	
							<input type="password" name="u_m_pw" value="" placeholder="비밀번호"> <br>
						</div>
						<div class="form_title">
							비밀번호 확인<span style="color:red">*</span>
						</div>
						<div class="form_content">	
							<input type="password"  name="u_m_pw_again" placeholder="비밀번호 확인"> <br>
						</div>
						<div class="form_title">
							성명<span style="color:red">*</span>
						</div>
						<div class="form_content">	
							<input type="text" name="u_m_name" placeholder="성명"> <br>
						</div>
						<div class="form_title">
							성별<span style="color:red">*</span>
						</div>
						<div class="form_content">
							<select name="u_m_gender">
								<option value="">성별</option>
								<option value="M" <c:if test="${loginedUserMemberVo.u_m_gender eq 'M'}"> selected </c:if>>남성</option>
								<option value="W" <c:if test="${loginedUserMemberVo.u_m_gender eq 'W'}"> selected </c:if>>여성</option>
							</select> <br>
						</div>
						<div class="form_title">
							이메일주소<span style="color:red">*</span>
						</div>
						<div class="form_content">	
							<input type="email"	name="u_m_mail" placeholder="이메일" ><br>
						</div>
						<div class="form_title">
							휴대폰번호<span style="color:red">*</span>
						</div>
						<div class="form_content">	
							<input type="text" name="u_m_phone"	placeholder="연락처"> <br>
						</div>
						<div class="form_title">
		      				우편번호    
		      			</div>
						<div class="form_content">	    
							<input type="text" name="u_m_zipcode" id="m_zipcode" placeholder="우편번호" onclick="openDaumPostcode();"><br>
		                </div>
		                <div class="form_title">
			                주소
		                </div>
						<div class="form_content"> 
		                	<input type="text" name="u_m_address" id="m_address" placeholder="주소"><br>
		                </div>
		                <div class="form_title">
							상세주소  
						</div>
						<div class="form_content">	  
		                	<input type="text" name="u_m_address_sub" id="m_address_sub" placeholder="상세주소"><br>
						</div>
					</div>
					<input type="button" value="정보수정" onclick="modifyAccountForm();"> 
					<input type="reset" value="취소" onclick="Back()">
					
				</form>
				
			</div>
		
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>  
	<script>
    function openDaumPostcode() {
      new daum.Postcode({
        oncomplete: function(data) {
          var fullAddr = ''; // 최종 주소 변수
          var extraAddr = ''; // 조합형 주소 변수
          if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
            fullAddr = data.roadAddress;
          } else { // 사용자가 지번 주소를 선택했을 경우(J)
            fullAddr = data.jibunAddress;
          }
          if(data.userSelectedType === 'R'){
            if(data.bname !== ''){
              extraAddr += data.bname;
            }
            if(data.buildingName !== ''){
              extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
          }
          document.querySelector("#m_zipcode").value = data.zonecode;
          document.querySelector("#m_address").value = fullAddr;
          document.querySelector("#m_address_sub").focus();
        }
      }).open();
    }
  </script>
</body>
</html>