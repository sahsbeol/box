<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="popup"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>카테고리 서브 | 핫트랙스</title>
	<link rel="stylesheet" type="text/css" href="/css/popup.css" />
	<link rel="stylesheet" type="text/css" href="/css/m_popup.css">
	<style type="text/css">
	div.main-text-search-result ul li a { font-size:11px !important; font-family:Dotum !important; }
	</style>
	<script type="text/javascript">
jQuery(function($) {
	var paramFactory = 
	{
			 paramMap : {}
			, getParamMap : function(){
				return paramFactory.paramMap;
			}
			, addParam : function(key, value){
				paramFactory.paramMap[key] = value;
			}
			, removeParam : function(key){
				delete paramFactory.paramMap[key];
			}
			, getParamByKey : function(key){
				return 	paramFactory.paramMap[key];
			}
			, setDefaultParam :  function(){
				paramFactory.addParam('categoryCode', '0000');
				paramFactory.addParam('koreanCode', 'C0351');
				paramFactory.addParam('charImageCode', 'ko01');
			}
	};
	
	function addSendAjaxFunction()
	{
		$.ajax({
			type : "get"
			, url : "/ht/hot/getSubBrandList"
			, dataType : "text/html"
			, data : paramFactory.getParamMap()
			, contentType  : "application/json"
			, success : successHandler
			, error : errorHandler
		});

		//inner method--------------------------------------------
		function successHandler(result){
			$(".main-text-search-result").html(result);
		}
		
		function errorHandler(){
			alert("잘못된 접근입니다. 관리자에게 문의 해 주세요");
		}
	}
	
	function addBtnOnOffFunction(selectStr, $currentA)
	{
		var pointCut = getMatchStr(selectStr);
		
		switch(pointCut)
		{
			case 'image' :
				imgBtnOnOffAdvice(selectStr, $currentA);
			case 'class' :
				classBtnOnOffAdvice(selectStr, $currentA);
		}
		
		//inner method--------------------------------------------
		function getMatchStr(selectStr)
		{
			var index = selectStr.lastIndexOf("_") + 1;
			var endIndex = selectStr.indexOf(" ", 0) - index ;
			var matchStr = selectStr.substr(index, endIndex); 
			return matchStr;
		}
		
		function imgBtnOnOffAdvice(selectStr, $currentA)
		{
			$(selectStr).each(function()
			{
				var $img = $(this).children().filter("img");
				$img.attr("src",$img.attr("src").replace("_on","_off"));
			});

			$img = $currentA.children().filter("img");
			$img.attr("src",$img.attr("src").replace("_off","_on"));
		}
		
		function classBtnOnOffAdvice(selectStr, $currentA)
		{
			$(selectStr).each(function()
			{
				var $li = $(this).parent();
				$li.attr("class", "");
			});

			$li = $currentA.parent();
			$li.attr("class", "selected" );
		}
	}
	
	function clickEventHandler(e)
	{
		var $a = $(this);
		
		addCustomFunction(e.data.selectStr);
		addBtnOnOffFunction(e.data.selectStr, $a);
		addSetParamFunction($a);
		addSendAjaxFunction();
		
		
		return false;
		
		//inner method--------------------------------------------
		function addCustomFunction(selectStr)
		{	
			if(selectStr != "#categorySerach_image li a")
			{
				makeAllBtnOff("#koreanSerach_class li a");
				makeAllBtnOff("#englishSerach_class li a");
			}	
			//inner method--------------------------------------------
			function makeAllBtnOff(selectStr)
			{
				$(selectStr).each(function()
				{
					var $li = $(this).parent();
					$li.attr("class", "");
				});
			}
		}
		
		function addSetParamFunction(currentObject)
		{
			var $obj = currentObject;
			var paramKey = $obj.attr("name");
			var code = $obj.attr("id");
			var charImageCode = $obj.attr("class");
			
			ifLanguageCode(paramKey, charImageCode);
			paramFactory.addParam(paramKey, code);
			
			//inner method--------------------------------------------
			function ifLanguageCode(paramKey, charImageCode)
			{
				if(paramKey !='categoryCode')
				{
					paramFactory.addParam("charImageCode", charImageCode);
					paramFactory.removeParam('koreanCode');
					paramFactory.removeParam('englishCode');
				}	
			}
			
		}
	}
	
	function addEventAtBtns()
	{
		addGetSubListEvent("#koreanSerach_class li a");
		addGetSubListEvent("#englishSerach_class li a");
		addGetSubListEvent("#categorySerach_image li a");
		
		
		//inner method--------------------------------------------
		function addGetSubListEvent(selectStr)
		{
			$(selectStr).each(function()
			{
				var $aBtn = $(this);
				$aBtn.bind("click",{selectStr:selectStr},clickEventHandler);
			});
		}
		
		
	}
	
	$("document").ready(function()
	{
		addEventAtBtns();
		paramFactory.setDefaultParam();
		
		$(".brandId").live("click", function(){
			var brandName = $(this).attr("href");
			parent.opener.goBrandNotice(brandName);
			window.close();
		});
	});
});

</script>
</head>
<body>
<div id="popup">
	<div class="pop-head" >
		<h1><img src="${imageServer}/images/popup/h1_logo.gif" alt="Hottracks" /></h1>
		<h2><img src="${imageServer}/images/popup/h2_brand_search.gif" alt="HOTTRACKS 브랜드 간편검색" /></h2>
	</div><!-- end pop-head -->
	<div class="pop_body" style="height:430px;">
	<div class="search-body" style="padding:0;">
		<div class="main-text-search">
			<h4><img src="${imageServer}/images/brand/h4_ko_search.gif" alt="가나다순 으로 찾기" /></h4>
			<ul id="koreanSerach_class">
				<c:forEach items="${koreanCodes}" var="koreanCode" varStatus="status">
					<li <c:if test="${koreanCode.code == 'C0351' }">class="selected"</c:if>>
						<a href="#" id="${koreanCode.code}" name="koreanCode" class="ko<ui:lpad length="2" padChar="0">${status.count}</ui:lpad>">
							<img src="${imageServer}/images/brand/text_ko<ui:lpad length="2" padChar="0">${status.count}</ui:lpad>.gif" alt="${koreanCode.codeName}"/>
						</a>
					</li>
				</c:forEach>
			</ul>
			<h4><img src="${imageServer}/images/brand/h4_en_search.gif" alt="알파벳순 으로 찾기" /></h4>
			<ul id="englishSerach_class">
				<c:forEach items="${englishCodes}" var="englishCode" varStatus="status">
					<li>
						<a href="#" id="${englishCode.code}" name="englishCode" class="en<ui:lpad length="2" padChar="0">${status.count}</ui:lpad>">
							<img src="${imageServer}/images/brand/text_en<ui:lpad length="2" padChar="0">${status.count}</ui:lpad>.gif" />
						</a>
					</li>
				</c:forEach>
			</ul>
		</div><!-- end main-text-search -->
		<div class="main-menu-sort" id="categorySerach_image">
			<ul>
                <li><a href="javascript://" name="categoryCode" id="0000"  ><img src="${imageServer}/images/renewal/gnb/menu_sort01_on.gif" alt="ALL" /></a></li>
                <li><a href="javascript://" name="categoryCode" id="000020"><img src="${imageServer}/images/renewal/gnb/menu_sort02_off.gif" alt="디자인문구" /></a></li>
                <li><a href="javascript://" name="categoryCode" id="000022"><img src="${imageServer}/images/renewal/gnb/menu_sort03_off.gif" alt="디지털" /></a></li>
                <li><a href="javascript://" name="categoryCode" id="000025"><img src="${imageServer}/images/renewal/gnb/menu_sort04_off.gif" alt="홈인테리어" /></a></li>
                <li><a href="javascript://" name="categoryCode" id="000024"><img src="${imageServer}/images/renewal/gnb/menu_sort05_off.gif" alt="가구" /></a></li>
                <li><a href="javascript://" name="categoryCode" id="000026"><img src="${imageServer}/images/renewal/gnb/menu_sort06_off.gif" alt="키친푸드" /></a></li>
                <li><a href="javascript://" name="categoryCode" id="000029"><img src="${imageServer}/images/renewal/gnb/menu_sort07_off.gif" alt="베이비/키즈" /></a></li>
                <li><a href="javascript://" name="categoryCode" id="000030"><img src="${imageServer}/images/renewal/gnb/menu_sort08_off.gif" alt="Pet" /></a></li>
                <li><a href="javascript://" name="categoryCode" id="000027"><img src="${imageServer}/images/renewal/gnb/menu_sort09_off.gif" alt="여행레저" /></a></li>
                <li><a href="javascript://" name="categoryCode" id="000028"><img src="${imageServer}/images/renewal/gnb/menu_sort10_off.gif" alt="패션/뷰티" /></a></li>
                <li><a href="javascript://" name="categoryCode" id="000023"><img src="${imageServer}/images/renewal/gnb/menu_sort11_off.gif" alt="키덜트" /></a></li>
                <li><a href="javascript://" name="categoryCode" id="000021"><img src="${imageServer}/images/renewal/gnb/menu_sort12_off.gif" alt="오피스" /></a></li>
			</ul>
		</div><!-- end main-menu-sort -->
		<div class="main-text-search-result">
			<p class="text"><img src="${imageServer}/images/brand/text_big_ko01.gif" alt="가" /></p>
			<ul>
				<c:forEach items="${brandNameList}" var="brandName">
					<li><a class="brandId" href="${brandName.id}">${brandName.koreanName}</a></li>
				</c:forEach>
			</ul>
		</div><!-- end main-text-search-result -->
	</div><!-- end search-body -->
	<p style="color:#fff;">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>></p>
	</div>
	<div class="popup-foot_02">
		<button type="button" onclick="self.close()"><img src="${imageServer}/images/popup/btn_close.gif" alt="닫기" /></button>
	</div><!-- end close-popup -->
</div><!-- end popup -->
</body>
</html>