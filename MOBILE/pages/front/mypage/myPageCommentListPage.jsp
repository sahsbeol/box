<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>내 상품평 | 쇼핑리스트 | MY HOTTRACKS - HOTTRACKS</title>
<script type="text/javascript">
function deleteWithAjax(seq){
    if (confirm("<fmt:message key='confirm.delete.message'/>")){
    }else{
        return false;
    }
    
    $.ajax({
        type: "POST"
        ,url: "/ht/product/deleteArticle"
        ,dataType: "json"
        ,data:{seq:seq}
        ,success : function(result){
            if(result){
                var isSuccss = result.isSuccess;
                var errorMessages = result.errorMessages;
                if(isSuccss){
                    location.reload();
                }else{
                    var messageStr ='';
                    for(var i=0; i<errorMessages.length; i++){
                        messageStr += errorMessages[i] + '\n';
                    }
                    alert(messageStr);
                }    
            }
        }
        ,error : function(){
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}

function deleteWithAjaxForMusic(seq){
    if (confirm("<fmt:message key='confirm.delete.message'/>")){
    }else{
        return false;
    }
    
    $.ajax({
        type: "POST"
        ,url: "/ht/product/deleteRecordReview"
        ,dataType: "json"
        ,data:{seq:seq}
        ,success : function(result){
            if(result){
                var isSuccss = result.isSuccess;
                var errorMessages = result.errorMessages;
                if(isSuccss){
                    location.reload();
                }else{
                    var messageStr ='';
                    for(var i=0; i<errorMessages.length; i++){
                        messageStr += errorMessages[i] + '\n';
                    }
                    alert(messageStr);
                }    
            }
        }
        ,error : function(){
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}

function modify(seq){
    window.open("/ht/product/commentPopup4Modify?seq=" + seq, "", "width=500, height=600, scrollbars=no");
}

function loadCommentSubList(){
    location.reload();
};
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
    
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_comment_list.gif" alt="내 상품평" /></h3>
    <ul class="list_type02">
        <li>등록하신 상품평을 편리하게 보실 수 있습니다.</li>
        <li>상품이미지를 클릭하시면 상품상세페이지로 이동하실 수 있습니다.</li>
    </ul>
    
    <div class="tbl_desc mgt50">현재 <em>${listSize}</em> 건의 상품평이 등록되어 있습니다.</div>
    <table class="bbs_list01">
        <caption>내 상품평 <span>작성일자, 상품, 제목, 평점, 수정/삭제</span></caption>
        <colgroup>
            <col style="width:90px" />
            <col style="width:100px" />
            <col style="width:*" />
            <col style="width:110px" />
            <col style="width:70px" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">작성일자</th>
                <th scope="col">상품</th>
                <th scope="col">제목</th>
                <th scope="col">평점</th>
                <th scope="col" class="last"></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${list}" var="dto" varStatus="status">
                <tr>
                    <td><fmt:formatDate pattern="yyyy/MM/dd" value="${dto.registerDate}" /></td>
                    <td>
                        <c:if test="${fn:contains('DR' ,dto.sellPrdtGbn) }"><a href="/ht/record/detail/${dto.barcode}"><ui:image rcrdCd="${dto.rcrdCd}" prdtGbn="${dto.sellPrdtGbn }" server="product" width="50" ratingCode="${dto.rtngCode }" alt="${dto.productName}"/></a></c:if>
                        <c:if test="${!fn:contains('DR' ,dto.sellPrdtGbn) }"><a href="/p/${dto.barcode}"><ui:image src="${dto.productImageUrl}" alt="${dto.productName}" size="50" server="product"/></a></c:if>
                    </td>
                    <td class="t_left">
                        <c:if test="${not empty dto.imageUrl}"><p><ui:image src="${dto.imageUrl}" style="max-width:100%;"/></p></c:if>
                        ${hfn:lineToBr(dto.title)}
                    </td>
                    <td>
                        <span class="star_grade">
                            <span class="hidden_obj">별 5개 만점중</span>
                            <span class="grade" style="width:${dto.grade/5*100}%">별${dto.grade}개</span>
                        </span>
                    </td>
                    <td>
                        <input  type="hidden" name="seq" value="${dto.seq}" />
                        <c:if test="${dto.commentGbn ne 'M' }">
                            <a class="btn_type02" href="javascript://" onclick="modify('${dto.seq}')">수정</a>
                            <a class="btn_type02" href="javascript://" onclick="deleteWithAjax('${dto.seq}')">삭제</a>
                        </c:if>
                        <c:if test="${dto.commentGbn ne 'H' }">
                            <a class="btn_type02" href="javascript://" onclick="deleteWithAjaxForMusic('${dto.seq}')">삭제</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty list}"><tr><td colspan="4" class="no_data">SOS상담 내역이 없습니다.</td></tr></c:if>
        </tbody>
    </table>

    <!-- paging -->
    <div class="paging">
        <ui:pagination url="/m/mypage/commentList" name="pageHolder"  />
    </div>
    <!-- //paging -->

</div>
<!-- //sub contents -->
</body>
</html>
