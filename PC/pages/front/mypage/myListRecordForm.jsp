<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="popup" />
<html>
<head>
<script type="text/javascript">

// 담기 처리
function add(folderSeq){
    $.ajax({
        async : true, 
        url : "/ht/mypage/myListRecordAdd",
        dataType : "json", 
        type : "post", 
        data : {
    	   myListFolderSeq : folderSeq, 
    	   rcrdCdList : "${c.rcrdCdList}" 
        }, 
        success : function(result, textStatus, XMLHttpRequest){
            if(result.errorMessages.length == 0){
                location.href = "/ht/mypage/myListRecordAddEnd?folderSeq="+folderSeq;
            }else{
                alert(result.errorMessages[0]);
            }
        }, 
        error: function(XMLHttpRequest, textStatus, errorThrown){
        	alert(request.status + " => " + request.statusText);
        }
    });
}


// 폴더생성후 담기 처리
function addFolderCreate(){
    var folderName = $("input[name=newFolderName]").val();

    if(folderName == ""){ alert("폴더명을 입력해 주십시오."); return; }
	
    $.ajax({
        async : true, 
        url : "/ht/mypage/myListRecordAddByFolder",
        dataType : "json", 
        type : "post", 
        data : {
           folderName : folderName, 
           rcrdCdList : "${c.rcrdCdList}" 
        }, 
        success : function(result, textStatus, XMLHttpRequest){
            if(result.errorMessages.length == 0){
            	location.href = "/ht/mypage/myListRecordAddEnd";
            }else{
                alert(result.errorMessages[0]);
            }
        }, 
        error: function(XMLHttpRequest, textStatus, errorThrown){
            alert(request.status + " => " + request.statusText);
        }
    });
}


function move(seq){
	opener.location.href = "/ht/mypage/myListRecordList?myListFolderSeq=" + seq;
	window.close();
}


$(document).ready(function(){
	window.resizeTo(498, 590);
});
</script>
</head>
<body>
<div style="width:480px;">
    <h1><img src="${imageServer}/images/renewal/common/tit_mylist.gif" alt="마이리스트에 담기" /></h1>
    <div class="pop_cont" style="height:350px;overflow-y:scroll;">
    
        <div class="box_gray03 pd14 mgt10">
            <ul class="list_type02">
                <li>담을 폴더를 선택하여 주세요</li>
            </ul>
        </div>
    
        <table class="table02 mgt15">
            <caption>마이리스트 상세정보</caption>
            <colgroup>
                <col width="50px" />
                <col width="*" />
                <col width="60px" />
                <col width="150px" />
            </colgroup>
            <thead>
                <tr>
                    <th colspan="4">담은 앨범 폴더명</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${folderList}" var="l" varStatus="st">
                    <tr>
                        <td>${st.count}</td>
                        <td>${l.folderName}</td>
                        <td>(${l.itemCnt})</td>
                        <td>
                            <a href="javascript://" onclick="add('${l.myListFolderSeq}')" class="btn_type01">담기</a>
                            <a href="javascript://" onclick="move('${l.myListFolderSeq}')" class="btn_type01">보기</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    
        <h2 class="tit01 mgt30">새폴더에 담기</h2>
        <div class="box_gray03 pd14">
            <input type="text" name="newFolderName"  class="input_txt" title="새폴더명 입력" style="width:330px;" />
            <a href="javascript://" onclick="addFolderCreate()" class="btn_type01">담기</a>
        </div>
        <ul class="list_type02 mgt10">
            <li>폴더는 50개까지 생성 가능합니다.</li>
            <li>한 폴더당 100곡까지 담으실 수 있습니다.</li>
        </ul>
    
    
    </div>
    <div class="pop_close">
        <a href="javascript://" onclick="self.close()">닫기</a>
    </div>
</div>
</body>
</html>