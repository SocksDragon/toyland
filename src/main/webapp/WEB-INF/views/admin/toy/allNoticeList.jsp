<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>글쓴이</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	</thead>
	
	<tbody>
		
		<c:forEach var="item" items="${noticeVos}">
			<tr>
				
				<td>${item.n_no}</td>
				<td>
					<c:url value='/toy/admin/noticeDetail' var='detail_url'>
						<c:param name='n_name' value='${item.n_name}'/>
					</c:url>
					<a href="${detail_url}">${item.n_name}</a>
				</td>
				<td>${item.a_m_name}</td>
				<td>${item.n_mod_date}</td>				
				<td>${item.n_hit}</td>
			</tr>
		</c:forEach>
		
	</tbody>
</table>