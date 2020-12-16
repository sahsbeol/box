<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="popupRecord" />
<html>
<head>
<script type="text/javascript">

// 담기 처리
function add(folderSeq){
    $.ajax({
        async : true, 
        url : "/ht/mypage/myListArtistAdd",
        dataType : "json", 
        type : "post", 
        data : {
    	   myListFolderSeq : folderSeq, 
    	   recArtiCdList : "${c.recArtiCdList}" 
        }, 
        success : function(result, textStatus, XMLHttpRequest){
            if(result.errorMessages.length == 0){
                location.href = "/ht/mypage/myListArtistAddEnd?folderSeq=" + folderSeq;
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
        url : "/ht/mypage/myListArtistAddByFolder",
        dataType : "json", 
        type : "post", 
        data : {
           folderName : folderName, 
           recArtiCdList : "${c.recArtiCdList}" 
        }, 
        success : function(result, textStatus, XMLHttpRequest){
            if(result.errorMessages.length == 0){
            	location.href = "/ht/mypage/myListArtistAddEnd";
            }else{
                alert(result.errorMessages[0]);
            }
        }, 
        error: function(XMLHttpRequest, textStatus, errorThrown){
            alert(request.status + " => " + request.statusText);
        }
    });
}


$(document).ready(function(){
	window.resizeTo(480, 605);
});

function goListView(myListFolderSeq){
	opener.location.href = "/ht/mypage/myListArtistList?myListFolderSeq="+myListFolderSeq;
	window.close();
}
</script>
</head>
<body>

<div id="popup">
    <div class="pop-head" >
        <h1><img src="${imageServer}/images/popup/h1_logo.gif" alt="Hottracks" /></h1>
        <h2> <img src="${imageServer}/images/popup/h2_popup_add_favor.gif" alt="마이리스트에 담기" /></h2>
    </div>
    <div class="pop_body" style="height:420px;">
        <div class="box_addfavor">
            <p class="desc">담을 폴더를 선택하여 주세요</p>
            <table>
                <col width="8%" />
                <col width="42%" />
                <col width="15%" />
                <col width="*" />
                <thead>
                    <tr>
                        <th scope="col" colspan="4">담은 아티스트 폴더명</th>
                    </tr>
                </thead>
                <tbody>
					<c:forEach items="${folderList}" var="l" varStatus="s">
	                    <tr>
	                        <td>${s.count}</td>
	                        <td>${l.folderName}</td>
	                        <td>(${l.itemCnt})</td>
	                        <td>
	                           <a href="javascript:add(${l.myListFolderSeq});"><img src="${imageServer}/images/music/btn_add.gif" alt="담기" /></a>
	                           <a href="javascript:goListView('${l.myListFolderSeq}');"><img src="${imageServer}/images/music/btn_view.gif" alt="보기"   /></a>
	                        </td>
	                    </tr>

					</c:forEach>
                </tbody>
            </table>
        
            <div class="add_folder">
                <p class="f_black">새폴더에 담기</p>
                <p class="func">
                    <input type="text" class="input" name="newFolderName" value="" />
                    <a href="javascript:addFolderCreate();"><img src="${imageServer}/images/music/btn_add_red.gif" alt="담기" /></a>
                </p>
                <p>
                                    폴더는 50개까지 생성 가능합니다.
                </p>
            </div> 
        </div>
    </div> 
    <div class="popup-foot_02">
        <button type="button" onclick="self.close()"><img src="${imageServer}/images/popup/btn_close.gif" alt="닫기" /></button>
    </div>
     
</div>























</body>
</html>