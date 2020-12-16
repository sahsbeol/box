<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!-- 이벤트 배너 -->
<div class="mgt20" id="evnetBannerArea" style="">
<!--     <a href="/ht/biz/eventDetail?eventId=67359">
        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/20200414/2020041467359950.jpg" alt="ban_event">
    </a>
    <a href="/ht/biz/eventDetail?eventId=67719">
        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/20200429/2020042967719950.jpg" alt="ban_event">
    </a> -->
   	<%-- <fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyyMMdd" var="currentDate" />
	<c:if test="${currentDate le 20200831}">
		<a href="/ht/biz/eventDetail?eventId=68863">
		   <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/20200729/2020072968863950.jpg" alt="ban_event">
		</a>
	</c:if>
	<c:if test="${currentDate ge 20200804 and currentDate le 20200811}">
		<a href="/ht/biz/eventDetail?eventId=69310">
		   <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/20200803/2020080369310950.jpg" alt="ban_event">
		</a>
	</c:if> --%>
	<c:forEach items="${orderCompleteBnrList}" var="l" varStatus="st">
        <a href="${l.bnrLinkUrl}" >
			<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.imageUrlPc}" onerror="this.src='http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif';">
		</a>
	</c:forEach>
</div>