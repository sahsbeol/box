<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>

     <!-- snb_n_music -->  
     <div class="snb_n_dvd">
         <ul>
             <li class="title"><img src="${imageServer}/images/dvd/snb_title_01.gif" alt="BLU-RAY" /></li>
             <c:forEach items="${categoryListLeft1}" var="l" varStatus="s">
                 <li 
                    <c:if test="${category.cateId eq l.cateId}">class="on"</c:if>
                 >
                     <span><a href="./${l.cateId}?<ui:param />">${l.cateName}</a></span>
                     
                 </li>
             </c:forEach>

             <li class="title02"><img src="${imageServer}/images/dvd/snb_title_02.gif" alt="DVD" /></li>
             <c:forEach items="${categoryListLeft2}" var="l" varStatus="s">
                 <li 
                    <c:if test="${category.cateId eq l.cateId}">class="on"</c:if>
                 >
                     <span><a href="./${l.cateId}?<ui:param skip='${leftSkipParam}' />">${l.cateName}</a></span>
                     
                 </li>
             </c:forEach>
         </ul>
     </div>
     <!-- //snb_n_music -->  