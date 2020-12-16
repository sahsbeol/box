<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/jquery-ui-1.8.16.custom.css"/>
<script type="text/javascript" src="/js/jquery-ui-1.8.14.custom.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    $("#datepicker").datepicker({
        showOn: "button",
        buttonImage: "${imageServer}/images/renewal/common/ico_carenda.gif",
        buttonText : "날짜조회",
        dateFormat : "yymmdd", 
        monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'], 
        showMonthAfterYear: true, 
        dayNamesMin: ['일','월','화','수','목','금','토'], 
        changeYear: false, 
        showButtonPanel: false, 
        onSelect : function(date){
            location.href = "?stdDt=" + date + "&<ui:param skip='stdDt' />";
        }
    }); 
});
</script>
</head>
<body>
<div class="cate03">
    <h2 class="tit"><img src="${imageServer}/images/renewal/shop/tit_record_best.gif" alt="베스트" /></h2>
    <c:if test="${c.bestRangeType ne 'C1006'}">
        <ul class="tab_best01">
            <li class="wid1"><a href="?recBestType=C0994&<ui:param skip="recBestType" />"<c:if test="${c.recBestType eq 'C0994'}"> class="on"</c:if>>온라인</a></li>
            <li class="wid2"><a href="?recBestType=C0995&<ui:param skip="recBestType" />"<c:if test="${c.recBestType eq 'C0995'}"> class="on"</c:if>>오프라인</a></li>
            <li class="wid3"><a href="?recBestType=C0996&<ui:param skip="recBestType" />"<c:if test="${c.recBestType eq 'C0996'}"> class="on"</c:if>>온/오프라인</a></li>
        </ul>
    </c:if>
    <c:if test="${fn:startsWith(category.cateId, '0003') }">
        <ul>
            <c:forEach items="${categoryListLeft}" var="l" varStatus="st">
                <li><a href="/ht/record/bestList/${l.cateId}?<ui:param skip="${leftSkipParam}" />"<c:if test="${category.cateId eq l.cateId}"> class="on"</c:if>>${l.cateName}</a></li>
            </c:forEach>
        </ul>
    </c:if>
    <c:if test="${fn:startsWith(category.cateId, '0004') }">
        <div class="tab_wrap">
            <ul class="tab_dvd tab_btn">
                <li><a href="#blu" class="on"><span>Blu-Ray</span></a></li>
                <li><a href="#dvd"><span>DVD</span></a></li>
            </ul>               
            <div class="tab_pannels"> 
                <div id="blu" class="pannel">
                    <ul>
                        <c:forEach items="${categoryListLeft1}" var="l" varStatus="st">
                            <li><a href="/ht/record/bestList/${l.cateId}?<ui:param />"<c:if test="${category.cateId eq l.cateId}"> class="on"</c:if>>${l.cateName}</a></li>
                        </c:forEach>
                     </ul>
                 </div>
                <div id="dvd" class="pannel" style="display:none">
                    <ul>
                        <c:forEach items="${categoryListLeft2}" var="l" varStatus="st">
                            <li><a href="/ht/record/bestList/${l.cateId}?<ui:param skip="${leftSkipParam}" />"<c:if test="${category.cateId eq l.cateId}"> class="on"</c:if>>${l.cateName}</a></li>
                        </c:forEach>
                     </ul>
                </div>
            </div>
        </div>
    </c:if>
</div>

<div class="list_section">
    <!-- Location -->
    <div class="page_location">
        <div class="loc">
            <c:if test="${fn:startsWith(category.cateId, '0003') }">
                <a href="/" class="home">Home</a><a href="/ht/recordMain">Cd </a><em>베스트</em>
            </c:if>
            <c:if test="${fn:startsWith(category.cateId, '0004') }">
                <a href="/" class="home">Home</a><a href="/ht/dvdMain">DVD </a><em>베스트</em>
            </c:if>
        </div>
    </div>
    <!-- //Location -->
    
    <ul class="tab_best02">
        <li><a href="?bestRangeType=C1001&<ui:param skip="bestRangeType,stdDt" />"<c:if test="${c.bestRangeType eq 'C1001'}"> class="on"</c:if>><span>실시간 베스트</span></a></li>
        <li><a href="?bestRangeType=C1002&<ui:param skip="bestRangeType,stdDt" />"<c:if test="${c.bestRangeType eq 'C1002'}"> class="on"</c:if>><span>일간 베스트</span></a></li>
        <li><a href="?bestRangeType=C1003&<ui:param skip="bestRangeType,stdDt" />"<c:if test="${c.bestRangeType eq 'C1003'}"> class="on"</c:if>><span>주간 베스트</span></a></li>
        <li><a href="?bestRangeType=C1004&<ui:param skip="bestRangeType,stdDt" />"<c:if test="${c.bestRangeType eq 'C1004'}"> class="on"</c:if>><span>월간 베스트</span></a></li>
        <li><a href="?bestRangeType=C1005&<ui:param skip="bestRangeType,stdDt" />"<c:if test="${c.bestRangeType eq 'C1005'}"> class="on"</c:if>><span>년간 베스트</span></a></li>
    </ul>
    
    <h3 class="tit03"><ui:code codeId="${c.bestRangeType}"/> 베스트</h3>
    <div class="tbl_top">
        <ul class="tab_rank">
            <c:if test="${fn:startsWith(c.ctgrId, '0003')}">
                <c:if test="${c.ctgrId eq '0003'}"><li>전체</li></c:if>
                <c:if test="${c.ctgrId ne '0003'}"><li>${category.cateName}</li></c:if>
            </c:if>
            <c:if test="${fn:startsWith(c.ctgrId, '0004')}">
                <c:if test="${c.ctgrId eq '000400' || c.ctgrId eq '000401' }"><li>전체</li></c:if>
                <c:if test="${c.ctgrId ne '000400' && c.ctgrId ne '000401' }"><li>${category.cateName}</li></c:if>
            </c:if>
            <c:if test="${c.bestRangeType eq 'C1001'}"><li>1~50위</li></c:if>
            <c:if test="${c.bestRangeType ne 'C1001'}"><li>1~100위</li></c:if>
        </ul>
        <c:if test="${c.bestRangeType eq 'C1001'}"><div class="date"><ui:mask pattern="####.##.##">${c.stdDt}</ui:mask></div></c:if>
        <c:if test="${c.bestRangeType eq 'C1002'}">
            <div class="date">
                <c:if test="${not empty stdDtPrev}">
                   <a href="?stdDt=${stdDtPrev}&<ui:param skip="stdDt" />" class="prev"><span>이전일</span></a>
                </c:if> 
                <ui:mask pattern="####.##.##">${c.stdDt}</ui:mask>
                <c:if test="${not empty stdDtNext}">
                   <a href="?stdDt=${stdDtNext}&<ui:param skip="stdDt" />" class="next"><span>다음일</span></a>
                </c:if> 
            </div>
            <span class="s_day"><input type="text" value="${c.stdDt}" id="datepicker" style="display:none;" /><label for="datepicker">날짜조회</label></span>
        </c:if>
        <c:if test="${c.bestRangeType eq 'C1003'}">
            <div class="date">
                <c:if test="${not empty stdDtPrev}">
                   <a href="?stdDt=${stdDtPrev}&<ui:param skip="stdDt" />" class="prev"><span>이전주</span></a>
                </c:if> 
                <fmt:formatDate value="${stdDtScope.startDate}" pattern="yyyy년 MM월 dd일" />
                ~
                <fmt:formatDate value="${stdDtScope.endDate}" pattern="yyyy년 MM월 dd일" />
                <c:if test="${not empty stdDtNext}">
                   <a href="?stdDt=${stdDtNext}&<ui:param skip="stdDt" />" class="next"><span>다음주</span></a>
                </c:if> 
            </div>
        </c:if>
        <c:if test="${c.bestRangeType eq 'C1004'}">
            <div class="date">
                <c:if test="${not empty stdDtPrev}">
                   <a href="?stdDt=${stdDtPrev}&<ui:param skip="stdDt" />" class="prev"><span>이전달</span></a>
                </c:if> 
                <c:if test="${not empty stdDtYear}">${stdDtYear}년</c:if>
                <c:if test="${not empty stdDtMonth}">${stdDtMonth}월</c:if>
                <c:if test="${not empty stdDtNext}">
                   <a href="?stdDt=${stdDtNext}&<ui:param skip="stdDt" />" class="next"><span>다음달</span></a>
                </c:if> 
            </div>
        </c:if>
    </div>

    <!-- paging -->
    <div class="paging">
        <ui:pagination name="pageHolder" url="?" parameters="listType,recBestType,bestRangeType,stdDt"/>
    </div>
    <!-- //paging -->

    <div class="list_tool_top mgt30">
        <a href="javascript://" onclick="addRecordsCart('chkRecord')" class="btn_type08">장바구니에 담기</a>
        <a href="/ht/record/bestListExcel/${c.ctgrId}?<ui:param />" class="btn_type08">엑셀로 리스트받기</a>
    </div>

    <!-- 리스트 -->
    <div class="p_list02">
        <ul class="tp_best">
            <c:forEach items="${list}" var="l" varStatus="sㅅ">
                <li>
                    <span class="rank">${l.rank}</span>
                    <div class="cover<c:if test="${l.sellPrdtGbn eq 'D'}"> type02</c:if>">
                        <a href="/ht/record/detail/${l.sellPrdtBcode}" target="_blank" title="새창열림">
                            <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="98" alt="${l.rcrdName}" ratingCode="${l.ratingCode}" /></c:if>
                            <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="64" alt="${l.rcrdName}" ratingCode="${l.ratingCode}" /></c:if>
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
                            <span class="artist">
                                ${l.artiName}  |  ${l.makerName}  |  <ui:mask pattern="####년 ##월">${l.rlseDt}</ui:mask>
                            </span>
                        </div>
                        <span class="price">
                            <c:if test="${l.priceReal < l.prdtSellPrice}">
                                <c:set var="savedPrice" value="${l.priceReal * l.prdtSavedRate / 100}"/>
                                <span class="ori_price"><fmt:formatNumber type="number" value="${l.prdtSellPrice}"/></span>
                                <span class="dis_price"><strong><fmt:formatNumber type="number" value="${l.priceReal}"/></strong> (${hfn:rate(l.prdtSellPrice, l.priceReal)}%)</span> |
                            </c:if> 
                            <c:if test="${l.priceReal >= l.prdtSellPrice}">
                                <c:set var="savedPrice" value="${l.prdtSellPrice * l.prdtSavedRate / 100}"/>
                                <span class="dis_price"><strong><fmt:formatNumber type="number" value="${l.prdtSellPrice}"/></strong></span>
                            </c:if>
                            <c:if test="${l.prdtSavedRate > 0}">
                                <span class="save_price"><fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" pattern=",###" />원 (${l.prdtSavedRate}%적립)</span>
                            </c:if>
                            <c:if test="${l.saleYn ne 'Y'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
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
        <a href="/ht/record/bestListExcel/${c.ctgrId}?<ui:param />" class="btn_type08">엑셀로 리스트받기</a>
    </div>

    <!-- paging -->
    <div class="paging mgt40">
        <ui:pagination name="pageHolder" url="?" parameters="listType,recBestType,bestRangeType,stdDt"/>
    </div>
    <!-- //paging -->
</div>
</body>
</html>