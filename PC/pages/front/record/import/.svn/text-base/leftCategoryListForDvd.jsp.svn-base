<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>

     <!-- snb_n_music -->  
     <div class="snb_n_dvd">
         <ul>
             <c:forEach items="${categoryListLeft}" var="l" varStatus="s">
                 <li 
                    onmousemove="leftSubmenuShow('${l.cateId}')" 
                    onmouseout="leftSubmenuHide('${l.cateId}')"
                    <c:if test="${fn:length(category.cateId) eq 6 and s.count eq 1}">class="on"</c:if>
                    <c:if test="${fn:length(category.cateId) ne 6 and s.count ne 1 and fn:startsWith(category.cateId, l.cateId)}">class="on"</c:if>
                 >
                    <c:if test="${l.cateId eq '00040010'}">
                        <span><a href="/ht/record/bluray3dList">${l.cateName}</a></span>
                    </c:if>
                    <c:if test="${l.cateId ne '00040010'}">
                        <span><a href="/ht/record/category/${l.cateId}">${l.cateName}</a></span>
                        <c:if test="${not empty l.childCategoryList and fn:length(l.cateId) > 6 and fn:contains('00040008,00040009,00040108,00040109', l.cateId)}">
                            <ul class="left_sub_menu_${l.cateId}">
                                <c:forEach items="${l.childCategoryList}" var="ls" varStatus="ss">
                                    <li <c:if test="${ss.index eq 0}">class="first-child"</c:if>><a href="/ht/record/category/${ls.cateId}">${ls.cateName}</a></li>
                                </c:forEach> 
                            </ul>
                        </c:if>
                    </c:if>
                 </li>
             </c:forEach>
         </ul>
     </div>
     <!-- //snb_n_music -->  