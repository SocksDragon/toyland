<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/listup_admins.css' />" rel="stylesheet" type="text/css">
</head>
<body>

	<jsp:include page="../../include/header.jsp" />
	<jsp:include page="../include/nav.jsp" />
	<section>
		<div id="section_wrap">
			<div class="word">
				<h3>유저 리스트</h3>
			</div>
			<div class="admin_list">
				<table>
					<thead>
						<tr>
							<th>NO</th>
							<th>계정</th>
							<th>이름</th>
							<th>성별</th>
							<th>메일</th>
							<th>연락처</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="item" items="${adminMemberVos}">
							<tr>
								<td>${item.u_m_no}</td>
								<td>${item.u_m_id}</td>
								<td>${item.u_m_name}</td>
								<td>${item.u_m_gender}</td>
								<td>${item.u_m_mail}</td>
								<td>${item.u_m_phone}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</section>
	<jsp:include page="../../include/footer.jsp" />
</body>
</html>