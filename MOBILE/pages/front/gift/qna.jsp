<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<h2 class="hid_obj">Q&amp;A</h2>
<div class="btn_area box_flex pd0_20">
    <c:if test="${c.dlvyVndrId eq 'G'}">
    <a href="javascript:addQnaGroup('${c.sellPrdtBcode}', '${c.rcrdCd}','${c.brandId}');" class="bt_mbgb"><span class="review_write">상품 Q&amp;A 쓰기</span></a>
    </c:if>
    <c:if test="${c.dlvyVndrId ne 'G'}">
    <a href="javascript:addQna('${c.sellPrdtBcode}', '${c.rcrdCd}');" class="bt_mbgb"><span class="review_write">상품 Q&amp;A 쓰기</span></a>
    </c:if>
</div>
<ul class="accordion review accordion_q">
    <c:if test="${empty review}"><li class="pd10 t_c"><span class="f14">해당 상품 Q&amp;A가 존재하지 않습니다.</span></li></c:if>
    <c:forEach items="${review}" var="l" varStatus="st">
        <li>
            <a href="javascript://">
                <span class="tit">${l.prdtQnaTitle}</span>
                <span class="writer">
                    <fmt:formatDate pattern="yyyy.MM.dd" value="${l.askRegstDtm}"/> / <ui:idAsterisk value="${l.userId}"/>
                </span>
            </a>
            <div class="cont">
                 <p>${hfn:lineToBr(l.prdtAskCont)}</p>
                 <c:choose>
                     <c:when test="${l.aswrYn}">
                         <p style="border-top:1px dashed #dbdbdb;border-bottom:1px dashed #dbdbdb;padding:5px 0;margin:5px 0;color:#da2128;font-weight:bold;">질문에 대한 답변입니다.</p>
                         <p>${hfn:lineToBr(l.prdtAswrCont)}</p>
                     </c:when>
                     <c:otherwise>
                         <p style="border-top:1px dashed #dbdbdb;border-bottom:1px dashed #dbdbdb;padding:5px 0;margin:5px 0;color:#da2128;font-weight:bold;">답변준비 중 입니다.</p>
                     </c:otherwise>
                 </c:choose>
            </div>
        </li>
    </c:forEach>
</ul>

<!-- paging -->
<div class="paging">
    <ui:paginationScript name="pageHolder" scriptName="goQnaList" parameters="sellPrdtBcode"/>
</div>
<!-- //paging -->
<script type="text/javascript">
<!--
$('.accordion_q > li > a').click(function(){
    if($(this).hasClass("on")){
        $(this).removeClass('on');
    }else{
        $('.accordion_q > li a').removeClass('on');
        $(this).addClass('on');
    }
});

$("#detail_tab03").html('상품Q&ampA<span class="font_t col_salmon ml5">(<fmt:formatNumber type="number">${pageHolder.totalRows}</fmt:formatNumber>)</span>');
//-->
</script>
