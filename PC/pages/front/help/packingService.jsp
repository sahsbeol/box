<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
    <title>포장서비스 | 서비스안내 | 고객센터 - HOTTRACKS</title>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_cs_center.gif" alt="CS Center"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>포장서비스</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/help/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_packing_service.gif" alt="포장서비스" /></h3>
    <ul class="list_type02">
        <li>고급필기구 구매 시, 선물 포장을 원하실 경우 주문서에 메모를 남겨주시면</li>
        <li>무료로 선물 포장 서비스를 해드립니다. (카드리지, 병잉크 등 악세서리는 제외)</li>
    </ul>

    <div class="box_gray03 mgt40 pd20">
        <p class="txt_tip">고급필기구 브랜드별 선물 포장은 아래 이미지를 참조하세요.<br /><span class="stxt">(포장 이미지는 실제와 다소 차이가 있을 수 있습니다.)</span></p>
    </div>

    <ul class="sv_packing">
        <li><img src="${imageServer}/images/renewal/content/packing01.gif" alt="PARKER" /></li>
        <li><img src="${imageServer}/images/renewal/content/packing02.gif" alt="WATERMAN" /></li>
        <li><img src="${imageServer}/images/renewal/content/packing03.gif" alt="CROSS" /></li>
        <li><img src="${imageServer}/images/renewal/content/packing04.gif" alt="SHEAFFER" /></li>
        <li><img src="${imageServer}/images/renewal/content/packing05.gif" alt="Pelikan" /></li>
        <li><img src="${imageServer}/images/renewal/content/packing06.gif" alt="FABER-CASTELL" /></li>
        <li><img src="${imageServer}/images/renewal/content/packing07.gif" alt="GRAF VON FABER-CASTELL" /></li>
        <li><img src="${imageServer}/images/renewal/content/packing08.gif" alt="ONLINE" /></li>
        <li><img src="${imageServer}/images/renewal/content/packing09.gif" alt="AURORA" /></li>
    </ul>
</div>
<!-- //sub contents -->
</body>
</html>