<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){
		obj.init();
	});
	
	var obj = {
		init : function(){			
			categoryFn();
		}
	};
</script>

<div class="coupon_wrap category_wrap">
	<div class="coupon_zone buy"><!-- 구매사은품은 buy, 할인은 cut, 무료배송은 free : class 추가 -->
		<h2 class='buy'>구매 사은품</h2>
		<div class="brand_coupon new_event">
			<div class="pd_filter">
				<p class="pd_total">
					<small class='buy'>지금 구매 시, <span>증정혜택</span>이 있어요!</small>
					<em class="font_t"><fmt:formatNumber type="number" value="${totalCnt}"/></em>개
				</p>
				<div class="form_select">
					<select id="orderBySelect" onchange="location.href='/ht/biz/mypage/payGifts?productOrderBy='+this.value;">
						<option value="R"<c:if test="${empty c.productOrderBy or c.productOrderBy eq 'R'}"> selected="selected"</c:if>>최근순</option>
						<option value="T"<c:if test="${c.productOrderBy eq 'T'}"> selected="selected"</c:if>>할인율순</option>
						<option value="P"<c:if test="${c.productOrderBy eq 'P'}"> selected="selected"</c:if>>인기순</option>
						<option value="L"<c:if test="${c.productOrderBy eq 'L'}"> selected="selected"</c:if>>낮은가격순</option>
						<option value="H"<c:if test="${c.productOrderBy eq 'H'}"> selected="selected"</c:if>>높은가격순</option>
					</select>
				</div>
			</div>
		</div>
	</div>
	<div class="new_event">
		<!-- 상품 -->
		<div class="pd_list">
			<ul>
				<!-- prod -->
				<c:import url="/pages/bizFront/template/bizLayerProduct.jsp" charEncoding="UTF-8">
					<c:param name="paramList" value="list"/>
				</c:import>
				<!-- //prod -->
			</ul>
		</div>
		<!--// 상품 -->
		
		<!-- pagination -->
		<div class="pagination_v2">	        	   
           <ui:bizPagination name="pageHolder" url="?" parameters="productOrderBy"/>
       	</div>
		<!--// pagination -->
	</div>
</div>