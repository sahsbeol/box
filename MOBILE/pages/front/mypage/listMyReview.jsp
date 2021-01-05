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
    $("#wrap").addClass("mypage_v1");
    $("#locReview").addClass("active");
});

function goList(page){
    location.replace("?page="+page);
}
</script>
</head>
<body>
<input type="hidden" name="eof" value="1"/>
<div class="customer mt17">
    <div class="gray_box2 pt5">
        <div class="tab_box">
            <a href="/m/mypage/listTargetReview">상품평 쓰기 (<fmt:formatNumber value="${cntTargetReview}" type="number"/>)</a>
            <a href="/m/mypage/listMyReview" class="active">내 상품평(<fmt:formatNumber value="${cntMyReview}" type="number"/>)</a>
        </div>
        <hr class="hr_01"/>
    </div>
    <p class="noti">총 <em class="col_orange"><fmt:formatNumber value="${cntMyReview}" type="number"/></em>건의 상품평이 등록되었습니다.</p>
    <div class="bbs_box02">
        <ul>
            <c:forEach items="${list}" var="l" varStatus="st">
                <li>
                    <dl class="tit">
                        <dt><a href="/p/${l.barcode}"><span>${l.brandName}</span>${l.productName}</a></dt>
                        <dd><fmt:formatDate value="${l.registerDate}" pattern="yyyy.MM.dd"/></dd>
                    </dl>
                    <div class="cont">
                        <c:if test="${not empty l.imageUrl}"><p class="img"><ui:image src="${l.imageUrl}"/></p></c:if>
                        ${l.title}
                    </div>
                    <div class="btn_box"> 
                        <c:choose>
                            <c:when test="${l.commentGbn eq 'M' }"> <!--  record -->
                                <a href="/m/gift/detail/reviewForm?rcrdReviewSeq=${l.rcrdReviewSeq}&rtnGbn=M" class="btn_edit">수정</a>
                                <a href="/m/gift/detail/removeReview?rcrdReviewSeq=${l.rcrdReviewSeq}&rtnGbn=M" class="btn_del">삭제</a>
                            </c:when>
                            <c:otherwise>
                                <a href="/m/gift/detail/removeReview?prdtQnaSeq=${l.seq}&rtnGbn=M" class="btn_del">삭제</a>
                                <a href="/m/gift/detail/reviewForm?prdtQnaSeq=${l.seq}&rtnGbn=M" class="btn_edit">수정</a>
                            </c:otherwise>
                            
                        </c:choose>
                        
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
    
    <!-- paging -->
    <div class="paging mb30">
        <ui:paginationScript name="pageHolder" scriptName="goList"/>
    </div>
    <!-- //paging -->
</div>
</body>
</html>
