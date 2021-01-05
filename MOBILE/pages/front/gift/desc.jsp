<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<c:if test="${param.sngl eq 'Y'}">
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=2.0">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:300,400,700&display=swap&subset=korean">
</head>
<body>
</c:if>
<style>
body {margin:0px; padding:0px;}
.product-detail {display:block;width:100%;overflow:hidden;font-family:'Noto Sans KR', AppleGothic, sans-serif;}
.product-detail .header {position: fixed;left: 0;top: 0;width: 100%;background: #fff;z-index: 900;text-align: center;display:none;height: 60px;border-bottom: 1px solid #dbdbdb;padding: 10px 0;box-sizing: border-box;}
.product-detail.more .header { display:block; } 
.product-detail .header h2 {padding: 10px 0;margin: 0 auto;line-height:1.4rem;font-size: 20px;font-weight: 700;color: #000;vertical-align: middle;letter-spacing: -0.1px;} 
.product-detail .header .btn_cls {
    position: absolute;
    right: 15px;
    top: 15px;
    width: 34px;
    height: 34px;
    overflow: hidden;
    text-indent: -9999px;
    font-size: 0;
    background: url('https://simage.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/btn_close_layer.png') 50% 50% no-repeat;
    background-size: 15px;
}
.product-detail.active { height:auto; }
.product-detail img { max-width:100%; }
.product-detail table { max-width:100%; }
.product-detail.more .detail-cont {margin-top:60px; font-size:14px;}
</style>
<div class="product-detail<c:if test="${param.sngl eq 'Y'}"> more</c:if>">
<div class="header">
    <h2>상품 상세보기</h2>
    <a class="btn_cls" onclick="history.back(); return false;">닫기</a>
</div>
<div class="detail-cont">
${desc}
</div>
</div>
<c:if test="${param.sngl eq 'Y'}">
</body>
</html>
</c:if>