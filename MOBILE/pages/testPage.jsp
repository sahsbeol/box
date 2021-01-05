<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript" src="/js/jquery-1.9.1.min.js?201610281645"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/js/mOrder.js"></script>
<title>장바구니</title>
<script type="text/javascript">
jQuery(function($) {
    <%-- 삭제 버튼 클릭 이벤트--%>
    $(".btnDeleteCartProduct").click(function() {
        if(!confirm("삭제버튼")) {
            return;
        }
    });
    
    <%-- 선택 주문 버튼 클릭 이벤트--%>
    $(".btnGoOrderCheckCartProduct").click(function() {
        if(!confirm("주문버튼")) {
            return;
        }    	
    });
});

function aa() {
	alert("11111");
}

function bb() {
	document.getElementById("lGetPoint").innerHTML = "Click됨";
}
</script>
</head>
<body>
테스트페이지...
                <div class="btn_area btn_order">
                    <a href="javascript://" class="btn btn_gray btnDeleteCartProduct">삭제</a>
                    <a href="javascript://" class="btn btn_orange btnGoOrder">바로주문</a>
                    <a href="javascript:aa();">aaaaa</a>
                    <a href="javascript:bb();">bbbbb</a>
                </div>
                <span id="lGetPoint" name="lGetPoint">0P</span>
</body>  
</html>