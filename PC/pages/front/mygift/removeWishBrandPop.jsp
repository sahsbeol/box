<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="popup"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>브랜드좋아요 삭제하기 &lt; 핫트랙스</title>
</head>
<body>
<h1><img src="${imageServer}/images/renewal/common/tit_pop_list_wish.gif" alt="좋아요" /></h1>
<div class="pop_cont">
    <div class="pop_tit">
        <strong><span class="point02">${dto.brandName}</span> 우린 인연이 아닌가봐요ㅜ.ㅜ '좋아요' 취소할게요!</strong>
    </div>
    <ul class="list_type02">
        <li>'좋아요'하신 브랜드는 <span class="bold">마이핫트랙스</span> &gt; 좋아요 브랜드♥ 에서도 삭제되었습니다.</li>
    </ul>
    <div class="info_box">
        <div class="incont">
            <p>MY HOTTRACKS &gt; 내가 '좋아요♥'한 브랜드 <a href="javascript:parent.opener.location.href ='/ht/mypage/listWishBrand';self.close();" class="btn_type05 mgl10">바로가기</a></p>
        </div>
    </div>
</div>
<div class="pop_close">
    <a href="javascript://" onclick="self.close()">닫기</a>
</div>
</body>
</html>
