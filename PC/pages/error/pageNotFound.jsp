<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="ht"/>
<html>
<head>
<title>HOTTRACKS - 생활 속 감성충전소</title>
</head>
<body>
<div class="error_wrap">
    <div class="error_box">
        <div class="error_move_a"><img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/bg_errormove.gif"/></div>
        <p class="txt">
            요청하신 페이지는 존재하지 않는 페이지입니다.
        </p>
        <p class="btxt">다시 한번 주소 확인을 부탁드립니다.</p>
    </div>    
    <div class="bt_a">
        <a href="javascript:history.back()" class="bt_backmove">이전</a>
        <a href="/" class="bt_homemove">홈으로</a>
    </div>    
</div>
</body>
</html>