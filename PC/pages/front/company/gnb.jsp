<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!-- Header -->
<div id="header">
    <div id="header_detail">
        <h1 class="logo"><a href="${defaultHost}/ht/welcomeMain">New Me Hottracks</a></h1>
        <!-- GNB -->
        <ul class="gnb-menu">
            <li class="gnb-item" id="gnb-item01"><a href="${defaultHost}/ht/welcomeMain"><strong>온라인몰</strong><span>On-Line Mall</span></a></li>
            <li class="gnb-item" id="gnb-item02">
                <span class="gnb-item-title"><a href="${defaultHost}/company/main"><strong>영업점</strong><span>Off-Line Store</span></a></span>
                <div class="snb-menu snb-twice">
                    <ol>
                        <c:forEach items="${listStore}" var="l" varStatus="st">
                            <li class="<c:if test="${st.first}">first</c:if><c:if test="${st.last}">first</c:if>"><a href="${defaultHost}/company/store/main?deptcode=${l.deptcode}">${l.deptname}</a></li>
                        </c:forEach>
                        <li><a href="http://www.workend.co.kr/" target="_blank">WORKEND</a></li>
                    </ol>
                </div>
            </li>
            <li class="gnb-item" id="gnb-item03">
                <span class="gnb-item-title"><a href="${defaultHost}/company/story/notice"><strong>이야기</strong><span>Story</span></a></span>
                <div class="snb-menu">
                    <ol>
                        <li class="first"><a href="${defaultHost}/company/story/notice" title="알려드립니다">알려드립니다</a></li>
                        <li><a href="${defaultHost}/company/story/event" title="이벤트">이벤트</a></li>
                        <li><a href="${defaultHost}/company/story/sign" title="사인회">사인회</a></li>
                        <li class="last"><a href="${defaultHost}/company/story/story" title="핫트랙스이야기">핫트랙스이야기</a></li>
                    </ol>
                </div>
            </li>
            <li class="gnb-item" id="gnb-item04">
                <span class="gnb-item-title"><a href="${defaultHost}/company/about/introduce"><strong>회사소개/채용</strong><span>Company</span></a></span>
                <div class="snb-menu">
                    <ol>
                        <li class="first"><a href="${defaultHost}/company/about/introduce" title="회사소개">회사소개</a></li>
                        <li><a href="${defaultHost}/company/about/history" title="연혁">연혁</a></li>
                        <li><a href="${defaultHost}/company/about/bi" title="B.I">B.I</a></li>
                        <%-- <li><a href="${defaultHost}/company/about/pr" title="PR">PR</a></li> --%>
                        <li><a href="${defaultHost}/company/about/alliance" title="제휴안내">제휴안내</a></li>
                        <li><a href="http://info.hottracks.co.kr/company/recruit/notice" target="_blank" title="인재채용">인재채용</a></li>
                        <li><a href="${defaultHost}/company/about/fair" title="공정거래 자율준수">공정거래 자율준수</a></li>
                        <li class="last"><a href="${defaultHost}/company/about/moral" title="윤리경영">윤리경영</a></li> 
                    </ol>
                </div>
            </li>
        </ul>
        <!-- //GNB -->
        </div>
</div>
<!-- //Header -->