<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@ taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="popup"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<script type="text/javascript">
function showOpenerDetail() {
    if (parent.opener) {
        parent.opener.location.href = "/ht/product/detail?barcode=${detail.product.barcode}&ctgrId=${detail.category.cateId}";
        window.close();
    }
}
</script>
</head>
<body>
<div style="width:783px;">
    <h1><img src="${imageServer}/images/renewal/common/tit_pop_product_info.gif" alt="상품기본정보" /></h1>
    <div class="pop_cont">
        <div class="pop_detail clear">
            <div class="detail_cont">
                <!-- 상품배너 -->
                <div class="view_banner tab_wrap">
                    <ul class="slide_btn tab_btn">
                        <c:if test="${detail.product.gbn ne 'D' && detail.product.gbn ne 'R'}">
                            <c:forEach items="${detail.images}" var="thumnail" varStatus="st">
                                <li><a href="#vb<ui:lpad length="2" padChar="0">${st.count}</ui:lpad>"><span><ui:image src="${thumnail.imageUrl}" size="400" server="product" alt="썸네일 ${st.count}"/></span><span class="over"></span></a></li>
                            </c:forEach>
                        </c:if>
                    </ul>
                    <div class="slide_pannels tab_pannels">
                        <c:if test="${detail.product.gbn ne 'D' && detail.product.gbn ne 'R'}">
                            <c:forEach items="${detail.images}" var="thumnail" varStatus="st">
                                <div id="vb<ui:lpad length="2" padChar="0">${st.count}</ui:lpad>" class="pannel"><ui:image src="${thumnail.imageUrl}" size="400" server="product" alt="썸네일 ${st.count}"/></div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${detail.product.gbn eq 'D' || detail.product.gbn eq 'R'}">
                            <div id="vb01" class="pannel">
                                <ui:image rcrdCd="${detail.product.rcrdCd}" prdtGbn="${detail.product.gbn}" id="primeImageTag" width="400" ratingCode="A" />
                            </div>
                        </c:if>
                    </div>
                </div>
                <!-- //상품배너 -->
                <div class="detail_info">
                    <span class="company">${detail.brand.brandName}</span>
                    <h2 class="tit">${detail.product.name}</h2>
                    <ul>
                        <li>
                            <span class="tit">판매가</span>
                            <div class="price">
                                <c:if test="${detail.product.sellPrice <= detail.product.lastDiscountPrice}">
                                    <strong><fmt:formatNumber value="${detail.product.lastDiscountPrice}" pattern=",###" /></strong>
                                </c:if>
                                <c:if test="${detail.product.sellPrice > detail.product.lastDiscountPrice}">
                                    <span class="ori_price"><fmt:formatNumber value="${detail.product.sellPrice}" pattern=",###" /></span>
                                    <strong><fmt:formatNumber value="${detail.product.lastDiscountPrice}" pattern=",###" /></strong> (${hfn:rate(detail.product.sellPrice, detail.product.lastDiscountPrice)}%)
                                </c:if>
                            </div>
                        </li>
                        <li>
                            <span class="tit">통합포인트</span>
                            <div>
                                <c:set var="savedPrice" value="${detail.product.lastDiscountPrice * detail.product.savedRate / 100}"/>
                                <span class="w100">${detail.product.savedRate}%적립 (+<fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" pattern=",###" />원)</span>
                                <div class="tooltip_wrap">
                                    <a href="#tooltip3" class="tooltip">?</a>
                                    <div id="tooltip3" class="layer_pop_wrap">
                                        <div class="layer_pop_container" style="width:289px;height:433px;">
                                            <h1>통합포인트 안내</h1>
                                            <div class="layer_pop_cont">
                                                <ul class="bu_list">
                                                    <li><span class="bu">•</span><strong>핫트랙스 온라인/오프라인, 교보문고 온라인/오프라인, 모바일 교보문고에서 모두 적립&middot;사용 가능!</strong></li>
                                                    <li><span class="bu">•</span><strong>10원 이상의 포인트도 바로바로 사용! (영업점은 1,000원 단위 사용)</strong><br />주문 시, 10원 단위부터 사용하실 수 있습니다.</li>
                                                    <li><span class="bu">•</span><strong>자동적립되는 편리한 포인트!</strong><br />구매 후 어떤 절차나 과정없이 바로 자동으로 적립됩니다.</li>
                                                    <li><span class="bu">•</span><strong>포인트 확인도 폭넓~게!</strong><br />온라인 마이룸, 모바일, 무인가입기, 영업점 영수증 등에서 적립하거나 사용하신 포인트 내역을 확인하실 수 있습니다.<br />
                                                    상품 구매 시 해당 상품의 적립률에 따라 지급되며 고객님께서 주문하신 상품이 발송완료 된 후 자동 지급됩니다.<br />단, 쿠폰 또는 마일리지, 통합포인트 사용 시 예상적립금이 변동될 수 있습니다.<br />(주문취소나 반품시에는 적립된 통합포인트가 다시 차감됩니다.)</li>
                                                </ul>
                                            </div>
                                            <a href="#none" class="cls_btn" title="레이어팝업 닫기"><img src="${imageServer}/images/renewal/common/btn_cls.gif" alt="닫기" /></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                    <div class="btn_wrap mgt20">
                        <a href="javascript://" onclick="showOpenerDetail()" class="btn_type11">자세히보기</a>
                        <a href="javascript://" onclick="addWishProduct('${detail.product.barcode}')" class="btn_type12">좋아요♥</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="pop_close">
        <a href="javascript://" onclick="self.close()">닫기</a>
    </div>
</div>
</body>
</html>