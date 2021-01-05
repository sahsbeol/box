<%@page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="none"/>
<script type="text/javascript">
	$(document).ready(function() {
		$("#loading").hide();
	});
</script>
<html>
<head>
</head>
<body>
	<div class="swiper-slide">
		<div class="life_wrapper">
			<div class="life_filter category_wrap">
				<div class="pd_filter">
					<div class="tag_list">
						<ul>
							<!-- 활성화 active : class 추가 -->
							<li value="R" <c:if test="${c.productOrderBy eq 'R'}">class="active"</c:if>><a href="javascript:;">최근순</a></li>
							<li value="P" <c:if test="${c.productOrderBy eq 'P'}">class="active"</c:if>><a href="javascript:;">공감순</a></li>
						</ul>
						<a href="javascript:" class='btn_sympathy <c:if test="${c.likeYn eq 'Y'}">active</c:if>'>나의공감</a>
					</div>
				</div>
			</div>
			<c:if test="${not empty lifeList}">
				<c:forEach items="${lifeList}" var="l" varStatus="st1">				
					<c:choose>
					  	<c:when test='${not empty l.lifeMainParam.imgUrl}'>
							<c:set var="mainClass" value="ver01"></c:set>
							<c:if test='${fn:length(l.lifeSubParam) < 2}'>
								<c:set var="subClass" value="one"></c:set>
							</c:if>							
						</c:when>
						<c:otherwise>
							<c:set var="mainClass" value="ver02"></c:set>
							<c:set var="subClass" value=""></c:set>
						</c:otherwise>
					</c:choose>						
					<div class="life_inner ${mainClass}"><!-- 이미지 있는 case = ver01, 없는 case = ver02 -->				
						<c:choose>
						  	<c:when test='${not empty l.lifeMainParam.imgUrl}'>
								<ui:image src="${l.lifeMainParam.imgUrl}" alt="${l.lifeMainParam.imgAlt}" />						
							</c:when>
							<c:otherwise>
								<b></b>
							</c:otherwise>
						</c:choose>														
						<div class="desc_txt">
							<h2>${l.lifeMainParam.mainText}</h2>
							<p>${l.lifeMainParam.subText}</p>
							<div class="like_heart clear">
								<c:set var="wishCnt" value="${l.lifeMainParam.wishCnt}"/>
								<c:if test="${l.lifeMainParam.wishCnt > 999}"><c:set var="wishCnt" value="999+"/></c:if>
								<span class="heart <c:if test="${l.lifeMainParam.userWishYn eq 'Y'}"> on</c:if>" code="${l.lifeMainParam.svcSeq}">${wishCnt}</span><!-- 활성화시 on : class 추가 -->
								<a href="javascript:" onclick="addBizWishLife(this);return false;" class='btn_life' svcSeq="${l.lifeMainParam.svcSeq}"></a>
							</div>
						</div>
						<div class="life_suggest">
							<c:choose>
								<c:when test="${fn:length(l.lifeSubParam) > 1}">
									<div class="swiper-container life-container">
										<div class="swiper-wrapper">
											<c:forEach items="${l.lifeSubParam}" var="m" varStatus="st2">
												<div class="swiper-slide">
													<a href="/ht/product/detail?barcode=${m.sellPrdtBcode}">
														<div class="img_life">
															<ui:image src="${m.imgUrl}" />
														</div>															
														<div class="txt_life">
															<h2>${m.title}</h2>
<%-- 															<h3>${m.prvdTitle}</h3> --%>
															<p>${m.prdtName}</p>															
														</div>
													</a>
												</div>	
											</c:forEach>									
										</div>
									</div>	
								</c:when>
								<c:otherwise>
									<div class="only_one">
										<c:forEach items="${l.lifeSubParam}" var="n" varStatus="st3">											
											<ui:image src="${n.imgUrl}" />
											<div class="txt_life">
												<h2>${n.title}</h2>
	<%-- 												<h3>${n.prdtName}</h3> --%>
												<p>${n.prdtName}</p>
											</div>	
											<a href="/ht/product/detail?barcode=${n.sellPrdtBcode}"></a>
										</c:forEach>
									</div>		
								</c:otherwise>
							</c:choose>									
						</div>	
					</div>	
				</c:forEach>
			</c:if>							
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
$(document).ready(function() {
    var lifeSwiper = new Swiper('.swiper-container.life-container', {//컬처이벤트
        slidesPerView: 'auto',
        spaceBetween: 4,
        speed: 1000,
        freeMode: true,
      });
    
	// 정렬순서 변경
	$('.tag_list  li').click(function(){
		$('.tag_list li').removeClass("active");
		$(this).addClass("active");
		
		getLifeMain();		
	});
	
	// 나의 공감 클릭 시
	$('.btn_sympathy').click(function(){
	    <c:if test='${!isLogin}'>
        	needLogin();
    	</c:if>
    	<c:if test='${isLogin}'>
	    	$(this).toggleClass('active');
			getLifeMain();
    	</c:if>		
	});	
	
	setTimeout(function(){
// 		스와이퍼 재설정
		main.mainBannerSwiper00.onResize();
		lifeLikeInit();
	}, 2000);	
});

function getLifeMain(){
	
	var productOrderBy = $('.tag_list .active').attr("value");
	var likeYn = "";
	
	if("P" != productOrderBy && "R" != productOrderBy){
		productOrderBy = "";
	}
	
	if($('.btn_sympathy').hasClass('active')){
		likeYn = "Y";
	}else{
		likeYn = "N";
	}
	
	//location.href="?productOrderBy="+productOrderBy+"&likeYn="+likeYn;
	var str = "?productOrderBy="+productOrderBy+"&likeYn="+likeYn;
	var gnbType = "gnblife";
	var $obj = $("#tabSwiper ." + gnbType);
	
    $.ajax({
        type: "GET"
       ,async:false
       ,url: "/m/biz/life/lifeMain" + str
       ,dataType: "html"
       ,success : function(htmlStr){
    	   $obj.empty();
    		$obj.append(htmlStr);
 			$("#loading").hide();

          	//메인탭스와이퍼 재설정
          	main.swiperRest();
       }
       ,error: function(data) {
           alert('<fmt:message key="error.common.system"/>');
           $("#loading").hide();
       }
   });	
}

function lifeLikeInit(){
	
	var d = new Date();
    var url = "/images/biz/sub/heart_on.gif?a="+d.getTime();                
    
    $(".heart.on").css({"background":""});	   
    $(".heart.on").css({background:"url("+url+") 50% 0% no-repeat",backgroundSize: 32});
}
</script>