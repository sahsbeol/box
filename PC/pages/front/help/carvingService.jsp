<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
    <title>각인서비스 | 서비스안내 | 고객센터 - HOTTRACKS</title>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_cs_center.gif" alt="CS Center"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>각인 서비스</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/help/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_carving_service.gif" alt="각인 서비스" /></h3>
    <ul class="list_type02">
        <li>고급필기구 단품가 2만원 이상 구매하시는 모든 분께는 각인을 무료로 제작해 드립니다.</li>
        <li>(단, 제품 특성 및 브랜드별로 각인이 되지 않는 경우도 있습니다.)</li>
        <li>고급필기구 단품가 2만원 미만 구매 시 유료 각인비는 5,000원 입니다.</li>
    </ul>

    <div class="box_gray03 mgt40 pd20">
        <p class="txt_tip">글자체별 디자인은 아래를 참고하셔서 주문 시 정확하게 입력해 주시기 바랍니다.<br /><span class="stxt">예시: 영문 풀네임 각인 – Hong Kil Dong (필기체)</span></p>
    </div>

    <div class="sv_carving">
        <div class="f_left">
            <h4 class="stit"><img src="${imageServer}/images/renewal/common/stit_carving_service01.gif" alt="영문서체" /></h4>
            <div class="con">
                <ul class="hidden_obj">
                    <li>Hong Kil Dong 필기체</li>
                    <li>Hong Kil Dong Fiolex girls</li>
                    <li>Hong Kil Dong 모노라임 크로스바</li>
                    <li>Hong Kil Dong 바탕체</li>
                    <li>Hong Kil Dong 고딕사체</li>
                    <li>Hong Kil Dong 고딕체</li>
                    <li>Hong Kil Dong 로마체</li>
                    <li>Hong Kil Dong 슬로건ocp</li>
                    <li>K.D Hong 필기체</li>
                    <li>K.D Hong Fiolex girls</li>
                    <li>K.D Hong 모노라임 크로스바</li>
                    <li>K.D Hong 바탕체</li>
                    <li>K.D Hong 고딕사체</li>
                    <li>K.D Hong 고딕체</li>
                    <li>K.D Hong 로마체</li>
                    <li>K.D Hong 슬로건ocp</li>
                </ul>
            </div>
        </div>
        <div class="f_right">
            <h4 class="stit"><img src="${imageServer}/images/renewal/common/stit_carving_service02.gif" alt="한글/한문서체" /></h4>
            <div class="con">
                <ul class="hidden_obj">
                    <li>홍길동 바탕체</li>
                    <li>홍길동 필기체</li>
                    <li>홍길동 휴면옛체</li>
                    <li>홍길동 고딕체</li>
                    <li>홍길동 해서체</li>
                    <li>홍길동 양제난초체</li>
                    <li>홍길동 펜흘림</li>
                    <li>홍길동 다운필기</li>
                    <li>홍길동 고딕체</li>
                    <li>홍길동 휴면옛체</li>
                    <li>홍길동 바탕체</li>
                    <li>홍길동 한양해서체</li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!-- //sub contents -->
</body>
</html>