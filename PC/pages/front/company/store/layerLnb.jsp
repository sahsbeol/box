<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div id="snb">
    <h2><img src="/images/company/shop/snb_txt_shop.png" alt="영업점" /></h2>
    <ul>
        <li>
            <a href="/company/store/main?storeId=03"><img alt="광화문점" src="/images/company/shop/snb_store_03${c.storeId eq '03'?'_on':''}.png"></a>
            <ul style="display:${c.storeId eq '03'?'block':'none'};" class="threeDep">
                <li class="threeDep"><a href="/company/store/event?storeId=03"><img alt="이벤트안내" src="/images/company/shop/snb_store_event${fn:indexOf(pageContext.request.requestURI,'event') >= 0?'_on':''}.png"></a></li>
                <li class="threeDep"><a href="/company/store/story?storeId=03"><img alt="광화문점이야기" src="/images/company/shop/snb_store_story_03${fn:indexOf(pageContext.request.requestURI,'story') >= 0?'_on':''}.png"></a></li>
            </ul>
        </li>
        <li>
            <a href="/company/store/main?storeId=10"><img alt="강남점" src="/images/company/shop/snb_store_10${c.storeId eq '10'?'_on':''}.png"></a>
            <ul style="display:${c.storeId eq '10'?'block':'none'};" class="threeDep">
                <li class="threeDep"><a href="/company/store/event?storeId=10"><img alt="이벤트안내" src="/images/company/shop/snb_store_event${fn:indexOf(pageContext.request.requestURI,'event') >= 0?'_on':''}.png"></a></li>
                <li class="threeDep"><a href="/company/store/story?storeId=10"><img alt="강남점이야기" src="/images/company/shop/snb_store_story_10${fn:indexOf(pageContext.request.requestURI,'story') >= 0?'_on':''}.png"></a></li>
            </ul>
        </li>
        <li>
            <a href="/company/store/main?storeId=21"><img alt="잠실점" src="/images/company/shop/snb_store_21${c.storeId eq '21'?'_on':''}.png"></a>
            <ul style="display:${c.storeId eq '21'?'block':'none'};" class="threeDep">
                <li class="threeDep"><a href="/company/store/event?storeId=21"><img alt="이벤트안내" src="/images/company/shop/snb_store_event${fn:indexOf(pageContext.request.requestURI,'event') >= 0?'_on':''}.png"></a></li>
                <li class="threeDep"><a href="/company/store/story?storeId=21"><img alt="잠실점이야기" src="/images/company/shop/snb_store_story_21${fn:indexOf(pageContext.request.requestURI,'story') >= 0?'_on':''}.png"></a></li>
            </ul>
        </li>
        <li>
            <a href="/company/store/main?storeId=27"><img alt="목동점" src="/images/company/shop/snb_store_27${c.storeId eq '27'?'_on':''}.png"></a>
            <ul style="display:${c.storeId eq '27'?'block':'none'};" class="threeDep">
                <li class="threeDep"><a href="/company/store/event?storeId=27"><img alt="이벤트안내" src="/images/company/shop/snb_store_event${fn:indexOf(pageContext.request.requestURI,'event') >= 0?'_on':''}.png"></a></li>
                <li class="threeDep"><a href="/company/store/story?storeId=27"><img alt="목동점이야기" src="/images/company/shop/snb_store_story_27${fn:indexOf(pageContext.request.requestURI,'story') >= 0?'_on':''}.png"></a></li>
            </ul>
        </li>
        <li>
            <a href="/company/store/main?storeId=50"><img alt="수유점" src="/images/company/shop/snb_store_50${c.storeId eq '50'?'_on':''}.png"></a>
            <ul style="display:${c.storeId eq '50'?'block':'none'};" class="threeDep">
                <li class="threeDep"><a href="/company/store/event?storeId=50"><img alt="이벤트안내" src="/images/company/shop/snb_store_event${fn:indexOf(pageContext.request.requestURI,'event') >= 0?'_on':''}.png"></a></li>
                <li class="threeDep"><a href="/company/store/story?storeId=50"><img alt="수유점이야기" src="/images/company/shop/snb_store_story_50${fn:indexOf(pageContext.request.requestURI,'story') >= 0?'_on':''}.png"></a></li>
            </ul>
        </li>
        <li>
            <a href="/company/store/main?storeId=31"><img alt="영등포점" src="/images/company/shop/snb_store_31${c.storeId eq '31'?'_on':''}.png"></a>
            <ul style="display:${c.storeId eq '31'?'block':'none'};" class="threeDep">
                <li class="threeDep"><a href="/company/store/event?storeId=31"><img alt="이벤트안내" src="/images/company/shop/snb_store_event${fn:indexOf(pageContext.request.requestURI,'event') >= 0?'_on':''}.png"></a></li>
                <li class="threeDep"><a href="/company/store/story?storeId=31"><img alt="영등포점이야기" src="/images/company/shop/snb_store_story_31${fn:indexOf(pageContext.request.requestURI,'story') >= 0?'_on':''}.png"></a></li>
            </ul>
        </li>
        <li>
            <a href="/company/store/main?storeId=25"><img alt="분당점" src="/images/company/shop/snb_store_25${c.storeId eq '25'?'_on':''}.png"></a>
            <ul style="display:${c.storeId eq '25'?'block':'none'};" class="threeDep">
                <li class="threeDep"><a href="/company/store/event?storeId=25"><img alt="이벤트안내" src="/images/company/shop/snb_store_event${fn:indexOf(pageContext.request.requestURI,'event') >= 0?'_on':''}.png"></a></li>
                <li class="threeDep"><a href="/company/store/story?storeId=25"><img alt="분당점이야기" src="/images/company/shop/snb_store_story_25${fn:indexOf(pageContext.request.requestURI,'story') >= 0?'_on':''}.png"></a></li>
            </ul>
        </li>
        <li>
            <a href="/company/store/main?storeId=22"><img alt="안양점" src="/images/company/shop/snb_store_22${c.storeId eq '22'?'_on':''}.png"></a>
            <ul style="display:${c.storeId eq '22'?'block':'none'};" class="threeDep">
                <li class="threeDep"><a href="/company/store/event?storeId=22"><img alt="이벤트안내" src="/images/company/shop/snb_store_event${fn:indexOf(pageContext.request.requestURI,'event') >= 0?'_on':''}.png"></a></li>
                <li class="threeDep"><a href="/company/store/story?storeId=22"><img alt="안양점이야기" src="/images/company/shop/snb_store_story_22${fn:indexOf(pageContext.request.requestURI,'story') >= 0?'_on':''}.png"></a></li>
            </ul>
        </li>
        <li>
            <a href="/company/store/main?storeId=28"><img alt="천안점" src="/images/company/shop/snb_store_28${c.storeId eq '28'?'_on':''}.png"></a>
            <ul style="display:${c.storeId eq '28'?'block':'none'};" class="threeDep">
                <li class="threeDep"><a href="/company/store/event?storeId=28"><img alt="이벤트안내" src="/images/company/shop/snb_store_event${fn:indexOf(pageContext.request.requestURI,'event') >= 0?'_on':''}.png"></a></li>
                <li class="threeDep"><a href="/company/store/story?storeId=28"><img alt="천안점이야기" src="/images/company/shop/snb_store_story_28${fn:indexOf(pageContext.request.requestURI,'story') >= 0?'_on':''}.png"></a></li>
            </ul>
        </li>
        <li>
            <a href="/company/store/main?storeId=70"><img alt="대구점" src="/images/company/shop/snb_store_70${c.storeId eq '70'?'_on':''}.png"></a>
            <ul style="display:${c.storeId eq '70'?'block':'none'};" class="threeDep">
                <li class="threeDep"><a href="/company/store/event?storeId=70"><img alt="이벤트안내" src="/images/company/shop/snb_store_event${fn:indexOf(pageContext.request.requestURI,'event') >= 0?'_on':''}.png"></a></li>
                <li class="threeDep"><a href="/company/store/story?storeId=70"><img alt="대구점이야기" src="/images/company/shop/snb_store_story_70${fn:indexOf(pageContext.request.requestURI,'story') >= 0?'_on':''}.png"></a></li>
            </ul>
        </li>
        <li>
            <a href="/company/store/main?storeId=23"><img alt="창원점" src="/images/company/shop/snb_store_23${c.storeId eq '23'?'_on':''}.png"></a>
            <ul style="display:${c.storeId eq '23'?'block':'none'};" class="threeDep">
                <li class="threeDep"><a href="/company/store/event?storeId=23"><img alt="이벤트안내" src="/images/company/shop/snb_store_event${fn:indexOf(pageContext.request.requestURI,'event') >= 0?'_on':''}.png"></a></li>
                <li class="threeDep"><a href="/company/store/story?storeId=23"><img alt="창원점이야기" src="/images/company/shop/snb_store_story_23${fn:indexOf(pageContext.request.requestURI,'story') >= 0?'_on':''}.png"></a></li>
            </ul>
        </li>
        <li>
            <a href="/company/store/main?storeId=26"><img alt="부산점" src="/images/company/shop/snb_store_26${c.storeId eq '26'?'_on':''}.png"></a>
            <ul style="display:${c.storeId eq '26'?'block':'none'};" class="threeDep">
                <li class="threeDep"><a href="/company/store/event?storeId=26"><img alt="이벤트안내" src="/images/company/shop/snb_store_event${fn:indexOf(pageContext.request.requestURI,'event') >= 0?'_on':''}.png"></a></li>
                <li class="threeDep"><a href="/company/store/story?storeId=26"><img alt="부산점이야기" src="/images/company/shop/snb_store_story_26${fn:indexOf(pageContext.request.requestURI,'story') >= 0?'_on':''}.png"></a></li>
            </ul>
        </li>
        <li>
            <a href="/company/store/main?storeId=29"><img alt="센텀시티점" src="/images/company/shop/snb_store_29${c.storeId eq '29'?'_on':''}.png"></a>
            <ul style="display:${c.storeId eq '29'?'block':'none'};" class="threeDep">
                <li class="threeDep"><a href="/company/store/event?storeId=29"><img alt="이벤트안내" src="/images/company/shop/snb_store_event${fn:indexOf(pageContext.request.requestURI,'event') >= 0?'_on':''}.png"></a></li>
                <li class="threeDep"><a href="/company/store/story?storeId=29"><img alt="센텀시티점이야기" src="/images/company/shop/snb_store_story_29${fn:indexOf(pageContext.request.requestURI,'story') >= 0?'_on':''}.png"></a></li>
            </ul>
        </li>
    </ul>
    <ul class="banner">
        <c:forEach items="${banners}" var="item" varStatus="status" begin="0" end="1">
            <li><a href="${item.linkUrl }"><img src="${item.imgUrl}" alt="숨겨진 음악으로의초대" width="172" height="65"/></a></li>
        </c:forEach>
    </ul>
</div>
