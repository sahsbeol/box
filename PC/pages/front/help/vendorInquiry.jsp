<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>상품입점문의 | 공지문의 | 고객센터 - HOTTRACKS</title>
<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>
<script type="text/javascript">
jQuery(function($) {
    $("form[name='vendorIqryForm']").submit(function() {
        var required = new Array();
        $(".required").each(function(){
            if(isEmpty($(this).val())){
                required.push($(this).attr("title"));
            }
        });
        
        if($("input[name=prdtGbn]:checked").val() == undefined){
            required.push("상품종류");
        }
        if($("#categorySelect select:eq(1)").val() == "0000"){
            required.push("2차 카테고리");
        }
        if(isEmpty($("textarea[name=iqryDesc]").val())){
            required.push("상품설명");
        }
        
        if(!$("#chkAgree").is(":checked")){
            alert("[제휴업체 담당자 개인정보 수집 및 이용에 대한 안내]에 대한 동의를 해주세요.");
            $("#chkAgree").focus();
        }else if(required.length > 0){
            alert("※해당 항목들은 생략이 불가능합니다.\r\n-"+required.join("\r\n-"));
        }else{
            beforeSubmit();
            $(".newbtn_064").hide();
            $("form[name='vendorIqryForm']").ajaxSubmit({
                url: "/ht/help/createVendorInquiry"
                ,dataType: "json"
                ,success: saveSuccess
                ,error: function(xhr, status, error) {
                    alert("<fmt:message key='error.common.system'/>");
                    $(".newbtn_064").show();
                }
            });
        }
        
        return false;
    });
});

function saveSuccess(data) {
    if (data.save) {
        alert('<fmt:message key="message.save.success"/>');
        document.location.href = "/ht/welcomeMain"; 
    } else {
        var errorMessages = data.errorMessages;
        alert(errorMessages.join("\n"));
        $(".newbtn_064").show();
    }
}

<%-- 등록 전 호출되는 함수(숫자값 초기화) --%>
function beforeSubmit() {
    var cnt = $("input[name=sellPsbltPrdtCount]");
    var tmp = cnt.val().replace(/\D/gi,"");
    cnt.val(tmp);
    
    $(".inputNumberText").each(function () {
        if($(this).val() == ""  && !$(this).hasClass("nums")) {
            $(this).val(0);
        }
    });
}

function get_number(val){
    val = $.trim(val);
    var rv = [];
    for(var i=0 ; i < val.length ; i++){
        if(i==0 && val.substring(i, i+1) == "-"){ rv.push("-"); }
        if(!isNaN(val.substring(i, i+1))){ rv.push(val.substring(i, i+1)); }
    }
    return rv.join("");
}

$(document).ready(function(event){
    $(".inputOnlyNum").change(function(event){
        this.value = get_number(this.value);
    });
    
    categorySelectLoad("0000", 2);
});

function categorySelectLoad(parentCateId, maxLength, divId, inputName, mallId) {
    if (maxLength == undefined || maxLength == "") {
        maxLength = 0;
    }
    
    if (divId == undefined || divId == '') {
        divId = 'categorySelect';
    }
    
    if (inputName == undefined || inputName == '') {
        inputName = 'selectCategory';
    }
    
    if (mallId == undefined) {
        mallId = '';
    }
    
    if (parentCateId == undefined || parentCateId == '') {
        parentCateId = '00';
    }
    
    var params = 'parentCateId='+parentCateId;
    params += '&maxLength=' + maxLength;
    params += '&inputName=' + inputName;
    params += '&divId=' + divId;
    params += '&mallId=' + mallId;
    
    $('#' + divId).html('');
    $.ajax({
        type: 'GET'
        ,url: '/product/listCategoryForSelect'
        ,data: params
        ,dataType: 'html'
        ,success: function(html) {
            $('#' + divId).html(html);
        }
    });
    
}
function checkLengthArea(chkObj, maxLength){
    var str = new String($("textarea[name="+chkObj+"]").val());
    var _byte = 0;
    if(str.length != 0){
        for(var i = 0; i < str.length; i++){
            if(escape(str.charAt(i)).length > 4)    _byte += 2;  // 2Byte
            else                                    _byte++;     // 1Byte
            
            if(_byte > maxLength){
                alert('제한 글자 수를 초과하였습니다');
                $("textarea[name="+chkObj+"]").val(str.substr(0, i));
                
                if(escape(str.charAt(i)).length > 4)    _byte -= 2;
                else                                    _byte--;
                
                break;
            }
        }
    }
    
    $("#t_"+chkObj).html(Byte_Length($($("textarea[name="+chkObj+"]")).val())+" Byte");
}
function Byte_Length(lvStr){
    var resultSize = 0;
    if (lvStr == null) return 0;
    for(var i=0; i<lvStr.length; i++){
        var c = escape(lvStr.charAt(i));
        if(c.length == 1) resultSize ++;
        else if(c.indexOf("%u") != -1) resultSize += 2;
        else if(c.indexOf("%") != -1) resultSize += c.length/3;
    }
    return resultSize;
}

function submitFrm(){
    $("form[name=vendorIqryForm]").submit();
}
</script>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_cs_center.gif" alt="CS Center"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>상품입점문의</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/help/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_vendor_inquiry.gif" alt="상품입점문의" /></h3>
    <ul class="list_type02">
        <li>핫트랙스와 함께 할 파트너를 모십니다.</li>
        <li>귀사의 상품을 입점하고자 하실 경우, 먼저 아래의 입점신청서를 작성하여 등록해 주세요.</li>
        <li>각 담당자가 신청서를 검토 및 확인 후 개별적으로 전화나 이메일로 답변을 드리고 있습니다.</li>
        <li>업무폭주로 인해 따로 전화상담은 받고 있지 않으니 참고 바랍니다.</li>
    </ul>
    <form name="vendorIqryForm" action="/" method="post">
    <div class="info_box mgt20">
        <ul class="incont">
            <li class="info_tit">* 제휴업체 담당자 개인정보 수집 및 이용에 대한 안내</li>
            <li>- 수집항목: 담당자명, 연락처, 이메일</li>
            <li>- 수집목적: 제휴협의를 위한 문의내역 확인 및 답변처리</li>
            <li>- 활용기간: 접수일로부터 한 달</li>
            <li>- 기재하여 주신 개인 정보는 제휴협의 외 다른 목적으로 사용되지 않습니다</li>
        </ul>
        <p class="agree"><input type="checkbox" id="chkAgree"/><label for="chkAgree"> 위 개인정보 수집, 이용에 동의합니다.</label></p>
    </div>
    <table class="table02 mgt30" summary="상품입점문 양식의 회사명,회사주소,담당자명,부서,연락처,휴대폰,이메일,회사URL,주요납품처,사업자등록번호,대표자명,업종,연매출,상품브랜드,판매가능한 상품수,상품종류,카테고리,상품설명 항목이 있습니다.">
        <caption>상품입점문의 양식</caption>
        <colgroup>
            <col width="17%" />
            <col width="33%" />
            <col width="17%" />
            <col width="*" />
        </colgroup>
        <tbody>
            <tr>
                <th scope="row"><label for="vndrName">회사명</label></th> 
                <td colspan="3"><input type="text" name="vndrName" id="vndrName" style="width:145px;" class="input_txt required" title="회사명"/></td>
            </tr>
            <tr>
                <th scope="row"><label for="vndrAddr">회사주소</label></th> 
                <td colspan="3"><input type="text" name="vndrAddr" id="vndrAddr" style="width:465px;" class="input_txt required" title="회사주소"/></td>
            </tr> 
            <tr> 
                <th scope="row"><label for="mngrName">담당자명</label></th> 
                <td><input type="text" name="mngrName" id="mngrName" style="width:145px;" class="input_txt required" title="담당자명"/></td> 
                <th scope="row"><label for="dptmtName">부서</label></th>
                <td><input type="text" name="dptmtName" id="dptmtName" style="width:145px;" class="input_txt" title="부서"/></td> 
            </tr> 
            <tr> 
                <th scope="row">연락처</th> 
                <td>
                    <input type="text" name="telNum1" style="width:36px;ime-mode:disabled;" class="input_txt inputNumberText" maxlength="4" title="연락처 첫 번째 자리"/>
                    -
                    <input type="text" name="telNum2" style="width:36px;" class="input_txt inputNumberText" maxlength="4" title="연락처 두 번째 자리"/>
                    -
                    <input type="text" name="telNum3" style="width:36px;" class="input_txt inputNumberText" maxlength="4" title="연락처 세 번째 자리"/>
                </td>
                <th scope="row">휴대폰</th>
                <td>
                    <input type="text" name="hdphnTelNum1" style="width:36px;ime-mode:disabled;" class="input_txt inputNumberText" maxlength="4" title="휴대폰 첫 번째 자리"/>
                    -
                    <input type="text" name="hdphnTelNum2" style="width:36px;" class="input_txt inputNumberText" maxlength="4" title="휴대폰 두 번째 자리"/>
                    -
                    <input type="text" name="hdphnTelNum3" style="width:36px;" class="input_txt inputNumberText" maxlength="4" title="휴대폰 세 번째 자리"/>
                </td>
            </tr>
            <tr>
                <th scope="row"><label for="emailAddr">이메일</label></th> 
                <td colspan="3"><input type="text" name="emailAddr" id="emailAddr" style="width:190px;" class="input_txt required" title="이메일"/></td>
            </tr>
            <tr> 
                <th scope="row"><label for="vndrUrl">회사 URL</label></th> 
                <td colspan="3"><input type="text" name="vndrUrl" id="vndrUrl" style="width:230px;" class="input_txt" title="회사 URL"/></td>
            </tr>
            <tr>
                <th scope="row"><label for="primeDlvyCstm">주요납품처</label></th> 
                <td colspan="3"><input type="text" name="primeDlvyCstm" id="primeDlvyCstm" style="width:230px;" class="input_txt" title="주요납품처"/></td>
            </tr>
            <tr>
                <th scope="row"><label for="bizRegNum">사업자등록번호</label></th> 
                <td colspan="3"><input type="text" name="bizRegNum" id="bizRegNum" style="width:170px;" class="input_txt required" title="사업자등록번호"/></td>
            </tr>
            <tr>
                <th scope="row"><label for="primeName">대표자명</label></th> 
                <td colspan="3"><input type="text" name="primeName" id="primeName" style="width:170px;" class="input_txt required" title="대표자명"/></td>
            </tr>
            <tr> 
                <th scope="row"><label for="bizKindInfo">업종</label></th>
                <td colspan="3"><input type="text" name="bizKindInfo" id="bizKindInfo" style="width:170px;" class="input_txt required" title="업종"/></td>
            </tr>
            <tr> 
                <th scope="row"><label for="yyyySales">연매출</label></th> 
                <td colspan="3"><input type="text" name="yyyySales" id="yyyySales" placeholder="숫자만가능" style="width:170px;ime-mode:disabled;" class="input inputNumberText inputOnlyNum required" maxlength="9" title="연매출"/></td>
            </tr>
            <tr> 
                <th scope="row"><label for="prdtBrand">상품브랜드</label></th> 
                <td><input type="text" name="prdtBrand" id="prdtBrand" style="width:170px;" class="input_txt required" title="상품브랜드"/></td> 
                <th scope="row"><label for="sellPsbltPrdtCount">판매가능한 상품수</label></th>
                <td><input type="text" name="sellPsbltPrdtCount" id="sellPsbltPrdtCount" style="width:170px;ime-mode:disabled;" class="input_txt inputNumberText required" maxlength="9" title="판매가능한 상품수"/></td>
            </tr>
            <tr>
                <th scope="row">상품종류</th> 
                <td class="txt" colspan="3"> 
                    <input name="prdtGbn" id="internal" type="radio" value="N" class="radios" title="상품종류"/><label for="internal" class="t01">국내유통 상품</label>
                    <input name="prdtGbn" id="importation" type="radio" value="I" class="radios" title="수입"/><label for="importation" class="t01">수입</label>
                    <input name="prdtGbn" id="itself" type="radio" value="S" class="radios" title="자체제작"/><label for="itself" class="t01">자체제작</label> 
                </td>
            </tr>
            <tr>
                <th scope="row">카테고리</th> 
                <td class="txt" colspan="3"><div class="left" id="categorySelect"></div></td>
            </tr>
            <tr> 
                <th scope="row"><label for="iqryDesc">상품설명</label></th> 
                <td colspan="3">
                    <div><textarea class="in01" style="width:98%;height:80px;" name="iqryDesc" id="iqryDesc" onkeyup="checkLengthArea('iqryDesc', 2000)" title="상품설명"></textarea></div>
                    <div style="float:right;">(<span id="t_iqryDesc">0Byte</span> / 2000 Byte)</div>
                </td>
            </tr>
        </tbody>
    </table>
    <div class="btn_area t_center mgt50">
        <a href="javascript://" class="btn_type03" onclick="submitFrm()">접수</a>
    </div>
    </form>
</div>
<!-- //sub contents -->
</body>
</html>