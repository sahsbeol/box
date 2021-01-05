<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizHot"/>

<script type="text/javascript">
jQuery(function($){
	$("#subTitle").text("알림");
});

//편집/취소 버튼 누를시 화면 변경
function alarmChg(flag){
	var alarmObj = $("#content .alarm_wrap");
	$(alarmObj).removeClass();
	$(alarmObj).addClass("alarm_wrap " + flag);
	
	//편집 취소일 경우 선택된 메세지 해제
	if(flag == "case01"){
		$(".alarm_list li").removeClass("check_on");
	}
}

//편집일때 체크 활성화, 일반일때 페이지 이동
function moveAndChk(aObj, url){
	if($("#content .alarm_wrap").hasClass("case01")){
		location.href = url;
	}else{
		 $(aObj).toggleClass('check_on');
	}
}

//S:선택삭제, A:전체삭제
function delAlarm(flag){
	var $selObj = $(".alarm_list li.check_on");
	alert(flag)
	if(flag == "S"){
		alert($selObj.length)
		if($selObj.length == 0){
			alert("선택하신 알림 내용이 없습니다.");
			return;
		}
	}else{
		$selObj = $(".alarm_list li");
	}
	
	var temp = new Array();
	for(var i = 0;i < $selObj.length; i++){
		var msgSeq = $($selObj[i]).attr("msgSeq");
		temp.push(msgSeq);
	}
	var msgSeqLst = temp.toString();
	console.log(msgSeqLst);
	
    $.ajax({
        type: "POST"
        ,url:"/m/biz/help/rmAlarm"
        ,data:{msgSeq : msgSeqLst}
        ,dataType: 'json'
        ,success: function(data) {
            alert("삭제되었습니다.");
            location.reload();
        }
        ,error: function() {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}
</script>

<div id="content">
	<div class="alarm_wrap ${fn:length(list) > 0 ? 'case01' : ''}">
		<c:choose>
			<c:when test="${fn:length(list) == 0}">
				<!-- 알림 없음 -->
				<div class="no_alarm">
					<img class='alarm_no' src="/images/biz/sub/no_alarm.png" alt="알림내역없음">
					<p><span>앗! 이럴수가! 수신된 알림 메시지가 없어요.<br>혹시 놓치고 있지 않으세요?<br>알림 수신 시, </span><br><br>더 많은 쿠폰, 상품할인<br> 혜택을 받으실 수 있습니다.</p>
					<a href="javascript:;" onclick="bizGoSetting();return false;">알림설정 확인하기</a>
				</div>
				<!--// 알림 없음 -->
			</c:when>
			<c:otherwise>
				<!-- 안내메시지 -->
				<div class="notice_inner clear">
					<p>수신일로 부터 1개월간 보관 됩니다.</p>
					<a href="javascript:" class='btn_cancel' onclick="alarmChg('case01');"><span>취소</span></a>
					<a href="javascript:" class='btn_edit' onclick="alarmChg('case02');"><span>편집</span></a>
					<a href="javascript:" class='alarm_set' onclick="bizGoSetting();return false;"><span>알림설정</span></a>
				</div>
				<!--// 안내메시지 -->
				<!-- 알림내용 -->
				<div class="alarm_inner">
					<ul class='box_delete clear'>
						<li><a href="javascript:" class='btn_part' onclick="delAlarm('S');"><span>선택삭제</span></a></li>
						<li><a href="javascript:" class='btn_all' onclick="delAlarm('A');"><span>전체삭제</span></a></li>
					</ul>
					<ul class='alarm_list'>
						<c:forEach items="${list}" var="l" varStatus="st">
							<li<c:if test="${l.msgDtmMsg eq '이벤트가 종료되었습니다.'}"> class='end'</c:if> onclick="moveAndChk(this, '${l.msgLnkUrl}');" msgSeq="${l.msgSeq}">
								<a href="javascript:" class='chk_delete'></a>
								<a href="javascript:" class='btn_alarm'>
									<h2>${l.msgTitle}</h2>
									<p>${l.msgDtmMsg}</p>
									<span>${l.msgDtmMsg}</span>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
				<!--// 알림내용 -->
			</c:otherwise>
		</c:choose>		
	</div>
</div>