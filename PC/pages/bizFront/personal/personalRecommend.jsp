<%@page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="htNoQuick"/>
<!DOCTYPE ui:decorator PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
$(document).ready(function(){
	$("#gnbPersonalRecommend").addClass("on");
	gnb();//gnb
	nav();//nav
	if($('.header_wrap').length >0){
		bodyScroll();//body scroll
	}
	tasteFn();//taste
	
	$('#brand_list li').click(function(e){
		$('#brand_list li').removeClass("active");
		$(this).addClass("active");
		$('.btn_more').find("span").html('더보기');
		$('.btn_more').removeClass("on");
		
		$fn.setRecobellBrandList();
    });

	$('.btn_more').click(function(e){
		if($(this).hasClass("on")){
			$('[name=brand_item]').hide();
			$(this).find("span").html('더보기');
			$(this).removeClass("on");
		}else{
			$('[name=brand_item]').show();
			$(this).find("span").html('접기');
			$(this).addClass("on");
		}
    });
	
	$fn.setRecobellBrandList();
});

$fn = {
	setRecobellBrandList:function() {
		$.ajax({
			url: "/ht/biz/personal/getRecobellBrandList"
			, data: {
				brandId : $('#brand_list .active').attr("brandId")
			}
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
	        	var append = '';
               	$('#recobellBrandList').empty();
	        	
                if(!isEmpty(data)) {
					var list = data.recobellBrandList;

					if(!isEmpty(list)) {
						for(var i=0; i < list.length; i++) {
							if(i < 4){
								append += '<li>';
							}else{
								append += '<li name="brand_item" style="display:none;">';
							}
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
	                	    	append += '			<a href="/ht/record/detail/'+list[i].sellPrdtBcode+'?foo=bar&rccode=pc_taste1_3">';
	                	    }else{
	                	    	append += '			<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'&foo=bar&rccode=pc_taste1_3">';
	                	    }
							append += '		<div class="thum">';
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
	                	    	append += '			<img src="http://image.kyobobook.co.kr/newimages/music/large/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
	                	    }else{
	                	    	append += '			<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].prdtImgUrl+'" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
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
							
							if (i == 19)	break;
	                	}
					}
					
					$('#recobellBrandList').html(append);
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
<style>
#container .content {width: 100%;}
</style>
</head>
<body>
	<!-- 컨텐츠 -->
	<div class="content personal_taste taste01" id="content">
		<div class="taste_top">
			<div class="inner950">
				<h3>개인의 취향</h3>
				<p>${userName}님을 위한 발견</p>
				<ul>
					<li class="active"><a href="/ht/biz/personal/personalRecommend"><span>추천</span></a></li>
					<li><a href="/ht/biz/personal/personalRecent"><span>최근,관심</span></a></li>
					<li><a href="/ht/biz/personal/personalLike"><span>좋아요</span></a></li>
					<li><a href="/ht/biz/personal/personalBest"><span>지금,인기</span></a></li>
				</ul>
			</div>
		</div>
		<c:if test="${not empty bestList}">
			<div class="cont01">
				<h3>혹시, 이 상품은 어떠세요?</h3>
				<p class="txt">최근 쇼핑 이력을 분석하여 현재 관심 있을만한 상품과 기획전을 추천드려요.</p>
				<c:if test="${fn:length(bestList) eq 1}">
					<div class="pd_one">
				</c:if>
				<c:if test="${fn:length(bestList) ne 1}">
					<div class="taste_slide">
				</c:if>
					<ul>
						<!-- 품절시 sold_out : class 추가 -->
						<c:forEach items="${bestList}" var="list" varStatus="st" begin="0" end="${fn:length(bestList)}">
							<c:if test="${fn:length(bestList) ne 1}">
								<li>
							</c:if>
								<c:if test="${list.sellPrdtGbn eq 'R' || list.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${list.sellPrdtBcode}?foo=bar&rccode=pc_taste1_1"></c:if>
	                            <c:if test="${list.sellPrdtGbn eq 'P' || list.sellPrdtGbn eq 'G' || list.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${list.sellPrdtBcode}&foo=bar&rccode=pc_taste1_1"></c:if>
									<div class="thum">
										<c:if test="${list.sellPrdtGbn eq 'R' || list.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${list.rcrdCd}" prdtGbn="${list.sellPrdtGbn}" ratingCode="A" rcrdImgType="large" width="${list.sellPrdtGbn eq 'R'?'150':'99'}" clazz="photo" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
	                            		<c:if test="${list.sellPrdtGbn eq 'P' || list.sellPrdtGbn eq 'G' || list.sellPrdtGbn eq 'S'}"><ui:image src="${list.prdtImgUrl}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
									</div>
									<div class="cont">
										<p class="tit">${list.prdtName}</p>
										<p class="price font_t">
			                    			<c:if test="${list.lastDcRate > 0}"><span class="percent">${list.lastDcRate}%</span></c:if>
											<span><fmt:formatNumber type="number">${list.lastCpnPrice}</fmt:formatNumber></span>
										</p>
									</div>
								</a>
							<c:if test="${fn:length(bestList) ne 1}">
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</div>
		</c:if>
		<c:if test="${not empty eventList}">
			<div class="cont02">
				<div class="taste_slide02">
					<ul>
						<c:forEach items="${eventList}" var="list" varStatus="st" begin="0" end="${fn:length(eventList)}">
							<li>
								<a href="/ht/biz/eventDetail?eventId=${list.eventId}&foo=bar&rccode=pc_taste1_2">
									<c:if test="${list.stdDscntRate ne null}">
										<span class="font_t percent">${list.stdDscntRate}%</span>
									</c:if>
									<!-- 컬처이벤트의 경우 class 추가 culture -->
									<div class="thum <c:if test="${list.cultZoneYn eq 'Y'}">culture</c:if>">
										<ui:image src="${list.imageUrl}" alt="${list.eventTitle}"/>
									</div>
									<strong>${list.eventTitle}</strong>
									<p>${list.eventDtlCont}</p>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</c:if>

		<div class="cont03">
			<h3>${userName}님, 이 브랜드는 어떠세요?</h3>
			<p class="txt">최근 쇼핑 이력을 분석하여 현재 관심 있을만한 상품과 기획전을 추천드려요.</p>
			<div class="pd_tab">
				<ul id="brand_list">
					<c:forEach items="${brandList}" var="list" varStatus="st" begin="0" end="4">
						<li brandId="${list.brandId}" <c:if test="${st.first}">class="active"</c:if>><a href="#" onclick="javacript:event.preventDefault();"><span>${list.brandName}</span></a></li>
					</c:forEach>
					<c:if test="${empty brandList}">
						<li class="active" brandId="91779"><a href="#" onclick="javacript:event.preventDefault();"><span>로이텀</span></a></li>
						<li brandId="29908"><a href="#" onclick="javacript:event.preventDefault();"><span>세레스홈</span></a></li>
						<li brandId="27639"><a href="#" onclick="javacript:event.preventDefault();"><span>드레텍</span></a></li>
						<li brandId="14975"><a href="#" onclick="javacript:event.preventDefault();"><span>라미</span></a></li>
						<li brandId="30547"><a href="#" onclick="javacript:event.preventDefault();"><span>마리슈타이거</span></a></li>
					</c:if>
				</ul>
			</div>
			<div class="pd_list">
				<ul id="recobellBrandList">
				</ul>
			</div>
			<div class="btn_wrapper">
				<a href="#" onclick="javacript:event.preventDefault();" class="btn_more"><span>더보기</span></a>
			</div>
		</div>
	</div>
	<!-- // 컨텐츠 -->
</body>
</html>