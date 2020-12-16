<%@page contentType="text/html;charset=utf-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="popup" />
<html>
<head>
<script type="text/javascript">

$(document).ready(function(){
	window.resizeTo(498, 350);
});

function viewListFolder(){
	var folderSeq = "${param.folderSeq}";
	var query = folderSeq ? "?myListFolderSeq="+folderSeq : "";
	
	opener.location.href="/ht/mypage/myListRecordList"+query;
	self.close();
}
</script>
</head>
<body>
<div class="popup" style="width:480px;">
    <h1><img src="${imageServer}/images/renewal/common/tit_mylist02.gif" alt="마이리스트에 담기 완료" /></h1>
    <div class="pop_cont">
    
        <div class="box_gray03 pd14 mgt10 t_center">
            <p class="point03">마이리스트에 담기가 완료되었습니다.</p>
            <p class="line18 mgt10">"담은 음반에 선택하신 상품이 담겼습니다.<br />담은 음반을 확인 하시겠습니까?"</p>
        </div>
    
        
        <div class="btn_area t_center mgt30">
            <a href="javascript://" onclick="viewListFolder()" class="btn_type01" style="width:51px">확인</a>
            <a href="javascript://" onclick="window.close()" class="btn_type02" style="width:51px">취소</a>
        </div>
    
    </div>
    <div class="pop_close">
        <a href="javascript://" onclick="self.close()">닫기</a>
    </div>
</div>
</body>
</html>