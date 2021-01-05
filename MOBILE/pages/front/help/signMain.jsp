<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<style type="text/css">
.banner_basic02 ul.mgt30{margin-left:10px; margin-right:10px; width : auto;}
.banner_basic02 ul.mgt30 li{height: 80px; margin-top:20px; width : 100%;}
.banner_basic02 ul.mgt30 a {width: 100%; float :left;}
.banner_basic02 ul.mgt30 a span{display:block;margin-left:160px;  text-align:left; width : auto;}
.banner_basic02 div.bannerIcon img{vertical-align: middle;  position: absolute; left: 125px; z-index: 999; width: 35px;}
</style>
<script type="text/javascript">
jQuery(function($){
    $('#subTitle').html('팬사인회');
    $("#wrap").addClass("mypage_v0");
    $("#locSign").addClass("active");
});

function goList(page){
    location.replace("?page="+page);
}
</script>
</head>
<body>
<div class="banner_basic02">
    <ul class="mgt30">
        <c:forEach items="${list}" var="l" varStatus="status">
            <li>
                <a href ="/m/help/signDetail?boardseq=${l.boardseq}">
                    <c:choose>
                        <c:when test="${l.prosGbn eq 'N'}"><div class="bannerIcon"><img src="http://info.hottracks.co.kr/images/story/ico_now.png" alt="NOW" class="png24" /></div></c:when>
                        <c:when test="${l.prosGbn eq 'S'}"><div class="bannerIcon"><img src="http://info.hottracks.co.kr/images/story/ico_soon.png" alt="SOON" class="png24" /></div></c:when>
                        <c:otherwise>
                        <div class="bannerIcon">
                        <img src="http://info.hottracks.co.kr/images/story/ico_end.png" alt="END" class="png24" />
                        </div></c:otherwise>
                    </c:choose>
                    <img src="http://info.hottracks.co.kr/${l.imgurl }" align="middle" style="left:10px;width:150px; height:60px; position:absolute; " />
                    <span style="font-size:15px;text-overflow:ellipsis; display:block; overflow:hidden; white-space:nowrap;"><strong>${l.title }</strong></span>
                    <span style="color:#a2a2a2;margin-top:7px;"><ui:mask pattern="####/##/##">${l.startdate}</ui:mask> ~ <ui:mask pattern="####/##/##">${l.enddate}</ui:mask></span>
                    <span style="color:#a2a2a2;margin-top:7px;">${l.deptname}</span>
                </a>
            </li>
            <hr style="border: solid 1px #E6E6E6;">
            </c:forEach>
        </ul>
    </div>
    <!-- paging -->
    <div class="paging mb30">
        <ui:paginationScript name="pageHolder" scriptName="goList"/>
    </div>
    <!-- //paging -->

</body>
</html>
