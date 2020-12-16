<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>대량구매상담 | 공지문의 | 고객센터 - HOTTRACKS</title>
<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>
<script type="text/javascript">
//대량구매 상담 저장
function sendBulkCounselRequest() {
    if(!$("#chkAgree").is(":checked")){
        alert("[제휴업체 담당자 개인정보 수집 및 이용에 대한 안내]에 대한 동의를 해주세요.");
        $("#chkAgree").focus();
        return;
    }
    
    $('form[name="saveBulkCounselRequestForm"]').find("input").each(function() {
        $(this).val($.trim($(this).val()));
    });
    
    if($("input[name='wishBuyCount']").val() == "") {
        $("input[name='wishBuyCount']").val(-1);
    }
    
    if($("input[name='emailAddress']").val() == "") {
        $("input[name='emailAddress']").val("noInput@noInput.co.kr");
    }
    
    if($("textarea[name='etcDetailContent']").val() == "") {
        $("textarea[name='etcDetailContent']").val("noInput");
    }
    
    $('form[name="saveBulkCounselRequestForm"]').ajaxSubmit({
        url: "/ht/help/saveBuBusinessBuy"
        ,dataType: "json"
        ,success: function(data) {
            if (data.save) {
                alert('<fmt:message key="message.bulk.counsel.save"/>');
            } else {
                var errorMessages = data.errorMessages;
                alert(errorMessages.join("\n"));
            }
        }
        ,error: function(data) {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}
function setProduct(prdtName){
    $("input[name=wishBuyProduct]").val(prdtName);
}
</script>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_cs_center.gif" alt="CS Center"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>대량구매상담</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/help/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_business_buy.gif" alt="대량구매상담" /></h3>
    <ul class="list_type02">
        <li>핫트랙스 온라인몰 대량구매 상담을 이용해 주셔서 진심으로 감사드립니다.</li>
        <li>원하시는 상품과 연락처 , 수량을 남겨주시면 최대한 빠른 시간에 연락 드리도록 하겠습니다.</li>
        <li>궁금하신 사항은 고객센터로 연락주세요 1661-1112</li>
    </ul>
    
    <form name="saveBulkCounselRequestForm" action="#" method="post">
        <input type="hidden" name="companyName" id="companyName" style="width:145px;" class="input_txt" value="회사명"/>
        <input type="hidden" name="companyAddress" id="companyAddress" style="width:465px;" class="input_txt" value="회사주소"/>
        <input type="hidden" name="companyHomepageUrl" id="companyHomepageUrl" style="width:300px;" class="input_txt" value="회사홈페이지"/>
        <input type="hidden" name="subscriberDepartment" id="subscriberDepartment" style="width:145px;" class="input_txt" value="부서명"/>
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
        <table class="table02 mgt30" summary="대량구매상담 양식의 회사명,회사주소,회사홈페이지,담당자명,부서명,전화,휴대폰,이메일,희망구매상품,희망구매수량,비고 항목이 있습니다.">
            <caption>대량구매상담 양식</caption>
            <colgroup>
                <col width="17%" />
                <col width="33%" />
                <col width="17%" />
                <col width="*" />
            </colgroup>
            <tbody>
<!-- 
                <tr>
                    <th scope="row"><label for="companyName">회사명</label></th>
                    <td colspan="3"><input type="text" name="companyName" id="companyName" style="width:145px;" class="input_txt" /></td>
                </tr>
                <tr>
                    <th scope="row"><label for="companyAddress">회사주소</label></th>
                    <td colspan="3"><input type="text" name="companyAddress" id="companyAddress" style="width:465px;" class="input_txt" /></td>
                </tr>
                <tr>
                    <th scope="row"><label for="companyHomepageUrl">회사홈페이지</label></th>
                    <td colspan="3"><input type="text" name="companyHomepageUrl" id="companyHomepageUrl" style="width:300px;" class="input_txt" /></td>
                </tr>
 -->
                <tr>
                    <th scope="row"><label for="subscriberName">성함</label></th>
                    <td colspan="3"><input type="text" name="subscriberName" id="subscriberName" style="width:145px;" class="input_txt" /></td>
<!-- 
                    <th scope="row"><label for="subscriberDepartment">부서명</label></th>
                    <td><input type="text" name="subscriberDepartment" id="subscriberDepartment" style="width:145px;" class="input_txt" /></td>
 -->
                </tr>
                <tr>
                    <th scope="row">전화</th>
                    <td>
                        <input type="text" name="subscriberTelNumber01" style="width:36px;" class="input_txt inputNumberText" maxlength="4" title="전화번호 첫 번째 자리"/>
                        -
                        <input type="text" name="subscriberTelNumber02" style="width:36px;" class="input_txt inputNumberText" maxlength="4" title="전화번호 두 번째 자리"/>
                        -
                        <input type="text" name="subscriberTelNumber03" style="width:36px;" class="input_txt inputNumberText" maxlength="4" title="전화번호 세 번째 자리"/>
                    </td>
                    <th scope="row">휴대폰</th>
                    <td>
                        <input type="text" name="subscriberHPNumber01" style="width:36px;" class="input_txt inputNumberText" maxlength="4" title="휴대폰 첫 번째 자리"/>
                        -
                        <input type="text" name="subscriberHPNumber02" style="width:36px;" class="input_txt inputNumberText" maxlength="4" title="휴대폰 두 번째 자리"/>
                        -
                        <input type="text" name="subscriberHPNumber03" style="width:36px;" class="input_txt inputNumberText" maxlength="4" title="휴대폰 세 번째 자리"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="emailAddress">이메일</label></th>
                    <td colspan="3"><input type="text" name="emailAddress" id="emailAddress" style="width:230px;" class="input_txt" /></td>
                </tr>
                <tr>
                    <th scope="row"><label for="wishBuyProduct">희망구매상품</label></th>
                    <td colspan="3">
                        <input type="text" name="wishBuyProduct" id="wishBuyProduct" style="width:500px;" class="input_txt" readonly/>
                        <a href="/ht/searchProduct" onclick="window.open(this.href, '_searchPrdt', 'width=715,height=600,scrollbars=yes');return false;" target="_blank" title="새창에서 열림" class="btn_type01">검색</a>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="wishBuyCount">희망구매수량</label></th>
                    <td colspan="3">
                        <input type="text" class="input_txt wish-quantity inputNumberText" name="wishBuyCount" id="wishBuyCount" style="width:230px;"/>
                        <span class="point02">(* 숫자만 입력가능합니다)</span>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="etcDetailContent">비고</label></th>
                    <td colspan="3">
                        <span class="point02">예) 연락은 1시 ~ 5시 사이에 해주세요~ </span><BR/>
                        <span class="point02">예) 유치원  사은품으로 사용 합니다. 다른 상품도 추천 주세요 .</span><BR/>
                        <textarea name="etcDetailContent" id="etcDetailContent" cols="50" rows="50" style="width:98%; height:80px;"></textarea>
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="btn_area t_center mgt50">
            <a href="javascript://" onclick="sendBulkCounselRequest()" class="btn_type03">상담접수</a>
        </div>
    </form>
</div>
<!-- //sub contents -->
</body>
</html>