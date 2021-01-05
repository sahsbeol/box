<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="layer"/>
<html>
<head>
<style type="text/css">
#content {padding:0px; !important;}
#zipcodeList li:first-child {margin-top:0; border:none;}
#zipcodeList li.moreBtn {display:block;text-align:right;}
</style>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
var page = 1;
var searchMode = 'G';
jQuery(function($){
    $("form").submit(function(e){
        e.preventDefault();
        fnSearch();
    });
});
</script>
</head>
<body>
<!-- tit_section -->
<div id="ly_header" class="mt10">
    <h1>최근 배송지 주소</h1>
</div>
<!-- //tit_section -->
<!-- content -->
<div id="ly_content">
    <div class="pd5">
        <ul class="br_list f14" id="zipcodeList" style="margin:0 auto;">
            <c:forEach var="result" items="${result}" begin="0" end="4" varStatus="status">
                <li><a href="#" onclick="select_address2('${result.rcvrPostNum}', '${result.rcvrAddr}' ,'${result.rcvrDtlAddr}', '${result.rcvrTelNum}', '${result.rcvrHdphnNum}', '${result.rcvrName}');return false;">${result.rcvrName}, [${result.rcvrPostNum}] ${result.rcvrAddr} ${result.rcvrDtlAddr}, ${result.rcvrHdphnNum}</a></li>
            </c:forEach>
        </ul>
    </div>
    <a href="javascript:closeZipcode();" class="btn_cls" style="top:25px; right:15px;">닫기</a>
</div>
<!-- //content -->
</body>
</html>