<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!-- SNB -->
<div id="snb">
    <p><img src="http://image.hottracks.co.kr/info/company/txt_snb_company.png" alt="회사소개"/></p>
    <ul>
        <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/introduce') >= 0}"> class="active"</c:if>><a href="/company/about/introduce" class="snb_tit">핫트랙스소개</a></li>
        <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/history') >= 0}"> class="active"</c:if>><a href="/company/about/history" class="snb_tit">연혁</a></li>
        <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/bi') >= 0}"> class="active"</c:if>><a href="/company/about/bi" class="snb_tit">B.I</a></li>
        <%-- <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/pr') >= 0}"> class="active"</c:if>><a href="/company/about/pr" class="snb_tit">PR</a></li> --%>
        <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/alliance') >= 0}"> class="active"</c:if>><a href="/company/about/alliance" class="snb_tit">제휴안내</a></li>
        <li><a href="http://info.hottracks.co.kr/company/recruit/notice" target="_blank" class="snb_tit">채용정보</a></li>
        <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/fair') >= 0}"> class="active"</c:if>><a href="/company/about/fair" class="snb_tit">공정거래 자율준수</a></li>
        <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/moral') >= 0}"> class="active"</c:if>><a href="/company/about/moral" class="snb_tit">윤리경영</a></li>
        <li style="margin-top:20px;"><a href="/company/about/fair" title="공정거래 자율준수"><img src="http://image.hottracks.co.kr/info/company/banner_guard.gif" alt="공정거래 자율준수" /></a></li>
        <li style="margin-top:10px;"><a href="/company/about/moral?target=3" title="사이버 신문고"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/company/about/cyber/cyber_bn.jpg" alt="사이버 신문고" /></a></li>
    </ul>
</div>
<!-- //SNB -->