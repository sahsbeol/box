<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>주문/배송조회 | 주문정보 | MY HOTTRACKS - HOTTRACKS</title>
<script language="javascript" src="http://<ui:pgurl service='pgweb'/>/WEB_SERVER/js/receipt_link.js"></script>
<script type="text/javascript">
function goList(){
    var m = '${c.menuId}';
    if(m==1 || m==0){
        var t = '${c.orderTermType}';
        location.href="/ht/mypage/orderDelivery?menuId=1&orderTermType="+t;
    }else if(m==2){
        location.href="/ht/mypage/orderChange?menuId=2";
    }else if(m==3){
        location.href="/ht/mypage/returnExchange?menuId=3";
    }
}


//거래명세서 출력
function specificationOnTransaction(orderNum) {
    window.open('/ht/order/viewSpecificationOnTransaction?orderNo='+orderNum,'popupSpecificationOnTransaction','width=770,height=570');
}

//네이버페이 LG U+ 현금영수증
function naverCash(orderNum) {
    window.open('http://pg.dacom.net/transfer/cashreceipt.jsp?orderid=' + orderNum + '&mid=hottracks&servicetype=SC0100','naverCash','width=770,height=570');
}

//네이버페이 NICE 현금영수증
function naverNiceCash(tid) {
    var status = "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=420,height=540";
    var url = "https://npg.nicepay.co.kr/issue/IssueLoader.do?TID="+tid+"&type=1";
    window.open(url,"popupIssue",status);
}



//카카오 페이 내역 조회
function cacaoPaySearch(tid) {
    var status = "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=420,height=540";
    var url = "https://mms.cnspay.co.kr/trans/retrieveIssueLoader.do?TID=" + tid + "&type=0";
    window.open(url,"popupIssue",status);
}

//NICE 전표 출력
function NicePrintReceipt(tid) {    
    var status = "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=420,height=540";
    var url = "https://npg.nicepay.co.kr/issue/IssueLoader.do?TID="+tid+"&type=0";
    window.open(url,"popupIssue",status);
}

//NICE 전표 출력
function NicePrintCashReceipt(tid) {    
    var status = "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=420,height=540";
    var url = "https://npg.nicepay.co.kr/issue/IssueLoader.do?TID="+tid+"&type=1";
    window.open(url,"popupIssue",status);
}
</script>

</script>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_my_hottracks.gif" alt="My Hottracks"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>MY HOTTRACKS</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/mypage/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_order_delivery.gif" alt="주문/배송조회" /></h3>
    <div class="box_gray02">주문번호<span class="order_num">${c.orderNo }</span></div>

    <c:if test="${not empty orderList}">
        <h4 class="tit01">주문/배송정보</h4>
        <table class="bbs_list01">
            <caption>주문/배송정보 <span>상품코드, 이미지, 상품명, 배송수량, 가격, 쿠폰할인, 처리상태, 배송조회</span>
            </caption>
            <colgroup>
                <col style="width:100px">
                <col style="width:56px">
                <col style="width:*">
                <col style="width:60px">
                <col style="width:60px">
                <col style="width:60px">
                <col style="width:80px">
                <col style="width:80px">
            </colgroup>
            <thead>
                <tr>
                    <th scope="col" class="fir">상품코드</th>
                    <th scope="col">이미지</th>
                    <th scope="col">상품명</th>
                    <th scope="col">배송수량</th>
                    <th scope="col">가격</th>
                    <th scope="col">쿠폰할인</th>
                    <th scope="col">처리상태</th>
                    <th scope="col" class="last">배송조회</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${orderList}" var="l" varStatus="st">
                    <tr> 
                        <td>
                            <span class="p_code">${l.barcode }</span>
                            <c:if test="${!fn:contains('CF' ,l.gbn) }">[${l.deliveryVendorId eq '0625'?'핫트랙스배송':'업체개별배송'}]</c:if>
                        </td>
                        <td>
                            <c:if test="${!fn:contains('CF' ,l.gbn) }">
                                <c:if test="${fn:contains('DR' ,l.gbn) }"><a href="/ht/record/detail/${l.barcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.gbn }" clazz="photo" width="50" alt="${l.productName }" ratingCode="${l.rtngCode }"/></a></c:if>
                                <c:if test="${!fn:contains('DR' ,l.gbn) }"><a href="/p/${l.barcode}"><ui:image src="${l.productImageUrl}" server="product" size="50" alt="${l.productName }"/></a></c:if>
                            </c:if>
                        </td>
                        <td class="t_left">${l.productName}
                            <c:if test="${l.gbn eq 'S'}"><p style="color:#DA2128;line-height:20px;">└ ${l.specName}</p></c:if>
                            <c:forEach items="${l.optionList}" var="optn">
                                <p style="color:#DA2128;line-height:20px;">└ ${optn.name}:${optn.value} - ${optn.cvslName}</p>
                            </c:forEach>
                        </td>
                        <td>${l.dlvyCount}</td>
                        <td class="right"><fmt:formatNumber value="${l.sellProductPrice * l.dlvyCount}" pattern="#,###"/>원</td>
                        <td class="right"><fmt:formatNumber value="${l.couponPrice}" pattern="#,###"/>원</td>
                        <td>
                            <ui:code codeId="${l.orderStatus }"/>
                            <%-- <c:if test="${!fn:contains('FCDR' ,l.gbn) && isLogin}"><a class="btn_type02" href="javascript:goReview(${l.barcode })">상품평쓰기</a></c:if> --%>
                        </td>
                        <td class="link">${l.tcbName }<br /><a href="${l.tcbUrl }${l.sendNo }" target="_blank">${l.sendNo }</a></td> 
                    </tr>
                </c:forEach>
                <c:if test="${not empty freeGiftList.freeGiftList || not empty freeGiftList.supplementList || not empty freeGiftList.fgiftList || not empty freeGiftList.posterCaseList }" >
                    <c:if test="${not empty freeGiftList.freeGiftList }">
                        <tr> <td colspan="8" class="t_right">
                                <span class="bold">사은품</span> : 
                                <c:forEach items="${freeGiftList.freeGiftList}" var="freeGift">
                                    ${freeGift.freeGiftName} <br/>
                                </c:forEach>
                            </td>
                        </tr>
                    </c:if>
                    <c:if test="${not empty freeGiftList.fgiftList}">
                        <tr>
                            <td colspan="8" class="t_right">
                                <span class="bold">주문사은품</span> : 
                                <c:forEach items="${freeGiftList.fgiftList}" var="fgift">
                                    ${fgift.title } <br/>
                                </c:forEach>
                            </td>
                        </tr>
                    </c:if>
                    <c:if test="${not empty freeGiftList.supplementList}">
                        <tr>
                            <td colspan="8" class="t_right">
                                <span class="bold">부록</span> : 
                                <c:forEach items="${freeGiftList.supplementList}" var="supplement">
                                    ${supplement.title} <br/>
                                </c:forEach>
                            </td>
                        </tr>
                    </c:if>
                    <c:if test="${not empty freeGiftList.posterCaseList }">
                        <tr><td colspan="8" class="right"><span class="f_black_b">포스터 증정</span></td></tr>
                    </c:if>
                </c:if>
            </tbody>
        </table>
    </c:if>
    <c:if test="${not empty cancelList }">
        <h4 class="tit01">취소/반품정보</h4>
        <table class="bbs_list01">
            <caption>취소반품정보 <span>상품코드, 이미지, 상품명, 취소구분, 수량, 처리상태</span>
            </caption>
            <colgroup>
                <col style="width:100px" />
                <col style="width:106px" />
                <col style="width:*" />
                <col style="width:100px" />
                <col style="width:50px" />
                <col style="width:90px" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col" class="fir">상품코드</th>
                    <th scope="col">이미지</th>
                    <th scope="col">상품명</th>
                    <th scope="col">취소구분</th>
                    <th scope="col">수량</th>
                    <th scope="col" class="last">처리상태</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${cancelList}" var="l" varStatus="st">
                    <tr> 
                        <td>
                            <span class="p_code">${l.barcode }</span>
                            <c:if test="${!fn:contains('CF', l.gbn) }">[${l.deliveryVendorId eq '0625'?'핫트랙스배송':'업체개별배송'}]</c:if>
                        </td>
                        <td>
                            <c:if test="${!fn:contains('CF', l.gbn) }">
                                <c:if test="${fn:contains('DR', l.gbn) }"><a href="/ht/record/detail/${l.barcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.gbn }" clazz="photo" width="50" alt="${l.productName }" ratingCode="${l.rtngCode }"/></a></c:if>
                                <c:if test="${!fn:contains('DR', l.gbn) }"><a href="/p/${l.barcode}"><ui:image src="${l.productImageUrl}" server="product" size="50" alt="${l.productName }"/></a></c:if>
                            </c:if>
                        </td>
                        <td class="t_left">${l.productName}
                            <c:if test="${l.gbn eq 'S'}"><p style="color:#DA2128;line-height:20px;">└ ${l.specName}</p></c:if>
                            <c:forEach items="${l.optionList}" var="optn">
                                <p style="color:#DA2128;line-height:20px;">└ ${optn.name}:${optn.value}</p>
                            </c:forEach>
                        </td>
                        <td><ui:code codeId="${l.dlvyStatusCode}" /></td>
                        <td>${l.dlvyCount}</td>
                        <td><ui:code codeId="${l.rtnStatusCode}" /></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${not empty paymentInfo }">
        <h4 class="tit01">결제정보</h4>
        <table class="table01">
            <caption>결제정보 <span>주문총액, 할인총액, 결제상세, 결제일시</span></caption>
            <colgroup>
                <col style="width:125px" />
                <col style="width:245px" />
                <col style="width:125px" />
                <col style="width:*;" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row">주문총액</th>
                    <td><span class="bold"><fmt:formatNumber value="${paymentInfo.orderAmt + paymentInfo.dlvyAmt}" pattern="#,###"/> 원<span></td>
                    <th scope="row">할인총액</th>
                    <td><span class="bold"><fmt:formatNumber value="${paymentInfo.savedPrice }" pattern="#,###"/> 원<span></td>
                </tr>
                <tr>
                    <th scope="row">결제상세</th>
                    <td colspan="3">
                        <ul>
                            <li>상품금액: <fmt:formatNumber value="${paymentInfo.orderAmt}" pattern="#,###"/>원</li>
                            <li>배송비: <fmt:formatNumber value="${paymentInfo.dlvyAmt}" pattern="#,###"/>원</li>
                            <li>
                                (-) 할인금액: 교보핫트랙스 온라인 예치금 <fmt:formatNumber value="${paymentInfo.paymentAmtC0116}" pattern="#,###"/>원
                                           | 마일리지  <fmt:formatNumber value="${paymentInfo.paymentAmtC0115}" pattern="#,###"/>원
                                           | 통합포인트 <fmt:formatNumber value="${paymentInfo.paymentAmtC0119}" pattern="#,###"/>원
                                           | 쿠폰 <fmt:formatNumber value="${paymentInfo.cpnDscntAmt}" pattern="#,###"/>원
                                           | GS Point <fmt:formatNumber value="${paymentInfo.gsAmt}" pattern="#,###"/>원
                                           | Oh Point <fmt:formatNumber value="${paymentInfo.paymentAmtC011B}" pattern="#,###"/>원
                                           | Ok CashBack <fmt:formatNumber value="${paymentInfo.paymentAmtC011C}" pattern="#,###"/>원
                                           | L Point <fmt:formatNumber value="${paymentInfo.paymentAmtC011F}" pattern="#,###"/>원
                            </li>
                            <li class="mgt15">
                                결제금액 : <fmt:formatNumber value="${paymentInfo.pymntAmt}" pattern="#,###"/>원
                                <c:choose>
                                    <c:when test="${paymentInfo.pymntMeansCode == 'C0111' }"> - <ui:code codeId="${paymentInfo.pymntMeansCode}"/> ( <ui:creditCardCode codeId="${paymentInfo.paymentCodeId }" />카드 /
                                        <c:choose>
                                            <c:when test="${paymentInfo.mitpCount == 0}">일시불</c:when>
                                            <c:otherwise>${paymentInfo.mitpCount }개월 할부</c:otherwise>
                                        </c:choose>)
                                    </c:when>   
                                    <c:when test="${paymentInfo.pymntMeansCode == 'C0112' }"> - <ui:code codeId="${paymentInfo.pymntMeansCode}"/>(<ui:bankCode codeId="${paymentInfo.transferCodeId}" />은행)</c:when>
                                    <c:when test="${paymentInfo.pymntMeansCode == 'C0113'}">
                                         - <ui:code codeId="${paymentInfo.pymntMeansCode}"/>(${paymentInfo.lgupPymntHdphnNum})
                                    </c:when>
                                    <c:when test="${paymentInfo.pymntMeansCode == 'C0114'}">
                                         - <ui:code codeId="${paymentInfo.pymntMeansCode}"/>
                                    </c:when>  
                                    <c:when test="${paymentInfo.pymntMeansCode eq 'C0117'}">
                                    - <ui:code codeId="${paymentInfo.pymntMeansCode}" />
                                    ${paymentInfo.lgdACCOUNTNAME}은행  ${paymentInfo.lgdACCOUNTNUM} &nbsp; • 예금주: 교보핫트랙스㈜ <br/>주문일로 부터 7일 동안 입금이 안될 경우 주문이 자동으로 취소 됩니다.
                                    </c:when>
                                    <c:when test="${paymentInfo.pymntMeansCode == 'C011D'}">
                                         - <ui:code codeId="${paymentInfo.pymntMeansCode}"/>
                                    </c:when>
                                    <c:when test="${paymentInfo.pymntMeansCode == 'C011J' }"> - <ui:code codeId="${paymentInfo.pymntMeansCode}"/> ( <ui:creditCardCode codeId="${paymentInfo.niceCardNm }" /> /
                                        <c:choose>
                                            <c:when test="${paymentInfo.niceCardqyota == '00'}">일시불</c:when>
                                            <c:otherwise>${paymentInfo.niceCardqyota}개월 할부</c:otherwise>
                                        </c:choose>)
                                    </c:when>  
                                    <c:when test="${paymentInfo.pymntMeansCode == 'C011K' }"> - <ui:code codeId="${paymentInfo.pymntMeansCode}"/>(<ui:bankCode codeId="${paymentInfo.niceBank}" />)</c:when>
                                    <c:when test="${paymentInfo.pymntMeansCode eq 'C011L'}">
                                    - <ui:code codeId="${paymentInfo.pymntMeansCode}" />
                                    ${paymentInfo.nicevBank}  ${paymentInfo.nicevBankNum} &nbsp; • 예금주: 교보핫트랙스㈜ <br/>주문일로 부터 7일 동안 입금이 안될 경우 주문이 자동으로 취소 됩니다.
                                    </c:when>
                                </c:choose>
                                <br/>
                                <c:choose>
                                    <c:when test="${paymentInfo.pymntMeansCode eq 'C0111'}">
                                        <a class="btn_type02" href="javascript:showReceiptByTID('${lgdMid}', '${paymentInfo.lgupDealNum}', '${paymentInfo.lgupChprDealNum}')">신용카드 전표출력</a>
                                    </c:when>
                                    <c:when test="${paymentInfo.pymntMeansCode eq 'C0112'}">
                                        <a class="btn_type02" href="javascript:showCashReceipts('${lgdMid}','${c.orderNo}', '0', 'BANK', '${cstPlatform}')">현금영수증 출력</a>
                                    </c:when>
                                    <c:when test="${paymentInfo.pymntMeansCode eq 'C0117' && !(paymentInfo.pymntStatCode eq 'C0101' )}">
                                        <a class="btn_type02" href="javascript:showCashReceipts('${lgdMid}','${c.orderNo}', '001', 'CAS', '${cstPlatform}')">현금영수증 출력</a>
                                    </c:when>
                                    <c:when test="${paymentInfo.pymntMeansCode eq 'C011E'}">
                                        <c:if test="${!empty paymentInfo.pymntOrganName}">
                                            <a class="btn_type02" href="javascript:naverNiceCash('${paymentInfo.pymntOrganName}')">현금영수증 출력</a>
                                        </c:if>
                                        <c:if test="${empty paymentInfo.pymntOrganName}">
                                            <a class="btn_type02" href="javascript:naverCash('${c.orderNo}')">현금영수증 출력</a>
                                        </c:if>
                                    </c:when>
                                    <c:when test="${paymentInfo.pymntMeansCode eq 'C011G'}">
                                        <a class="btn_type02" href="javascript:cacaoPaySearch('${paymentInfo.lgupDealNum}')">카카오 전표출력</a>
                                    </c:when>
                                    <c:when test="${paymentInfo.pymntMeansCode eq 'C011J'}">
                                        <a class="btn_type02" href="javascript:NicePrintReceipt('${paymentInfo.lgupDealNum}')">신용카드 전표출력</a>
                                    </c:when>
                                    <c:when test="${paymentInfo.pymntMeansCode eq 'C011K'}">
                                        <a class="btn_type02" href="javascript:NicePrintCashReceipt('${paymentInfo.niceBankTID}')">현금영수증 출력</a>
                                    </c:when>
                                    <c:when test="${paymentInfo.pymntMeansCode eq 'C011L' && !(paymentInfo.pymntStatCode eq 'C0101' )}">
                                        <a class="btn_type02" href="javascript:NicePrintCashReceipt('${paymentInfo.niceBankTID}')">현금영수증 출력</a>
                                    </c:when>
                                </c:choose>
                                    <c:if test="${!empty orderList && !(paymentInfo.pymntStatCode eq 'C0101' )}">
                                        <a class="btn_type02" href="javascript:specificationOnTransaction('${c.orderNo}');">거래명세서 출력</a>
                                    </c:if>
                            </li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <th scope="row">결제일시</th>
                    <td colspan="3"><c:if test="${!(paymentInfo.pymntStatCode eq 'C0101' )}"><fmt:formatDate value="${paymentInfo.pymntDtm }" pattern="yyyy.MM.dd"/></c:if></td>
                </tr>
            </tbody>
        </table>
    </c:if>
    <c:if test="${totalOrderCancelAmt != 0}">
        <h4 class="tit01">환불정보</h4>
        <table class="table01">
            <caption>환불정보 <span>총 취소 금액, 환불상세, 환불금액</span></caption>
            <colgroup>
                <col style="width:125px" />
                <col style="width:*;" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row">총 취소 금액</th>
                    <td class="t_right"><span class="bold"><fmt:formatNumber value="${(-1) * totalOrderCancelAmt}" pattern="#,###"/> 원<span></td>
                </tr>
                <tr>
                    <th scope="row">환불상세</th>
                    <td>
                        <ul class="refund">
                            <c:forEach items="${refundPaymentList}" var="l" varStatus="st">
                                <li>
                                    <span class="item"><ui:code codeId="${l.pymntMeansCode}" /></span>
                                    <span class="price"><fmt:formatNumber value="${(-1)*l.cancRtnAmt}" pattern="#,###"/> 원</span>
                                </li>
                                <c:set var="totalCancRtnAmt" value="${totalCancRtnAmt + (-1)*l.cancRtnAmt}"/>
                            </c:forEach>
                            <li class="mgt15">
                                <span class="item">배송비 공제</span>
                                <span class="price"><fmt:formatNumber value="${dlvyAmout }" pattern="#,###"/> 원</span>
                            </li>
                            <li class="mgt15">
                                <span class="item">쿠폰 공제</span>
                                <span class="price"><fmt:formatNumber value="${cancelCouponAmt }" pattern="#,###"/> 원</span>
                            </li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <th scope="row">환불금액</th>
                    <td class="t_right"><span class="bold point02"><fmt:formatNumber value="${totalCancRtnAmt}" pattern="#,###"/> 원</span></td>
                </tr>
            </tbody>
        </table>
    </c:if>
    <h4 class="tit01">주문자정보</h4>
    <table class="table01">
        <caption>주문자정보 <span>주문자명, 이메일, 전화번호, 휴대폰</span></caption>
        <colgroup>
            <col style="width:125px" />
            <col style="width:245px" />
            <col style="width:125px" />
            <col style="width:*;" />
        </colgroup>
        <tbody>
            <tr>
                <th scope="row">주문자명</th>
                <td>${orderInfo.buyerName }</td>
                <th scope="row">이메일</th>
                <td>${orderInfo.buyerEmail }</td>
            </tr>
            <tr>
                <th scope="row">전화번호</th>
                <td>${orderInfo.telePhone }</td>
                <th scope="row">휴대폰</th>
                <td>${orderInfo.handPhone }</td>
            </tr>
        </tbody>
    </table>

    <h4 class="tit01">배송지정보</h4>
    <table class="table01">
        <caption>배송지정보 <span>주문자명, 전화번호, 휴대폰, 주소, 전달메시지, 주문요청사항, 배송요청사항</span></caption>
        <colgroup>
            <col style="width:125px" />
            <col style="width:245px" />
            <col style="width:125px" />
            <col style="width:*;" />
        </colgroup>
        <tbody>
            <tr>
                <th scope="row">주문자명</th>
                <td colspan="3">${orderInfo.receiverName }</td>
            </tr>
            <tr>
                <th scope="row">전화번호</th>
                <td>${orderInfo.receiverTelePhone }</td>
                <th scope="row">휴대폰</th>
                <td>${orderInfo.receiverHandPhone }</td>
            </tr>
            <tr>
                <th scope="row">주소</th>
                <td colspan="3"><c:if test="${!empty orderInfo.receiverPostNum}">${fn:substring(orderInfo.receiverPostNum,0,3)}-${fn:substring(orderInfo.receiverPostNum, 3,6)}<br /></c:if> ${orderInfo.receiverAddress }${orderInfo.receiverDetailAddress }</td>
            </tr>
            <tr>
                <th scope="row">전달메시지</th>
                <td colspan="3">${orderInfo.giftMessage }</td>
            </tr>
            <tr>
                <th scope="row">주문요청사항</th>
                <td colspan="3">${orderInfo.orderMessage }</td>
            </tr>
            <tr>
                <th scope="row">배송요청사항</th>
                <td colspan="3">${orderInfo.deliveryMessage }</td>
            </tr>
        </tbody>
    </table>
    <div class="btn_area t_center mgt50">
        <a href="javascript:goList()" class="btn_type03">목록으로</a>
    </div>

</div>
<!-- //sub contents -->
</body>
</html>