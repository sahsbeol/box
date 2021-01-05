<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<head>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="none"/>
<html>
<head>

</head>
<body>
<script type="text/javascript">
	$(document).ready(function() {
		var date = new Date();

		var yy = date.getFullYear();
		var mm = date.getMonth()+1;
		var dd = date.getDate();

		var hh = date.getHours();

		if((mm+"").length < 2){
			mm = "0"+mm;
		}

		if((dd+"").length < 2){
			dd = "0"+dd;
		}
		$('#searchTime').html(yy+'.'+mm+'.'+dd+' '+hh+':00');
		searchFn(); //search
	});
	
	function gnbSrchFrm(){
	    var frm = $("form[name=gnbSearchFrm]");
	
	    if($.trim(frm.find("input[name=searchTerm]").val()) == ""){
	        alert("검색어를 입력해주세요");
	        return false;
	    }
	    frm.submit();
	}
	function rmRcntKerword(rcntKeySeq, id){
	    $.ajax({
	        type: "GET"
	        , url: "/m/search/rmRecentKeyword"
	        , data: "rcntKeySeq=" + rcntKeySeq
	        , dataType: "json"
	        , success: function(data) {
	            $(id).slideUp();
	            setTimeout(function(){
	            	if ($(".cont03 #keyWord li:visible").length == 0  ) {
		            	$(".cont03").append("<div class='none'>최근 검색어가 없습니다</div>");
	 						
					}
	            }, 500);
	            
			
	        }
	        , error: function() {
	            //alert("<fmt:message key='error.common.system'/>");
	        }
	    });
	}
	function rmRecentKeywordAll(){
	    $.ajax({
	        type: "GET"
	        , url: "/m/biz/search/rmRecentKeywordAll"
	        , dataType: "json"
	        , success: function(data) {
	        	$(".cont03 ul").html("");
            	if ($(".cont03 #keyWord li:visible").length == 0 && $(".cont03 .none").length == 0) {
	            	$(".cont03").append("<div class='none'>최근 검색어가 없습니다</div>");
 						
				}
	        }
	        , error: function() {
	        }
	    });
	}
	
	function gnbSrchKerword(keyword){
	    if($("form[name=gnbSearchFrm]").length < 1){
	        _search(keyword);
	    }else{
	        
	        $("form[name=gnbSearchFrm] input[name=searchTerm]").val(keyword);
	        gnbSrchFrm();
	    }
	}
</script>
<form name="gnbSearchFrm" action="${defaultHost}/m/biz/search/searchMain" method="get">
<div id="search_menu">
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<div class="search_cont">
						<c:if test="${not empty curtainBnr}">
						<div class="top_banner MB_MAIN_TOP_1_1" style="background:#8971ff;" onclick="location.href='${curtainBnr.bnrLinkUrl}'" >
						<ui:image src="${curtainBnr.imageUrlMo}" alt="${fn:escapeXml(curtainBnr.imageAlt)}"/>
						</div>
						</c:if>
						<div class="search_top">
						    <div class="inner">
								<div class="input_wrap">
									<input type="text" class="s_input" name="searchTerm" value="" placeholder="검색어를 입력하세요" title="검색어를 입력하세요" autocomplete="off"/>
									<span class="input_clear hidden">삭제</span>
								</div>
						    </div>
							<a href="javascript:" class="btn_back">뒤로가기</a>
							<a href="javascript:" onclick="gnbSrchFrm();return false;"  class="btn_search MB_MAIN_TOP_1_2"><span>검색</span></a>
						</div>
						
						<div class="search_wrap">
							<div class="search_list">
								<div class="swiper-container">
									<div class="swiper-wrapper">
										<div class="swiper-slide">
											<div class="cont cont01">
												<h5>인기 검색어</h5>
												<ul>
													<c:forEach items="${listKeywordBest}" var="l" varStatus="st">
													<li class="MB_MAIN_TOP_1_3">
														<a href="javascript:" onclick="gnbSrchKerword('${l.keyword}');return false;">
															<em class="font_t">${st.count}</em>
															<p>${l.keyword}</p>
															<!-- ▲ up , ▼ down : class 추가 -->
															<c:choose>
																<c:when test="${l.prevRank == 0}">
																	<span class="new"><strong>NEW</strong></span>
																</c:when>
																<c:when test="${(l.prevRank - l.ranking) == 0}">
																	<span>-</span>
																</c:when>
																<c:when test="${l.prevRank < l.ranking}">
																	<span class="num down">${(l.prevRank - l.ranking) * -1}</span>
																</c:when>
																<c:otherwise>
																	<span class="num up">${l.prevRank - l.ranking}</span>
																</c:otherwise>
															</c:choose>
														</a>
													</li>
													</c:forEach>
												</ul>
											</div>
											<p class="txt"><span class="font_t" id="searchTime">2019.11.11 11:00</span> 기준</p>
										</div>
										<div class="swiper-slide">
											<div class="cont cont02">
												<h5>추천 검색어</h5>
												<ul>
												<c:forEach items="${listKeywordPick}" var="l" varStatus="st">
													<li class="MB_MAIN_TOP_1_4">
														<a href="javascript:" onclick="gnbSrchKerword('${l.keyword}');return false">
															<em class="font_t">${st.count}</em>
															<p>${l.keyword}</p>
														</a>
													</li>
												</c:forEach>
												</ul>
											</div>
										</div>
										<div class="swiper-slide">
											<div class="cont cont03">
												<h5>최근 검색어</h5>
												<c:if test="${fn:length(listKeywordRecent) != 0}">
												<ul id="keyWord">
												<c:forEach items="${listKeywordRecent}" var="l" varStatus="st">
													<li id="lyRcntItem${l.rcntKeySeq}" class="MB_MAIN_TOP_1_5">
														<a href="javascript:" onclick="gnbSrchKerword('${l.keyword}');return false;">${l.keyword}</a>
														<a href="javascript:" onclick="rmRcntKerword('${l.rcntKeySeq}', '#lyRcntItem${l.rcntKeySeq}');return false;" class="btn_delete">삭제</a>
													</li>
												</c:forEach>
												</ul>
												</c:if>
												<!-- 검색어 없는 경우 -->
<!-- 												<script type="text/javascript"> -->
<%-- 												alret("${fn:length(listKeywordRecent)}"); --%>
<!-- 												</script> -->
												<c:if test="${fn:length(listKeywordRecent) == 0 }">
												<div class="none">
													최근 검색어가 없습니다
												</div>
												</c:if>
												<!--// 검색어 없는 경우 -->
											</div>
											<div class="btn_wrapper">
												<a href="javascript:" class="btn_delete_all" onclick="rmRecentKeywordAll();">전체삭제</a>
											</div>
										</div>
									</div>
									<div class="swiper-pagination"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>
</body>
</html>