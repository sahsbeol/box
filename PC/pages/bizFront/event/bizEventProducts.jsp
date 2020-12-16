<%@page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none" />
<style>
<!--
.prod_list_large02 ul li + li {margin-left:10px}
-->
</style>

<c:if test="${c.eventPrdtTypeCode eq 'C0241'}">
    <c:forEach items="${listMain}" var="l">
    	<div class="pd_list prod_list_large03">
			<ul>
				<li <c:if test="${l.prdtStatCode ne 'C0312' && l.prdtStatCode eq 'C0313'}">class="sold_out-t"</c:if><c:if test="${l.prdtStatCode ne 'C0312' && l.prdtStatCode ne 'C0313'}">class="sold_out"</c:if>>
						<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
							<c:choose>
								<c:when test="${l.prdtStatCode ne 'C0312'}">
								<a href="/ht/record/detail/${l.sellPrdtBcode}">
									<div class="thum">
										<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'400':'264'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
										<c:if test="${l.prdtStatCode ne 'C0312'}">
											<div class="soldout-wrap">
			                                    <div class="absol-center">
			                                        <p>아쉽지만!</p>
			                                        <p><b></b>이에요</p>
			                                    </div>
			                                </div>
		                                </c:if>
									</div>
								</a>
								</c:when>
								<c:otherwise>
									<c:set var="detailHref" value="/ht/record/detail/${l.sellPrdtBcode}"/>
				                    <a href="${detailHref}">
				                    <div class="thum">
				                    <ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'400':'264'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
				                    </div>
				                    </a>
			                    </c:otherwise>
			                </c:choose>
		                </c:if>
		                <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
		                	<c:choose>
								<c:when test="${l.prdtStatCode ne 'C0312'}">
								<a href="#none">
									<div class="thum">
										<ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
										<c:if test="${l.prdtStatCode ne 'C0312'}">
											<div class="soldout-wrap">
			                                    <div class="absol-center">
			                                        <p>아쉽지만!</p>
			                                        <p><b></b>이에요</p>
			                                        <button type="button" class="replace-stuff-btn" onclick="replaceBtn('${l.sellPrdtBcode}');return false;">대체상품</button>
			                                    </div>
			                                </div>
		                                </c:if>
									</div>
								</a>
								</c:when>
								<c:otherwise>
				                	<c:set var="detailHref" value="/ht/product/detail?barcode=${l.sellPrdtBcode}"/>
				                    <a href="${detailHref}">
				                    <div class="thum">
				                    <ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
				                    </div>
				                    </a>
			                    </c:otherwise>
		                    </c:choose>
		                </c:if>
					<!-- 클릭시 active : class 추가 -->
					<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt eq '1'}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
					<a href="${detailHref}">
						<div class="cont">
							<div class="badge">
								<c:if test="${l.prdtStatCode ne 'C0312'}">
									<c:if test="${l.prdtStatCode eq 'C0313'}"><span class="badge03">일시품절</span></c:if>
									<c:if test="${l.prdtStatCode ne 'C0313'}"><span class="badge03">품절</span></c:if>
								</c:if>
<%-- 								<c:if test="${l.prdtStatCode ne 'C0312'}"><span class="badge03">품절</span></c:if> --%>
								<c:if test="${l.hasPosterCaseYn eq 'Y'}"><span class="badge01">포스터</span></c:if>
								<c:if test="${l.impYn eq 'Y'}"><span class="badge02">수입</span></c:if>
								<c:if test="${l.rcrdStat eq '9'}"><span class="badge02">예약</span></c:if>
								<c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><span class="badge01">쿠폰</span></c:if>
								<c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}"><span class="badge02">사은품</span></c:if>
								<c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}"><span class="badge02">무료배송</span></c:if>
							</div>
							<p class="brand">${l.brandName}</p>
							<p class="tit">${fn:escapeXml(l.prdtName)}</p>
							<p class="price font_t">
							<c:if test="${l.prdtSellPrice eq l.lastCpnPrice}">
							<span class="ori_price"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
							</c:if>
							<c:if test="${l.prdtSellPrice ne l.lastCpnPrice}">
							<span class="percent"><fmt:parseNumber var="percent" integerOnly="true" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>${percent}%</span>
							<span class="ori_price"><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
							<span class="discount"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
							</c:if>
							<c:if test="${l.prdtStatCode ne 'C0312'}">
							<img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/>
							</c:if>
							</p>
							<div class="info">
								<c:set var="reviewCount" value="${l.reviewCount}"/>
								<c:set var="wishPrdtCnt" value="${l.wishPrdtCnt}"/>
								<c:if test="${l.reviewCount > 999}"><c:set var="reviewCount" value="999+"/></c:if>
								<c:if test="${l.wishPrdtCnt > 999}"><c:set var="wishPrdtCnt" value="999+"/></c:if>
								<c:if test="${l.reviewCount > 0}"><span class="reply">${reviewCount}</span></c:if>
								<c:if test="${l.wishPrdtCnt > 0}"><span class="like" code="${l.sellPrdtBcode}">${wishPrdtCnt}</span></c:if>
							</div>
						</div>
					</a>
				</li>
			</ul>
		</div>
    </c:forEach>
</c:if>
<c:if test="${c.eventPrdtTypeCode eq 'C0242' || c.eventPrdtTypeCode eq 'C0244'}">
    <div class="pd_list prod_list_large">
        <c:forEach items="${listMain}" step="2" varStatus="s1">
            <c:if test="${s1.first || fn:length(listMain)-s1.index > 1}">
            <ul>
                <c:forEach items="${listMain}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+1}">
                    <li <c:if test="${l.prdtStatCode ne 'C0312' && l.prdtStatCode eq 'C0313'}">class="sold_out-t"</c:if><c:if test="${l.prdtStatCode ne 'C0312' && l.prdtStatCode ne 'C0313'}">class="sold_out"</c:if>>
                    	
                    	<a href="/p/${l.sellPrdtBcode}">
                        <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                        	<c:choose>
                        		<c:when test="${l.prdtStatCode ne 'C0312'}">
                        			<a href="/ht/record/detail/${l.sellPrdtBcode}">
										<div class="thum">
                                            <ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'400':'264'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
                                            <div class="soldout-wrap">
                                                <div class="absol-center">
                                                    <p>아쉽지만!</p>
                                                    <p><b></b>이에요</p>
                                                </div>
                                            </div>
										</div>
									</a>
                        		</c:when>
                        		<c:otherwise>
		                            <a href="/ht/record/detail/${l.sellPrdtBcode}">
		                            <div class="thum">
		                            <ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'400':'264'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
		                            </div>
		                            </a>
                        		</c:otherwise>
                        	</c:choose>
                        </c:if>
                        <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                        	<c:choose>
                        		<c:when test="${l.prdtStatCode ne 'C0312'}">
                        			<a href="#none">
										<div class="thum">
                                            <ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
                                            <div class="soldout-wrap">
                                                <div class="absol-center">
                                                    <p>아쉽지만!</p>
                                                    <p><b></b>이에요</p>
                                                    <button type="button" class="replace-stuff-btn" onclick="replaceBtn('${l.sellPrdtBcode}');return false;">대체상품</button>
                                                </div>
                                            </div>
										</div>
									</a>
                        		</c:when>
                        		<c:otherwise>
		                            <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
		                            <div class="thum">
		                            <ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
		                            </div>
		                            </a>
                            	</c:otherwise>
                        	</c:choose>
                        </c:if>
                        <a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt eq '1'}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
                        </a>
                        <c:if test="${c.prdtInfoExpsYn eq 'Y'}">
                        <a href="/p/${l.sellPrdtBcode}">
                       	<div class="cont">
							<p class="brand">${l.brandName}</p>
							<p class="tit">${fn:escapeXml(l.prdtName)}</p>
							<p class="price font_t">
								<c:if test="${l.prdtSellPrice eq l.lastCpnPrice}">
                                    <span><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                </c:if>
                               
                                <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}">
                                	<span class="percent"><fmt:parseNumber var="percent" integerOnly="true" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>${percent}%</span>
                                    <span><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
                                    <span class="discount"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                </c:if>
							</p>
							<div class="info">
								<c:set var="reviewCount" value="${l.reviewCount}"/>
                                <c:set var="wishPrdtCnt" value="${l.wishPrdtCnt}"/>
                                <c:if test="${l.reviewCount > 999}"><c:set var="reviewCount" value="999+"/></c:if>
                                <c:if test="${l.wishPrdtCnt > 999}"><c:set var="wishPrdtCnt" value="999+"/></c:if>
                                <c:if test="${l.reviewCount > 0}"><span class="reply">${reviewCount}</span></c:if>
                                <c:if test="${l.wishPrdtCnt > 0}"><span class="like" code="${l.sellPrdtBcode}">${wishPrdtCnt}</span></c:if>
							</div>
							<div class="badge">
								<c:if test="${l.prdtStatCode ne 'C0312'}">
									<c:if test="${l.prdtStatCode eq 'C0313'}"><span class="badge03">일시품절</span></c:if>
									<c:if test="${l.prdtStatCode ne 'C0313'}"><span class="badge03">품절</span></c:if>
								</c:if>
								<c:if test="${l.hasPosterCaseYn eq 'Y'}"><span class="badge01">포스터</span></c:if>
								<c:if test="${l.impYn eq 'Y'}"><span class="badge02">수입</span></c:if>
								<c:if test="${l.rcrdStat eq '9'}"><span class="badge02">예약</span></c:if>
                                <c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><span class="badge01">쿠폰</span></c:if>
                                <c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}"><span class="badge02">사은품</span></c:if>
								<c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}"><span class="badge02">무료배송</span></c:if>
							</div>
                        </div>
                        </a>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>
            </c:if>
        </c:forEach>
    </div>
</c:if>
<c:if test="${c.eventPrdtTypeCode eq 'C0243'}">
    <div class="pd_list prod_list_large02 mgb25">
        <c:forEach items="${listMain}" step="3" varStatus="s1">
            <c:if test="${s1.first || fn:length(listMain)-s1.index > 2}">
            <ul>
                <c:forEach items="${listMain}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+2}">
                    <li <c:if test="${l.prdtStatCode ne 'C0312' && l.prdtStatCode eq 'C0313'}">class="sold_out-t"</c:if><c:if test="${l.prdtStatCode ne 'C0312' && l.prdtStatCode ne 'C0313'}">class="sold_out"</c:if>>
                            <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                            	<c:choose>
                            		<c:when test="${l.prdtStatCode ne 'C0312'}">
                            			<a href="/ht/record/detail/${l.sellPrdtBcode}">
											<div class="thum">
												<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'400':'264'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
												<c:if test="${l.prdtStatCode ne 'C0312'}">
													<div class="soldout-wrap">
					                                    <div class="absol-center">
					                                        <p>아쉽지만!</p>
					                                        <p><b></b>이에요</p>
					                                    </div>
					                                </div>
				                                </c:if>
											</div>
										</a>
                            		</c:when>
                            		<c:otherwise>
		                                <a href="/ht/record/detail/${l.sellPrdtBcode}">
		                                <div class="thum">
		                                <ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'400':'264'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
		                                </div>
		                                </a>
                            		</c:otherwise>
                            	</c:choose>
                            </c:if>
                            <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                            	<c:choose>
                            		<c:when test="${l.prdtStatCode ne 'C0312'}">
                            			<a href="#none">
											<div class="thum">
												<ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
												<c:if test="${l.prdtStatCode ne 'C0312'}">
													<div class="soldout-wrap">
					                                    <div class="absol-center">
					                                        <p>아쉽지만!</p>
					                                        <p><b></b>이에요</p>
					                                        <button type="button" class="replace-stuff-btn" onclick="replaceBtn('${l.sellPrdtBcode}');return false;">대체상품</button>
					                                    </div>
					                                </div>
				                                </c:if>
											</div>
										</a>
                            		</c:when>
                            		<c:otherwise>
		                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
		                                <div class="thum">
		                                <ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
		                                </div>
		                                </a>
                                	</c:otherwise>
                            	</c:choose>
                            </c:if>
							<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt eq '1'}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
                        <c:if test="${c.prdtInfoExpsYn eq 'Y'}">
                        <a href="/p/${l.sellPrdtBcode}">
						<div class="cont">
							<p class="brand">${l.brandName}</p>
							<p class="tit">${fn:escapeXml(l.prdtName)}</p>
							<p class="price font_t">
								<c:if test="${l.prdtSellPrice eq l.lastCpnPrice}">
                                    <span><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                </c:if>
                                <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}">
                                    <span class="percent"><fmt:parseNumber var="percent" integerOnly="true" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>${percent}%</span>
                                    <span><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
                                    <span class="discount"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                </c:if>
							</p>
							<div class="info">
								<c:set var="reviewCount" value="${l.reviewCount}"/>
                                <c:set var="wishPrdtCnt" value="${l.wishPrdtCnt}"/>
                                <c:if test="${l.reviewCount > 999}"><c:set var="reviewCount" value="999+"/></c:if>
                                <c:if test="${l.wishPrdtCnt > 999}"><c:set var="wishPrdtCnt" value="999+"/></c:if>
                                <c:if test="${l.reviewCount > 0}"><span class="reply">${reviewCount}</span></c:if>
                                <c:if test="${l.wishPrdtCnt > 0}"><span class="like" code="${l.sellPrdtBcode}">${wishPrdtCnt}</span></c:if>
							</div>
							<div class="badge">
								<c:if test="${l.prdtStatCode ne 'C0312'}">
									<c:if test="${l.prdtStatCode eq 'C0313'}"><span class="badge03">일시품절</span></c:if>
									<c:if test="${l.prdtStatCode ne 'C0313'}"><span class="badge03">품절</span></c:if>
								</c:if>
<%-- 								<c:if test="${l.prdtStatCode ne 'C0312'}"><span class="badge03">품절</span></c:if> --%>
                                <c:if test="${l.hasPosterCaseYn eq 'Y'}"><span class="badge01">포스터</span></c:if>
								<c:if test="${l.impYn eq 'Y'}"><span class="badge02">수입</span></c:if>
								<c:if test="${l.rcrdStat eq '9'}"><span class="badge02">예약</span></c:if>
                                <c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><span class="badge01">쿠폰</span></c:if>
                                <c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}"><span class="badge02">사은품</span></c:if>
								<c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}"><span class="badge02">무료배송</span></c:if>
							</div>
						</div>
                        </a>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>
            </c:if>
        </c:forEach>
    </div>
</c:if>
<c:if test="${c.eventPrdtTypeCode eq 'C0245'}">
    <div class="pd_list prod_list_normal mgb25">
        <c:forEach items="${listMain}" step="4" varStatus="s1">
            <c:if test="${s1.first || fn:length(listMain)-s1.index > 3}">
            <ul>
                <c:forEach items="${listMain}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
                    <li <c:if test="${l.prdtStatCode ne 'C0312' && l.prdtStatCode eq 'C0313'}">class="sold_out-t"</c:if><c:if test="${l.prdtStatCode ne 'C0312' && l.prdtStatCode ne 'C0313'}">class="sold_out"</c:if>>
                        <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                       	<c:choose>
                       		<c:when test="${l.prdtStatCode ne 'C0312'}">
                       			<a href="/ht/record/detail/${l.sellPrdtBcode}">
									<div class="thum">
										<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'200':'132'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
										<c:if test="${l.prdtStatCode ne 'C0312'}">
											<div class="soldout-wrap">
			                                    <div class="absol-center">
			                                        <p>아쉽지만!</p>
			                                        <p><b></b>이에요</p>
			                                    </div>
			                                </div>
		                                </c:if>
									</div>
								</a>
                       		</c:when>
                       		<c:otherwise>
								<a href="/ht/record/detail/${l.sellPrdtBcode}">
		                            <div class="thum">
		                            <ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'200':'132'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
		                            </div>
								</a>
                       		</c:otherwise>
                       	</c:choose>
                        </c:if>
                        <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                        <c:choose>
                       		<c:when test="${l.prdtStatCode ne 'C0312'}">
                       			<a href="#none">
									<div class="thum">
										<ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
										<c:if test="${l.prdtStatCode ne 'C0312'}">
											<div class="soldout-wrap">
			                                    <div class="absol-center">
			                                        <p>아쉽지만!</p>
			                                        <p><b></b>이에요</p>
			                                        <button type="button" class="replace-stuff-btn" onclick="replaceBtn('${l.sellPrdtBcode}');return false;">대체상품</button>
			                                    </div>
			                                </div>
		                                </c:if>
									</div>
								</a>
                       		</c:when>
                       		<c:otherwise>
		                        <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
		                            <div class="thum">
		                            <ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
		                            </div>
		                        </a>
		                    </c:otherwise>
                       	</c:choose>
                        </c:if>
                        <a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt eq '1'}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
                        <c:if test="${c.prdtInfoExpsYn eq 'Y'}">
                        <a href="/p/${l.sellPrdtBcode}">
                        <div class="cont">
							<p class="brand">${l.brandName}</p>
							<p class="tit">${fn:escapeXml(l.prdtName)}</p>
							<p class="price font_t">
								<c:if test="${l.prdtSellPrice eq l.lastCpnPrice}">
                                    <span><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                </c:if>
                                <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}">
                                	<span class="percent"><fmt:parseNumber var="percent" integerOnly="true" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>${percent}%</span>
                                    <span><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
                                    <span class="discount"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                </c:if>
							</p>
							<div class="info">
								<c:set var="reviewCount" value="${l.reviewCount}"/>
                                <c:set var="wishPrdtCnt" value="${l.wishPrdtCnt}"/>
                                <c:if test="${l.reviewCount > 999}"><c:set var="reviewCount" value="999+"/></c:if>
                                <c:if test="${l.wishPrdtCnt > 999}"><c:set var="wishPrdtCnt" value="999+"/></c:if>
                                <c:if test="${l.reviewCount > 0}"><span class="reply">${reviewCount}</span></c:if>
                                <c:if test="${l.wishPrdtCnt > 0}"><span class="like" code="${l.sellPrdtBcode}">${wishPrdtCnt}</span></c:if>
							</div>
							<div class="badge">
								<c:if test="${l.prdtStatCode ne 'C0312'}">
									<c:if test="${l.prdtStatCode eq 'C0313'}"><span class="badge03">일시품절</span></c:if>
									<c:if test="${l.prdtStatCode ne 'C0313'}"><span class="badge03">품절</span></c:if>
								</c:if>
<%-- 								<c:if test="${l.prdtStatCode ne 'C0312'}"><span class="badge03">품절</span></c:if> --%>
								<c:if test="${l.hasPosterCaseYn eq 'Y'}"><span class="badge01">포스터</span></c:if>
								<c:if test="${l.impYn eq 'Y'}"><span class="badge02">수입</span></c:if>
								<c:if test="${l.rcrdStat eq '9'}"><span class="badge02">예약</span></c:if>
                                <c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><span class="badge01">쿠폰</span></c:if>
                                <c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}"><span class="badge02">사은품</span></c:if>
								<c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}"><span class="badge02">무료배송</span></c:if>
							</div>
						</div>
                        </a>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>
            </c:if>
        </c:forEach>
    </div>
</c:if>
<c:if test="${c.eventPrdtTypeCode eq 'C0244'}">
    <div class="pd_list prod_list_large">
        <c:forEach items="${listProduct}" step="2" varStatus="s1">
            <c:if test="${s1.first || fn:length(listProduct)-s1.index > 1}">
            <ul>
                <c:forEach items="${listProduct}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+1}">
                    <li <c:if test="${l.prdtStatCode ne 'C0312' && l.prdtStatCode eq 'C0313'}">class="sold_out-t"</c:if><c:if test="${l.prdtStatCode ne 'C0312' && l.prdtStatCode ne 'C0313'}">class="sold_out"</c:if>>
                        <span class="img">
                            <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                            <c:choose>
                            	<c:when test="${l.prdtStatCode ne 'C0312'}">
									<a href="/ht/record/detail/${l.sellPrdtBcode}">
										<div class="thum">
											<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'400':'264'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
											<c:if test="${l.prdtStatCode ne 'C0312'}">
												<div class="soldout-wrap">
				                                    <div class="absol-center">
				                                        <p>아쉽지만!</p>
				                                        <p><b></b>이에요</p>
				                                    </div>
				                                </div>
			                                </c:if>
										</div>
									</a>
								</c:when>
                            	<c:otherwise>
	                                <a href="/ht/record/detail/${l.sellPrdtBcode}">
	                                <div class="thum">
	                                <ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'400':'264'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
	                                </div>
	                                </a>
                            	</c:otherwise>
                            </c:choose>
                            </c:if>
                            <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                            	<c:choose>
                            		<c:when test="${l.prdtStatCode ne 'C0312'}">
										<a href="#none">
											<div class="thum">
												<ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
												<c:if test="${l.prdtStatCode ne 'C0312'}">
													<div class="soldout-wrap">
					                                    <div class="absol-center">
					                                        <p>아쉽지만!</p>
					                                        <p><b></b>이에요</p>
					                                        <button type="button" class="replace-stuff-btn" onclick="replaceBtn('${l.sellPrdtBcode}');return false;">대체상품</button>
					                                    </div>
					                                </div>
				                                </c:if>
											</div>
										</a>
									</c:when>
                            		<c:otherwise>
		                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
		                                <div class="thum">
		                                <ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
		                                </div>
		                                </a>
                            		</c:otherwise>
                            	</c:choose>
                            </c:if>
                            <a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt eq '1'}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
                        </span>
                        <c:if test="${c.prdtInfoExpsYn eq 'Y'}">
                        <a href="/p/${l.sellPrdtBcode}">
                        <div class="cont">
							<p class="brand">${l.brandName}</p>
							<p class="tit">${fn:escapeXml(l.prdtName)}</p>
							<p class="price font_t">
								<c:if test="${l.prdtSellPrice eq l.lastCpnPrice}">
                                    <span><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                </c:if>
                                <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}">
                                	<span class="percent"><fmt:parseNumber var="percent" integerOnly="true" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>${percent}%</span>
                                    <span><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
                                    <span class="discount"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                </c:if>
							</p>
							<div class="info">
								<c:set var="reviewCount" value="${l.reviewCount}"/>
                                <c:set var="wishPrdtCnt" value="${l.wishPrdtCnt}"/>
                                <c:if test="${l.reviewCount > 999}"><c:set var="reviewCount" value="999+"/></c:if>
                                <c:if test="${l.wishPrdtCnt > 999}"><c:set var="wishPrdtCnt" value="999+"/></c:if>
                                <c:if test="${l.reviewCount > 0}"><span class="reply">${reviewCount}</span></c:if>
                                <c:if test="${l.wishPrdtCnt > 0}"><span class="like" code="${l.sellPrdtBcode}">${wishPrdtCnt}</span></c:if>
							</div>
							<div class="badge">
								<c:if test="${l.prdtStatCode ne 'C0312'}">
									<c:if test="${l.prdtStatCode eq 'C0313'}"><span class="badge03">일시품절</span></c:if>
									<c:if test="${l.prdtStatCode ne 'C0313'}"><span class="badge03">품절</span></c:if>
								</c:if>
<%-- 								<c:if test="${l.prdtStatCode ne 'C0312'}"><span class="badge03">품절</span></c:if> --%>
								<c:if test="${l.hasPosterCaseYn eq 'Y'}"><span class="badge01">포스터</span></c:if>
								<c:if test="${l.impYn eq 'Y'}"><span class="badge02">수입</span></c:if>
								<c:if test="${l.rcrdStat eq '9'}"><span class="badge02">예약</span></c:if>
                                <c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><span class="badge01">쿠폰</span></c:if>
                                <c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}"><span class="badge02">사은품</span></c:if>
								<c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}"><span class="badge02">무료배송</span></c:if>
							</div>
						</div>
                        </a>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>
            </c:if>
        </c:forEach>
    </div>
</c:if>
<c:if test="${not empty listProduct && (c.eventPrdtTypeCode eq 'C0241' || c.eventPrdtTypeCode eq 'C0242' || c.eventPrdtTypeCode eq 'C0243' || c.eventPrdtTypeCode eq 'C0245')}">
    <div class=" pd_list prod_list_normal">
		<ul>
        <c:forEach items="${listProduct}" step="4" varStatus="s1">
<%--             <c:if test="${s1.first || c.eventPrdtTypeCode eq 'C0245' || fn:length(listProduct)-s1.index > 3}"> --%>
                <c:forEach items="${listProduct}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
                    <li <c:if test="${l.prdtStatCode ne 'C0312' && l.prdtStatCode eq 'C0313'}">class="sold_out-t"</c:if><c:if test="${l.prdtStatCode ne 'C0312' && l.prdtStatCode ne 'C0313'}">class="sold_out"</c:if>>
                        <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                        <c:choose>
                        	<c:when test="${l.prdtStatCode ne 'C0312'}">
								<a href="/ht/record/detail/${l.sellPrdtBcode}">
									<div class="thum">
										<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'200':'132'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
										<c:if test="${l.prdtStatCode ne 'C0312'}">
											<div class="soldout-wrap">
			                                    <div class="absol-center">
			                                        <p>아쉽지만!</p>
			                                        <p><b></b>이에요</p>
			                                        <button type="button" class="replace-stuff-btn" onclick="replaceBtn('${l.sellPrdtBcode}');return false;">대체상품</button>
			                                    </div>
			                                </div>
		                                </c:if>
									</div>
								</a>
							</c:when>
                        	<c:otherwise>
								<a href="/ht/record/detail/${l.sellPrdtBcode}">
		                            <div class="thum">
		                            <ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'200':'132'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
		                            </div>
								</a>
                        	</c:otherwise>
                        </c:choose>
                        </c:if>
                        <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                        <c:choose>
                        	<c:when test="${l.prdtStatCode ne 'C0312'}">
								<a href="#none">
									<div class="thum">
										<ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
										<c:if test="${l.prdtStatCode ne 'C0312'}">
											<div class="soldout-wrap">
			                                    <div class="absol-center">
			                                        <p>아쉽지만!</p>
			                                        <p><b></b>이에요</p>
			                                        <button type="button" class="replace-stuff-btn" onclick="replaceBtn('${l.sellPrdtBcode}');return false;">대체상품</button>
			                                    </div>
			                                </div>
		                                </c:if>
									</div>
								</a>
							</c:when>
                        	<c:otherwise>
		                        <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
		                            <div class="thum">
		                            <ui:image src="${l.prdtImageUrl}" src2="${l.productImageUrl2}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/>
		                            </div>
		                        </a>
                        </c:otherwise>
                        </c:choose>
                        </c:if>
                        <a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt eq '1'}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
                        <c:if test="${c.prdtInfoExpsYn eq 'Y'}">
                        <a href="/p/${l.sellPrdtBcode}">
                        <div class="cont">
							<p class="brand">${l.brandName}</p>
							<p class="tit">${fn:escapeXml(l.prdtName)}</p>
							<p class="price font_t">
								<c:if test="${l.prdtSellPrice eq l.lastCpnPrice}">
                                    <span><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                </c:if>
                                <c:if test="${l.prdtSellPrice ne l.lastCpnPrice}">
                                	<span class="percent"><fmt:parseNumber var="percent" integerOnly="true" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>${percent}%</span>
                                    <span><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></span>
                                    <span class="discount"><fmt:formatNumber type="number">${l.prdtSellPrice}</fmt:formatNumber></span>
                                </c:if>
							</p>
							<div class="info">
								<c:set var="reviewCount" value="${l.reviewCount}"/>
                                <c:set var="wishPrdtCnt" value="${l.wishPrdtCnt}"/>
                                <c:if test="${l.reviewCount > 999}"><c:set var="reviewCount" value="999+"/></c:if>
                                <c:if test="${l.wishPrdtCnt > 999}"><c:set var="wishPrdtCnt" value="999+"/></c:if>
                                <c:if test="${l.reviewCount > 0}"><span class="reply">${reviewCount}</span></c:if>
                                <c:if test="${l.wishPrdtCnt > 0}"><span class="like" code="${l.sellPrdtBcode}">${wishPrdtCnt}</span></c:if>
							</div>
							<div class="badge">
								<c:if test="${l.prdtStatCode ne 'C0312'}">
									<c:if test="${l.prdtStatCode eq 'C0313'}"><span class="badge03">일시품절</span></c:if>
									<c:if test="${l.prdtStatCode ne 'C0313'}"><span class="badge03">품절</span></c:if>
								</c:if>
<%-- 								<c:if test="${l.prdtStatCode ne 'C0312'}"><span class="badge03">품절</span></c:if> --%>
								<c:if test="${l.hasPosterCaseYn eq 'Y'}"><span class="badge01">포스터</span></c:if>
								<c:if test="${l.impYn eq 'Y'}"><span class="badge02">수입</span></c:if>
								<c:if test="${l.rcrdStat eq '9'}"><span class="badge02">예약</span></c:if>
                                <c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><span class="badge01">쿠폰</span></c:if>
                                <c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}"><span class="badge02">사은품</span></c:if>
								<c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}"><span class="badge02">무료배송</span></c:if>
							</div>
						</div>
                        </a>
                        </c:if>
                    </li>
                </c:forEach>
<%--             </c:if> --%>
        </c:forEach>
		</ul>
    </div>
    
</c:if>
