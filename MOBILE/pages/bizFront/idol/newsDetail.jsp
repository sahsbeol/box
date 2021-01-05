<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="bizHot"/>
<head>
<title>[NEW ME 핫트랙스] ${fn:escapeXml(news.title)}</title>
<c:set value="20190411" var="temp"/>
<link rel="stylesheet" type="text/css" href="/css/chart.css?${temp }">
<meta property="fb:app_id" content="981386905311018" />
<meta property="og:title" content="${fn:escapeXml(news.title)}">
<meta property="og:type" content="website"/>
<meta property="og:url" content="http://m.hottracks.co.kr/m/idol/newsDetail?cntid=${news.cntid}"/>
<meta property="og:description" content="핫트랙스 아이돌차트"/>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/idol/facebook_200.png"/>
<script type="text/javascript">
jQuery(function($){
	
	var date = new Date();
	
	var yy = date.getFullYear();
	var mm = date.getMonth()+1;
	var dd = date.getDate();
	
	if((mm+"").length < 2){
		mm = "0"+mm;
	}
	
	if((dd+"").length < 2){
		dd = "0"+dd;
	}
	
	today = yy+''+mm+''+dd;
	
	if(eval(today) < '20190716'){
		$('#evnetBannerArea').show();
	}else{
		$('#defaultBannerArea').show();
	}
	
    $("#wrap").removeClass("mini");
    $("#locMusic").addClass("active");
});

function openIdolChart(){
    $("#loading").remove();
}

</script>
</head>
<body>
<div class="music_wrap">
    <div class="idole_news">
    <section class="musicmain">
        <div style="display: flex;height: 49.5px;">
            <p id="news" class="on"><a href="/m/biz/idol/news">신곡뉴스</a></p>
            <p id="speical"><a href="/m/biz/idol/special">아이돌매거진</a></p>
        </div>
        <div class="news_detail">
            <span class="title">${news.title }</span>
            <span class="date">${news.pubdt }</span>
            <!-- SNS 기능 추가  -->
            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/idol/pin_400.jpg" alt="${news.title}" class="sns_img kakao-img" style="display:none;"/>
            <div class="event_sub_info" style="height:10px;">
                <div class="sns" style="top:-42px;">
                    <a href="#" onclick="goTwitter('${fn:escapeXml(news.title)}', 'http://m.hottracks.co.kr/m/biz/idol/newsDetail?cntid=${news.cntid}');return false;" class="ic_twitter">트위터</a>
                    <a href="#" onclick="goFaceBook('${fn:escapeXml(news.title)}', 'http://m.hottracks.co.kr/m/biz/idol/newsDetail?cntid=${news.cntid}');return false;" class="ic_facebook">페이스북</a>
                    <a href="#" onclick="sendKakao('[핫트랙스] ${fn:escapeXml(news.title)}', 'http://m.hottracks.co.kr/m/biz/idol/newsDetail?cntid=${news.cntid}');return false;"class="ic_kakaotalk">카카오톡</a>
                </div>
            </div>
            <span class="detail">${news.description }</span>
            <span class="chart_logo">
                <span id="logo_ment">
                            본사는 서비스 제공 중개자로서 본 콘텐츠의 제작 당사자가 아닙니다.<br/>
                            저작권은 작성 주체인 아이돌차트에 있으며 이를 무단 이용하는 경우 
                            저작권법 등에 따라 법적 책임을 질 수 있습니다.<br/>
                </span>
				<div id="defaultBannerArea" style="display: none;">
	                <a href="https://idol-chart.com/" id="logo_img" onClick="javascript:openIdolChart();">
	                    <span id="logo">아이돌차트 바로가기
	                    <img id="logo_circle" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/idol/btn-circle.png"/>
	                    </span>
	                    <img id="logo_bg" class="M_MUSICMAGAZINE_1" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/idol/btn-bg.png"/>
	                </a>
				</div>
				<div id="evnetBannerArea" style="display: none;">
	                <a href="https://m.idol-chart.com/event/?mode=view&no=34" id="logo_img" onClick="javascript:openIdolChart();">
	                    <img id="logo_bg" class="M_MUSICMAGAZINE_1" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/idol/btn-outlink-event1_m.jpg"/>
	                </a>
				</div>
                <span id="gotoNews"><a href="/m/biz/idol/news">목록</a></span>
            </span>
            <!-- 연관상품 -->
            <div class="prod_box">
                <c:if test="${not empty list}">
                    <h1><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/idol/gifticon.png"/>연관상품</h1>
                </c:if>
                <c:forEach items="${list}" var="l" varStatus="st">
                    <a href="/p/${l.sellPrdtBcode}">
                        <c:choose>
                            <c:when test="${param.lazy eq 'Y' && st.index > 7}">
                                <c:choose>
                                    <c:when test="${l.sellPrdtGbn eq 'R'}"><span class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" alt="${l.prdtName}" lazy="Y" clazz="lazy"/></span></c:when>
                                    <c:when test="${l.sellPrdtGbn eq 'D'}"><span class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" alt="${l.prdtName}" lazy="Y" clazz="lazy"/></span></c:when>
                                    <c:otherwise>
                                        <span class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}" lazy="Y" clazz="lazy"/></span>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${l.sellPrdtGbn eq 'R'}"><span class="pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" alt="${l.prdtName}"/></span></c:when>
                                    <c:when test="${l.sellPrdtGbn eq 'D'}"><span class="pic dvd"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" alt="${l.prdtName}"/></span></c:when>
                                    <c:otherwise>
                                        <span class="pic"><ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/></span>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                        <span class="txt_box">
                            <em class="brand">${l.brandName}</em>
                            <em class="tit">${fn:escapeXml(l.prdtName)}</em>
                            <em class="price"><fmt:formatNumber type="number" value="${l.lastCpnPrice}"/>원</em>
                            <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}"><em class="sale">[<fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}</fmt:formatNumber>%]</em></c:if>
                        </span>
                        <span class="ico_box">
                            <c:set var="reviewCount" value="${l.reviewCount}"/>
                            <c:set var="wishPrdtCnt" value="${l.wishPrdtCnt}"/>
                            <c:if test="${l.reviewCount > 99}"><c:set var="reviewCount" value="99+"/></c:if>
                            <c:if test="${l.wishPrdtCnt > 99}"><c:set var="wishPrdtCnt" value="99+"/></c:if>
                            <c:if test="${l.reviewCount > 0}"><em class="ico_review">${reviewCount}</em></c:if>
                            <c:if test="${l.wishPrdtCnt > 0}"><em class="ico_like">${wishPrdtCnt}</em></c:if>
                        </span>
                        <span class="bnf_box">
                            <c:choose>
                                <c:when test="${l.prdtStatCode ne 'C0312'}">                                	
									<c:if test="${l.prdtStatCode eq 'C0313'}"><em class="ico_soldout">일시품절</em></c:if>
									<c:if test="${l.prdtStatCode ne 'C0313'}"><em class="ico_soldout">품절</em></c:if>                                	
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}"><em class="ico_free">무료배송</em></c:if>
                                    <c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><em class="ico_coupon">쿠폰</em></c:if>
                                    <c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}"><em class="ico_gift">GIFT</em></c:if>
                                    <c:if test="${l.dlvyVndrId eq '0625'}"><em class="ico_hottracks">핫트랙스배송</em></c:if>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </a>
                </c:forEach>
            </div><!--  연관상품 -->
        </div>
    </section>
    </div>
</div>
</body>
</html>