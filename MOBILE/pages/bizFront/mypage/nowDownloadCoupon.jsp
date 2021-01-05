<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizFull"/>
<script type="text/javascript">
	var obj = {
		 page : 1				/*	현재 페이지	*/
		,loadData : function(){	/*	페이징		*/
			if(_isEmpty(obj.page))    obj.page = 1;
		    var url = "/m/biz/mypage/nowDownloadCoupon?lazy=Y&pagingLoad=true&productOrderBy="
    		   	+ $('#orderBySelect').val() +"&tabType="+ $('.coupon_zone li.active').attr("tabType") +"&page="+ obj.page;
		    
		    if("${c.brandId}" != ""){
		    	url += "&brandId=${c.brandId}";
		    }
		    
		    if($("[name=eofObj]").val() == "0"){
		        $("#loading").show();
		        $("input[name=eofObj]").val("1");
		        
		        $.ajax({
		            type: "GET"
		           ,async:false
		           ,url: url
		           ,dataType: "html"
		           ,success : function(htmlStr){
		        	   	$("#dataList").parent().children().not("ul").remove();
		        	   	$("#dataList").empty();
		        	   
		        	   	//페이징, 데이터 리스트 삭제
		        	   	if($(".pagination_v2").length > 0){
		        	   		$(".pagination_v2").remove();
		        	   	}

		      			//데이터 리스트, 페이징 추가
		        	   	if($("#totalCnt").text() == "0"){
		      				$("#dataList").parent().prepend(htmlStr);
		      			}else{
		      				$("#dataList").append(htmlStr);
		      			}
		      			
		               	if($(".pagination_v2").length > 0){
		               		$("#dataList").parent().after($(".pagination_v2"));
		               	}
		               	
		        	   	//스크롤 최 상위로 이동
		        	   	$(window).scrollTop(0);
		               	
		               	$("#loading").hide();
		               	$("img.lazy").lazyload({placeholder:'/images/no_image2.gif',effect : "fadeIn"});
		               	$("input[name=eofObj]").val("0");
		           }
		           ,error: function(data) {
		               alert('<fmt:message key="error.common.system"/>');
		               $("#loading").hide();
		           }
		       });
		    }
		}
		,init : function(){
           $("#subTitle").text("쿠폰존");
		}
		,changeOrderBy : function(){	/*	카테고리 변경 시	*/
			obj.page = 1;
			obj.loadData();
		}
	};
	
	function goList(page){
		obj.page = page;
		obj.loadData();
	}
	
	$(document).ready(function(){	
	    obj.init();
	  	//상품 불러오기
	    obj.loadData();
	});
</script>

<div id="content">
	<div class="benefit_wrap category_wrap">
		<input type="hidden" name="eofObj" value="0"/>
		<div class="coupon_zone">
			<ul class='list_tab clear'>
				<li<c:if test="${empty c.tabType or c.tabType eq 'PD'}"> class="active"</c:if> tabType="${c.tabType}">
					<a href="javascript:" onclick="location.href='/m/biz/mypage/nowDownloadCoupon?tabType=PD'">상품쿠폰</a>
				</li>
				<li<c:if test="${c.tabType eq 'BR' or c.tabType eq 'BP'}"> class="active"</c:if> tabType="${c.tabType}">
					<a href="javascript:" onclick="location.href='/m/biz/mypage/nowDownloadCoupon?tabType=BR'">브랜드쿠폰</a>
				</li>
				<li<c:if test="${c.tabType eq 'PM'}"> class="active"</c:if> tabType="${c.tabType}">
					<a href="javascript:" onclick="location.href='/m/biz/mypage/nowDownloadCoupon?tabType=PM'">프로모션</a>
				</li>
			</ul>
			<c:if test="${c.tabType ne 'PM'}">
				<ul class='list_how'>
					<li>할인 쿠폰은 상품 상세 페이지에서 발급 가능합니다.</li>
					<li>쿠폰 적용불가 상품의 경우 할인 적용 대상에서 제외합니다.</li>
					<li>하나의 상품에는 하나의 쿠폰만 사용하실 수 있습니다.</li>
					<li>이미 보유 중인 쿠폰은 추가발급되지 않습니다.</li>
				</ul>
			</c:if>
			<c:if test="${c.tabType eq 'PM'}">
				<ul class='list_how'>
					<li>쿠폰은 각 이벤트 페이지에서 다운로드 가능합니다.</li>
					<li>쿠폰은 장바구니 합계 기준, 해당 금액 이상 구매 시 적용 가능합니다.</li>
					<li>쿠폰은 유효기간 종료 후 구매 취소 시 반환되지 않습니다.</li>
					<li>일부 상품은 적용 제외될 수 있습니다.</li>
				</ul>
			</c:if>
		</div>
		
		<!-- 쿠폰존 배너 -->
		<c:if test="${not empty brData}">		
			<c:if test="${not empty brData.cpnDscntRate && brData.cpnDscntRate > 0}">
				<div class="bnr_coupon">
					<div class="desc_coupon">
						<c:choose>
	                        <c:when test="${not empty brData.cpnDscntRate && brData.cpnDscntRate > 0}">
	                        	<h4 class='font_t'>${brData.cpnDscntRate}%</h4>
	                        </c:when>
	                        <c:otherwise>
	                            <h4 class='font_t'><fmt:formatNumber type="number">${brData.cpnDscntAmt}</fmt:formatNumber>원</h4>
	                        </c:otherwise>
	                    </c:choose>
						<p class='font_t'>
							<c:if test='${not empty brData.brandEngName}'>
								${brData.brandEngName}
							</c:if>
							<c:if test='${empty brData.brandEngName}'>
								${brData.brandName}
							</c:if>
						</p>
						<fmt:parseDate value="${brData.cpnApplyStartDt}" var="sDate" pattern="yyyyMMdd"/>
						<fmt:parseDate value="${brData.cpnApplyEndDt}" var="eDate" pattern="yyyyMMdd"/>	
						<span class='font_t'><fmt:formatDate value="${sDate}" pattern="yyyy.MM.dd"/>~<fmt:formatDate value="${eDate}" pattern="yyyy.MM.dd"/></span>
					</div>
					<a href="/p/${brData.sellPrdtBcode}"></a>
				</div>	
			</c:if>		
		</c:if>
		<!--// 쿠폰존 배너 -->
		
		<c:if test="${c.tabType != 'PM'}">
			<div class="choice_wrap">
				<div class="pd_filter">
					<p class="pd_total">
						<c:if test="${c.tabType == 'BP'}">쿠폰 적용 상품 &nbsp;</c:if>
						<em class="font_t" id="totalCnt"></em>개
					</p>
					<c:if test="${c.tabType == 'PD' or c.tabType == 'BP'}">
						<div class="form_select">
							<select id="orderBySelect" onchange="javascript:obj.changeOrderBy();">
								<option value="R" selected="selected">최근순</option>
								<option value="T">할인율순</option>
								<option value="P">인기순</option>
								<option value="L">낮은가격순</option>
								<option value="H">높은가격순</option>
							</select>
						</div>
					</c:if>
				</div>
			</div>
		</c:if>
		<c:choose>
			<c:when test="${c.tabType == 'BR'}">
				<!-- 브랜드 -->
				<div class="coupon_terr">
					<ul class='coupon_list' id="dataList">
					</ul>
				</div>
				<!--//브랜드 -->	
			</c:when>
			<c:when test="${c.tabType == 'BP'}">
				<!-- 브랜드 상품 -->
				<div class="pd_list pd_best">
					<ul id="dataList">
					</ul>
				</div>
				<!--//브랜드 상품 -->
			</c:when>
			<c:when test="${c.tabType == 'PM'}">
				<!-- 이벤트 목록 -->
				<div class="coupon_terr event_list">
					<div class="event_banner">
						<ul id="dataList">
						</ul>
					</div>
				</div>
				<!-- //이벤트 목록 -->
			</c:when>
			<c:otherwise>
				<!-- 상품 -->
				<div class="pd_list coupon">
					<ul id="dataList">
					</ul>
				</div>
				<!--//상품 -->
			</c:otherwise>
		</c:choose>		
	</div>
</div>