<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>

<h2 class="hid_obj">상품후기</h2>
<div class="btn_area box_flex pd0_20">
<!-- 체험단이면서 체험상품이 아니거나, 체험단이 아닌경우 -->
    <c:choose>
        <c:when test="${isEmpBar eq true && isEmpYn eq true}">
            <a class="bt_mbgb"><span class="review_write" onclick="javascript:addReviewTest('${c.sellPrdtBcode}', '${c.rcrdCd}');">상세 후기 쓰기</span></a>
        </c:when>
        <c:when test="${empty isEmpYn }">
            <a class="bt_mbgb"><span class="review_write" onclick="javascript:addReview('${c.sellPrdtBcode}', '${c.rcrdCd}');">상세 후기 쓰기</span></a>
        </c:when>
        <c:otherwise>
            <a class="bt_mbgb"><span class="review_write" onclick="javascript:addReview('${c.sellPrdtBcode}', '${c.rcrdCd}');">상세 후기 쓰기</span></a>
        </c:otherwise>
    </c:choose>
</div>
<ul class="accordion review accordion_r">
    <c:if test="${empty review}"><li class="pd10 t_c"><span class="f14">해당 상품 후기가 존재하지 않습니다.</span></li></c:if>
    <c:forEach items="${review}" var="l" varStatus="st">
        <li>
            <a href="javascript://">
                <span class="tit" style="border:0;">${l.prdtQnaTitle}</span>
                <span class="writer">
                    <fmt:formatDate pattern="yyyy.MM.dd" value="${l.askRegstDtm}"/> / <ui:idAsterisk value="${l.userId}"/>
                </span>
            </a>
            <div class="cont">
                <div class="grade_star">
                    <span class="st_on" style="width:${l.prdtGrade/5*100}%;"></span>
                </div>
                <c:if test="${not empty user && user.userNum eq l.askRegstUserNum}">
                    <div class="btn_box">
<!--                         <span style="float:right;"> -->
                        <a href="/m/gift/detail/reviewForm?prdtQnaSeq=${l.prdtQnaSeq}&rcrdReviewSeq=${l.rcrdReviewSeq}&rtnGbn=P&sellPrdtBcode=${c.sellPrdtBcode}" class="btn_edit">수정</a></span>
<!--                         <span style="float:right;"> -->
                        <a href="/m/gift/detail/removeReview?prdtQnaSeq=${l.prdtQnaSeq}&rcrdReviewSeq=${l.rcrdReviewSeq}&rtnGbn=P&sellPrdtBcode=${c.sellPrdtBcode}" class="btn_del">삭제</a></span>
                    </div>
                </c:if>
                <p>
                    <c:if test="${not empty l.imageUrl}">
                        <ui:image src="${l.imageUrl}"/><br/><br/>
                    </c:if>
                    ${hfn:lineToBr(l.prdtQnaTitle)}
                </p>
            </div>
        </li>
    </c:forEach>
</ul>

<!-- paging -->
<div class="paging">
    <ui:paginationScript name="pageHolder" scriptName="goReviewList" parameters="sellPrdtBcode"/>
</div>
<!-- //paging -->
<script type="text/javascript">
<!--
/* 아코디언 */
$('.accordion_r > li > a').click(function(){
    if($(this).hasClass("on")){
        $(this).removeClass('on');
    }else{
        $('.accordion_r > li a').removeClass('on');
        $(this).addClass('on');
    }
});

$("#detail_tab02").html('상품후기<span class="font_t col_salmon ml5">(<fmt:formatNumber type="number">${pageHolder.totalRows}</fmt:formatNumber>)</span>');


	
$(document).ready(function(){
	if($("#prdtGbn").val() == 'R' || $("#prdtGbn").val() == 'D'){
		$("#reviewBanner").hide();
	}	
});	

//-->
</script>
