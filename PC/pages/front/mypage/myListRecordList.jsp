<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>담은음반 | 마이리스트 | MY HOTTRACKS - HOTTRACKS</title>
<script type="text/javascript">
function addFolder() {
    window.open("/ht/mypage/popup/addFolder?folderCode=${folderCode}", "popup", 'width=600, height=310');
}

function modFolder(){
    var myListFolderSeq = $("input[name=myListFolderSeq]").val(); 
    var folderName = $("input[name=folderName]").val(); 
    
    if(!folderName || !myListFolderSeq){
        alert("폴더를 선택하여 주십시오.");
        return;
    }
    
    window.open("/ht/mypage/popup/modFolder?folderCode=${folderCode}&myListFolderSeq=" + myListFolderSeq + "&folderName=" + folderName, 'popup', 'width=600, height=310');
}

function delFolder(){
    var myListFolderSeq = $("input[name=myListFolderSeq]").val(); 
    
    if(!myListFolderSeq || !myListFolderSeq){
        alert("폴더를 선택하여 주십시오.");
        return;
    }
    
    if(confirm("폴더내 모든 내용이 삭제됩니다.\n삭제하시겠습니까?")){
        $.ajax({
            url: "/ht/mypage/delFolder"
            ,data : {
                myListFolderSeq : myListFolderSeq
            }
            ,success : function(data){
                alert("폴더 삭제에 성공 하셨습니다.");
                location.href="/ht/mypage/myListRecordList";
            } 
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function delList(seq){
    if(confirm("해당 음반을 정말로 삭제하시겠습니까?")){
        $.ajax({
            url: "/ht/mypage/delList"
            ,data : "myListSeq="+seq
            ,success : function(data){
                alert("음반 삭제에 성공 하셨습니다.");
                location.reload();
            } 
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

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
    
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_my_list_record_list.gif" alt="담은음반" /></h3>
    
    <h4 class="tit01">담은 음반 폴더 <span class="normal">(<fmt:formatNumber type="number">${folderListCnt}</fmt:formatNumber>)</span></h4>
    <div class="tbl_top">
        <a href="javascript://" onclick="addFolder()" class="btn_type01">+ 폴더추가</a>
        <a href="javascript://" onclick="modFolder()" class="btn_type01">폴더명수정</a>
        <a href="javascript://" onclick="delFolder()" class="btn_type01">- 폴더삭제</a>
    </div>
    <div class="box_gray03">
        <ul class="folder">
            <c:forEach items="${folderList}" var="l" varStatus="st">
                <c:if test="${l.myListFolderSeq eq c.myListFolderSeq}"><c:set var="folderName" value="${l.folderName}"/></c:if>
                <li>
                    <a href="/ht/mypage/myListRecordList?myListFolderSeq=${l.myListFolderSeq}">
                        <span>${st.count}</span>
                        ${l.folderName}
                    </a>
                    <span class="date"><fmt:formatDate value="${l.modDtm}" pattern="yyyy.MM.dd"/></span>
                </li>
            </c:forEach>
        </ul>
    </div>
    <h4 class="tit01">담은 음반 <span class="normal">|</span> <span class="normal fs12">${folderName}(<fmt:formatNumber type="number">${listCnt}</fmt:formatNumber>)</span></h4>
    <div class="p_list">
        <input type="hidden" name="myListFolderSeq" value="${c.myListFolderSeq}"/>
        <input type="hidden" name="folderName" value="${folderName}"/>
        <ul>
            <c:forEach var="l" items="${list}">
                <li> 
                    <a href="/ht/record/detail/${l.sellPrdtBcode}" class="album_pic"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="150" alt="${l.prdtName}" ratingCode="${l.rtngCode}"/></a>
                    <a href="/ht/record/detail/${l.sellPrdtBcode}" class="tit">${folderName}<br /><ui:cut limit="20">${l.prdtName}</ui:cut><br />${l.trkName}</a>
                    <span class="artist">${l.artiName} | ${l.makerName}</span> 
                    <a href="javascript:delList('${l.myListSeq}');" class="btn_type02">삭제</a>
                </li>
            </c:forEach>
        </ul>
    </div>

    <!-- paging -->
    <div class="paging">
        <ui:pagination url="/ht/mypage/myListRecordList" name="pageHolder" pageParam="page" parameters="pageHolder,myListFolderSeq"/>
    </div>
    <!-- //paging -->

</div>
<!-- //sub contents -->
</body>
</html>