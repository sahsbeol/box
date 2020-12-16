<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="popup" />
<html>
<head>
<script type="text/javascript">
$(document).ready(function(){
    window.resizeTo(620, 360);
});
</script>
</head>
<body>
<div style="width:600px;">
<h1><img src="${imageServer}/images/renewal/common/tit_pop_alrim01.gif" alt="알림예약등록완료" /></h1>
<div class="pop_cont">
    <div class="box_complate">
        <strong class="fs14 point03">알림 예약 등록이 완료되었습니다.</strong>
        <p class="mgt20 fs11 line18 point05">해당 상품이 예약 등록되어 구매가 가능 할 경우, 회원니의 이메일 또는 SMS로 알려 드리겠습니다.<br />감사합니다.</p>
    </div>
</div>
<div class="pop_close">
    <a href="javascript://" onclick="self.close()">닫기</a>
</div>
</div>
</body>
</html>