<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript">
jQuery(function($){
    $("#wrap").removeClass("mini");
    $("#locBest").addClass("active");
    
    $("img.lazy").lazyload({placeholder:'/images/no_image2.gif',effect : "fadeIn"});
    $('#best_type_item').val('${c.ctgrId}');
});

function goList(page){
    location.href="/m/hot/best?dispMstrId="+$('#best_type').val()+"&ctgrId="+$('#best_type_item').val()+"&page="+page;
}
</script>
<style>
#content {
	padding:0px;
}
#content .box_flex.t_select{
    width: 95%;
    padding: 2%;
    margin-left: 11px;
    margin-top: 5px;
    background-color: rgba(255,255,255,0.9);
}
#content .box_flex select {
	background: #fff url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/common/bg_select.png) no-repeat 92% 55%;
}
#content .prod_box {
	padding-top:50px;
}
.customer .gray_box2{
	margin:0px;
	padding-bottom:2px;
}
</style>
</head>
<body>
<input type="hidden" id="best_type" value="${c.dispMstrId}">

<!-- 정렬 -->
<div class="customer mt17">
	<div class="gray_box2 pt5">
		<div class="tab_box">
 			<a href="/m/hot/best?dispMstrId=CATE_GFT_BEST" <c:if test="${c.dispMstrId eq 'CATE_GFT_BEST'}"> class="active"</c:if>>카테고리별</a>
			<a href="/m/hot/best?dispMstrId=CART_BEST&ctgrId=1" <c:if test="${c.dispMstrId eq 'CART_BEST'}"> class="active"</c:if>>장바구니</a>
			<a href="/m/hot/best?dispMstrId=FREE_DELIVERY_BEST&ctgrId=1" <c:if test="${c.dispMstrId eq 'FREE_DELIVERY_BEST'}"> class="active"</c:if>>무료배송</a>
		</div>
	</div>
</div>
<c:choose>
    <c:when test="${c.dispMstrId eq 'CATE_GFT_BEST'}">
    	<select class="box_flex t_select" id="best_type_item" onchange="javascript:goList('1')">
	    	<option value="0000">전체 카테고리</option>
			<option value="000020">디자인문구</option>
			<option value="000022">디지털</option>
			<option value="000007">고급필기구</option>
			<option value="000021">오피스</option>
			<option value="000025">리빙/생활가전</option>
			<option value="000026">키친/푸드</option>
			<option value="000024">가구/수납</option>
			<option value="000028">패션잡화</option>
			<option value="000006">뷰티/헬스</option>
			<option value="000027">여행/자동차</option>
			<option value="000023">취미/펫</option>
			<option value="000029">유아동</option>
		</select>
    </c:when>
    <c:when test="${c.dispMstrId eq 'FREE_DELIVERY_BEST'}">
		<select class="box_flex t_select" id="best_type_item" onchange="javascript:goList('1')">
	    	<option value="1">1만원 이하</option>
			<option value="2">2만원 이하</option>
			<option value="3">3만원 이하</option>
		</select>
    </c:when>
</c:choose>

<!-- //정렬 -->

<!-- prod -->
<c:import url="/pages/front/hot/layerBestProduct.jsp" charEncoding="UTF-8">
    <c:param name="best" value="Y"/>
    <c:param name="lazy" value="Y"/>
</c:import>
<!-- //prod -->


<!-- paging -->
<div class="paging mb30">
    <ui:paginationScript name="pageHolder" scriptName="goList"/>
</div>
<!-- //paging -->
</body>
</html>