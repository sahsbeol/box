<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="none"/>

<!-- 탑 텍스트 배너 -->
<c:if test="${not empty curtainTopBnr}">
    <div class="top_txtbnr">
       <ul class="inner">
       	<c:set var="urlLink" value="${defaultHost}"/>
       	<c:forEach items="${curtainTopBnr}" var="top" begin="0" end="3">
       	   <li><a href="${urlLink}${top.bnrLnkUrl}">${top.bnrTitle}</a></li>
        </c:forEach>
       </ul>
    </div>
</c:if>
<c:if test="${not empty curtainBnr}">
	<!-- 커튼 배너 -->
	<div class="top_banner PC_MAIN_TOP_1" style="background-color:#7e68ff;">
		<div class="inner">
			<!-- 영역 -->
				${curtainBnr.bnrCont}				
			<!--// 영역 -->
		</div>
	</div>
</c:if>