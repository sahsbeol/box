<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<c:set var="imgurl" value="http://info.hottracks.co.kr/${detail.imgurl}"/>
<c:if test="${c.bbsRegType eq 'M'}">
    <c:forEach items="${listImg}" var="img" end="0">
        <c:set var="imgurl" value="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${img}"/>
    </c:forEach>
</c:if>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=2.0">
<title>${detail.title} - HOTTRACKS</title>
<link rel="image_src" href="${imgurl}" />
<img src="${imgurl}" class="kakao-img" style="display:none;"/>
<script type="text/javascript" src="/js/jquery.rwdImageMaps.min.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<style type="text/css">
#btn_gotolist { display:block;margin:30px 0 15px;text-align:center; }
#btn_gotolist a { display:block;width:120px;height:30px;line-height:30px;font-size:15px;font-weight:bold;border:1px solid #dadada;border-radius:10px;margin:0 auto;color:#777;background-color:#f1f2f3; }
p.bbsUltiTheme{ font-size: 1.2em; font-weight: bold; padding-top : 10px; padding-bottom : 10px; margin-bottom : 10px; border-top: 1px solid #d9d9d9;border-bottom: 1px solid #d9d9d9; }
p.bbsContents{ font-size: 1.2em; margin-bottom : 10px; }
p.bbsContDtl{ font-size: 1.2em; margin-bottom : 4px;}
</style>
<script type="text/javascript">
jQuery(function($){
$(document).ready(function(){
    $("#wrap").addClass("mypage02");
    $("#locStore1").addClass("active");
});
});
</script>
<c:if test="${c.bbsRegType ne 'M'}">
<script type="text/javascript">
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
    , error : function(){
        alert("error");
        
    }
});
</script>
</c:if>
</head>
<body>
<div class="w_top event_sub_info">
    <c:choose>
        <c:when test="${detail.enddate eq '20180101' && c.bbsType eq 'M'}">
            <p>(<ui:mask pattern="####.##.##">${detail.startdate}</ui:mask> ~ 재고소진시까지)</p>
        </c:when>
        <c:otherwise>
            <p>(<ui:mask pattern="####.##.##">${detail.startdate}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.enddate}</ui:mask>)</p>
        </c:otherwise>
    </c:choose>
    <div class="sns">
        <a href="javascript:goTwitter('${detail.title}', 'http://m.hottracks.co.kr/m/help/storeBoard?bbsRegType=${c.bbsRegType}&boardseq=${detail.boardseq}&rdpCode=${param.rdpCode}')" class="ic_twitter">트위터</a>
        <a href="javascript:goFaceBook('${detail.title}', 'http://m.hottracks.co.kr/m/help/storeBoard?bbsRegType=${c.bbsRegType}&boardseq=${detail.boardseq}&rdpCode=${param.rdpCode}')" class="ic_facebook">페이스북</a>
        <a href="javascript:sendKakao('[핫트랙스] ${detail.title}', 'http://m.hottracks.co.kr/m/help/storeBoard?bbsRegType=${c.bbsRegType}&boardseq=${detail.boardseq}&rdpCode=${param.rdpCode}')" class="ic_kakaotalk">카카오톡</a>
    </div>
</div>
<h2>${detail.title}</h2>
<div class="event_info mt30">
    <div class="event_cont cust" id="detail_cont">
        <c:if test="${c.bbsRegType eq 'M'}">
            <c:forEach items="${listImg}" var="imgurl">
                <ui:image src="${imgurl}"/>
            </c:forEach>
            <c:if test="${not empty detail.bbsUltiTheme}"><p class="bbsUltiTheme"><ui:br>${detail.bbsUltiTheme}</ui:br></p></c:if>
            <c:if test="${not empty detail.contents}"><p class="bbsContents"><ui:br>${detail.contents}</ui:br></p></c:if>
            <c:if test="${not empty detail.bbsContDtl}"><p class="bbsContDtl"><ui:br>${detail.bbsContDtl}</ui:br></p></c:if>
        </c:if>
    </div>
    <div id="btn_gotolist">
        <c:choose>
            <c:when test="${not empty param.rdpCode}">
                <a href="#" onclick="location.replace('/m/help/store/${param.rdpCode}');return false;">목록보기</a>
            </c:when>
            <c:otherwise>
                <a href="#" onclick="location.replacE('/m/help/listStore');return false;">목록보기</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
