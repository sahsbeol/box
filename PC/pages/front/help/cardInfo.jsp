<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>제휴/할인카드 | 서비스안내 | 고객센터 - HOTTRACKS</title>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_cs_center.gif" alt="CS Center"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>제휴/할인카드</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/help/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    <div class="cardinfo_wrap">
        <h3 class="page_title"><img src="${imageServer}/images/renewal/common/tit_card_info.gif" alt="제휴/할인카드" /></h3>
        <ul class="list_type02">
            <li>핫트랙스의 또 다른 혜택</li>
            <li>추가적립 &amp; 할인과 다양한 무이자 할부 혜택!</li>
            <li>핫트랙스 온라인몰의 제휴/할인 카드 혜택으로 저렴하게 구매하세요.</li>
        </ul>
        <h4 class="tit01">교보문고 핫트랙스 롯데카드</h4>
        <table class="table03">
            <caption>교보문고 핫트랙스 롯데카드</caption>
            <colgroup>
                <col width="33%" />
                <col width="*" />
                <col width="33%" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col">전월청구서상 해당카드</th>
                    <th scope="col">할인율</th>
                    <th scope="col">월할인한도 (대상가맹점통합한도)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>30만원 이상</td>
                    <td>10%</td>
                    <td>1만원</td>
                </tr>
                <tr>
                    <td>60만원 이상</td>
                    <td>25%</td>
                    <td>2만원</td>
                </tr>
            </tbody>
        </table>
        <div class="box_gray03">
            <h5 class="txt_tip">단 2만원 이상 결제시</h5>
            <ul class="list_type02 mgt20">
                <li>가) 할인대상 매출금액은 전월청구서상 이용금액 제외 </li>
                <li>나) 할인대상 가맹점 : 교보문고/핫트랙스 온라인/오프라인 전매장<br />예) 전월카드사용실적이 60만원이상일 경우 교보문고/핫트랙스 온/오프 매장 구매실적의 25%할인(최대할인한도 2만원)</li>
            </ul>
            <div class="img_card"><img src="${imageServer}/images/renewal/content/img_card.gif" alt="" /></div>
        </div>
        <div class="btn_area t_center mgt35">
            <a href="http://www.lottecard.co.kr/app/view/if/gate.jsp?b_id=11129_11195_11443&vt_cd_knd_c=P02528-A02528" target="_lotte1" class="btn_type07">일반 신청</a>
            <a href="http://www.lottecard.co.kr/app/view/if/gate.jsp?b_id=11130_11196_11444&vt_cd_knd_c=P02529-A02529" target="_lotte2" class="btn_type07">바로DC 신청</a>
        </div>
    </div>
</div>
<!-- //sub contents -->
</body>
</html>
