<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="detail"/>
<html>
<head>
<script type="text/javascript" src="/scripts/mypage.js"></script>
</head>
<body>
<div class="page-location">
    <p>현재 페이지 위치</p>
    <ul>
        <li><a href="#">GIFT쇼핑</a> <span>&gt;</span></li>
        <li><strong>공지사항</strong></li>
    </ul>
</div><!-- end page-location -->
<div class="product-detail">
    <div class="detail-content">
        <a href="/ht/detail/sample">detail</a><br/>
        <a href="/ht/hot/sample">hot</a><br/>
        <a href="/ht/gift/sample">gift</a><br/>
        <a href="/ht/help/sample">help</a><br/>
        <a href="/ht/mypage/sample">mypage</a><br/>
        <input type="button" value="찜테스트[상품]" onclick="addWishProduct('2300000619928','3705001')"/><br/> 
        <input type="button" value="찜테스트[브랜드]" onclick="addWishBrand('10009')"/><br/>
        <img src="${imageServer}/images/common/h3_item_view.gif"/>
    </div>
</div>
</body>
</html>