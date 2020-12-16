<%@page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="htNoQuick"/>
<!DOCTYPE ui:decorator PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
$(document).ready(function(){
	gnb();//gnb
	nav();//nav
	if($('.header_wrap').length >0){
		bodyScroll();//body scroll
	}
	tasteFn();//taste
	
	$('[name=brand]').click(function(){
		$('[name=brand]').removeClass("active");
		$('[name=brand]').find("span").removeClass("active");
		$(this).addClass("active");
		$(this).find("span").addClass("active");
		
		$fn.setRecobellBrandList();
	});
	
	$fn.setRecobellBrandList();
});

$fn = {
	setRecobellBrandList:function() {
		var brandId = $('[name=brand] .active').attr("brandId");
		
		$.ajax({
			url: "/ht/biz/personal/getRecobellBrandList"
			, data: {
				brandId : brandId
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
							append += '<li code='+list[i].sellPrdtBcode+'>';
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
	                	    	append += '			<a href="/ht/record/detail/'+list[i].sellPrdtBcode+'?foo=bar&rccode=pc_taste3_2">';
	                	    }else{
	                	    	append += '			<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'&foo=bar&rccode=pc_taste3_2">';
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
							
							if (i == 3)	break;
	                	}
					}
					
					$('#recobellBrandList').html(append);
                }
	        }
			,complete: function() {
				$fn.setRecobellEventList();
	        }
	        ,error: function(request, status, error) {
	            if(request.status != 0){
	                alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
	            }
	        }
	    });
	}
	, setRecobellEventList:function() {
		var code = $('#recobellBrandList li').attr('code');
		
		$.ajax({
			url: "/ht/biz/personal/getRecobellEventList"
			, data: {
				code : code
			}
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
	        	var append = '';
               	$('#recobellEventList').empty();
	        	
                if(!isEmpty(data)) {
					var list = data.eventList;
					if(!isEmpty(list)) {
						var cultZoneYn = '';
						if(list[0].cultZoneYn == 'Y'){
							cultZoneYn = 'culture';
						}
						
						append += '<a href="/ht/biz/eventDetail?eventId='+list[0].eventId+'&foo=bar&rccode=pc_taste3_3">';
						append += '	<div class="img_wrap '+cultZoneYn+'">';
						append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/'+list[0].imageUrl+'" alt="'+list[0].eventTitle+'">';
						append += '	</div>';
						append += '	<div class="cont">';
						if(!isEmpty(list[0].stdDscntRate)){
							append += '	<span class="font_t percent">'+list[0].stdDscntRate+'%</span>';
						}
						append += '		<strong>'+list[0].eventTitle+'</strong>';
						append += '		<p>'+list[0].eventDtlCont+'</p>';
						append += '		<span class="date font_t">'+list[0].eventStartDt.replace(/(\d{4})(\d{2})(\d{2})/, '$1.$2.$3')+' ~ '+list[0].eventEndDt.replace(/(\d{4})(\d{2})(\d{2})/, '$1.$2.$3')+'</span>';
						append += '	</div>';
						append += '</a>';
					}
					
					$('#recobellEventList').html(append);
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
	<div class="content personal_taste taste03" id="content">
		<div class="taste_top">
			<div class="inner950">
				<h3>개인의 취향</h3>
				<p>${userName}님을 위한 발견</p>
				<ul>
					<li><a href="/ht/biz/personal/personalRecommend"><span>추천</span></a></li>
					<li><a href="/ht/biz/personal/personalRecent"><span>최근,관심</span></a></li>
					<li class="active"><a href="/ht/biz/personal/personalLike"><span>좋아요</span></a></li>
					<li><a href="/ht/biz/personal/personalBest"><span>지금,인기</span></a></li>
				</ul>
			</div>
		</div>
		<c:if test="${not empty wishList}">
			<div class="cont01">
				<h3>찜한 상품을 잊지 않으셨나요?</h3>
				<c:if test="${fn:length(wishList) eq 1}">
					<div class="pd_one">
				</c:if>
				<c:if test="${fn:length(wishList) ne 1}">
					<div class="taste_slide">
				</c:if>
					<ul>
						<c:forEach items="${wishList}" var="list" varStatus="st" begin="0" end="19">
							<c:if test="${fn:length(wishList) ne 1}">
								<li>
							</c:if>
								<c:if test="${list.sellPrdtGbn eq 'R' || list.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${list.sellPrdtBcode}?foo=bar&rccode=pc_taste3_1" code="${list.sellPrdtBcode}"></c:if>
	                            <c:if test="${list.sellPrdtGbn eq 'P' || list.sellPrdtGbn eq 'G' || list.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${list.sellPrdtBcode}&foo=bar&rccode=pc_taste3_1" code="${list.sellPrdtBcode}"></c:if>
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
							<c:if test="${fn:length(wishList) ne 1}">
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</div>
		</c:if>
		<div class="cont02">
			<div class="inner950">
				<h3>관심 브랜드의 소식을 놓치지 마세요!</h3>
				<div class="tab">
					<ul>
						<c:forEach items="${brandList}" var="list" varStatus="st" end="4">
							<li name="brand" <c:if test="${st.first}">class="active"</c:if>><a href="#" onclick="javacript:event.preventDefault();"><span <c:if test="${st.first}">class="active"</c:if> brandId="${list.brandId}">${list.brandKorName}</span></a></li>
						</c:forEach>
						<c:if test="${empty brandList}">
							<li name="brand" class="swiper-slide active"><a href="#" onclick="javacript:event.preventDefault();"><span class="active" brandId="91779">로이텀</span></a></li>
							<li name="brand" class="swiper-slide"><a href="#" onclick="javacript:event.preventDefault();"><span brandId="29908">세레스홈</span></a></li>
							<li name="brand" class="swiper-slide"><a href="#" onclick="javacript:event.preventDefault();"><span brandId="27639">드레텍</span></a></li>
							<li name="brand" class="swiper-slide"><a href="#" onclick="javacript:event.preventDefault();"><span brandId="14975">라미</span></a></li>
							<li name="brand" class="swiper-slide"><a href="#" onclick="javacript:event.preventDefault();"><span brandId="30547">마리슈타이거</span></a></li>
						</c:if>
					</ul>
				</div>
				<div class="pd_list">
					<ul id="recobellBrandList">
					</ul>
				</div>
				<div class="event_banner" id="recobellEventList">
				</div>
			</div>
		</div>
		<c:if test="${not empty cartList}">
			<div class="cont03">
				<h3>최근, 장바구니에 담긴 기록입니다</h3>
				<div class="taste_slide">
					<ul>
						<c:forEach items="${cartList}" var="list" varStatus="st" begin="0" end="9">
							<li>
								<c:if test="${list.sellPrdtGbn eq 'R' || list.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${list.sellPrdtBcode}?foo=bar&rccode=pc_taste3_4" code="${list.sellPrdtBcode}"></c:if>
	                            <c:if test="${list.sellPrdtGbn eq 'P' || list.sellPrdtGbn eq 'G' || list.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${list.sellPrdtBcode}&foo=bar&rccode=pc_taste3_4" code="${list.sellPrdtBcode}"></c:if>
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
		<c:if test="${not empty recobellList1}">
			<div class="cont04">
				<h3><strong>배송비 아까울땐!</strong> 가뿐하게 담아 보세요</h3>
				<div class="taste_slide">
					<ul>
						<c:forEach items="${recobellList1}" var="list" varStatus="st" begin="0" end="${fn:length(recobellList1)}">
							<li>
								<c:if test="${list.sellPrdtGbn eq 'R' || list.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${list.sellPrdtBcode}?foo=bar&rccode=pc_taste3_5" code="${list.sellPrdtBcode}"></c:if>
	                            <c:if test="${list.sellPrdtGbn eq 'P' || list.sellPrdtGbn eq 'G' || list.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${list.sellPrdtBcode}&foo=bar&rccode=pc_taste3_5" code="${list.sellPrdtBcode}"></c:if>
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
		<c:if test="${not empty recobellList2}">
			<div class="cont05">
				<h3><span><strong>천원의 행복!</strong> 이렇게나 이쁜 아이들이</span></h3>
				<div class="taste_slide">
					<ul>
						<c:forEach items="${recobellList2}" var="list" varStatus="st" begin="0" end="${fn:length(recobellList2)}">
							<li>
								<c:if test="${list.sellPrdtGbn eq 'R' || list.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${list.sellPrdtBcode}?foo=bar&rccode=pc_taste3_6" code="${list.sellPrdtBcode}"></c:if>
	                            <c:if test="${list.sellPrdtGbn eq 'P' || list.sellPrdtGbn eq 'G' || list.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${list.sellPrdtBcode}&foo=bar&rccode=pc_taste3_6" code="${list.sellPrdtBcode}"></c:if>
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
	</div>
	<!-- // 컨텐츠 -->
</body>
</html>