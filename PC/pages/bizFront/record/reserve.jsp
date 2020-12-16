<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<title>
<c:if test="${fn:startsWith(c.ctgrId, '0003')}">예약 CD</c:if>
<c:if test="${fn:startsWith(c.ctgrId, '0004')}">예약 BLU-RAY/DVD</c:if>
- HOTTRACKS
</title>
<script type="text/javascript">
isLogin = ${isLogin};
</script>
</head>
<body>
<!-- 가요 lnb -->
<div class="cate03">
    <c:if test="${fn:startsWith(c.ctgrId, '0003')}">
        <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit03.gif" alt="CD" /></h2>
        <ul>
            <c:forEach items="${categoryListLeft}" var="l" varStatus="st">
                <li><a href="/ht/record/reserve/${l.cateId}" <c:if test="${c.ctgrId eq l.cateId}">class="on"</c:if>>${l.cateName}</a></li>
            </c:forEach>
        </ul>
    </c:if>
    <c:if test="${fn:startsWith(c.ctgrId, '0004')}">
        <h2><img src="${imageServer}/images/renewal/shop/sub_tit10.gif" alt="Blu-Ray" /></h2>
        <ul class="mgb25">
            <c:forEach items="${categoryListLeft1}" var="l" varStatus="st">
                <li><a href="/ht/record/reserve/${l.cateId}" <c:if test="${c.ctgrId eq l.cateId}">class="on"</c:if>>${l.cateName}</a></li>
            </c:forEach>
        </ul>
        <h2><img src="${imageServer}/images/renewal/shop/sub_tit11.gif" alt="DVD" /></h2>
        <ul>
            <c:forEach items="${categoryListLeft2}" var="l" varStatus="st">
                <li><a href="/ht/record/reserve/${l.cateId}" <c:if test="${c.ctgrId eq l.cateId}">class="on"</c:if>>${l.cateName}</a></li>
            </c:forEach>
        </ul>
    </c:if>
</div>

<div class="list_section">
    <!-- Location -->
    <div class="page_location">
        <div class="loc">
            <a href="/" class="home">Home</a>
            <c:if test="${fn:startsWith(c.ctgrId, '0003')}">
                <a href="/ht/biz/record/recordCategoryMain?ctgrId=0003">CD</a>
                <em>예약 CD</em>
            </c:if>
            <c:if test="${fn:startsWith(c.ctgrId, '0004')}">
                <a href="/ht/biz/record/dvdCategoryMain?ctgrId=000401">DVD</a>
                <em>예약 Blu-Ray/Dvd</em>
            </c:if>
        </div>
    </div>
    <!-- //Location -->
    
    <h3 class="tit03"><ui:category id="${c.ctgrId}" full="false"/></h3>
    <c:if test="${fn:startsWith(c.ctgrId, '0003')}">
        <div class="radio_option">
            <input type="radio" name="impYn" id="radio_1" value="" onclick="location.href='?impYn=&<ui:param skip="page,impYn" />'" <c:if test="${empty c.impYn}">checked</c:if>/>
            <label for="radio_1">전체</label>
            <input type="radio" name="impYn" id="radio_2" value="N" onclick="location.href='?impYn=N&<ui:param skip="page,impYn" />'" <c:if test="${c.impYn eq 'N'}">checked</c:if>/>
            <label for="radio_2">국내음반</label>
            <input type="radio" name="impYn" id="radio_3" value="Y" onclick="location.href='?impYn=Y&<ui:param skip="page,impYn" />'" <c:if test="${c.impYn eq 'Y'}">checked</c:if>/>
            <label for="radio_3">수입음반</label>
        </div>
    </c:if>
    <div class="tbl_top">
        <div class="f_left">
            <ul class="tab_btn02">
                <li<c:if test="${empty c.order || c.order eq 'rlseDesc'}"> class="active"</c:if>><a href="?order=rlseDesc&<ui:param skip="page,order" />">최신등록순</a></li>
                <li<c:if test="${c.order eq 'saleDesc'}"> class="active"</c:if>><a href="?order=saleDesc&<ui:param skip="page,order" />">최근판매량</a></li>
                <li<c:if test="${c.order eq 'priceAsc'}"> class="active"</c:if>><a href="?order=priceAsc&<ui:param skip="page,order" />">낮은가격순</a></li>
                <li<c:if test="${c.order eq 'priceDesc'}"> class="active"</c:if>><a href="?order=priceDesc&<ui:param skip="page,order" />">높은가격순</a></li>
            </ul>
        </div>
        <div class="btn_r">
            <ul class="tab_btn02">
                <li<c:if test="${empty c.saleYn}"> class="active"</c:if>><a href="?saleYn=&<ui:param skip="page,saleYn" />">품절포함</a></li>
                <li<c:if test="${c.saleYn eq 'Y'}"> class="active"</c:if>><a href="?saleYn=Y&<ui:param skip="page,saleYn" />">품절제외</a></li>
            </ul>
            <ul class="tab_btn02">
                <li<c:if test="${empty c.listSize || c.listSize eq '20'}"> class="active"</c:if>><a href="?listSize=20&<ui:param skip="page,listSize" />">20개</a></li>
                <li<c:if test="${c.listSize eq '50'}"> class="active"</c:if>><a href="?listSize=50&<ui:param skip="page,listSize" />">50개</a></li>
                <li<c:if test="${c.listSize eq '100'}"> class="active"</c:if>><a href="?listSize=100&<ui:param skip="page,listSize" />">100개</a></li>
            </ul>
        </div>
    </div>
    <!-- paging -->
    <div class="paging"><ui:pagination name="pageHolder" url="?" parameters="order,impYn,saleYn,listSize"/></div>
    <!-- //paging -->
    <div class="list_tool_top mgt30">
        <a href="javascript://" onclick="addRecordsCart('chkRecord')" class="btn_type08">장바구니에 담기</a>
    </div>
    <!-- 리스트 -->
    <div class="p_list02">
        <ul>
           <c:if test="${empty list}"><li class="t_center mgt20 mgb20"><img src="${imageServer}/images/common/no_result.gif" alt="상품이 존재하지 않습니다" /></li></c:if>
            <c:forEach items="${list}" var="l" varStatus="s">
                <li>
                    <div class="cover"><!-- 2014-10-02 수정 -->
                        <div>
                            <a href="/ht/record/detail/${l.sellPrdtBcode}" title="새창열림">
                                <ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode }" width="${l.sellPrdtGbn eq 'R'?'96':'63'}" height="96" alt="${l.rcrdName}" />
                            </a>
                            <a href="/ht/record/detail/${l.sellPrdtBcode}" target="_blank" title="새창열림" class="blank"><span>새창</span></a>
                        </div>
                        <span class="label">
                            <c:if test="${l.impYn eq 'Y'}"><img src="${imageServer}/images/renewal/common/txt_label01.gif" alt="수입" /></c:if>
                            <c:if test="${l.rcrdStat eq '9'}"><img src="${imageServer}/images/renewal/common/txt_label02.gif" alt="예약" /></c:if>
                        </span>
                    </div>
                    <div class="p_txt">
                        <div class="txt_info">
                            <a href="/ht/record/detail/${l.sellPrdtBcode}" class="tit">${l.artiName} - ${l.rcrdName}</a>
                            <span class="artist">
                                ${l.artiName}  |  ${l.makerName }
                                <c:if test="${not empty l.okdate && l.okdate ne '00000000'}">  |  <ui:mask pattern="####년 ##월">${l.okdate}</ui:mask></c:if>
                                <c:if test="${empty l.okdate || l.okdate eq '00000000'}">  |  <ui:mask pattern="####년 ##월">${l.rlseDt}</ui:mask></c:if>
                            </span>
                        </div>
                        <span class="price">
                            <c:if test="${l.lastDcPrice < l.prdtSellPrice}">
                                <c:set var="savedPrice" value="${l.lastDcPrice * l.prdtSavedRate / 100}"/>
                                <span class="ori_price"><fmt:formatNumber type="number" value="${l.prdtSellPrice}"/></span>
                                <span class="dis_price"><strong><fmt:formatNumber type="number" value="${l.lastDcPrice}"/></strong> (${hfn:rate(l.prdtSellPrice, l.lastDcPrice)}%)</span> |
                            </c:if> 
                            <c:if test="${l.lastDcPrice >= l.prdtSellPrice}">
                                <c:set var="savedPrice" value="${l.prdtSellPrice * l.prdtSavedRate / 100}"/>
                                <span class="dis_price"><strong><fmt:formatNumber type="number" value="${l.prdtSellPrice}"/></strong></span>
                            </c:if>
                            <c:if test="${l.prdtSavedRate > 0}">
                                <span class="save_price"><fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" pattern=",###" />원 (${l.prdtSavedRate}%적립)</span>
                            </c:if>
                        </span>
                    </div>
                    <div class="down">
                        <c:if test="${l.saleYn eq 'Y'}">
                            <div class="chk_wrap">
                                <input name="chkRecord" type="checkbox" title="${l.sellPrdtBcode}" />
                                <input type="hidden" name="chkRecord_${l.sellPrdtBcode}" value="${l.rcrdCd}" />
                                 수량 <input name="${l.sellPrdtBcode}_prdt_count" type="text" maxlength="4" title="수량입력" value="1"/>
                            </div>
                            <a href="javascript://" onclick="addRecordCart('${l.sellPrdtBcode}')" class="btn_type01">장바구니</a>
                            <a href="javascript://" onclick="addRecordBuy('${l.sellPrdtBcode}')" class="btn_type02">바로구매</a>
                        </c:if>
                        <c:if test="${l.outOfStockMailYn eq 'Y' and isLogin}"><a href="javascript://" onclick="addRecordStockedInfoRequest('${l.rcrdCd}')" class="btn_type02">알림예약</a></c:if>
                        <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="btn_type02 zzim"><span>좋아요</span></a>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
    <!-- //리스트 -->

    <div class="list_tool_bottom">
        <a href="javascript://" onclick="addRecordsCart('chkRecord')" class="btn_type08">장바구니에 담기</a>
    </div>

    <!-- paging -->
    <div class="paging mgt40"><ui:pagination name="pageHolder" url="?" parameters="order,impYn,saleYn,listSize"/></div>
    <!-- //paging -->
</div>
</body>
</html>