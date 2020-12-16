<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="none"/>
<script type="text/javascript">
		$(".inner950 .tab ul li").click(function(){
			var codeNum = undefined;
		    if ($(this).children("a").attr("href")=="type01") {
		    	codeNum = $("input[name='lastCtgrId']").val()==""?"0000":$("input[name='lastCtgrId']").val();
		    	getEventList("N",codeNum,"type01");
			} else {
				codeNum = $("input[name='lastEventDispTypeCode']").val()==""?"C1532":$("input[name='lastEventDispTypeCode']").val();
				getEventList("N",codeNum,"type02");
				}
		    return false;
		});
	    $(".category_nav_wrap ul li").click(function(){
	    	$("input[name='lastCtgrId']").val($(this).attr("ctgrid"))
	    });
	    $(".type02 .list_tab ul li").click(function(){
	    	$("input[name='lastEventDispTypeCode']").val($(this).attr("newEventDispTypeCode"));
	    });
</script>
<input type="hidden" name="type" value="${c.type}">
<input type="hidden" name="ctgrId" value="${c.ctgrId}">
<input type="hidden" name="newEventDispTypeCode" value="${c.newEventDispTypeCode}">
<input type="hidden" name="orderBy" value="${c.orderBy}">
<div class="tab">
	<ul>
		<li<c:if test="${c.type eq 'type01'}"> class="active"</c:if>><a href="type01">상품기획전</a></li>
		<li<c:if test="${c.type eq 'type02'}"> class="active"</c:if>><a href="type02">혜택이벤트</a></li>
	</ul>
</div>
<c:choose>
	<c:when test="${c.type eq 'type01'}">
	<div class="type01">
		<div class="btn_wrapper">
			<a href="/ht/help/eventPrizeList" class="btn_winner">당첨자발표</a>
		</div>
		<div class="category_nav_wrap">
			<ul>
				<li ctgrId="0000" <c:if test="${c.ctgrId eq '00'||c.ctgrId eq '0000'}">class="active"</c:if>><a href="javascript:getEventList('N','0000','type01');">전체</a></li>
				<li ctgrId="000020" <c:if test="${c.ctgrId eq '000020'}">class="active"</c:if>><a href="javascript:getEventList('N','000020','type01');">디자인문구</a></li>
				<li ctgrId="000022" <c:if test="${c.ctgrId eq '000022'}">class="active"</c:if>><a href="javascript:getEventList('N','000022','type01');">디지털</a></li>
				<li ctgrId="000007" <c:if test="${c.ctgrId eq '000007'}">class="active"</c:if>><a href="javascript:getEventList('N','000007','type01');">고급필기구</a></li>
				<li ctgrId="000021" <c:if test="${c.ctgrId eq '000021'}">class="active"</c:if>><a href="javascript:getEventList('N','000021','type01');">오피스</a></li>
				<li ctgrId="000025" <c:if test="${c.ctgrId eq '000025'}">class="active"</c:if>><a href="javascript:getEventList('N','000025','type01');">리빙/생활가전</a></li>
				<li ctgrId="000026" <c:if test="${c.ctgrId eq '000026'}">class="active"</c:if>><a href="javascript:getEventList('N','000026','type01');">키친/푸드</a></li>
				<li ctgrId="000024" <c:if test="${c.ctgrId eq '000024'}">class="active"</c:if>><a href="javascript:getEventList('N','000024','type01');">가구/수납</a></li>
				<li ctgrId="000028" <c:if test="${c.ctgrId eq '000028'}">class="active"</c:if>><a href="javascript:getEventList('N','000028','type01');">패션/잡화</a></li>
				<li ctgrId="000006" <c:if test="${c.ctgrId eq '000006'}">class="active"</c:if>><a href="javascript:getEventList('N','000006','type01');">뷰티/헬스</a></li>
				<li ctgrId="000027" <c:if test="${c.ctgrId eq '000027'}">class="active"</c:if>><a href="javascript:getEventList('N','000027','type01');">여행/자동차</a></li>
				<li ctgrId="000023" <c:if test="${c.ctgrId eq '000023'}">class="active"</c:if>><a href="javascript:getEventList('N','000023','type01');">취미/펫</a></li>
				<li ctgrId="000029" <c:if test="${c.ctgrId eq '000029'}">class="active"</c:if>><a href="javascript:getEventList('N','000029','type01');">유아동</a></li>
				<li ctgrId="0003" <c:if test="${c.ctgrId eq '0003'}">class="active"</c:if>><a href="javascript:getEventList('N','0003','type01');">CD</a></li>
				<li ctgrId="0004" <c:if test="${c.ctgrId eq '0004'}">class="active"</c:if>><a href="javascript:getEventList('N','0004','type01');">DVD/BLU-RAY</a></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
				<li></li>
			</ul>
		</div>
		<div class="pd_filter">
			<p class="pd_total"><em class="font_t">${listCount}</em>건 진행중</p>
			<div class="form_select">
				<select onchange="javascript:getEventSort(this.value,'type01')">
					<option value="N"<c:if test="${c.orderBy eq 'N' || c.orderBy eq null}"> selected</c:if>>최근등록순</option>
					<option value="O"<c:if test="${c.orderBy eq 'O'}"> selected</c:if>>마감임박순</option>
					<option value="P"<c:if test="${c.orderBy eq 'P'}"> selected</c:if>>인기순</option>
				</select>
			</div>
		</div>

		<div class="event_cont">
			<!-- 이벤트 목록 -->
			<div class="event_banner">
				<ul>
				<c:forEach items="${list}" var="l" varStatus="st">
					<li <c:if test="${listCount ne null && st.index eq '0'}">listCount="${listCount}"</c:if>>
						<a href="/ht/biz/eventDetail?eventId=${l.eventId}">
							<div class="img_wrap">
								<ui:image src="${l.imageUrl}" alt="${l.eventTitle}" />
							</div>
							<c:if test="${not empty l.dispDscntRate}">
							<span class="font_t percent"><fmt:formatNumber type="number">${l.dispDscntRate}</fmt:formatNumber>%</span>
							</c:if>
							<strong>${fn:escapeXml(l.eventTitle)}</strong>
							<p>${fn:escapeXml(l.eventDtlCont)}<c:if test="${l.eventDtlCont eq null || l.eventDtlCont == ''}"></br> </c:if></p>
							<span class="date font_t"><ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.eventEndDt}</ui:mask></span>
						</a>
					</li>
				</c:forEach>
				</ul>
			</div>
			<!--// 이벤트 목록 -->
		</div>
		<div class="pagination_v2">
			<ui:bizPagination name="pageHolder" url="?" parameters="orderBy,eventDispTypeCode,ctgrId,type,lastCtgrId,lastEventdisptypecode"/>
		</div>
	</div>
	</c:when>
	<c:when test="${c.type eq 'type02'}">
	<div class="type02">
		<div class="list_tab">
			<ul>
				<li newEventDispTypeCode="C1532"<c:if test="${c.newEventDispTypeCode eq 'C1532'}"> class="active" </c:if> onclick="javascript:setlastEventDispTypeCode()">
				<a href="javascript:getEventList('N','C1532','type02');">쿠폰/혜택</a></li>
				<li newEventDispTypeCode="C1533"<c:if test="${c.newEventDispTypeCode eq 'C1533'}"> class="active" </c:if> onclick="javascript:setlastEventDispTypeCode()">
				<a href="javascript:getEventList('N','C1533','type02');">컬처</a></li>
				<li newEventDispTypeCode="C1534"<c:if test="${c.newEventDispTypeCode eq 'C1534'}"> class="active" </c:if> onclick="javascript:setlastEventDispTypeCode()">
				<a href="javascript:getEventList('N','C1534','type02');">우수고객존</a></li>
			</ul>
		</div>
		<div class="pd_filter">
			<p class="pd_total"><em class="font_t">${listCount}</em>건 진행중</p>
			<div class="form_select" >
				<select onchange="javascript:getEventSort(this.value,'type02')">
					<option value="N"<c:if test="${c.orderBy eq 'N' || c.orderBy eq null}"> selected</c:if>>최근등록순</option>
					<option value="O"<c:if test="${c.orderBy eq 'O'}"> selected</c:if>>마감임박순</option>
					<option value="P"<c:if test="${c.orderBy eq 'P'}"> selected</c:if>>인기순</option>
				</select>
			</div>
		</div>

		<div class="event_cont">
			<!-- 컬쳐 -->
			<div <c:if test="${c.newEventDispTypeCode ne 'C1533'}">class="event_banner"</c:if><c:if test="${c.newEventDispTypeCode eq 'C1533'}">class="event_culture"</c:if>>
				<ul>
				<c:forEach items="${list}" var="l" varStatus="st">
					<li <c:if test="${listCount ne null && st.index eq '0'}">listCount="${listCount}"</c:if>>
						<a href="/ht/biz/eventDetail?eventId=${l.eventId}">
							<div class="img_wrap">
								<ui:image src="${l.imageUrl}" alt="${l.eventTitle}" />
							</div>
							<p>${fn:escapeXml(l.eventTitle)}<c:if test="${l.eventTitle eq null || l.eventTitle == ''}"></br> </c:if></p>
							<span class="date font_t"><ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.eventEndDt}</ui:mask></span>
						</a>
					</li>
				</c:forEach>
				</ul>
			</div>
			<!--// 컬쳐 -->
		</div>
		<div class="pagination_v2">
			<ui:bizPagination  name="pageHolder"  url="?" parameters="orderBy,eventDispTypeCode,ctgrId,type,lastCtgrId,lastEventdisptypecode"/>
		</div>
	</div>
	</c:when>
</c:choose>