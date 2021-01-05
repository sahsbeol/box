<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<c:choose>
	<c:when test="${empty c.userNum}">
		<div class="vacant_history">
			<img class='login' src="/images/biz/sub/history/no_login.png" alt="히스토리 내역없음">
			<p><span>혹시 로그인을 깜빡하신 걸까요?</span><br><br> 좋아요 기능은<br> 회원만 이용하실 수 있어요</p>
			<a href="javascript:" onclick="login()">지금 로그인 하기</a>
		</div>		
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${empty list}">
				<div class="vacant_history">
					<img class='login' src="/images/biz/sub/history/no_like.png" alt="히스토리 내역없음">
					<p><span>아직 마음에 드는 상품을<br> 못찾으셨군요</span><br><br> 기다리고 있을게요</p>
					<a href="javascript:" onclick="location.href='/m/biz/welcomeMain';return false;">메인으로 이동</a>
				</div>				
				<c:if test="${not empty bestList}">				
					<div class="plus_spot pd_unit">
						<h2>혹시,<br> 이런 발견은 어떠세요?</h2>
						<div class="swiper-container">
							<div class="swiper-wrapper">
								<c:forEach items="${bestList}" var="l" varStatus="st">									
									<div class="swiper-slide">
										<a href="/p/${l.sellPrdtBcode}?foo=bar&rccode=history">
											<div class="thum">
												<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"><ui:image src="${l.productImageUrl}" size="400" server="product" alt="${fn:escapeXml(l.prdtName)}"/></c:if>
								                <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></c:if>
								                <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></c:if>
											</div>
										</a>	
										<a href="/p/${l.sellPrdtBcode}?foo=bar&rccode=history">
											<div class="cont">
												<p class="brand">${l.brandEngName}</p>
												<p class="tit">${l.prdtName}</p>
												<p class="price font_t">
													<fmt:parseNumber var="rate" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
													<span class="percent"><c:if test="${rate > 0}"><fmt:parseNumber integerOnly="true" value="${rate}"/>%</c:if></span>
													<span><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>																								
													<c:if test="${rate > 0}"><span class="discount"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span></c:if>
												</p>
												<div class="info">
										           	<c:set var="reviewCount" value="${l.reviewCount}"/>
													<c:set var="wishPrdtCnt" value="${l.wishPrdtCnt}"/>	
													<c:if test="${l.reviewCount > 999}"><c:set var="reviewCount" value="999+"/></c:if>
										            <c:if test="${l.wishPrdtCnt > 999}"><c:set var="wishPrdtCnt" value="999+"/></c:if>																								
													<span class="reply">${reviewCount}</span>
													<span class="like">${wishPrdtCnt}</span>
												</div>
											</div>
										</a>											
									</div>						
								</c:forEach>							
							</div>
							<!-- 스크롤바 -->
							<div class="swiper-scrollbar"></div>
						</div>
					</div>					
				</c:if>
			</c:when>	
			<c:otherwise>			
				<div class="choice_wrap">
					<div class="pd_filter">
						<p class="pd_total"><em class="font_t">${pageHolder.totalRows}</em>건</p>
						<div class="form_select">
							<select onchange="goSort(this.value);return false;">
								<option value="R" <c:if test="${c.productOrderBy eq 'R'}"> selected="selected"</c:if>>최근등록순</option>				
								<option value="A" <c:if test="${c.productOrderBy eq 'A'}"> selected="selected"</c:if>>가나다순</option>
							</select>
						</div>
					</div>
				</div>
				<!-- 제품 -->
				<div class="pd_list coupon">
					<ul>
				    <c:forEach items="${list}" var="l" varStatus="st">
					    <li <c:if test="${l.prdtStatCode ne 'C0312'}">class="sold_out"</c:if>>
					    	<a href="/p/${l.sellPrdtBcode}">
					    		<div class="thum">
					    			<c:choose>
					    				<c:when test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
					    					<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="${l.rtngCode }" alt="${l.prdtName}"/>
					    				</c:when>
					    				<c:otherwise>
					    					<ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
									    </c:otherwise>       
					               	</c:choose>
					            </div>
					        </a>
					        <!-- 클릭시 active : class 추가 -->
					        <a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt > 0}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
					        <a href="/p/${l.sellPrdtBcode}">
					        	<div class="cont">	        	
									<c:choose>
					    				<c:when test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
					    					<p class="brand">${l.artiName}</p>
					    				</c:when>
					    				<c:otherwise>
					    					<p class="brand">${l.brandEngName}</p>
									    </c:otherwise>       
					               	</c:choose>
									<p class="tit">${fn:escapeXml(l.prdtName)}</p>
									<p class="price font_t">
					                	<fmt:parseNumber var="rate" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
										<span class="percent"><c:if test="${rate > 0}">${rate}%</c:if></span>
										<span><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>																								
										<c:if test="${rate > 0}"><span class="discount"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span></c:if>
									</p>
					            	<div class="info">
										<c:set var="reviewCount" value="${l.reviewCount}"/>
										<c:set var="wishPrdtCnt" value="${l.wishPrdtCnt}"/>												
										<c:if test="${l.reviewCount > 999}"><c:set var="reviewCount" value="999+"/></c:if>
						                <c:if test="${l.wishPrdtCnt > 999}"><c:set var="wishPrdtCnt" value="999+"/></c:if>
						                <span class="reply">${reviewCount}</span>
						                <span class="like" code="${l.sellPrdtBcode}">${wishPrdtCnt}</span>											
									</div>
									<div class="badge">
										<c:choose>
						    				<c:when test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
												<c:if test="${l.mediaName ne 'VCD' && fn:startsWith(l.ctgrId, '000400')}"><span class="badge02">블루레이</span></c:if>
												<c:if test="${l.mediaName ne 'VCD' && fn:startsWith(l.ctgrId, '000401')}"><span class="badge02">DVD</span></c:if>						
												<c:if test="${l.hasPosterCaseYn eq 'Y'}"><span class="badge01">포스터</span></c:if>
												<c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><span class="badge01">쿠폰</span></c:if>
												<c:if test="${l.impYn eq 'Y'}"><span class="badge02">수입</span></c:if>
												<c:if test="${l.rcrdStat eq '9'}"><span class="badge02">예약</span></c:if>
												<c:if test="${l.prdtStatCode ne 'C0312'}">
													<c:choose>
														<c:when test="${l.rcrdStat eq '3' || l.rcrdStat eq '4'}">
															<span class="badge03">품절</span>
														</c:when>
														<c:otherwise>
															<span class="badge03">일시품절</span>
														</c:otherwise>
													</c:choose>
												</c:if>
						    				</c:when>
						    				<c:otherwise>
												<c:choose>
													<c:when test="${l.prdtStatCode ne 'C0312'}">
														<c:if test="${l.prdtStatCode eq 'C0313'}"><span class="badge03">일시품절</span></c:if>
														<c:if test="${l.prdtStatCode ne 'C0313'}"><span class="badge03">품절</span></c:if>																										
													</c:when>
													<c:otherwise>
														<c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><span class="badge01">쿠폰</span></c:if>
														<c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}"><span class="badge02">사은품</span></c:if>
														<c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}"><span class="badge02">무료배송</span></c:if>
													</c:otherwise>
												</c:choose>
										    </c:otherwise>
						               	</c:choose>
									</div>			
								</div>	
							</a>   
						</li>           
				    </c:forEach>
				    </ul>
				</div>
				<!--// 제품 -->
				<div class="pagination_v2">
				    <ui:bizpaginationScript name="pageHolder" scriptName="goList"/>
				</div>		
			</c:otherwise>
		</c:choose>			
	</c:otherwise>
</c:choose>

<script type="text/javascript">
$(document).ready(function() {	
	categoryFn(); //category
});

//페이지 이동
function goList(page){	
    var target = "${c.target}";
    var productOrderBy = "${c.productOrderBy}";
    loadTemplate(target, productOrderBy, page);
}

//정렬순서 변경
function goSort(productOrderBy){	
    var target = "${c.target}";
    var page = "1";
    loadTemplate(target, productOrderBy, page);
}
</script>