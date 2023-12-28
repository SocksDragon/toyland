<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<table id="orderTable" border="1">
    <colgroup>
    	<col />
    	<col />
    	<col />
    	<col />
    	<col />
    </colgroup>
	<thead>
		<tr>
			<th>구분</th>
			<th>상품명</th>
			<th>판매가</th>
			<th>수량</th>
			<th>합계</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach  var="item" items="${cartToyVos}">
			<fmt:formatNumber value="${item.mt_price}" type="number" var="mt_price"/>
			<fmt:formatNumber value="${item.mt_price * item.cart_qty}" type="number" var="mt_amount"/>
			
			<tr>
				<td>${item.mt_type}</td>
				<td>${item.mt_name}</td>
				<td>${mt_price}원</td>
				<td>${item.cart_qty}</td>
				<td>${mt_amount}원</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="5" style="padding:20px 0; border:none"> </td>
		</tr>
	</tbody>
	<c:set var="qty_total" value="0" />
	<c:set var="amount_total" value="0" />
	<c:forEach var="item" items="${cartToyVos}">
		<c:set var="qty_total" value="${qty_total + item.cart_qty}" />
		<c:set var="amount_total" value="${amount_total + (item.cart_qty * item.mt_price)}" />
	</c:forEach>
	<fmt:formatNumber value="${amount_total}" type="number" var="amountTotal" />
	<fmt:formatNumber value="${amount_total+5000}" type="number" var="allTotAmount"/>
		
	<tfoot>
		<tr>
			<td colspan="5" style="text-align:center; padding:20px 0; border:1px solid #000;">
				<span>주문상품 수량 : ${cartToyVos.size()}건 [${qty_total}]개</span>
				<span style="margin:0 30px">배송료 : 5,000원</span>
				<span>총 주문금액 : ${allTotAmount}원</span>
			</td>
		</tr>
	</tfoot>
</table>
<div class="order_info">
	<p class="tit">주문 고객 정보</p>
	<table>
	    <colgroup>
    	<col />
    	<col />
    	<col />
    	<col />
    	<col />
    	<col />
    	</colgroup>
    	<tbody>
			<tr>
							
				<th>이름</th>
				<th>${cartToyVos.get(0).getU_m_name()}</th>
				<th>이메일</th>
				<th class="email_area">${cartToyVos.get(0).getU_m_mail()}</th>
				<th>전화번호</th>
				<th>${cartToyVos.get(0).getU_m_phone()}</th>
			</tr>
		</tbody>
	</table>
</div>
<form method="post" name="LGD_PAYINFO" id="LGD_PAYINFO">
	<input type="hidden" value="${cartToyVos.get(0).getU_m_no()}" name="u_m_no" id="u_m_no">	
    <c:forEach var="item" items="${cartToyVos}">
    	<input type="hidden" name="order_nos" value="${item.getMt_no()}">
    	<input type="hidden" name="order_qtys" value="${item.getCart_qty()}">
    </c:forEach>
    <div class="addr_info_box">
      <p class="tit">배송지 정보</p>
      <div class="address_info" style="position:relative;">
        <fieldset>
        <legend>배송지 정보 입력</legend>
        <div class="register_addr">
          <div class="register_li">
            <div class="i_tit"><strong>배송지 선택<span> *</span></strong></div>
            <div class="i_con">                          
              <label class="ra_label">
                <input type="radio" name="delivery_addr" id="delivery_Orderaddr" value="Orderaddr" class="i_radio" checked onclick="javascript:set_deliveryAddr();">
                <span>주문자와 동일</span>
              </label>
              <label class="ra_label">
                <input type="radio" name="delivery_addr" id="delivery_Newaddr" value="Newaddr" class="i_radio" onclick="javascript:set_deliveryAddr();">
                <span>새로입력</span>
              </label>
            </div>
          </div>
          <div class="register_li">
            <div class="i_tit"><strong>이름<span> *</span></strong></div>
            <div class="i_con">
              <label>
                <input type="text" value="${cartToyVos.get(0).getU_m_name()}" name="delivery_name" id="m_name" class="i_text">  
              </label>
            </div>
          </div>
          <div class="register_li">
            <div class="i_tit"><strong>주소<span> * </span></strong></div>
            <div class="i_con">
              <label>
                <input type="text" name="u_m_zipcode" id="m_zipcode" class="i_text" onclick="openDaumPostcode();">  
              </label>
              <label>    
                <input type="button" value="우편번호 검색" id="prof_zipcode" class="i_button" onclick="openDaumPostcode();">
              </label>
              <div class="input_space"></div>
              <label>
                <input type="text" name="u_m_address" id="m_address" class="i_text2" value="${cartToyVos.get(0).getU_m_address()}">  
              </label>
              <label class="i_label">
                <input type="text" name="u_m_address_sub" id="m_address_sub" class="i_text2" value="${cartToyVos.get(0).getU_m_address_sub()}">
                <span>※ 배송주소를 다시 한번 확인해 주세요.</span>
              </label>	
              <input type="hidden" name="delivery_address" >
            </div>
          </div>
          <div class="register_li">
            <div class="i_tit"><strong>휴대전화<span> *</span></strong></div>
            <div class="i_con">
              <label>
                <input type="text" name="m_mobile_1" id="m_mobile_1" class="i_text3" onkeyup="this.value=number_filter(this.value);" maxlength="4">  
              </label>
              -
              <label>
                <input type="text" name="m_mobile_2" id="m_mobile_2" class="i_text3" onkeyup="this.value=number_filter(this.value);" maxlength="4">  
              </label>
              - 
              <label>
                <input type="text" name="m_mobile_3" id="m_mobile_3" class="i_text3" onkeyup="this.value=number_filter(this.value);" maxlength="4"><br>
              </label>
              <input type="hidden" name="delivery_phone" >
   		    </div>
          </div>
          <div class="register_li">
            <div class="i_tit"><strong>일반전화</strong></div>
            <div class="i_con">
              <label>
                <input type="text" name="m_phone_1" id="m_phone_1" class="i_text3" onkeyup="this.value=number_filter(this.value);" maxlength="4">  
              </label>
              - 
              <label>
                <input type="text" name="m_phone_2" id="m_phone_2" class="i_text3" onkeyup="this.value=number_filter(this.value);" maxlength="4">  
              </label>
              - 
              <label>
                <input type="text" name="m_phone_3" id="m_phone_3" class="i_text3" onkeyup="this.value=number_filter(this.value);" maxlength="4">  
              </label>
            </div>
          </div>
            <div class="register_li">
            <div class="i_tit"><strong>배송메시지</strong></div>
            <div class="i_con">
              <label>
                <input type="text" name="ord_comment" id="ord_comment" class="i_text4">
                                 <span>(50자 이내 작성)</span>
              </label>
            </div>
          </div>
        </div>
        </fieldset>
              </div>
      
    </div>
  <script>
  set_deliveryAddr();
  function set_deliveryAddr() {
	  let type = "";
	  jQ("input[name=delivery_addr]").each(function(){
		  if (jQ(this).prop("checked")) {
			  type = jQ(this).val()
		  }
	  })
	  if (type=="Orderaddr") {
		  jQ("input[name=u_m_name]").val("${cartToyVos.get(0).getU_m_name()}");
		  jQ("input[name=u_m_zipcode]").val("${cartToyVos.get(0).getU_m_zipcode()}");
		  jQ("input[name=u_m_address]").val("${cartToyVos.get(0).getU_m_address()}");
		  jQ("input[name=u_m_address_sub]").val("${cartToyVos.get(0).getU_m_address_sub()}");
		  let phone = "${cartToyVos.get(0).getU_m_phone()}";
		  let phones = phone.split("-")
		  jQ("input[name=m_mobile_1]").val(phones[0]);
		  jQ("input[name=m_mobile_2]").val(phones[1]);
		  jQ("input[name=m_mobile_3]").val(phones[2]);
	  } else if (type=="Newaddr") {
		  jQ("input[name=u_m_name]").val("");
		  jQ("input[name=u_m_zipcode]").val("");
		  jQ("input[name=u_m_address]").val("");
		  jQ("input[name=u_m_address_sub]").val("");
		  jQ("input[name=m_mobile_1]").val("");
		  jQ("input[name=m_mobile_2]").val("");
		  jQ("input[name=m_mobile_3]").val("");
	  }
	  
  }
  
  </script>
  
  
  <!-- 배송지 정보 SCRIPT -->
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>  
  <script>
    //새주소등록  우편번호찾기
    function openDaumPostcode() {
      new daum.Postcode({
        oncomplete: function(data) {
          // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
  
          // 각 주소의 노출 규칙에 따라 주소를 조합한다.
          // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
          var fullAddr = ''; // 최종 주소 변수
          var extraAddr = ''; // 조합형 주소 변수
  
          // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
          if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
            fullAddr = data.roadAddress;
  
          } else { // 사용자가 지번 주소를 선택했을 경우(J)
            fullAddr = data.jibunAddress;
          }
  
          // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
          if(data.userSelectedType === 'R'){
            //법정동명이 있을 경우 추가한다.
            if(data.bname !== ''){
              extraAddr += data.bname;
            }
            // 건물명이 있을 경우 추가한다.
            if(data.buildingName !== ''){
              extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
            fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
          }
          // 우편번호와 주소 정보를 해당 필드에 넣는다.
          jQ('#m_zipcode').val(data.zonecode);
          jQ('#m_address').val(fullAddr);
          jQ('#m_address_sub').focus();
        }
      }).open();
    }
  </script>  

      <!-- 결제 정보 -->
  <div class="payment_info">
      <p class="tit">결제 정보</p>
      <dl class="payment_type">
        <dt>결제방법 선택</dt>
         <dd>
          <label class="ra_label">
            <input type="radio" name="ord_pay_method" id="ord_pay_method2" class="i_radio" value="bank" checked>
            <input type="hidden" name="order_status">
            <span>무통장 입금</span>
          </label>
        </dd>
      </dl>      
    </div>
    <!-- //결제 정보 -->
    <!-- 무통장입금 - 안내창 -->
    <div id="p_type_deposit" style="display:block">
      <!-- 무통장입금 입금 계좌 -->
      <div class="account_info">
        <div class="register_li">
          <div class="i_tit"><strong>입금계좌<span> *</span></strong></div>
          <div class="i_con">
            <label>
              <select id="ord_bank" name="ord_bank" class="i_select2">  
                <option value="결제계좌를 선택해 주세요.">결제계좌를 선택해 주세요.</option>  
                <option value="농협은행 204063-55-222333">농협은행 / 204063-55-222333 / (주)블도져스</option>
                <option value="한빛은행 068-396373-13-001">한빛은행 / 068-396373-13-001 / (주)블도져스</option>
                <option value="조흥은행 240-05-013166">조흥은행 / 240-05-013166 / (주)블도져스</option>
              </select>  
            </label>
          </div>
        </div>
        <div class="register_li">
          <div class="i_tit"><strong>입금예정일<span> *</span></strong></div>
          <div class="i_con">
            <!-- 달력 -->
            <div class="cld_area">
              <label>
                <input class="i_text" id="ord_onlinedt" name="ord_onlinedt" type="text">
              </label>
            </div>
            <!-- //달력 -->
          </div>
        </div>
        <div class="register_li">
          <div class="i_tit"><strong>입금자명<span> *</span></strong></div>
          <div class="i_con">
            <label>
              <input type="text" name="ord_name" id="ord_name" class="i_text2">  
            </label>
          </div>
        </div>
      </div>
    </div>
    <script>
  $( function() {
    $( "#ord_onlinedt" ).datepicker({
      showOn: "button",
      buttonImage: "/toy/resources/img/user/CALENDER.png",
      buttonImageOnly: true,
      buttonText: "CALENDER"
    });
  } );
  </script>
    <script>
     jQ('#ord_onlinedt').datepicker();
  		jQ(document).on("click", "#ord_onlinedt_btn", function(){
        	jQ('#ord_onlinedt').datepicker('show');
        });
  
	  	jQ.datepicker.regional['ko'] = {
			closeText: '닫기',
			prevText: '이전달',
			nextText: '다음달',
			currentText: '오늘',
			monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],				
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],					
			dayNames: ['일','월','화','수','목','금','토'],
			dayNamesShort: ['일','월','화','수','목','금','토'],
			dayNamesMin: ['일','월','화','수','목','금','토'],
			weekHeader: 'Wk',
			dateFormat: 'yy-mm-dd',
			firstDay: 0,
			isRTL: false,
			showMonthAfterYear:true,		
			changeYear: true,
			yearRange: "-50:+20",
			yearSuffix: ' 년'};
  		jQ.datepicker.setDefaults(jQ.datepicker.regional['ko']);
    	 
	    </script>       
    
    
    <script>
    function select_pay_method(num){
    	if (num==0) {
    		jQ("#p_type_card").show()
    		jQ("#p_type_deposit").hide()
    	} else if (num==2) {
    		jQ("#p_type_card").hide()
    		jQ("#p_type_deposit").show()
    	}
    }
    </script>
    
    
    <!-- 주문,결제 최종 정보 영역 -->
    <div class="total_info">
      <input type="hidden" id="sum_sale_price" name="sum_sale_price">
      <input type="hidden" id="sum_ecoin_price" name="sum_ecoin_price">
      <input type="hidden" id="sum_coupon_price" name="sum_coupon_price">
      <input type="hidden" id="sum_total_price" name="sum_total_price" value="176400">
      <input type="hidden" id="sum_total_mileage" name="sum_total_mileage" value="9800">
      <input type="hidden" id="p_delivery_price" name="p_delivery_price" value="0">
      
      <!-- 주문 총액 정보 -->
       <dl class="total_order">
        <dt>주문상품 : </dt>
        <dd>총 ${cartToyVos.size()}종 [${qty_total}개]</dd>
        <dt>총 상품금액 : </dt>
        <dd>${amountTotal}원</dd>
        <dt>배송비 : </dt>
        <dd>5,000원</dd>
      </dl>
      <!-- //주문 총액 정보 -->
      
      <!-- 최종 결제 정보 -->
      <dl class="total_payment">
        <dt><strong>최종 결제 금액 :</strong></dt>
        <dd><strong><span id="sum_t_price_show">${allTotAmount}원</span></strong></dd>
      </dl>
      <!-- //최종 결제 정보 -->
      
      <!-- 결제하기 버튼 -->
      <label>
        <button name="bynPay" type="button" class="btn_payment" onclick="payment();">결제하기</button>
      </label>
      <!-- //결제하기 버튼 -->
    </div>
    <!-- //주문,결제 최종 정보 영역 -->
  </form>					
  <script>
   let form = document.LGD_PAYINFO
   function payment(){
      let delivery_name = jQ("input[name=delivery_name]").val()
      /*  let u_m_name =  jQ("input[name=u_m_name]").val();*/
	  let u_m_zipcode = jQ("input[name=u_m_zipcode]").val()
      let u_m_address = jQ("input[name=u_m_address]").val()
      let u_m_address_sub = jQ("input[name=u_m_address_sub]").val()
      let m_mobile_1 = jQ("input[name=m_mobile_1]").val()
      let m_mobile_2 = jQ("input[name=m_mobile_2]").val()
      let m_mobile_3 = jQ("input[name=m_mobile_3]").val()
      
      if (!delivery_name) {
         alert("받을 사람 이름을 입력해 주세요.")
         jQ("input[name=delivery_name]").focus()
         return false;
      }/*  else if (u_m_name.value != delivery_name.value) {
			alert('사용자와 입금자를 동일한 이름으로 입력해주세요.');
			form.delivery_name.focus();
	  } */ else if (!u_m_zipcode) {
         alert("우편번호를 입력하세요.")
         jQ("input[name=u_m_zipcode]").focus()
         return false;
      } else if (!u_m_address) {
         alert("주소를 입력하세요.")
         jQ("input[name=u_m_address]").focus()
         return false;
      } else if (!u_m_address_sub) {
         alert("상세주소를 입력하세요.")
         jQ("input[name=u_m_address_sub]").focus()
         return false;
      } else if(!m_mobile_1){
			alert("받을 사람의 연락처를 입력해 주세요.")
			jQ("input[name=m_mobile_1]").focus()
			return false;
	  } else if(!m_mobile_2){
			alert("받을 사람의 연락처를 입력해 주세요.")
			jQ("input[name=m_mobile_2]").focus()
			return false;
	  } else if(!m_mobile_3){
			alert("받을 사람의 연락처를 입력해 주세요.")
			jQ("input[name=m_mobile_3]").focus()
			return false;
      } 
      
      let purchase = ""
      jQ("input[name=ord_pay_method]").each(function(){
         if (jQ(this).prop("checked")){
            purchase = jQ(this).val()
         }
      })
      if (purchase=="bank") {
         let ord_bank = jQ("#ord_bank").val()
         let ord_onlinedt = jQ("input[name=ord_onlinedt]").val()
         let ord_name = jQ("input[name=ord_name]").val()
         if (ord_bank=="결제계좌를 선택해 주세요.") {
            alert("입금 계좌번호를 선택하세요.")
            jQ("input[name=ord_bank]").focus()
            return false;
         } else if (!ord_onlinedt) {
            alert("입금예정일을 입력하세요.")
            jQ("input[name=ord_onlinedt]").focus()
            return false;
         } else if (!ord_name) {
            alert("입금자명을 입력하세요.")
            jQ("input[name=ord_name]").focus()
            return false;
         }
         jQ("input[name=order_status]").val(0)
      } else {
         jQ("input[name=order_status]").val(1)
      }
      
      jQ("input[name=delivery_address]").val("["+u_m_zipcode+"] " + u_m_address + " " + u_m_address_sub) 
      jQ("input[name=delivery_phone]").val(m_mobile_1+"-"+m_mobile_2+"-"+ m_mobile_3)
      
      form.action = "${pageContext.request.contextPath}/toy/user/purchaseRequest"
	  form.method = "post"
      form.submit()
  }

</script>       			