<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<title>레이블 입고 안내 | 수입음반 입고 안내 | CD - HOTTRACKS</title>
</head>
<body>
<!-- 가요 lnb -->
<div class="cate03">
    <h2 class="tit"><img src="${imageServer}/images/renewal/shop/tit_lable_stock.gif" alt="수입음반 입고안내" /></h2>
    <ul>
        <li><a href="#" class="on">레이블 입고 안내</a></li>
    </ul>
</div>

<div class="list_section">
    <!-- Location -->
    <div class="page_location">
        <div class="loc">
            <a href="/" class="home">Home</a><a href="/ht/biz/record/recordCategoryMain?ctgrId=0003">CD</a><a href="/ht/record/lableStockedList">수입음반 입고안내</a><em>레이블 입고 안내</em>
        </div>
    </div>
    <!-- //Location -->

    <h3 class="tit03">레이블 입고 안내</h3>
    <div class="tab_lable">
        <ul>
            <li><a href="/ht/record/lableStockedList"<c:if test="${empty param.labelGbn }"> class="on"</c:if>><span>전체</span></a></li>
            <li><a href="/ht/record/lableStockedList?labelGbn=C0901"<c:if test="${param.labelGbn eq 'C0901'}"> class="on"</c:if>><span>팝</span></a></li>
            <li><a href="/ht/record/lableStockedList?labelGbn=C0902"<c:if test="${param.labelGbn eq 'C0902'}"> class="on"</c:if>><span>클래식</span></a></li>
        </ul>
    </div>

    <!-- list -->
    <table class="bbs_list01">
        <caption>레이블 입고 안내 <span>새로 입고된 레이블, 날짜</span></caption>
        <colgroup>
            <col width="*">
            <col width="140">
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir t_left">새로 입고된 레이블</th>
                <th scope="col" class="last">날짜</th>
            </tr>
        </thead>
        <tbody>
            <c:if test="${empty list}"><tr><td colspan="2" class="no_data">새로 입고된 레이블이 없습니다.</td></tr></c:if>
            <c:forEach items="${list}" var="l">
                <tr>
                    <td class="t_left"><a href="/ht/record/lableStockedDetail?labelClassId=${l.labelClassId}">${l.clssName}</a></td>
                    <td><fmt:formatDate value="${l.regstDtm }" pattern="yyyy.MM.dd"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <!-- //list -->
    <!-- paging -->
    <div class="paging">
        <ui:pagination name="pageHolder" url="/ht/record/lableStockedList" parameters="labelGbn"/>
    </div>
    <!-- //paging -->
</div>
</body>
</html>