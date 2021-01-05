<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<title>${detail.title} - HOTTRACKS</title>
<link rel="image_src" href="http://info.hottracks.co.kr/${detail.imgurl}" />
<img src="http://info.hottracks.co.kr/${detail.imgurl}" class="kakao-img" style="display:none;"/>
<script type="text/javascript" src="/js/jquery.rwdImageMaps.min.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
jQuery(function($){
$(document).ready(function(){
	
	$('#subTitle').html('팬사인회');
    $("#wrap").addClass("mypage_v2");
    $("#locSign").addClass("active");
    
    $.ajax({
        type: "GET"
        , url : "/m/help/signDetailDesc?boardseq=${detail.boardseq}"
        , dataType : "json"
        , success : function(data){ 
            $("#detail_cont").html(data.detail.contents);
            if(window.HybridApp != undefined && window.HybridApp.showImage != undefined){
                $("#detail_cont").find("img").each(function(){ 
                    $(this).click(function(){
                        window.HybridApp.showImage($(this).attr("src"));
                    });
                });
            }
        }
        , error : function(error){
        }
    });

});
});
</script>
</head>
<body>
<div class="w_top event_sub_info">
    <p>(<ui:mask pattern="####.##.##">${detail.startdate}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.enddate}</ui:mask>)</p>
    <div class="sns">
        <a href="javascript:goTwitter('${detail.title}', 'http://m.hottracks.co.kr/m/help/signDetail?boardseq=${detail.boardseq}')" class="ic_twitter">트위터</a>
        <a href="javascript:goFaceBook('${detail.title}', 'http://m.hottracks.co.kr/m/help/signDetail?boardseq=${detail.boardseq}')" class="ic_facebook">페이스북</a>
        <a href="javascript:sendKakao('[핫트랙스] ${detail.title}', 'http://m.hottracks.co.kr/m/help/signDetail?boardseq=${detail.boardseq}')" class="ic_kakaotalk">카카오톡</a>
    </div>
</div>
<div class="event_info mt30">
    <div class="event_cont" id="detail_cont"></div>
</div>
</body>
</html>
