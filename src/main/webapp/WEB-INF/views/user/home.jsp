<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="<c:url value='/resources/css/common/common.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/user/home.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/resources/css/admin/notice.css' />" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

</head>
<body>

	<jsp:include page="../include/header.jsp" />
	<jsp:include page="./include/nav.jsp" />

	<section>
		<div id="banner_wrap">
			<div class="banners">
    			<i class="fas fa-chevron-left" onclick="navigate(-1)"></i>
				<a href="<c:url value='/toy/user/mallToyType?mt_type=영유아' />"><img src="<c:url value='/resources/img/user/로봇 장난감.jpg' />" class="active" onclick="changeImage(0)"></a>
				<a href="<c:url value='/toy/user/mallToyType?mt_type=인형' />"><img src="<c:url value='/resources/img/user/인형.jpg' />" onclick="changeImage(1)"></a>
   				<a href="<c:url value='/toy/user/mallToyType?mt_type=캐릭터' />"><img src="<c:url value='/resources/img/user/캐릭터 장난감.jpg' />" onclick="changeImage(2)"></a>
   				<a href="<c:url value='/toy/user/mallToyType?mt_type=자동차' />"><img src="<c:url value='/resources/img/user/자동차 장난감.jpg' />" onclick="changeImage(3)"></a>
   				<a href="<c:url value='/toy/user/mallToyType?mt_type=블록' />"><img src="<c:url value='/resources/img/user/블록장난감.jpg' />" onclick="changeImage(4)"></a>
			    <i class="fas fa-chevron-right" onclick="navigate(1)"></i>
			</div>
		</div>
		<!--배터 다음이미지 변경  -->
		<script>
	    var images = [
	        "<c:url value='/resources/img/user/로봇 장난감.jpg' />",
	        "<c:url value='/resources/img/user/인형.jpg' />",
	        "<c:url value='/resources/img/user/캐릭터 장난감.jpg' />",
	        "<c:url value='/resources/img/user/자동차 장난감.jpg' />",
	        "<c:url value='/resources/img/user/블록장난감.jpg' />"
	    ];
	
	    var currentIndex = 0;
	
	    function changeImage(index) {
	        currentIndex = index;
	        updateImages();
	    }
	
	    function navigate(direction) {
	        currentIndex += direction;
	        if (currentIndex < 0) {
	            currentIndex = images.length - 1;
	        } else if (currentIndex >= images.length) {
	            currentIndex = 0;
	        }
	        updateImages();
	    }
	
	    function updateImages() {
	        var bannerImages = document.querySelectorAll('.banners img');
	
	        for (var i = 0; i < bannerImages.length; i++) {
	            if (i === currentIndex) {
	                bannerImages[i].classList.add('active');
	            } else {
	                bannerImages[i].classList.remove('active');
	            }
	        }
	    }
		</script>
		<div id="main_wrap">
			<h2>
				<span>판매리스트</span>
				<a href="<c:url value='/toy/user/mallToySearchAll' />" class="btn_allView">전체보기</a>
			</h2>
			
			<div class="mallToyList">
		
			</div>
			
			<h2>
				<span>공지사항</span>
				<a href="<c:url value='/toy/user/toyNotice' />" class="btn_allView">전체보기</a>
			</h2>
			<div class="notice_list">
		
			</div>
		</div>

	</section>
	
	<jsp:include page="../include/footer.jsp" />
	<script>
    $.noConflict();
    var jQ = jQuery;
		jQ.ajax({
			type :"GET",
			contentType : "application/json; charset=UTF-8",
			url : "${pageContext.request.contextPath}/toy/user/mallToyAll",
			success : function(rdata){
				console.log(rdata)
				jQ(".mallToyList").html(rdata)
			},
			error : function(error){
				console.log(error)
			}
		})
	</script>
	<!-- 임시제거
 	<script>
		jQ.ajax({
			type :"GET",
			contentType : "application/json; charset=UTF-8",
			url : "${pageContext.request.contextPath}/toy/user/rentalToyAll",
			success : function(rdata){
				console.log(rdata)
				jQ(".rentalToyList").html(rdata)
			},
			error : function(error){
				console.log(error)
			}
		})
	</script> -->
	 <script>
	    jQ.ajax({
	        url : "${pageContext.request.contextPath}/toy/user/allToyNotice",
	        type : "GET",
	        success:function(rdata){
	        	console.log(rdata)
	        	jQ('.notice_list').html(rdata);
	        },
	        error:function(error){
	        	alert(error)
	        }
		})
	</script>
	
</body>
</html>