<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<script type="text/javascript">
$(function(){
    <c:if test="${decorator eq 'dvd'}">
        var sellPrdtBcodeList = [];
        $(".album_desc").each(function(){
            sellPrdtBcodeList.push($(this).attr("id").replace("desc",""));
        })
        
        $.ajax({
            url : "/ht/record/productDesc",
            data : {
                sellPrdtBcode : sellPrdtBcodeList.join(","),
            },
            success : function(result){
                if(result.descList){
                    for(i=0;i<result.descList.length;i++){
                        $("#desc"+result.descList[i].sellPrdtBcode).text(result.descList[i].prdtDesc)
                    }
                }
            }
        })
    </c:if>
});
</script>
<table>
    <colgroup>  
        <c:choose>
            <c:when test="${listViewRankYn eq 'Y'}">
                <col width="50px" />
                <col width="87px" />
                <col width="*" />
                <col width="125px" />
            </c:when>
            <c:otherwise>
                <col width="15%" />
                <col width="*" />
                <col width="100px" />
            </c:otherwise>
        </c:choose>
    </colgroup> 
    <tbody>
        <c:forEach items="${list}" var="l" varStatus="s">
            <tr>
                <c:if test="${listViewRankYn eq 'Y'}">
                    <td class="rank"><p class="best${l.rank}"><a>best ${l.rank}</a></p></td>
                </c:if>
                <td class="product">
                    <a href="/ht/record/detail/${l.sellPrdtBcode}" class="album_pic">
                       <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="85" alt="${l.rcrdName}" ratingCode="${l.ratingCode}" /></c:if>
                       <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="65" alt="${l.rcrdName}" ratingCode="${l.ratingCode}" /></c:if>
                    </a> 
                    <span class="album_zoom"><a title="새창열기" href="javascript:viewRecordWin('${l.sellPrdtBcode}', '${c.ctgrId}');"><img src="${imageServer}/images/music/product_zoom.gif" alt="새창열기" /></a></span> 
                </td>
                <td class="infor">  
                    <p class="album_title">
                       <a href="/ht/record/detail/${l.sellPrdtBcode}">
                           ${l.commTitle}
                           ${l.rcrdSubComments}
                           <c:if test="${l.rcrdStat eq '9'}"><img src="${imageServer}/images/product/icon_reserve.gif"></c:if>
                       </a>
                    </p>
                    <p class="album_artist">
                       ${l.artiName}<span class="seperate">|</span> 
                       ${l.makerName} <span class="seperate">|</span>
                       <ui:mask pattern="####년 ##월">${l.rlseDt}</ui:mask> 
                    </p> 
                    <p class="album_artist album_desc" id="desc${l.sellPrdtBcode }"></p>
                    <p class="price">
                        <c:if test="${l.prdtSellPrice ne l.lastDcPrice}">
                            <span class="ori_price"><fmt:formatNumber value="${l.prdtSellPrice}" pattern=",###" />원</span>
                            <span class="dis_price">
                                <fmt:formatNumber value="${l.lastDcPrice}" pattern=",###" />원 
                                <em>[${hfn:rate(l.prdtSellPrice, l.lastDcPrice)}%할인]</em>
                            </span>
                        </c:if>
                        <c:if test="${l.prdtSellPrice eq l.lastDcPrice}">
                            <span class="dis_price"><fmt:formatNumber value="${l.lastDcPrice}" pattern=",###" />원</span>
                        </c:if>
                        <c:if test="${l.prdtSavedRate > 0}">
                           <span class="save_price">
                               <span class="seperate">|</span> 
                               <fmt:formatNumber value="${l.lastDcPrice * l.prdtSavedRate / 100}" pattern=",###" />원
                               <em>[${l.prdtSavedRate}%적립]</em>
                           </span>
                        </c:if>
                        <c:if test="${l.freeDlvyYn eq 'Y'}"><span><img src="${imageServer}/images/common/icon_delivery01.gif" alt="무료배송" /></span></c:if>
                        <c:if test="${l.impYn eq 'Y'}"><span><img src="${imageServer}/images/music/icon_import.gif" alt="수입" /></span></c:if>
                    </p>
                </td> 
                <td class="down"> 
                    <c:if test="${l.saleYn eq 'Y'}">
                        <p>
                           <input name="chkRecord" type="checkbox" value="${l.sellPrdtBcode}" title="수량입력"/>
                           <input type="hidden" name="chkRecord_${l.sellPrdtBcode}" value="${l.rcrdCd}" />
                           <span class="count">
                               <img src="${imageServer}/images/music/text_count.gif" width="19" height="12" alt="수량" />
                               <input name="${l.sellPrdtBcode}_prdt_count" type="text" maxlength="4"  class="album_count" value="1" title="수량입력"/>
                           </span>
                        </p> 
                        <a title="새창열기" href="javascript:addRecordCart('${l.sellPrdtBcode}');"><img src="${imageServer}/images/music/btn_cart_s.gif" alt="장바구니에 담기" class="bt_m" /></a>
                        <a title="페이지이동" href="javascript:addRecordBuy('${l.sellPrdtBcode}');"><img src="${imageServer}/images/music/btn_buy.gif" alt="바로구매" class="bt_m" /></a>
                    </c:if>
                    <c:if test="${l.outOfStockMailYn eq 'Y' and isLogin}"><a title="새창열기" href="javascript:addRecordStockedInfoRequest('${l.rcrdCd}')"><img src="${imageServer}/images/music/btn_alm_reservation.gif" alt="알림예약" class="bt_m"></a></c:if>
                    <c:if test="${l.sellPrdtGbn eq 'R'}"><a title="새창열기" href="javascript:addMyListRecord('${l.rcrdCd}');"><img src="${imageServer}/images/music/btn_myList_s.gif" alt="마이리스트에 담기" /></a></c:if>
                    <c:if test="${l.sellPrdtGbn eq 'D'}"><a title="새창열기" href="javascript:addMyListDvd('${l.rcrdCd}');"><img src="${imageServer}/images/music/btn_myList_s.gif" alt="마이리스트에 담기" /></a></c:if>
                </td>
            </tr>
            <tr>
                <td class="review" colspan="<c:if test="${listViewRankYn eq 'Y'}">4</c:if><c:if test="${listViewRankYn ne 'Y'}">3</c:if>">
                    <p class="album_review">
                        <span class="left">${l.rcrdRlseInfo}</span> 
                        <c:if test="${l.reviewGrade ne 0}">
                            <span class="point">회원평점 
                                <img src="${imageServer}/images/music/star_${l.reviewGrade}.gif" alt="평점${l.reviewGrade}점"/>
                                <span class="seperate">|</span>
                            </span> 
                            <span class="text">회원리뷰 <em><strong>${l.reviewCount}</strong></em>개</span>
                        </c:if>
                            
                        <c:if test="${l.reviewGrade eq 0}">
                            <span class="point">회원평점 
                                <img src="${imageServer}/images/music/star_${l.reviewGrade}.gif" alt="평점${l.reviewGrade}점"/>
                                <span class="seperate">|</span>
                            </span> 
                            <span class="text">회원리뷰가 없습니다.</span>
                        </c:if>
                    </p>
                </td>
            </tr>  
        </c:forEach>
        <c:if test="${empty list}"><tr><td colspan="4" class="no">상품이 없습니다.</td></tr></c:if>   
    </tbody>  
</table>