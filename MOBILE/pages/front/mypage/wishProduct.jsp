<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<title>좋아요♥ 상품 | 마이핫트랙스 - 뉴미핫트랙스</title>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<style type="text/css">
input[name="checkWishPrdt"] + label{ display: inline-block; width: 14px; height: 14px; border: 1px solid #bcbcbc; cursor: pointer;}
input[name="checkWishPrdt"]:checked + label:after {content: '\2714';font-size: 8px; margin-bottom: 10px; padding-left : 1px; padding-right : 1px;}
input[name="checkWishPrdt"]{display:  none;}

</style>
<script type="text/javascript">
jQuery(function($){
    $(".checkboxDel").hide(); 
    $(document).ready(function(){
        $("#wrap").addClass("mypage01");
        $("#locWish").addClass("active");
    });
    
    $("input:checkbox[name='checkWishPrdt']").click(function() {
        if($('input:checkbox[name="checkWishPrdt"]:checked').length > 0){
            $(".checkboxDel").show(); 
        }
        else if($('input:checkbox[name="checkWishPrdt"]:checked').length == 0){
            $(".checkboxDel").hide(); 
        }
    });
});

function removeWishProduct(sellPrdtBcode, prdtName, index){
     $.ajax({
        type: 'GET'
        ,url: '/m/gift/removeWishProduct'
        ,data: 'sellPrdtBcode=' + sellPrdtBcode
        ,dataType: 'json'
        , async: false
        ,success: function(data) {
            var size = data.errorMessages.length;
            if (size == 0) {
                if(index == '0'){
                    alert("삭제되었습니다.");
                    location.reload(true);
                }else{}
            } else {
                alert(data.errorMessages);
            }
        }
        ,error: function(data) {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}
function removeSelectedWishProduct(){
    $("input:checkbox[name='checkWishPrdt']:checked").each(function(index) {
        removeWishProduct($(this).val(), $(this).parent().parent().find(".prdtName").val(), '1');
    });
    alert("삭제되었습니다.");
    location.replace("?ctgrId=${c.ctgrId}&"+(new Date()).getTime());
}
function goList(page){
    location.href="?ctgrId=${c.ctgrId}&page="+page;
}
</script>
</head>
<body>
<div class="gray_box">
    <hr class="hr_01"/>
    <div id="my_content">
        <!-- .nav -->
        <c:if test="${not empty ctgrList}">
            <div class="customer">
                <div class="gray_box2 pt5">
                    <div class="tab_box">
                        <c:forEach items="${ctgrList}" var="l" varStatus="st"> 
                            <a href="#" onclick="location.replace('/m/mypage/wishProduct?ctgrId=${l.ctgrId}');return false;"<c:if test="${fn:startsWith(c.ctgrId, l.ctgrId)}"> class="active"</c:if>>${l.ctgrName} (<fmt:formatNumber type="number">${l.prdtCnt}</fmt:formatNumber>)</a>
                        </c:forEach> 
                    </div>
                    <hr class="hr_01"/>
                </div>
            </div>
        </c:if>
        <div class="giftList">
            <c:if test="${not empty giftList}">
                <div class="txt_sel_box bg_white">
                    <dl>
                        <dt>카테고리</dt>
                        <dd>
                            <c:forEach items="${giftList}" var="l" varStatus="st">
                                <c:if test="${st.first}"><a href="#" onclick="location.replace('/m/mypage/wishProduct?ctgrId=${l.ctgrId}');return false;"<c:if test="${c.ctgrId eq l.ctgrId}"> class="active"</c:if>>전체 <em class="col_orange">(<fmt:formatNumber type="number">${l.prdtCnt}</fmt:formatNumber>)</em></a></c:if>
                                <c:if test="${!st.first}"><a href="#" onclick="location.replace('/m/mypage/wishProduct?ctgrId=${l.ctgrId}');return false;"<c:if test="${c.ctgrId eq l.ctgrId}"> class="active"</c:if>>${l.ctgrName}<em class="col_orange">(<fmt:formatNumber type="number">${l.prdtCnt}</fmt:formatNumber>)</em></a></c:if>
                            </c:forEach>
                        </dd>
                    </dl>
                </div>
            </c:if>
        </div>
        <div class="checkboxDel">
            <p class="btn_area t_r"><a href="#" onclick="removeSelectedWishProduct();return false;" class="btn ic_del">삭제</a></p>
        </div>
        <div class="prod_basic03 border">
            <c:if test="${empty list}">
                <script>$("body").addClass("bg_gray");</script>
                <div class="roundbox mt10">
                    <ul class="br_list">
                        <li class="br_none"><strong>좋아요♥ 상품 목록이 존재하지 않습니다.</strong></li>
                    </ul>
                </div>
            </c:if>
            <c:if test="${not empty list}">
            <ul id="productList">
                <c:forEach items="${list}" var="l" varStatus="st">
                    <li>
                        <span class="checkSpan">
                            <input type="checkbox" name="checkWishPrdt" value="${ l.sellPrdtBcode}" id="checkWishPrdt_${st.index }">
                            <label for="checkWishPrdt_${st.index }"></label>
                        </span>
                        <div>
                            <input type="hidden" class="prdtName" value="${l.prdtName }" />
                            <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                                <p class="pic"><a href="/p/${l.sellPrdtBcode}"><ui:image src="${l.productImageUrl}" server="product" size="200" alt="${fn:escapeXml(l.prdtName)}" /></a></p>
                                <p class="brand t_l"><a href="/p/${l.sellPrdtBcode}">${l.brandEngName}</a></p>
                            </c:if>
                            <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                                <p class="pic<c:if test="${l.sellPrdtGbn eq 'D'}"> dvd</c:if>"><a href="/p/${l.sellPrdtBcode}"><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></a></p>
                                <p class="brand t_l"><a href="/p/${l.sellPrdtBcode}">${fn:escapeXml(l.artiName)}</a></p>
                            </c:if>
                            <p class="tit t_l"><a href="/p/${l.sellPrdtBcode}">${fn:escapeXml(l.prdtName)}</a></p>
                            <p class="price t_l">
                                <fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>원
                                <c:if test="${l.prdtSellPrice>l.lastCpnPrice}"><em class="sale">[<fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}</fmt:formatNumber>%]</em></c:if>
                            </p>
                            <p class="btn_area">
                                <a href="#" onclick="removeWishProduct('${l.sellPrdtBcode}', '${fn:escapeXml(l.prdtName)}','0');return false;" class="btn ic_del">삭제</a>
                            </p>
                        </div>
                    </li>
                </c:forEach>
            </ul>
            </c:if>
        </div>
        <!-- paging -->
        <div class="paging mb30">
            <ui:paginationScript name="pageHolder" scriptName="goList"/>
        </div>
        <!-- //paging -->
    </div>
</div>
</body>
</html>