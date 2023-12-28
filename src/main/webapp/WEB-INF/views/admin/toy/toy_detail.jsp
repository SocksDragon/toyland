<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/toy_detail.css' />" rel="stylesheet" type="text/css">
<script type="text/javascript">

function deleteToy(mt_no, mt_name, mt_photo) {
	
	let result = confirm('장난감(' + mt_name + ')를(을) 정말 삭제 하시겠습니까?');
	
	if (result)
		location.href = "<c:url value='/toy/admin/deleteToyConfirm?no="+mt_no+"&photo="+mt_photo+"'/>";
	
}

</script>
</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
			<div class="word">
				<h3>장난감 상세정보</h3>
			</div>
			
			<div class="toy_detail">
				<ul>
					<li>
						<img src="<c:url value="/toyUploadImg/${mallToyVo.mt_photo}"/>">
					</li>
					<li>
						<table>
							<tr>
								<td>장난감명</td>
								<td>${mallToyVo.mt_name}</td>
							</tr>
							<tr>
								<td>제작사</td>
								<td>${mallToyVo.mt_publisher}</td>
							</tr>
							<tr>
								<td>가격</td>
								<td>${mallToyVo.mt_price}</td>
							</tr>
							<tr>
								<td>등록일</td>
								<td>${mallToyVo.mt_mod_date}</td>
							</tr>
							<tr>
								<td>제품상세정보</td>
								<td>${mallToyVo.mt_detail}</td>
							</tr>
						</table>
					</li>
				</ul>
				
			</div>
			<div class="buttons">
				
				<c:url value='/toy/admin/modifyToyForm' var='modify_url'>
					<c:param name='mt_no' value='${mallToyVo.mt_no}'/>
				</c:url>
				
				<c:if test="${loginedAdminMemberVo.a_m_id == 'seonghoseo'}">
				<a class="modify_button" href="${modify_url}"><i class="fa-solid fa-gear"></i></a>
				
				<a class="delete_button" href="javascript:;" onclick="deleteToy(${mallToyVo.mt_no}, '${mallToyVo.mt_name}', '${mallToyVo.mt_photo }')"><i class="fa-solid fa-trash"></i></a>
				</c:if>
				
			</div>
		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />

</body>
</html>