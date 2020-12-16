<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="popup"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>팝업</title>
<link rel="stylesheet" type="text/css" href="/css/contents.css"/>
<script type="text/javascript" src="/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/js/jquery.tools.min.js"></script>
<script type="text/javascript">
var initBody;
function beforePrint(){
     initBody = document.body.innerHTML;
     document.body.innerHTML = printArea.innerHTML;
}
function afterPrint(){
     document.body.innerHTML = initBody;
}

function pageprint(){
     window.onbeforeprint = beforePrint;
     window.onafterprint = afterPrint;
     window.print();
}
</script>
</head>
<body>
<div id="printArea">
    <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/event/officecoupon2.jpg" width="620px"/>
</div>
<div id="printButton" style="position:relative;top:10px;">
    <center>
    <img src="/images/event/coupon_print.jpg"
         width="200px"
         onclick="pageprint();"
         style="cursor:pointer;cursor:hand"/>
    </center>
</div>
</body>
</html> 