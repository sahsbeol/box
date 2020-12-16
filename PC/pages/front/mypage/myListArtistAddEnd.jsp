<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="popupRecord" />
<html>
<head>
<script type="text/javascript">

$(document).ready(function(){
	window.resizeTo(480, 350);
});

function viewListFolder(){
	var folderSeq = "${param.folderSeq}";
	var query = folderSeq ? "?myListFolderSeq="+folderSeq : "";
	
	opener.location.href="/ht/mypage/myListArtistList" + query;
	self.close();
}
</script>
</head>
<body>

<div id="popup">
    <div class="pop-head" >
        <h1><img src="${imageServer}/images/popup/h1_logo.gif" alt="Hottracks" /></h1>
        <h2><img src="${imageServer}/images/popup/h2_popup_add_favor_com.gif" alt="마이리스트에 담기 완료" /></h2>
    </div>
    <div class="pop_body">
        <div class="box_addfavor_02">
            <div class="alert">
                <p class="f_black">마이리스트에 담기가 완료되었습니다.</p>
                <p>
                    "선택하신 아티스트가 등록되었습니다.<br />
                                        담은 아티스트를 확인 하시겠습니까?"
                </p>
            </div>
        </div>
        <p class="center">
            <a href="javascript:viewListFolder();"><img src="${imageServer}/images/music/btn_confirm.gif" alt="확인" /></a>
            <a href="javascript:window.close();"><img src="${imageServer}/images/music/btn_cancel.gif"  alt="취소" /></a>
        </p>  
    </div>
    <div class="popup-foot">
        <button type="button" onclick="self.close()"><img src="${imageServer}/images/popup/btn_close.gif" alt="닫기" /></button>
    </div>
</div>






















</body>
</html>