<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
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
        }else{
            $("#listOption").find(optnId).val(optnValue);
        }
        if(checked)    $(this).removeClass("active");
        else           $(this).addClass("active");
        goNewDiary("1");
    });
    
    
    $("select.lb_option").change(function(e){
        e.preventDefault();
        var selected = $("select.lb_option option:selected").val();
        //console.log("낮/높 :" + selected);
        
        for(var i=0; i<2 ; i++){
            $(".f_right option").removeClass("active");
            $("#listOption input.optn-order").val(false); // main = listOption
        }
        $("#listOption input[name="+selected+"]").val(true);
        
        goNewDiary("1");
    });
    
    $("select.lb_option2").change(function(e){
        e.preventDefault();
        var selected = $("select.lb_option2 option:selected").val();
        var index = $("select.lb_option2 option").index($(".lb_option2 option:selected"));
        
        $("#listOption .optn_theme").val(selected);
        
        goNewDiary("1");
    });
    
});
</script>
<!--  #listNewArea -->
<div class="prod_list_normal diary_mnew mgt20">
    <div id="loadingbar" style="position:absolute; display:none; left: 0; top: 0; width: 100%; height: 100%; z-index: 99; min-height:124px; background: url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2018/bg_layer01.png');"></div>
    <img id="loading" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2018/ajax-loader.gif" style="position: absolute; left: 45%; top: 50%; z-index:99; width: 100px;height: 100px; display:none; "/>
    <div class="option-box" style="position: absolute; top: -25px; left: 0px;">
        <div class="f_left lb_check">
            <a href="#benefitChk=1" class="${c.benefitChk1?'active':''}">무료배송</a>
            <a href="#benefitChk=2" class="${c.benefitChk2?'active':''}">쿠폰</a>
            <a href="#benefitChk=3" class="${c.benefitChk3?'active':''}">할인</a>
            <a href="#benefitChk=4" class="${c.benefitChk4?'active':''}">핫트랙스배송</a>
        </div>
        <div class="f_right" >
            <select class="lb_option2">
                 <option value="AL"<c:if test="${c.themeCtgrId eq 'AL' }"> selected="selected"</c:if>>전체</option>
                 <option value="000000"<c:if test="${c.themeCtgrId eq '000000' }"> selected="selected"</c:if>>날짜형</option>
                 <option value="000001"<c:if test="${c.themeCtgrId eq '000001' }"> selected="selected"</c:if>>만년형</option>
                 <option value="00000102"<c:if test="${c.themeCtgrId eq '00000102' }"> selected="selected"</c:if>>먼슬리</option>
                 <option value="00000101"<c:if test="${c.themeCtgrId eq '00000101' }"> selected="selected"</c:if>>위클리</option>
            </select>
            <select class="lb_option">
            	<option value="ulProductOrderBy1"<c:if test="${c.ulProductOrderBy1 eq true }"> selected="selected"</c:if>>신상품순</option>
                <option value="ulProductOrderBy2"<c:if test="${c.ulProductOrderBy2 eq true }"> selected="selected"</c:if>>낮은가격순</option>
                <option value="ulProductOrderBy3"<c:if test="${c.ulProductOrderBy3 eq true }"> selected="selected"</c:if>>높은가격순</option>
            </select>
        </div>
    </div>  <!--  옵션 박스 -->
    <ul class="first_ul"><!-- 1 -->
    <c:forEach items="${list}" var="l"  varStatus="s1" begin="0" end="1" >
        <li>
            <span class="img">
                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" title="${l.prdtName}"><ui:image src="${l.prdtImgUrl}" size="400" server="product" alt="${l.prdtName}"/></a>
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
                    <c:if test="${l.basePrdtSellPrice > l.lastCpnPrice}"><span class="dc"><fmt:formatNumber type="number">${l.basePrdtSellPrice}</fmt:formatNumber></span></c:if>
                    <span class="sale"><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
                    <c:if test="${l.basePrdtSellPrice > l.lastCpnPrice}"><span class="pc">${hfn:rate(l.basePrdtSellPrice,l.lastCpnPrice)}%</span></c:if>
                </em>
            </a>
        </li>
    </c:forEach>
    </ul>
    
    <c:forEach items="${list}" varStatus="s1" step="4" begin="2">
        <ul class="second_ul">
        <c:forEach items="${list}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
            <li>
                <span class="img">
                    <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" title="${l.prdtName}"><ui:image src="${l.prdtImgUrl}" size="200" server="product" alt="${l.prdtName}"/></a>
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
                        <c:if test="${l.basePrdtSellPrice > l.lastCpnPrice}"><span class="dc"><fmt:formatNumber type="number">${l.basePrdtSellPrice}</fmt:formatNumber></span></c:if>
                        <span class="sale"><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
                        <c:if test="${l.basePrdtSellPrice > l.lastCpnPrice}"><span class="pc">${hfn:rate(l.basePrdtSellPrice,l.lastCpnPrice)}%</span></c:if>
                    </em>
                </a>
            </li>
        </c:forEach>
        </ul>
    </c:forEach>
    
</div><!-- //.prod_list_normal -->
<div class="paging mgt50" >
    <ui:paginationScript name="pageHolder" scriptName="goNewDiary" parameters="page"/>
</div>