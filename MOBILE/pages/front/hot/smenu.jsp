<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<h5 class="cate${category.ctgrId}">${category.ctgrName}</h5>
<ul>
    <c:choose>
        <c:when test="${category.ctgrId eq '0003'}">
            <li><a href="#" onclick="location.href='${defaultHost}/m/record/category/${category.ctgrId}';return false;"><strong>전체보기</strong></a>
            <c:forEach items="${subCategorys}" var="l" varStatus="st">
                <li><a href="#" onclick="location.href='${defaultHost}/m/record/category/${l.ctgrId}';return false;">${l.ctgrName}</a></li>
            </c:forEach>
        </c:when>
        <c:when test="${category.ctgrId eq '0004'}">
            <li><a href="#" onclick="location.href='${defaultHost}/m/record/category/000401';return false;"><strong>DVD 전체보기</strong></a>
            <c:forEach items="${subCategorys1}" var="l" varStatus="st">
                <li><a href="#" onclick="location.href='${defaultHost}/m/record/category/${l.ctgrId}';return false;">${l.ctgrName}</a></li>
            </c:forEach>
            <li><a href="#" onclick="location.href='${defaultHost}/m/record/category/000400';return false;"><strong>BLU-RAY 전체보기</strong></a>
            <c:forEach items="${subCategorys2}" var="l" varStatus="st">
                <li><a href="#" onclick="location.href='${defaultHost}/m/record/category/${l.ctgrId}';return false;">${l.ctgrName}</a></li>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <li><a href="#" onclick="location.href='${defaultHost}/m/gift/category/${category.ctgrId}';return false;"><strong>전체보기</strong></a>
            <c:forEach items="${subCategorys}" var="l" varStatus="st">
                <li><a href="#" onclick="location.href='${defaultHost}/m/gift/category/${l.ctgrId}';return false;">${l.ctgrName}</a></li>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</ul>
<a href="#" onclick="tglSmneu('${category.ctgrId}');return false;" class="btn_cls">닫기</a>