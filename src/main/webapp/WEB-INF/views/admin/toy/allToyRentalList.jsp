<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<table>
	<thead>
		<tr>
			<th>장난감명</th>
			<th>장난감이미지</th>
			<th>제작사</th>
			<th>장난감타입</th>
			<th>리스트작성일시</th>
			<th>삭제</th>
		</tr>
	</thead>
	
	<tbody>
		
		<c:forEach var="item" items="${rentalToyVos}">
			<tr>
				<td>${item.rt_name}</td>
				<td><img src="<c:url value="/toyUploadImg/${item.rt_photo}"/>"></td>
				<td>${item.rt_publisher}</td>
				<td>${item.rt_type}</td>
				<td>${item.rt_reg_date}</td>
				<td>
				<c:if test="${loginedAdminMemberVo.a_m_id == 'seonghoseo'}">
				<a class="delete_button" href="javascript:;" onclick="deleteToy(${item.rt_no}, '${item.rt_name}', '${item.rt_photo }')"><i class="fa-solid fa-minus"></i></a>
				</c:if>
				</td>
			</tr>
		</c:forEach>
		
	</tbody>
</table>