<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<table class="bbs_list_v2 mgt20">
    <caption>상품후기 <span>번호, 만족도, 상품평, 작성자, 작성일</span>
    </caption>
    <colgroup>
        <col width="70px">
        <col width="94px">
        <col width="*">
        <col width="60px">
        <col width="80px">
        <col width="100px">
    </colgroup>
    <thead>
        <tr>
            <th scope="col" class="fir">번호</th>
            <th scope="col">만족도</th>
            <th scope="col" colspan="2">상품평</th>
            <th scope="col">작성자</th>
            <th scope="col" class="last">작성일</th>
        </tr>
    </thead>
    <tbody>
        <c:if test="${empty list}">
            <tr><td colspan="6" class="no_data">등록된 상품후기가 없습니다.</td></tr>
        </c:if>
        <c:forEach items="${list}" var="dto" varStatus="status">
            <tr>
                <td>${pageHolder.startNumber + status.index}</td>
                <td>
                    <span class="star_grade">
                        <span class="hidden_obj">별 5개 만점중</span>
                        <span class="grade" style="width:${dto.grade/5*100}%">별${dto.grade}개</span>
                    </span>
                </td>
                <td class="t_left">
                    <c:if test="${not empty dto.imageUrl}">
                      <ui:image src="${dto.imageUrl}" style="max-width:100%;"/><br/><br/>
                    </c:if>
                    ${hfn:lineToBr(dto.title)}</td>
                </td>
                <td>
                    <c:if test="${isLogin}"> 
                        <c:if test="${dto.userNum eq currentLoginUserNum}">
                            <input type="hidden" name="seq" value="${dto.seq}" />
                            <a class="aModifyCommentBtns btn_type02" href="#aWriteCommentBtn">수정</a>
                            <a class="aDeleteCommentBtns btn_type02 mgt5" href="#aWriteCommentBtn">삭제</a>
                        </c:if>
                    </c:if>
                </td>
                <td><ui:idAsterisk value="${dto.userId}"/></td>
                <td><fmt:formatDate pattern="yyyy/MM/dd" value="${dto.registerDate}" /></td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<!-- paging -->
<div class="paging mgt40">
    <ui:paginationScript name="pageHolder" scriptName="loadCommentSubList" parameters="barcode"/>
</div>
<!-- //paging -->
<script type="text/javascript">
jQuery(function($) {
    function ajaxSuccessHandler(result){
        if(result){
            var isSuccss         = result.isSuccess;
            var errorMessages     = result.errorMessages;
            if(isSuccss){
                loadCommentSubList();
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
    $("span.product-estimation").each(function(){
        var $pCommentCount = $(this);
        $pCommentCount.text("(${listSize})");
    });
    
    $(".aDeleteCommentBtns").each(function(){
           var $aBtn = $(this);
           var $inputSeq = $aBtn.siblings(0);
           var seqVal = $inputSeq.val();
           $aBtn.bind("click",{seq:seqVal} ,deleteWithAjax);
    });
    
    function windowOpen4Modify(e){
        window.open("/ht/product/commentPopup4Modify?seq=" + e.data.seq, "", "width=500, height=600, scrollbars=no");
    }
    
    $(".aModifyCommentBtns").each(function(){
        var $aBtn = $(this);
        var $inputSeq = $aBtn.siblings(0);
        var seqVal = $inputSeq.val();
        $aBtn.bind("click", {seq:seqVal}, windowOpen4Modify);
    });
});
</script>