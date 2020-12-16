<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<!-- snb_n_music -->  
<div class="snb_n_music">
    <ul>
        <c:forEach items="${categoryListLeft}" var="l" varStatus="s">
            <li class="left_sub_menu ${fn:startsWith(category.cateId, l.cateId)?'on':''}" 
               <c:if test="">class="on"</c:if>
            >
                <span><a href="/ht/record/category/${l.cateId}">${l.cateName}</a></span>
                <c:if test="${not empty l.childCategoryList}">
                    <ul class="left_sub_menu_${l.cateId}">
                        <c:forEach items="${l.childCategoryList}" var="ls" varStatus="ss">
                            <li <c:if test="${ss.index eq 0}">class="first-child"</c:if>><a href="/ht/record/category/${ls.cateId}">${ls.cateName}</a></li>
                        </c:forEach> 
                    </ul>
                </c:if>
            </li>
        </c:forEach>
    </ul>
</div>
<!-- //snb_n_music -->  