<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<c:set var="ctgrName"><ui:category id="${c.ctgrId}" full="false"/></c:set>
<title>${ctgrName} - HOTTRACKS</title>
<script type="text/javascript" src="/js/fn_htts_slide.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    slideDiv(".main_sec4", 6000, ".main_sec4");
    
    $.ajax({
        type: "GET"
        ,url: "/ht/getPopupList"
        ,data: {dispGbn : 'C', ctgrId : '${c.ctgrId}'}
        ,dataType: "json"
        ,success: function getPopup(data) {
            if(data && data.popupList) {
                var popupList = data.popupList;
                for(var i=0;i<popupList.length;i++) {
                    var options =   "width=" + popupList[i].popupSizeX
                                  + ",height=" + (popupList[i].popupSizeY + 20)
                                  + ",left=" + popupList[i].popupPosX
                                  + ",top=" + popupList[i].popupPosY;
                    window.open("/ht/getPopup?popupseq="+popupList[i].popupSeq, "giftCategoryPopup" + i, options);
                }
            }
        }
        ,error: function(xhr, status, error) {
            alert("<fmt:message key='error.common.system'/>");
        }
    });
});
</script>
</head>
<body>

<!-- Location -->
<div class="page_location shop">
    <div class="loc">
        <a href="/" class="home">Home</a>
        <c:forEach varStatus="st" begin="6" end="${fn:length(c.ctgrId)}" step="2">
            <c:if test="${st.last}"><em><ui:category id="${ctgrId}" full="false"/></em></c:if>
            <c:if test="${!st.last && st.first}"><a href="/ht/gift/giftCategoryMain?ctgrId=${fn:substring(c.ctgrId, 0, st.index)}"><ui:category id="${fn:substring(c.ctgrId, 0, st.index)}" full="false"/></a></c:if>
            <c:if test="${!st.last && !st.first}"><a href="/ht/gift/giftCategorySub?ctgrId=${fn:substring(c.ctgrId, 0, st.index)}"><ui:category id="${fn:substring(c.ctgrId, 0, st.index)}" full="false"/></a></c:if>
        </c:forEach>
    </div>
    <a href="/ht/welcome/hotEventMain?ctgrId=${fn:substring(c.ctgrId, 0, 6)}" class="more_event"><span><ui:category id="${fn:substring(c.ctgrId, 0, 6)}" full="false"/> 이벤트 더보기</span></a>
    <%-- <c:if test="${fn:startsWith(c.ctgrId, '000020')}"> 
        <img src="${imageServer}/images/diary/2017/bnr_diary_top.jpg" alt="2017 다이어리배너" style="margin: 10px 0;" usemap="#diaryMap"/>
        <map name="diaryMap" id="diaryMap">
            <area shape="rect" coords="25,6,731,73" href="/ht/diary/main" />
            <area shape="rect" coords="735,7,928,72" href="/ht/biz/eventDetail?eventId=40651" />
        </map>
    </c:if> --%>
</div>
<!-- //Location -->

<!-- Office_design -->
<div class="office_design02">
    <c:import url="/menu/gift/lnb">
        <c:param name="ctgrId">${c.ctgrId}</c:param>
    </c:import>
    
    <!-- 서브배너 -->
    <div class="sub_banner">
        <!-- 왼쪽배너 -->
        <div class="main_sec4">
            <ul class="main_slide_btn slide_view">
                <c:forEach items="${list1St}" var="l" varStatus="st">
                    <li class="main_slide_img"><ui:banner bannerImageUrl="${l.bnrImgUrl}" bnrLinkUrl="${l.bnrLnkUrl}" bnrSeq="${l.bnrSeq}" bnrTgtGbn="L" newWdwYn="${l.bnrNewWinYn}" alt="${l.bnrImgAlt}"/></li>
                </c:forEach>
            </ul>
            <ul class="main_slide_navi">
                <c:forEach items="${list1St}" var="l" varStatus="st">
                    <li class="slide_navi ${st.first?'active':''}"><a href="javascript://"><img src="${imageServer}/images/common/ic_navi0${st.count}.png"/></a></li>
                </c:forEach>
                <li class="slide_ctrl">
                    <a class="stop" href="javascript://">일시정지</a>
                </li>
            </ul>
        </div>
        <!-- //왼쪽배너 -->
        <!-- //오른쪽 상품 전시 -->
        <div class="main_sec5">
            <ul>
                <c:forEach items="${list2St}" var="l" varStatus="st" end="1">
                    <li>
                        <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                            <span class="img"><ui:image src="${l.prdtImgUrl}" server="product" size="120" alt="${l.prdtName}" ratingCode="${l.nyoSellBanYn}"/></span>
                            <span class="tit">${l.prdtName}</span>
                            <em class="price"><span class="sale"><fmt:formatNumber type="number" value="${l.lastCpnPrice}"/></span></em>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <!-- //오른쪽 상품 전시 -->
    </div>
    <!-- //서브배너 -->
    
</div>
<!-- //Office_design -->

<p class="main_bg_line03"></p>

<!-- prod_col2 -->
<c:if test="${not empty list3St}">
<div class="office_design03">
    <ul>
        <c:forEach items="${list3St}" var="l" varStatus="st" end="3">
            <li id="dsn03_bnr0${st.count}"><ui:banner bannerImageUrl="${l.bnrImgUrl}" bnrLinkUrl="${l.bnrLnkUrl}" bnrSeq="${l.bnrSeq}" bnrTgtGbn="L" newWdwYn="${l.bnrNewWinYn}" alt="${l.bnrImgAlt}"/></li>
        </c:forEach>
    </ul>
</div>
</c:if>
<!-- //prod_col2 -->

<!--Md's pick -->
<div class="mds_pick tab_wrap">
    <h2 class="tit"><img src="${imageServer}/images/renewal/shop/sub_tit02.gif" alt="Md's pick" /></h2>
    <ul class="mds_tab tab_btn_clk" style="line-height:14px;">
        <li><a href="#mp01" class="on"><span>${mst4St.title}</span></a></li>
        <li><a href="#mp02"><span>${mst5St.title}</span></a></li>
        <li><a href="#mp03"><span>${mst6St.title}</span></a></li>
        <li><a href="#mp04"><span>${mst7St.title}</span></a></li>
    </ul>
    <div class="mds_pannels tab_pannels">
        <c:forEach begin="0" end="3" varStatus="s1">
            <c:if test="${s1.index eq 0}"><c:set var="listBnr" value="${list4StBnr}"/><c:set var="listPrdt" value="${list4StPrdt}"/></c:if>
            <c:if test="${s1.index eq 1}"><c:set var="listBnr" value="${list5StBnr}"/><c:set var="listPrdt" value="${list5StPrdt}"/></c:if>
            <c:if test="${s1.index eq 2}"><c:set var="listBnr" value="${list6StBnr}"/><c:set var="listPrdt" value="${list6StPrdt}"/></c:if>
            <c:if test="${s1.index eq 3}"><c:set var="listBnr" value="${list7StBnr}"/><c:set var="listPrdt" value="${list7StPrdt}"/></c:if>
            <div id="mp0${s1.count}" class="pannel">
                <ul>
                    <c:forEach items="${listBnr}" var="l" varStatus="st" end="0">
                        <li class="c1"><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span><ui:image src="${l.bnrImgUrl}" style="width:293px;height:408px;" alt="${l.bnrImgAlt}"/></span></a></li>
                    </c:forEach>
                    <c:forEach items="${listPrdt}" var="l" varStatus="st" end="5">
                        <li class="c${st.count+1}">
                            <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                                <span class="img"><ui:image src="${l.prdtImgUrl}" server="product" ratingCode="${l.nyoSellBanYn}" size="150" alt="${l.prdtName}" /></span>
                                <span class="tit">${l.prdtName}</span>
                                <em class="price"><span class="sale"><fmt:formatNumber type="number" value="${l.lastCpnPrice}"/></span></em>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </c:forEach>
    </div>
    
</div>
<!-- //Md's pick -->
<p class="main_bg_line03"></p>

<!-- prod_col2 -->
<c:if test="${not empty list8St}">
<div class="office_design04">
    <ul class="list">
        <c:forEach items="${list8St}" var="l" varStatus="st" end="2">
            <li>
                <a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>>
                    <span class="img"><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" style="width:290px;height:140px;"/></span>
                    <span class="tit">
                        <strong>${l.bnrTitle}</strong>
                        <em>${l.bnrSubTitle}</em>
                    </span>
                </a>
            </li>
        </c:forEach>
    </ul>
</div>
<!-- //prod_col2 -->
</c:if>

<div class="prod_recome tab_wrap">
    <div class="tab_recome">
        <ul class="tab_btn_clk">
            <li><a href="#pr01" ><span>${mstBest.title}</span></a></li>
            <li><a href="#pr05" class="on"><span>For You</span></a></li>
            <li><a href="#pr04"><span>${mstSale.title}</span></a></li>
            <li><a href="#pr02"><span>${mstNew.title}</span></a></li>
            <li><a href="#pr03"><span>${mstBrand.title}</span></a></li>
        </ul>
    </div>

    <div class="recome_pannels tab_pannels">
    	<!-- 레코벨 추천상품 start-->
        <div id="pr05" class="pannel">
            <c:forEach items="${listRecobell}" varStatus="s2" step="4" end="7">
                <ul>
                    <c:forEach items="${listRecobell}" var="l" varStatus="st" begin="${s2.index}" end="${s2.index+3}">
                        <li>
                            <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${l.sellPrdtBcode}?foo=bar&rccode=pc_category1"></c:if>
                       		<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}&foo=bar&rccode=pc_category1"></c:if>
                                <span class="img">
	                                <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="A" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'120':'79'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></c:if>
	                       			<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"><ui:image src="${l.prdtImgUrl}" server="product" size="120" alt="${l.prdtName}" ratingCode="${l.nyoSellBanYn}" /></c:if>
                                </span>
                                <span class="tit">${l.prdtName}</span>
                                <em class="price">
                                    <span class="sale"><fmt:formatNumber value="${l.lastCpnPrice}" pattern="#,###"/>원</span>
                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                    <c:if test="${l.prdtStatCode eq 'C0312' && l.basePrdtSellPrice > l.lastCpnPrice}"><span class="pc">[<fmt:formatNumber type="number">${hfn:rate(l.basePrdtSellPrice, l.lastCpnPrice)}</fmt:formatNumber>%]</span></c:if>
                                </em>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </c:forEach>
        </div>
        <!-- 레코벨 추천상품 end-->
        <div id="pr01" class="pannel">
            <c:forEach items="${listBest}" varStatus="s2" step="4" end="7">
                <ul>
                    <c:forEach items="${listBest}" var="l" varStatus="st" begin="${s2.index}" end="${s2.index+3}">
                        <li>
                            <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                                <span class="img"><ui:image src="${l.prdtImgUrl}" server="product" size="120" alt="${l.prdtName}" ratingCode="${l.nyoSellBanYn}" /></span>
                                <span class="tit">${l.prdtName}</span>
                                <em class="price">
                                    <span class="sale"><fmt:formatNumber value="${l.lastCpnPrice}" pattern="#,###"/>원</span>
                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                    <c:if test="${l.prdtStatCode eq 'C0312' && l.basePrdtSellPrice > l.lastCpnPrice}"><span class="pc">[<fmt:formatNumber type="number">${hfn:rate(l.basePrdtSellPrice, l.lastCpnPrice)}</fmt:formatNumber>%]</span></c:if>
                                </em>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </c:forEach>
        </div>
        <div id="pr02" class="pannel">
            <c:forEach items="${listNew}" varStatus="s2" step="4" end="7">
                <ul>
                    <c:forEach items="${listNew}" var="l" varStatus="st" begin="${s2.index}" end="${s2.index+3}">
                        <li>
                            <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                                <span class="img"><ui:image src="${l.prdtImgUrl}" server="product" size="120" alt="${l.prdtName}" ratingCode="${l.nyoSellBanYn}"/></span>
                                <span class="tit">${l.prdtName}</span>
                                <em class="price">
                                    <span class="sale"><fmt:formatNumber value="${l.lastCpnPrice}" pattern="#,###"/>원</span>
                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                    <c:if test="${l.prdtStatCode eq 'C0312' && l.basePrdtSellPrice > l.lastCpnPrice}"><span class="pc">[<fmt:formatNumber type="number">${hfn:rate(l.basePrdtSellPrice, l.lastCpnPrice)}</fmt:formatNumber>%]</span></c:if>
                                </em>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </c:forEach>
        </div>
        <div id="pr03" class="pannel">
            <c:forEach items="${listBrand}" varStatus="s2" step="4" end="7">
                <ul>
                    <c:forEach items="${listBrand}" var="l" varStatus="st" begin="${s2.index}" end="${s2.index+3}">
                        <li>
                            <a href="/ht/hot/brandDetail?brandId=${l.brandId}">
                                <span class="img"><ui:image src="${l.prdtImgUrl}" server="product" size="120" alt="${l.prdtName}" ratingCode="${l.nyoSellBanYn}"/></span>
                                <span class="tit">${l.brandEngName}</span>
                                <em class="brandName">${l.brandName}</em>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </c:forEach>
        </div>
        <div id="pr04" class="pannel">
            <c:forEach items="${listSale}" varStatus="s2" step="4" end="7">
                <ul>
                    <c:forEach items="${listSale}" var="l" varStatus="st" begin="${s2.index}" end="${s2.index+3}">
                        <li>
                            <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                                <span class="img"><ui:image src="${l.prdtImgUrl}" server="product" size="120" alt="${l.prdtName}" ratingCode="${l.nyoSellBanYn}" /></span>
                                <span class="tit">${l.prdtName}</span>
                                <em class="price">
                                    <span class="sale"><fmt:formatNumber value="${l.lastCpnPrice}" pattern="#,###"/>원</span>
                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                    <c:if test="${l.prdtStatCode eq 'C0312' && l.basePrdtSellPrice > l.lastCpnPrice}"><span class="pc">[<fmt:formatNumber type="number">${hfn:rate(l.basePrdtSellPrice, l.lastCpnPrice)}</fmt:formatNumber>%]</span></c:if>
                                </em>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </c:forEach>
        </div>
    </div>
</div>
</body>
</html>