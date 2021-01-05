<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn"%>
<html>
<head>
<script type="text/javascript">
	function goList(page) {
		location.href = "?page=" + page;
	}
</script>
</head>
<body>
	<div class="customer">
		<h2 class="tit_h2">오늘의 추천</h2>
	</div>
	<div class="prod_list01">
		<c:if test="${empty list}">
			<div class="mt20 pd10 t_c">
				<ul class="mb30 bt_line">
					<li class="pd10 bg_f8f8f8"><strong class="t_c f14">최근 본 상품이 없습니다</strong></li>				
				</ul>
			</div>
		</c:if>
		<c:if test="${not empty list}">
			<ul id="productList">

				<c:forEach items="${list}" var="l" varStatus="st">
					<li class="bb_line">
						<div>
							<c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}">
								<p class="pic">
									<a href="/p/${l.sellPrdtBcode}"><ui:image src="${l.productImageUrl}" server="product" size="150" /> </a>
								</p>
							</c:if>
							<c:if test="${l.sellPrdtGbn eq 'R'}">
								<p class="pic">
									<a href="/p/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${l.prdtName}" /> </a>
								</p>
							</c:if>
							<c:if test="${l.sellPrdtGbn eq 'D'}">
								<p class="pic dvd">
									<a href="/p/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${l.prdtName}" /> </a>
								</p>
							</c:if>
							<p class="brand t_l">
								<a href="/p/${l.sellPrdtBcode}">${fn:escapeXml(l.brandEngName)}</a>
							</p>
							<p class="tit t_l">
								<a href="/p/${l.sellPrdtBcode}">${fn:escapeXml(l.prdtName)}</a>
							</p>
							<p class="price t_l">
								<fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber>
								원
								<c:if test="${l.prdtSellPrice>l.lastCpnPrice}">
									<em class="col_red ml5"><fmt:formatNumber type="number">${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}</fmt:formatNumber>%</em>
								</c:if>
							</p>
						</div>
					</li>
				</c:forEach>
			</ul>
		</c:if>
	</div>

	<!-- paging -->
	<div class="paging mb30">
		<ui:paginationScript name="pageHolder" scriptName="goList" />
	</div>
	<!-- / paging -->

</body>
</html>