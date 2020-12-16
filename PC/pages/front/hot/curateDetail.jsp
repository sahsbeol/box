<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<!--  SNS 공유 내용 -->
<meta property="og:type" content="website"/>
<meta property="og:title" content="${detail.crtTitle}"/>
<meta property="og:url" content="${defaultHost}/ht/hot/curateDetail?crtSeq=${detail.crtSeq}"/>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/logo_over.gif"/>
<!--  SNS 공유 내용 -->
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
isEntryTerm = ${entryTermYn};

function preValidation() {
    if (!isLogin) {
        needLogin();
        return false;
    } else if (!isEntryTerm) {
        alert("해당기간이 아닙니다.");
        return false;
    }

    return true;
}

function likeCurate(crtSeq) {
    var cnt = parseInt($(".brand_sns .btn_wish").text().replace(","));
    if (preValidation()) {
        $.ajax({
            type: 'GET'
            ,url: '/ht/hot/curateLike?crtSeq='+crtSeq
            ,dataType: 'json'
            ,success: function(data) {
                if (data.save) {
                    alert('쪼아쪼아~♥');
                    $(".brand_sns .btn_wish").html(price_format(cnt+1));
                } else {
                    alert(data.errorMessages);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function loadCurateComments(crtSeq, page){
    $('#childComment'+crtSeq).load('/ht/hot/curateList/comments/'+crtSeq+'?page=' + page, function (){
        $("html,body").scrollTop($('#childComment'+crtSeq).offset().top-260);
    });
}

function loadChildComment4Page(page, param){
    params = param.split("&");
    var crtSeq = '';
    for(var i = 0; i<params.length; i++){
        if(params[i].indexOf("crtSeq=") == 0){
            crtSeq = params[i].replace("crtSeq=", "");
        }
    }
    loadCurateComments(crtSeq, page);
}

function saveCurateComment(crtSeq) {
    var cnt = parseInt($(".comment_inlist").find(".btn_cmnt").text().replace(","));
    if(isEmpty($('form[name=curateCommentFrm'+crtSeq+']').find("[name=cmnt]").val())){
        alert("코멘트 내용을 입력해주세요");
        $('form[name=curateCommentFrm'+crtSeq+']').find("[name=cmnt]").focus();
        return false;
    }
    if (preValidation()) {
        $('form[name=curateCommentFrm'+crtSeq+']').ajaxSubmit({
            url: '/ht/hot/curateList/comments/save'
            ,dataType: 'json'
            ,success: function(data) {
                alert('<fmt:message key="message.save.success"/>');
                $(".comment_inlist").find(".btn_cmnt").html(price_format(cnt+1));
                loadCurateComments(crtSeq, "1");
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
    return false;
}

function deleteCurateComment(crtCmntSeq, crtSeq) {
    var cnt = parseInt($(".comment_inlist").find(".btn_cmnt").text().replace(","));
    if (preValidation()) {
        if (confirm('삭제하시겠습니까?')) {
            $.ajax({
                type: 'GET'
                ,url: '/ht/hot/curateList/comments/delte'
                ,data: {crtCmntSeq:crtCmntSeq,crtSeq:crtSeq}
                ,dataType: 'json'
                ,success: function(data) {
                    alert('<fmt:message key="message.delete.success"/>');
                    $(".comment_inlist").find(".btn_cmnt").html(price_format(cnt-1));
                    loadCurateComments(crtSeq, "1");
                }
                ,error: function(data) {
                    alert('<fmt:message key="error.common.system"/>');
                }
            });
        }
    }
}
</script>
</head>
<body>
<div class="curate-detail">
<!-- brand_all_wrap -->
<div class="curator-area">
    <a href="/ht/biz/eventDetail?eventId=${detail.eventId}" class="btn_brand">+ 기획전 보러가기</a>
    <div class="curator-info">
        <strong class="curator-name"><ui:idAsterisk value="${detail.userId}"/></strong>
        <span class="curate-title">${detail.crtTitle}</span>
        <span class="curate-desc">${detail.crtDesc}</span>
    </div>
    <div class="brand_sns">
        <a href="javascript://" onclick="goTwitter('${detail.crtTitle}', '${defaultHost}/ht/hot/curateDetail?crtSeq=${detail.crtSeq}')"><img src="${imageServer}/images/renewal/common/ico_sns_twitter.png" alt="twitter"/></a>
        <a href="javascript://" onclick="goFaceBook('${detail.crtTitle}', '${defaultHost}/ht/hot/curateDetail?crtSeq=${detail.crtSeq}')"><img src="${imageServer}/images/renewal/common/ico_sns_facebook.png" alt="facebook"/></a>
        <a href="javascript://" onclick="goPinterest('${detail.crtTitle}', '${defaultHost}/ht/hot/curateDetail?crtSeq=${detail.crtSeq}')"><img src="${imageServer}/images/renewal/common/ico_sns_pinterest.png" alt="pinterest" style="width:28px;height:28px;" nopin="true"/></a>
        <a href="javascript://" onclick="likeCurate('${detail.crtSeq}')" class="btn_wish">좋아요<img class="wish_img" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/content/ico_like.png" /><fmt:formatNumber type="number">${detail.cntLike}</fmt:formatNumber></a>
    </div>
    <c:if test="${not empty eventList}">
        <div class="brand_event">
            <h4>Brand Event</h4>
            <c:forEach items="${eventList}" var="l" varStatus="st" end="0">
                <p><a href="/ht/biz/eventDetail?eventId=${l.eventId}">${l.eventTitle}</a></p>
            </c:forEach>
        </div>
    </c:if>
</div>
<!-- //brand_all_wrap -->
<!-- brand_pr_list -->
<div class="product-list" id="productList">
    <c:if test="${empty list }">
       <div class="t_center mgt25 mgb25"><img src="${imageServer}/images/common/no_result.gif" alt="상품이 존재하지 않습니다" /></div>
    </c:if>
    <div class="prod_list_normal">
        <c:forEach items="${list}" varStatus="s1" step="4">
            <ul>
                <c:forEach items="${list}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
                    <li>
                        <span class="img">
                            <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                                <a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'200':'132'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a>
                            </c:if>
                            <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}"><ui:image src="${l.prdtImgUrl}" src2="${l.prdtImgUrl2}" size="150" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a>
                            </c:if>
                            <div class="hide_util">
                                <a href="javascript://" onclick="productPreview('${l.sellPrdtBcode}')" class="zoom"><span>확대</span></a>
                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                            </div>
                        </span>
                        <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                            <span class="make">${l.brandName}</span>
                            <span class="name">${l.prdtName}</span>
                            <em class="price">
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
</div>
<!-- brand_pr_list -->
<div class="comment_inlist" id="childComment${detail.crtSeq}">
    <p class="txt_total">총 <span class="c_orange btn_cmnt"><fmt:formatNumber type="number">${detail.cntCmnt}</fmt:formatNumber></span>건의 COMMENT가 있습니다.</p>
    <c:import url="/ht/hot/curateList/comments/${detail.crtSeq}"/>
</div>
</div>
</body>
</html>