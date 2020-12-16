<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript">
jQuery(function($){
    $(document).ready(function(){
        $("tr[id^='qna-content0']").hide();
    });

    $("a[href^='#qna-content0']").each(function(){
        var $a = $(this);
        var aHrefVal = $a.attr("href");
        var $tr = $(aHrefVal);
        $a.click(function() {
            $tr.toggle();
            return false;
        });
    });

    var tab01 = $("div.section:eq(1)");
    var tabContent01 = tab01.find("div.break-down");
        tab01.find("ul.menu li a").click(function(){
            tabContent01.hide();
            $("#"+$(this).attr("href").split("#")[1]).show();
            tab01.find("ul.menu li a").parent().attr("class","");
            $(this).parent().attr("class","selected");
        });
});
</script>
</head>
<body>
<div class="page-location">
    <p>현재 페이지 위치</p>
    <ul>
        <li><strong>MY HOTTRACKS</strong></li>
    </ul>
</div><!-- end page-location -->
<div class="wins">
    <c:if test="${winEventCountDuringAWeek > 0}"><a href="/ht/mypage/myEventList">“축하합니다! 이벤트 당첨자에 선정되셨습니다!”</a></c:if>
    <c:if test="${winEventCountDuringAWeek == 0}">“오늘도 기분좋은 하루 보내세요!”</c:if>
</div><!-- winds -->
<div class="my-room">
    <div class="my-break-down">
        <h3><img src="${imageServer}/images/myhottracks/h3_main_title01.gif" alt="최근 상품Q&amp;A 내역" /></h3>
        <p class="recent-cnt">현재 <strong>${answeredRowSize}</strong> 건의 문의에 대한 답변을 준비중입니다.</p>
        <p class="view-more"><a href="/ht/mypage/questionList"><img src="${imageServer}/images/myhottracks/btn_more_view.gif" alt="더보기" /></a></p>
        <div class="board">
            <table class="list" summary="최근 상품 질문과 답변의 내역을 접수일자 상품 제목 답변여부 순으로 보여주는 표">
                <caption>최근 상품Q&amp;A 내역</caption>
                <colgroup>
                    <col width="14%" />
                    <col width="13%" />
                    <col width="*" />
                    <col width="16%" />
                </colgroup>
                <thead>
                    <tr>
                        <th scope="col"><img src="${imageServer}/images/common/board_list_receive_date.gif" alt="접수일자" /></th>
                        <th scope="col"><img src="${imageServer}/images/common/board_list_product.gif" alt="상품" /></th>
                        <th scope="col" class="titles"><img src="${imageServer}/images/common/board_list_subject.gif" alt="제목" /></th>
                        <th scope="col"><img src="${imageServer}/images/common/board_list_answer.gif" alt="답변여부" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${qnaList}" var="qna" varStatus="status">
                    <tr>
                        <td class="center-date"><fmt:formatDate pattern="yyyy.MM.dd" value="${qna.registerDate}" /></td>
                        <td class="center">
                            <a href="/ht/product/detail?barcode=${qna.barcode}" target="_blank">
                                <ui:image src="${qna.productImageUrl}" alt="${qna.productName}" server="product" width="47px" height="47px"/>
                            </a>
                        </td>                   
                        <td class="titles">
                            <a href="#qna-content0${status.index + 1}"><c:out value="${qna.title}" escapeXml="true"/><c:if test="${qna.publicYn eq 'N'}">[비공개]</c:if></a>
                        </td>
                        <td class="center">
                            <ui:gubun key="procStatGbn" value="${qna.procStatGbn}"/>
                        </td>
                    </tr>
                    <tr id="qna-content0${status.index + 1}">
                        <td colspan="4" class="detail-content">
                            <p class="question-content">${hfn:lineToBr(qna.content)}</p>
                            <p class="answer">
                                <c:choose>
                                    <c:when test="${qna.answerYn == 'Y'}">질문에 대한 답변입니다.</c:when>
                                    <c:otherwise>답변준비 중 입니다.</c:otherwise>
                                </c:choose>
                            </p>
                            <p class="answer-content">${qna.answerContent}</p>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div><!-- end board -->
    </div><!-- end my-break-down -->
    <div class="my-break-down">
        <h3><img src="${imageServer}/images/myhottracks/h3_main_title02.gif" alt="최근 100자 상품평 등록 내역" /></h3>
        <p class="recent-cnt">
            <c:if test="${postscriptListCount eq 0}">최근 3개월간 등록한 상품평이 없습니다.</c:if>
            <c:if test="${postscriptListCount > 0}">최근 3개월간 등록한 상품평이 <strong>${postscriptListCount}</strong> 건 있습니다.</c:if>
        </p>
        <p class="view-more"><a href="/ht/mypage/commentList"><img src="${imageServer}/images/myhottracks/btn_more_view.gif" alt="더보기" /></a></p>
        <div class="board">
            <table class="list" summary="최근 100자 상품평 등록 내역의 작성일자 상품 제목 평점 순으로 보여주는 표">
                <caption>최근 100자 상품평 등록 내역</caption>
                <colgroup>
                    <col width="14%" />
                    <col width="13%" />
                    <col width="*" />
                    <col width="16%" />
                </colgroup>
                <thead>
                    <tr>
                        <th scope="col"><img src="${imageServer}/images/common/board_list_write_date.gif" alt="작성일자" /></th>
                        <th scope="col"><img src="${imageServer}/images/common/board_list_product.gif" alt="상품" /></th>
                        <th scope="col" class="titles"><img src="${imageServer}/images/common/board_list_subject.gif" alt="제목" /></th>
                        <th scope="col"><img src="${imageServer}/images/common/board_list_point.gif" alt="평점" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${postscriptList}" var="postscript" varStatus="status">
                    <tr>
                        <td class="center-date"><fmt:formatDate pattern="yyyy.MM.dd" value="${postscript.registerDate}" /></td>
                        <td class="center">
                            <a href="/ht/product/detail?barcode=${postscript.barcode}" target="_blank">
                                <ui:image src="${postscript.productImageUrl}" alt="${postscript.productName}" server="product" width="47px" height="47px"/>
                            </a>
                        </td>
                        <td class="titles">${hfn:lineToBr(postscript.title)}<c:if test="${postscript.publicYn eq 'N'}">[비공개]</c:if></td>
                        <td class="center"><img src="${imageServer}/images/common/icon_estimation0${postscript.grade}.gif" alt="${postscript.grade}" /></td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div><!-- end board -->
    </div><!-- my-break-down -->
    <div class="my-break-down">
        <h3><img src="${imageServer}/images/myhottracks/h3_main_title03.gif" alt="최근 이벤트 참여 내역" /></h3>
        <p class="recent-cnt">현재  <strong>${progressEventCount}</strong> 건의 이벤트에 참여중입니다.</p>
        <p class="view-more"><a href="/ht/mypage/myEventList"><img src="${imageServer}/images/myhottracks/btn_more_view.gif" alt="더보기" /></a></p>
        <div class="board">
            <table class="list" summary="이벤트 참여 내역의 참여일자 이벤트명 당첨자 발표 진행여부 보여주는 표">
                <caption>이벤트 참여 내역</caption>
                <colgroup>
                    <col width="14%" />
                    <col width="*" />
                    <col width="14%" />
                    <col width="16%" />
                </colgroup>
                <thead>
                    <tr>
                        <th scope="col"><img src="${imageServer}/images/common/board_list_join_date.gif" alt="참여일자" /></th>
                        <th scope="col" class="event-name"><img src="${imageServer}/images/common/board_list_event.gif" alt="이벤트명" /></th>
                        <th scope="col"><img src="${imageServer}/images/common/board_list_prizewinner.gif" alt="당첨자 발표" /></th>
                        <th scope="col"><img src="${imageServer}/images/common/board_list_progress.gif" alt="진행여부" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${eventList}" var="event" varStatus="status">
                    <tr>
                        <td class="center-date"><fmt:formatDate value="${event.regstDtm}" pattern="yyyy.MM.dd"/></td>
                        <td class="event-name"><a href="/ht/biz/eventDetail?eventId=${event.eventId}" target="_blank">${event.eventTitle}</a></td>
                        <td class="center-date">
                            <c:choose>
                                <c:when test="${event.eventStatus eq 'progress'}">
                                    <c:if test="${empty event.userNum}"><ui:mask pattern="####.##.##">${event.announcingWinnerDate}</ui:mask></c:if>
                                    <c:if test="${!empty event.userNum && today eq event.announcingWinnerDate}"><img src="${imageServer}/images/myhottracks/icon_win_prize.gif" alt="당첨" /></c:if>
                                    <c:if test="${!empty event.userNum && today ne event.announcingWinnerDate}"><ui:mask pattern="####.##.##">${event.announcingWinnerDate}</ui:mask></c:if>
                                </c:when>
                                <c:when test="${event.eventStatus eq 'win'}">
                                    <c:if test="${event.announcementYn}"><img src="${imageServer}/images/myhottracks/icon_win_prize.gif" alt="당첨" /></c:if>
                                    <c:if test="${!event.announcementYn}">발표준비중</c:if>
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${event.announcementYn}">다음 기회에</c:if>
                                    <c:if test="${!event.announcementYn}">발표준비중</c:if>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="center">
                            <c:if test="${event.eventStatus eq 'progress'}">진행중</c:if>
                            <c:if test="${event.eventStatus ne 'progress'}">마감</c:if>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div><!-- end board -->
    </div><!-- end my-break-down -->
    <div class="zzim-section">
        <div  class="head-line type01">
            <h3><img src="${imageServer}/images/myhottracks/h3_main_title04.gif" alt="찜하기 내역보기" /></h3>
            <p class="more-view"><a href="/ht/mypage/listWishProduct"><img src="${imageServer}/images/myhottracks/btn_more_view.gif" alt="더보기" /></a></p>
        </div><!-- end head-line -->
        <ul class="menu">
            <li class="selected">상품<strong>${wishProductListCount}건</strong></li>
            <li>브랜드<strong>${wishBrandListCount}건</strong></li>
        </ul>
        <div class="break-down-contents">
            <ul>
                <c:forEach items="${wishProductList}" var="wishProduct" varStatus="status">
                <li>
                    <p class="photo"><a href="/ht/product/detail?barcode=${wishProduct.barcode}" target="_blank"><ui:image src="${wishProduct.productImageUrl}" server="product" width="47px" height="47px"/></a></p>
                    <p class="goods"><a href="/ht/product/detail?barcode=${wishProduct.barcode}" target="_blank"><ui:substring beginIndex="0" endIndex="16" shortString="..">${wishProduct.productName}</ui:substring></a></p>
                </li>
                </c:forEach>
            </ul>
        </div><!-- end goods -->
        <div class="break-down-contents">
            <ul>
                <c:forEach items="${wishBrandList}" var="wishBrand" varStatus="status">
                <li>
                    <p class="photo"><a href="/ht/hot/brandDetail?brandId=${wishBrand.brandId}" target="_blank"><ui:image src="${wishBrand.brandImageUrl}" server="brand"/></a></p>
                    <p class="goods"><a href="/ht/hot/brandDetail?brandId=${wishBrand.brandId}" target="_blank">${wishBrand.brandEngName}<c:if test="${empty wishBrand.brandEngName}">${wishBrand.brandKorName}</c:if></a></p>
                </li>
                </c:forEach>
            </ul>
        </div><!-- end break-down-contents -->
    </div><!-- end zzim-section -->
    <div class="section right-field">
        <div class="head-line">
            <h3><img src="${imageServer}/images/myhottracks/h3_main_title06.gif" alt="MY GIFT STORY" /></h3>
            <p class="cnt">| 총 <strong>${giftStoryCount}건</strong></p>
            <p class="more-view"><a href="/ht/hot/myGiftList"><img src="${imageServer}/images/myhottracks/btn_more_view.gif" alt="더보기" /></a></p>
        </div><!-- end head-line -->
        <div class="break-down">
            <ul>
                <c:forEach items="${giftStoryList}" var="giftStory" varStatus="status">
                <li>
                    <p class="goods"><a href="/ht/hot/myGiftDetail?giftStorySeq=${giftStory.giftStorySeq}">${giftStory.giftStoryTitle}</a></p>
                    <p class="end-day"><ui:mask pattern="####.##.##">${giftStory.giftStoryWhen}</ui:mask> </p>
                </li>
                </c:forEach>
            </ul>
        </div><!-- break-down -->
    </div><!-- section-odd -->
    <div class="section">
        <div class="head-line">
            <h3><img src="${imageServer}/images/myhottracks/h3_main_title07.gif" alt="MY E-card" /></h3>
            <p class="more-view"><a href="/ht/mypage/ecard/ecardSendedList"><img src="${imageServer}/images/myhottracks/btn_more_view.gif" alt="더보기" /></a></p>
        </div><!-- end head-line -->
        <ul class="menu">
            <li class="selected"><a href="#card01">보낸카드<strong>${sendEcardListCount}건</strong></a><span>|</span></li>
            <li><a href="#card02">만든카드 <strong>${madeEcardListCount}건</strong></a></li>
        </ul>
        <div id="card01" class="break-down">
            <ul>
                <c:forEach items="${sendEcardList}" var="sendEcard" varStatus="status">
                <li>
                    <p class="goods"><a href="/ht/mypage/ecard/ecardSendedList">${sendEcard.ecardTitle}</a></p>
                    <p class="crop">${sendEcard.senderName}</p>
                    <p class="day"><fmt:formatDate value="${sendEcard.registrationDate}" pattern="yyyy.MM.dd"/></p>
                </li>
                </c:forEach>
            </ul>
        </div><!-- break-down -->
        <div id="card02" class="break-down">
            <ul>
                <c:forEach items="${madeEcardList}" var="madeEcard" varStatus="status">
                <li>
                    <p class="goods"><a href="/ht/mypage/ecard/ecardMadeList">${madeEcard.title}</a></p>
                    <p class="crop"></p>
                    <p class="day"><fmt:formatDate value="${madeEcard.registrationDate}" pattern="yyyy.MM.dd"/></p>
                </li>
                </c:forEach>
            </ul>
        </div><!-- break-down -->
    </div><!-- end section-even -->
</div><!-- end my-room -->
</body>
</html>