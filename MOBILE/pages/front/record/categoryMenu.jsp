<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<style type="text/css">
.conts-cate { background-color: #f5f6f1;margin: 26px -10px 0;padding: 8px; }
.conts-cate .inner {background-color:#f5f6f1;}
.conts-cate .inner li {padding:0 10px;}
.conts-cate .inner li a {display:block;padding:13px 8px;font-weight:bold;color:#2b2b2b;border-bottom:1px solid #ccc}
</style>
<div class="conts-cate">
    <ul class="inner">
        <c:if test="${fn:startsWith(c.ctgrId, '0003')}">
            <li><a href="/m/record/best/0003">베스트 상품 보기</a></li>
            <li><a href="/m/record/category/0003">전체 상품 보기</a></li>
        </c:if>
        <c:if test="${fn:startsWith(c.ctgrId, '0004')}">
            <li><a href="/m/record/best/${fn:substring(c.ctgrId, 0, 6)}">베스트 상품 보기</a></li>
            <li><a href="/m/record/category/${fn:substring(c.ctgrId, 0, 6)}">전체 상품 보기</a></li>
        </c:if>
        <c:forEach items="${childCategory}" var="l" varStatus="st">
            <li><a href="/m/record/category/${l.ctgrId}">${l.ctgrName}</a></li>
        </c:forEach>
    </ul>
</div>
