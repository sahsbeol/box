<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizFull"/>
<script>
$(document).ready(function() {
	$('[name=brand]').click(function(){
		$('[name=brand]').removeClass("active");
		$('[name=brand]').find("span").removeClass("active");
		$(this).addClass("active");
		$(this).find("span").addClass("active");
		
		$fn.setRecobellBrandPrdtList();
	});
	
	tasteFn();
	
	$fn.setRecobellBrandPrdtList();
});

$fn = {
	setRecobellBrandPrdtList:function() {
		var brandId = $('[name=brand] .active').attr("brandId");
		
		$.ajax({
			url: "/m/biz/personal/getRecobellBrandPrdtList"
			, data: {
				brandId : brandId
			}
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
	        	var append = "";
               	$('#recobellBrandPrdtList').empty();
	        	
	            if (data) {
	                if(!isEmpty(data)) {
						var list = data.recobellBrandPrdtList;
						if(!isEmpty(list)) {
							for(var i=0; i < list.length; i++) {
								append += '<li code="'+list[i].sellPrdtBcode+'">';
								append += '	<a href="/p/'+list[i].sellPrdtBcode+'?foo=bar&rccode=mo_taste3_2">';
								append += '		<div class="thum">';
								if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
			                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/music/large/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" >';
		                	    }else{
			                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
		                	    }
								append += '		</div>';
								append += '		<div class="desc">';
								append += '			<p class="tit">'+list[i].prdtName+'</p>';
								append += '			<p class="price font_t">';
								if(list[i].lastDcRate != 0){
			                	    append += '				<span class="percent">'+list[i].lastDcRate+'%</span>';
		                	    }
								append += 				price_format(list[i].lastCpnPrice);
								append += '			</p>';
								append += '		</div>';
								append += '	</a>';
								append += '</li>';
								
								if (i == 19)	break;
		                	}
						}
						
						$('#recobellBrandPrdtList').html(append);
	                }
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
		var code = $('#recobellBrandPrdtList li').attr('code');
		
		$.ajax({
			url: "/m/biz/personal/getRecobellEventList"
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
						append += '<a href="/m/biz/eventDetail?eventId='+list[0].eventId+'&foo=bar&rccode=mo_taste3_3">';
						append += '	<div class="img_wrap">';
						append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/'+list[0].imageUrl+'" alt="'+list[0].eventTitle+'">';
						append += '	</div>';
						if(!isEmpty(list[0].stdDscntRate)){
							append += '	<span class="font_t percent">'+list[0].stdDscntRate+'%</span>';
						}
						append += '	<strong>'+list[0].eventTitle+'</strong>';
						append += '	<p>'+list[0].eventDtlCont+'</p>';
						append += '	<span class="date font_t">'+list[0].eventStartDt.replace(/(\d{4})(\d{2})(\d{2})/, '$1.$2.$3')+' ~ '+list[0].eventEndDt.replace(/(\d{4})(\d{2})(\d{2})/, '$1.$2.$3')+'</span>';
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
</head>
<body>
	<!-- content -->
	<div id="content">
		<div class="personal_taste taste03">
			<div class="tab">
				<p>${userName}님을 위한 발견</p>
				<ul>
					<li><a href="/m/biz/personal/personalRecommend"><span>추천</span></a></li>
					<li><a href="/m/biz/personal/personalRecent"><span>최근,관심</span></a></li>
					<li class="active"><a href="/m/biz/personal/personalLike"><span>좋아요</span></a></li>
					<li><a href="/m/biz/personal/personalBest"><span>지금,인기</span></a></li>
				</ul>
			</div>
			<c:if test="${not empty wishList}">
				<div class="cont01">
					<h3>찜한 상품들<br/>잊지 않으셨나요?</h3>
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<c:forEach items="${wishList}" var="list" varStatus="st" begin="0" end="${fn:length(wishList)}">
								<div class="swiper-slide">
									<a href="/p/${list.sellPrdtBcode}?foo=bar&rccode=mo_taste3_1">
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
			<div class="cont02">
				<h3>관심 브랜드의<br/>소식을 놓치지 마세요!</h3>
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<c:forEach items="${brandList}" var="list" varStatus="st">
							<div name="brand" class="swiper-slide  <c:if test="${st.first}">active</c:if>"><a href="#" onclick="javacript:event.preventDefault();"><span <c:if test="${st.first}">class="active"</c:if> brandId="${list.brandId}">${list.brandEngName}</span></a></div>
						</c:forEach>
						<c:if test="${empty brandList}">
							<div name="brand" class="swiper-slide active"><a href="#" onclick="javacript:event.preventDefault();"><span class="active" brandId="91779">로이텀</span></a></div>
							<div name="brand" class="swiper-slide"><a href="#" onclick="javacript:event.preventDefault();"><span brandId="29908">세레스홈</span></a></div>
							<div name="brand" class="swiper-slide"><a href="#" onclick="javacript:event.preventDefault();"><span brandId="27639">드레텍</span></a></div>
							<div name="brand" class="swiper-slide"><a href="#" onclick="javacript:event.preventDefault();"><span brandId="14975">라미</span></a></div>
							<div name="brand" class="swiper-slide"><a href="#" onclick="javacript:event.preventDefault();"><span brandId="30547">마리슈타이거</span></a></div>
						</c:if>
					</div>
				</div>

				<div class="pd_list">
					<ul id="recobellBrandPrdtList">
					</ul>
				</div>

				<div class="event_banner" id="recobellEventList">
				</div>
			</div>
			<c:if test="${not empty cartList}">
				<div class="cont03 banner_list">
					<h3>최근,<br/>장바구니에 담긴 기록입니다</h3>
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<c:forEach items="${cartList}" var="list" varStatus="st" begin="0" end="${fn:length(cartList)}">
								<div class="swiper-slide">
									<a href="/p/${list.sellPrdtBcode}?foo=bar&rccode=mo_taste3_4">
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
				                    			${list.sellPrdtGbn}
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
			<c:if test="${not empty recobellList1}">
				<div class="cont04 banner_list">
					<h3><strong>배송비 아까울 땐!</strong>가뿐하게 담아보세요</h3>
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<c:forEach items="${recobellList1}" var="list" varStatus="st" begin="0" end="${fn:length(recobellList1)}">
								<div class="swiper-slide">
									<a href="/p/${list.sellPrdtBcode}?foo=bar&rccode=mo_taste3_5">
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
			<c:if test="${not empty recobellList2}">
				<div class="cont05 banner_list">
					<h3><span><strong>천원의 행복!</strong>이렇게나 예쁜 아이들이</span></h3>
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<c:forEach items="${recobellList2}" var="list" varStatus="st" begin="0" end="${fn:length(recobellList2)}">
								<div class="swiper-slide">
									<a href="/p/${list.sellPrdtBcode}?foo=bar&rccode=mo_taste3_6">
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