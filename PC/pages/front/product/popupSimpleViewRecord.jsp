<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<ui:decorator name="popup"/>
<html>
<head>
<title>음반 상품 간략보기</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
var imageServerUri = "<ui:variable key='image.server.host,image.upload.uri' prepare='http://' postfix='/'/>";

//jQuery(function($) { });
$(document).ready(function($){
	
	$('#tabs01').removeClass().addClass("on");
	$('#tabs02').removeClass().addClass("off");
	$('#tabs03').removeClass().addClass("off");
	$('div#tabs-1').show();
	$('div#tabs-2').hide();
	$('div#tabs-3').hide();

});

function selectTrackTabs(cdNo) {

	$.ajax({
		url : "/ht/record/productCdNoList"
		, data : {
			rcrdCd : $("input[name='rcrdCd']").val(),
			cdNo   : cdNo
		}
		, success: function(data) {
			
			var addTag = $(".music_box_list");
			var addText = "";
			
			$(addTag).find('ol').remove();
			
			for(i=0;i<data.listTrack.length;i++){
				addText += "<ol><li>"+data.listTrack[i].trkNo+". "+data.listTrack[i].trkName+"</li></ol>";
			}	

			addTag.find('ul').after($(addText));
        }
	});
}	

//tab 선택
function selectTabs(tabsId) {

	$('#tabs01').removeClass().addClass("off");
	$('#tabs02').removeClass().addClass("off");
	$('#tabs03').removeClass().addClass("off");

	switch(tabsId){
		case '1' :
			$('#tabs01').removeClass().addClass("on");
			$('div#tabs-1').show();
			$('div#tabs-2').hide();
			$('div#tabs-3').hide();
			break;
		case '2' :
			$('#tabs02').removeClass().addClass("on");
			$('div#tabs-1').hide();
			$('div#tabs-2').show();
			$('div#tabs-3').hide();
			break;
		case '3' :
			$('#tabs03').removeClass().addClass("on");
			$('div#tabs-1').hide();
			$('div#tabs-2').hide();
			$('div#tabs-3').show();
			break;
	}
}

</script>
</head>
<body>

<input type="hidden" name="rcrdCd" value="${product.rcrdCd}" />

<div id="popup">
	<div class="pop-head" >
		<h1><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/popup/h1_logo.gif" alt="Hottracks" /></h1>
		<h2><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/popup/h2_product_view.gif"  alt="제품간략보기" /></h2>
	</div>
	
	<!-- 간략정보 S -->
	<div id="tabs-1" class="pop_body">
		<div class="m_tab_pop">
			<ul>
				<li><a href="javascript:selectTabs('1');" id="tabs01" class="on">간략정보</a></li>
				<li><a href="javascript:selectTabs('2');" id="tabs02" class="off">앨범소개</a></li>
				<li class="last"><a href="javascript:selectTabs('3');" id="tabs03" class="off">앨범수록곡</a></li>
			</ul>
		</div>
		<div class="music_compact">
			<p class="bold">${product.rcrdName}</p>
			<p>뮤지션 ${product.artiName}  l  제작사  ${product.makerName}</p>
			<p class="path">
				<c:forEach items="${cateList}" var="list" varStatus="status">
					<c:if test="${fn:length(cateList) eq status.index+1}">
						${list.cateNameFullPath}
					</c:if>
				</c:forEach>
			</p>

			<div class="music_info">
				<dl>
					<dt>
						<ui:image rcrdCd="${product.rcrdCd}" prdtGbn="${product.sellPrdtGbn}" width="150" height="150" ratingCode="A" />
					</dt>
					<dd class="f_black">정가 : <span class="line-through"><fmt:formatNumber value="${product.prdtSellPrice}" pattern=",###" />원</span></dd>
					<dd class="f_black">판매가 : <fmt:formatNumber value="${product.priceReal}" pattern=",###" />원 
						<span class="f_orange">[${hfn:rate(product.prdtSellPrice, product.priceReal)}%↓ 
							<fmt:formatNumber value="${product.priceReal - product.prdtSellPrice}" pattern=",###" />원 할인]
						</span>
	                </dd>
					<dd class="mile">마일리지 : <fmt:formatNumber value="${product.priceReal * product.prdtSavedRate / 100}" pattern=",###" />원 [${product.prdtSavedRate}%적립]</dd>
					<dd>출시일    : ${fn:substring(product.rlseDt, 0, 4)}년 ${fn:substring(product.rlseDt, 4, 6)}월 ${fn:substring(product.rlseDt, 6, 8)}일</dd>
					<dd>음반코드 : ${product.rcrdCd} |  미디어 : ${product.mediaName}  |  수입구분 : <c:if test="${product.impYn eq 'Y'}">수입</c:if><c:if test="${product.impYn eq 'N'}">라이센스</c:if></dd>
				</dl>
			</div>
		</div>
	</div>
	<!-- 간략정보 E -->
	
	<!-- 앨범소개 S -->	
	<div id="tabs-2" class="pop_body">
		<div class="m_tab_pop">
			<ul>
				<li><a href="javascript:selectTabs('1');" id="tabs01" class="off">간략정보</a></li>
				<li><a href="javascript:selectTabs('2');" id="tabs02" class="on">앨범소개</a></li>
				<li class="last"><a href="javascript:selectTabs('3');" id="tabs03" class="off">앨범수록곡</a></li>
			</ul>
		</div>
		<div class="music_compact">
			<p class="bold">${product.rcrdName}</p>
			<p>뮤지션 ${product.artiName} | 제작사  ${product.makerName}</p>
			<div class="music_box">
			<p>${product.description}</p>
			</div>
		</div>
	</div>
	<!-- 앨범소개 E -->	
	
	<!-- 앨범 수록곡 S -->	
	<div id="tabs-3" class="pop_body">
		<div class="m_tab_pop">
			<ul>
				<li><a href="javascript:selectTabs('1');" id="tabs01" class="off">간략정보</a></li>
				<li><a href="javascript:selectTabs('2');" id="tabs02" class="off">앨범소개</a></li>
				<li class="last"><a href="javascript:selectTabs('3');" id="tabs03" class="on">앨범수록곡</a></li>
			</ul>
		</div>
		<div class="music_compact">
			<p class="bold">${product.rcrdName}</p>
			<p>뮤지션 ${product.artiName} | 제작사  ${product.makerName}</p>

			<div class="music_box_list">
				<ul>
					<c:forEach begin="1" end="${product.cdCount}" step="1" varStatus="status">
						<c:if test="${not status.last}"><li></c:if>
					 	<c:if test="${status.last}"><li class="bg_none"></c:if>
					 	<a href="javascript:selectTrackTabs('<fmt:formatNumber value="${status.index}" pattern="000"/>');">DISC ${status.index}</a>
					 	</li>
					</c:forEach>
				</ul>
				<div class="listbox">
					<ol>
						<c:forEach items="${listTrack}" var="list" varStatus="status">
							<c:if test="${(status.index mod 2) eq 0 }"><li class="clear">${list.trkNo}. ${list.trkName}</li></c:if>
							<c:if test="${(status.index mod 2) eq 1 }"><li>${list.trkNo}. ${list.trkName}</li></c:if>
						</c:forEach>
					</ol>
				</div>
			</div>
		</div>
	</div>
	<!-- 앨범 수록곡 E -->	
		
	<div class="popup-foot">
		<button type="button" onclick="self.close()"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/popup/btn_close.gif" alt="닫기" /></button>
	</div>
</div>
</body>
</html>
