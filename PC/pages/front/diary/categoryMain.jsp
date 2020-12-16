<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="diary"/>
<html>
<head>
<script type="text/javascript">
jQuery(function($){
    $(".option-box a").click(function(e){
        e.preventDefault();
        var checked = $(this).hasClass("active");
        var optn = $(this).attr("href");
        optnId = optn.split("=")[0];
        optnValue = optn.split("=")[1];
        if(optnId == "#benefitChk"){
            if (optnValue == "All"){
                $(".optn-benefit").val(!checked);
            }else{
                $("#benefitChkAll").val(false);
            }
            $(optnId+optnValue).val(!checked);
        }else if (optnId == "#ctgrId"){
            $("#listOption").attr("action", "/ht/diary/category/"+optnValue);
        }else{
            $("#listOption").find(optnId).val(optnValue);
        }
        if(checked)    $(this).removeClass("active");
        else           $(this).addClass("active");
        $("#listOption").submit();
    });
    
    
    $(document).ready(function(){
        // GNB 위치 체크
        $("#snb<ui:lpad length="2" padChar="0">${category.gnbOrder}</ui:lpad>").addClass("active");
        $("#snb${fn:substring(c.themeCtgrId, 0, 8)}").addClass("active");
        // productListType가 B면 처음접근, C면 두번 이상 접근
        // C면 위치 스크롤
        var productListType = "${c.productListType}";
        if(productListType == "C"){
            $("html,body").scrollTop($('#listOption').offset().top-35);
        }else{
            $("html,body").scrollTop($('#snb01').offset().top);
        }
    });
});
</script>
</head>
<body>
<div class="prod_list box_wrap diary-best category_main">
    <ul class="box_gray03">
        <li class="first"><img src="${imageServer}/images/diary/2016/sub_title${category.ctgrId}.png" alt="${category.ctgrName}"/></li>
        <c:forEach items="${listBest}" var="l" varStatus="st" end="3">
            <li style="width : 140px; margin-right : 40px;" >
                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                    <p class="img"><ui:image src="${l.prdtImgUrl}" server="product" size="200" style="width:140px;height:140px;" alt="${l.prdtName}"/></p>
                    <span class="artist txt_line1">${l.brandEngName}</span>
                    <span class="tit">${l.prdtName}</span>
                    <em class="price">
                        <c:if test="${l.basePrdtSellPrice > l.lastCpnPrice}">
                            <span class="dc"><fmt:formatNumber value="${l.basePrdtSellPrice}" type="number" /></span>
                            <span class="sale"><fmt:formatNumber value="${l.lastCpnPrice}" pattern=",###" /></span>
                            <span class="pc">${hfn:rate(l.basePrdtSellPrice, l.lastCpnPrice)}%</span>
                        </c:if>
                        <c:if test="${l.basePrdtSellPrice <= l.lastCpnPrice}">
                            <span class="sale"><fmt:formatNumber value="${l.basePrdtSellPrice}" type="number" /></span>
                        </c:if>
                    </em>
                </a>
            </li>
        </c:forEach>
    </ul>
</div><!-- end second -->
<p class="main_bg_line02"></p>
<form id="listOption" action="?" method="get">
<input type="hidden" name="productOrderBy" id="productOrderBy" value="${c.productOrderBy}">
<input type="hidden" name="productListType" id="productListType" value="C">
<input type="hidden" name="listSize" id="listSize" value="${c.listSize}">
<input type="hidden" name="benefitChkAll" id="benefitChkAll" value="${c.benefitChk1}">
<input type="hidden" name="benefitChk1" class="optn-benefit" id="benefitChk1" value="${c.benefitChk1}">
<input type="hidden" name="benefitChk2" class="optn-benefit" id="benefitChk2" value="${c.benefitChk2}">
<input type="hidden" name="benefitChk3" class="optn-benefit" id="benefitChk3" value="${c.benefitChk3}">
<input type="hidden" name="benefitChk4" class="optn-benefit" id="benefitChk4" value="${c.benefitChk4}">

</form>
<div class="view_opt">
    <div class="f_left option-box">
        <%-- <div class="lb_select size10">
            <p class="lb_select_box">
                <span>
                    <c:if test="${c.themeCtgrId eq category.ctgrId}">${category.ctgrName}</c:if>
                    <c:forEach items="${childCategory}" var="l" varStatus="st">
                        <c:if test="${c.themeCtgrId eq l.ctgrId}">${l.ctgrName}</c:if>
                    </c:forEach>
                </span>
            </p>
            <div class="lb_select_list">
                <a href="#ctgrId=${category.ctgrId}" class="${c.themeCtgrId eq category.ctgrId?'active':''}">${category.ctgrName}</a>
                <c:forEach items="${childCategory}" var="l" varStatus="st">
                    <a href="#ctgrId=${l.ctgrId}" class="${c.themeCtgrId eq l.ctgrId?'active':''}">${l.ctgrName}</a>
                </c:forEach>
            </div>
        </div> --%>
    </div>
    <div class="f_right option-box">
        <div class="f_left lb_check">
            <a href="#benefitChk=All" class="${c.benefitChkAll?'active':''}">전체</a>
            <a href="#benefitChk=1" class="${c.benefitChkAll || c.benefitChk1?'active':''}">무료배송</a>
            <a href="#benefitChk=2" class="${c.benefitChkAll || c.benefitChk2?'active':''}">쿠폰</a>
            <a href="#benefitChk=3" class="${c.benefitChkAll || c.benefitChk3?'active':''}">할인</a>
            <a href="#benefitChk=4" class="${c.benefitChkAll || c.benefitChk4?'active':''}">핫트랙스배송</a>
        </div>
        <div class="f_left lb_select size6">
            <p class="lb_select_box">
                <span>
                    <c:if test="${c.productOrderBy eq 'P'}">인기상품순</c:if>
                    <c:if test="${c.productOrderBy eq 'R'}">신상품순</c:if>
                    <c:if test="${c.productOrderBy eq 'L'}">낮은가격순</c:if>
                    <c:if test="${c.productOrderBy eq 'H'}">높은가격순</c:if>
                    <c:if test="${c.productOrderBy eq 'T'}">높은할인율순</c:if>
                </span>
            </p>
            <div class="lb_select_list">
                <a href="#productOrderBy=P" class="${c.productOrderBy eq 'P'?'active':''}">인기상품순</a>
                <a href="#productOrderBy=R" class="${c.productOrderBy eq 'R'?'active':''}">신상품순</a>
                <a href="#productOrderBy=L" class="${c.productOrderBy eq 'L'?'active':''}">낮은가격순</a>
                <a href="#productOrderBy=H" class="${c.productOrderBy eq 'H'?'active':''}">높은가격순</a>
                <a href="#productOrderBy=T" class="${c.productOrderBy eq 'T'?'active':''}">높은할인율순</a>
            </div>
        </div>
        <div class="f_left lb_select size3">
            <p class="lb_select_box">
                <span>
                    <c:if test="${c.listSize eq '40'}">40개</c:if>
                    <c:if test="${c.listSize eq '80'}">80개</c:if>
                    <c:if test="${c.listSize eq '120'}">120개</c:if>
                </span>
            </p>
            <div class="lb_select_list">
                <a href="#listSize=40" class="${c.listSize eq '40'?'active':''}">40개</a>
                <a href="#listSize=80" class="${c.listSize eq '80'?'active':''}">80개</a>
                <a href="#listSize=120" class="${c.listSize eq '120'?'active':''}">120개</a>
            </div>
        </div>
    </div>
</div>
<c:if test="${empty listProduct }">
   <div class="t_center mgt25 mgb25"><img src="${imageServer}/images/common/no_result.gif" alt="상품이 존재하지 않습니다" /></div>
</c:if>
<div class="prod_list_normal diary_product">
    <c:forEach items="${listProduct}" varStatus="s1" step="4">
        <ul>
            <c:forEach items="${listProduct}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
                <li>
                    <span class="img">
                        <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}"><ui:image src="${l.productImageUrl}" src2="${l.productImageUrl2}" server="product" size="200" alt="${l.prdtName}" ratingCode="${l.nyoSellBanYn}"/></a>
                        <div class="hide_util">
                            <a href="javascript://" onclick="productPreview('${l.sellPrdtBcode}')" class="zoom"><span>확대</span></a>
                            <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                            <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                        </div>
                    </span>
                    <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                        <span class="make">${l.brandEngName}</span>
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
                        <em class="price" style="text-align: left;">
                            <c:if test="${l.prdtSellPrice > l.lastCpnPrice}"><span class="dc"><fmt:formatNumber value="${l.prdtSellPrice}" pattern="#,###"/></span></c:if>
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
<div class="paging"><ui:pagination name="pageHolder" url="?" parameters="themeCtgrId,benefitGbn,productOrderBy,productListType,listSize,benefitChkAll,benefitChk1,benefitChk2,benefitChk3,benefitChk4"/></div>
</body>
</html>