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
    $("#locNew").addClass("active");
    
    $("img.lazy").lazyload({placeholder:'/images/no_image2.gif',effect : "fadeIn"});
});

function goList(page){
    location.href="/m/hot/best?dispMstrId=${c.dispMstrId}&ctgrId=${c.ctgrId}&page="+page;
}
</script>
</head>
<body>
<!-- 정렬 -->
<div class="box_flex t_select" style="margin-top : -11px;">
    <select class="select" title="정렬 순서 선택" onchange="document.location.href='/m/hot/best?dispMstrId=${c.dispMstrId}&ctgrId='+this.value;">
        <option<c:if test="${c.ctgrId eq '0000'}"> selected="selected"</c:if> value="0000">전체 카테고리</option>
        <option<c:if test="${c.ctgrId eq '000020'}"> selected="selected"</c:if> value="000020">디자인문구</option>
        <option<c:if test="${c.ctgrId eq '000022'}"> selected="selected"</c:if> value="000022">디지털</option>
        <option<c:if test="${c.ctgrId eq '000007'}"> selected="selected"</c:if> value="000007">고급필기구</option>
        <option<c:if test="${c.ctgrId eq '000021'}"> selected="selected"</c:if> value="000021">오피스</option>
        <option<c:if test="${c.ctgrId eq '000025'}"> selected="selected"</c:if> value="000025">리빙/생활가전</option>
        <option<c:if test="${c.ctgrId eq '000026'}"> selected="selected"</c:if> value="000026">키친/푸드</option>
        <option<c:if test="${c.ctgrId eq '000024'}"> selected="selected"</c:if> value="000024">가구/수납</option>
        <option<c:if test="${c.ctgrId eq '000028'}"> selected="selected"</c:if> value="000028">패션잡화</option>
        <option<c:if test="${c.ctgrId eq '000006'}"> selected="selected"</c:if> value="000006">뷰티/헬스</option>
        <option<c:if test="${c.ctgrId eq '000027'}"> selected="selected"</c:if> value="000027">여행/자동차</option>
        <option<c:if test="${c.ctgrId eq '000023'}"> selected="selected"</c:if> value="000023">취미/펫</option>
        <option<c:if test="${c.ctgrId eq '000029'}"> selected="selected"</c:if> value="000029">유아동</option>
    </select>
</div>
<!-- //정렬 -->

<!-- prod -->
<c:import url="../template/layerProduct.jsp" charEncoding="UTF-8">
    <c:param name="best" value="N"/>
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