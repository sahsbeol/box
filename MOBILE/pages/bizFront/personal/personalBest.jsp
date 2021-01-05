<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizFull"/>
<script>
var today = new Date();

var yyyy = today.getFullYear();
var mm = today.getMonth()+1;
var dd = today.getDate();
var hh = today.getHours();

function getTodayLabel() {
    
    var week = new Array('일', '월', '화', '수', '목', '금', '토');
    
    var today = new Date().getDay();
    var todayLabel = week[today];
    
    return todayLabel;
}

$(document).ready(function() {
	
	$('#bestListMore').click(function(){
			if($(this).hasClass("on")){
				$('[name=best_item]').hide();
				$(this).find("span").html('더보기');
				$(this).removeClass("on");
			}else{
				$('[name=best_item]').show();
				$(this).find("span").html('접기');
				$(this).addClass("on");
			}
	});

	$('[name=keyword]').click(function(){
		$('[name=keyword]').removeClass("active");
		$('[name=keyword]').find("span").removeClass("active");
		$(this).addClass("active");
		$(this).find("span").addClass("active");
		
		$fn.setRecobellSearchList();
	});
	
	tasteFn();
	
	$fn.setRecobellSearchList();
	
	$('#date1').text(mm+'/'+dd);
	$('#date2').text('('+getTodayLabel()+')');
	$('#date3').text(hh);
});

$fn = {
	setRecobellSearchList:function() {
		$.ajax({
			url: "/m/biz/personal/getRecobellSearchList"
			, data: {
				keyword : $('[name=keyword] .active').text()
			}
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
               	$('[name=keyItem]').empty();
               	
	            if (data) {
	                if(!isEmpty(data)) {
						var list = data.recobellSearchList;
						if(!isEmpty(list)) {
							for(var i=0; i < list.length; i++) {
								var append = '';
								append += '	<a href="/p/'+list[i].sellPrdtBcode+'?foo=bar&rccode=mo_taste4_4">';
								append += '		<div class="thum">';
								if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
			                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/music/large/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" >';
		                	    }else{
			                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
		                	    }
								append += '		</div>';
								append += '	</a>';
								
								$('[item'+i+']').append(append);
								
								if (i == 10)	break;
		                	}
						}
	                }
	            }
	        }
	        ,error: function(request, status, error) {
	            if(request.status != 0){
	                alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
	            }
	        }
	    });
	}
};
</script>	
</head>
<body>
	<!-- content -->
	<div id="content">
		<div class="personal_taste taste04">
			<div class="tab">
				<p>${userName}님을 위한 발견</p>
				<ul>
					<li><a href="/m/biz/personal/personalRecommend"><span>추천</span></a></li>
					<li><a href="/m/biz/personal/personalRecent"><span>최근,관심</span></a></li>
					<li><a href="/m/biz/personal/personalLike"><span>좋아요</span></a></li>
					<li class="active"><a href="/m/biz/personal/personalBest"><span>지금,인기</span></a></li>
				</ul>
			</div>
			<c:if test="${not empty bestList}">
				<div class="cont01">
					<h3>지금, 다른 사람들이<br/>가장 많이 보고 있어요!</h3>
					<div class="pd_list" id="bestList">
						<ul>
							<c:forEach items="${bestList}" var="list" varStatus="st" begin="0" end="19">
								<li <c:if test="${st.index > 5}">name="best_item" style="display:none;"</c:if>>
									<a href="/p/${list.sellPrdtBcode}?foo=bar&rccode=mo_taste4_1">
										<div class="thum">
											<c:if test="${list.sellPrdtGbn eq 'P' || list.sellPrdtGbn eq 'G' || list.sellPrdtGbn eq 'S'}"><ui:image src="${list.productImageUrl}" size="400" server="product" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
							                <c:if test="${list.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${list.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
							                <c:if test="${list.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${list.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
										</div>
										<div class="desc">
											<p class="tit">${list.prdtName}</p>
											<p class="price font_t">
												<fmt:parseNumber var="rate" type="number" value="${hfn:rate(list.prdtSellPrice,list.lastCpnPrice)}"/>
				                    			<fmt:parseNumber var="rate" type="number" value="${rate+(1-(rate%1))%1}" integerOnly="true"/>
												<fmt:formatNumber type="number">${list.lastCpnPrice}</fmt:formatNumber>
				                    			<c:if test="${rate > 0}"><span class="percent">${rate}%</span></c:if>
											</p>
										</div>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
					<c:if test="${fn:length(bestList) > 6}">
						<a href="#" onclick="javacript:event.preventDefault();" id="bestListMore" class="btn_more"><span>더보기</span></a>
					</c:if>
				</div>
			</c:if>
			
			<c:if test="${not empty eventList}">
				<div class="event_banner">
					<c:forEach items="${eventList}" var="list" varStatus="st">
						<c:if test="${st.first}">
							<a href="/m/biz/eventDetail?eventId=${list.eventId}&foo=bar&rccode=mo_taste4_2">
								<div class="img_wrap">
									<ui:image src="${list.imageUrl}" alt="${list.eventTitle}"/>
								</div>
								<c:if test="${list.stdDscntRate ne null}">
									<span class="font_t percent">${list.stdDscntRate}%</span>
								</c:if>
								<strong>${list.eventTitle}</strong>
									<p>${list.eventDtlCont}</p>
								<span class="date font_t"><ui:mask pattern="####.##.##">${list.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${list.eventEndDt}</ui:mask></span>
							</a>
						</c:if>
					</c:forEach>
				</div>
			</c:if>
			
			<c:if test="${not empty bestList2}">
				<div class="cont02">
					<h3>인기 행진!<br/>가장 많이 판매되고 있어요!</h3>
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<c:forEach items="${bestList2}" var="list" varStatus="st" begin="0" end="${fn:length(bestList2)}">
								<div class="swiper-slide">
									<a href="/p/${list.sellPrdtBcode}?foo=bar&rccode=mo_taste4_3">
										<div class="thum">
											<c:if test="${list.sellPrdtGbn eq 'P' || list.sellPrdtGbn eq 'G' || list.sellPrdtGbn eq 'S'}"><ui:image src="${list.productImageUrl}" size="400" server="product" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
							                <c:if test="${list.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${list.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
							                <c:if test="${list.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${list.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
										</div>
										<div class="desc">
											<p class="tit">${list.prdtName}</p>
											<p class="price font_t">
												<fmt:parseNumber var="rate" type="number" value="${hfn:rate(list.prdtSellPrice,list.lastCpnPrice)}"/>
				                    			<fmt:parseNumber var="rate" type="number" value="${rate+(1-(rate%1))%1}" integerOnly="true"/>
				                    			<c:if test="${rate > 0}"><span class="percent">${rate}%</span></c:if>
												<fmt:formatNumber type="number">${list.lastCpnPrice}</fmt:formatNumber>
											</p>
										</div>
									</a>
								</div>
							</c:forEach>
						</div>
	
						<!-- 스크롤바 -->
						<div class="swiper-scrollbar"></div>
					</div>
				</div>
			</c:if>
			<div class="cont03">
				<h3><span class="font_t" id="date1"></span><span id="date2"></span> <span class="font_t" id="date3"></span>시, 지금!</h3>
				<p>급상승 키워드</p>
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<c:forEach items="${keyList}" var="list" varStatus="i">
							<div name="keyword" class="swiper-slide <c:if test="${i.first}">active</c:if>" key="${list}"><a href="#" onclick="javacript:event.preventDefault();"><span <c:if test="${i.first}">class="active"</c:if>>${list}</span></a></div>
						</c:forEach>
					</div>
				</div>

				<div class="pd_list">
					<ul>
						<li>
							<div class="type01">
								<div class="cont cont_left" name="keyItem" item1>
								</div>
								<div class="cont cont_right" name="keyItem" item2 item3>
								</div>
							</div>
						</li>
						<li name="keyItem" item4>
						</li>
						<li>
							<div class="type01">
								<div class="cont cont_right" name="keyItem" item5 item6>
								</div>
								<div class="cont cont_left" name="keyItem" item7>
								</div>
							</div>
						</li>
						<li name="keyItem" item8>
						</li>
						<li>
							<div class="type02">
								<div class="cont" name="keyItem" item9>
								</div>
								<div class="cont" name="keyItem" item10>
								</div>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!--// content -->
</body>
<script type="text/javascript">
$(document).ready(function() {
	sideMenu(); //side menu
	footerFn(); //footer
});
</script>
</html>