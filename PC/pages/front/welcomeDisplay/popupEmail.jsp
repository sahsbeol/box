<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="popup"/>
<html>
<head>
<title>이메일 무단 수집거부 - NEW ME HOTTRACKS</title>
</head>
<body class="popup" style="width:400px;">
<h1><img src="${imageServer}/images/renewal/common/tit_pop_email.gif" alt="이메일 무단 수집거부" /></h1>
<div class="pop_cont">
    <ul class="list_type02">
        <li>교보핫트랙스는 이용자들의 이메일 무단 수집을 거부합니다!</li>
    </ul>
    <div class="info_box">
        <div class="incont">
            <p>웹사이트에 포함 및 게시된 이메일 주소가 전자우편 주소 수집 프로그램이나 그 밖의 기술적 장치를 이용하여 무단으로 수집되는 것을 거부하며, 이를 위반할 경우 정보통신망이용촉진및정보보호등에관한법률 제50조의2(전자우편주소의 무단 수집행위 등 금지)와 제74조(벌칙)에 따라 1년 이하의 징역 또는 1천만원 이하의 벌금에 처해질 수 있습니다.</p>
        </div>
    </div>
    <div class="btn_area t_center mgt20">
        <a href="javascript://" class="btn_type01" style="width:70px" onclick="window.print();">프린트하기</a>
    </div>
</div>
<div class="pop_close">
    <a href="javascript://" onclick="self.close();">닫기</a>
</div>
</body>
</html>