<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<html>
<head>
</head>
<body>
<div class="page-location">
    <p>현재 페이지 위치</p>
	<ul>
		<li><a href="/ht/mypage/main">MY HOTTRACKS</a> <span>&gt;</span></li>
		<li><strong>찜하기 내역</strong></li>
    </ul>
</div><!-- end page-location -->
<div class="my-room-sub">
	<h3><img src="${imageServer}/images/myhottracks/h3_main_title11.gif" alt="찜하기 내역 보기" /></h3>
	<p class="heading-explains">
		최근 6개월간 저장하신 찜브랜드 리스트입니다.<br>
		6개월 이전 저장하신 찜브랜드 및 거래종료 브랜드는 자동삭제됩니다.<br>
		리스트의 브랜드 삭제 및 변경 등의 관리로 보다 편리하게 이용 하실 수 있습니다.
	</p>
    <div id="products" class="interest-tab">
        <ul class="menu">
	        <li id="liProduct"><a href="/ht/mypage/listWishProduct">상품<strong>${wishProductCount}건</strong></a><span>|</span></li>
            <li id="liBrand" class="selected"><a href="/ht/mypage/listWishBrand">브랜드<strong>${wishBrandCount}건</strong></a></li>
        </ul>  
        <div class="product-list04">
			<ul>
			    <c:forEach items="${wishBrands}" var="wishBrand" varStatus="status">
				<li>
					<p class="brand-mark"><a href="/ht/hot/detailBrand?brandId=${wishBrand.brandId}"><ui:image src="${wishBrand.brandImageUrl}"  width="177" height="100" server="brand"/></a></p>
					<p class="brand-text">${wishBrand.brandEngName} <span>|</span> ${wishBrand.brandKorName}</p>
					<p class="choose-day"><fmt:formatDate value="${wishBrand.registDatetime}" pattern="yyyy.MM.dd"/></p>
				</li>
				</c:forEach>
			</ul>
		</div><!--end brand-list01  -->  
        <div class="pager">
            <ui:pagination name="pageHolder" url="/ht/mypage/listWishBrand" parameters=""/>                                         
        </div><!-- end pager -->
    </div><!-- end interest-tab -->    
</div><!-- end my-room-sub -->
</body>