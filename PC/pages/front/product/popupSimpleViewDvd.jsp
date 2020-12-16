<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<ui:decorator name="${popup}"/>
<head>
<title>DVD상품 간략보기</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="/css/contents.css"/>
<script type="text/javascript" src="/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript">
var imageServerUri = "<ui:variable key='image.server.host,image.upload.uri' prepare='http://' postfix='/'/>";

//jQuery(function($) { });
$(document).ready(function($){
	
	$('#tabs01').removeClass().addClass("on");
	$('#tabs02').removeClass().addClass("off");
	$('div#tabs-1').show();
	$('div#tabs-2').hide();

});

//tab 선택
function selectTabs(tabsId) {

	$('#tabs01').removeClass().addClass("off");
	$('#tabs02').removeClass().addClass("off");

	switch(tabsId){
		case '1' :
			$('#tabs01').removeClass().addClass("on");
			$('div#tabs-1').show();
			$('div#tabs-2').hide();
			break;
		case '2' :
			$('#tabs02').removeClass().addClass("on");
			$('div#tabs-1').hide();
			$('div#tabs-2').show();
			break;
	}
}
</script>
</head>
<body>


<body>
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
				<li class="last"><a href="javascript:selectTabs('2');" id="tabs02" class="off">상품소개</a></li>
			</ul>
		</div>
		<div class="movie_compact">
			<p class="bold">${product.commTitle}</p>
			<c:set var="dvdName" value="DVD"/>
			<c:forEach items="${cateList}" var="list" varStatus="status">
				<c:if test="${list.parentCateId eq '00040000'}">
					<c:set var="dvdName" value="BLU-RAY"/>
				</c:if>
				<c:if test="${list.parentCateId eq '00040100'}">
					<c:set var="dvdName" value="DVD"/>
				</c:if>
			</c:forEach>
			<p>${dvdName} Disc l 감독 ${product.director} 출연자 (목소리) ${product.actor} l 제작사 ${product.makerName} </p>
			<p class="path">
				<c:forEach items="${cateList}" var="list" varStatus="status">
					<c:if test="${fn:length(cateList) eq status.index+1}">
						${list.cateNameFullPath}
					</c:if>
				</c:forEach>
			</p>
			<div class="movie_info">
				<dl>
					<dt>
						<ui:image rcrdCd="${product.rcrdCd}" prdtGbn="${product.sellPrdtGbn}" width="150" alt="${product.rcrdName}" clazz="photo" rcrdImgType="large" ratingCode="${product.ratingCode}" />
					</dt>
					<dd class="bold">정가 : <fmt:formatNumber value="${product.prdtSellPrice}" pattern=",###" />원</dd>
					<dd class="bold">판매가 : <fmt:formatNumber value="${product.priceReal}" pattern=",###" />원 
						<span class="f_orange">[${hfn:rate(product.prdtSellPrice, product.priceReal)}%↓ 
							<fmt:formatNumber value="${product.priceReal - product.prdtSellPrice}" pattern=",###" />원 할인]
						</span>
					</dd>
					<dd class="mile">마일리지 : <fmt:formatNumber value="${product.priceReal * product.prdtSavedRate / 100}" pattern=",###" />원 [${product.prdtSavedRate}%적립]</dd>
					<dd>출시일    : ${fn:substring(product.rlseDt, 0, 4)}년 ${fn:substring(product.rlseDt, 4, 6)}월 ${fn:substring(product.rlseDt, 6, 8)}일</dd>
					<dd>음반코드 : ${product.rcrdCd} </dd>
					<dd>화면 : ${product.screen}</dd>
					<dd>음향 : ${product.sound}</dd>
					<dd>언어 : ${product.language}</dd>
					<dd>자막 : ${product.caption}</dd>
					<dd class="mile">상영시간 : ${product.screenHour}분 </dd>
				</dl>
			</div>
		</div>
	</div>
	<!-- 간략정보 E -->
	
	<!-- 상품소개 S -->
	<div id="tabs-2" class="pop_body">
		<div class="m_tab_pop">
			<ul>
				<li><a href="javascript:selectTabs('1');" id="tabs01" class="off">간략정보</a></li>
				<li class="last"><a href="javascript:selectTabs('2');" id="tabs02" class="on">상품소개</a></li>
			</ul>
		</div>
		<div class="movie_compact">
			<p class="bold">${product.commTitle}</p>
			<c:forEach items="${cateList}" var="list" varStatus="status">
				<c:if test="${list.parentCateId eq '00040000'}">
					<c:set var="dvdName" value="BLU-RAY"/>
				</c:if>
				<c:if test="${list.parentCateId eq '00040100'}">
					<c:set var="dvdName" value="DVD"/>
				</c:if>
			</c:forEach>
			<p>${dvdName} Disc l 감독 ${product.director} 출연자 (목소리) ${product.actor} l 제작사 ${product.makerName} </p>
			<p class="path">
				<c:forEach items="${cateList}" var="list" varStatus="status">
					<c:if test="${fn:length(cateList) eq status.index+1}">
						${list.cateNameFullPath}
					</c:if>
				</c:forEach>
			</p>
			
			<div class="movie_info">
				<dl>
					<dt>
						<ui:image rcrdCd="${product.rcrdCd}" prdtGbn="${product.sellPrdtGbn}" width="150" alt="${product.rcrdName}" clazz="photo" rcrdImgType="large" ratingCode="${product.ratingCode}" />
					</dt>
					<dd>${product.description}</dd>
				</dl>
			</div>
		</div>
	</div>
	<!-- 상품소개 E -->
	
	<div class="h20"></div>
	<div class="popup-foot">
		<button type="button" onclick="self.close()"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/popup/btn_close.gif" alt="닫기" /></button>
	</div>
</div>
</body>
</html>