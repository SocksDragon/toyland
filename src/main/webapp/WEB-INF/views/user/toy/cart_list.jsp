<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
  
</style>


<c:choose>
<c:when test="${cartToyVos.size() != 0}">
	<table class="cartInfo">
	<colgroup>
       <col>
       <col>
       <col>
       <col>
       <col>
       <col>
       <col>
    </colgroup>
    <thead>
        <tr>
        	<th><input class="allCheck" type="checkbox"></th>
            <th>이미지</th>
            <th>상품명</th>
            <th>판매가</th>
            <th>수량</th>
            <th>합계</th>
            <th>삭제</th>
        </tr>
    </thead>
    <tbody>
    
	  <c:forEach  var="item" items="${cartToyVos}">
	  <fmt:formatNumber value="${item.mt_price}" type="number" var="mt_price"/>
	  <fmt:formatNumber value="${item.mt_price * item.cart_qty}" type="number" var="mt_amount"/>	
	     <tr data-bmno="${item.mt_no}">
	     	<td><input type="checkbox" checked></td>
            <td><img src="<c:url value='/toyUploadImg/${item.mt_photo}' />" alt="${item.mt_photo}"></td>
            
			<td>${item.mt_name}</td>
            <td class="price" data-price="${item.mt_price}">${mt_price}원</td>
            <td>
            	<button type="button" class="qty__minus">-</button>
            	<input style="width:50px" type="text" value="${item.cart_qty}">
            	<button type="button" class="qty__plus">+</button>
            </td>
            <td class="sub_total" data-sub-total="${item.mt_price * item.cart_qty}">${mt_amount}원</td>
            <td><button type="button" class="remove">삭제</button></td>
	     </tr>
	  </c:forEach>
	</tbody>
    <tfoot>
		<tr>
			<td colspan="7">
				<span class="total"></span>원
				+
				<span class="dfee"></span>
				=
				<span class="all_total"></span>원
			</td>
		</tr>
	</tfoot>
</table>
</c:when>
<c:otherwise>
  <h2 class="list_empty">장바구니가 비어있습니다.</h2>
</c:otherwise>
</c:choose>

<script>
	total()
	function total(){
		let total = 0;
		jQ(".price").each(function(){
			total += parseInt(jQ(this).attr("data-price")) * parseInt(jQ(this).next().find("input").val())
		})
		jQ('tfoot').find('.total').text(total.toLocaleString())
		jQ('tfoot').find('.dfee').text("5,000원")
		let amount = total+5000
		jQ('tfoot').find('.all_total').text(amount.toLocaleString())
	}

	jQ(".qty__plus").on("click", function(){
		let mt_no = jQ(this).closest("tr").attr("data-bmno")
		let cart_qty = jQ(this).prev().val()
		let price = parseInt(jQ(this).parent().prev().attr("data-price"))
		cart_qty++;
		if (cart_qty>20) cart_qty=20;
		jQ(this).prev().val(cart_qty);
		let toamount = cart_qty*price
		jQ(this).parent().next().text(toamount.toLocaleString()+"원")
		total()
		sqty(user_no, mt_no, cart_qty)
	})
	
	jQ(".qty__minus").on("click", function(){
		let mt_no = jQ(this).closest("tr").attr("data-bmno")
		let cart_qty = jQ(this).next().val()
		let price = parseInt(jQ(this).parent().prev().attr("data-price"))
		cart_qty--;
		if (cart_qty==0) cart_qty=1;
		jQ(this).next().val(cart_qty);
		let toamount = cart_qty*price
		jQ(this).parent().next().text(toamount.toLocaleString()+"원")
		total()
		sqty(user_no, mt_no, cart_qty)
	})
	
	function sqty(user_no, mt_no, cart_qty){
		jQ.ajax({
			type :"POST",
			contentType : "application/json; charset=UTF-8",
			url : "${pageContext.request.contextPath}/toy/user/cartQty/"+user_no,
			data : JSON.stringify({mt_no, cart_qty}),
			success : function(){
			},
			error : function(error){
				console.log(error)
			}
		})
	}
	
	jQ(".remove").on("click", function(){
		let answer = confirm("정말로 삭제하시겠습니까?")
		if (!answer) {
			return false;
		}
		let mt_no = jQ(this).closest("tr").attr("data-bmno")
		jQ.ajax({
			type :"POST",
			contentType : "application/json; charset=UTF-8",
			url : "${pageContext.request.contextPath}/toy/user/cartDelete/"+user_no,
			data : JSON.stringify({mt_no}),
			success : function(rdata){
				jQ(".cartBox").html(rdata)
			},
			error : function(error){
				console.log(error)
			}
		})
	})
	
	
	
	jQ(".allCheck").on("click", function(){
		if (jQ(this).prop("checked")){
			jQ("tbody input[type=checkbox]").prop("checked", true)
		} else {
			jQ("tbody input[type=checkbox]").prop("checked", false)
		}
	})
	
</script>
