<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="none"/>
<c:forEach items="${list}" var="l" varStatus="st" end="0">
    <c:set var="store" value="${l}"/>
</c:forEach>
<style>
#shopinfo_event {
    padding: 0px;
}
</style>

<div id="shopinfo_name">
    <span><a href="${defaultHost}/m/help/store/${store.rdpCode}"><img src="${imageServer}/images/mobile/content/shop_my_img.png" alt="myimg"></a></span>
    <p><strong class="col_orange">${userName}</strong>님과<br>가장 가까운 핫트랙스 매장</p>
</div>
<!-- shop list -->
<div id="shopinfo_list">
    <c:forEach items="${list}" var="l" varStatus="st">
        <c:choose>
            <c:when test="${st.first}">
                <div id="shopinfo_slecet">
                    <dl>
                        <dt><a href="${defaultHost}/m/help/store/${l.rdpCode}"><strong>${l.deptname}</strong></a></dt>
                        <dd><ui:br>${l.rdpAddr}</ui:br></dd>
                        <dt>시간</dt>
                        <dd><ui:br>${l.rdpTime}</ui:br></dd>
                        <dt>대표전화</dt>
                        <dd><a href="#" onclick="window.open('tel:${l.rdpTlnm}');return false;"><strong>${l.rdpTlnm}</strong><img src="${imageServer}/images/mobile/content/icon_telephone.jpg" class="shop_tel" alt="전화걸기"></a></dd>
                        <div class="s_tel"></div>
                        <dt>정기휴일</dt>
                        <dd><ui:br>${l.rdpOffday}</ui:br></dd>
                        <dt>주차안내</dt>
                        <dd>회원등급별무료주차상이<div class="btn_area"><a class="btn" href="${defaultHost}/m/help/createCounselForm">문의하기 ></a></div></dd>
                    </dl>
                </div>
                <!-- shop event -->
                <div id="shopinfo_event">
                    <div class="hotevent">
                        <div class="banner_basic t_c">
                            <ul id="eventList">
                                <c:forEach items="${l.childList}" var="evt" varStatus="st">
                                    <li>
                                        <a href="${defaultHost}/m/help/storeBoard?bbsRegType=${evt.bbsRegType}&boardseq=${evt.boardseq}&rdpCode=${l.rdpCode}">
                                            <c:if test="${not empty evt.imgurl}">
                                                <c:if test="${evt.bbsRegType eq 'M'}">
                                                    <p style="max-height:150px;overflow:hidden;"><ui:image src="${evt.imgurl}" alt="${evt.title}" style="max-height:initial;border-radius:2px;"/></p>
                                                </c:if>
                                                <c:if test="${evt.bbsRegType eq 'H'}">
                                                    <p><img src="http://info.hottracks.co.kr${evt.imgurl}"  alt="${evt.title}" style="border-radius:2px;"/></p>
                                                </c:if>
                                            </c:if>
                                            <p class="tit"><strong>행사명 : ${evt.title}</strong></p>
                                            <c:choose>
                                                <c:when test="${evt.enddate eq '20180101' && evt.bbsRegType eq 'M'}">
                                                    <p class="txt">이벤트 기간 : <ui:mask pattern="####.##.##">${evt.startdate}</ui:mask> ~ 재고소진시까지</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <p class="txt">이벤트 기간 : <ui:mask pattern="####.##.##">${evt.startdate}</ui:mask> ~ <ui:mask pattern="####.##.##">${evt.enddate}</ui:mask></p>
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <c:if test="${fn:length(l.childList) > 1}">
                            <div class="btn_area"><a class="btn" id="btnEventMore${l.rdpCode}" href="javascript:loadEvent('#btnEventMore${l.rdpCode}');">이벤트 더보기 +</a></div>
                        </c:if>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="sbox_basic">
                    <div class="box_list">
                        <a href="${defaultHost}/m/help/store/${l.rdpCode}"><span><img src="${imageServer}/images/company/scr_store_${l.rdpCode}.jpg" alt="${l.deptname}" onerror="this.src='${imageServer}/images/company/scr_store_base.jpg';"/></span></a>
                        <ul>
                            <li><a href="${defaultHost}/m/help/store/${l.rdpCode}"><strong>${l.deptname}</strong></a></li>
                            <c:if test="${l.distince ne '-1'}">
                                <fmt:formatNumber value="${l.distince}" var="distance" type="number"/> 
                                <li>위치 <em>${distance}km</em></li>
                            </c:if>
                            <li>시간 <em><ui:br>${fn:replace(l.rdpTime, ' ', '')}</ui:br></em></li>
                            <c:forEach items="${l.childList}" var="evt" varStatus="st" end="0">
                                <li class="mt5"><a href="${defaultHost}/m/help/storeBoard?bbsRegType=${evt.bbsRegType}&boardseq=${evt.boardseq}&rdpCode=${l.rdpCode}"><span>EVENT</span><strong class="ml5">${evt.title}</strong></a></li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </c:forEach>
</div>
<!-- //shop list -->
