<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<c:choose>
	<c:when test="${empty c.userNum}">
		<div class="vacant_history">
			<img class='login' src="/images/biz/sub/history/no_login.png" alt="히스토리 내역없음">
			<p><span>혹시 로그인을 깜빡하신 걸까요?</span><br><br> 좋아요 기능은<br> 회원만 이용하실 수 있어요</p>
			<a href="javascript:" onclick="login()">지금 로그인 하기</a>
		</div>		
	</c:when>
	<c:otherwise>		
		<c:choose>
			<c:when test="${empty list}">
				<div class="vacant_history">
					<img class='brand' src="/images/biz/sub/history/no_brand.png" alt="히스토리 내역없음">
					<p><span>아직 취향에 맞는<br> 브랜드를 못찾으셨군요</span><br><br>괜찮아요, 기다리고 있을게요</p>
					<a href="javascript:">지금 추천받기</a>
				</div>		
				<div class="plus_spot pd_unit">
					<h2>혹시,<br> 이런 발견은 어떠세요?</h2>
					<div class="swiper-container plus_history">
						<div class="swiper-wrapper">
							<!-- 품절시 sold_out : class 추가 -->
							<div class="swiper-slide">
								<a href="#none">
									<div class="info bigger">
										<span class="like">999+</span>
									</div>
									<div class="thum">
										<img src="/images/biz/thums/main_banner00.png" alt="">
										<em class="font_t">motemote <small>모트모트</small></em>
									</div>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="#none">
									<div class="info bigger">
										<span class="like">999+</span>
									</div>
									<div class="thum">
										<img src="/images/biz/thums/main_banner00.png" alt="">
										<em class="font_t">motemote <small>모트모트</small></em>
									</div>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="#none">
									<div class="info bigger">
										<span class="like">999+</span>
									</div>
									<div class="thum">
										<img src="/images/biz/thums/main_banner00.png" alt="">
										<em class="font_t">motemote <small>모트모트</small></em>
									</div>
								</a>
							</div>
						</div>
		
						<!-- 스크롤바 -->
						<div class="swiper-scrollbar"></div>
					</div>
				</div>				
			</c:when>
			<c:otherwise>			
				<div class="choice_wrap">
					<div class="pd_filter">
						<p class="pd_total"><em class="font_t">${pageHolder.totalRows}</em>건</p>
						<div class="form_select">
							<select onchange="goSortBrand(this.value);return false;">
								<option value="R" <c:if test="${c.productOrderBy eq 'R'}"> selected="selected"</c:if>>최근순</option>				
								<option value="A" <c:if test="${c.productOrderBy eq 'A'}"> selected="selected"</c:if>>가나다순</option>
							</select>
						</div>
					</div>
				</div>						
				<!-- 제품 -->
				<div class="brand_history">
					<ul class='list_brands'>    
				    <c:forEach items="${list}" var="l" varStatus="st">
						<li>
							<a href="/m/hot/brandDetail?brandId=${l.brandId}" class='clear'>
								<i><ui:image src="${l.brandImageUrl}" server="brand" alt="${fn:escapeXml(l.brandName)}"/></i>
								<div class="txt_brand">
									<c:if test="${not empty l.brandEngName}">
										<h3 class='font_t'>${l.brandEngName}</h3>
									</c:if>				
									<c:if test="${not empty l.brandName}">
										<p>${l.brandName}</p>
									</c:if>					
								</div>
							</a>
							<div class="like_brand">
								<c:set var="wishBrandCnt" value="${l.wishBrandCnt}"/>
								<c:if test="${l.wishBrandCnt > 999}"><c:set var="wishBrandCnt" value="999+"/></c:if>
								<span class="<c:if test="${l.wishUserBrandCnt ne '0'}">like</c:if>">${wishBrandCnt}</span>
								<a href="javascript:" id="${l.brandId}" onclick="addBizWishBrand('${l.brandId}')" class='btn_brandLike'></a>				
							</div>
						</li>         
				    </c:forEach>
				    </ul>
				</div>
				<!--// 제품 -->
				<div class="pagination">
				    <ui:bizpaginationScript name="pageHolder" scriptName="goListBrand"/>
				</div>		
			</c:otherwise>
		</c:choose>	
	</c:otherwise>
</c:choose>

<script>
//페이지 이동
function goListBrand(page){	
    var target = "${c.target}";
    var productOrderBy = "${c.productOrderBy}";
    loadTemplate(target, productOrderBy, page);
}

//정렬순서 변경
function goSortBrand(productOrderBy){	
    var target = "${c.target}";
    var page = "1";
    loadTemplate(target, productOrderBy, page);
}
</script>