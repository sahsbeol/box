<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<style>
<!--
div.today-calendar { font-family: "Malgun Gothic"; clear: both;margin-top:10px;padding-bottom:10px;text-align:center;background: url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/music/uek_bottom_schedule.gif'); }
div.today-calendar .calendar-title { height:100px;background: url("http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/music/uek_title_schedule.gif") no-repeat scroll 0 15px; }
div.today-calendar h4 { color: #ffffff;font-size: 30px;padding:15px 0 12px 40px;border-bottom:2px dashed #FFF;  }
div.today-calendar h4 span.dot { font-size:12px; }
div.today-calendar .schedule-info { font-size: 1.2em;line-height: 40px;padding: 0 10px;text-align: right; }
div.today-calendar p.year-moth { padding: 0 0 20px;text-align: center; }
div.today-calendar p.year-moth span { padding: 0 20px; }
div.today-calendar div.calendar-list { width: 950px;padding-bottom:15px;text-align:center;background: url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/music/uek_bg_schedule.gif');  }
div.today-calendar div.calendar-list table { width: 910px;height:770px;margin:0 20px; }
div.today-calendar div.calendar-list table caption { height: 0; font-size: 0; line-height: 0; visibility: hidden; }
div.today-calendar div.calendar-list table thead tr th { width: 106px;height: 27px;border-left: 1px dotted #000;font-weight: bold;font-size:1.5em;padding:5px; }
div.today-calendar div.calendar-list table thead tr th.first { border-left:none; }
div.today-calendar div.calendar-list table thead tr th.sun { color: #E9084E; }
div.today-calendar div.calendar-list table thead tr th.sat { color: #0064B1; }
div.today-calendar div.calendar-list table tbody tr td { border-left: 1px dotted #000;border-top: 1px dotted #000;vertical-align:top; }
div.today-calendar div.calendar-list table tbody tr td.first { border-left:none; }
div.today-calendar div.calendar-list table tbody tr td p.date { padding: 5px 0 10px 10px;font-weight: bold;text-align: left;font-size:1.2em; }
div.today-calendar div.calendar-list table tbody tr td ul { padding: 5px 10px 10px 10px; }
div.today-calendar div.calendar-list table tbody tr td ul li { list-style:disc inside;padding:5px 0; }
div.today-calendar div.calendar-list table tbody tr td.sun p.date { color: #E9084E; }
div.today-calendar div.calendar-list table tbody tr td.sat p.date { color: #0064B1; }
div.today-calendar div.calendar-list table tbody tr td p.photo { padding: 0 0 10px; text-align: center; }
div.today-calendar div.calendar-list table tbody tr td p.photo img { }
div.today-calendar div.calendar-list table tbody tr td p.button { padding: 0 0 7px; text-align: center; }
-->
</style>
<div class="today-calendar">
    <div class="calendar-title"><h4><span class="dot">■</span> 유이케이 ${fn:substring(month, 4, 6)}월 출시 스케줄</h4></div>
    <div class="calendar-list">
        <p class="schedule-info">
            <img src="${imageServer}/images/music/uek_btn_D.gif" alt="DVD"/>: DVD
            <img src="${imageServer}/images/music/uek_btn_B.gif" alt="블루레이"/>: 블루레이
        </p>
        <table summary="달력">
            <caption>달력</caption>
            <thead>
                <tr>
                    <th scope="col" class="sun first">일</th>
                    <th scope="col">월</th>
                    <th scope="col">화</th>
                    <th scope="col">수</th>
                    <th scope="col">목</th>
                    <th scope="col">금</th>
                    <th scope="col" class="sat">토</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${list}" var="l1" varStatus="s1">
                    <tr>
                        <c:forEach begin="0" end="6" varStatus="s2">
                            <c:if test="${s2.index eq 0}"><c:set var="dt" value="${l1.s1}"/></c:if>
                            <c:if test="${s2.index eq 1}"><c:set var="dt" value="${l1.s2}"/></c:if>
                            <c:if test="${s2.index eq 2}"><c:set var="dt" value="${l1.s3}"/></c:if>
                            <c:if test="${s2.index eq 3}"><c:set var="dt" value="${l1.s4}"/></c:if>
                            <c:if test="${s2.index eq 4}"><c:set var="dt" value="${l1.s5}"/></c:if>
                            <c:if test="${s2.index eq 5}"><c:set var="dt" value="${l1.s6}"/></c:if>
                            <c:if test="${s2.index eq 6}"><c:set var="dt" value="${l1.s7}"/></c:if>
                            <td class="${s2.first?'sun first':''}${s2.last?'sat':''}">
                                <p class="date"><c:if test="${not empty dt}"><fmt:formatNumber>${fn:substring(dt, 6, 8)}</fmt:formatNumber></c:if></p>
                                <c:if test="${not empty index[dt]}">
                                    <ul>
                                        <c:forEach items="${index[dt]}" var="l" varStatus="st">
                                            <li>
                                                <a href="/ht/record/detail/${l.sellPrdtBcode}">${l.prdtName}</a>
                                                <c:if test="${fn:startsWith(l.ctgrId, '000401')}"><img src="${imageServer}/images/music/uek_btn_D.gif" alt="DVD"/></c:if>
                                                <c:if test="${fn:startsWith(l.ctgrId, '000400')}"><img src="${imageServer}/images/music/uek_btn_B.gif" alt="블루레이"/></c:if>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </c:if>
                            </td>
                        </c:forEach>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div><!-- end calendar-list -->
</div><!-- end today-calendar -->
