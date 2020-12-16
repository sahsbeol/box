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
                 <li 
                    <c:if test="${category.cateId eq l.cateId}">class="on"</c:if>
                 >
                     <span><a href="./${l.cateId}?<ui:param skip='${leftSkipParam}' />">${l.cateName}</a></span>
                 </li>
             </c:forEach>
         </ul>
     </div>
     <!-- //snb_n_music -->