<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.photoList { 
	display:grid; 
	grid-template-columns: 1fr 1fr 1fr;
}

.photoList > li { 
	border:1px solid #000; 
	margin:20px; 
    display:grid; 
    position:relative; 
 }
 
 .photoList > li > div.originBox {
	display:grid; 
	align-content:space-between;
 }
 
 .photoList > li > div.hoverBox {
	position:absolute; top:0; left:0; right:0; bottom:0;
	background:red; 
	display:none; 
	justify-content:center;
    align-items:center;
 }   
 
 .photoList > li:hover > div.hoverBox { 
 	display:flex 
 	}
 
 .photoList > li > div.hoverBox a { 
 	margin:0 20px; }

 #modalOuter { 
 	position:fixed; top:0; left:0; bottom:0; right:0; 
	background:rgba(0, 0, 0, 0.8); 
	z-index:9999; 
	display:none; 
 }

#modalInner { 
	width:400px; height:400px;
	position:absolute; left:50%; top:50%;
	transform: translate(-50%, -50%);
	background: #00afa0; 
	text-align: center;
	padding: 20px; 
}

#modalInner .close { 
	text-align: right; 
}

#modalInner .close i { 
	font-size: 50px; 
	color: #fff; 
	cursor: pointer;
}

#modalInner .infoText { 
	font-size:18px; 
	margin-top:20px; 
}

#modalInner .infoText p {
 	color:#fff; 
 	margin:3px 0px;  
}

#modalInner .cartIcon { 
	font-size:80px; 
	margin:5px 0;  
}

#modalInner .cartIcon i { 
	color:#fff;
}

#modalInner .moveBtn { 
display:flex; 
justify-content:center; 
}

#modalInner .moveBtn a { 
	width:100px; height:100px; 
 	border-radius:50%; 
 	border:1px solid #fff; 
	display:flex;  justify-content:center;
	align-items:center; 
	margin:0 10px; 
	color:#fff; 
}

#modalInner .moveBtn a:hover {
	background:#0d786d; 
	border:1px solid #0d786d; 
}
  
</style>

<ul class="photoList">
	<c:forEach var="item" items="${reviewListAll}">
		<li>
		   <div class="originBox">
				<p>
				   <c:choose>
				       <c:when test="${item.pr_photo0 != null }">
				         <img src="<c:url value='/libraryUploadImg/${item.pr_photo0}' />">
				       </c:when>
				       <c:when test="${item.pr_photo0 == null }">
				         <img src="<c:url value='/resources/img/user/small_banner1.png' />">
				       </c:when>
				   </c:choose>
				</p>
				<div>
					<p>${item.pr_name}</p>
					<p>${item.pr_author}</p>
					<p>${item.pr_publisher}</p>
				</div>
			</div>
			<div class="hoverBox">
			     <a href="#">상세페이지</a>
				 <a href="${item.pr_no}">장바구니</a>
			</div>
		</li>
	</c:forEach>
</ul>

<div id="modalOuter">
	<div id="modalInner">
	    <div class="close">
	    	<i class="fa-solid fa-xmark"></i>
	    </div>
	    <div class="infoText">
	    	<p>해당 상품을 장바구니에 담았습니다.</p>
	    	<p>장바구니로 이동하시겠습니까?</p>
	    </div>
	    <div class="cartIcon">
			<i class="fa-solid fa-cart-shopping"></i>
		</div>
		<div class="moveBtn">
		     <a href="#">장바구니<br>이동</a>
		     <a href="javascript:;">쇼핑<br>계속</a>
		</div>
	</div>
</div>


<script>
	jQ(".hoverBox a:nth-child(2)").on('click', function(){
		jQ("#modalOuter").fadeIn(300);
		return false
	})
	
	jQ("#modalOuter").on("click", ".close i, .moveBtn a:nth-child(2)", function(){
		jQ("#modalOuter").fadeOut(300);
	})
	
</script>