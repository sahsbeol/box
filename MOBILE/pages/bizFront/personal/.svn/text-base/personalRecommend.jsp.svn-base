<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizFull"/>
<script type="text/javascript">
var brand = '';

$(document).ready(function(){
	$(document).on("click","#brandList li",function() {
		$('#brandList li').removeClass("active");
		
		$('#brandId').val($(this).attr("brandId"));
		
		$fn.setRecobellBrandPrdtList();
    });
	
	tasteFn();
	
	$fn.setRecobellBrandList();
})

$fn = {
	setRecobellBrandList:function() {
		$.ajax({
			url: "/m/biz/personal/getRecobellBrandList"
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
	            if (data) {
	                if(!isEmpty(data)) {
						var list = data.brandList;
						if(!isEmpty(list)) {
							brand += '<li class="brand_list_wrap"  style="height: 299px;">';
							brand += '	<div class="brand_list">';
							brand += '		<ul id="brandList">';
							for(var i=0; i < list.length; i++) {
								if (i == 0)	$('#brandId').val(list[i].brandId);
								brand += '			<li brandId="'+list[i].brandId+'"><a href="#" onclick="javacript:event.preventDefault();"><span>'+list[i].brandName+'</span></a></li>';	
								if (i == 4)	break;
							}
							brand += '		</ul>';
							brand += '	</div>';
							brand += '</li>';
						}
	                }
	            }
	        }
	        ,complete: function() {
	        	$fn.setRecobellBrandPrdtList();
	        }
	        ,error: function(request, status, error) {
	            if(request.status != 0){
	                alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
	            }
	        }
	    });
	}
	, setRecobellBrandPrdtList:function() {
		var brandId = $('#brandId').val();
		
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
						append += brand;

						if(!isEmpty(list)) {
							for(var i=0; i < list.length; i++) {
								append += '	<li style="height: 299px;">';
								append += '	<a href="/p/'+list[i].sellPrdtBcode+'?foo=bar&rccode=mo_taste1_3">';
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
								
								if (i == 18)	break;
		                	}
						}
						
						$('#recobellBrandPrdtList').html(append);

						$('[brandId='+brandId+']').addClass("active");
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

function shuffle(a) {
    var j, x, i;
    for (i = a.length; i; i -= 1) {
        j = Math.floor(Math.random() * i);
        x = a[i - 1];
        a[i - 1] = a[j];
        a[j] = x;
    }
}
</script>
</head>
<body>
	<input type="hidden" id="brandId">
	<!-- content -->
	<div id="content">
		<div class="personal_taste taste01">
			<div class="tab">
				<p>${userName}님을 위한 발견</p>
				<ul>
					<li class="active"><a href="/m/biz/personal/personalRecommend"><span>추천</span></a></li>
					<li><a href="/m/biz/personal/personalRecent"><span>최근,관심</span></a></li>
					<li><a href="/m/biz/personal/personalLike"><span>좋아요</span></a></li>
					<li><a href="/m/biz/personal/personalBest"><span>지금,인기</span></a></li>
				</ul>
			</div>
			<c:if test="${not empty bestList}">
				<div class="cont01">
					<h3>혹시,<br/>이 상품은 어떠세요?</h3>
					<p>최근 쇼핑 이력을 분석하여<br/>현재 관심 있을만한 상품과 기획전을 추천드려요.</p>
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<c:forEach items="${bestList}" var="list" varStatus="st" begin="0" end="${fn:length(bestList)}">
								<div class="swiper-slide">
									<a href="/p/${list.sellPrdtBcode}?foo=bar&rccode=mo_taste1_1">
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
			
			<c:if test="${not empty eventList}">
				<div class="cont02">
					<!-- 이미지 1개는 case1, 그 이상 case2 : class 추가 -->
					<div class="event_list<c:if test="${fn:length(eventList) == 1}"> case1</c:if><c:if test="${fn:length(eventList) > 1}"> case2</c:if>">
				        <div class="event_top">
			            	<!-- 이미지가 1개인 경우 -->
							<c:if test="${fn:length(eventList) == 1}">
								<c:forEach items="${eventList}" var="list" varStatus="st" begin="0" end="${fn:length(eventList)}">
                                <div class="event_bnr">
                                <ul>
                                    <li>
                                        <a href="/m/biz/eventDetail?eventId=${list.eventId}&foo=bar&rccode=mo_taste1_2">
                                            <div class="img_wrap">
                                                <ui:image src="${list.imageUrl}" alt="${list.eventTitle}" />
                                            </div>
                                            <c:if test="${list.stdDscntRate != null}">
                                            <span class="font_t percent">${list.stdDscntRate}%</span>
                                            </c:if>
                                            <strong>${list.eventTitle}</strong>
                                            <p>${list.eventDtlCont}</p>
                                        </a>
                                    </li>
                                </ul>
                                </div>
                                </c:forEach>
							</c:if> 
							<c:if test="${fn:length(eventList) > 1}">                           
							<div class="swiper-container">
								<div class="swiper-wrapper">
									<c:forEach items="${eventList}" var="list" varStatus="st" begin="0" end="${fn:length(eventList)}">
										<div class="swiper-slide">
											<a href="/m/biz/eventDetail?eventId=${list.eventId}&foo=bar&rccode=mo_taste1_2">
												<div class="thum">
													<ui:image src="${list.imageUrl}" alt="${list.eventTitle}" />
												</div>
	                                            <c:if test="${list.stdDscntRate != null}">
	                                            <span class="font_t percent">${list.stdDscntRate}%</span>
	                                            </c:if>
												<strong>${list.eventTitle}</strong>
												<p>${list.eventDtlCont}</p>
											</a>
										</div>
									</c:forEach>
								</div>
								<!-- swiper-pagination -->
								<div class="pagination_wrap">
									<div class="swiper-pagination"></div>
								</div>
								<!-- 스크롤바 -->
								<div class="swiper-scrollbar"></div>
							</div> 
							</c:if>                      
                        </div>
                    </div>
				</div>
			</c:if>
			<div class="cont03">
				<h3>${userName}님,<br/>이 브랜드는 어떠세요?</h3>
				<ul id="recobellBrandPrdtList">
				</ul>
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