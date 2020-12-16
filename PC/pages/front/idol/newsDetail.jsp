<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<head>
<title>음반 메인 - NEW ME HOTTRACKS</title>
<c:set value="12345678" var="temp"/>
<link rel="stylesheet" type="text/css" href="/css/chart.css?${temp }">
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
});
function goList(page) {
    if(page == null || page == undefined)    page = 1;
    location.href="?page=" +page;
}


</script>
</head>
<body>
<div class="music_wrap">
    <h1 id="music_magazine_title"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/idol/music_title.png"/></h1>
    <div class="idole_news">
    <section class="musicmain">
        <div id="magazine_title">
            <p id="news" class="on"><a href="/ht/idol/news">신곡뉴스</a></p>
            <p id="special"><a href="/ht/idol/special">아이돌매거진</a></p>
        </div>
        <hr/>
        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/idol/pin_400.jpg" alt="${news.title}" class="sns_img" style="display:none;"/>
        <div class="sns f_right" style="margin:0 18px 20px 0;">
            <a href="#" onclick="goTwitter('${news.title}', 'www.hottracks.co.kr/ht/idol/newsDetail?cntid=${news.cntid}');return false;"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/ico_sns_twitter.png" alt="twitter"></a>
            <a href="#" onclick="goFaceBook('${news.title}', 'www.hottracks.co.kr/ht/idol/newsDetail?cntid=${news.cntid}');return false;"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/ico_sns_facebook.png" alt="facebook"></a>
            <a href="#" onclick="goPinterest('${news.title}', 'www.hottracks.co.kr/ht/idol/newsDetail?cntid=${news.cntid}');return false;"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/ico_sns_pinterest.png" alt="pinterest" style="width:28px;height:28px;" nopin="true"></a>
        </div>
        <div class="news_detail">
            <span class="title">${news.title }</span>
            <span class="date">${news.pubdt }</span>
            <span class="detail">${news.description }</span>
            <span class="chart_logo">
                <span id="logo_ment">
                            본사는 서비스 제공 중개자로서 본 콘텐츠의 제작 당사자가 아닙니다.<br/>
                            저작권은 작성 주체인 아이돌차트에 있으며 이를 무단 이용하는 경우 
                            저작권법 등에 따라 법적 책임을 질 수 있습니다.<br/>
                </span>
                <div id="defaultBannerArea" style="display: none;">
	                <a href="https://idol-chart.com/" target="_blank" >
	                    <span id="logo_img" class="PC_MUSICMAGAZINE_1"></span>
	                </a>
                </div>
                <div id="evnetBannerArea" style="display: none;">
	                <a href="https://www.idol-chart.com/event/?mode=view&no=34" target="_blank" >
	                    <span id="logo_img_event1" class="PC_MUSICMAGAZINE_1"></span>
	                </a>
                </div>
            <span id="gotoNews"><a href="/ht/idol/news">목록</a></span>
            </span>
            <div class="prod_box"> <!--  연관상품 -->
                <c:if test="${not empty list}">
                    <h1>연관상품</h1>
                </c:if>
                <div class="prod_list_normal">
                    <c:forEach items="${list}" varStatus="s1" step="4">
                    <ul>
                        <c:forEach items="${list}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
                            <li>
                                <span class="img">
                                <c:choose>
                                    <c:when test="${l.sellPrdtGbn eq 'D' || l.sellPrdtGbn eq 'R'}">
                                        <a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'133':'87'}" alt="${l.prdtName}" ratingCode="A"/></a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}&ctgrId=${l.ctgrId}"><ui:image src="${l.productImageUrl}" src2="${l.productImageUrl2}" alt="${fn:escapeXml(l.prdtName)}" server="product" ratingCode="${l.nyoSellBanYn}" size="200"/></a>
                                    </c:otherwise>
                                </c:choose>
                                    <div class="hide_util">
                                        <a href="javascript://" onclick="productPreview('${l.sellPrdtBcode}')" class="zoom"><span>확대</span></a>
                                        <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                        <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                                    </div>
                                </span>
                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                                    <span class="make">${l.brandName}</span>
                                    <span class="name">${l.prdtName}</span>
                                    <span class="icon">
                                        <c:set var="reviewCount" value="${l.reviewCount}"/>
                                        <c:set var="wishPrdtCnt" value="${l.wishPrdtCnt}"/>
                                        <c:if test="${l.reviewCount > 99}"><c:set var="reviewCount" value="99+"/></c:if>
                                        <c:if test="${l.wishPrdtCnt > 99}"><c:set var="wishPrdtCnt" value="99+"/></c:if>
                                        <c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}"><em class="ico_free">무료배송</em></c:if>
                                        <c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><em class="ico_coupon">쿠폰</em></c:if>
                                        <c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}"><em class="ico_gift">GIFT</em></c:if>
                                        <c:if test="${l.wishPrdtCnt > 0}"><em class="ico_like">${wishPrdtCnt}</em></c:if>
                                        <c:if test="${l.reviewCount > 0}"><em class="ico_review">${reviewCount}</em></c:if>
                                    </span>
                                    <em class="price">
                                        <c:if test="${l.basePrdtSellPrice > l.lastCpnPrice}"><span class="dc"><fmt:formatNumber value="${l.basePrdtSellPrice}" pattern="#,###"/></span></c:if>
                                        <span class="sale"><fmt:formatNumber value="${l.lastCpnPrice}" pattern="#,###"/></span>
                                        <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                        <c:if test="${l.prdtStatCode eq 'C0312' && l.prdtSellPrice > l.lastCpnPrice}"><span class="pc">${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}%</span></c:if>
                                    </em>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </c:forEach>
            </div>
        </div>
        </div>
    </section>
    </div>
</div>
</body>
</html>