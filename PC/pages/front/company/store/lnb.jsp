<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="none"/>
<div id="snb">
    <h2><img src="http://image.hottracks.co.kr/info/shop/snb_txt_shop.png" alt="������" /></h2>
    <ul>
        <c:set var="locGbnName" value=""/>
        <c:set var="locGbnCode" value=""/>
        <c:forEach items="${listStore}" var="l" varStatus="st">
            <c:if test="${locGbnName ne l.locGbnName}">
                <c:if test="${locGbnCode eq 'C1361'}">
                    <li><a class="snb_tit" href="http://www.workend.co.kr/" target="_blank" title="WORKEND�� �̵�">WORKEND</a></li>
                </c:if>
                <c:set var="locGbnCode" value="${l.locGbnCode}"/>
                <c:set var="locGbnName" value="${l.locGbnName}"/>
                <li class="tit_loc">${locGbnName}</li>
            </c:if>
            <li<c:if test="${c.deptcode eq l.deptcode}"> class="active"</c:if>>
                <a class="snb_tit" href="/company/store/main?deptcode=${l.deptcode}">${l.deptname}</a>
                <ol class="threeDep">
                    <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/store/board') >= 0}"> class="active"</c:if>><a href="/company/store/board?deptcode=${l.deptcode}">- ��������</a></li>
                    <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/store/event') >= 0}"> class="active"</c:if>><a href="/company/store/event?deptcode=${l.deptcode}">- ���ȳ�</a></li>
                    <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/store/story') >= 0}"> class="active"</c:if>><a href="/company/store/story?deptcode=${l.deptcode}">- ${l.deptname} �̾߱�</a></li>
                    <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/store/loc') >= 0}"> class="active"</c:if>><a href="/company/store/loc?deptcode=${l.deptcode}">- �൵/����</a></li>
                    <li><a href="http://www.kyobobook.co.kr/storen/MainStore.laf?SITE=${l.kyoboSite}" target="_blank">- ��������</a></li>
                </ol>
            </li>
        </c:forEach>
    </ul>
    <ul class="banner">
        <c:forEach items="${banners}" var="item" varStatus="status" begin="0" end="1">
            <li><a href="${item.linkurl }"><img src="http://info.hottracks.co.kr${item.imgurl}" alt="������ �����������ʴ�" width="172" height="65"/></a></li>
        </c:forEach>
    </ul>
</div>
