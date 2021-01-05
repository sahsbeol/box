<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>

<script type="text/javascript">
jQuery(function($){
	$("#subTitle").text("설정");
	
	$(".btn_check > input").change(function(){
		if($(this).is(":checked")){
   			$(this).parent().addClass("set_on");
       	}
       	else {
    		$(this).parent().removeClass("set_on");
       	}
		syncData();
	});
});

function closeSetting(){
	document.location.href = '${defaultHost}/m/biz/welcomeMain';
/*	
    if(window.HybridApp != undefined && window.HybridApp.goSetting != undefined){
        window.HybridApp.closeSetting();
    }else{
        history.back();
    }
*/
}

function syncData(){
	var autoLoginYn = $("#btnAutoLoginYn").hasClass("set_on")?"Y":"N";
    var adAltRcvYn = $("#btnAdAltRcvYn").hasClass("set_on")?"Y":"N";
    var nightRcvYn = $("#btnNightRcvYn").hasClass("set_on")?"Y":"N";
    var cameraUseYn = $("#btnCameraUseYn").hasClass("set_on")?"Y":"N";
    var picUseYn = $("#btnPicUseYn").hasClass("set_on")?"Y":"N";

    /*FingerPush 수신 여부 관련 Native App 함수 호출*/
    var userAgent = navigator.userAgent;
    //안드로이드
    if(/Android/i.test(userAgent)){
    	if(window.HybridApp != undefined && window.HybridApp.pushRcvYn != undefined){
    		window.HybridApp.pushRcvYn(adAltRcvYn); 
        }
    }
    //iOS
    else if(/iPad|iPhone|iPod/i.test(userAgent) && !window.MSStream){
    	try{
    		document.location = "myScheme://pushRcvYn?"+adAltRcvYn;
    	}catch(err){
    		alert(err);
    	}
    }
    
    $.ajax({
        type: "POST"
        ,url: "/m/biz/dev/syncData"
        ,dataType: "json"
        ,async: false
        ,data : {
            devId : "${device.devId}"
          , gcmKey : "${device.gcmKey}"
          , devVersion : "${device.devVersion}"
          , autoLoginYn : autoLoginYn
          , adAltRcvYn : adAltRcvYn
          , nightRcvYn : nightRcvYn
          , cameraUseYn : cameraUseYn
          , picUseYn : picUseYn
        }
        ,success : function(data){
            //console.log("save");
        } 
        ,error: function(data) {
            //console.log("fail");
        }
    });
}

function applogout() {
	if($("#btnAutoLoginYn").hasClass("set_on")){
		$("#btnAutoLoginYn").removeClass("set_on");
		syncData();
	}
	logout();
}
</script>

<div id="content">
	<div class="setup_wrap">
		<div class="setup_inner">
			<span>로그인</span>
			<ul class='setup_list'>
				<li>
					<c:choose>
						<c:when test="${isLogin}">
							<h3>${user.userId}</h3>
							<a href="javascript:" onclick="applogout();return false;" class='btn_logout'>로그아웃</a>
						</c:when>
						<c:otherwise>
							<h3></h3>
							<a href="javascript:" onclick="login();return false;" class='btn_logout'>로그인</a>
						</c:otherwise>
					</c:choose>
				</li>
				<li>
					<h3>자동로그인</h3>
					<label class="btn_check<c:if test="${device.autoLoginYn eq 'Y'}"> set_on</c:if>" id="btnAutoLoginYn">
						<input type="checkbox" <c:if test="${device.autoLoginYn eq 'Y'}">checked="true"</c:if>>
						<span></span>
					</label>
				</li>
			</ul>
			<span>알림설정</span>
			<ul class='setup_list'>
				<li>
					<h3>광고성 알림 수신</h3>
					<p>본 설정은 해당 기기에서만 유효하며,<br> 특가상품 및 할인/쿠폰 등 다양한 이벤트 혜택에 관한 마케팅 알림을 받으실 수 있습니다.</p>
					<label class="btn_check<c:if test="${device.adAltRcvYn eq 'Y'}"> set_on</c:if>" id="btnAdAltRcvYn">
						<input type="checkbox" <c:if test="${device.adAltRcvYn eq 'Y'}">checked="true"</c:if>>
						<span></span>
					</label>
				</li>
				<%-- <li>
					<h3>야간 수신</h3>
					<p><em>야간(오후9시~익일 오전8시)</em>에도 알림 수신을 허용합니다.</p>
					<label class="btn_check<c:if test="${device.nightRcvYn eq 'Y'}"> set_on</c:if>" id="btnNightRcvYn">
						<input type="checkbox" <c:if test="${device.nightRcvYn eq 'Y'}">checked="true"</c:if>>
						<span></span>
					</label>
				</li> --%>
			</ul>
			<%-- <span>권한 및 기기설정</span>
			<ul class='setup_list'>
				<li>
					<h3>카메라</h3>
					<p>상품평 작성 시, 사진 촬영에 사용합니다.</p>
					<label class="btn_check<c:if test="${device.cameraUseYn eq 'Y'}"> set_on</c:if>" id="btnCameraUseYn">
						<input type="checkbox" <c:if test="${device.cameraUseYn eq 'Y'}">checked="true"</c:if>>
						<span></span>
					</label>
				</li>
				<li>
					<h3>사진/저장소</h3>
					<p>이미지 저장 및 상품평 사진첨부 기능에 사용합니다.</p>
					<label class="btn_check<c:if test="${device.picUseYn eq 'Y'}"> set_on</c:if>" id="btnPicUseYn">
						<input type="checkbox" <c:if test="${device.picUseYn eq 'Y'}">checked="true"</c:if>>
						<span></span>
					</label>
				</li>
				<li class='access_set'>
					<h3>접근권한 설정</h3>
					<a href="javascript:" class='btn_access'></a>
				</li>
				<li>
					<h3>캐시 데이터 삭제</h3>
					<p>기기에 임의로 저장된 데이터를 삭제하여 여유공간을 확보합니다.</p>
					<a href="javascript:" class='btn_delete'>삭제하기</a>
				</li>
			</ul> --%>
			<span>현재 버전 ${device.devVersion}</span>
			<c:if test="${not empty rcntVersion && not empty device && device.devGbnCode eq 'C1331' && device.devVersion eq rcntVersion}">
				<small>최신 버전입니다.</small>
			</c:if>
		</div>
	</div>
</div>