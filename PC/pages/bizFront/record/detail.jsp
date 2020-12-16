<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>${p.commTitle} - NEW ME HOTTRACKS</title>
<!--  SNS 공유 내용 -->
<meta property="og:type" content="website">
<meta property="og:title" content="${fn:escapeXml(p.commTitle)}">
<meta property="og:url" content="${defaultHost}/ht/record/detail/${p.sellPrdtBcode}">
<meta property="og:description" content="${fn:escapeXml(p.artiName)}">
<meta property="og:image" content="${productImageUrl}">


<!--  레코벨 스크립트 -->
<meta property="rb:type" content="product" />
<meta property="rb:cuid" content="e15e978e-3623-4892-bf0a-485b9f8196ee" />
<meta property="rb:itemId" content="${p.sellPrdtBcode}" />
<meta property="rb:itemName" content="${p.commTitle}" />
<meta property="rb:itemImage" content="${productImageUrl}" />
<meta property="rb:itemUrl" content="${defaultHost}/ht/record/detail/${p.sellPrdtBcode}" />
<meta property="rb:originalPrice" content="${p.prdtSellPrice}" />
<meta property="rb:salePrice" content="${p.lastCpnPrice}" />

<c:set var="stind" value="0"/>
<c:forEach varStatus="st" begin="4" end="${fn:length(p.ctgrId)}" step="2">
    <c:set var="stind" value="${stind+1}"/>
    <meta property="rb:category${stind}" content="${fn:substring(p.ctgrId, 0, st.index)}" />
</c:forEach>

<meta property="rb:brandId" content="" />
<meta property="rb:brandName" content="" />
<meta property="rb:regDate" content="" />
<meta property="rb:updateDate" content="" />
<meta property="rb:stock" content="" />
<meta property="rb:state" content="" />
<c:choose>
    <c:when test="${p.sellPrdtGbn == 'R'}">
        <meta property="rb:description" content="음반" />
    </c:when>
    <c:when test="${p.sellPrdtGbn == 'D'}">
        <meta property="rb:description" content="DVD" />
    </c:when>
    <c:otherwise>
        <meta property="rb:description" content="기프트" />
    </c:otherwise>
</c:choose>
<meta property="rb:extraImage" content="" />
<meta property="rb:locale" content="KR" />
<c:choose>
    <c:when test="${p.lastCpnPrice >= 20000}">
    	<meta property="rb:freeShipping" content="Y" />
    </c:when>
    <c:otherwise>
    	<meta property="rb:freeShipping" content="N" />
    </c:otherwise>
</c:choose>
<c:choose>
    <c:when test="${p.lastCpnPrice < 10000}">
        <meta property="rb:priceRange" content="1" />
    </c:when>
    <c:when test="${p.lastCpnPrice < 20000}">
        <meta property="rb:priceRange" content="2" />
    </c:when>
    <c:when test="${p.lastCpnPrice < 30000}">
        <meta property="rb:priceRange" content="3" />
    </c:when>
    <c:otherwise>
        <meta property="rb:priceRange" content="" />
    </c:otherwise>
</c:choose>
<!--  레코벨 스크립트 끝-->

<link rel="stylesheet" type="text/css" href="/css/swiper-5.1.0.min.css?${tmpKey}">

<style type="text/css">

span.c_red{
    color:#ff0000;
    font-weight: bold;
}

</style>
<!-- Facebook Pixel Code -->
<script>
!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments);};if(!f._fbq)f._fbq=n;
n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s);}(window,
document,'script','//connect.facebook.net/en_US/fbevents.js');

fbq('init', '2595348470556537');
fbq('track', "PageView");
</script>
<noscript><img height="1" width="1" style="display:none" src="https://www.facebook.com/tr?id=1053245131399072&ev=PageView&noscript=1"/></noscript>
<!-- End Facebook Pixel Code -->


<!--  레코벨 스크립트 -->
<script type="text/javascript">
  var _recoUserId = getCookie('UserCookieKey');
  window._rblq = window._rblq || [];
  _rblq.push(['setVar','cuid','e15e978e-3623-4892-bf0a-485b9f8196ee']);
  _rblq.push(['setVar','device','PW']);
  _rblq.push(['setVar','itemId','${p.sellPrdtBcode}']);
  _rblq.push(['setVar','userId',SHA256(_recoUserId)]);
  _rblq.push(['setVar','searchTerm','']);  
  _rblq.push(['track','view']);
  _rblq.push(['track','product']);  /* -- IMPORTANT -- */
  (function(s,x){s=document.createElement('script');s.type='text/javascript';
  s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+'://assets.recobell.io/rblc/js/rblc-apne1.min.js';
  x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
</script>
<!--  레코벨 스크립트 끝-->

<script type="text/javascript">
// 전역변수 처리
var sellPrdtBcode = "${p.sellPrdtBcode}";
var rcrdCd = "${p.rcrdCd}";
var isLogin = ${isLogin};
var hasOption = ${hasOption};

jQuery(function($){
    $("button.up").click(function(){
        var productCount = $("input[name=prdtCount]");
        productCount.val(parseInt(productCount.val()) + 1);
    });
    
    $("button.down").click(function(){
        var productCount = $("input[name=prdtCount]");
        if(parseInt(productCount.val()) > 1){
            productCount.val(parseInt(productCount.val()) - 1);
        }else{
            alert("최소 1개 이상 구매 가능합니다.");
        }
    });
});

// 전체 선택 처리
function chkAll(chk){
    $(".listDsc" + chk.value).attr("checked", chk.checked);
}

//전곡 듣기 처리
function playAll(){
    $("input[name=chkTrkId]").attr("checked", true);
    musicPlayer.base.openPlayer('chkTrkId');
}


// 전곡듣기 처리
function playAllHot(){
    $("input[name=chkTrkNo]").attr("checked", true);
    musicPlayer.base.openPlayerHot('chkTrkNo');
}


// 바로구매 처리
function detailBuy(){
    var prdtCount = $("input[name=prdtCount]").val();
    if(!hasOption){
        addRecordBuy(sellPrdtBcode, prdtCount);
    }else{
        var optnNameList = [];
        var optnValueList = [];
        $("select[name=prdtOption]").each(function(idx){
            optnNameList.push($(this).find("option").get(0).value);
            if(this.selectedIndex > 0){
                optnValueList.push($(this).find("option:selected").val());
            }
        });
        if(optnValueList.length != optnNameList.length){ alert("옵션을 선택해 주십시오"); return; }
        addRecordBuy(sellPrdtBcode, prdtCount, optnNameList.join("|"), optnValueList.join("|"));
    }
}

// 장바구니 처리 
function detailCart(){
	
    /* Facebook Pixel Code */
    fbq('track', 'AddToCart');
    /* End Facebook Pixel Code */
	
    _rbSendSyncLogs();
    
    var prdtCount = $("input[name=prdtCount]").val();
    if(!hasOption){
        addRecordCart(sellPrdtBcode, prdtCount);
    }else{
        var optnNameList = [];
        var optnValueList = [];
        $("select[name=prdtOption]").each(function(idx){
            optnNameList.push($(this).find("option").get(0).value);
            if(this.selectedIndex > 0){
                optnValueList.push($(this).find("option:selected").val());
            }
        });
        if(optnValueList.length != optnNameList.length){ alert("옵션을 선택해 주십시오"); return; }
        addRecordCart(sellPrdtBcode, prdtCount, optnNameList.join("|"), optnValueList.join("|"));
    }
}

// 리뷰 삭제하기
function reviewRemove(seq){
    if(isLogin){
        $.ajax({
            async : true, 
            url : "/ht/record/reviewRemove",
            dataType : "json", 
            type : "post", 
            data : {
                RcrdReviewSeq : seq 
            }, 
            success : function(result, textStatus, XMLHttpRequest){
                if(result.errorMessages.length > 0){
                    alert(result.errorMessages[0]);
                }else{
                    alert("삭제되었습니다.");
                    $("#member_review").listGoPage(1);
                }
            }, 
            error: function(request, textStatus, errorThrown){
                alert(request.status + " => " + request.statusText);
            }
        });
    }else{
        needLogin();
    }
}


// 리뷰 저장하기
function reviewSave(){
    if(isLogin){
        var grade = $("input[name=practicality]:checked").val();
        var review = $.trim($("textarea[name=review]").val());

        if(!grade){ alert("평점을 선택해 주십시오"); return; }
        if(review == ""){ alert("내용을 등록해 주십시오"); return; }

        $.ajax({
            async : true, 
            url : "/ht/record/reviewSave",
            dataType : "json", 
            type : "post", 
            data : {
                rcrdCd : "${p.rcrdCd}", 
                review : review, 
                grade : grade
            }, 
            success : function(result, textStatus, XMLHttpRequest){
                if(result.errorMessages.length > 0){
                    alert(result.errorMessages[0]);
                }else{
                    alert("등록되었습니다.");
                    $("textarea[name=review]").val("");
                    $("#member_review").listGoPage(1);
                }
            }, 
            error: function(XMLHttpRequest, textStatus, errorThrown){
                alert(request.status + " => " + request.statusText);
            }
        });
    }else{
        needLogin();
    }
}

// 리뷰 목록 생성후 콜백 함수
function reviewCallBack(target){
    var options = target.data("listOption");

    
    
    // 리뷰 전체 개수 처리
    $(".member_review_count").html("(" + options.totalCount + ")");

    // 마지막 항목 점선 제거 처리
    $($(".review_list").find("li").get($(".review_list").find("li").size() - 1)).addClass("end");

    <c:if test="${isLogin}">
        var user_num = "${loginUser.num}";
    
        // 삭제 버튼 컨트롤
        $(".review_list").find("li").each(function(idx){
            if($(this).find("input[name=userNum]").val() == user_num){
                $(this).find(".btnRemove").show();
            }else{
                $(this).find(".btnRemove").hide();
            }
        });
    </c:if>
}

// QNA 목록 생성후 콜백 함수
function qnaCallBack(target){
    var options = target.data("listOption");

    
    
    // 전체 개수 처리
    $(".product_qna_count").html("(" + options.totalCount + ")");


    // 답변준비중 처리
    $(".answer-txet").each(function(idx){
        if($.trim($(this).html()) == ""){
            $(this).parents("td").find("p.question-answer").html("답변준비중입니다.");
        }else{
            $(this).parents("td").find("p.question-answer").html("질문에 대한 답변입니다");
        }
    });


    
    var loginYN = "${isLogin}";
    if (loginYN == "true"){
        var user_num = "${loginUser.num}";
    
        // 삭제 버튼 컨트롤
        $(".qa_list").find("tr").each(function(idx){
            if($(this).find("input[name=userNum]").val() == user_num){
                $(this).find(".btnUpdate").show();
                $(this).find(".btnRemove").show();
            }
        });
    }
}

// 리뷰 입력 바이트 체크
function reviewCheckByte(event){
    var review = $("textarea[name=review]").val();
    if(byteCheck(review) >= 200 && event.keyCode != 8 && event.keyCode != 9){ event.returnValue = false; }
}

// 리뷰 입력 바이트 표현
function reviewDispByte(event){
    var review = $("textarea[name=review]").val();
    $(".reviewCheckByteResult").html(byteCheck(review));
}


// Q&A 입력 창 활성화
function qnaWriteOpen(){
    var loginYN = "${isLogin}";
    if (loginYN == "true"){
        window.open("/ht/product/questionPopup4write?barcode=${p.sellPrdtBcode}", "", "width=500, height=700, scrollbars=no");
        return false;
    } else {
        needLogin();
    }
}

// Q&A 수정 창 활성화
function qnaUpdateOpen(seq){
    var loginYN = "${isLogin}";
    if (loginYN == "true"){
        window.open("/ht/product/questionPopup4Modify?seq=" + seq, "", "width=500, height=600, scrollbars=no");
    } else {
        needLogin();
    }
}

// Q&A 상세보기
function qnaView(seq){
    $(".qa_list_body_" + seq).toggle();
}

// Q&A 삭제요청
function qnaRemove(seq){
    var loginYN = "${isLogin}";
    if (loginYN == "true"){
        if(confirm("삭제하시겠습니까?")){
            $.ajax({
                async : true, 
                url : "/ht/product/deleteArticle",
                dataType : "json", 
                type : "post", 
                data : {
                    seq : seq, 
                    barcode : "00" 
                }, 
                success : function(result, textStatus, XMLHttpRequest){
                    if(result.errorMessages.length > 0){
                        alert(result.errorMessages[0]);
                    }else{
                        alert("삭제되었습니다.");
                        $("#product_qna").listGoPage(1);
                    }
                }, 
                error: function(XMLHttpRequest, textStatus, errorThrown){
                    alert(request.status + " => " + request.statusText);
                }
            });
       }
    } else {
        needLogin();
    }
}


// Q&A 입력 및 수정 콜백 처리
function loadQuestionSubList(){
    $("#product_qna").listGoPage(1);
}


//상세 펼쳐보기 처리
function infoViewControl(){
    if($(".album_information_content").hasClass("full")){
        $(".album_information_content").css("height", "200px");
        $(".album_information_content").removeClass("full");
        $(".open_button_area").find("img").attr("src", "<c:if test="${decorator eq 'record'}">${imageServer}/images/music/btn_album_open.gif</c:if><c:if test="${decorator eq 'dvd'}">${imageServer}/images/dvd/btn_open_area.gif</c:if>");
    }else{
        $(".album_information_content").css("height", null);
        $(".album_information_content").addClass("full");
        $(".open_button_area").find("img").attr("src", "<c:if test="${decorator eq 'record'}">${imageServer}/images/music/btn_album_close.gif</c:if><c:if test="${decorator eq 'dvd'}">${imageServer}/images/dvd/btn_close_area.gif</c:if>");
    }
}



$(document).ready(function(){
    $('a#sendCoupon').click(function(){
        var barcode = "${p.sellPrdtBcode}";
        
        if (isEmpty(barcode)) {
            alert("오류가 발생하였습니다.");
        } else {
            var loginYN = "${isLogin}";
            if (loginYN == "true"){
                window.open('/ht/coupon/popupProductCoupon?barcode='+barcode,'popupPrizewinner','width=610,height=480');
                return false;
            } else {
                needLogin();
            }
        }
    });
    
    
    $("#aWriteCommentBtn").click(function(event) {
        event.preventDefault();
        if (isLogin){
            window.open(paramFactory("/ht/product/commentPopup4write"), "", "width=500, height=600, scrollbars=no");
            return false;
        } else {
            needLogin();
        }
    });
    
    $("#aWriteQuestionBtn").click(function(event) {
        event.preventDefault();
        if (isLogin){
            window.open(paramFactory("/ht/product/questionPopup4write"), "", "width=500, height=700, scrollbars=no");
            return false;
        } else {
            needLogin();
        }
    });
    
    loadCommentSubList();
    loadQuestionSubList();
    
    // 좋아요 펌핑
    setPumpBackground(".btn_like", 2, 110);
    
    // 최근본상품 등록
    saveRecentProduct("${p.sellPrdtBcode}");
    
    <c:if test="${not empty param.play}">
        var s = "${param.play}";
        var a = s.split(",");
        musicPlayer.base.openPlayerHot(a[0], a[1], a[2]);
    </c:if>    
});

function paramFactory(urlStr){
    var url = urlStr;
    url += "?rcrdCd=${p.rcrdCd}&barcode=dummy";
    return url;
}

<%-- 상품평 --%>
function loadCommentSubList(param){
    if(param != null && param != ""){
        var param = "?rcrdCd=${p.rcrdCd}&page="+param;
    }else{
        var param = "?rcrdCd=${p.rcrdCd}";
    }
    jQuery(function($) {
        $.ajax({
            type: "POST"
              ,url: "/ht/record/review" + param
              ,dataType: "html"
            ,success : function(html){
                $("#divSubCommentList").html(html);
            }
        });
    });
}

<%-- Q&A --%>
function loadQuestionSubList(param){
    if(param != null && param != ""){
        var param = "?rcrdCd=${p.rcrdCd}&page="+param;
    }else{
        var param = "?rcrdCd=${p.rcrdCd}";
    }
    jQuery(function($) {
        $.ajax({
            type: "POST"
              ,url: "/ht/record/qa" + param
              ,dataType: "html"
            ,success : function(html){
                $("#divSubQuestionList").html(html);
            }
        });
    });
}

function sendToKyobo(){
    AEC_F_D('${p.sellPrdtBcode}', 'i', $("input[name=productCount]").val());
}

//좋아요 토글
function toggleWichProduct(){
 if($(".btn_like").hasClass("active")){
     removeWishProduct("${p.sellPrdtBcode}");
 }else{
     fbq('track', 'AddToWishlist');
     addWishProduct("${p.sellPrdtBcode}");
 }
}

/* Facebook Pixel Code */
fbq('track', 'ViewContent');
/* End Facebook Pixel Code */
 
</script>
<script type='text/javascript' src='//assets.recobell.io/rblc/js/rblc-apne1.min.js'></script>
<script type='text/javascript'>
var _recoUserId = getCookie('UserCookieKey');
var _rbSendSyncLogs = function() {
rblc.op('setVar','cuid','e15e978e-3623-4892-bf0a-485b9f8196ee');
rblc.op('setVar','device','PW');
rblc.op('setVar','itemId','${p.sellPrdtBcode}');
rblc.op('track','add_to_cart');
// if you want to send user log with userId inserted
rblc.op('setVar','userId',SHA256(_recoUserId));
rblc.op('track', 'user');
};
</script>
</head>
<body>
<!-- detail_top -->
<div class="detail_top">
    <div class="inner">
        <!-- Location -->
        <div class="location_wrap_v2 mgt20 mgb10">
                <a href="/" class="btn_home">Home</a>
                <c:if test="${fn:startsWith(p.ctgrId, '0003')}"><div class="location_nav_wrap"><a class="location_1" href="/ht/biz/record/recordCategoryMain?ctgrId=0003">CD</a></div></c:if>
                <c:if test="${fn:startsWith(p.ctgrId, '0004')}"><div class="location_nav_wrap"><a class="location_1" href="/ht/biz/record/dvdCategoryMain?ctgrId=000401">DVD</a></div></c:if>
                <c:forEach varStatus="st" begin="6" end="${fn:length(p.ctgrId)}" step="2">
                    <c:if test="${st.last}"><div class="location_nav_wrap"><a class="location_1"><ui:category id="${p.ctgrId}" full="false"/></a></div></c:if>
                    <c:if test="${!st.last}"><div class="location_nav_wrap"><a class="location_1" href="/ht/biz/record/recordCategoryMain?ctgrId=${fn:substring(p.ctgrId, 0, st.index)}"><ui:category id="${fn:substring(p.ctgrId, 0, st.index)}" full="false"/></a></div></c:if>
                </c:forEach>
        </div>
        <!-- //Location -->
        
        <div class="detail_cont">
            <%-- <a href="/ht/diary/main" style="height:98px;margin: 0px 0 40px;">
                <img src="${imageServer}/images/diary/2018/top_950_98_2.png" alt="2019 다이어리배너"/>
            </a> --%>
            <c:if test="${p.hasPosterCase}">
                <p class="icon_p" style="position:absolute;left:0;"><img src="${imageServer}/images/music/icon_poster.png" class="iepngfix" alt="포스터 증정"/></p>
            </c:if>
            <div class="cover">
                <c:if test="${p.sellPrdtGbn eq 'R'}">
                    <span class="img t_center"><ui:image rcrdCd="${p.rcrdCd}" prdtGbn="${p.sellPrdtGbn}" width="400" alt="${p.rcrdName}" rcrdImgType="large" ratingCode="${p.rtngCode}" clazz="sns_img"/></span>
                </c:if>
                <c:if test="${p.sellPrdtGbn eq 'D'}">
                    <span class="img t_center"><ui:image rcrdCd="${p.rcrdCd}" prdtGbn="${p.sellPrdtGbn}" width="224" height="340" style="padding:30px;" alt="${p.rcrdName}" rcrdImgType="large" clazz="sns_img" ratingCode="${p.rtngCode}" /></span>
                </c:if>
                <ul class="mediainfo">
                    <c:if test="${p.sellPrdtGbn eq 'R'}">
                        <c:if test="${not empty p.artiName}">
                            <li><strong>아티스트</strong> : <a href="#" onclick="goSearchDtl('${p.artiName}', 'arti_name', 'RECORD');return false;">${p.artiName}</a> <span class="line">|</span></li>
                        </c:if>
                        <c:if test="${not empty p.makerName}">
                            <li><strong>제작사</strong> : <a href="#" onclick="goSearchDtl('${p.makerName}', 'maker_name', 'RECORD');return false;">${p.makerName}</a> <span class="line">|</span></li>
                        </c:if>
                        <c:if test="${not empty p.labelName}">
                            <li><strong>레이블</strong> : <a href="#" onclick="goSearchDtl('${p.labelName}', 'label_name', 'RECORD');return false;">${p.labelName}</a></li>
                        </c:if>
                        <c:if test="${fn:startsWith(p.ctgrId, '000308')}">
                            <c:if test="${not empty p.cmpsr}"><li><strong>작곡가</strong> : ${p.cmpsr}</li></c:if>
                            <c:if test="${not empty p.prfmr}"><li><strong>연주자</strong> : ${p.prfmr}</li></c:if>
                            <c:if test="${not empty p.cndtr}"><li><strong>지휘자</strong> : ${p.cndtr}</li></c:if>
                            <c:if test="${not empty p.ocstr}"><li><strong>오케스트라</strong> : ${p.ocstr}</li></c:if>
                            <c:if test="${not empty p.insmt}"><li><strong>악기</strong> : ${p.insmt}</li></c:if>
                            <c:if test="${not empty p.vocal}"><li><strong>보컬</strong> : ${p.vocal}</li></c:if>
                        </c:if>
                    </c:if>
                    <c:if test="${p.sellPrdtGbn eq 'D' && fn:startsWith(p.ctgrId, '000400')}">
                        <c:if test="${not empty p.drctr}">
                            <li>
                                <strong>감독</strong> : 
                                <c:set var="directors" value="${fn:split(p.drctr, ',')}"/>
                                <c:forEach items="${directors}" var="director" varStatus="st">
                                    <c:if test="${!st.first}">,</c:if>
                                    <a href="#" onclick="goSearchDtl('${director}', 'drctr', 'BLURAY');return false;">${director}</a>
                                </c:forEach>
                                <span class="line">|</span>
                            </li>
                        </c:if>
                        <c:if test="${not empty p.actor}">
                            <li>
                                <strong>출연자</strong> : 
                                <c:set var="actors" value="${fn:split(p.actor, ',')}"/>
                                <c:forEach items="${actors}" var="actor" varStatus="st">
                                    <c:if test="${!st.first}">,</c:if>
                                    <a href="#" onclick="goSearchDtl('${actor}', 'actor', 'BLURAY');return false;">${actor}</a>
                                </c:forEach>
                                <span class="line">|</span>
                            </li>
                        </c:if>
                        <c:if test="${not empty p.makerName}">
                            <li>
                                <strong>제작사</strong> : <!-- 제작사는 변수값이 없음 -->
                                <c:set var="makers" value="${fn:split(p.makerName, ',')}"/>
                                <c:forEach items="${makers}" var="maker" varStatus="st">
                                    <c:if test="${!st.first}">,</c:if>
                                    <a href="#" onclick="goSearchDtl('${maker}', 'maker_name', 'BLURAY');return false;">${maker}</a>
                                </c:forEach>
                                <span class="line">|</span>
                            </li>
                        </c:if>
                        <c:if test="${not empty p.labelName}">
                            <li>
                                <strong>레이블</strong> : 
                                <c:set var="labels" value="${fn:split(p.labelName, ',')}"/>
                                <c:forEach items="${labels}" var="label" varStatus="st">
                                    <c:if test="${!st.first}">,</c:if>
                                    <a href="#" onclick="goSearchDtl('${label}', 'label_name', 'BLURAY');return false;">${label}</a>
                                </c:forEach>
                                <span class="line">|</span>
                            </li>
                        </c:if>
                    </c:if>
                    <c:if test="${p.sellPrdtGbn eq 'D' && fn:startsWith(p.ctgrId, '000401')}">
                        <c:if test="${not empty p.drctr}">
                            <li>
                                <strong>감독</strong> : 
                                <c:set var="directors" value="${fn:split(p.drctr, ',')}"/>
                                <c:forEach items="${directors}" var="director" varStatus="st">
                                    <c:if test="${!st.first}">,</c:if>
                                    <a href="#" onclick="goSearchDtl('${director}', 'drctr', 'DVD');return false;">${director}</a>
                                </c:forEach>
                                <span class="line">|</span>
                            </li>
                        </c:if>
                        <c:if test="${not empty p.actor}">
                            <li>
                                <strong>출연자</strong> : 
                                <c:set var="actors" value="${fn:split(p.actor, ',')}"/>
                                <c:forEach items="${actors}" var="actor" varStatus="st">
                                    <c:if test="${!st.first}">,</c:if>
                                    <a href="#" onclick="goSearchDtl('${actor}', 'actor', 'DVD');return false;">${actor}</a>
                                </c:forEach>
                                <span class="line">|</span>
                            </li>
                        </c:if>
                        <c:if test="${not empty p.makerName}">
                            <li>
                                <strong>제작사</strong> : <!-- 제작사는 변수값이 없음 -->
                                <c:set var="makers" value="${fn:split(p.makerName, ',')}"/>
                                <c:forEach items="${makers}" var="maker" varStatus="st">
                                    <c:if test="${!st.first}">,</c:if>
                                    <a href="#" onclick="goSearchDtl('${maker}', 'maker_name', 'DVD');return false;">${maker}</a>
                                </c:forEach>
                                <span class="line">|</span>
                            </li>
                        </c:if>
                        <c:if test="${not empty p.labelName}">
                            <li>
                                <strong>레이블</strong> : 
                                <c:set var="labels" value="${fn:split(p.labelName, ',')}"/>
                                <c:forEach items="${labels}" var="label" varStatus="st">
                                    <c:if test="${!st.first}">,</c:if>
                                    <a href="#" onclick="goSearchDtl('${label}', 'label_name', 'DVD');return false;">${label}</a>
                                </c:forEach>
                                <span class="line">|</span>
                            </li>
                        </c:if>
                    </c:if>
                    <c:if test="${not empty p.rlseDt}">
                       <li class="date"><strong>출시일</strong> : <ui:mask pattern="####년##월##일">${p.rlseDt}</ui:mask></li>
                    </c:if>
                </ul>
                <c:if test="${not empty p.rcrdMdMemoReal}">
                    <p class="txt_tip"><span class="hidden_obj">Tip</span>${p.rcrdMdMemoReal}</p>
                </c:if>
                
            </div>
            <span class="ico_label badge">
                <c:if test="${p.mediaName ne 'VCD' && fn:startsWith(p.ctgrId, '000400')}"><span class="badge02">블루레이</span></c:if>
                <c:if test="${p.mediaName ne 'VCD' && fn:startsWith(p.ctgrId, '000401')}"><span class="badge02">DVD</span></c:if>
                <!-- 지관통포스터 추가 -->
                <c:if test="${p.hasPosterCase}"><span class="badge01">포스터</span></c:if>
                <c:if test="${not empty p.couponList}"><span class="badge01">쿠폰</span></c:if>
                
                <c:if test="${p.impYn eq 'Y'}"><span class="badge02">수입</span></c:if>
                <c:if test="${p.rcrdStat eq '9'}"><span class="badge02">예약</span></c:if>
                <c:if test="${p.haveFreeGiftHaveYn eq 'Y'}"><span class="badge02">사은품</span></c:if>
                
                <c:if test="${p.saleYn ne 'Y'}">
                    <c:choose>
                        <c:when test="${p.rcrdStat eq '0' || p.rcrdStat eq '1' || p.rcrdStat eq '6'}">
                            <span class="badge03">일시품절</span>
                        </c:when>
                        <c:when test="${p.rcrdStat eq '3'}">
                            <span class="badge03">품절</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge03">품절</span>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </span>
            <div class="detail_info">
                <h2 class="tit mgt30">
                    <c:if test="${!fn:contains('DVD,BLU-RAY DISC', p.artiName)}">${p.artiName} - </c:if>
                    ${p.commTitle}
                </h2>
                <ul>
                	<c:if test="${not empty p.rcrdSubComments}">
                        <li class="mgb10"><span class="sub_tit">${p.rcrdSubComments}</span></li>
                    </c:if>
                    <c:if test="${p.rtngCode eq 'C0845'}">
                        <li class="mgb10"><span class="sub_tit">19세 이상 상품입니다.</span></li>
                    </c:if>
                    <li>
                        <span class="tit">판매가</span>
                        <div class="price">
                            <c:if test="${p.prdtSellPrice <= p.lastDcPrice}">
                                <strong><fmt:formatNumber value="${p.prdtSellPrice}" pattern=",###" /></strong>
                            </c:if>
                            <c:if test="${p.prdtSellPrice > p.lastDcPrice}">
                                <span class="ori_price"><fmt:formatNumber value="${p.prdtSellPrice}" pattern=",###" /></span>
                                <strong><fmt:formatNumber value="${p.lastDcPrice}" pattern=",###" /></strong> (${hfn:rate(p.prdtSellPrice, p.lastDcPrice)}%)
                            </c:if>
                        </div>
                    </li>
                    <c:if test="${p.lastDcPrice > p.lastCpnPrice}">
                        <li>
                            <span class="tit">쿠폰적용가</span>
                            <div class="price">
                                <span class="ori_price"><fmt:formatNumber value="${p.lastDcPrice}" pattern=",###" /></span>
                                <strong class="c_point"><fmt:formatNumber value="${p.lastCpnPrice}" pattern=",###" /></strong>
                                <c:forEach items="${p.couponList}" var="l" varStatus="st" end="0">
                                    <span class="c_amt">
                                        <c:if test="${l.rateYn}"><fmt:formatNumber type="number">${l.couponDiscountRate}</fmt:formatNumber>%</c:if>
                                        <c:if test="${!l.rateYn}"><fmt:formatNumber type="number">${l.couponDiscountAmount}</fmt:formatNumber></c:if>
                                    </span>
                                    <span class="c_down"><a href="javascript://" id="sendCoupon" class="btn_type05_v2">쿠폰받기</a></span>
                                </c:forEach>
                            </div>
                        </li>
                    </c:if>
                    <c:if test="${p.prdtSavedRate > 0}">
                        <li>
                            <span class="tit">통합포인트</span>
                            <div>
                                <c:set var="savedPrice" value="${p.lastDcPrice * p.prdtSavedRate / 100}"/>
                                <span class="w100"><fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" pattern=",###" />원 (${p.prdtSavedRate}%적립)</span>
                                <div class="tooltip_wrap">
                                    <a href="#tooltip03" class="tooltip">?</a>
                                    <div id="tooltip03" class="layer_pop_wrap">
                                        <div class="layer_pop_container" style="width:340px;height:385px;">
                                            <h1>통합포인트 안내</h1>
                                            <div class="layer_pop_cont">
                                                <ul>
                                                    <li>•<strong>핫트랙스 온라인/오프라인, 교보문고 온라인/오프라인, 모바일 교보문고에서 모두 적립&middot;사용 가능!</strong></li>
                                                    <li>•<strong>10원 이상의 포인트도 바로바로 사용! (영업점은 1,000원 단위 사용)</strong><br />주문 시, 10원 단위부터 사용하실 수 있습니다.</li>
                                                    <li>•<strong>자동적립되는 편리한 포인트!</strong><br />구매 후 어떤 절차나 과정없이 바로 자동으로 적립됩니다.</li>
                                                    <li>•<strong>포인트 확인도 폭넓~게!</strong><br />온라인 마이룸, 모바일, 무인가입기, 영업점 영수증 등에서 적립하거나 사용하신 포인트 내역을 확인하실 수 있습니다.<br />
                                                    상품 구매 시 해당 상품의 적립률에 따라 지급되며 고객님께서 주문하신 상품이 발송완료 된 후 자동 지급됩니다.<br />단, 쿠폰 또는 마일리지, 통합포인트 사용 시 예상적립금이 변동될 수 있습니다.<br />(주문취소나 반품시에는 적립된 통합포인트가 다시 차감됩니다.)</li>
                                                </ul>
                                            </div>
                                            <a href="#none" class="cls_btn" title="레이어팝업 닫기"><img src="${imageServer}/images/renewal/common/btn_cls.gif" alt="닫기" /></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </c:if>
                    <li>
                        <span class="tit">카드혜택</span>
                        <div>
                            <span class="w100">신용카드할인안내</span>
                            <div class="tooltip_wrap">
                                <a href="#tooltip" class="tooltip">?</a>
                                <div id="tooltip" class="layer_pop_wrap">
                                    <div class="layer_pop_container" style="width:309px;line-height:20px;">
                                         <h1>신용카드 할인안내</h1>
                                            <div class="layer_pop_cont pd0">
                                                <ul class="card_list">
                                                    <li>
                                                        <span class="img"><img src="${imageServer}/images/common/ic_card_80_50.png" alt="신용카드" /></span>
                                                        <div class="txt">
                                                            <strong>신한카드</strong>
                                                            -2~6개월, 12개월(부분) 무이자
                 										    <strong>하나카드</strong>
                                                            -2~3개월 무이자
	                                                        <strong>국민카드</strong>
                                                            -2~5개월 무이자
                                                            <strong>비씨, NH농협, 현대, 삼성카드</strong>															
															-2~6개월 무이자
															<strong>유의사항</strong>
															-법인,체크,선불,기프트,하이브리드 제외<br/>
															-무이자 적용 최소결제 금액 등 상세 내용은 결제 팝업창에서 확인 요망
                                                        </div>
                                                    </li>
	                                                <li>
	                                                    <span class="img"><img src="${imageServer}/images/common/smilepay_80_50.jpg" alt="스마일페이" /></span>
                                                        <div class="txt">
                                                            <strong>※Smile Pay  결제시 2천원 적립</strong>
                                                            -이벤트 기간 : 2019.08.01 ~ 2019.12.31<br/>
                                                            -스마일페이로 3만원 이상 첫 결제 시 2천원 스마일캐시 적립
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        <a href="#none" class="cls_btn" title="레이어팝업 닫기"><img src="${imageServer}/images/renewal/common/btn_cls.gif" alt="닫기" /></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <span class="tit">배송구분</span>
                        <div>
                            <span class="w100">핫트랙스 배송</span>
                            <div class="tooltip_wrap">
                                <a href="#tooltip02" class="tooltip">?</a>
                                <div id="tooltip02" class="layer_pop_wrap">
                                    <div class="layer_pop_container" style="width:289px;height:100px;line-height:20px;">
                                        <h1>핫트랙스 배송</h1>
                                        <div class="layer_pop_cont">
                                            <p>${p.lastDcPrice < 20000?'2,000 원 (20,000 이상 구매시 무료)':'무료배송'}</p>
                                            <p>도서·산간지역 추가요금 있음</p>
                                        </div>
                                        <a href="#none" class="cls_btn" title="레이어팝업 닫기"><img src="${imageServer}/images/renewal/common/btn_cls.gif" alt="닫기" /></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
                <ul>
                    <c:if test="${p.rcrdStat eq '9' or p.sellPrdtGbn eq 'R'}">
                        <c:if test="${p.rcrdStat eq '9'}">
                            <c:choose>
                                <c:when test="${not empty p.okdate && fn:length(p.okdate) == 8 && p.okdate ne '00000000'}">
                                    <li>
                                        <span class="tit">예약상품</span>
                                        <div class="pdt3"><span><ui:mask pattern="####.##.##">${p.okdate}</ui:mask> 발매 예정입니다.</span></div>
                                    </li>
                                </c:when>
                                <c:when test="${not empty p.rlseDt && fn:length(p.rlseDt) == 8}">
                                    <li>
                                        <span class="tit">예약상품</span>
                                        <div class="pdt3"><span><ui:mask pattern="####.##.##">${p.rlseDt}</ui:mask> 발매 예정입니다.</span></div>
                                    </li>
                                </c:when>
                                <c:otherwise><li class="mgb15"><strong class="tit c_black">예약판매 입니다.</strong></li></c:otherwise>
                            </c:choose>
                        </c:if>
                    </c:if>
                    <li>
                        <span class="tit">상품코드</span>
                        <div class="pdt3">${p.sellPrdtBcode} (음반코드 : ${p.rcrdCd})</div>
                    </li>
                    <c:if test="${not empty dlvyInfo}"><%-- RecordController.getDelvStatus 메서드 JSP로 변경[2013.03.27] --%>
                        <li>
                            <span class="tit">배송안내</span>
                            <div class="pdt3">
                                <c:choose>
                                    <c:when test="${dlvyInfo.rcrdHardSaleYn eq 'Y'}"><!-- 강제 판매인 경우의 처리 (20120806) -->
                                        <span>예상출고일 <strong>3일 이내</strong> (상품주문 후  4~5일 이내 받을 수 있습니다.)</span>
                                    </c:when>
                                    <c:when test="${quickGbYn eq 'Y'}"><!-- 바로배송인 경우 -->
                                        <!-- 바로배송 체크 => 주말이 아니고 오전 10시 이전이면 바로배송 정보 구성, 바로배송 조건이 만족하지 않을 경우 다음날 배송으로 정보 구성 -->
                                        <c:choose>
                                            <c:when test="${currTime < 10 && currDayOfWeek != 1 && currDayOfWeek != 7}"><span><strong>바로배송</strong> 지금 주문하면 <span class="c_blue">오늘(${currDay}일, ${currWeekName})</span> 받을 수 있습니다.</span></c:when>
                                            <c:otherwise><span><strong>바로배송</strong> 오전 10시 이전 주문은 오늘,이후 주문은 내일 도착 (일,공휴일 제외)</span></c:otherwise>
                                        </c:choose>
                                        <span><a class="btn_type05_v2" href="http://www.kyobobook.co.kr/event/memberBenefit.laf?page=30&orderClick=LAa" target="_blank" title="안내">안내</a></span>
                                    </c:when>
                                    <c:when test="${p.rcrdStat eq '5'}"><!-- 인터넷 주문 불가 상품에 대한 처리 -->
                                        <span class="c_red">인터넷주문불가</span>
                                    </c:when>
                                    <c:when test="${p.rcrdStat eq '2' || p.rcrdStat eq '4'}"><!-- 품절 상품에 대한 처리 -->
                                        <span class="c_red">품절</span>
                                    </c:when>
                                    <c:when test="${p.rcrdStat eq '3'}"><!-- 절판 상품에 대한 처리 -->
                                        <span class="c_red">절판</span>
                                    </c:when>
                                    <c:when test="${p.rcrdStat eq '9'}"><!-- 예약 상품에 대한 처리 -->
                                        <c:choose>
                                            <c:when test="${not empty p.okdate  && fn:length(p.okdate) == 8 && p.okdate ne '00000000'}">
                                                <span><strong>예약판매 : <ui:mask pattern="####.##.##">${p.okdate}</ui:mask> 발매 예정</strong>입니다.</span>
                                            </c:when>
                                            <c:when test="${not empty p.rlseDt && fn:length(p.rlseDt) == 8}">
                                                <span><strong>예약판매 : <ui:mask pattern="####.##.##">${p.rlseDt}</ui:mask> 발매 예정</strong>입니다.</span>
                                            </c:when>
                                            <c:otherwise><span><strong>예약판매</strong> 입니다.</span></c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:when test="${fn:contains('0|1|6', p.rcrdStat) && dlvyInfo.hotStockQty <= 1 && dlvyInfo.stockCntProduct < 1 && dlvyInfo.rcrdHardSaleYn eq 'N'}"><!-- 일시품절에 대한 처리 -->
                                        <span><span class="c_red">일시품절</span> (알림메일 받기를 신청하면 정상유통시 알려드립니다.)</span>
                                    </c:when>
                                    <c:when test="${p.rcrdStat eq '0'}"><!-- 정상상품에 대한 처리 -->
                                        <c:choose>
                                            <c:when test="${empty dlvyInfo.leadDay || dlvyInfo.leadDay eq 0}">
                                                <span>예상출고일 <strong>1일 이내</strong> (상품주문 후 2~3일 이내 받을 수 있습니다.)</span>
                                            </c:when>
                                            <c:when test="${dlvyInfo.leadDay < 7}">
                                                <span>예상출고일 <strong>${dlvyInfo.leadDay}일 이내</strong> (상품주문 후 ${dlvyInfo.leadDay+1}~${dlvyInfo.leadDay+2}일 이내 받을 수 있습니다.)</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span>예상출고일 <strong>7일 이후</strong> (상품주문 후  9~10일 이내 받을 수 있습니다.)</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                </c:choose>
                            </div>
                        </li>
                    </c:if>
                    <li>
                        <span class="tit">수량</span>
                        <div class="count">
                            <form name="productForm">
                                <input type="text" value="1" name="prdtCount" maxlength="4" class="inputNumberText" style='ime-mode:disabled' title="수량입력"/>
                                <span class="button_wrap mgl4m">
                                    <button type="button" class="up">증가</button>
                                    <button type="button" class="down">감소</button>
                                </span>
                                <span class="s_txt">개</span>
                            </form> 
                        </div>
                    </li>
                </ul>
                <div class="sns">
                    <c:if test="${p.sellPrdtGbn eq 'R' && p.mediaName ne 'LP'}">
                        <p>음반 판매자료는 <span class="c_red">온/오프라인 동일하게 </span>한터차트와 뮤직뱅크 차트, 가온차트 <span class="c_red">판매량 집계에 100%</span> 반영됩니다.</p>
                        <p class="mgt10">Music sales data from both ON&OFF LINE STORES, Would be 100% counted for HANTEO CHART/MUSIC BANK CHART/GAON CHART.</p>
                    </c:if>
                    <c:if test='${fn:startsWith(cateList[1].cateId,"000400") }'>
                        <p><strong class="c_black">BLU-RAY 전용 플레이어 상품이며</strong>, DVD 플레이어에서는 재생이 되지 않습니다.</p>
                    </c:if>
                    <div class="btn_wrap">
                        <a href="javascript://" onclick="goTwitter('${p.commTitle}', '${defaultHost}/ht/product/detail?barcode=${p.sellPrdtBcode}')"><img src="${imageServer}/images/renewal/common/ico_sns_twitter.png" alt="twitter"/></a>
                        <a href="javascript://" onclick="goFaceBook('${p.commTitle}', '${defaultHost}/ht/product/detail?barcode=${p.sellPrdtBcode}')"><img src="${imageServer}/images/renewal/common/ico_sns_facebook.png" alt="facebook"/></a>
                        <a href="javascript://" onclick="goPinterest('${p.commTitle}', '${defaultHost}/ht/product/detail?barcode=${p.sellPrdtBcode}')"><img src="${imageServer}/images/renewal/common/ico_sns_pinterest.png" alt="pinterest" style="width:28px;height:28px;" nopin="true"/></a>
                    </div>
                </div>
                <div class="btn_wrap mgt35<c:if test="${not empty p.offlineUrl}"> small01</c:if>">
                    <c:choose>
                        <c:when test="${p.wishUserPrdtCnt eq '0'}"><c:set var="linkCls" value="pump"/></c:when>
                        <c:otherwise><c:set var="linkCls" value="active"/></c:otherwise>
                    </c:choose>
                    <c:if test="${p.saleYn eq 'Y'}">
                        <a href="javascript://" onclick="detailBuy()" onMouseDown="javascript:sendToKyobo()" class="btn_type04_v1 fs18" style="width:133px;">바로구매</a>
                        <a href="javascript://" onclick="detailCart()" onMouseDown="javascript:sendToKyobo()" class="btn_type04_v2 fs18 mgl8" style="width:133px;">장바구니</a>
                        <a href="#" onclick="toggleWichProduct();return false;" class="btn_type04_v2 mgl7" style="width:133px;"><em class="btn_like ${linkCls}"><fmt:formatNumber type="number">${p.wishPrdtCnt}</fmt:formatNumber></em></a>
                    </c:if>
                    
                    <c:if test="${p.outOfStockMailYn eq 'Y'}">
                        <a href="#" onclick="addRecordStockedInfoRequest('${p.rcrdCd}');return false;" class="btn_type04_v2">알림예약 신청하기</a>
                        <a href="#" onclick="toggleWichProduct();return false;" class="btn_type04_v2 mgl7" style="width:133px;"><em class="btn_like ${linkCls}"><fmt:formatNumber type="number">${p.wishPrdtCnt}</fmt:formatNumber></em></a>
                    </c:if>
                    
                    <c:if test="${not empty p.offlineUrl}">
						<a href="${p.offlineUrl}" class="btn_360 mgt20 fs18" style="width:423px;">핫트픽업 매장수령 예약주문</a>
                        <div class="mgt20 fs14 p_lineh20">
                            <strong>※ 핫트픽업 예약주문이란?</strong>
                            <p class="mgt10 c_gray">앨범 출시 전 예약주문 기간 내, 핫트랙스 온라인으로 예약주문을 하고, 공지되어있는 수령일에 핫트랙스 오프라인 매장으로 고객님께서 방문하여 수령하시는 주문방식입니다. 이 주문은 별도 배송이 되지 않으며, 선택하신 매장 외 다른 매장에서는 수령이 불가합니다.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- //detail_top -->

<!-- 레코벨 추천상품 start-->
<div class="best_music_a">
<ul class="best_music">
    <c:set var="relCnt" value="0"/>
    <c:forEach begin="0" end="4" varStatus="s1">
        <c:if test="${s1.index eq 0}"><c:set var="title" value="분야 베스트"/><c:set var="list" value="${bestRecordList}"/></c:if>
        <c:if test="${s1.index eq 1}"><c:set var="title" value="이 아티스트의 다른음반"/><c:set var="list" value="${artiRecordList}"/></c:if>
        <c:if test="${s1.index eq 2 && p.sellPrdtGbn eq 'R'}"><c:set var="title" value="이 분야의 새 앨범"/><c:set var="list" value="${newRecordList}"/></c:if>
        <c:if test="${s1.index eq 2 && p.sellPrdtGbn eq 'D'}"><c:set var="title" value="이 분야의 새 상품"/><c:set var="list" value="${newRecordList}"/></c:if>
        <c:if test="${s1.index eq 3}"><c:set var="title" value="오늘만 특가 상품"/><c:set var="list" value="${todaySaleList}"/></c:if>
        <c:if test="${s1.index eq 4}"><c:set var="title" value="발매 예정 상품"/><c:set var="list" value="${reserveList}"/></c:if>
        <c:if test="${not empty list}">
            <c:set var="relCnt" value="${relCnt+1}"/>
            <li class="t_tab<c:if test="${relCnt eq 1}"> active</c:if>">
                <a href="javascript://" class="tab"><span>${title}</span></a>
                <div class="depth2 swiper-container">
                    <div class="swiper-wrapper">
                    <c:forEach items="${list}" varStatus="s"  step="4" end="11">
                    <ul class="swiper-slide">
                        	<c:forEach items="${list}" var="l" varStatus="st" begin="${s.index}" end="${s.index+3}">
                            <li class="txt_line1">
                                <a href="/ht/record/detail/${l.sellPrdtBcode}" title="${l.artiName} - ${l.commTitle}">
                                    <span class="cover t_center"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'133':'87'}" alt="${l.rcrdName}" ratingCode="${l.ratingCode}"/></span>
                                    <span class="artist">${l.commTitle}</span>
                                    <strong class="tit">${l.artiName}</strong>
                                </a>
                            </li>
                            </c:forEach>
                    </ul>
                    </c:forEach>
                </div>
                
                <div class="p_pagination">
	                 	<!-- Add Pagination -->
					    <div class="swiper-pagination"></div>
					    <!-- Add Arrows -->
					    <div class="swiper-button-area">
					    	<div class="swiper-button-next"></div>
					    	<div class="swiper-button-prev"></div>
					    </div>
				     </div> 
                </div>  	
                
            </li>
        </c:if>
    </c:forEach>
</ul>
</div>

<script type="text/javascript" src="/js/swiper-5.1.0.min.js?${tmpKey}"></script>
<script>
 var swiper = new Swiper('.swiper-container', {
   speed: 1000,
   pagination: {
     el: '.swiper-pagination',
     type: 'fraction',
   },
   navigation: {
     nextEl: '.swiper-button-next',
     prevEl: '.swiper-button-prev',
   },
 });

 $('.swiper-pagination-fraction').each(function() {
	 var text = $(this).html();
	 $(this).html(text.replace(' / ', ' '));

 });
</script>

<style>    
.best_music .p_pagination {position: absolute; bottom: 0px; width: 232px; height: 44px; left: 50%; margin-left: -116px;}
.best_music .swiper-pagination {font-size: 18px; line-height: 21px; height:44px;}
_:-ms-fullscreen, :root .best_music .swiper-pagination {line-height: 44px !important; bottom:0px !important;}
_:-ms-fullscreen, :root .best_music .p_pagination {bottom:20px !important;}
.best_music .swiper-pagination span.swiper-pagination-current {font-family: font_gs, sans-serif; font-weight:bold; color: #000; margin-right: 8px; line-height: 21px;}
.best_music .swiper-pagination span.swiper-pagination-total {font-family: font_gs, sans-serif; font-weight:normal; color: #777; line-height: 21px;}
.best_music .swiper-button-area {position:absolute;width:232px;left:50%;margin-left:-116px;bottom:0;height:44px; top:auto;}
.best_music .swiper-button-next {position:absolute; width:44px; height:44px; background:url('https://simage.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/icon_swiper_arr03.png') no-repeat; background-position:-88px 0; overflow:hidden; font-size:0; line-height:0px; text-indent:-9999px; opacity: 1; top:auto;}
.best_music .swiper-button-prev {position:absolute; width:44px; height:44px; background:url('https://simage.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/icon_swiper_arr03.png') no-repeat; background-position:-44px 0; overflow:hidden; font-size:0; line-height:0px; text-indent:-9999px; opacity: 1; top:auto;}
.best_music .swiper-button-next.swiper-button-disabled {position:absolute; width:44px; height:44px; background-position:100% 0; overflow:hidden; font-size:0; line-height:0px; text-indent:-9999px; opacity: 1;}
.best_music .swiper-button-prev.swiper-button-disabled {position:absolute; width:44px; height:44px; background-position:0 0; overflow:hidden; font-size:0; line-height:0px; text-indent:-9999px; opacity: 1;}
.best_music .swiper-button-next, .swiper-button-prev {display: inline-flex;}
</style>
<!-- 레코벨 추천상품 end-->

<!-- 상품정보 -->
<div class="detail_p_info">
    <!-- 음반정보 -->
    <div class="" id="detail_cont01">
        <ul class="detail_tab">
            <li class="active"><a href="#detail_cont01">${p.sellPrdtGbn eq 'R'?'음반':'상품'}정보<span class="hidden_obj">- 현재진행단계</span></a></li>
            <li><a href="#detail_cont02">상품후기<span class="product-estimation c_salmon mgl10">(0)</span></a></li>
            <li><a href="#detail_cont03">상품Q&amp;A<span class="product-qna c_salmon mgl10">(0)</span></a></li>
            <li><a href="#detail_cont04">배송/교환/반품</a></li>
        </ul>
        
        <c:if test="${not empty bnrPrdtDetail}">
            <c:forEach var="l" varStatus="st" items="${bnrPrdtDetail}">
                <p style="text-align:center;margin:20px 0;">
                    <c:if test="${l.linkUrl ne '#'}"> 
                        <a href="${l.linkUrl }"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.imgUrl }" style="max-width:100%;"/></a>
                    </c:if>
                    <c:if test="${l.linkUrl eq '#'}"> 
                        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.imgUrl }" style="max-width:100%;"/>
                    </c:if>
                </p>
            </c:forEach>
        </c:if>
        <c:if test="${not empty listTrack && not empty listTrack.cdNoList}">
            <h2 class="hidden_obj">음반정보</h2>
            <h3 class="tit_tahoma">Track List</h3>
            <c:forEach items="${listTrack.cdNoList}" var="cdNo" varStatus="status">
                <div class="track_tool<c:if test="${!status.first}"> mgt50</c:if>">
                    <span>DISC ${cdNo}</span>
                    <c:if test="${listTrack.cdNoMapHasAudio[cdNo]}">
                        <a href="javascript://" onclick="playAllHot()" class="btn_type01">전체듣기</a>
                    </c:if>
                </div>
                <table class="table02_v1">
                    <caption>Track List<span>NO, 곡명, 듣기</span></caption>
                    <colgroup>
                        <col style="width:60px" />
                        <col style="width:*" />
                        <col style="width:50px" />
                    </colgroup>
                    <thead>
                        <tr>
                            <c:if test="${listTrack.cdNoMapHasAudio[cdNo]}">
                                <th scope="col" class="check" style="display:none;">
                                   <input type="checkbox" name="checkbox" onclick="chkAll(this)" value="${cdNo}" title="전체 곡 선택/해제"/>
                                </th>
                            </c:if>
                            <th scope="col">No.</th>
                            <th scope="col">곡명</th>
                            <th scope="col">듣기</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${listTrack.cdNoMapList[cdNo]}" var="l" varStatus="s">
                            <tr>
                               <c:if test="${listTrack.cdNoMapHasAudio[cdNo]}">
                                    <th scope="row" class="check" style="display:none;">
                                       <c:if test="${l.audioYn eq 'Y'}">
                                           <input type="checkbox" name="chkTrkNo" class="listDsc listDsc${cdNo}" value="${p.rcrdCd},${l.cdNo},${l.trkNo}" title="[${l.trkName}] 선택"/>
                                       </c:if>
                                    </th>
                                </c:if>
                                <td>${l.trkNo}</td>
                                <td class="t_left">
                                    <c:if test="${l.audioYn eq 'Y'}">
                                       <a href="javascript:musicPlayer.base.openPlayerHot('${l.rcrdCd}','${l.cdNo}','${l.trkNo}');">
                                           ${l.trkName}
                                           <c:if test="${not empty l.artiName}">(${l.artiName})</c:if>
                                       </a>
                                    </c:if>
                                    <c:if test="${l.audioYn ne 'Y'}">
                                        ${l.trkName}
                                        <c:if test="${not empty l.artiName}">(${l.artiName})</c:if>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${l.audioYn eq 'Y'}">
                                        <a href="javascript://" onclick="musicPlayer.base.openPlayerHot('${l.rcrdCd}','${l.cdNo}','${l.trkNo}');"><img src="${imageServer}/images/sound/btn_listen.png" class="iepngfix" alt="듣기" /></a>
                                    </c:if>
                                    <c:if test="${l.audioYn ne 'Y'}">
                                        <img src="${imageServer}/images/sound/btn_listen_off.png" class="iepngfix" alt="듣기" />
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:forEach>
        </c:if>
        <div class="track_info mgt50">
            <c:if test="${p.hasPosterCase}">
                <strong>포스터는 포스터 지관통에 담아 발송해 드립니다.</strong>
                <p>(앨범을 2장 이상 구매 시 포스터는 구매 수량과 동일하게 증정되며, 포스터 지관통은 주문 건당 1개만 증정됩니다.)<br />단 해외 주문 건은 포스터가 발송 되지 않습니다</p>
            </c:if>
            <c:if test="${not empty p.okdate and p.rcrdStat eq '9'}">
                <strong style="color:#1591D2;">본 상품은 <ui:mask pattern="####년##월##일">${p.rlseDtNextDay}</ui:mask> 발송 예정인 예약판매 ${p.sellPrdtGbn eq 'R'?'음반':'상품'} 입니다.</strong>
                <p>예약 상품의 경우 발매일은 제작사의 사정에 따라 연기 될 수도 있으며, 예약 상품과 같이 주문하시는 상품은 예약상품 발매 후 같이 발송 됩니다. 먼저 출시된 다른 상품을 먼저 받아보시려면 예약 상품과 별도의 주문을 하셔야 합니다</p>
            </c:if>
        </div>
        <c:if test="${fn:startsWith(p.ctgrId, '0004')}">
            <div class="album_info">
                <h3>상품 추가 정보</h3>
                <h4><c:if test="${not empty p.actor}">출연자 : ${p.actor}</c:if></h4>
                <p>
                    <c:if test="${not empty p.drctr}">감독 : ${p.drctr}  |  </c:if>
                    <c:if test="${not empty p.lang}">언어 : ${p.lang}  |  </c:if>
                    <c:if test="${not empty p.captn}">자막 : ${p.captn}</c:if>
                    <br />
                    <c:if test="${not empty p.scr}">화면 : ${p.scr} | </c:if>
                    <c:if test="${not empty p.sound}">음향 : ${p.sound}</c:if>
                    <br />
                    <c:if test="${not empty p.scrHour}">상영시간 :  ${p.scrHour} | </c:if>
                    <c:if test="${not empty p.cdCount}">디스크 수 : ${p.cdCount}  |  </c:if>
                    <c:if test="${not empty p.localCode && fn:startsWith(p.ctgrId, '000401')}">지역코드 : ${p.localCode}  |  </c:if>
                    <c:if test="${not empty p.rcrdYear}">제작년도 : ${p.rcrdYear}  |  </c:if>
                    <c:if test="${not empty p.rtngCode}">등급 : <ui:code codeId="${p.rtngCode}" /></c:if> 
                </p>
            </div>
        </c:if>
        <div class="album_option">
            <ul>
                <c:if test="${not empty p.mediaName}">
                    <li>
                        <strong>미디어</strong> : ${p.mediaName}
                        <div class="tooltip_wrap">
                            <a href="#tooltip3" class="tooltip">?</a>
                            <div id="tooltip3" class="layer_pop_wrap">
                                <div class="layer_pop_container" style="width:360px;height:385px;">
                                    <h1>미디어 코드 안내</h1>
                                    <div class="layer_pop_cont">
                                        <ul class="list_type02">
                                            <li>
                                                <strong>SACD</strong><br />
                                                본 음반은 Super Audio CD Players에서만 재생 가능합니다.
                                            </li>
                                            <li>
                                                <strong>SACD Hybrid</strong><br />
                                                본 음반은 일반 CD Players, Super Audio CD Players 모두 재생가능합니다.
                                            </li>
                                            <li>
                                                <strong>DVD Audio</strong><br />
                                                이것은 오직 DVD 플레이어에서만 재생 가능한 고음질 5.1채널 CD로서 영상은 포함되어 있지 않으니 유념하시기 바랍니다.
                                            </li>
                                            <li>
                                                <strong>Blu-Ray</strong><br />
                                                화질, 음향이 DVD보다 진화된 차세대 영상미디어 입니다.<br />
                                                Blu-Ray는 Blu-Ray 전용플레이어서만 플레이가 되며, DVD 플레이어에서는 재생이 되지 않습니다.
                                            </li>
                                            <li>
                                                <strong>Blu-Ray Audio</strong><br />
                                                영상이 없는 '듣는 블루레이'입니다.<br />
                                                Blu-Ray Audio는 Blu-Ray 전용 플레이어에서만 플레이가 되며, CD플레이어, DVD플레이어 등에서는 재생이 되지 않습니다.
                                            </li>
                                        </ul>
                                    </div>
                                    <a href="#none" class="cls_btn" title="레이어팝업 닫기"><img src="${imageServer}/images/renewal/common/btn_cls.gif" alt="닫기" /></a>
                                </div>
                            </div>
                        </div>
                        <span class="line">|</span>
                    </li>
                </c:if>
                <li><strong>수입구분</strong> : ${p.impYn eq 'Y'?'수입':'라이센스'} <span class="line">|</span></li>
                <li><strong>디스크 수</strong> : ${p.cdCount} DISC <span class="line">|</span></li>
                <c:if test="${cateList[1].cateId eq '000308' && not empty p.rcrdYear}">
                    <li><strong>녹음연도</strong> : ${p.rcrdYear} DISC <span class="line">|</span></li>
                </c:if>
                <c:if test="${!fn:startsWith(p.ctgrId, '000400')}">
                    <li>
                        <strong>지역코드</strong>
                        <div class="tooltip_wrap">
                            <a href="#tooltip4" class="tooltip">?</a>
                            <div id="tooltip4" class="layer_pop_wrap">
                                <div class="layer_pop_container" style="width:260px;height:255px;">
                                    <h1>지역 코드 안내</h1>
                                    <div class="layer_pop_cont">
                                        <ul class="list_type02">
                                            <li><strong>0</strong> 지역에 상관없이 재생가능</li>
                                            <li><strong>1</strong> 미국을 포함한 북미 지역</li>
                                            <li><strong>2</strong> 일본 및 유럽</li>
                                            <li><strong>3</strong> 우리 나라를 포함한 동남아 지역</li>
                                            <li><strong>4</strong> 오스트레일리아, 뉴질랜드, 남아메리카</li>
                                            <li><strong>5</strong> 러시아, 아프리카</li>
                                            <li><strong>6</strong> 중국</li>
                                            <li><strong>7</strong> 국가간을 여행하는 비행기나 선박 내</li>
                                        </ul>
                                    </div>
                                    <a href="#none" class="cls_btn" title="레이어팝업 닫기"><img src="${imageServer}/images/renewal/common/btn_cls.gif" alt="닫기" /></a>
                                </div>
                            </div>
                        </div>
                        <span class="line">|</span>
                    </li>
                </c:if>
                <li>
                    <strong>제조국</strong> : 
                    <c:choose>
                        <c:when test="${empty p.productionNation or p.productionNation eq '999'}">상품내 표기</c:when>
                        <c:when test="${p.productionNation eq '001'}">한국</c:when>
                        <c:when test="${p.productionNation eq '002'}">미국</c:when>
                        <c:when test="${p.productionNation eq '003'}">영국</c:when>
                        <c:when test="${p.productionNation eq '004'}">일본</c:when>
                        <c:when test="${p.productionNation eq '005'}">EU</c:when>
                        <c:when test="${p.productionNation eq '006'}">아시아</c:when>
                        <c:otherwise>상품내 표기</c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </div>
        <c:forEach items="${bannerList}" var="l" varStatus="st">
            <p class="t_center mgt20"><ui:banner bnrLinkUrl="${l.bnrLnkUrl}" bannerImageUrl="${l.bnrImgUrl}" bnrTgtGbn="L" bnrSeq="${l.bnrSeq}" newWdwYn="${l.bnrNewWinYn}"/></p>
        </c:forEach>
        <div class="album_info mgb55">
            <h3>${p.sellPrdtGbn eq 'R'?'음반':'상품'}정보</h3>
            <c:if test="${not empty p.moviePath}"><p>${p.moviePath}</p></c:if>
            <c:if test="${not empty p.subDescription }">
                <p><ui:br>${p.subDescription}</ui:br></p>
            </c:if>
            <p><ui:br>${p.description}</ui:br></p>
        </div>

    </div>
    <!-- //음반정보 -->

    <!-- 상품후기 -->
    <div style="padding-top:140px;" id="detail_cont02">
        <ul class="detail_tab">
            <li><a href="#detail_cont01">${p.sellPrdtGbn eq 'R'?'음반':'상품'}정보</a></li>
            <li class="active"><a href="#detail_cont02">상품후기<span class="product-estimation c_salmon mgl10">(0)</span><span class="hidden_obj">- 현재진행단계</span></a></li>
            <li><a href="#detail_cont03">상품Q&amp;A<span class="product-qna c_salmon mgl10">(0)</span></a></li>
            <li><a href="#detail_cont04">배송/교환/반품</a></li>
        </ul>
        
        <h2 class="hidden_obj">상품후기</h2>
        <div class="tbl_top mgt0">
            <p class="txt_l">CD, DVD 관련 상품은 상품평을 작성하셔도 포인트 적립대상에서 제외입니다.</p>
            <div class="f_right">
                <a href="#n" id="aWriteCommentBtn" class="btn_type02_v1">상품평쓰기</a>
            </div>
        </div>
        <div id="divSubCommentList"></div>
    </div>
    <!-- //상품후기 -->

    <!-- 상품Q&amp;A -->
    <div style="padding-top:140px;" id="detail_cont03">
        <ul class="detail_tab">
            <li><a href="#detail_cont01">${p.sellPrdtGbn eq 'R'?'음반':'상품'}정보</a></li>
            <li><a href="#detail_cont02">상품후기<span class="product-estimation c_salmon mgl10">(0)</span></a></li>
            <li class="active"><a href="#detail_cont03">상품Q&amp;A<span class="product-qna c_salmon mgl10">(0)</span><span class="hidden_obj">- 현재진행단계</span></a></li>
            <li><a href="#detail_cont04">배송/교환/반품</a></li>
        </ul>
        
        <h2 class="hidden_obj">상품Q&amp;A</h2>
        <div class="tbl_top mgt0">
            <p class="txt_l">상품 Q&A는 상품문의하기를, 주문/배송/교환/반품 문의는 고객센터 문의하기를 이용해 주시기 바랍니다.</p>
            <div class="f_right">
                <a href="javascript://" onclick="qnaWriteOpen()" class="btn_type02_v1">상품문의하기</a>
                <a href="/ht/help/createCounselForm" class="btn_type02_v1 mgl7">고객센터 문의하기</a>
            </div>
        </div>
        <div id="divSubQuestionList"></div>
    </div>
    <!-- //상품Q&amp;A -->

    <!-- 배송/교환/반품 -->
    <div style="padding-top:140px;" id="detail_cont04">
        <ul class="detail_tab">
            <li><a href="#detail_cont01">${p.sellPrdtGbn eq 'R'?'음반':'상품'}정보</a></li>
            <li><a href="#detail_cont02">상품후기<span class="product-estimation c_salmon mgl10">(0)</span></a></li>
            <li><a href="#detail_cont03">상품Q&amp;A<span class="product-qna c_salmon mgl10">(0)</span></a></li>
            <li class="active"><a href="#detail_cont04">배송/교환/반품<span class="hidden_obj">- 현재진행단계</span></a></li>
        </ul>

        <h2 class="hidden_obj">배송/교환/반품</h2>
        <div class="detail_info_box">
            <div class="inner mgt0">
                <h3>배송안내</h3>
                <div class="txt_wrap">
                    <ul>
                        <li><span class="bu">-</span>핫트랙스 배송 : 2만원 이상 구매 시 무료배송/ 2만원 미만 구매 시 배송비 2,000원</li>
                        <li><span class="bu">-</span>브랜드별 배송 : 브랜드 정책에 따라 무료배송 혹은 배송비 부과 (상품상세정보에서 배송비 기준 확인가능)</li>
                    </ul>
                    <h4>* 배송비</h4>
                    <ul>
                        <li><span class="bu">-</span>도서, 산간, 오지, 일부지역, 설치배송 상품 등은 배송비가 추가될 수 있습니다.</li>
                        <li><span class="bu">-</span>무료배송 상품과 함께 구입 시, 기준금액 미만으로 구입하시더라도 해당 브랜드 상품은 무료배송 됩니다.</li>
                        <li><span class="bu">-</span>핫트랙스 배송과 브랜드 개별 배송비는 별도로 부과 됩니다.</li>
                    </ul>
                    <h4>* 배송기간 및 방법</h4>
                    <ul>
                        <li><span class="bu">-</span>결제 완료 후, 1~5일 이내에 배송 됩니다. (단, 상품의 재고 상황이나 배송 상황, 지역특성에 따라 배송이 지연될 수 있습니다.)</li>
                        <li><span class="bu">-</span>주문제작 상품 및 가구와 같은 업체 직배송 상품은 제작기간과 배송시기를 별도 확인하시기 바랍니다.</li>
                    </ul>
                </div>
            </div>
            <div class="inner">
                <h3>반품/교환 안내</h3>
                <div class="txt_wrap">
                    <ul>
                        <li><span class="bu">-</span>상품 설명에 반품/교환 관련 안내가 있는 경우 그 내용을 우선으로 합니다. (업체 사정에 따라 변경 될 수 있습니다.)</li>
                        <li><span class="bu">-</span>브랜드별 배송 : 브랜드 정책에 따라 무료배송 혹은 배송비 부과 (상품상세정보에서 배송비 기준 확인가능)</li>
                    </ul>
                    <h4>* 반품/교환 방법</h4>
                    <ul>
                        <li><span class="bu">-</span>MY HOTTRACKS &gt; 주문정보 &gt; 반품/교환신청</li>
                        <li><span class="bu">-</span>고객센터 &gt; SOS상담</li>
                        <li><span class="bu">-</span>고객센터 (1661-1112)</li>
                    </ul>
                    <h4>* 반품/교환가능 기간</h4>
                    <ul>
                        <li><span class="bu">-</span>변심반품의 경우 수령 후 7일 이내, 상품의 결함 및 계약내용과 다를 경우 문제점 발견 후 30일 이내</li>
                        <li><span class="bu">-</span>상품불량 및 오배송 등의 이유로 반품/교환을 하실 경우 반품/교환비는 무료 입니다.<br />(단, 판매자가 반품된 상품 확인 후 상품불량이 아닌 것으로 확인 될 시 반송비를 고객님께 부과할 수 있습니다.)</li>
                        <li><span class="bu">-</span>고객변심으로 인한 교환/반품의 배송비는 고객님 부담 입니다.</li>
                        <li><span class="bu">-</span>고객변심으로 인한 교환/반품 시 주문에 사용된 할인쿠폰은 반환되지 않습니다.</li>
                    </ul>
                    <h4>* 반품/교환 불가사유</h4>
                    <ul>
                        <li><span class="bu">-</span>반품/교환 가능 기간을 초과한 경우</li>
                        <li><span class="bu">-</span>소비자의 책임 있는 사유로 상품 등이 손실 또는 훼손된 경우 (단지 확인을 위한 포장 훼손은 제외)</li>
                        <li><span class="bu">-</span>소비자의 사용, 포장 개봉에 의해 상품 등의 가치가 현저히 감소한 경우 (예: 밀봉상품, 제품 수선, 세탁, 기타 사용/분리/훼손)</li>
                        <li><span class="bu">-</span>설치상품의 경우 설치가 완료되어 상품의 가치가 훼손된 경우 (예: 설치가전, 가구, 식품 등)</li>
                        <li><span class="bu">-</span>소비자의 요청에 따라 개별적으로 주문 제작되는 상품의 경우</li>
                        <li><span class="bu">-</span>시간의 경과에 의해 재판매가 곤란한 정도로 가치가 현저히 감소한 경우</li>
                        <li><span class="bu">-</span>전자상거래 등에서의 소비자보호에 관한 법률이 정하는 소비자 청약철회 제한 내용에 해당되는 경우</li>
                        <li><span class="bu">-</span>복제가 가능한 상품 등의 포장을 훼손한 경우 (예: 음반/DVD/비디오, 소프트웨어, 영상화보집)</li>
                    </ul>
                </div>
            </div>
            <div class="inner">
                <h3>기타 사항</h3>
                <div class="txt_wrap">
                    <ul>
                        <li><span class="bu">-</span>상품의 불량에 의한 교환, A/S, 환불, 품질보증 및 피해보상 등에 관한 사항은 소비자분쟁해결 기준 (공정거래위원회 고시)에 준하여 처리됨</li>
                        <li><span class="bu">-</span>대금 환불 및 환불지연에 따른 배상금 지급 조건, 절차 등은 전자상거래 등에서의 소비자 보호에 관한 법률에 따라 처리함</li>
                        <!-- <li><span class="bu">-</span>구매자가 미성년자인 경우에는 상품 구입 시 법정대리인이 동의 하지 아니하면 미성년자 본인 또는 법정대리인이 구매취소 할 수 있습니다.</li> -->
                    </ul>
                </div>
            </div>
        </div>

    </div>
    <!-- //배송/교환/반품 -->
</div>
<!-- //상품정보 -->
</body>
</html>