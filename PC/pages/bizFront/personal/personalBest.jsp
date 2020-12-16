<%@page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="htNoQuick"/>
<!DOCTYPE ui:decorator PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
var today = new Date();

var mm = today.getMonth()+1;
var dd = today.getDate();
var hh = today.getHours();

if(dd<10) {
    dd='0'+dd
} 

if(mm<10) {
    mm='0'+mm
} 

$(document).ready(function(){
	gnb();//gnb
	nav();//nav
	if($('.header_wrap').length >0){
		bodyScroll();//body scroll
	}
	
	tasteFn();//taste
	
	$('#bestListMore').click(function(){
		$('#bestList li').show();
		$('#bestListMore').hide();
	});
	
	$('.btn_more').click(function(e){
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
	
	$('.keyword_slide').on('afterChange', function(event, slick, currentSlide, nextSlide){
		$fn.setRecobellSearchList($('.slick-current').attr('st'));
	});
	
	$fn.setRecobellSearchList($(".slide-item :eq(0)").attr('st'));
	
	$('#date1').text(mm);
	$('#date2').text(dd);
	$('#date3').text(hh);
	
});

$fn = {
	setRecobellSearchList:function(st) {
		$.ajax({
			url: "/ht/biz/personal/getRecobellSearchList"
			, data: {
				keyword : st
			}
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
	        	var setArea = '';
	        	var append = '';
	        	$('#SearchListArea').empty();
	        	
	        	setArea += '<div class="taste_slide">';
	        	setArea += '	<ul id="recobellSearchList">';
	        	setArea += '	</ul>';
	        	setArea += '</div>';
				
				$('#SearchListArea').html(setArea);
				
	            if (data) {
	                if(!isEmpty(data)) {
						var list = data.recobellSearchList;
						if(!isEmpty(list)) {
							for(var i=0; i < list.length; i++) {
								append += '<li>';
								if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
		                	    	append += '			<a href="/ht/record/detail/'+list[i].sellPrdtBcode+'?foo=bar&rccode=pc_taste4_4">';
		                	    }else{
		                	    	append += '			<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'&foo=bar&rccode=pc_taste4_4">';
		                	    }
								append += '		<div class="thum">';
								if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
		                	    	append += '			<img src="http://image.kyobobook.co.kr/newimages/music/midi/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
		                	    }else{
		                	    	append += '			<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/200/'+list[i].prdtImgUrl+'" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
		                	    }
								append += '		</div>';
								append += '		<div class="cont">';
								append += '			<p class="tit">'+list[i].prdtName+'</p>';
								append += '			<p class="price font_t">';
								if(list[i].lastDcRate != 0){
			                	    append += '				<span class="percent">'+list[i].lastDcRate+'%</span>';
		                	    }
								append += '				<span>'+price_format(list[i].lastCpnPrice)+'</span>';
								append += '			</p>';
								append += '		</div>';
								append += '	</a>';
								append += '</li>';
		                	}
						}
						
						$('#recobellSearchList').html(append);
	                }
	            }
	        }
			,complete: function() {
				$('.personal_taste.taste04 .cont04 .taste_slide ul').bxSlider({
					auto: false,
					pause: 3000,
					speed: 1000,
					hideControlOnEnd: true,
					minSlides: 4,
					maxSlides: 4,
			        slideWidth: 230,
					slideMargin: 10,
					infiniteLoop: false,
					touchEnabled: false,
					pager: true,
					pagerType: 'short',
					pagerShortSeparator: '',
				});
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
<style>
#container .content {width: 100%;}
</style>
</head>
<body>
	<!-- 컨텐츠 -->
	<div class="content personal_taste taste04" id="content">
		<div class="taste_top">
			<div class="inner950">
				<h3>개인의 취향</h3>
				<p>${userName}님을 위한 발견</p>
				<ul>
					<li><a href="/ht/biz/personal/personalRecommend"><span>추천</span></a></li>
					<li><a href="/ht/biz/personal/personalRecent"><span>최근,관심</span></a></li>
					<li><a href="/ht/biz/personal/personalLike"><span>좋아요</span></a></li>
					<li class="active"><a href="/ht/biz/personal/personalBest"><span>지금,인기</span></a></li>
				</ul>
			</div>
		</div>
		
		<c:if test="${not empty bestList}">
			<div class="cont01">
				<h3>지금, 다른 사람들이 가장 많이 보고 있어요!</h3>
				<div class="pd_list col03">
					<ul id="bestList">
						<c:forEach items="${bestList}" var="list" varStatus="st" begin="0" end="19">
							<li <c:if test="${st.count > 6}">name="best_item" style="display:none;"</c:if>>
								<c:if test="${list.sellPrdtGbn eq 'R' || list.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${list.sellPrdtBcode}?foo=bar&rccode=pc_taste4_1" code="${list.sellPrdtBcode}"></c:if>
	                            <c:if test="${list.sellPrdtGbn eq 'P' || list.sellPrdtGbn eq 'G' || list.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${list.sellPrdtBcode}&foo=bar&rccode=pc_taste4_1" code="${list.sellPrdtBcode}"></c:if>
									<div class="thum">
										<c:if test="${list.sellPrdtGbn eq 'R' || list.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${list.rcrdCd}" prdtGbn="${list.sellPrdtGbn}" ratingCode="A" rcrdImgType="large" width="${list.sellPrdtGbn eq 'R'?'150':'99'}" clazz="photo" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
	                            		<c:if test="${list.sellPrdtGbn eq 'P' || list.sellPrdtGbn eq 'G' || list.sellPrdtGbn eq 'S'}"><ui:image src="${list.productImageUrl}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
									</div>
									<div class="cont">
										<p class="tit">${list.prdtName}</p>
										<p class="price font_t">
			                    			<c:if test="${list.lastDcRate > 0}"><span class="percent">${list.lastDcRate}%</span></c:if>
											<span><fmt:formatNumber type="number">${list.lastCpnPrice}</fmt:formatNumber></span>
										</p>
									</div>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
				<div class="btn_wrapper">
					<a href="#" onclick="javacript:event.preventDefault();" class="btn_more"><span>더보기</span></a>
				</div>
			</div>
		</c:if>

		<c:if test="${not empty eventList}">
			<div class="cont02">
				<div class="event_banner">
					<c:forEach items="${eventList}" var="list" varStatus="st">
						<c:if test="${st.first}">
							<a href="/ht/biz/eventDetail?eventId=${list.eventId}&foo=bar&rccode=pc_taste4_2">
							    <!-- 컬처이벤트의 경우 class 추가 culture -->
								<div class="img_wrap <c:if test="${list.cultZoneYn eq 'Y'}">culture</c:if>">
									<ui:image src="${list.imageUrl}" alt="${list.eventTitle}"/>
								</div>
								<div class="cont">
									<c:if test="${list.stdDscntRate ne null}">
										<span class="font_t percent">${list.stdDscntRate}%</span>
									</c:if>
									<strong>${list.eventTitle}</strong>
									<p>${list.eventDtlCont}</p>
									<span class="date font_t"><ui:mask pattern="####.##.##">${list.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${list.eventEndDt}</ui:mask></span>
								</div>
							</a>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</c:if>

		<c:if test="${not empty bestList2}">
			<div class="cont03">
				<h3>인기 행진! 가장 많이 판매되고 있어요!</h3>
				<div class="taste_slide">
					<ul>
						<c:forEach items="${bestList2}" var="list" varStatus="st" begin="0" end="${fn:length(bestList2)}">
							<li>
								<c:if test="${list.sellPrdtGbn eq 'R' || list.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${list.sellPrdtBcode}?foo=bar&rccode=pc_taste4_3" code="${list.sellPrdtBcode}"></c:if>
	                            <c:if test="${list.sellPrdtGbn eq 'P' || list.sellPrdtGbn eq 'G' || list.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${list.sellPrdtBcode}&foo=bar&rccode=pc_taste4_3" code="${list.sellPrdtBcode}"></c:if>
									<div class="thum">
										<c:if test="${list.sellPrdtGbn eq 'R' || list.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${list.rcrdCd}" prdtGbn="${list.sellPrdtGbn}" ratingCode="A" rcrdImgType="large" width="${list.sellPrdtGbn eq 'R'?'150':'99'}" clazz="photo" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
	                            		<c:if test="${list.sellPrdtGbn eq 'P' || list.sellPrdtGbn eq 'G' || list.sellPrdtGbn eq 'S'}"><ui:image src="${list.productImageUrl}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
									</div>
									<div class="cont">
										<p class="tit">${list.prdtName}</p>
										<p class="price font_t">
			                    			<c:if test="${list.lastDcRate > 0}"><span class="percent">${list.lastDcRate}%</span></c:if>
											<span><fmt:formatNumber type="number">${list.lastCpnPrice}</fmt:formatNumber></span>
										</p>
									</div>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</c:if>
		<div class="cont04">
			<div class="txt">
				<p class="time"><span id="date1"></span><span id="date2"></span><span id="date3"></span>시</p>
				<h5>급상승키워드</h5>
			</div>
			<div class="bg_wrap">
				<div class="bg" style="background-image:url('/images/biz/thums/img_taste05.png');"></div>
			</div>
			<div class="keyword_slide">
				<c:forEach items="${keyList}" var="list" varStatus="i">
					<div class="slide-item" st="${list}"><a href="#" onclick="javacript:event.preventDefault();"><em class="font_t">${i.count}</em>${list}</a></div>
				</c:forEach>
			</div>
			<div id="SearchListArea">
				<div class="taste_slide">
					<ul id="recobellSearchList">
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- // 컨텐츠 -->
</body>
</html>