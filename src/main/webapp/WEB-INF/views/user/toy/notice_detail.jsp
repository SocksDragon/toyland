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

</script>
</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	
	<jsp:include page="../include/nav.jsp" />
	
	<section>
		
		<div id="section_wrap">
			<div class="word">
				<h3>공 지 사 항</h3>
			</div>
			
			<div class="notice_detail">
				<table>
					<colgroup>
						<col style="width:100px">
						<col style="auto">
						<col style="width:100px">
						<col style="width:200px">
						<col style="width:100px">
						<col style="width:200px">
					</colgroup>
					<tr>
						<td>제목</td>
				        <td colspan="5">${noticeVo.n_name}</td>

					</tr>
					<tr>
						<td>작성일</td>
						<td>${noticeVo.n_mod_date}</td>
						<td>글쓴이</td>
						<td>${noticeVo.a_m_name}</td>
						<td>조회수</td>
						<td>${noticeVo.n_hit}</td>
					</tr>
					<tr>
						<td>내용</td>
        				<td colspan="5">${noticeVo.n_content}</td>
					</tr>
					
				
				</table>
				
			</div>

		</div>
		
	</section>
	
	<jsp:include page="../../include/footer.jsp" />

</body>
</html>