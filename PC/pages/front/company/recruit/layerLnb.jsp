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
        <li><a href="/company/about/introduce"><img src="http://image.hottracks.co.kr/info/company/snb_hottracks<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/introduce') >= 0}">_on</c:if>.png" alt="핫트랙스소개" /></a></li>
        <li><a href="/company/about/history"><img src="http://image.hottracks.co.kr/info/company/snb_history<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/history') >= 0}">_on</c:if>.png" alt="연혁" /></a></li>
        <li><a href="/company/about/bi"><img src="http://image.hottracks.co.kr/info/company/snb_bi<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/bi') >= 0}">_on</c:if>.png" alt="B.I" /></a></li>
        <%-- <li><a href="/company/about/pr"><img src="http://image.hottracks.co.kr/info/company/snb_pr<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/pr') >= 0}">_on</c:if>.png" alt="PR" /></a></li> --%>
        <li><a href="/company/about/alliance"><img src="http://image.hottracks.co.kr/info/company/snb_part<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/alliance') >= 0}">_on</c:if>.png" alt="제휴안내" /></a></li>
        <li>
            <a href="/company/recruit/notice"><img src="http://image.hottracks.co.kr/info/btn/btn_snb02_01<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/recruit/') >= 0}">_on</c:if>.png" alt="채용정보"/></a>
            <ul class="threeDep" style="display:${fn:indexOf(pageContext.request.requestURI,'/company/recruit/') >= 0?'block':'none'};">
                <li class="threeDep"><a href="/company/recruit/notice"><img src="http://image.hottracks.co.kr/info/recruit/snb_notice<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/recruit/notice') >= 0}">_on</c:if>.png" alt="공지사항"/></a></li>
                <li class="threeDep"><a href="/company/recruit/recruit"><img src="http://image.hottracks.co.kr/info/recruit/snb_announce<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/recruit/recruit') >= 0}">_on</c:if>.png" alt="모집공고"/></a></li>
                <li class="threeDep"><a href="/company/recruit/process"><img src="http://image.hottracks.co.kr/info/recruit/snb_process<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/recruit/process') >= 0}">_on</c:if>.png" alt="채용프로세스"/></a></li>
                <li class="threeDep"><a href="/company/recruit/pass/agree">합격확인</a></li>
                <li class="threeDep"><a href="/company/recruit/position"><img src="http://image.hottracks.co.kr/info/recruit/snb_hr_work<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/recruit/position') >= 0}">_on</c:if>.png" alt="직무소개"/></a></li>
                <li class="threeDep"><a href="/company/recruit/career"><img src="http://image.hottracks.co.kr/info/recruit/snb_hr_career<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/recruit/career') >= 0}">_on</c:if>.png" alt="경력경로"/></a></li>
                <li class="threeDep"><a href="/company/recruit/support"><img src="http://image.hottracks.co.kr/info/recruit/snb_hr_support<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/recruit/support') >= 0}">_on</c:if>.png" alt="역량계발제도"/></a></li>
                <li class="threeDep"><a href="/company/recruit/welfare"><img src="http://image.hottracks.co.kr/info/recruit/snb_hr_welfare<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/recruit/welfare') >= 0}">_on</c:if>.png" alt="복리후생제도"/></a></li>
                <li class="threeDep"><a href="/company/recruit/faq">FAQ</a></li>
            </ul>
        </li>
        <li><a href="/company/about/fair"><img src="http://image.hottracks.co.kr/info/company/snb_fair<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/about/fair') >= 0}">_on</c:if>.png" alt="공정거래 자율준수" /></a></li>
        <li style="margin-top:20px;"><a href="/company/about/fair" title="공정거래 자율준수"><img src="http://image.hottracks.co.kr/info/company/banner_guard.gif" alt="공정거래 자율준수" /></a></li>
    </ul>
</div>
<!-- //SNB -->