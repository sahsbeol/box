<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<div class="mt10 pd10" id="evnetBannerArea" style="">
<!--     <a href="/m/biz/eventDetail?eventId=67359">
        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/20200414/2020041467359750.jpg" alt="ban_event" style="width: 100%;">
    </a>
    <a href="/m/biz/eventDetail?eventId=67719">
        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/20200429/2020042967719750.jpg" alt="ban_event" style="width: 100%;">
    </a> -->
    
    <%-- <fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyyMMdd" var="currentDate" />
	<c:if test="${currentDate le 20200831}">
		<a href="/m/biz/eventDetail?eventId=68863">
		   <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/20200729/2020072968863750.jpg" alt="ban_event" style="width: 100%;">
		</a>
	</c:if>
	<c:if test="${currentDate ge 20200804 and currentDate le 20200811}">
		<a href="/m/biz/eventDetail?eventId=69310">
		   <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/20200803/2020080369310750.jpg" alt="ban_event" style="width: 100%;">
		</a>
	</c:if> --%>
	<c:forEach items="${orderCompleteBnrList}" var="l" varStatus="st">
        <a href="${l.bnrLinkUrl}" >
			<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.imageUrlMo}" onerror="this.src='http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif';" style="width: 100%;">
		</a>
	</c:forEach>
</div>
