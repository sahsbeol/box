<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<table class="bbs_list_v2 mgt20">
    <caption>상품Q&amp;A <span>번호, 구분, 제목, 작성자, 작성일</span></caption>
    <colgroup>
        <col width="70">
        <col width="94">
        <col width="*">
        <col width="60">
        <col width="80">
        <col width="100">
    </colgroup>
    <thead>
        <tr>
            <th scope="col" class="fir">번호</th>
            <th scope="col">구분</th>
            <th colspan="2" scope="col">제목</th>
            <th scope="col">작성자</th>
            <th scope="col" class="last">작성일</th>
        </tr>
    </thead>
    <tbody id="tbodyQna">
        <c:if test="${empty list}"><tr><td colspan="6" class="no_data">등록된 FAQ가 없습니다.</td></tr></c:if>
        <c:forEach items="${list}" var="dto" varStatus="status">
            <tr>
                <td>${pageHolder.startNumber + status.index}</td>
                <td><ui:gubun key="procStatGbn" value="${dto.procStatGbn}"/></td>
                <td class="t_left"><a href="#qna-content0${status.index + 1}" class="click">${hfn:lineToBr(dto.prdtQnaTitle)}</a></td>
                <td>
                    <c:if test="${isLogin && dto.askRegstUserNum eq currentLoginUserNum}"> 
                        <input  type="hidden" name="seq" value="${dto.prdtQnaSeq}" />
                        <c:if test="${dto.aswrYn eq 'N'}">
                            <a class="aModifyQuestionBtn btn_type02" href="#aWriteQuestionBtn">수정</a>
                            <a class="aDeleteQuestionBtn btn_type02 mgt5" href="#aWriteQuestionBtn">삭제</a>
                        </c:if> 
                    </c:if>
                </td>
                <td><ui:idAsterisk value="${dto.userId}"/></td>
                <td><fmt:formatDate pattern="yyyy/MM/dd" value="${dto.askRegstDtm}" /></td>
            </tr>
            <tr class="conts" id="qna-content0${status.index + 1}">
                <td colspan="6" class="detail-content">
                    <div class="txt">
                        <p class="question-content">${hfn:lineToBr(dto.prdtAskCont)}</p>
                        <c:choose>
                            <c:when test="${dto.aswrYn eq 'Y'}">
                                <p class="answer" style="border-top:1px dashed #DADADA;border-bottom:1px dashed #DADADA;padding:5px 0;margin:5px 0;color:#DD0000;font-weight:bold;">질문에 대한 답변입니다.</p>
                                <p class="answer-content">${hfn:lineToBr(dto.prdtAswrCont)}</p>
                            </c:when>
                            <c:otherwise>
                                <p class="answer" style="border-top:1px dashed #DADADA;border-bottom:1px dashed #DADADA;padding:5px 0;margin:5px 0;color:#DD0000;font-weight:bold;">답변준비 중 입니다.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
<!-- paging -->
<div class="paging mgt40">
    <ui:paginationScript name="pageHolder" scriptName="loadQuestionSubList" parameters="barcode"/>
</div>
<!-- //paging -->
 <script type="text/javascript">
jQuery(function($) {
    $("#tbodyQna a.click").click(function(event) {
        event.preventDefault(); // # 링크 이동 중지
        
        var selectHref = $(this).attr("href");
        if($(selectHref).hasClass("on")){
            $(selectHref).removeClass("on");
        }else{
            $(selectHref).addClass("on");
        }
    });
    
    $("span.product-qna").each(function(){
        var $pCommentCount = $(this);
        $pCommentCount.text("(${listSize})");
    });
    
    function ajaxSuccessHandler(result){
        if(result){
            var isSuccss         = result.isSuccess;
            var errorMessages     = result.errorMessages;
            if(isSuccss){
                loadQuestionSubList();
            }else{
                var messageStr ="";
                for(var i=0; i<errorMessages.length; i++){
                    messageStr += errorMessages[i] + "\n";
                }
                alert(messageStr);
            }    
        }
    }
    
    function ajaxErrorHandler(result){
        alert('<fmt:message key="error.common.system"/>');
    }
    
    function deleteWithAjax(e){
        if (confirm("<fmt:message key='confirm.delete.message'/>")){
        }else{
            return false;
        };
        $.ajax({
            type: "POST"
            ,url: "/ht/product/deleteArticle"
            ,dataType: "json"
            ,data:{seq:e.data.seq, barcode:"00"}
            ,success : ajaxSuccessHandler
            ,error : ajaxErrorHandler
        });
        
    }

    $(".aDeleteQuestionBtn").each(function(){
           var $aBtn = $(this);
           var $inputSeq = $aBtn.siblings("[name='seq']");
           var seqVal = $inputSeq.val();
           $aBtn.bind("click",{seq:seqVal} ,deleteWithAjax);
    });
    
    function windowOpen4Modify(e){
        window.open("/ht/product/questionPopup4Modify?seq=" + e.data.seq, "", "width=500, height=600, scrollbars=no");
    }
    
    $(".aModifyQuestionBtn").each(function(){
        var $aBtn = $(this);
        var $inputSeq = $aBtn.siblings("[name='seq']");
        var seqVal = $inputSeq.val();
        $aBtn.bind("click", {seq:seqVal}, windowOpen4Modify);
    });
});
</script>