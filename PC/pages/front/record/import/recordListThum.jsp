<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
                        <ul>
                            <c:forEach items="${list}" var="l" varStatus="s">
	                            <li>
	                                <c:if test="${listViewRankYn eq 'Y'}">
	                                   <p class="rank"><span class="best${l.rank}"><a>best ${l.rank}</a></span></p>
	                                </c:if>
                                    <p class="check">
	                                    <c:if test="${l.saleYn eq 'Y'}">
	                                        <input name="chkRecord" type="checkbox" value="${l.sellPrdtBcode}" />
	                                        <input type="hidden" name="chkRecord_${l.sellPrdtBcode}" value="${l.rcrdCd}" />
	                                        <input name="${l.sellPrdtBcode}_prdt_count" type="hidden" class="album_count" value="1" />
	                                    </c:if>
                                    </p> 
	                                <p class="album_pic">
	                                   <a href="/ht/record/detail/${l.sellPrdtBcode}" class="album_pic">
                                           <c:if test="${l.sellPrdtGbn eq 'R'}">
                                              <ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="85" alt="${l.rcrdName}" ratingCode="${l.ratingCode}" />
                                           </c:if>
                                           <c:if test="${l.sellPrdtGbn eq 'D'}">
                                              <ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="65" alt="${l.rcrdName}" ratingCode="${l.ratingCode}" />
                                           </c:if>
	                                   </a>
	                                </p>
	                                <p class="album_title"><a href="/ht/record/detail/${l.sellPrdtBcode}">${l.commTitle}</a></p>
	                                <p class="album_artist">${l.artiName}</p>
	                                <p class="price">
	                                   <fmt:formatNumber value="${l.lastDcPrice}" pattern=",###" />원
	                                   <c:if test="${l.prdtSellPrice ne l.lastDcPrice or l.prdtSavedRate > 0}"> 
		                                   <em>
		                                       [
		                                          <c:if test="${l.prdtSellPrice ne l.lastDcPrice}">
		                                              ${hfn:rate(l.prdtSellPrice, l.lastDcPrice)}%↓
		                                          </c:if>
		                                          <c:if test="${l.prdtSavedRate > 0}">
		                                              ${l.prdtSavedRate}%P
		                                          </c:if>
		                                       ]
		                                   </em>
	                                   </c:if>
	                                </p>
	                            </li>
	                        </c:forEach>
                        </ul>