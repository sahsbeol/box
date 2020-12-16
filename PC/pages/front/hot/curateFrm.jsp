<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="none"/>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
var MAX_REG_PRODUCT_CNT = 40;
jQuery(function($){
    $(document).ready(function(){
        var maskHeight = $(document).height();  
        var maskWidth = $(document).width();
        
        var bnrTop = $(window).height()/2 - $(".curate-form").height()/2;
        var bnrLeft = $(window).width()/2 - $(".curate-form").width()/2;
        
        //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
        $('#mask').css({'width':maskWidth,'height':maskHeight});
        $('.curate-form').css({'left':bnrLeft,'top':bnrTop});

        //애니메이션 효과
        // $('#mask').fadeIn(500);
        $('#mask').fadeTo(10,0.6);
        
        $('.curate-form').show();
    });
});

function submitCurateFrm() {
    if(isEmpty($("[name=crtTitle]").val())) {
        alert("제목을 입력해주세요.");
        $("[name=crtTitle]").focus();
        return false;
    }
    
    if(isEmpty($("[name=crtDesc]").val())) {
        alert("추천이유를 입력해주세요.");
        $("[name=crtDesc]").focus();
        return false;
    }
    
    if(isEmpty($("[name=sellPrdtBcode]").val())) {
        alert("상품을 한 개 이상 등록해주세요.");
        return false;
    }
    
    $("form[name=curateFrm]").ajaxSubmit({
        url: "/ht/hot/curateSubmit"
        ,dataType: "json"
        ,success: function(data) {
            alert('정상적으로 등록되었습니다.');
            location.href="/ht/hot/curateDetail?crtSeq="+data.crtSeq;
        }
        ,error: function(data) {
            alert('등록중 오류가 발생하였습니다.');
        }
    });
}

function setProduct(product){
    var sellPrdtBcodes = $("input[name=sellPrdtBcode]").val();
    var errMsg = "";
    if(isEmpty($("input[name=sellPrdtBcode]").val()) || $("input[name=sellPrdtBcode]").val().indexOf(product.sellPrdtBcode) == -1){
        if(sellPrdtBcodes.split(",").length+1 > MAX_REG_PRODUCT_CNT){
            errMsg = "상품은 최대 "+MAX_REG_PRODUCT_CNT+"개까지 등록 가능합니다.";
        }else{
            var curateProd = '';
            curateProd += '<li id="crt'+product.sellPrdtBcode+'">';
            curateProd += '    <a href="javascript://" onclick="rmProduct(\''+product.sellPrdtBcode+'\')" class="btn_del">삭제</a>'
            curateProd += '    <span class="photo"><img src="'+product.productImageUrl+'"/></span>';
            curateProd += '    <span class="make txt_line1">'+product.brandName+'</span>';
            curateProd += '    <span class="name txt_line1">'+product.prdtName+'</span>';
            curateProd += '</li>';
            
            if(!isEmpty(sellPrdtBcodes))    sellPrdtBcodes += ",";
            sellPrdtBcodes += product.sellPrdtBcode;
            $("input[name=sellPrdtBcode]").val(sellPrdtBcodes);
            
            $("#curateProducts").prepend(curateProd);
        }
    }else{
        errMsg = "이미 등록된 상품입니다.";
    }
    return errMsg;
}

function rmProduct(bcode){
    var sellPrdtBcodes = $("input[name=sellPrdtBcode]").val();
    var sellPrdtBcode = sellPrdtBcodes.split(",");
    var result = new Array();
    for(var i= 0; i<sellPrdtBcode.length; i++){
        if(sellPrdtBcode[i] != bcode){
            result.push(sellPrdtBcode[i]);
        }
    }
    $("#crt"+bcode).remove();
    $("input[name=sellPrdtBcode]").val(result.join(","));
}

function cancelCurateFrm(){
    $(".curate-form").remove();
    $('#mask').hide();
}
</script>
<!-- sub contents -->
<div class="curate-form">
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_choice_reg.jpg" alt="추천상품등록" /></h3>
    <ul class="list_type02">
        <li>추천상품과 추천이유를 작성해 주세요~</li>
        <li>상품 등록은 검색 버튼 클릭 후 검색창에서 선택 하실 수 있습니다.</li>
    </ul>
    
    <form name="curateFrm" action="#" method="post">
        <input type="hidden" name="crtSeq" value="${cfCriteria.crtSeq}"/>
        <input type="hidden" name="eventId" value="${cfCriteria.eventId}"/>
        <input type="hidden" name="dispYn" value="Y"/>
        <table class="table02 mgt30" summary="대량구매상담 양식의 회사명,회사주소,회사홈페이지,담당자명,부서명,전화,휴대폰,이메일,희망구매상품,희망구매수량,비고 항목이 있습니다.">
            <caption>대량구매상담 양식</caption>
            <colgroup>
                <col width="150px;" />
                <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row"><label for="crtTitle">제목</label></th>
                    <td><input type="text" name="crtTitle" value="${ext.crtTitle}" id="crtTitle" style="width:545px;" class="input_txt" /></td>
                </tr>
                <tr>
                    <th scope="row"><label for="emtcUrl01">이모티콘</label></th>
                    <td>
                        <c:forEach begin="0" end="5" varStatus="s1">
                            <span style="margin-right:15px;">
                                <c:set var="emtcUrl">/images/renewal/content/ic_emtc_0${s1.count}.png</c:set>
                                <input type="radio" name="emtcUrl" id="emtcUrl0${s1.count}" value="${emtcUrl}"<c:if test="${(empty ext && s1.first) || ext.emtcUrl eq emtcUrl}"> checked="checked"</c:if>/>
                                <label for="emtcUrl"><img src="${imageServer}${emtcUrl}" alt="이모티콘0${s1.count}" style="width:30px;"/></label>
                            </span>
                        </c:forEach>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="crtDesc">추천이유</label></th>
                    <td><textarea name="crtDesc" id="crtDesc" cols="50" rows="50" style="width:98%; height:80px;">${ext.crtDesc}</textarea></td>
                </tr>
                <tr>
                    <th scope="row">
                        <label for="wishBuyProduct">희망구매상품</label>
                        <a href="/ht/findProduct" onclick="window.open(this.href, '_searchPrdt', 'width=715,height=600,scrollbars=yes');return false;" target="_blank" title="새창에서 열림"><img src="${imageServer}/images/renewal/common/btn_plus_round02.gif" alt="상품검색"/></a>
                    </th>
                    <td>
                        <div class="curate-list">
                            <ul id="curateProducts">
                                <c:set var="sellPrdtBcode" value=""/> 
                                <c:forEach items="${prdtList}" var="l">
                                    <c:if test="${not empty sellPrdtBcode}"><c:set var="sellPrdtBcode">${sellPrdtBcode},</c:set></c:if>
                                    <c:set var="sellPrdtBcode">${sellPrdtBcode}${l.sellPrdtBcode}</c:set>
                                    <li id="crt${l.sellPrdtBcode}">
                                        <a href="javascript://" onclick="rmProduct('${l.sellPrdtBcode}')" class="btn_del">삭제</a>
                                        <span class="photo">
                                            <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'100':'66'}" alt="${fn:escapeXml(l.prdtName)}"/></c:if>
                                            <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"><ui:image src="${l.prdtImgUrl}" size="100" server="product" alt="${fn:escapeXml(l.prdtName)}"/></c:if>
                                        </span>
                                        <span class="make txt_line1">${l.prdtName}</span>
                                        <span class="name txt_line1">${l.brandName}</span>
                                    </li>
                                 </c:forEach>
                            </ul>
                        </div>
                        <input type="hidden" name="sellPrdtBcode" value="${sellPrdtBcode}"/>
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="btn_area t_center mgt30">
            <a href="javascript://" onclick="submitCurateFrm()" class="btn_type03 btn bg_orange">등록</a>
            <a href="javascript://" onclick="cancelCurateFrm()" class="btn_type03 btn br_orange">취소</a>
        </div>
    </form>
</div>