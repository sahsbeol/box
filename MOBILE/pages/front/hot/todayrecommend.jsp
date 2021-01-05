<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn"%>
<html>
<head>
<script type="text/javascript">
	jQuery(function($) {
		$("#todayrecommend").addClass("active");

		var recobellRecentLen = '${fn:length(recobellRecentList)}';
		
		if(recobellRecentLen <= 1){
			$(".btn_more").hide();
		}else{
			btn_more();
		}
		
		getRecobellSubList($("[name=slidelist]").first());
		
		// 연관상품 열기	
		$("[name=subListBtn]").click(function(e) {
			var item = $(this).closest("[name=slidelist]");
			if (item.hasClass("active")) {
				item.removeClass("active");
				item.find(".cont_a").slideUp();
			} else {
				if(item.hasClass("first")){
					getRecobellSubList($(this).closest("[name=slidelist]"));
				}
				item.find(".cont_a").slideDown();
				item.addClass("active");
			}
		});
	});
	
	function btn_more(){
		if($(".btn_more").hasClass("active")){
			$("[name=recent]").each(function(index, item) {
		        if(index != 0){
		        	$(this).slideUp();
		        }
		    });
			$(".btn_more").html('더보기 +');
			$(".btn_more").removeClass("active");			
		}else{
			$("[name=recent]").slideDown();
			$(".btn_more").html('접기 -');
			$(".btn_more").addClass("active");
		}
	};
	
	function fn_slide(){
		$(".swiper-container").each(function(index, element){
		    var $this = $(this);
		    $this.addClass('instance-' + index);

		    var swiper = new Swiper('.instance-' + index, {
		        observer: true,
		        observeParents: true,
		        scrollbar: {
		            el: $('.instance-' + index).siblings('.swiper-scrollbar'),
		            hide: false,
		        },
		        watchOverflow: true
		    });
		});
	};
	
	function getRecobellSubList(item){
		var code = item.find('[name=subListBtn]').attr('code');
		$.ajax({
			url: "/m/hot/getRecobellSubList"
			, data: {code:code}
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
	        	var append = "";
	        	
	        	if(!isEmpty(data)) {
	        		var list = data.recobellSubList;
	        		var listLen = list.length >= 15 ? 15 : list.length;
	        		
	        		append += '<section class="todayre_s1_1 pbest_list">';
	        		append += '	<div class="swiper-container">';
	        		append += '		<div class="swiper-wrapper">';
	        		for(var i=0; i < Math.ceil(listLen/3); i++) {
	        			append += '	<div class="swiper-slide">';
		        		append += '		<div class="box_cont">';
		        		append += '			<div class="row">';
	        			for(var j=(i*3); j < (i*3)+3; j++) {
	        				if(j > listLen-1){
	        					append += '<div class="box_prod row_item">';
        						append += '    <p class="pic">';
	        					append += '     	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/resources/img/img_blank.png" alt="blank"/>';
	                            append += '    </p>';
	                         	append += '</div>';
	        				}else{
	        					append += '<a href="/p/'+list[j].sellPrdtBcode+'?foo=bar&rccode=mo_today2" return false;" class="box_prod row_item">';
		        				append += '		<p class="pic">';
		                	    if(list[j].sellPrdtGbn == 'R' || list[j].sellPrdtGbn == 'D'){
			                	    append += '			<img src="http://image.kyobobook.co.kr/newimages/music/midi/'+list[j].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[j].rcrdCd+'.jpg" alt="'+list[j].prdtName+'">';
		                	    }else{
			                	    append += '			<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[j].productImageUrl+'" alt="'+list[j].prdtName+'" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
		                	    }
		                	    append += '		</p>';
		        				append += '    <p class="tit">'+list[j].prdtName+'</p>';
		        				append += '    <p class="price">';
	       						append += 			list[j].lastCpnPrice+'원';
		        				append += '        <span class="sale">['+list[j].lastDcRate+'%]</span>';
		        				append += '    </p>';
		        				append += '</a>';
	        				}
		        		}
	        			append += '			</div>';
		        		append += '		</div>';
		        		append += '	</div>';
	        		}
	        		append += '		</div>';
	        		append += '	</div>';
	        		append += '</section>';
	        	}
	        	item.find(".cont_a").html(append);
	        	item.addClass("active");
	        	item.removeClass("first");
	        }
	        ,error: function(request, status, error) {
	            if(request.status != 0){
	                alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
	            }
	        }
	        , complete : function() {
	        	fn_slide();
	        }
	    });
	}
</script>
<style>
/* 충돌 */
#content {
	padding: 0px;
}
.customer {
    padding: 30px 10px;
}
/* common.css 통합 */
.bb_line {
	border-bottom: 16px solid #eee;
}

.bt_line {
	border-top: 16px solid #eee;
}

.tit_h3{
	font-size: 16px;
	font-weight: bold;
	color: #000;
}

.f14 {
	font-size: 14px !important;
}

.col_red {
	color: #da2128 !important;
}

.tb_line {
	border-bottom: 1px solid;
}

.pd10 {
	padding: 10px !important;
}

.pt20 {
	padding-top: 20px !important;
}

.pt30 {
	padding-top: 30px !important;
}

.pb20 {
	padding-bottom: 20px !important;
}

.ml10 {
	margin-left: 10px !important;
}

.ml20 {
	margin-left: 20px !important;
}

.mr10 {
	margin-right: 10px !important;
}

.mr20 {
	margin-right: 20px !important;
}

.mt20 {
	margin-top: 20px !important;
}

.mb30 {
	margin-bottom: 30px !important;
}

.line_th {
	text-decoration: line-through;
}

.box_flex {
	display: -webkit-box;
}

.box_flex * {
	-webkit-box-flex: 1;
	display: block;
}

.btn_guide {
	display: inline-block;
	width: 20px;
	height: 20px;
	text-align: center;
	background-color: #333;
	color: #fff;
	border-radius: 50%;
	float: right;
	font-size: 14px;
	padding: 1px;
	border: 1px solid #333;
}

.btn_guide_x {
	display: inline-block;
	width: 20px;
	height: 20px;
	text-align: center;
	background-color: #fff;
	color: #333;
	border-radius: 50%;
	float: right;
	font-size: 14px;
	padding: 1px;
	border: 1px solid #333;
	margin: -44px 0 0 0;
}

.br_black {
	border: 1px solid #000;
	background-color: #fff;
	color: #000;
}

.btn_area {
	padding: 0 10px;
	text-align: center;
}

.btn {
	height: 39px;
	text-align: center;
	font-size: 14px;
	font-weight: bold;
	line-height: 39px;
}

.pb_line_eee {
    border-bottom: 1px solid #eee;
}
/* content.css 통합 */
.dlvy_list {
    background-color: #fff;
    padding: 0 10px;
    margin: 0px;
    border: 0;
}

.dlvy_list .prod {padding:0px;}


.dlvy_list .prod dl {
	position: relative;
	min-height: 80px;
}

.dlvy_list .prod dl .pic {
	position: absolute;
	left: 0;
	top: 0;
	height: 100px;
    max-width: 100px;
    text-align: center;
    border: none;
}

.dlvy_list .prod dl .pic img {
	width: 100px;
	height: 100px;
	max-width: 100px;
	border-radius: 50%;
}

.dlvy_list .prod dl .pinfo {
    display: block;
    margin: 0px 0 0 120px;
}

.dlvy_list .prod dl .pinfo span.txt {
	font-weight: bold;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

.dlvy_list .prod dl .pinfo .price {
	margin-top: 10px;
}

.dlvy_list .prod dl .pinfo span {
	display: block;
	font-size: 14px;
}

.dlvy_list .prod dl .pinfo .price {
	margin-top: 10px;
}

.todayre_s4 .box_cont .box_prod .pic img {
	border-radius: 50%;
}
/* 레코벨 맞춤상품 카테고리 */
.pbest_list {
	position: relative;
	background-color: #fff;
}

.pbest_list .tit_mdspick {
	margin: 0 20px;
	padding-bottom: 5px;
	border-bottom: 1px solid #eee;
}

.pbest_list .tit_mdspick img {
	height: 19px;
	padding-bottom: 7px;
}

.pbest_list .box_cont {
	border: none;
	box-shadow: none;
	background-color: #fff;
	padding: 0 0 10px 0;
	background-color: #fff;
	margin: 0px;
}

.pbest_list .box_cont .raw+.raw {
	margin-top: 22px;
}

.pbest_list .row {
	display: -webkit-box;
}

.pbest_list .row .row_item {
    -webkit-box-flex: 1;
    display: block;
    width: 100%;
    margin: 10px 0 10px 6%;
}

.pbest_list .row .row_item .dvd img {
	width: 66%;
}

.pbest_list .swiper-container {
	overflow: hidden;
}

.pbest_list .swiper-container .swiper-wrapper {
	height: auto !important;
}

.pbest_list .swiper-container .swiper-wrapper .swiper-slide {
	position: relative;
	float: left;
	width: 100%;
	text-align: center;
	height: auto !important;
}

.pbest_list .swiper-container .swiper-wrapper .swiper-slide .tit {
	margin-top: 12px;
	font-size: 13px;
	color: #555;
}

.pbest_list .swiper-container .swiper-wrapper .swiper-slide .price {
	font-size: 13px;
	color: #000;
}

.pbest_list .swiper-container .swiper-wrapper .swiper-slide .price .sale
	{
	color: #f51d1d;
	margin-left: 5px;
}

.pbest_list .pagination {
	text-align: center;
	padding-bottom: 30px;
}

.pbest_list .pagination .swiper-pagination-switch {
	display: none;
	width: 10px;
	height: 10px;
	overflow: hidden;
	margin: 0 5px;
	background: #fff;
	border: 1px solid #000;
	border-radius: 50%;
}

.pbest_list .pagination .swiper-active-switch {
	background: #000;
}

.slidelist_a .btn_tit {
    display: block;
    padding: 0px 30px 10px 10px;
    font-size: 14px;
    font-weight: bold;
    background: url('http://image.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/btn_arrow_down02.png') calc(100% - 10px) center no-repeat #fff;
    background-size: 12px auto;
    display: block;
    text-align: right;
    background-position-y: 5px;
    border:0px;
}

.slidelist_a .active .btn_tit {
    background: url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/content/btn_arrow_up02.png') calc(100% - 10px) center no-repeat #fff;
    background-size: 12px auto;
    background-position-y: 5px;
    border-bottom: 1px solid #eee;
}

.btn_more {
    font-size: 14px;
    font-weight: bold;
    padding: 10px 0 10px 0;
    cursor: pointer;
    border-top: 1px solid #eee;
}

#recent_2 .dlvy_list, #recent_3 .dlvy_list, #recent_4 .dlvy_list, #recent_5 .dlvy_list{
	border-top: 16px solid #eee;
}

.clear {
    clear: both;
}
</style>
</head>
<body>
	<!--<div class="bb_line">
		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/page01.jpg" style="width:100%;" alt="ban_event">
	</div>-->
	
	<!-- 최근 본 상품 -->
	<div class="bb_line pt10">
		<div class="pd10 mt10">
			<c:choose>
				<c:when test="${recentIsNull eq 'Y'}"><h2 class="tit_h3">인기베스트 추천 상품</h2></c:when>
				<c:otherwise><h2 class="tit_h3">최근 본 상품</h2></c:otherwise>
			</c:choose>
		</div>
		<div class="dlvy_list_a">
			<c:forEach items="${recobellRecentList}" var="list" varStatus="st" begin="0" end="4">
				<div name="recent" <c:if test="${!st.first}">class="bt_line"</c:if>>
					<ul class="dlvy_list">
						<li class="prod pt10">
							<dl>
								<a href="#" onclick="location.href='/p/${list.sellPrdtBcode}?foo=bar&rccode=mo_today1';return false;">
									<dt class="pic">
										<c:if test="${list.sellPrdtGbn eq 'P' || list.sellPrdtGbn eq 'G'}"><ui:image src="${list.productImageUrl}" server="product" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
						                <c:if test="${list.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${list.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
						                <c:if test="${list.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${list.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
									</dt>
								</a>
								<dd class="pinfo">
									<span class="txt">${list.prdtName}</span> 
									<span class="price">
										<strong><fmt:formatNumber type="number">${list.lastCpnPrice}</fmt:formatNumber>원</strong>
										<fmt:parseNumber var="rate" type="number" value="${hfn:rate(list.prdtSellPrice,list.lastCpnPrice)}"/>
		                    			<fmt:parseNumber var="rate" type="number" value="${rate+(1-(rate%1))%1}" integerOnly="true"/>
		                    			<c:if test="${rate > 0}"><strong class="ml10 sale col_red">[${rate}%]</strong></c:if>
										<%-- <em class="ml10 line_th"><fmt:formatNumber type="number">${list.prdtSellPrice}</fmt:formatNumber></em> --%>
									</span>
								</dd>
							</dl>
						</li>
					</ul>
					
					<div class="slidelist_a">
						<div name="slidelist" class="first"><a href="#" onclick="javacript:event.preventDefault();" class="btn_tit" name="subListBtn" code="${list.sellPrdtBcode}"><span>연관 추천상품</span></a>
						<div class="cont_a">
							<%-- <c:if test="${recobellRecentIsNull ne 'Y'}">
								<fmt:parseNumber var="recobellRecentSubListLength" integerOnly="true" value="${fn:length(list.subList)}" />
								<fmt:parseNumber var="blankDataCheck" integerOnly="true" value="${recobellRecentSubListLength >= 15 ? 0 : recobellRecentSubListLength % 3}" />
							    <section class="todayre_s1_${st.count} pbest_list">
							        <div class="swiper-container">
							            <div class="swiper-wrapper">
								            <c:forEach begin="0" end="${recobellRecentSubListLength >= 14 ? 14 : recobellRecentSubListLength -1}" varStatus="s0" step="3">
								                <div class="swiper-slide">
								                    <div class="box_cont">
								                        <div class="row">
								                            <c:forEach items="${list.subList}" var="l" begin="${s0.index}" end="${s0.index+2}">
								                                <a href="#" onclick="location.href='/p/${l.sellPrdtBcode}?foo=bar&rccode=mo_today2';return false;" class="box_prod row_item">
								                                    <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}"><p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
								                                    <c:if test="${l.sellPrdtGbn eq 'R'}"><p class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
								                                    <c:if test="${l.sellPrdtGbn eq 'D'}"><p class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
								                                    <p class="tit">${l.prdtName}</p>
								                                    <p class="price">
								                                        <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>원
								                                        <fmt:parseNumber var="rate" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
								                                        <fmt:parseNumber var="rate" type="number" value="${rate+(1-(rate%1))%1}" integerOnly="true"/>
								                                        <c:if test="${rate > 0}"><span class="sale">[${rate}%]</span></c:if>
								                                    </p>
								                                </a>
								                            </c:forEach>
								                            <c:if test="${blankDataCheck != 0 && s0.last}">
								                            	<c:forEach begin="0" end="${2 - blankDataCheck}">
								                            		<div class="box_prod row_item">
										                                 <p class="pic">
										                                 <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/resources/img/img_blank.png" alt="blank"/>
										                                 </p>
										                             </div>
								                            	</c:forEach>
								                             </c:if>
								                        </div>
								                    </div>
								                </div>
								            </c:forEach>
							            </div>
							        </div>
							    </section>
							</c:if> --%>
						</div>
					</div>
				</div>
	        </div>
	        </c:forEach>
		</div>
		<div class="btn_area box_flex">
			<a href="javascript:btn_more();" class="btn_more active">더보기 +</a>
		</div>
	</div>
	<!-- / 최근 본 상품 -->
	
	<!-- 최근 검색어 추천상품 -->
	<c:if test="${not empty recobellSearchList}">
		<div class="bb_line">
			<div class="pd10 mt10">
				<h2 class="tit_h2">
					<c:if test="${empty recobellSearchKeyword}">
						<h2 class="tit_h3">인기 검색 추천상품</h2>
					</c:if>
					<c:if test="${not empty recobellSearchKeyword}">
						<h2 class="tit_h3">최근 검색어 추천상품</h2>
						<strong class="col_red fl_l mt5 f14"># ${recobellSearchKeyword}</strong>
					</c:if>
				</h2>
			</div>
			<fmt:parseNumber var="recobellSearchListLength" integerOnly="true" value="${fn:length(recobellSearchList)}" />
			<fmt:parseNumber var="blankDataCheck_search" integerOnly="true" value="${recobellSearchListLength >= 15 ? 0 : recobellSearchListLength % 3}" />
		    <section class="todayre_s2 pbest_list clear">
		        <div class="swiper-container">
		            <div class="swiper-wrapper">
			            <c:forEach begin="0" end="${recobellSearchListLength >= 14 ? 14 : recobellSearchListLength -1}" varStatus="s0" step="3">
			                <div class="swiper-slide">
			                    <div class="box_cont">
			                        <div class="row">
			                            <c:forEach items="${recobellSearchList}" var="l" begin="${s0.index}" end="${s0.index+2}">
			                                <a href="#" onclick="location.href='/p/${l.sellPrdtBcode}?foo=bar&rccode=mo_today3';return false;" class="box_prod row_item">
			                                    <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}"><p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
			                                    <c:if test="${l.sellPrdtGbn eq 'R'}"><p class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
			                                    <c:if test="${l.sellPrdtGbn eq 'D'}"><p class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
			                                    <p class="tit">${l.prdtName}</p>
			                                    <p class="price">
			                                        <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>원
			                                        <fmt:parseNumber var="rate" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
			                                        <fmt:parseNumber var="rate" type="number" value="${rate+(1-(rate%1))%1}" integerOnly="true"/>
			                                        <c:if test="${rate > 0}"><span class="sale">[${rate}%]</span></c:if>
			                                    </p>
			                                </a>
			                            </c:forEach>
			                            <c:if test="${blankDataCheck_search != 0 && s0.last}">
			                            	<c:forEach begin="0" end="${2 - blankDataCheck_search}">
			                            		<div class="box_prod row_item">
					                                 <p class="pic">
					                                 <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/resources/img/img_blank.png" alt="blank"/>
					                                 </p>
					                             </div>
			                            	</c:forEach>
			                             </c:if>
			                        </div>
			                    </div>
			                </div>
			            </c:forEach>
		            </div>
		        </div>
		    </section>
		</div>
	</c:if>
	<!-- / 최근 검색어 추천상품 -->
	
	<!-- 즐겨찾는 카테고리 -->
	<c:if test="${not empty recobellMyCtgrList}">
		<div class="bb_line">
			<div class="pd10 mt10">
				<h2 class="tit_h3">
					<h2 class="tit_h3">즐겨찾는 카테고리</h2>
				</h2>
			</div>
			<fmt:parseNumber var="recobellMyCtgrListLength" integerOnly="true" value="${fn:length(recobellMyCtgrList)}" />
			<fmt:parseNumber var="blankDataCheck_myCtgr" integerOnly="true" value="${recobellMyCtgrListLength >= 30 ? 0 : recobellMyCtgrListLength % 3}" />
			<section class="todayre_s3 pbest_list clear">
		        <div class="swiper-container">
		            <div class="swiper-wrapper">
			            <c:forEach begin="0" end="${recobellMyCtgrListLength >= 29 ? 29 : recobellMyCtgrListLength -1}" varStatus="s0" step="6">
			                <div class="swiper-slide">
			                    <div class="box_cont">
			                    	<c:forEach items="${recobellMyCtgrList}" varStatus="s1" begin="${s0.index}" end="${s0.index+5}" step="3">
				                        <div class="row">
				                            <c:forEach items="${recobellMyCtgrList}" var="l" begin="${s1.index}" end="${s1.index+2}">
				                                <a href="#" onclick="location.href='/p/${l.sellPrdtBcode}?foo=bar&rccode=mo_today4';return false;" class="box_prod row_item">
				                                    <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}"><p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
				                                    <c:if test="${l.sellPrdtGbn eq 'R'}"><p class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
				                                    <c:if test="${l.sellPrdtGbn eq 'D'}"><p class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
				                                    <p class="tit">${l.prdtName}</p>
				                                    <p class="price">
				                                        <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>원
				                                        <fmt:parseNumber var="rate" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
				                                        <fmt:parseNumber var="rate" type="number" value="${rate+(1-(rate%1))%1}" integerOnly="true"/>
				                                        <c:if test="${rate > 0}"><span class="sale">[${rate}%]</span></c:if>
				                                    </p>
				                                </a>
				                            </c:forEach>
					                        <c:if test="${blankDataCheck_myCtgr != 0 && s0.last && s1.last}">
				                            	<c:forEach begin="0" end="${2 - blankDataCheck_myCtgr}">
				                            		<div class="box_prod row_item">
						                                 <p class="pic">
						                                 <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/resources/img/img_blank.png" alt="blank"/>
						                                 </p>
						                             </div>
				                            	</c:forEach>
				                             </c:if>
				                        </div>
			                        </c:forEach>
			                    </div>
			                </div>
			            </c:forEach>
		            </div>
		        </div>
		    </section>
		</div>
	</c:if>
	<!-- /즐겨찾는 카테고리 -->
	
	<!-- 같이 보면 좋은상품 -->
	<c:if test="${not empty recobellCtgrList}">
		<div class="bb_line">
			<div class="pd10 mt10">
				<h2 class="tit_h3">같이 보면 좋은상품</h2>
			</div>
			<fmt:parseNumber var="recobellCtgrListLength" integerOnly="true" value="${fn:length(recobellCtgrList)}" />
			<fmt:parseNumber var="blankDataCheck_ctgr" integerOnly="true" value="${recobellCtgrListLength >= 15 ? 0 : recobellCtgrListLength % 3}" />
		    <section class="todayre_s4 pbest_list">
		        <div class="swiper-container">
		            <div class="swiper-wrapper">
			            <c:forEach begin="0" end="${recobellCtgrListLength >= 14 ? 14 : recobellCtgrListLength -1}" varStatus="s0" step="3">
			                <div class="swiper-slide">
			                    <div class="box_cont">
			                        <div class="row">
			                            <c:forEach items="${recobellCtgrList}" var="l" begin="${s0.index}" end="${s0.index+2}">
			                                <a href="#" onclick="location.href='/p/${l.sellPrdtBcode}?foo=bar&rccode=mo_today5';return false;" class="box_prod row_item">
			                                    <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}"><p class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
			                                    <c:if test="${l.sellPrdtGbn eq 'R'}"><p class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
			                                    <c:if test="${l.sellPrdtGbn eq 'D'}"><p class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></p></c:if>
			                                    <p class="tit">${l.prdtName}</p>
			                                    <p class="price">
			                                        <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>원
			                                        <fmt:parseNumber var="rate" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
			                                        <fmt:parseNumber var="rate" type="number" value="${rate+(1-(rate%1))%1}" integerOnly="true"/>
			                                        <c:if test="${rate > 0}"><span class="sale">[${rate}%]</span></c:if>
			                                    </p>
			                                </a>
			                            </c:forEach>
			                            <c:if test="${blankDataCheck_ctgr != 0 && s0.last}">
			                            	<c:forEach begin="0" end="${2 - blankDataCheck_ctgr}">
			                            		<div class="box_prod row_item">
					                                 <p class="pic">
					                                 <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/resources/img/img_blank.png" alt="blank"/>
					                                 </p>
					                             </div>
			                            	</c:forEach>
			                             </c:if>
			                        </div>
			                    </div>
			                </div>
			            </c:forEach>
		            </div>
		        </div>
		    </section>
		</div>
	</c:if>
	<!-- / 연관 카테고리 추천상품 -->
	
	<!-- 무료배송 배너 -->
	<div class="bb_line">
		<a href="/m/hot/best?dispMstrId=FREE_DELIVERY_BEST&ctgrId=1">
			<img style="width:100%;" class="MB_TODAY_1" src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/bnr_freedelivery.png" alt="무료배송">
		</a>
	</div>
	
</body>
</html>