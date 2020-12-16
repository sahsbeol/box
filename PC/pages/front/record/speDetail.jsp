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
<style type="text/css">

span.c_red{
    color:#ff0000;
    font-weight: bold;
}

</style>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
// 전역변수 처리
var sellPrdtBcode = "${p.sellPrdtBcode}";
var rcrdCd = "${p.rcrdCd}";
var isLogin = ${isLogin};
var hasOption = ${hasOption};
var isSpec = ("${specProducts != null && fn:length(specProducts) > 0?'Y':'N'}" == "Y");

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
    
    $("select.options").change(function(index){
        if($(this).find("option:selected").hasClass("disabled")){
            alert("해당 상품은 품절상품입니다.");
            $(this).val("");
            return;
        }
        
        var selectors = $("select.options");
        for(var i = 0; i<selectors.length;i++){
            if(selectors.eq(i).val() == "")
                return;
        }
        
        var specYn = false;
        var price = "${p.lastDcPrice}";
        var keyValue = '';
        var idName = '';
        var prdtCnt = $("input[name=prdtCount]").val();
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
        
        if($("#tr"+idName).length > 0){
            $("#tr"+$(this).find("option:selected").val()).find(".prdtCnt").select();
            return;
        }
        
        var strHtml = "";
        strHtml += "<tr id='tr"+idName+"'>";
        if(specYn){
            strHtml += "    <td class='t_left'>"+$(this).find("option:selected").text()+"</td>";
        }else{
            strHtml += "    <td class='t_left'>"+valStr+"</td>";
        }
        strHtml += "    <td class='t_center'>";
        strHtml += "        <div class='count'>";
        if(specYn){
            strHtml += "            <input type='hidden' name='specPrdtBcodes' value='"+$(this).find("option:selected").val()+"'/>";
            strHtml += "            <input type='hidden' name='specNames' value='"+$(this).find("option:selected").text()+"'/>";
        }else{
            strHtml += "            <input type='hidden' name='specPrdtBcodes' value='${ext.sellPrdtBcode}'/>";
            strHtml += "            <input type='hidden' name='optnNames' value='"+nameValue+"'/>";
            strHtml += "            <input type='hidden' name='optnValues' value='"+keyValue+"'/>";
        }
        strHtml += "            <input type='hidden' class='snglPrdtPrce' value='"+price+"'/>";
        strHtml += "            <input type='text' name='optnCnts' class='prdtCnt inputNumberText' value='"+prdtCnt+"' title='수량입력' onchange='checkOption()'/>";
        strHtml += "            <span class='button_wrap'>";
        strHtml += "                <button class='up' onclick='incPrdtCnt(\""+idName+"\")' type='button'>증가</button>";
        strHtml += "                <button class='down' onclick='decPrdtCnt(\""+idName+"\")' type='button'>감소</button>";
        strHtml += "            </span>";
        strHtml += "        </div>";
        strHtml += "    </td>";
        strHtml += "    <td class='t_right'>";
        strHtml += "        <span class='bold prdtPrce'>"+price_format(price)+"</span>";
        strHtml += "        <a class='btn_del' href='javascript://' onclick='deleteOption(\""+idName+"\")'><img alt='삭제' src='${imageServer}/images/renewal/common/btn_delete.gif'></a>";
        strHtml += "    </td>";
        strHtml += "</tr>";
        $("#cartList").append(strHtml);
        checkOption();
    });

    $(document).ready(function(){
        loadQuestionSubList();
    });
    
});

// 바로구매 처리
function detailBuy(){
    var prdtCount = $("input[name=prdtCount]").val();
/*    
    if(!hasOption){
        addSpeRecordBuy(sellPrdtBcode, prdtCount);
    }else{
        alert("상품선택이 잘못되었습니다. 바로구매 진행할수 없습니다.");
    }
*/    
    if (!isSpec) {
    	addSpeRecordBuy(sellPrdtBcode, prdtCount);
    } else {
    	if ($("#cartList tr").length < 1) {
            alert('옵션을 선택하세요.');
            $('select.options:first').focus();
        } else {
        	$('form[name="sForm"]').attr("action", "/ht/order/quickOrderForOption");
            $('form[name="sForm"]').html(makeOptnData());
            sendOrder();
        }
    }
}

function sendOrder() {
    var productCount = $('form[name="productForm"] input[name="productCount"]').val();
    $('form[name="sForm"] input[name="prdtCount"]').attr('value', productCount);
    
    var tmpHtml = '<input type="hidden" name="groupSellYn" value="Y"/>';
        
    $('form[name="sForm"]').append(tmpHtml);
    
    $('form[name="sForm"]').ajaxSubmit({
        type: "POST"
        ,url: $('form[name="sForm"]').attr("action")
        ,dataType: "json"
        ,success : function(data){
            if (data) {
                if(data.save) {
                    // 바로구매
                    if(data.cartType == "quickOrder")    window.location.href = sslHost + "/ht/order/orderGiftChoose";
                	//if(data.cartType == "quickOrder")    window.location.href = "/ht/order/orderGiftChoose";
                } else {
                    var errorMessages = data.result;
                    alert(errorMessages);
                }
            }
        }
        ,error: function(data) {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}

function makeOptnData(){
    var data = '';
    var trs = $("#cartArea").find("tr");
    for(var i = 0; i<trs.length; i++){
        var inputs = trs.eq(i).find("input");
        for(var j = 0; j<inputs.length; j++){
            var input = inputs.eq(j);
            data += "<input name='"+input.attr("name")+"' value='"+input.val()+"'/>";
            //alert(data);
        }
    }
    return data;
}

function incPrdtCnt(sellPrdtBcode){
    var tr = $("#tr"+sellPrdtBcode);
    var stat = $("#stat"+sellPrdtBcode).val();
    var productCount = tr.find(".prdtCnt");
    var productPrice = tr.find(".snglPrdtPrce");
    if(stat != "Y" && parseInt(productCount.val()) >= parseInt(stat)){
        alert("본 상품의 현재 주문 가능한 수량은  "+stat+"개 입니다.");
        productCount.val(stat);
    }else{
        productCount.val(parseInt(productCount.val()) + 1);
        checkOption();
    }
}

function decPrdtCnt(sellPrdtBcode){
    var tr = $("#tr"+sellPrdtBcode);
    var productCount = tr.find(".prdtCnt");
    var productPrice = tr.find(".snglPrdtPrce");
    if(parseInt(productCount.val()) > 1){
        productCount.val(parseInt(productCount.val()) - 1);
        checkOption();
    }else{
        alert("최소 1개 이상 구매 가능합니다.");
    }
}

function deleteOption(sellPrdtBcode){
    var tr = $("#tr"+sellPrdtBcode);
    tr.remove();
    checkOption();
}

function checkOption(){
    if($("#cartList").find("tr").length < 1){
        $("#cartArea").hide();
    }else if($("select[name=SpecGroup]").val() != undefined){
        $("#cartList").find("tr").each(function(){
            var tr = $(this);
            var specBarcode = tr.find("input[name=specPrdtBcodes]");
            var cnt = parseInt(tr.find(".prdtCnt").val());
            $.ajax({
                type: 'GET'
                ,url: '/ht/product/get'
                ,data: 'barcode=' + specBarcode.val()
                ,dataType: 'json'
                ,success: function(data) {
                    if (cnt > data.product.laveCount) {
                        cntStr = "1";
                        tr.find(".prdtCnt").val(cntStr);
                    }
                    calculateOption();
                }
                ,error: function(xhr, status, error) {
                    $(this).attr('value', '1');
                }
            });
        });
    }else{
        calculateOption();
    }
}

function calculateOption(){
    var cartSum = 0;
    var trs = $("#cartList").find("tr");
    for(var i = 0; i< trs.length; i++){
        var tr = trs.eq(i);
        var cntStr = tr.find(".prdtCnt").val();
        var prdtBcode = tr.find("input[name=specPrdtBcodes]").val();
        if(prdtBcode != null && prdtBcode != ""){
            stat = $("#stat"+prdtBcode).val();
        }
        if(stat != "Y" && parseInt(cntStr) >= parseInt(stat)){
            alert("본 상품의 현재 주문 가능한 수량은  "+stat+"개 입니다.");
            tr.find(".prdtCnt").val(stat);
            cntStr = stat;
        }
        
        if(isEmpty(cntStr) || parseInt(cntStr) < 1){
            cntStr = "1";
            tr.find(".prdtCnt").val(cntStr);
        }
        
        var cnt = parseInt(cntStr);
        
        var prce = parseInt(tr.find(".snglPrdtPrce").val());
        tr.find(".prdtPrce").html(price_format(cnt*prce));
        cartSum += (cnt*prce);
    }
    $("#cartSum").html(price_format(cartSum));
    $("#cartArea").show();
}

//Q&A 입력 창 활성화
function qnaWriteOpen(){
    var loginYN = "${isLogin}";
    if (loginYN == "true"){
        window.open("/ht/product/questionPopup4write?barcode=${p.sellPrdtBcode}", "", "width=500, height=700, scrollbars=no");
        return false;
    } else {
        needLogin();
    }
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

//QNA 목록 생성후 콜백 함수
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


//Q&A 삭제요청
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

//Q&A 상세보기
function qnaView(seq){
    $(".qa_list_body_" + seq).toggle();
}

//Q&A 수정 창 활성화
function qnaUpdateOpen(seq){
    var loginYN = "${isLogin}";
    if (loginYN == "true"){
        window.open("/ht/product/questionPopup4Modify?seq=" + seq, "", "width=500, height=600, scrollbars=no");
    } else {
        needLogin();
    }
}

</script>
</head>
<body>
<!-- detail_top -->
<div class="detail_top">
    <div class="inner">
        <!-- Location -->
        <div class="page_location">
            <div class="loc">
                <a href="/" class="home">Home</a>
                <c:if test="${fn:startsWith(p.ctgrId, '0003')}"><a href="/ht/biz/record/recordCategoryMain?ctgrId=0003">CD</a></c:if>
                <c:if test="${fn:startsWith(p.ctgrId, '0004')}"><a href="/ht/biz/record/dvdCategoryMain?ctgrId=000401">DVD</a></c:if>
                <c:forEach varStatus="st" begin="6" end="${fn:length(p.ctgrId)}" step="2">
                    <c:if test="${st.last}"><em><ui:category id="${p.ctgrId}" full="false"/></em></c:if>
                    <c:if test="${!st.last}"><a href="/ht/record/category/${fn:substring(p.ctgrId, 0, st.index)}"><ui:category id="${fn:substring(p.ctgrId, 0, st.index)}" full="false"/></a></c:if>
                </c:forEach>
            </div>
        </div>
        <!-- //Location -->
        
        <div class="detail_cont">
            <c:if test="${p.hasPosterCase && groupSellInfo.offYn ne 'Y'}">
                <p class="icon_p" style="position:absolute;left:0;top:53px;"><img src="${imageServer}/images/music/icon_poster.png" class="iepngfix" alt="포스터 증정" /></p>
            </c:if>
            <c:if test="${p.hasPosterCase && groupSellInfo.offYn eq 'Y'}">
                <p class="icon_p" style="position:absolute;left:0;top:53px;"><img src="${imageServer}/images/music/icon_poster_off.png" class="iepngfix" alt="포스터 증정" /></p>
            </c:if>
            <div class="cover">
                <c:if test="${p.sellPrdtGbn eq 'R'}">
                    <span class="img t_center"><ui:image rcrdCd="${p.rcrdCd}" prdtGbn="${p.sellPrdtGbn}" width="400" alt="${p.rcrdName}" rcrdImgType="large" ratingCode="${p.rtngCode}" clazz="sns_img"/></span>
                </c:if>
                <c:if test="${p.sellPrdtGbn eq 'D'}">
                    <span class="img t_center"><ui:image rcrdCd="${p.rcrdCd}" prdtGbn="${p.sellPrdtGbn}" width="224" height="340" style="padding:30px;" alt="${p.rcrdName}" rcrdImgType="large" clazz="sns_img" ratingCode="${p.rtngCode}" /></span>
                </c:if>
                <ul>
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
            <span class="ico_label">
                <c:if test="${p.mediaName ne 'VCD' && fn:startsWith(p.ctgrId, '000400')}"><img src="${imageServer}/images/renewal/common/txt_detail_label04.png" alt="BD"/></c:if>
                <c:if test="${p.mediaName ne 'VCD' && fn:startsWith(p.ctgrId, '000401')}"><img src="${imageServer}/images/renewal/common/txt_detail_label05.png" alt="DVD"/></c:if>
                <c:if test="${p.impYn eq 'Y'}"><img src="${imageServer}/images/renewal/common/txt_detail_label01.png" alt="수입상품" /></c:if>
                <c:if test="${p.rcrdStat eq '9'}"><img src="${imageServer}/images/renewal/common/txt_detail_label02.png" alt="예약상품" /></c:if>
                <c:if test="${p.haveFreeGiftHaveYn eq 'Y'}"><img src="${imageServer}/images/renewal/common/txt_detail_gift.png" alt="사은품"/></c:if>
                <c:if test="${not empty p.couponList}"><img src="${imageServer}/images/renewal/common/txt_detail_coupon.png" alt="쿠폰"/></c:if>
                <c:if test="${p.saleYn ne 'Y'}">
                    <c:choose>
                        <c:when test="${p.rcrdStat eq '0' || p.rcrdStat eq '1' || p.rcrdStat eq '6'}">
                            <img src="${imageServer}/images/renewal/common/txt_detail_none_stock.png" alt="일시품절"/>
                        </c:when>
                        <c:when test="${p.rcrdStat eq '3'}">
                            <img src="${imageServer}/images/renewal/common/txt_detail_sold_out.png" alt="절판"/>
                        </c:when>
                        <c:otherwise>
                            <img src="${imageServer}/images/renewal/common/txt_detail_sold_out.png" alt="품절"/>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </span>
            <div class="detail_info">
                <h2 class="tit mgt30">
                    <c:if test="${!fn:contains('DVD,BLU-RAY DISC', p.artiName)}">${p.artiName} - </c:if>
                    ${p.commTitle}
                    <c:if test="${not empty groupSellInfo.optionName}"> - ${groupSellInfo.optionName}</c:if>
                </h2>
                <ul>
                    <c:if test="${p.rtngCode eq 'C0845'}">
                        <li style="margin-left:7px;font-weight:bold;color:#FF0000;">19세 이상 상품입니다.</li>
                    </c:if>
                    <c:if test="${not empty p.rcrdSubComments}">
                        <li style="color:#FF6600;margin-top:-10px;line-height:15px;">${p.rcrdSubComments}</li>
                    </c:if>
                    <li>
                        <span class="tit"><c:if test="${groupSellInfo.offYn eq 'Y'}">판매가</c:if><c:if test="${groupSellInfo.offYn ne 'Y'}">공구가</c:if></span>
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
                    <c:if test="${groupSellInfo.offYn ne 'Y' && p.sellPrdtBcode ne '2300185880878' && p.sellPrdtBcode ne '2300185881011' && p.sellPrdtBcode ne '2300185881028'}">
                    <!-- 결제 혜택 -->
                    <!-- <li>
                    	<span class="tit">결제 혜택</span>
		            	<div><span class="w200">
		                <img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/common/images/order/txt_smile.png"/><strong> Smile Pay 결제 시 2천원 적립</strong></span></div>
		                <div class="mgt10"><span class="w200">- 이벤트 기간 : 5/1 ~ 7/31</span></div>
		                <div class="mgt10"><span class="w200">- 스마일페이로 3만원 이상 결제 시 2천원 스마일캐시 적립</span></div>
		                <div class="mgt10"><span class="w200">- 첫 결제 고객님도! 이미 사용해 본 고객님도!</span></div>
		            </li> -->
		            <!-- / 결제 혜택 -->
                    <li>
                        <span class="tit">배송비</span>
                        <div><span class="w200">2,000원 (해외배송불가)</span></div>
                        <div class="mgt10"><span class="w200">2만원 이상 구매시 무료배송</span></div>
                    </li>
                    </c:if>
                    <c:if test="${p.sellPrdtBcode eq '2300185880878'}">
                    <li>
                        <span class="tit">배송비</span>
                        <div><span class="w200">동마갤공지확인/배송비별도</span></div>
                    </li>
                    </c:if>
                </ul>
                <ul>
<!-- 
                    <c:if test="${groupSellInfo.offYn ne 'Y'}">
	                    <c:if test="${p.rcrdStat eq '9' or p.sellPrdtGbn eq 'R'}">
	                        <c:if test="${p.rcrdStat eq '9'}">
	                            <c:choose>
	                                <c:when test="${not empty p.okdate && fn:length(p.okdate) == 8 && p.okdate ne '00000000'}">
	                                    <li>
	                                        <span class="tit">출고 예정일</span>
	                                        <div><ui:mask pattern="####.##.##">${p.okdate}</ui:mask> 발매 예정입니다.</div>
	                                    </li>
	                                </c:when>
	                                <c:when test="${not empty p.rlseDt && fn:length(p.rlseDt) == 8}">
	                                    <li>
	                                        <span class="tit">출고 예정일</span>
	                                        <div><ui:mask pattern="####.##.##">${p.rlseDt}</ui:mask> 발매 예정입니다.</div>
	                                    </li>
	                                </c:when>
	                                <c:otherwise><li><span class="tit">예약판매 입니다.</span></li></c:otherwise>
	                            </c:choose>
	                        </c:if>
	                    </c:if>
	                    <c:if test="${not empty dlvyInfo}">
	                        <li>
	                            <span class="tit">배송안내</span>
	                            <div>
		                            <c:choose>
		                                <c:when test="${not empty p.okdate  && fn:length(p.okdate) == 8 && p.okdate ne '00000000'}">
		                                    <b>출고 예정일 : <ui:mask pattern="####.##.##">${p.okdate}</ui:mask>발매 예정</b>입니다.
		                                </c:when>
		                                <c:when test="${not empty p.rlseDt && fn:length(p.rlseDt) == 8}">
		                                    <b>출고 예정일 : <ui:mask pattern="####.##.##">${p.rlseDt}</ui:mask>발매 예정</b>입니다.
		                                </c:when>
		                                <c:otherwise><b>예약판매</b> 입니다.</c:otherwise>
		                            </c:choose>
	                            </div>
	                        </li>
	                    </c:if>
                    </c:if>
 -->
                    <c:if test="${not empty specProducts}">
                        <li>
                            <span class="tit"><c:if test="${groupSellInfo.offYn eq 'Y'}">수령매장</c:if><c:if test="${groupSellInfo.offYn ne 'Y'}">옵션</c:if></span>
                            <div>
                                <c:forEach items="${specProducts}" var="l" varStatus="st">
                                    <input type="hidden" id="stat${l.sellPrdtBcode}" value="${l.saleStat}"/>
                                </c:forEach>
                                <select class="select options" name="specGroup">
                                    <option value="">옵션을 선택하세요.</option>
                                    <c:forEach items="${specProducts}" var="l" varStatus="st">
                                        <option value="${l.sellPrdtBcode}" prce="${l.lastCpnPrice}"<c:if test="${l.prdtStatCode ne 'C0312'}"> class="disabled" style="color:#bfbfbf;"</c:if>>
                                            ${l.specName}<c:if test="${l.prdtStatCode ne 'C0312'}"> (<ui:code codeId="${l.prdtStatCode}"/>)</c:if>
                                            <c:if test="${l.laveCount < 1}">, 예약마감</c:if>
                                            <!-- 
                                            <c:if test="${l.limitCount < 99999}">, 한정:<fmt:formatNumber type="number">${l.laveCount}</fmt:formatNumber>개</c:if>
                                             -->
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </li>
                    </c:if>
                    
                    <li>
                        <span class="tit">수량</span>
                        <div class="count">
                            <form name="productForm">
                                <input type="text" value="1" name="prdtCount" maxlength="4" class="inputNumberText" style='ime-mode:disabled' title="수량입력"/> 개
                                <span class="button_wrap">
                                    <button type="button" class="up">증가</button>
                                    <button type="button" class="down">감소</button>
                                </span>
                            </form> 
                        </div>
                    </li>
                </ul>
                <div id="cartArea" style="display:none;">
                    <table class="detail_tbl">
                        <colgroup>
                            <col style="width:*">
                            <col style="width:70px">
                            <col style="width:150px">
                        </colgroup>
                        <tfoot>
                            <tr>
                                <th colspan="2">상품 금액 합계</th>
                                <td id="cartSum">0</td>
                            </tr>
                        </tfoot>
                        <tbody id="cartList"></tbody>
                    </table>
                </div>
                <div class="sns">
                    <c:if test="${p.sellPrdtGbn eq 'R'}">
                        <p>음반 판매자료는 한터차트와 가온차트 <span class="c_red">판매량 집계에 100%</span> 반영됩니다.</p>
                    </c:if>
                    <c:if test='${fn:startsWith(cateList[1].cateId,"000400") }'>
                        <p><font style="color: black; font-weight: bold;">BLU-RAY 전용 플레이어 상품이며</font>, DVD 플레이어에서는 재생이 되지 않습니다.</p>
                    </c:if>
                </div>
                <div class="sns">
                    <p><ui:br>${groupSellInfo.optionKey}</ui:br></p>
                </div>
                <div class="btn_wrap mgt35">
                    <c:choose>
                        <c:when test="${p.wishUserPrdtCnt eq '0'}"><c:set var="linkCls" value="pump"/></c:when>
                        <c:otherwise><c:set var="linkCls" value="active"/></c:otherwise>
                    </c:choose>
                    <c:if test="${p.saleYn eq 'Y'}">
                        <a href="javascript://" onclick="detailBuy()" class="btn_type03 bg_orange">예약구매</a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
 
<c:if test="${p.sellPrdtBcode eq '2300185880762'}">
<div>
	<a href="http://www.hottracks.co.kr/ht/biz/eventDetail?eventId=51291" target="_wanna">
	    <img onerror="this.src='http://image.kyobobook.co.kr/images/no_image.gif';" alt="" src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/1984/1534386842187_51291_bnr.jpg"/>
	</a>
</div>
</c:if>
<!-- 상품정보 -->
<div class="detail_p_info mgt65">
    <!-- 음반정보 -->
    <div class="" id="detail_cont01">
        <ul class="detail_tab">
            <li class="active"><a href="#detail_cont01">${p.sellPrdtGbn eq 'R'?'음반':'상품'}정보<span class="hidden_obj">- 현재진행단계</span></a></li>
            <li><a href="#detail_cont03">상품Q&amp;A <span class="product-qna">(0)</span></a></li>
        </ul>
        <div class="album_info mgb55">
            <p><ui:br>${groupSellInfo.optionDescription}</ui:br></p>
        </div>
    </div>
    <!-- //음반정보 -->
    <!-- 상품Q&amp;A -->
    <div style="padding-top:140px;" id="detail_cont03">
        <ul class="detail_tab">
            <li><a href="#detail_cont01">${p.sellPrdtGbn eq 'R'?'음반':'상품'}정보</a></li>
            <li class="active"><a href="#detail_cont03">상품Q&amp;A <span class="product-qna">(0)</span><span class="hidden_obj">- 현재진행단계</span></a></li>
        </ul>
        
        <h2 class="hidden_obj">상품Q&amp;A</h2>
        <div class="tbl_top mgt0">
            <p class="txt_l">상품 Q&A는 상품문의하기를, 주문/배송/교환/반품 문의는 고객센터 문의하기를 이용해 주시기 바랍니다.</p>
            <div class="btn_r">
                <a href="javascript://" onclick="qnaWriteOpen()" class="btn_type09 btn bg_orange">상품문의하기</a>
            </div>
        </div>
        <div id="divSubQuestionList"></div>
    </div>
    <!-- //상품Q&amp;A -->

    <c:if test="${p.sellPrdtBcode ne '2300185880878'}">
    <!-- 배송/교환/반품 -->
    <div style="padding-top:140px;" id="detail_cont04">
        <ul class="detail_tab">
            <li class="active"><a href="#detail_cont04">배송/교환/반품<span class="hidden_obj">- 현재진행단계</span></a></li>
        </ul>

        <h2 class="hidden_obj">배송/교환/반품</h2>
        <c:if test="${groupSellInfo.offYn ne 'Y'}">
        <div class="detail_info_box">
            <div class="inner mgt0">
                <h3>배송안내</h3>
                <div class="txt_wrap">
                    <ul>
                        <li><span class="bu">-</span>2만원 이상 구매 시 무료배송/ 2만원 미만 구매 시 배송비 2,000원 (도서, 산간지역 추가비용 없음)</li>
                        <li><span class="bu">-</span>출시일부터 발송 예정이나 주문량이 많은 경우, 상품의 재고 상황이나 배송상황, 지역특성에 따라 배송이 지연될 수 있습니다.</li>
                    </ul>
                </div>
            </div>
            <div class="inner">
                <h3>반품/교환 안내</h3>
                <div class="txt_wrap">
                    <ul>
                        <li><span class="bu">-</span>반품 및 환불은 불가하며, 불량이나 구성품 누락을 대비해 박스 개봉부터 동영상 촬영을 요청드립니다.</li>
                        <li><span class="bu">-</span>동영상이 없는 경우 교환이 제한될 수 있습니다.</li>
                    </ul>
                </div>
            </div>
            <div class="inner">
                <h3>기타 사항</h3>
                <div class="txt_wrap">
                    <ul>
                        <li><span class="bu">-</span>통합포인트는 적립되지 않습니다.</li>
                        <li><span class="bu">-</span>앨범 구매시 쿠폰은 사용하실수 없습니다.</li>
                        <c:if test="${p.sellPrdtBcode ne '2300185899610'}">
                        <li><span class="bu">-</span>선착순 포스터의 경우 지관통은 주문건당 1개만 증정이 됩니다.</li>
                        </c:if>
                        <li><span class="bu">-</span>공동구매 주문건은 SOS 상담접수 (1:1문의) 시 별도의 답변이나 처리 진행이 되지않습니다. 고객센터로 전화문의 부탁드립니다.</li>
                    </ul>
                </div>
            </div>
        </div>
        </c:if>
        <c:if test="${groupSellInfo.offYn eq 'Y'}">
        <div class="detail_info_box">
            <div class="inner mgt0">
                <h3>수령안내</h3>
                <div class="txt_wrap">
                    <ul>
                        <li><span class="bu">-</span>공식판매일부터 수령이 가능하며, 영업점 배송상황에 따라 영업점별 수령시간이 다를 수 있습니다.</li>
                        <li><span class="bu">-</span>수령가능 일시는 주문/배송조회에서 처리상태가 “상품준비＂상태로 변경된 후 SMS로 안내드립니다.</li>
                        <li><span class="bu">-</span>수령하기 위해서는 주문 시 발송된 문자 확인이 필요하오니 문자를 꼭 저장하여 오시기 바랍니다.</li>
                    </ul>
                </div>
            </div>
            <div class="inner">
                <h3>반품/교환 안내</h3>
                <div class="txt_wrap">
                    <ul>
                        <li><span class="bu">-</span>반품 및 교환은 수령한 영업점에서 가능합니다.</li>
                        <li><span class="bu">-</span>구성품 누락의 경우 유통사 정책에 따라 교환 또는 누락 구성품 추후 증정이 될 수 있습니다.</li>
                    </ul>
                </div>
            </div>
            <div class="inner">
                <h3>기타 사항</h3>
                <div class="txt_wrap">
                    <ul>
                        <li><span class="bu">-</span>매장수령 예약주문 상품 외 온라인몰의 다른 상품을 함께 구매하실 수 없습니다.</li>
                        <li><span class="bu">-</span>할인상품의 경우 통합포인트는 적립되지 않습니다.</li>
                        <li><span class="bu">-</span>음반예약수령은 지관통이 증정되지 않습니다.</li>
                        <li><span class="bu">-</span>음반예약수령 앨범 구매시 쿠폰은 사용하실 수 없습니다.</li>
                        <li><span class="bu">-</span>해당 주문건으로 사인회 참여를 하실 수 없습니다.</li>
                    </ul>
                </div>
            </div>
        </div>
        </c:if>
    </div>
    </c:if>
    <!-- //배송/교환/반품 -->
</div>
<!-- //상품정보 -->
<FORM name="sForm" id="sFormDiv" method="post"></FORM>
</body>
</html>