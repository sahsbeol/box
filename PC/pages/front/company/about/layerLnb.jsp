<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!-- SNB -->
<div id="snb">
    <p><img src="http://image.hottracks.co.kr/info/company/txt_snb_company.png" alt="ȸ��Ұ�"/></p>
    <ul>
        <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/introduce') >= 0}"> class="active"</c:if>><a href="/company/about/introduce" class="snb_tit">��Ʈ�����Ұ�</a></li>
        <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/history') >= 0}"> class="active"</c:if>><a href="/company/about/history" class="snb_tit">����</a></li>
        <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/bi') >= 0}"> class="active"</c:if>><a href="/company/about/bi" class="snb_tit">B.I</a></li>
        <%-- <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/pr') >= 0}"> class="active"</c:if>><a href="/company/about/pr" class="snb_tit">PR</a></li> --%>
        <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/alliance') >= 0}"> class="active"</c:if>><a href="/company/about/alliance" class="snb_tit">���޾ȳ�</a></li>
        <li><a href="http://info.hottracks.co.kr/company/recruit/notice" target="_blank" class="snb_tit">ä������</a></li>
        <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/fair') >= 0}"> class="active"</c:if>><a href="/company/about/fair" class="snb_tit">�����ŷ� �����ؼ�</a></li>
        <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/moral') >= 0}"> class="active"</c:if>><a href="/company/about/moral" class="snb_tit">�����濵</a></li>
        <li style="margin-top:20px;"><a href="/company/about/fair" title="�����ŷ� �����ؼ�"><img src="http://image.hottracks.co.kr/info/company/banner_guard.gif" alt="�����ŷ� �����ؼ�" /></a></li>
        <li style="margin-top:10px;"><a href="/company/about/moral?target=3" title="���̹� �Ź���"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/company/about/cyber/cyber_bn.jpg" alt="���̹� �Ź���" /></a></li>
    </ul>
</div>
<!-- //SNB -->