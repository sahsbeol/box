<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none" />
<c:forEach items="${list}" var="detail" varStatus="s1">
    <li id="crtMst${detail.crtSeq}" class="curate-item" style="display:none;">
        <div class="curate-info">
            <div class="btn_sns">
                <a class="tw" href="javascript://" onclick="goTwitter('${fn:escapeXml(detail.crtTitle)}', '${defaultHost}/ht/hot/curateDetail?crtSeq=${detail.crtSeq}')" title="트위터에 공유하기"><img src="${imageServer}/images/renewal/common/btn_twitter_square.gif" alt="twitter"/></a>
                <a class="fa" href="javascript://" onclick="goFaceBook('${fn:escapeXml(detail.crtTitle)}', '${defaultHost}/ht/hot/curateDetail?crtSeq=${detail.crtSeq}')" title="페이스북에 공유하기"><img src="${imageServer}/images/renewal/common/btn_facebook_square.gif" alt="facebook"/></a>
                <a class="pi" href="javascript://" onclick="goPinterest('${fn:escapeXml(detail.crtTitle)}', '${defaultHost}/ht/hot/curateDetail?crtSeq=${detail.crtSeq}')" title="핀터레이스트에 공유하기"><img src="${imageServer}/images/renewal/common/btn_pinterest_square.gif" alt="pinterest" nopin="true"/></a>
            </div>
            <dl>
                <dt>
                    <span class="photo"><img src="${imageServer}${detail.emtcUrl}" alt="아이디" style="width:48px;"/></span>
                    <span class="wrtor"><ui:idAsterisk value="${detail.userId}"/></span>
                    <span class="title txt_line1" title="${fn:escapeXml(detail.crtTitle)}">${fn:escapeXml(detail.crtTitle)}</span>
                    <span class="desc txt_line1" title="${fn:escapeXml(detail.crtDesc)}">${fn:escapeXml(detail.crtDesc)}</span>
                    <div class="btn_area">
                        <span class="btn_box" id="btnChildCmnt${detail.crtSeq}"><a href="javascript://" onclick="toggleCurateComment('${detail.crtSeq}')" class="btn_cmnt"><fmt:formatNumber pattern=",###">${detail.cntCmnt}</fmt:formatNumber></a></span>
                        <span class="btn_box"><a href="javascript://" onclick="likeCurate('${detail.crtSeq}')" class="btn_like"><fmt:formatNumber pattern=",###">${detail.cntLike}</fmt:formatNumber></a></span>
                        <c:if test="${detail.userNum eq loginUser.num}">
                            <span class="btn_box"><a href="javascript://" onclick="editCurateFrm('${detail.eventId}', '${detail.crtSeq}')" class="btn_mod">수정</a></span>
                        </c:if>
                    </div>
                </dt>
                <c:forEach items="${detail.prdtList}" var="l" varStatus="st" end="3">
                    <dd>
                        <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                            <a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.rtngCode}" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'150':'99'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a>
                        </c:if>
                        <c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}">
                            <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}"><ui:image src="${l.prdtImgUrl}" src2="${l.prdtImgUrl2}" size="150" server="product" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a>
                        </c:if>
                        <a href="/p/${l.sellPrdtBcode}">
                            <span class="name txt_line1">${l.brandName}</span>
                            <em class="price">
                                <c:if test="${l.prdtSellPrice > l.lastCpnPrice}"><span class="dc"><fmt:formatNumber value="${l.prdtSellPrice}" pattern="#,###"/></span></c:if>
                                <span class="sale"><fmt:formatNumber value="${l.lastCpnPrice}" pattern="#,###"/></span>
                                <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                <c:if test="${l.prdtStatCode eq 'C0312' && l.prdtSellPrice > l.lastCpnPrice}"><span class="pc">${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}%</span></c:if>
                            </em>
                        </a>
                    </dd>
                </c:forEach>
                <c:forEach begin="${fn:length(detail.prdtList)}" end="3">
                    <dd><img src="${imageServer}/images/renewal/common/no_image3.jpg" alt="이미지가 없습니다." style="width:150px;height:150px;"/></dd>
                </c:forEach>
            </dl>
            <a href="/ht/hot/curateDetail?crtSeq=${detail.crtSeq}" class="btn_more">상품 더보기</a>
        </div>
        <div class="comment_inlist" id="childComment${detail.crtSeq}"></div>
    </li>
</c:forEach>