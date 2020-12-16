<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="none"/>
<div class="cate" style="position: relative;z-index:900;">
    <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit${threeDepthCtgrId}.gif" alt="${currentCategory.cateName}" /></h2>
    <!-- 다이어리 배너 추가 -->
	<c:if test="${fn:startsWith(c.ctgrId, '000020')}">
        <a href="/ht/diary/main" style="margin:0 0 10px 0;">
			<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/resources/img/bnr/h_180_40.jpg" class="PC_DIARY_SIDE">
		</a>
    </c:if>
    
    <ul>
        <c:if test="${threeDepthCtgrId eq '000025'}">
            <li class="first">
                <a href="/ht/hot/brandDetail?brandId=20466">
                    <span>프리미엄 조명</span>
                    <span class="arrow">&nbsp;</span>
                </a>
            </li>
        </c:if>
        <c:if test="${not empty listBestBrand}">
            <li class="first">
                <a href="#">
                    <span>${mstBestBrand.title}</span>
                    <span class="arrow">&nbsp;</span>
                </a>
                <ul>
                    <c:forEach items="${listBestBrand}" var="l">
                        <li><a href="/ht/hot/brandDetail?brandId=${l.brandId}"><span>${l.brandName}</span></a></li>
                    </c:forEach>
                </ul>
            </li>
        </c:if>
        
        <c:set var="cateSp" value="N"/>
        <c:forEach items="${lnbCategoryList}" var="l" varStatus="st">
            <c:set var="cateSpCls" value=""/>
            <c:if test="${fn:startsWith(l.cateId, '000023') && fn:startsWith(l.cateName, 'PET') && cateSp eq 'N'}">
                <c:set var="cateSp" value="Y"/>
                <c:set var="cateSpCls" value="sp"/>
            </c:if>
            <li class="${cateSpCls}">
                <c:if test="${not empty l.childCategoryList}">
                    <a href="/ht/gift/giftCategorySub?ctgrId=${l.cateId}">
                        <span class="lcate${l.iconId}">${l.cateName}</span>
                        <span class="arrow">&nbsp;</span>
                    </a>
                    <ul>
                        <c:forEach items="${l.childCategoryList}" var="l2" varStatus="st2">
                            <li><a href="/ht/gift/giftCategorySub?ctgrId=${l2.cateId}"><span>${l2.cateName}</span></a></li>
                        </c:forEach>
                    </ul>
                </c:if>
                <c:if test="${empty l.childCategoryList}">
                    <a href="/ht/gift/giftCategorySub?ctgrId=${l.cateId}">
                        <span>${l.cateName}</span>
                    </a>
                </c:if>
            </li>
        </c:forEach>
        <c:if test="${fn:startsWith(c.ctgrId, '000007')}">
            <li class="mgt20 first"><a href="/ht/brandStory?type=1" onclick="window.open(this.href,'popBrandStory','width=849,height=700,scrollbars=yes');return false;">브랜드 스토리</a></li>
            <li class="first"><a href="/ht/fountainPen?type=1" onclick="window.open(this.href,'popFountainPen','width=849,height=700,scrollbars=yes');return false;">만년필 사용법</a></li>
            <li class="first"><a href="/ht/carvingService" onclick="window.open(this.href,'popCarvingSevice','width=849,height=700,scrollbars=yes');return false;">각인 서비스</a></li>
            <li class="first"><a href="/ht/fountainPenFaq?type=1" onclick="window.open(this.href,'popFaq','width=849,height=700,scrollbars=yes');return false;">자주 묻는질문</a></li>
        </c:if>
    </ul>
    <%--
    <c:if test="${fn:startsWith(c.ctgrId, '000020')}">
        <a href="/ht/diary/main" class="mgt20"><img src="${imageServer}/images/diary/2016/bnr_lnb.jpg" alt="2016 날짜인쇄"/></a>
    </c:if>
     --%>
</div>