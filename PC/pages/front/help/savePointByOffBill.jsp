<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>영수증적립 | 서비스안내 | 고객센터 - HOTTRACKS</title>
<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>
<script type="text/javascript">
var isLogin = ${isLogin};
function offSavePoint() {
    if (!isLogin) {
        needLogin();
    } else {
        if(!serviceCheck()){
            if ($("input[name=textfield]").val() == "") {alert("영수증번호가 없습니다.");document.offPoint.textfield.focus();return;}
            if ($("input[name=textfield2]").val() == "") {alert("금액이 없습니다.");document.offPoint.textfield2.focus();return;}
            
            $("#offPoint").ajaxSubmit({
                type : "POST"
                , url : "/ht/help/savePointByOffBillAjx"
                , async : false
                , success : function(result){
                    if(result.save == "OK"){
                        alert("적립되었습니다.");
                        location.reload();
                    } else {
                        alert(result.errorMessages);
                    }
                }
                ,error: function(xhr, status, error) {
                    alert("<fmt:message key='error.common.system'/>");
                }
            });
        }
    }
}
</script>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_cs_center.gif" alt="CS Center"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>영수증 적립</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/help/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_save_point.gif" alt="영수증 적립" /></h3>
    <ul class="list_type02">
        <li>구매 후 깜빡하고 적립하지 못했던 통합 포인트 영수증 적립 이제 핫트랙스 온라인몰에서 간편하게 적립하세요</li>
    </ul>

    <h4 class="tit01">통합포인트 적립방법</h4>
    <div><img src="${imageServer}/images/renewal/content/txt_save_point.gif" alt="회원 인증하기 &rarr; 핫트랙스 영수증번호 &rarr; 통합포인트 "/></div>
    <ul class="list_type02 mgt15">
        <li>매장에서 결제하신 핫트랙스 영수증은 통합포인트 후적립이 가능합니다.</li>
        <li>영수증 하단에 있는 바코드 번호와 승인금액을 입력하셔야 해당 영수증의 통합포인트가 후적립됩니다.</li>
        <li>영수증 후적립은 7일 이전 영수증까지 가능합니다.</li>
        <li>동일일자에 발행된 영수증은 10건까지 가능합니다.</li>
        <li>동일한 영수증은 1회 적립되며, 1일 최대 3개의 영수증까지 적립 가능합니다.</li>
        <li>일부 상품은 적립 대상에서 제외되며 등급 산정을 위한 구매금액에는 포함됩니다.</li>
        <li>통합포인트 적립제외 품목: 행사상품, 디지털상품, 카페자우, 할인쿠폰, 포장봉투 등 (단, 회원등급 산정을 위한 구매금액에는 포함됨)</li>
    </ul>

    <div class="save_point">
        <div class="inner">
            <div class="f_left">
                <h4 class="tit01">통합포인트 적립</h4>
                <p class="stxt">${user.name} 고객님의 현재 보유 통합포인트는 <strong><fmt:formatNumber value="${totalPointAmt}" pattern="#,###"/></strong>원입니다.</p>
                <form id="offPoint" name="offPoint" style="padding-top:20px;">
                    <table class="table01 mgt15">
                        <caption>통합포인트 적립</caption>
                        <colgroup>
                            <col width="170" />
                            <col width="*" />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th scope="row" class="t_right">영수증 바코드 번호</th>
                                <td><input name="textfield" type="text" class="input_txt inputNumberText" id="tit" style="width:150px;" /></td>
                            </tr>
                            <tr>
                                <th scope="row" class="t_right">구매금액</th>
                                <td>
                                    <span class="f_left"><input name="textfield2" type="text" class="input_txt inputNumberText" id="tit" style="width:150px;" /> 원</span>
                                    <span class="f_right"><a href="javascript://" onclick="offSavePoint()" class="btn_type01" style="width:50px;">확인</a></span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </div>
            <div class="f_right"><img src="${imageServer}/images/renewal/content/img_bill.gif" alt=""/></div>
        </div>
    </div>

    <h4 class="txt_tip mgt30">통합포인트 적립방법</h4>
    <p class="stxt_tip">핫트랙스 온/오프라인은 물론 교보문고 온/오프라인에서도 제품 구매시 10원단위부터 사용 가능 (일부 서비스 사용 제외)</p>
</div>
<!-- //sub contents -->
</body>
</html>