<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>Q&amp;A | 쇼핑도우미 | MY HOTTRACKS - HOTTRACKS</title>
<script type="text/javascript">
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
});

function deleteWithAjax(seq){
    if (confirm("<fmt:message key='confirm.delete.message'/>")){
     }else{
        return false;
    }
    
    $.ajax({
          type: "POST"
        , url: "/ht/product/deleteArticle"
        , dataType: "json"
        , data:{seq:seq}
        , success : function(){
              location.reload();
        }
    });
}

function windowOpen4Modify(seq){
    window.open("/ht/product/questionPopup4Modify?seq=" + seq, "", "width=500, height=600, scrollbars=no");
}
</script>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_my_hottracks.gif" alt="My Hottracks"/></h2>
    <div class="loc"><a href="#" class="home">Home</a><em>MY HOTTRACKS</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/mypage/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_question_list.gif" alt="상품 Q&amp;A 내역" /></h3>
    <ul class="list_type02">
        <li>상품페이지에서 문의하신 질문에 대한 답변을 편리하게 보실 수 있습니다.</li>
        <li>상품이미지를 클릭하시면 상품 상세페이지로 이동하실 수 있습니다.</li>
    </ul>
    
    <div class="tbl_desc mgt50">현재 <em>${answeredRowSize}</em> 건의 문의에 대한 답변을 준비중입니다.</div>
    <table class="bbs_list01">
        <caption>상품 Q&amp;A 내역 <span>작성일자, 상품, 제목, 답변여부</span></caption>
        <colgroup>
            <col style="width:90px" />
            <col style="width:100px" />
            <col style="width:*" />
            <col style="width:90px" />
            <col style="width:80px" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">작성일자</th>
                <th scope="col">상품</th>
                <th scope="col" colspan="2">제목</th>
                <th scope="col" class="last">답변여부</th>
            </tr>
        </thead>
        <tbody id="qnaTbody">
            <c:forEach items="${list}" var="l" varStatus="st">
                <tr>
                    <td><fmt:formatDate pattern="yyyy/MM/dd" value="${l.registerDate}" /></td>
                    <td>
                        <c:if test="${fn:contains('DR' ,l.sellPrdtGbn) }"><a href="/ht/record/detail/${l.barcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn }" alt="${l.productName}" width="50" ratingCode="${l.rtngCode }"/></a></c:if>
                        <c:if test="${!fn:contains('DR' ,l.sellPrdtGbn) }"><a href="/p/${l.barcode}"><ui:image src="${l.productImageUrl}" alt="${l.productName}" size="50" server="product"/></a></c:if>
                    </td>
                    <td class="t_left"><a href="#qna-content0${st.index + 1}" class="click"><c:out value="${l.title}" escapeXml="true"/></a></td>
                    <td>
                        <c:if test="${l.answerYn ne 'Y'}">
                            <a class="btn_type02" href="javascript://" onclick="windowOpen4Modify('${l.seq}')">수정</a>
                            <a class="btn_type02" href="javascript://" onclick="deleteWithAjax('${l.seq}')">삭제</a>
                        </c:if>
                    </td>
                    <td><ui:gubun key="procStatGbn" value="${l.procStatGbn}"/></td>
                </tr>
                <tr class="conts" id="qna-content0${st.index + 1}">
                    <td colspan="5">
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
            <c:if test="${empty list}"><tr><td colspan="4" class="no_data">SOS상담 내역이 없습니다.</td></tr></c:if>
        </tbody>
    </table>

    <!-- paging -->
    <div class="paging">
        <ui:pagination url="/ht/mypage/questionList" name="pageHolder"  />
    </div>
    <!-- //paging -->

</div>
<!-- //sub contents -->
</body>
</html>
