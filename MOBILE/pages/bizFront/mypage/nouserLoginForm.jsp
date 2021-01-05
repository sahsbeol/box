<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<html lang="ko">
<head>
	<!-- 태그 라이브러리 -->
	<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
	<!-- 데코레이터 메뉴,푸터 없음 -->
	<ui:decorator name="bizSimpleHot"/>	
	
	<script type="text/javascript">
        $(document).ready(function() {
	        var responseMessage = "<c:out value="${errorMessagesForNoUser}" />";
	        if(responseMessage != ""){
	            alert(responseMessage);
	        }
	        
			// 로그인_닫기 버튼으로 ID clear
		    var $ipt = $('#chkId'),
		        $clearIpt = $('.search');
			
		    $ipt.keyup(function(){
		      	$(".search").toggle(Boolean($(this).val()));
		    });
		    
		    $clearIpt.toggle(Boolean($ipt.val()));
		    
		    $clearIpt.click(function(){
		      	$("#chkId").val('').focus();
		      	$(this).hide();
		      	$("input.m_login").trigger("change");
		    });
		    
			// 로그인_닫기 버튼으로 PW clear
		    var $ipt = $('#chkPw'),
		        $clearIpt = $('.searchClear');
			
		    $ipt.keyup(function(){
		      	$(".searchClear").toggle(Boolean($(this).val()));
		    });
		    
		    $clearIpt.toggle(Boolean($ipt.val()));
		    
		    $clearIpt.click(function(){
		   		$("#chkPw").val('').focus();
		      	$(this).hide();
		      	$("input.m_login").trigger("change");
		    });
		    
			//주문배송 조회 활성화 및 데이터 유효성 체크
			$("input.m_login").on("change keyup paste", function() {
			    var chkId = $("#chkId").val($("#chkId").val().replace(/[^0-9]/g,''));
			    var chkPw = $("#chkPw").val($("#chkPw").val().replace(/[^0-9]/g,''));
			    
			    if($(chkPw).val() != "" && $(chkId).val() != "") {
			    	$("button.btn_login").removeClass("off");
			    	$("button.btn_login").addClass("on");
			    }else{
			    	$("button.btn_login").removeClass("on");
			    	$("button.btn_login").addClass("off");
			    }
			});
		});
        
        var noUserLogin = function(){
        	//필수값 입력시
        	if($("button.btn_login").hasClass("on")){
        		document.nouserLoginForm.submit();
        	}
        };
        
      	//maxlength 체크
        function maxLengthCheck(object){
        	if (object.value.length > object.maxLength) {
        		object.value = object.value.slice(0, object.maxLength);
        	}
        }
	</script>
</head>

<body>
	<header class="header">
		<div class="header_wrap">
			<div class="ic_header h_back"><a href="javascript:history.back();" class="blind">뒤로가기</a></div>
	  	</div>
	</header>
	<!-- 컨텐츠 (로그인은 cont_login : class 추가) -->
	<div id="content" class='cont_login'>
		<div class='loginWrap'>
			<div class='logo_txt'><p>로그인</p></div>
			<ul class='tab_login m_tab_login clear'>
				<li><a href='http://mobile.kyobobook.co.kr/hotLogin?turl=${encodedReturnUrl}' onclick="login();return false;" target='_self' class='btn_member_off'>회원 로그인</a></li>
				<li><a href='javascript:' class='btn_nonmember_on'>비회원(주문조회)</a></li>
			</ul>
			<div class='box_login'>
				<form id="nouserLoginForm" name="nouserLoginForm" action="/m/biz/nouserLogin" method=post>
					<input type="hidden" name="returnUrl" value="${encodedReturnUrl}"/>
					<fieldset>
						<legend>로그인 정보 입력</legend>
						<div class="m_inp_login">
							<input type="number" id="chkId" name="orderNum" class="m_login" placeholder="주문번호를 입력해주세요" oninput="maxLengthCheck(this)" maxlength="12" value="${orderNum}">
							<span class="search"><img src='/images/biz/common/btn_close.png' alt='지우기'></span>
						</div>
						<div class='m_inp_login m_inp_pw'>
							<input type="password" id="chkPw" name="passwd" class="m_login" placeholder="비밀번호를 입력해주세요" maxlength="4" value="${passwd}">
							<span class="searchClear"><img src='/images/biz/common/btn_close.png' alt='지우기'></span>
						</div>
						<p class='txt_inquiry'>- 비회원으로 상품을 구매하신 경우에만 조회 가능합니다</p>
						<!-- 모두 유효한 값일 때, btn_login on으로 클래스 변경 -->
						<button type="button" class="btn_login <c:choose><c:when test="${!empty orderNum && !empty passwd}">on</c:when><c:otherwise>off</c:otherwise></c:choose> invoice" onclick="noUserLogin();">주문배송조회</button>
					</fieldset>
        		</form>
				<div class='box_register'>
					<a href="https://mobile.kyobobook.co.kr/member/join?partnerCode=HOT" class='link_register'>회원가입<img src='/images/biz/sub/arrow_r_s.png' alt='회원가입 바로가기'></a>
					<!-- <span class='bt_bar'></span> -->
					<p>교보문고/핫트랙스 통합회원으로 가입하시면<br> 편리함과 혜택이 늘어납니다.</p>
				</div>
				
				<!-- 비회원 로그인 배너 -->
				<div class='bnr_login'>
					<c:import url="/m/biz/banner"/>
				</div>
				<!-- //비회원 로그인 배너 -->
				
				<p class='txt_customer'>고객센터 <span>1661-1112</span></p>
				<p class='txt_center'>(평일 09:00~18:00 / 점심 12:00~13:00 / 주말 및 공휴일 휴무)</p>
				<span class='bt_bar'></span>
				<p class='copyright font_t'>COPYRIGHT(C) KYOBO BOOK CENTRE ALL RIGHTS RESERVED.</p>
			</div>
		</div>
	</div>
	<!-- //컨텐츠 -->
</body>
</html>