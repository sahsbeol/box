<%@ page contentType="text/html;charset=utf-8" language="java" %>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>

<!-- 데코레이터에 있는 #container 요소에 클래스를 추가하기 위해 -->
<meta name="container" content="product"/>

<script type="text/javascript">
	$(document).ready(function(){
		//메뉴 선택 클래스 추가
		$("#gnbBest").addClass("on");
	});
</script>

<p class='bg_goods best'>배경색</p>
<div class="goods_wrap category_wrap">
	<h2>베스트</h2>
	<ul class='list_category clear'><!-- 활성화시 active : class 추가 -->
		<li><a href="/ht/biz/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=0000"<c:if test="${empty c.ctgrId or c.ctgrId eq '0000'}"> class="active"</c:if>>전체</a></li>
        <li><a href="/ht/biz/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000020"<c:if test="${c.ctgrId eq '000020'}"> class="active"</c:if>>디자인문구</a></li>
        <li><a href="/ht/biz/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000022"<c:if test="${c.ctgrId eq '000022'}"> class="active"</c:if>>디지털</a></li>
        <li><a href="/ht/biz/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000007"<c:if test="${c.ctgrId eq '000007'}"> class="active"</c:if>>고급필기구</a></li>
        <li><a href="/ht/biz/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000021"<c:if test="${c.ctgrId eq '000021'}"> class="active"</c:if>>오피스</a></li>
        <li><a href="/ht/biz/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000025"<c:if test="${c.ctgrId eq '000025'}"> class="active"</c:if>>리빙/생활가전</a></li>
        <li><a href="/ht/biz/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000026"<c:if test="${c.ctgrId eq '000026'}"> class="active"</c:if>>키친/푸드</a></li>
        <li><a href="/ht/biz/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000024"<c:if test="${c.ctgrId eq '000024'}"> class="active"</c:if>>가구/수납</a></li>
        <li><a href="/ht/biz/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000028"<c:if test="${c.ctgrId eq '000028'}"> class="active"</c:if>>패션잡화</a></li>
        <li><a href="/ht/biz/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000006"<c:if test="${c.ctgrId eq '000006'}"> class="active"</c:if>>뷰티/헬스</a></li>
        <li><a href="/ht/biz/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000027"<c:if test="${c.ctgrId eq '000027'}"> class="active"</c:if>>여행/자동차</a></li>
        <li><a href="/ht/biz/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000023"<c:if test="${c.ctgrId eq '000023'}"> class="active"</c:if>>취미/펫</a></li>
        <li><a href="/ht/biz/welcome/hotAwardPage?dispMstrId=${c.dispMstrId}&ctgrId=000029"<c:if test="${c.ctgrId eq '000029'}"> class="active"</c:if>>유아동</a></li>
	</ul>

	<!-- 상품 (베스트만 best : class 추가) -->
	<div class="lower_content">
		<div class="pd_list best">
			<ul>
				<!-- prod -->
				<c:import url="/pages/bizFront/ranking/layerBestProduct.jsp" charEncoding="UTF-8">
				</c:import>
				<!-- //prod -->
			</ul>
		</div>
		<c:import url="/menu/biz/quickMenu"/>
	</div>
	<!--상품 -->
</div>