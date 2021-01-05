<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<html>
<head>
<meta name="apple-mobile-web-app-capable" content="yes"> 
<link rel="apple-touch-icon-precomposed" href="/images/content/ico_app.png" />
<link rel="apple-touch-startup-image" href="/images/content/ico_app.png">
<link href="/favicon.ico" rel="shortcut icon">

<link rel="stylesheet" type="text/css" href="/css/layout.css?201610281645">
<link rel="stylesheet" type="text/css" href="/css/content.css?201611011740">
<link rel="stylesheet" type="text/css" href="/css/common.css?201610281645">

<script type="text/javascript" src="/js/jquery-1.9.1.min.js?201610281645"></script>
<script type="text/javascript" src="/js/jquery.mobile-events.min.js?201610281645"></script>
<script type="text/javascript" src="/js/jquery.lazyload.min.js?201610281645"></script>
<script type="text/javascript" src="/js/idangerous.swiper.min.js?201610281645"></script>
<script type="text/javascript" src="/js/common.js?201610281645"></script>
<script type="text/javascript" src="/js/kakao.min.js?201610281645"></script>
<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>
<script type="text/javascript" src="/scripts/common?201610281645"></script>
<script type="text/javascript" src="/scripts/loadingBar?201610281645"></script>
<script type="text/javascript" charset="utf-8">
jQuery(function($) {
});
function fnXlsLoad(){
    // $('#ajaxform').html($("[name=gcmForm]").html());
    
    $("[name=gcmForm]").submit();
}
function sendGcm(){
    $("[name=gcmForm]").ajaxSubmit({
        url: '/dev/sendGcmMessage'
       ,dataType: 'json'
       ,success: function(){
           alert("전송되었습니다.");
       }
       ,error: function(data) {
           alert('ajaxFail');
       }
    });
}
</script>
</head>
<body>
<div id="contents">
<div id="contents-area">
<h3>GCM 알림관리</h3>
<h4>GCM 알림</h4>
<div class="form-type">
    <form action="/dev/listUserDevice" method="post" name="gcmForm">
        <table class="table">
            <colgroup>
                <col width="120px"/>
                <col width="*"/>
                <col width="160px"/>
                <col width="250px"/>
            </colgroup>
            <tr>
                <th scope="row">메시지구분</th>
                <td>
                    <select name="gcmGbn">
                        <option value="C1341">쇼핑혜택 알림</option>
                        <option value="C1342">사인회 알림</option>
                    </select>
                </td>
                <th scope="row" rowspan="5">대상자선택</th>
                <td rowspan="5">
                    <label><input type="radio" value="A" checked="checked"/>전체</label>
                    <label><input type="radio" value="S"/>대상선택</label>
                    <div id="lyUpload">
                        <input type="text" name="userId" value=""/>
<!--                         <input type="file" name="uploadExcel" size="50"/>
                        <span class="button"><a href="#" onclick="fnXlsLoad();return false;">엑셀업로드</a></span> -->
                    </div>
                </td>
            </tr>
            <tr>
                <th scope="row">메시지제목</th>
                <td><input type="text" name="gcmTitle"/></td>
            </tr>
            <tr>
                <th scope="row">링크경로</th>
                <td><input type="text" name="linkUrl"/></td>
            </tr>
            <tr>
                <th scope="row">이미지경로</th>
                <td><input type="text" name="imgUrl"/></td>
            </tr>
            <tr>
                <th scope="row">메시지내용</th>
                <td><textarea name="gcmMessage"></textarea></td>
            </tr>
        </table>
        <div class="form-button">
            <span class="button"><input type="button" value="등록" onclick="sendGcm()"/></span>
        </div><!-- end write-button -->
    </form>
</div>
</div><!-- end contents-area -->
</div><!-- end contents -->
</body>
</html>