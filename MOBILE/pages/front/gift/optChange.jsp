<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="shortcut icon" href="http://image.kyobobook.co.kr/newimages/apps/b2c/kyobo.ICO"/>
<link rel="apple-touch-icon" href='http://image.kyobobook.com/mimages/static/images/common/apple-touch-icon.png' class="ico_homeAdd">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta name="format-detection" content="telephone=no">
<link href="http://mobile.kyobobook.co.kr/css/m_welcome.css" rel="stylesheet">
<link href="http://mobile.kyobobook.co.kr/css/m_order.css" rel="stylesheet">
<script type="text/javascript" src="http://mobile.kyobobook.co.kr/js/jquery/jquery-1.11.3.js"></script>
<script type="text/javascript" src="http://mobile.kyobobook.co.kr/js/jquery/ui.js"></script>
<title>옵션신청 | 교보문고</title>
</head>
<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
<script language='javascript'>
document.domain = 'kyobobook.co.kr';
var optionBarcode = '2300000084863';

var cvclOptValue ='';

function openCarvedSeal(barcode) {
    window.open("/m/optCarvingService/" + barcode, "", "width=900, height=1000, scrollbars=yes");
}

function optChoice() {
	var isOrderMake = ${ext.orderMakeYn};
	
	// 옵션값 확인
	var nameValue = '';
	var keyValue = '';
	var result = true;
	var opt1 = '';
	var opt2 = '';
	var opt3 = '';  // 각인내용
	var param = '${param.param}';
	$('select.options').each(
	    function(index) {
	        if ($(this).val() == '') {
	            alert('옵션을 선택하세요.');
	            $(this).focus();
	            result = false;
	            return false;
	        } else {
	            nameValue += nameValue == '' ? $(this).attr('id') : ',' + $(this).attr('id');
	            keyValue += keyValue == '' ? $(this).val() : '-' + $(this).val();
	        }
	    }
	);

	if (result) {
	    var optionValue = 'N|2300000084863|' + nameValue + '|' + keyValue + '||';
	    opt1 = optionValue;
	}

	// 주문제작문구
	if (isOrderMake) {
	    var tmp = 'N|2300000084863||기타정보|' + $('input[name="orderMakeText"]').val() + "|";
	    opt2 = tmp;
	}

	opt3 = cvclOptValue;    // 각인내용

	if (result) {
		//alert(opt1 + "/" + opt2 + "/" + param + "/" + opt3);
	    opener.retOptChange(opt1,opt2,param,opt3);
	    self.close();
	}
}

function setCarvedSealInfo(info, carvingContents) {
    if(info.length >= 3) {
        cvclOptValue = 'Y|2300000028379|유료각인|' + info[0] + '|' + carvingContents + '|';
    }
}
</script>
<body id="windowPopup">
<div id="accessibility">
    <ul>
        <li><a accesskey="1" href="#content">본문으로 바로가기</a></li>
    </ul>
</div>

<!-- 옵션신청 -->
<div class="window_pop">
    <div class="window_inner">
        <div class="window_header">
            <h2>옵션신청</h2>
        </div>
        <div id="content" class="window_container">

            <div class="pop_section">
                <table class="table_style1 type2">
                    <caption>옵션신청</caption>
                    <tbody>
                        <tr>
                            <th>상품명</th>
                            <td>${ext.prdtName}</td>
                        </tr>
                        <tr>
                            <th>상품코드</th>
                            <td>${ext.sellPrdtBcode}</td>
                        </tr>
            <c:if test="${not empty options}">
                        <tr>
                            <th>옵션선택</th>
                            <td>
                                <c:forEach items="${options}" var="l" varStatus="st">
                                    <ui:select clazz="options" iD="${l.optnName}" name="${l.optnKey}" key="${l.optnKey}" title="${l.optnName}">${l.optnName}<fmt:message key="label.select.required"/></ui:select>
                                </c:forEach>
                            </td>
                        </tr>
            </c:if>
                        <c:if test="${ext.orderMakeYn}">
                        <tr>
                            <th>문구입력</th>
                            <td>
                                <input type="text" name="orderMakeText" class="input_style" title="문구입력" />
<!--                                 <div class="margin_top5 align_right">1/100</div> -->
                            </td>
                        </tr>
                        </c:if>
                        <c:if test="${ext.cvslYn}">
                        <tr>
                            <th>각인신청</th>
                            <td>
                                <a href="javascript://" onclick="openCarvedSeal('${ext.sellPrdtBcode}')" class="btn_white_ss">각인신청하기</a>
                            </td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <ul class="btn_group">
                <li style="width:50%;"><a href="javascript:self.close();" class="btn_white_l">취소</a></li>
                <li style="width:50%;"><a href="javascript:optChoice();" class="btn_white_l btn_blue">확인</a></li>
            </ul>

        </div>
        <button type="button" class="close_window" onclick="self.close();">팝업 닫기</button>
    </div>
</div>
</body>
</html>
