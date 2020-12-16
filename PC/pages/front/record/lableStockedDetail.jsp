<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><ui:cut isStripHtml="true">${label.clssName}</ui:cut> - HOTTRACKS</title>
</head>
<body>
<!-- 가요 lnb -->
<div class="cate03">
    <h2 class="tit"><img src="${imageServer}/images/renewal/shop/tit_lable_stock.gif" alt="수입음반 입고안내" /></h2>
    <ul>
        <li><a href="#" class="on">레이블 입고 안내</a></li>
    </ul>
</div>

<div class="list_section">
    <!-- Location -->
    <div class="page_location">
        <div class="loc">
            <a href="/" class="home">Home</a><a href="/ht/biz/record/recordCategoryMain?ctgrId=0003">CD</a><a href="/ht/record/lableStockedList">수입음반 입고안내</a><em>레이블 입고 안내</em>
        </div>
    </div>
    <!-- //Location -->
    
    <h3 class="tit03">${label.clssName}</h3>
    
    <div class="list_tool_top">
        <a href="javascript://" onclick="addRecordsCart('chkRecord')" class="btn_type08">장바구니에 담기</a>
    </div>
    <!-- 리스트 -->
    <div class="p_list02">
        <ul>
           <c:if test="${empty list}"><li class="t_center mgt20 mgb20"><img src="${imageServer}/images/common/no_result.gif" alt="상품이 존재하지 않습니다" /></li></c:if>
            <c:forEach items="${list}" var="l" varStatus="s">
                <li>
                    <div class="cover">
                        <a href="/ht/record/detail/${l.sellPrdtBcode}" target="_blank" title="새창열림">
                            <ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.ratingCode }" width="${l.sellPrdtGbn eq 'R'?'96':'63'}" height="96" alt="${l.rcrdName}" />
                            <span class="blank"><span>새창</span></span>
                        </a>
                        <span class="label">
                            <c:if test="${l.impYn eq 'Y'}"><img src="${imageServer}/images/renewal/common/txt_label01.gif" alt="수입" /></c:if>
                            <c:if test="${l.rcrdStat eq '9'}"><img src="${imageServer}/images/renewal/common/txt_label02.gif" alt="예약" /></c:if>
                        </span>
                    </div>
                    <div class="p_txt">
                        <div class="txt_info">
                            <a href="/ht/record/detail/${l.sellPrdtBcode}" class="tit">${l.artiName} - ${l.commTitle}</a>
                            <span class="artist">${l.artiName}  |  ${l.makerName }  |  <ui:mask pattern="####년 ##월">${l.rlseDt}</ui:mask></span>
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
    <div class="paging mgt40"><ui:pagination name="pageHolder" url="/ht/record/lableStockedDetail" parameters="labelClassId, listSize"/></div>
    <!-- //paging -->
</div>
</body>
</html>