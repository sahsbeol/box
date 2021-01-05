<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="bizFull"></ui:decorator>
<html>
<head>
<title>[NEW ME 핫트랙스] ${ext.prdtName}</title>
<!--  SNS 공유 내용 -->
<meta property="og:type" content="website">
<meta property="og:title" content="${fn:escapeXml(p.commTitle)}">
<meta property="og:url" content="http://m.hottracks.co.kr/p/${p.sellPrdtBcode}">
<meta property="og:description" content="${fn:escapeXml(p.artiName)}">
<meta property="og:image" content="${productImageUrl}">
<!--  SNS 공유 내용 -->
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type='text/javascript' src='//logger.eigene.io/js/logger.min.js'></script>
<script type="text/javascript" src="/js/mOrder.js?201801251633"></script>
<style type="text/css">
.sns input{border : 0px; line-height: 35px; width : 25px; color :#898989; }
.like_cnt{ outline:none; }
.like_img{ position: fixed; top: 35%; z-index: 999; overflow: initial; width: 100%; text-align: center;}
.like_img img{width : 200px; }
#prodDesc img { max-width:100% !important; }
</style>
<script type="text/javascript">
var isSpec = ("${specProducts != null && fn:length(specProducts) > 0?'Y':'N'}" == "Y");
var isOption = false;
var isOrderMake = false;
jQuery(function($){
    $(document).ready(function(){
        $("#wrap").addClass("mini");
        $(".like_img").show();
        
        goQnaList('1');
        
        var userAgent = navigator.userAgent.toUpperCase();
        var prdtName = '${ext.prdtName}';
        prdtName = prdtName.replace(/&/g, ' and ');
        
        $("#footer").css("padding-bottom", "58px");
        
        if(getToday('${ext.okdate}'))
            $(".reserve").show();
        else
            $(".reserve").hide();
    });
    
    
    // 상세이미지
    var cateBest = new Swiper('.detail_image .swiper-container',{
        pagination: '.detail_image .pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true
    });
    
    // 카테고리베스트
    var cateBest = new Swiper('.detail_best .swiper-container',{
        pagination: '.detail_best .pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true
    });
    
    // 카테고리신상품
    var cateNew = new Swiper('.detail_new .swiper-container',{
        pagination: '.detail_new .pagination',
        loop:true,
        grabCursor: true,
        paginationClickable: true
    });
    
    $("#btnDetailMore").click(function(){
        var detail = $(document).find(".product-detail");
        if(detail.hasClass("active")){
            detail.removeClass("active");
            $(this).find("span").text("상세 이미지 더보기");
        }else{
            detail.addClass("active");
            $(this).find("span").text("상세 이미지 접기");
        }
    });
    
    $("button.up").click(function(){
        var productCount = $(".prdtCnt");
        productCount.val(parseInt(productCount.val()) + 1);
        $(".count [type=number]").val(productCount.val()); 
        calcTotPrice();
    });
    
    $("button.down").click(function(){
        var productCount = $(".prdtCnt");
        if(parseInt(productCount.val()) > 1){
            productCount.val(parseInt(productCount.val()) - 1);
            $(".count [type=number]").val(productCount.val()); 
        }else{
            alert("최소 1개 이상 구매 가능합니다.");
        }
        calcTotPrice();
    });
    
    $(".count [type=number]").change(function(){
        if($(this).val() < 1){
            alert("최소 1개 이상 구매 가능합니다.");
            $(this).val("1"); 
        }
        $(".prdtCnt").val($(this).val()); 
        calcTotPrice();
    });
    
    $("select.options").change(function(index){
        var selectors = $("select.options");
        for(var i = 0; i<selectors.length;i++){
            if(selectors.eq(i).val() == "")
                return;
        }
        var specYn = false;
        var price = "${ext.lastCpnPrice}";
        var keyValue = '';
        var idName = '';
        var prdtCnt = 1;
        if($(this).attr("name") == "specGroup"){
            specYn = true;
            price = $(this).find("option:selected").attr("prce");
            keyValue = $(this).find("option:selected").val();
            idName = $(this).find("option:selected").val();
            stat = $("#stat"+idName).val();
            if(stat != "Y" && parseInt(prdtCnt) > parseInt(stat)){
                prdtCnt = stat;
            };
        }else{
            nameValue = '';
            valStr = '';
            var selectors = $("select.options");
            for(var i = 0;i < selectors.length; i++){
                var selector = selectors.eq(i);
                nameValue += nameValue == '' ? selector.attr('id') : '|' + selector.attr('id');
                keyValue += keyValue == '' ? selector.find("option:selected").val() : '|' + selector.find("option:selected").val();
                idName += selector.find("option").index(selector.find("option:selected"));
                valStr += valStr == '' ? selector.attr('id') + " : " + selector.find("option:selected").val() : '<br/>' + selector.attr('id') + " : " + selector.find("option:selected").val();
            }
        }
        if($("#ord"+idName).length > 0){
            $("#ord"+$(this).find("option:selected").val()).find(".prdtCnt").select();
            return;
        }
        
        var strHtml = "";
        strHtml += '<div class="ord_price" id="ord'+idName+'">';
        if(specYn)    strHtml += '    <p class="name">'+$(this).find("option:selected").text()+'</p>';
        else          strHtml += '    <p class="name">'+valStr+'</p>';
        strHtml += '    <div class="count">';
        if(specYn){
            strHtml += '            <input type="hidden" name="specPrdtBcodes" value="'+$(this).find("option:selected").val()+'"/>';
            strHtml += '            <input type="hidden" name="specNames" value="'+$(this).find("option:selected").text()+'"/>';
        }else{
            strHtml += '            <input type="hidden" name="specPrdtBcodes" value="${ext.sellPrdtBcode}"/>';
            strHtml += '            <input type="hidden" name="optnNames" value="'+nameValue+'"/>';
            strHtml += '            <input type="hidden" name="optnValues" value="'+keyValue+'"/>';
        }
        strHtml += '        <input type="hidden" name="price" value="'+price+'"/>';
        strHtml += '        <input type="number" name="optnCnts" id="prdtCnt" number="prdtCnt" class="prdtCnt" min="0" max="${maxCnt}" value="1" title="주문수량 입력" maxlength="5" style="width: 100%;height: 30px;border: 1px solid #e5e5e5;text-align: center;font-size: 16px;color: #424242;"/>';
        strHtml += '        <button type="button" title="1개씩 감소" class="down" onclick="decPrdtCnt(\''+idName+'\')">감소</button>';
        strHtml += '        <button type="button" title="1개씩 증가" class="up" onclick="incPrdtCnt(\''+idName+'\')">증가</button>';
        strHtml += '    </div>';
        strHtml += '    <span class="amount">'+price_format(price)+' 원</span>';
        strHtml += '    <a class="btn_del" href="javascript://" onclick="deleteOption(\''+idName+'\')"><img alt="삭제" src="/images/content/btn_delete.png" style="height:22px;"></a>';
        strHtml += '</div>';
        $("#cartList").append(strHtml);

        calcTotPrice();
    });
});

function goBuyProudct(){
    if($(".detail_input").hasClass("active")){
        onClickBuyNowGroup();
    }else{
        $(".detail_input").addClass("active");
    }
}

function goCartProudct(){
    if($(".detail_input").hasClass("active")){
        cartAdd();
    }else{
        $(".detail_input").addClass("active");
    }
}

function toggleInput(){
    if($(".detail_input").hasClass("active")){
        $(".detail_input").removeClass("active");
    }else{
        $(".detail_input").addClass("active");
    }
}

function getToday(okdate){
    var okdate = new Date((okdate).substr(0,4),(okdate).substr(4,2)-1, (okdate).substr(6,2));
    okdate = okdate.getTime();
    
    var today = new Date();
    today = today.getTime();
    
    if(okdate < today){
        return false;
    }else{
        return true;
    }
}

function decPrdtCnt(sellPrdtBcode){
    var div = $("#ord"+sellPrdtBcode);
    var productCount = div.find(".prdtCnt");
    if(parseInt(productCount.val()) > 1){
        productCount.val(parseInt(productCount.val()) - 1);
        // checkOption();
    }else{
        alert("최소 1개 이상 구매 가능합니다.");
    }
    calcTotPrice();
}

function incPrdtCnt(sellPrdtBcode){
    var div = $("#ord"+sellPrdtBcode);
    var stat = $("#stat"+sellPrdtBcode).val();
    var productCount = div.find(".prdtCnt");
    if(stat != "Y" && parseInt(productCount.val()) >= parseInt(stat)){
        alert("본 상품의 현재 주문 가능한 수량은  "+stat+"개 입니다.");
    }else{
        productCount.val(parseInt(productCount.val()) + 1);
        // checkOption();
    }
    calcTotPrice();
}

function deleteOption(id){
    $(document).find("#ord"+id).remove();
    calcTotPrice();
};

function calcTotPrice(){
    var totprice = 0;
    if(isSpec){
        $(".ord_price").each(function(){
            var price = parseInt($(this).find("[name=price]").val());
            var cnt = parseInt($(this).find(".prdtCnt").val());
            $(this).find(".amount").text(price_format(price * cnt) + " 원");
            totprice += (price*cnt);
        });
        if($(".ord_price").length > 0 ){
            $(".amount_price").find("dd").text(price_format(totprice) + " 원");
        }
    }else{
        price = parseInt("${ext.lastDcPrice}");
        cnt = parseInt($(".prdtCnt").val());
        $(".amount").text(price_format(price * cnt) + " 원");
        $(".amount_price").find("dd").text(price_format(price * cnt) + " 원");
    }
}

function goQnaList(page){
    if($.trim(page) == "")    page = 1;
    $('#detail_cont03').load('/m/gift/detail/qna/${ext.sellPrdtBcode}?dlvyVndrId=G&brandId=${groupNum}&rcrdCd=${ext.rcrdCd}&page=' + page);
}
</script>
</head>
<body>
<!-- .nav -->
<div class="nav gray">
    <c:set var="ctgrNavi" value="${fn:split(fn:replace(category.ctgrNamePath, ' ', ''), '>')}"/>
    <ul class="swiper-wrapper">
        <li class="swiper-slide"><a href="/">HOME</a></li>
        <c:if test="${fn:startsWith(category.ctgrId, '0003')}">
            <li class="swiper-slide"><a href="/m/recordMain">CD</a></li>
            <c:forEach items="${ctgrNavi}" var="l" varStatus="st" begin="2">
                <li class="swiper-slide"><a href="/m/record/category/${fn:substring(category.ctgrId, 0, (st.count+2)*2)}">${l}</a></li>
            </c:forEach>
        </c:if>
        <c:if test="${fn:startsWith(category.ctgrId, '0004')}">
            <li class="swiper-slide"><a href="/m/dvdMain">DVD</a></li>
            <c:forEach items="${ctgrNavi}" var="l" varStatus="st" begin="2">
                <li class="swiper-slide"><a href="/m/record/category/${fn:substring(category.ctgrId, 0, (st.count+2)*2)}">${l}</a></li>
            </c:forEach>
        </c:if>
        <li class="swiper-slide"><a href="/m/record/category/${category.ctgrId}">${category.ctgrName}</a></li>
    </ul>
</div>
<!-- //.nav -->
<!-- 상세 -->
<div class="detail_wrap">
    <!-- swiper -->
    <div class="detail_image">
        <div class="swiper-container">
            <ul class="swiper-wrapper">
                <li class="swiper-slide">
                    <ui:image prdtGbn="${ext.sellPrdtGbn}" rcrdCd="${ext.rcrdCd}" rcrdImgType="large" ratingCode="${ext.rtngCode}" alt="${fn:escapeXml(ext.prdtName)}" clazz="prdt-photo sns_img kakao-img"/>
                    <c:if test="${posterCaseCnt>0 && groupSellInfo.offYn ne 'Y'}"><span class="ico_event gift">GIFT</span></c:if>
                    <c:if test="${posterCaseCnt>0 && groupSellInfo.offYn eq 'Y'}"><span class="ico_event offgift">POST</span></c:if>
                </li>
            </ul>
        </div>
        <div class="pagination"></div>
    </div>
    <!-- //swiper -->
    
    <!-- 상품 정보 -->
    <div class="detail_info">
        <div class="tit">
            <p class="detail_icon">
                <c:set var="ico_cnt" value="0"/>
                <c:if test="${ext.mediaName ne 'VCD' && fn:startsWith(ext.ctgrId, '000400') && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="bluray">BLU-RAY</span></c:if>
                <c:if test="${ext.mediaName ne 'VCD' && fn:startsWith(ext.ctgrId, '000401') && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="dvd">DVD</span></c:if>
                <c:if test="${!ext.saleYn && ico_cnt < 4}">
                    <c:choose>
                        <c:when test="${ext.rcrdStat eq '0' || ext.rcrdStat eq '1' || ext.rcrdStat eq '6'}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="soldout">일시품절</span></c:when>
                        <c:when test="${ext.rcrdStat eq '3'}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="soldout">절판</span></c:when>
                        <c:otherwise><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="soldout">품절</span></c:otherwise>
                    </c:choose>
                </c:if>
                <c:if test="${ext.impYn && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="import">수입상품</span></c:if>
                <c:if test="${ext.rcrdStat eq '9' && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="preorder">예약상품</span></c:if>
                <c:if test="${freeGift && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="gift">사은품</span></c:if>
                <c:if test="${not empty couponList && ico_cnt < 4}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="coupon">쿠폰</span></c:if>
                <c:if test="${posterCaseCnt>0 && ico_cnt < 4 && groupSellInfo.offYn ne 'Y'}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="poster">지관통+포스터</span></c:if>
                <c:if test="${posterCaseCnt>0 && ico_cnt < 4 && groupSellInfo.offYn eq 'Y'}"><c:set var="ico_cnt" value="${ico_cnt+1}"/><span class="poster">포스터 현장 수령</span></c:if>
            </p>
            <a href="#" onclick="return false;" class="brand"><u>${ext.labelName}</u></a>
            <h2>
                <c:if test="${!(ext.mediaName eq 'VCD' && fn:startsWith(ext.ctgrId, '0004') && ico_cnt < 4)}">${ext.artiName} - </c:if>
                ${ext.prdtName}
                <c:if test="${not empty groupSellInfo.optnName}"> - ${groupSellInfo.optnName}</c:if>
            </h2>
            <c:if test="${not empty ext.rcrdSubComments}"><span class="event">${ext.rcrdSubComments}</span></c:if>
            <c:if test="${empty ext.rcrdSubComments}">
                <c:forEach items="${eventList}" var="l" varStatus="st" end="0">
                    <a href="/m/biz/eventDetail?eventId=${l.eventId}"><span class="event">${l.eventTitle}</span></a>
                </c:forEach>
            </c:if>
        </div>

        <dl class="info">
            <!-- 최종판매가 -->
            <dt class="lastPrice"><strong><c:if test="${groupSellInfo.offYn eq 'Y'}">판매가</c:if><c:if test="${groupSellInfo.offYn ne 'Y'}">공구가</c:if></strong></dt>
            <dd class="lastPrice"><fmt:formatNumber type="number">${ext.lastDcPrice}</fmt:formatNumber>원</dd>
            <c:if test="${ext.sellPrdtBcode ne '2300185880878' && groupSellInfo.offYn ne 'Y' && ext.sellPrdtBcode ne '2300185881011' && ext.sellPrdtBcode ne '2300185881028'}">
            <!-- 결제 혜택  -->
            <!-- <dd class="t_r">
			<img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/common/images/order/txt_smile.png">
			<strong> Smile Pay 결제 시 2천원 적립</strong>
			    <p class="mt10">- 이벤트 기간 : 5/1 ~ 7/31</p>
			    <p>- 스마일페이로 3만원 이상 결제 시 2천원 스마일캐시 적립</p>
			    <p>- 첫 결제 고객님도! 이미 사용해 본 고객님도!</p>
			</dd> -->
            <!-- / 결제 혜택  -->
            <dt>배송비</dt>
            <dd class="t_r">
                2,000원 (해외배송불가)<BR/>
                2만원 이상 구매시 무료배송
            </dd>
            </c:if>
            <c:if test="${ext.sellPrdtBcode eq '2300185880878'}">
            <dt>배송비</dt>
            <dd class="t_r">동마갤공지확인/배송비별도</dd>
            </c:if>
        </dl>
    </div>
    <!-- 주문 정보 -->
    <div class="detail_input">
        <a href="#" onclick="toggleInput();return false;" class="btn_toggle">토글버튼</a>
        <a href="#" onclick="history.back();return false;" class="btn_back">뒤로</a>
        <a href="/m/record/detail/desc/${ext.rcrdCd}?sellPrdtBcode=${ext.sellPrdtBcode}&sngl=Y" class="btn_detail">확대보기</a>
        <a href="#" onclick="openRecent();return false;" class="btn_recent">
            <c:choose>
                <c:when test="${not empty listRecent}">
                    <c:forEach items="${listRecent}" var="l" varStatus="st" end="0">
                        <c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><ui:image src="${l.productImageUrl}" server="product" size="150" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
                        <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
                        <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
                    </c:forEach>
                </c:when>
                <c:otherwise><img src="${imageServer}/images/mobile/content/no_img03.jpg" alt="상품 없음"/></c:otherwise>
            </c:choose>
        </a>
        <a href="#" onclick="moveTop();return false;" class="btn_top">위로</a>
        <div class="order_input">
            <c:if test="${not empty specProducts}">
                <c:forEach items="${specProducts }" var="l" varStatus="st">
                    <input type="hidden" id="stat${l.sellPrdtBcode}" value="${l.saleStat}"/>
                </c:forEach>
                <select class="select select_black options" name="specGroup" id="specGroup" title="옵션선택">
                    <c:if test="${groupSellInfo.offYn eq 'Y'}"><option value="">수령 매장을 선택하세요.</option></c:if><c:if test="${groupSellInfo.offYn ne 'Y'}"><option value="">옵션을 선택하세요.</option></c:if>
                    <c:forEach items="${specProducts}" var="l" varStatus="st">
                        <option value="${l.sellPrdtBcode}" prce="${l.lastDcPrice}">
                            ${l.specName}
                            <c:if test="${l.lastDcPrice < ext.lastDcPrice}">, ${l.lastDcPrice - ext.lastDcPrice}</c:if>
                            <c:if test="${l.lastDcPrice > ext.lastDcPrice}">, +${l.lastDcPrice - ext.lastDcPrice}</c:if>
                            <c:if test="${l.laveCount < 1}">, 예약마감</c:if>
                        </option>
                    </c:forEach>
                </select>
            </c:if>
            
            <c:if test="${ext.saleYn}">
	            <c:if test="${empty specProducts}">
	                <div class="ord_price" id="ord${ext.sellPrdtBcode}">
	                    <div class="count">
	                        <input type="number" name="prdtCnt" id="prdtCnt" number="prdtCnt" class="prdtCnt" min="0" max="" value="1" title="주문수량 입력" style="width: 100%;height: 30px;border: 1px solid #e5e5e5;text-align: center;font-size: 16px;color: #424242;"/>
	                        <button type="button" title="1개씩 감소" class="down">감소</button>
	                        <button type="button" title="1개씩 증가" class="up">증가</button>
	                    </div>
	                    <span class="amount"><fmt:formatNumber type="number">${ext.lastDcPrice}</fmt:formatNumber> 원</span>
	                </div>
	            </c:if>
	            <c:if test="${not empty specProducts}">
	                <div id="cartList"></div>
	            </c:if>
            </c:if>
            <dl class="amount_price">
                <dt>총합계</dt>
                <dd><fmt:formatNumber type="number">${ext.lastDcPrice}</fmt:formatNumber></dd>
            </dl>
        </div>
        <div class="detail_order">
            <c:choose>
                <c:when test="${ext.saleYn}">
                    <div class="btn_area box_flex">
                        <a href="#" onclick="goBuyProudct();return false;" class="btn btn_orange">예약구매</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <p style="padding: 7px 15px 6px;line-height: 1.6;color:#ff6000;font-weight:bold;">현재 판매가 중지된 상품입니다.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <!-- //주문 정보 -->
	<div class="sns" style="padding:30px 10px; border-top:1px solid #e5e5e5;">
	   <p><ui:br>${groupSellInfo.optnKey}</ui:br></p>
	</div>
 	
	<c:if test="${ext.sellPrdtBcode eq '2300185880762'}">
	    <div>
	        <a href="http://m.hottracks.co.kr/m/biz/eventDetail?eventId=51291">
			    <img onerror="this.src='http://image.kyobobook.co.kr/images/no_image.gif';" alt="" src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/1984/1534386842187_51291_bnr.jpg" width="100%"/>
			</a>
	    </div>
	</c:if>

    <!-- 상세 탭메뉴 -->
    <div class="detail_tab">
        <ul class="tab_btn">
            <li><a href="#detail_cont01" class="on">상품설명</a></li>
            <li><a href="#detail_cont03" id="detail_tab03">Q&amp;A</a></li>
        </ul>
    </div>
    <!-- //상세 탭메뉴 -->
    
    <div class="tab_pannels">
        <!-- 상품설명 -->
        <div class="tab_cont" id="detail_cont01">
            <h2 class="hid_obj">상품설명</h2>
            <c:if test="${not empty ext.rcrdMdMemo}">
                <p style="margin:12px;padding: 10px 10px 10px 58px;color: #4f4f4f;font-size: 11px;font-weight: bold;line-height: 18px;background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/ico_tip.gif) no-repeat 15px 12px #f3f2f1;color:#6a6a6a;">${ext.rcrdMdMemo}</p>
            </c:if>
            <!-- 
            <c:if test="${not empty ext.okdate  }">
                   <strong style="font-size: 1.2em; color: black; padding-bottom : 15px;" class="txt_list reserve">예약판매 :
                       <ui:mask pattern="####.##.##">${ext.okdate}</ui:mask> 발매예정  
                   </strong>
            </c:if>
             -->
            <c:if test="${groupSellInfo.offYn ne 'Y'}">            
            <c:if test="${ext.sellPrdtBcode ne '2300185880878'}">
            <ul class="accordion">
                <li>
                    <a href="#n" class="on">배송안내</a>
                    <div class="cont">
                        <p>
                            - 2만원 이상 구매 시 무료배송/2만원 미만 구매시 배송비 2,000원 (도서, 산간지역 추가비용 없음)<br/>
                            - 출시일부터 발송 예정이나 주문량이 많은 경우, 상품의 재고 상황이나 배송상황, 지역특성에 따라 배송이 지연될 수 있습니다.<br/>
                        </p>
                    </div>
                </li>
                <li>
                    <a href="#n" class="on">반품교환</a>
                    <div class="cont">
                        <p>
                            -반품 및 환불은 불가하며, 불량이나 구성품 누락을 대비해 박스 개봉부터 동영상 촬영을 요청드립니다.<br/>
                            -동영상이 없는 경우 교환이 제한될 수 있습니다.<br/>
                        </p>
                    </div>
                </li>
                <li>
                    <a href="#n" class="on">기타사항</a>
                    <div class="cont">
                        <p>
                            -통합포인트는 적립되지 않습니다.<br/>
                            -앨범 구매시 쿠폰은 사용하실수 없습니다.<br/>
                            <c:if test="${   ext.sellPrdtBcode ne '2300185899610'
                                          }">
                            -선착순 포스터의 경우 지관통은 주문건당 1개만 증정이 됩니다.<br/>
                            </c:if>
                            -공동구매 주문건은 SOS 상담접수 (1:1문의) 시 별도의 답변이나 처리 진행이 되지않습니다. 고객센터로 전화문의 부탁드립니다.<br/>
                        </p>
                    </div>
                </li>
            </ul>
            </c:if>
            </c:if>
            <c:if test="${groupSellInfo.offYn eq 'Y'}">
            <ul class="accordion">
                <li>
                    <a href="#n" class="on">수령안내</a>
                    <div class="cont">
                        <p>
                            - 공식판매일부터 수령이 가능하며, 영업점 배송상황에 따라 영업점별 수령시간이 다를 수 있습니다.<br/>
                            - 수령가능 일시는 주문/배송조회에서 처리상태가 “상품준비＂상태로 변경된 후 SMS로 안내드립니다.<br/>
                            - 수령하기 위해서는 주문 시 발송된 문자 확인이 필요하오니 문자를 꼭 저장하여 오시기 바랍니다.<br/>
                        </p>
                    </div>
                </li>
                <li>
                    <a href="#n" class="on">반품교환</a>
                    <div class="cont">
                        <p>
                            - 반품 및 교환은 수령한 영업점에서 가능합니다.<br/>
                            - 구성품 누락의 경우 유통사 정책에 따라 교환 또는 누락 구성품 추후 증정이 될 수 있습니다.<br/>
                        </p>
                    </div>
                </li>
                <li>
                    <a href="#n" class="on">기타사항</a>
                    <div class="cont">
                        <p>
                            - 매장수령 예약주문 상품 외 온라인몰의 다른 상품을 함께 구매하실 수 없습니다.<br/>
                            - 할인상품의 경우 통합포인트는 적립되지 않습니다.<br/>
                            - 음반예약수령은 지관통이 증정되지 않습니다.<br/>
                            - 음반예약수령 앨범 구매시 쿠폰은 사용하실 수 없습니다.<br/>
                            - 해당 주문건으로 사인회 참여를 하실 수 없습니다.<br/>
                        </p>
                    </div>
                </li>
            </ul>
            </c:if>
            <div id="prodDesc" style="padding:10px;">
                <p><ui:br>${groupSellInfo.optnDesc}</ui:br></p>
            </div>
        </div>
        <!-- //상품설명 -->
        <!-- QnA -->
        <div class="tab_cont" id="detail_cont03"></div>
        <!-- //QnA -->
    </div>
        <!-- //banner -->
</div>
<!-- //상세 -->

<div id="formBaseHtml">
    <input type="hidden" value="${ext.sellPrdtBcode}" name="sellPrdtBcode">
    <input type="hidden" value="1" name="prdtCount" class="prdtCnt">
    <input type="hidden" value="Y" name="groupSellYn">
</div>

<FORM name="sForm" id="sFormDiv" method="post">
</FORM>  <!-- 장바구니 담기 Form -->
</body>
</html>