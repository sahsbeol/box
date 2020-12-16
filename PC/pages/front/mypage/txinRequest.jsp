<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>세금계산서신청 | 주문정보 | MY HOTTRACKS - HOTTRACKS</title>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/loadingBar"></script>
<script type="text/javascript">
jQuery(function() {
    // 전송
    $("#submitFrm").click(function(event) {
        event.preventDefault();
        $("form#txRequestForm").ajaxSubmit({
            url:'/ht/mypage/addTxinRequest'
            , dataType:'json'
            , success: function(data){
                if(data.success) {
                    alert('<fmt:message key="message.save.success"/>');
                    location.reload();
                }else{
                    var errorMessages = data.errorMessages;
                    var errorStr="";
                    for(i=0; i<errorMessages.length; i++) {
                        errorStr += errorMessages[i] + "\n";
                    }
                    alert(errorStr);
                }
            }
            , error: function(data){
                alert("<fmt:message key='error.common.system'/>");
            }
        });
    });
    
    // 취소
    $("#cancelFrm").click(function(event) {
        event.preventDefault();
        $("form input, form select").val("");
    });
});
// 조회 콜백함수
function callBackSearchTxinRequest(userBizRegNumSeq) {
     $('div#callBackTxinRequest').load('/ht/mypage/ajaxSearchTxinRequest?userBizRegNumSeq=' + userBizRegNumSeq);
}

// 세금계산서 관련 faq 바로가기
function goFaq() {
    window.location.href = "/ht/help/faqListC0394";
}

// 주문결제월 선택 조회
function goSearchOtherMonth() {
    var searchMonth = $("select[name='searchMonth']").val();
    $("div#orderInfo").load("/ht/mypage/orderHistoryList?searchMonth=" + searchMonth);
}

// 세금계산서 신청목록
function goTxinRequestList() {
    window.location.href = "/ht/mypage/txinRequestList";
}

// 조회
function searchTxinRequest() {
    window.open('/ht/mypage/searchTxinRequest', '' , 'width=820,height=360');
}

// 등록
function registTxin(){
    window.open('/ht/mypage/createFormTxinRequest', '' , 'width=820,height=460');
}

// 세금계산서 faq
function goFaq() {
    window.location.href = "/ht/help/faqListC0394";
}
<%-- 이메일 선택 이벤트 --%>
function emailSelect() {
    if(this.value == "") {
        this.disabled = "";
        $(document).find("input[name=emailAddr2]").attr("disabled", false);
    }else {
        $(document).find("input[name=emailAddr2]").attr("disabled", true);
    }
    $(document).find("input[name=emailAddr2]").val(this.value);
    
}
</script>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_my_hottracks.gif" alt="My Hottracks"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>MY HOTTRACKS</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/mypage/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/txinRequest.gif" alt="세금계산서 신청" /></h3>
    <div class="mgt30">
        <a href="javascript://" onclick="goTxinRequestList()" class="btn_type01">세금계산서 신청내역 보기</a>
    </div>
    <div class="box_gray03 pd14 mgt10">
        <h4>주문번호 조회</h4>
        <ul class="list_type02 mgt10">
            <li>결제일이 전월인 주문은 당월 7일까지 조회, 신청 가능합니다. 8일부터는 당월 주문만 조회됩니다.</li>
            <li>해당주문의 상품이 모두 출고완료 된 주문만 신청가능하며 월 단위로 신청 가능합니다.</li>
        </ul>
    </div>
    <form id="txRequestForm">
    <!-- 퍼블리싱에 없는 내용 -->
    <c:if test="${!empty monthSelect}">
        <div class="mgt10">
            <span class="bold"> 주문결제월 선택</span>
            <select class="select" name="searchMonth" style="width:70px;">
                <c:forEach items="${monthSelect}" var="month">
                    <option value="${month}"<c:if test="${criteria.searchMonth eq month}"> selected="selected"</c:if>>${month}</option>
                </c:forEach>
            </select>
            <span class="btn_type02"><a href="javascript://" onclick="goSearchOtherMonth()">조회</a></span> 
        </div>
    </c:if>
    <!-- //퍼블리싱에 없는 내용 -->
    <div id ="orderInfo">
    <table class="bbs_list01 mgt15">
        <caption>주문번호 조회 <span>선택, 주문번호, 결제완료일, 상품내역, 결제금액</span>
        </caption>
        <colgroup>
            <col style="width:50px" />
            <col style="width:80px" />
            <col style="width:120px" />
            <col style="width:*" />
            <col style="width:80px" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">선택</th>
                <th scope="col">주문번호</th>
                <th scope="col">결제완료일</th>
                <th scope="col">상품내역</th>
                <th scope="col" class="last">결제금액</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${empty orderHistoryList}"><tr><td colspan="5" class="no_data">검색된 주문내용이 없습니다.</td></tr></c:if>
            <c:forEach items="${orderHistoryList}" var="order" varStatus="status">
                <tr>
                    <td><input name="orderNums" value="${order.orderNum}" type="checkbox" title="[${order.orderNum}] 주문번호 선택" /></td>
                    <td><a href="/ht/mypage/orderDeliveryDetail?orderNo=${order.orderNum}">${order.orderNum}</a></td>
                    <td><fmt:formatDate value="${order.pymntDtm}" pattern="yyyy.MM.dd"/></td>
                    <td><a href="/ht/mypage/orderDeliveryDetail?orderNo=${order.orderNum}">${order.prdtName}<c:if test=" ${order.prdtCount > 0}" > 외  ${order.prdtCount}건</c:if></a></td>
                    <td class="t_right"><fmt:formatNumber value="${order.pymntAmt}" pattern="#,###"/>원</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>
    <div class="box_gray03 pd14 mgt80">
        <h4>사업자 등록증 등록 및 조회</h4>
        <ul class="list_type02 mgt10">
            <li>1회 이상 신청하거나 자주쓰는 사업자등록번호에 등록하시면 사업등록번호를 작성하신 후 '조회'를 클릭하면 관련 정보를 불러올 수 있습니다. </li>
        </ul>
    </div>
    <p class="stxt mgt10">* 세금계산서는 이메일로 발송되므로 정확하게 기재해 주셔야 합니다.</p>
    
    <div id="callBackTxinRequest">
        <table class="table02 mgt30">
            <caption>사업자 등록증 신청<span>사업자등록번호, 상호명(법인명), 대표자명, 업태, 종목, 사업자소재지, 담당자명, 이메일, 신청자명, 산청자 연락처</span></caption>
            <colgroup>
                <col width="17%" />
                <col width="33%" />
                <col width="17%" />
                <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row"><label for="bizRegNum">사업자등록번호</label></th>
                    <td colspan="3">
                        <input name="bizRegNum1" maxlength="3" type="text" class="input_txt" id="bizRegNum" title="사업자등록번호 앞자리입력" style="width:44px;" /> -
                        <input name="bizRegNum2" maxlength="2" type="text" class="input_txt" title="사업자등록번호 중간자리입력" style="width:44px;" /> -
                        <input name="bizRegNum3" maxlength="5" type="text" class="input_txt" title="사업자등록번호 뒷자리입력" style="width:44px;" />
                        <c:if test="${!empty loginUser}" >
                            <a href="#" onclick="searchTxinRequest();return false;" class="btn_type01">조회</a>
                            <a href="#" onclick="registTxin();return false;" class="btn_type01">등록</a>
                        </c:if>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="vndrName">상호명</label></th>
                    <td><input name="vndrName" type="text" class="input_txt" id="vndrName" style="width:170px;" /></td>
                    <th scope="row"><label for="primeName">대표자명</label></th>
                    <td><input name="primeName" type="text" class="input_txt" id="primeName" style="width:170px;" /></td>
                </tr>
                <tr>
                    <th scope="row"><label for="bizKindInfo">업태</label></th>
                    <td><input name="bizTypeInfo" type="text" class="input_txt" id="bizKindInfo" style="width:170px;" /></td>
                    <th scope="row"><label for="division">종목</label></th>
                    <td><input name="bizKindInfo" type="text" class="input_txt" id="division" style="width:170px;" /></td>
                </tr>
                <tr>
                    <th scope="row"><label for="vndrAddr">사업자 소재지</label></th>
                    <td colspan="3"><input name="vndrAddr" type="text" class="input_txt" id="vndrAddr" style="width:465px;" /></td>
                </tr>
                <tr>
                    <th scope="row"><label for="mngrName">담당자명</label></th>
                    <td colspan="3"><input name="mngrName" type="text" class="input_txt" id="mngrName" style="width:170px;" /></td>
                </tr>
                <tr>
                    <th scope="row"><label for="mail">이메일</label></th>
                    <td colspan="3">
                        <input name="emailAddr1" type="text" class="input_txt" id="mail" title="이메일 아이디입력" style="width:170px;" /> @
                        <input name="emailAddr2" type="text" class="input_txt" title="이메일 도메인입력" style="width:170px;" />
                        <select name="emailSelect" onchange="emailSelect()" class="select" title="이메일 도메인선택" style="width:120px;">
                            <option value="">직접입력</option>   
                            <option value="naver.com">naver.com</option>
                            <option value="hanmail.net">hanmail.net</option>
                            <option value="hotmail.com">hotmail.com</option>
                            <option value="nate.com">nate.com</option>
                            <option value="yahoo.co.kr">yahoo.co.kr</option>
                            <option value="empas.com">empas.com</option>
                            <option value="dreamwiz.com">dreamwiz.com</option>
                            <option value="freechal.com">freechal.com</option>
                            <option value="lycos.co.kr">lycos.co.kr</option>
                            <option value="korea.com">korea.com</option>
                            <option value="gmail.com">gmail.com</option>
                            <option value="hanmir.com">hanmir.com</option>
                            <option value="paran.com">paran.com</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="applicant">신청자명</label></th>
                    <td><input name="sscbrName" type="text" class="input_txt" id="applicant" style="width:170px;" /></td>
                    <th scope="row"><label for="applicantTel1">신청자 연락처</label></th>
                    <td>
                        <input name="sscbrTelNum1" maxlength="3" id="applicantTel1" type="text" style="width:36px;" class="input_txt" title="신청자 연락처 첫 번째 자리"/> -
                        <input name="sscbrTelNum2" maxlength="4" type="text" style="width:36px;" class="input_txt" title="신청자 연락처 두 번째 자리"/> -
                        <input name="sscbrTelNum3" maxlength="4" type="text" style="width:36px;" class="input_txt" title="신청자 연락처 세 번째 자리"/>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="btn_area t_center mgt50">
        <a href="#n" id="submitFrm" class="btn_type03">신청하기</a>
        <a href="#n" id="cancelFrm" class="btn_type04">취소</a>
    </div>
    </form>
    <div class="infobox01 type2 mgt80">
        <h5 class="txt_tip">
            세금계산서 신청시 유의사항
            <a href="javascript://" onclick="goFaq()" class="btn_type01 mgl10"> 세금계산서 FAQ</a>
        </h5>
        <div class="con">
            <ul class="list_type02">
                <li>[세금계산서]는 과세/면세 각 1장씩 발행됩니다.</li>
                <li>면세 상품은 꽃종류, 도서(화보집)입니다.</li>
                <li>[세금계산서] 신청은 발송완료 후 익월 7일 이내에 가능합니다.</li>
                <li>[세금계산서] 작성일(세금계산서 내 작성될 날짜)은 결제완료일로 기재됩니다.<br />
                단, 익월 7일까지 신청해야 발급가능하며 이후 신청 불가능 합니다.<br />
                (예 : 2006년1월30일 결제완료일을 2006년2월7일까지 신청해야 [세금계산서] 작성일 란에 2006년1월30일로 기재됩니다.)</li>
                <li>[세금계산서]를 신청하면 기재한 이메일로 신청내역 발송함과 동시에, 인쇄 페이지로 이동됩니다.</li>
                <li><font color="red">현금영수증이 발행된 주문은 [세금계산서] 발행시 현금영수증이 자동취소 됩니다.</font></li>
                <li><font color="red">발급은 현금성 거래로 인정되는 수단에 한해서만 가능합니다. (실시간계좌이체, 무통장 송금 주문 건)</font></li>
                <li>배송비는 주문 내용에 따라 세금계산서 발행 시, 미포함될 수 있습니다.</li>
                <li>신용카드결제 혹은 신용카드+현금성수단 결제 주문인 경우에는 [세금계산서] 신청이 불가능 합니다.<br />
                [카드매출전표 + 현금영수증 제공]</li>
                <li>합주문, 분리 배송, 부분 배송건에 대한 [세금계산서]는 고객센터 (1661-1112)로 문의해주세요.</li>
            </ul>
        </div>  
    </div>
</div>
<!-- //sub contents -->
</body>
</html>