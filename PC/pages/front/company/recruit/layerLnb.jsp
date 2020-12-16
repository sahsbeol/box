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
        <li><a href="/company/about/introduce"><img src="http://image.hottracks.co.kr/info/company/snb_hottracks<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/introduce') >= 0}">_on</c:if>.png" alt="��Ʈ�����Ұ�" /></a></li>
        <li><a href="/company/about/history"><img src="http://image.hottracks.co.kr/info/company/snb_history<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/history') >= 0}">_on</c:if>.png" alt="����" /></a></li>
        <li><a href="/company/about/bi"><img src="http://image.hottracks.co.kr/info/company/snb_bi<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/bi') >= 0}">_on</c:if>.png" alt="B.I" /></a></li>
        <%-- <li><a href="/company/about/pr"><img src="http://image.hottracks.co.kr/info/company/snb_pr<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/pr') >= 0}">_on</c:if>.png" alt="PR" /></a></li> --%>
        <li><a href="/company/about/alliance"><img src="http://image.hottracks.co.kr/info/company/snb_part<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/alliance') >= 0}">_on</c:if>.png" alt="���޾ȳ�" /></a></li>
        <li>
            <a href="/company/recruit/notice"><img src="http://image.hottracks.co.kr/info/btn/btn_snb02_01<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/recruit/') >= 0}">_on</c:if>.png" alt="ä������"/></a>
            <ul class="threeDep" style="display:${fn:indexOf(pageContext.request.requestURI,'/company/recruit/') >= 0?'block':'none'};">
                <li class="threeDep"><a href="/company/recruit/notice"><img src="http://image.hottracks.co.kr/info/recruit/snb_notice<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/recruit/notice') >= 0}">_on</c:if>.png" alt="��������"/></a></li>
                <li class="threeDep"><a href="/company/recruit/recruit"><img src="http://image.hottracks.co.kr/info/recruit/snb_announce<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/recruit/recruit') >= 0}">_on</c:if>.png" alt="��������"/></a></li>
                <li class="threeDep"><a href="/company/recruit/process"><img src="http://image.hottracks.co.kr/info/recruit/snb_process<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/recruit/process') >= 0}">_on</c:if>.png" alt="ä�����μ���"/></a></li>
                <li class="threeDep"><a href="/company/recruit/pass/agree">�հ�Ȯ��</a></li>
                <li class="threeDep"><a href="/company/recruit/position"><img src="http://image.hottracks.co.kr/info/recruit/snb_hr_work<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/recruit/position') >= 0}">_on</c:if>.png" alt="�����Ұ�"/></a></li>
                <li class="threeDep"><a href="/company/recruit/career"><img src="http://image.hottracks.co.kr/info/recruit/snb_hr_career<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/recruit/career') >= 0}">_on</c:if>.png" alt="��°��"/></a></li>
                <li class="threeDep"><a href="/company/recruit/support"><img src="http://image.hottracks.co.kr/info/recruit/snb_hr_support<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/recruit/support') >= 0}">_on</c:if>.png" alt="�����������"/></a></li>
                <li class="threeDep"><a href="/company/recruit/welfare"><img src="http://image.hottracks.co.kr/info/recruit/snb_hr_welfare<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/recruit/welfare') >= 0}">_on</c:if>.png" alt="�����Ļ�����"/></a></li>
                <li class="threeDep"><a href="/company/recruit/faq">FAQ</a></li>
            </ul>
        </li>
        <li><a href="/company/about/fair"><img src="http://image.hottracks.co.kr/info/company/snb_fair<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/fair') >= 0}">_on</c:if>.png" alt="�����ŷ� �����ؼ�" /></a></li>
        <li style="margin-top:20px;"><a href="/company/about/fair" title="�����ŷ� �����ؼ�"><img src="http://image.hottracks.co.kr/info/company/banner_guard.gif" alt="�����ŷ� �����ؼ�" /></a></li>
    </ul>
</div>
<!-- //SNB -->