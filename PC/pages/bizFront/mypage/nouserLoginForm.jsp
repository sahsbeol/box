<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<html lang="ko">
<head>
	<!-- 태그 라이브러리 -->
	<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
	<!-- 데코레이터 메뉴,푸터 없음 -->
	<ui:decorator name="bizSimpleHt"/>	

	<script type="text/javascript">
		$(document).ready(function() {
			$("#container").addClass("cont_login");
			
			loginFn();
			t = 1;
			
			//ID clear
			var $clearIpt = $('.search');
			$clearIpt.click(function(){
			  	$("input.form_login").trigger("change");
			});
			
			//PW clear
			var $clearIpt2 = $('.searchClear');
			$clearIpt2.click(function(){
				$("input.form_login").trigger("change");
			});
			
			//주문배송 조회 활성화 및 데이터 유효성 체크
			$("input.form_login").on("change keyup paste", function() {
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
	</script>
</head>

<body>
	<div class='loginWrap'>
		<div class='logo_img'><img src='/images/common/logo_hott.png' alt='logo' onclick='document.location.href="/";'></div>
		<ul class='tab_login clear'>
			<li><a href='https://dev.kyobobook.co.kr/login/LoginHot.jsp?retURL=${encodedReturnUrl}' target='_self' class='btn_member_off'>회원 로그인</a></li>
			<li><a href='javascript:' class='btn_nonmember_on'>비회원 주문조회</a></li>
		</ul>
		<div class='box_login'>
			<form id="nouserLoginForm" name="nouserLoginForm" method="post" action="/ht/biz/mypage/nouserLogin">
				<fieldset>
					<legend>로그인 정보 입력</legend>
					<div class="inp_login">
						<label for="chkId" class="lab_comment">주문번호</label>
						<input type="text" name="orderNum" id="chkId" class="form_login" placeholder="주문번호를 입력해주세요" maxlength="12" value="${orderNum}">
						<span class="search"><img src='/images/common/btn_close.png' alt='지우기'></span>
					</div>
					<div class="inp_login inp_pw">
						<label for="chkPw" class="lab_comment">비밀번호</label>
						<input type="password" name="password" id="chkPw" class="form_login" placeholder="비밀번호를 입력해주세요" maxlength="4" value="${passwd}">
						<span class="searchClear"><img src='/images/common/btn_close.png' alt='지우기'></span>

						<c:if test="${!empty errorMessagesForNoUser}">
							<!-- 주분조회 실패시 경고 메세지 -->
							<p style='color:#ff6a5b;font-size:1em;text-align:left;margin-top:7px;line-height:1.5em;'>
								<c:forEach items="${errorMessagesForNoUser}" var="errorMessage" varStatus="status">${errorMessage}<br/></c:forEach>
							</p>
						</c:if>
					</div>
					
					<p class='txt_inquiry'>- 비회원으로 상품을 구매하신 경우에만 조회 가능합니다</p>
					<!-- 모두 유효한 값일 때, btn_login on으로 클래스 변경 -->
					<button type="button" class="btn_login <c:choose><c:when test="${!empty orderNum && !empty passwd}">on</c:when><c:otherwise>off</c:otherwise></c:choose> invoice" onclick="noUserLogin();">주문배송조회</button>
				</fieldset>
       		</form>
			<div class='box_register'>
				<a href='https://www.kyobobook.co.kr/member/joinMain.laf' target='_blank' class='link_register'>회원가입<img src='/images/sub/arrow_r_s.png' alt='회원가입 바로가기'></a>
				<span class='bt_bar'></span>
				<p>교보문고/핫트랙스 통합회원으로 가입하시면<br> 편리함과 혜택이 늘어납니다.</p>
			</div>
			
			<div class='bnr_login'>
				<c:import url="/ht/biz/loginBanner"/>
			</div>

			<p class='txt_center'>고객센터 : 1661-1112 (	평일09:00 ~ 18:00 / 점심 12:00~13:00 / 주말 및 공휴일 휴무</p>
			<span class='bt_bar'></span>
			<p class='copyright'>COPYRIGHT(C) KYOBO BOOK CENTRE ALL RIGHTS RESERVED.</p>
		</div>
	</div>
</body>
</html>