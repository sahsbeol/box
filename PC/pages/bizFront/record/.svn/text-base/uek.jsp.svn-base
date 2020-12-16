<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<style type="text/css">
#list-uek-gnb { padding:20px 0 10px; }
.list-uek-01 { padding-top:10px;position:relative; }
.list-uek-01 .list-menu { position:absolute;top:10px;right:5px; }
.list-uek-01 ul li { border-top:1px dotted #000;height:260px;position:relative; }
.list-uek-01 ul li.first { border-top:none; }
.list-uek-01 ul li dl { float:left;margin:10px 0;padding:0 10px;border-left:1px solid #DADADA;position:relative; }
.list-uek-01 ul li dl.first { border-left:none; }
.list-uek-01 ul li dl dt { text-align:left;padding:10px;position:absolute;top:0;left:10px; }
.list-uek-01 ul li dl dd { width:159px;text-align:center;padding:5px;text-overflow:ellipsis;overflow:hidden;white-space:nowrap; }
</style>
<script type="text/javascript">
isLogin = ${isLogin};
returnUrl = (document.location.href).split('#')[0];
loginUrl = '<ui:variable key="kyobo.server"/><ui:variable key="kyobo.login.uri"/>' + escape(returnUrl);
function showSchedule(month){
    $("#divUekSchedule").load("/ht/record/uekSchedule?month="+month);
}

/**
 * 복수개의 상품을 장바구니에 담기
 *  폼구성요소의 이름을 고정시켜서 사용함.
 * @return
 */
function addRecordsCartUek(target){
    var sellPrdtBcodes = [];
    var sellPrdtCounts = [];
    $("input[name=" + target + "]:checked").each(function(idx){
        sellPrdtBcodes.push(this.value);
        sellPrdtCounts.push($("input[name=" + target + "_" + this.value + "_prdt_count]").val() || 1);
    });

    if(sellPrdtBcodes.length == 0){ alert("장바구니에 담을 상품을 선택해 주십시오"); return; }

    
    $.ajax({
        async : true, 
        url : "/ht/order/addCartForProductList",
        dataType : "json", 
        type : "post", 
        data : {
            sellPrdtBcodes : sellPrdtBcodes.join(","), 
            prdtCounts : sellPrdtCounts.join(","), 
            optnPrdtYn : false 
        }, 
        success : function(result, textStatus, XMLHttpRequest){
            if(result.errorMessages.length == 0){
                //alert("장바구니에 선택하신 상품이 담겼습니다.");
                
                // 상단 장바구니 카운트 변경
                initTopNavigation();
                if(confirm("장바구니에 선택하신 상품이 담겼습니다.\n장바구니로 이동하시겠습니까?")) location.href="/ht/order/cart";
            }else{
                alert(result.errorMessages[0]);
                
                if(result.errorMessages[0].substring(0, 4) == "연령제한"){
                    goToLogin();
                }
                
                if(result.errorMessages[0].substring(0, 4) == "본인인증"){
                    goToCert();
                }
            }
        }, 
        error: function(request, textStatus, errorThrown){
            alert("장바구니 담기에서 장애가 발생했습니다.");
            //alert(request.status + " => " + request.statusText);
        }
    });
}

function addMyListDvdsUek(target){
    if(isLogin){
        var rcrdCdList = [];
        $("input[name=" + target + "]:checked").each(function(idx){
            rcrdCdList.push($("input[name="+target+"_" + this.value + "]").val());
        });
        if(rcrdCdList.length == 0){ alert("마이리스트에 담을 DVD를 선택해 주십시오"); return; }
        
        
        addMyListDvd(rcrdCdList.join(","));
    }else{
        alert("로그인후 이용이 가능합니다.");
        goToLogin();
    }
}
</script>
</head>
<body>
<div id="container">
<div class="main-uek">
    <div id="list-uek-gnb">
        <c:forEach items="${uekGnb}" var="l" varStatus="st">
            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.imageUrl}" alt="${l.dispTitle}"/>
        </c:forEach>
    </div>
    <c:forEach begin="0" end="4" varStatus="s1">
        <c:if test="${s1.index eq 0}"><c:set var="titleImg" value="${imageServer}/images/music/uek_title_new_blu.jpg"/><c:set var="titleAlt" value="새로나온 블루레이"/><c:set var="list" value="${listNewBlu}"/><c:set var="chkName" value="chkNewBlu"/></c:if>
        <c:if test="${s1.index eq 1}"><c:set var="titleImg" value="${imageServer}/images/music/uek_title_new_dvd.jpg"/><c:set var="titleAlt" value="새로나온 DVD"/><c:set var="list" value="${listNewDvd}"/><c:set var="chkName" value="chkNewDvd"/></c:if>
        <c:if test="${s1.index eq 2}"><c:set var="titleImg" value="${imageServer}/images/music/uek_title_dscnt.jpg"/><c:set var="titleAlt" value="할인행사"/><c:set var="list" value="${listDscnt}"/><c:set var="chkName" value="chkDscnt"/></c:if>
        <c:if test="${s1.index eq 3}"><c:set var="titleImg" value="${imageServer}/images/music/uek_title_special_3d.jpg"/><c:set var="titleAlt" value="Special 3D"/><c:set var="list" value="${listSpecial3D}"/><c:set var="chkName" value="chkSpc3D"/></c:if>
        <c:if test="${s1.index eq 4}"><c:set var="titleImg" value="${imageServer}/images/music/uek_title_special_event.jpg"/><c:set var="titleAlt" value="Special event"/><c:set var="list" value="${listSpecialEvent}"/><c:set var="chkName" value="chkSpcEvent"/></c:if>
        <div class="list-uek-01">
            <h4><img src="${titleImg}" alt="${titleAlt}"/></h4>
            <div class="list-menu">
                <a href="javascript:addRecordsCartUek('${chkName}');" title="선택한 상품 전체 장바구니에 담기"><img alt="장바구니에 담기" src="${imageServer}/images/music/btn_cart.gif"/></a>
            </div>
            <ul>
                <c:forEach items="${list}" varStatus="s1" step="5" end="9">
                    <li class="${s1.first?'first':''}">
                        <c:forEach items="${list}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+4}">
                            <dl class="${st.first?'first':''}">
                                <dt>
                                    <input type="checkbox" name="${chkName}" value="${l.sellPrdtBcode}" title="장바구니 및 보관함에 ${l.prdtName} 담기 선택"/>
                                    <input type="hidden" name="${chkName}_${l.sellPrdtBcode}_prdt_count" value="1" />
                                    <input type="hidden" name="${chkName}_${l.sellPrdtBcode}" value="${l.rcrdCd}" />
                                </dt>
                                <dd><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${l.sellPrdtGbn eq 'R'?'150':'99'}" height="150" ratingCode="A" alt="${l.prdtName}"/></a></dd>
                                <dd class="title"><strong><a href="/ht/record/detail/${l.sellPrdtBcode}" title="${l.prdtName}">${l.prdtName}</a></strong></dd>
                                <dd class="price"><span><fmt:formatNumber value="${l.dscntPrice}" pattern=",###"/>원</span></dd>
                            </dl>
                        </c:forEach>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </c:forEach>
    <div id="divUekSchedule"><c:import url="/ht/record/uekSchedule"/></div>
</div>
</div>
</body>
</html>