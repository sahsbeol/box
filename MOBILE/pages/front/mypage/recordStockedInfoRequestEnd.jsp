<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="layer" />
<html>
<head>
<style type="text/css">
.recordForm{
    background-color: #fff;
    border: 1px solid #aaa;
    margin-left : 10px;
    margin-right : 10px;
    padding-bottom : 15px;
    display: block;
    margin-top : 30%;
    z-index: 1;
}
#alarmLayer{
    position: fixed;
    left:0;
    top: 0;
    width: 100%;
    height: 100%;
    z-index: 998;
    background: url(/images/season01/bg_layer01.png);
}
.title h1{ 
    background-color: #fd6f1b; 
    height : 40px;
    padding-top :10px;
    text-align: center;
    color: #fff;
}
.title #close_btn{
    margin-top : -38px;
    width : 30px;
    height : 30px;
    float: right;
    margin-right : 10px;
}
.btn_orange_2 {
    width : 100px;
    height : 36px;
    text-align: center;
    margin-left :2px; 
    float : center;
    padding-left : 30%;
    background-color : #fd6f1b;
}
div.line{   
    margin-top : 10px;
    margin-bottom : 50px;
    width : auto;
    border: 0.1px solid #eee;
    margin-left: 10px;
    margin-right: 10px;
}
p.point05{
    text-align: center;
    margin-top : 10px;
    font-size: 1.1em;
    color : #909090;
}
div.box_complate{
    margin-top: 50px;
    margin-bottom: 50px;
}
a.btn {
    text-align: center;
    padding-left: 0;
}
</style>
<script type="text/javascript">

</script>
</head>
<body>
<div id="alarmLayer">
    <div style="background-color: #fff;" class="recordForm">
        <div class="title">
            <h1>알림예약 등록</h1>
            <div align="right"><a href="javascript://" onclick="closeGiftStockedInfoRequest()"><img src="${imageServer }/images/mobile/common/close_white.png" id="close_btn"/></a></div>
        </div>
        <div class="pop_cont">
            <div class="box_complate">
                <p class="mgt20 fs11 line18 point05">알림예약등록이 완료 되었습니다.</p>
                <p class="mgt20 fs11 line18 point05">해당상품이 구매가 가능할 경우,</p>
                <p class="mgt20 fs11 line18 point05">회원님이 선택하신 정보로 안내됩니다.</p>
                <p class="mgt20 fs11 line18 point05">감사합니다.</p>
            </div>
        </div>
        <div class="line"></div>
        <div class="pop_close" style="text-align: center;">
            <a href="javascript://" onclick="closeGiftStockedInfoRequest()" class="btn btn_orange_2">닫기</a>
        </div>
    </div>
</div>
</body>
</html>