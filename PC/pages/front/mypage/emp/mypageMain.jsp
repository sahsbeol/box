<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<style type="text/css">
a.aprdtName{display: block;width: 100%; margin-bottom : 17px;}
a.aprdtName div{height: 22px;}
p.txt2{text-align: left;position:relative; top:-28px;}
p.prdtName {text-overflow: ellipsis; display: inline-block; overflow: hidden; width: 98%; white-space: nowrap; text-align: left; height:22px;}
p.specName {color:#DA2128;line-height:20px; text-align: left;position:relative; top:-35px;text-overflow: ellipsis; display: inline-block; overflow: hidden; width: 98%; white-space: nowrap; text-align: left;height: 22px;}
div.btn_orange{display: inline-block; margin-top: 0; position: relative;left: 150px;  top: -24px;  padding: 2px 0; width: 90px; text-align: center; min-height: 22px;}
</style>
<title>마이핫트랙스 - HOTTRACKS</title>
<script type="text/javascript">
function goReview(barcode, orderNum, orderPrdtInseq, rcrdCd){
    window.open(paramFactory("/ht/product/commentPopup4write", barcode, orderNum, orderPrdtInseq, rcrdCd), "", "width=500, height=600, scrollbars=no");
}
function paramFactory(urlStr, barcode, orderNum, orderPrdtInseq, rcrdCd){
    var url = urlStr;
    url += "?barcode="+barcode+"&orderNum="+orderNum+"&orderPrdtInseq="+orderPrdtInseq+"&rcrdCd="+rcrdCd+"&pageCheck=98";
    return url;
}
jQuery(function($){
    $("tbody#qnaTbody tr td a.click").click(function(event) {
        event.preventDefault(); // # 링크 이동 중지
        var selectHref = $(this).attr("href");
        if($(selectHref).hasClass("on")){
            $(selectHref).removeClass("on");
        }else{
            $(selectHref).addClass("on");
        }
    });
    
    $("tbody#sosTbody tr td a.click").click(function(event) {
        event.preventDefault(); // # 링크 이동 중지
        var returnSeq = $(this).attr("id");
        var tr = $($(this).attr("href"));
        if(!tr.hasClass("on")){
            $.ajax({
                type: "GET"
                , url: "/ht/mypage/getSosCounsel"
                , data: "returnSeq=" + returnSeq
                , dataType: "json"
                , success: function(data) {
                    var counsel = data.counsel;
                    var listProduct = counsel.listProduct;
                    var listProductStr = "";
                    var htmlStr = "";
                    
                    if (listProduct.length >= 1) {
                        listProductStr = "[" + counsel.orderNum + "] " + listProduct[0].productName;
                    }
                    
                    var htmlStr;
                    htmlStr += "<div class=\"one\">";
                    htmlStr += "    <p style='padding:5px 0;'><strong>문의]</strong> <em>" + counsel.counselTitle + "</em></p>";
                    htmlStr += "    <p style='padding:5px 0;color:#FF0000;'>" + listProductStr + "</p>";
                    htmlStr += "    <p style='padding:5px 0;'>" + counsel.counselContent + "</p>";
                    htmlStr += "</div>";
                    
                    if (counsel.sosProcessGubun == "E") {
                        htmlStr += "<div class=\"two\">";
                        htmlStr += "    <p style='padding:5px 0;'><strong>답변]</strong></span> <em>답변일시 : " + counsel.lastModifyDtm + "</em>";
                        htmlStr += "    <p style='padding:5px 0;'>" + counsel.replyContent + "</p>";
                        htmlStr += "</div>";
                     }
                     tr.find("div").html(htmlStr);
                }
                , error: function() {
                    alert("<fmt:message key='error.common.system'/>");
                }
            });
            
            tr.addClass("on");
        }else{
            tr.removeClass("on");
        }
    });
});
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
    
    <div class="my_list_section">
        <h3 class="tit01 mgt0">주문/배송조회</h3>
        <table class="bbs_list01">
            <caption>주문/배송조회 <span>주문일, 주문번호, 주문상품, 주문금액, 주문상태</span></caption>
            <colgroup>
                <col style="width:80px" />
                <col style="width:126px" />
                <col style="width:*" />
                <col style="width:100px" />
                <col style="width:100px" />
                <col style="width:110px" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col" class="fir">주문일</th>
                    <th scope="col">주문번호</th>
                    <th scope="col">주문상품</th>
                    <th scope="col">-</th>
                    <th scope="col">주문금액</th>
                    <th scope="col" class="last">주문상태</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${orderList}" var="l" varStatus="st">
                    <tr>
                        <td><fmt:formatDate value="${l.orderDatetime}" pattern="yyyy.MM.dd" var="chkdt"/>${chkdt}</td>
                        <td><a href="/ht/mypage/orderDeliveryDetail?orderNo=${l.orderNum }&orderTermType=${orderCriteria.orderTermType }">${l.orderNum}</a></td>
                        <td>
                            <a href="/ht/mypage/orderDeliveryDetail?orderNo=${l.orderNum }&orderTermType=${orderCriteria.orderTermType }" class="aprdtName">
                                <c:forEach items="${l.listChild}" var="prod" varStatus="sd">
                                    <div style="margin-top : ${sd.index ne 0 ? '17px': '0'};">
                                        <p class="prdtName">${prod.prdtName }</p>
                                        
                                        <c:set var="cntPos" value="0"/>
                                        <c:if test="${not empty prod.sendNo || (prod.reviewCnt eq 0 && prod.orderStatusCode eq 'C0124')}">
                                            <c:if test="${prod.reviewCnt eq 0 && prod.orderStatusCode eq 'C0124' && prod.ableReview ne '-1'}">  <!--  작성한 적이 없고, 배송완료이고, 작성 기한안에 있다면 -->
                                                <c:set var="cntPos" value="1"/>
                                               <div class="btn_orange"><span onclick="javascript:goReview('${prod.barcode }', '${prod.orderNum}', '${prod.orderPrdtInseq}','${prod.rcrdCd }')" class="btn_edit">상품평 쓰기</span></div>
                                            </c:if>
                                            <!-- 음반이면 버튼 없애기 / 기프트 인경우에만 (상품평 적립 완료, 혹은 상품평 쓰기 완료)-->
                                            <c:if test="${empty prod.rcrdCd }">
                                                <c:if test="${prod.reviewCnt ne 0 && prod.orderStatusCode eq 'C0124' && resultComment ne 1}"><!--  상품 후기완료 && 배송완료 && 적립 전  -->
                                                    <c:set var="cntPos" value="1"/>
                                                    <div class="btn_orange"><span onclick="return false;" class="btn_black">상품평 작성완료</span></div>
                                                </c:if>
                                                <c:if test="${prod.reviewCnt ne 0 && prod.orderStatusCode eq 'C0124' && resultComment eq 1}"><!--  상품 후기완료 && 배송완료 && 적립 후  -->
                                                    <c:set var="cntPos" value="1"/>
                                                    <div class="btn_orange"><span onclick="return false;" class="btn_black">상품평 적립완료</span></div>
                                                </c:if>
                                            </c:if>
                                        </c:if>
                                        <c:if test="${cntPos eq 0}"><div class="btn_orange"></div></c:if>
                                        <c:if test="${not empty prod.kyoboSelectOptionStr }">
                                            <p class="txt2" >${prod.kyoboSelectOptionStr}</p></c:if>
                                        <c:if test="${not empty prod.specName }">
                                            <p class="specName">└ ${prod.specName}
                                                <span class="price" style="font-weight: bold;">
                                                   (<fmt:formatNumber value="${prod.orderCount}" type="number"/>개)</span>
                                            </p>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </a>
                        </td>
                        <td></td>
                        <td><fmt:formatNumber value="${l.orderPrdtAmt}" pattern="#,###"/>원</td>
                        <td>
                            <c:choose>
                                <c:when test="${l.orderStatusCode eq 'C0123'}"><span style="color:#ff0000;"><ui:code codeId="${l.orderStatusCode}"/></span></c:when>
                                <c:when test="${l.orderStatusCode eq 'C0124'}"><span style="color:#000000;"><ui:code codeId="${l.orderStatusCode}"/></span></c:when>
                                <c:otherwise><span style="color:#DADADA"><ui:code codeId="${l.orderStatusCode }" /></span></c:otherwise>
                            </c:choose>
                            <c:if test="${l.escrowYn eq 'true' && empty l.escrowAgreementGbn && (l.orderStatusCode eq 'C0123' || l.orderStatusCode eq 'C0124')}">
                                <br /><span class="btn_type02"><a href="javascript://" onclick="escrowAgreement('${l.orderNum}');">구매확정</a></span>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <a href="/ht/mypage/orderDelivery" class="btn_more" title="주문/배송조회 더보기">MORE +</a>
    </div>
    <c:if test="${not empty user}">
        <div class="my_list_section">
            <h3 class="tit01">좋아요♥ 상품</h3>
            <div class="zzim-list">
                <c:if test="${not empty wishProductList}">
                    <ul>
                        <c:forEach items="${wishProductList}" var="l" varStatus="st">
                            <li>
                                <c:if test="${fn:contains('DR', l.sellPrdtGbn)}"><a href="/ht/record/detail/${l.barcode}" target="_blank" title="[${l.productName}] 상세페이지 새창에서 열림"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="100" style="width:${l.sellPrdtGbn eq 'D'?'66':'100'}px;height:100px;" ratingCode="${l.rtngCode }" alt="${l.productName}"/></a></c:if>
                                <c:if test="${!fn:contains('DR', l.sellPrdtGbn)}"><a href="/ht/product/detail?barcode=${l.barcode}" target="_blank" title="[${l.productName}] 상세페이지 새창에서 열림"><ui:image src="${l.productImageUrl}" src2="${l.productImageUrl2}" server="product" size="100" alt="${l.productName}"/></a></c:if>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
                <c:if test="${empty wishProductList}"><p class="no_data">찜한 상품이 없습니다.</p></c:if>
            </div>
            <a href="/ht/mypage/listWishProduct" class="btn_more" title="찜한 상품 더보기">MORE +</a>
        </div>
        <div class="my_list_section">
            <h3 class="tit01">좋아요♥ 브랜드</h3>
            <div class="zzim-list">
                <c:if test="${not empty wishBrandList}">
                    <ul>
                        <c:forEach items="${wishBrandList}" var="l" varStatus="st">
                            <li><a href="/ht/hot/brandDetail?brandId=${l.brandId}" target="_blank" title="[${l.brandEngName}] 상세페이지 새창에서 열림"><ui:image src="${l.productImageUrl}" src2="${l.productImageUrl2}" server="product" size="100" alt="${l.brandEngName}"/></a></li>
                        </c:forEach>
                    </ul>
                </c:if>
                <c:if test="${empty wishBrandList}"><p class="no_data">찜한 브랜드가 없습니다.</p></c:if>
            </div>
            <a href="/ht/mypage/listWishBrand" class="btn_more" title="찜한 브랜드 더보기">MORE +</a>
        </div>
        <div class="my_list_section">
            <h3 class="tit01">내 상품평</h3>
            <table class="bbs_list01">
                <caption>내 상품평 <span>작성일, 상품, 내용, 만족도</span></caption>
                <colgroup>
                    <col style="width:80px" />
                    <col style="width:106px" />
                    <col style="width:*" />
                    <col style="width:110px" />
                </colgroup>
                <thead>
                    <tr>
                        <th scope="col" class="fir">작성일</th>
                        <th scope="col">상품</th>
                        <th scope="col">내용</th>
                        <th scope="col" class="last">만족도</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${postscriptList}" var="l" varStatus="st">
                        <tr> 
                            <td><fmt:formatDate pattern="yyyy.MM.dd" value="${l.registerDate}" /></td>
                            <td>
                                <c:if test="${fn:contains('DR' ,l.sellPrdtGbn) }"><a href="/ht/record/detail/${l.barcode}" target="_blank" title="[${l.productName}] 상세페이지 새창에서 열림"><ui:image rcrdCd="${l.rcrdCd}" alt="${l.productName}" prdtGbn="${l.sellPrdtGbn}" width="100" style="width:${l.sellPrdtGbn eq 'D'?'33':'50'}px;height:50px;" ratingCode="${l.rtngCode }"/></a></c:if>
                                <c:if test="${!fn:contains('DR' ,l.sellPrdtGbn) }"><a href="/p/${l.barcode}" target="_blank" title="[${l.productName}] 상세페이지 새창에서 열림"><ui:image src="${l.productImageUrl}" alt="${l.productName}" server="product" size="50"/></a></c:if>
                            </td>
                            <td class="t_left">${hfn:lineToBr(l.title)}<c:if test="${l.publicYn eq 'N'}">[비공개]</c:if></td> 
                            <td>
                                <span class="star_grade">
                                    <span class="hidden_obj">별 5개 만점중</span>
                                    <span class="grade" style="width:${l.grade/5*100}%">별${l.grade}개</span>
                                </span>
                            </td> 
                        </tr>
                    </c:forEach>
                    <c:if test="${empty postscriptList}"><tr><td colspan="4" class="no_data">상품평 내역이 없습니다.</td></tr></c:if>
                </tbody>
            </table>
            <a href="/ht/mypage/commentList" class="btn_more" title="내 상품평 더보기">MORE +</a>
        </div>
        <div class="my_list_section">
            <h3 class="tit01">상품 Q&amp;A</h3>
            <table class="bbs_list01">
                <caption>상품 Q&amp;A <span>작성일, 상품, 내용, 만족도</span></caption>
                <colgroup>
                    <col style="width:80px" />
                    <col style="width:106px" />
                    <col style="width:*" />
                    <col style="width:110px" />
                </colgroup>
                <thead>
                    <tr>
                        <th scope="col" class="fir">작성일</th>
                        <th scope="col">상품</th>
                        <th scope="col">내용</th>
                        <th scope="col" class="last">답변여부</th>
                    </tr>
                </thead>
                <tbody id="qnaTbody">
                    <c:forEach items="${qnaList}" var="l" varStatus="st">
                        <tr> 
                            <td><fmt:formatDate pattern="yyyy.MM.dd" value="${l.registerDate}" /></td>
                            <td>
                                <c:if test="${fn:contains('DR' ,l.sellPrdtGbn) }"><a href="/ht/record/detail/${l.barcode}" target="_blank" title="[${l.productName}] 상세페이지 새창에서 열림"><ui:image rcrdCd="${l.rcrdCd}" alt="${l.productName}" prdtGbn="${l.sellPrdtGbn}" width="100" style="width:${l.sellPrdtGbn eq 'D'?'31':'47'}px;height:47px;" ratingCode="${l.rtngCode }"/></a></c:if>
                                <c:if test="${!fn:contains('DR' ,l.sellPrdtGbn) }"><a href="/p/${l.barcode}" target="_blank" title="[${l.productName}] 상세페이지 새창에서 열림"><ui:image src="${l.productImageUrl}" alt="${l.productName}" server="product" width="47" height="47"/></a></c:if>
                            </td>
                            <td class="t_left"><a href="#qna-content0${st.count}" class="click"><c:out value="${l.title}" escapeXml="true"/><c:if test="${l.publicYn eq 'N'}">[비공개]</c:if></a></td> 
                            <td><ui:gubun key="procStatGbn" value="${l.procStatGbn}"/></td> 
                        </tr> 
                        <tr class="conts" id="qna-content0${st.count}">
                            <td colspan="4">
                                <div class="txt">
                                    <p class="question-content">${hfn:lineToBr(l.content)}</p>
                                    <c:choose>
                                        <c:when test="${l.answerYn eq 'Y'}">
                                            <p class="answer" style="border-top:1px dashed #DADADA;border-bottom:1px dashed #DADADA;padding:5px 0;margin:5px 0;color:#DD0000;font-weight:bold;">질문에 대한 답변입니다.</p>
                                            <p class="answer-content">${hfn:lineToBr(l.answerContent)}</p>
                                        </c:when>
                                        <c:otherwise>
                                            <p class="answer" style="border-top:1px dashed #DADADA;border-bottom:1px dashed #DADADA;padding:5px 0;margin:5px 0;color:#DD0000;font-weight:bold;">답변준비 중 입니다.</p>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                         </tr>
                    </c:forEach>
                    <c:if test="${empty qnaList}"><tr><td colspan="4" class="no_data">상품 Q&amp;A 내역이 없습니다.</td></tr></c:if>
                </tbody>
            </table>
            <a href="/ht/mypage/questionList" class="btn_more" title="상품 Q&amp;A 더보기">MORE +</a>
        </div>
    </c:if>
    <div class="my_list_section">
        <h3 class="tit01">SOS 상담</h3>
        <table class="bbs_list01">
            <caption>SOS 상담 <span>작성일, 상담구분, 내용, 답변여부</span>
            </caption>
            <colgroup>
                <col style="width:80px" />
                <col style="width:126px" />
                <col style="width:*" />
                <col style="width:106px" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col" class="fir">작성일</th>
                    <th scope="col">상담구분</th>
                    <th scope="col">내용</th>
                    <th scope="col" class="last">답변여부</th>
                </tr>
            </thead>
            <tbody id="sosTbody">
                <c:forEach items="${sosList}" var="l" varStatus="st">
                    <tr> 
                        <td><fmt:formatDate value="${l.registDtm}" pattern="yyyy.MM.dd"/></td>
                        <td><ui:code codeId="${l.sosCounselCode}"/></td>
                        <td class="t_left"><a href="#sos-content0${l.returnSeq}" id="${l.returnSeq}" class="click">${l.counselTitle}</a></td> 
                        <td>${l.sosProcessGubun eq 'E'?'YES':'NO'}</td>
                    </tr>
                    <tr class="conts" id="sos-content0${l.returnSeq}"><td colspan="4"><div class="txt"></div></td></tr>
                </c:forEach>
                <c:if test="${empty sosList}"><tr><td colspan="4" class="no_data">SOS 상담 내역이 없습니다.</td></tr></c:if>
            </tbody>
        </table>
        <a href="/ht/mypage/listSosCounsel" class="btn_more" title="SOS 상담 더보기">MORE +</a>
    </div>
    </div>
</body>
</html>
