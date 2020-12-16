<%@ page contentType="text/html;charset=utf-8" language="java" %>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>

<!-- 데코레이터에 있는 #container 요소에 클래스를 추가하기 위해 -->
<meta name="container" content="product"/>

<script type="text/javascript">
	$(document).ready(function(){
		//메뉴 선택 클래스 추가
		$("#gnbFree").addClass("on");
	});
</script>

<p class='bg_goods ship'>배경색</p>
<div class="goods_wrap category_wrap">
	<h2>무료배송</h2>
	<ul class='list_price clear'>
		<!-- 해당 금액에 on : class 추가 -->
		<li><a href="/ht/biz/welcome/hotFreeDeliveryPage?ctgrId=1"<c:if test="${empty c.ctgrId or c.ctgrId eq '1'}"> class="on"</c:if>>~ 1만원</a></li>
		<li><a href="/ht/biz/welcome/hotFreeDeliveryPage?ctgrId=2"<c:if test="${c.ctgrId eq '2'}"> class="on"</c:if>>~ 2만원</a></li>
		<li><a href="/ht/biz/welcome/hotFreeDeliveryPage?ctgrId=3"<c:if test="${c.ctgrId eq '3'}"> class="on"</c:if>>~ 3만원</a></li>
	</ul>
	<div class="choice_price"></div>
	
	<!-- 상품 (베스트만 best : class 추가) -->
	<div class="lower_content">	
		<div class="pd_list">		
			<ul id="dataList">
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