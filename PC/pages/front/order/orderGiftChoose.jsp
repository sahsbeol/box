<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>장바구니 사은품 증정</title> 
<script type="text/javascript">
var sslHost = "${sslHost}";
function goOrder() {
	var seqArr = [];
	var fgiftSeqArr = [];
	var fgiftTitleArr = [];
	
	// 유효성 체크
	$("div.typeI_list").each(function(){
		var seq = $(this).find("input[type=radio]:checked").attr("seq");
		var fgiftTitle = $(this).find("input[type=radio]:checked").attr("title");
		var fgiftSeq = $(this).find("input[type=radio]:checked").val();
		
		seq = (typeof seq == 'undefined') ? ' ' : seq ;
		fgiftSeq = (typeof fgiftSeq == 'undefined') ? ' ' : fgiftSeq ;
		fgiftTitle = (typeof fgiftTitle == 'undefined') ? ' ' : fgiftTitle ;
		
	    seqArr.push(seq);
	    fgiftSeqArr.push(fgiftSeq);
	    fgiftTitleArr.push(fgiftTitle);
	})
    $.ajax({
        type: "POST"
        ,url: "/ht/order/addGiftProduct"
        ,data: {
        	fgiftMasterSeq : seqArr.join(",")
        	, fgiftSeq : fgiftSeqArr.join(",")
        	, fgiftTitle : fgiftTitleArr.join(",")
        }
        ,dataType: "json"
        ,success : function(data){
            if (data) {
                if(data.save) {
                    window.location.href = sslHost + "/ht/order/orderSheet";
                } else {
                    var errorMessages = data.errorMessages;
                    alert(errorMessages.join("\n"));
                }
            }
        }
        ,error: function(data) {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}
</script>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_my_hottracks.gif" alt="My Hottracks"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>MY HOTTRACKS</em></div>
</div>
<!-- //sub top -->

<div class="cart_top mgt50">
    <div class="cart_step">
        <ol class="step01">
            <li>1.장바구니 - 현재진행단계</li>
            <li>2.주문결제</li>
            <li>3.주문완료</li>
        </ol>
    </div>
    <c:if test="${isLogin}">
        <div class="my_info">
            <div class="txt">
                <p>
                    <span class="name">${loginUser.name}</span>님은 <c:if test="${userProperty.gradeId == '99'}">[구매한도:<strong class="f_arial"><fmt:formatNumber pattern="#,###" value="${userProperty.limitAmt}"/></strong>원]</c:if>
                    <br />
                    <strong class="point02">[<ui:userGrade gradeId="${userProperty.gradeId}"/>]</strong>등급입니다.
                </p>
                <a href="javascript://" onclick="goModifyMemInfo()" class="btn_type01">회원정보수정</a>
            </div>
            <table>
                <caption>나의 등급 정보<span>통합포인트, 마일리지, 교보핫트랙스 온라인예치금, 쿠폰</span></caption>
                <thead>
                    <tr>
                        <th scope="col" class="first">통합포인트</th>
                        <th scope="col">마일리지</th>
                        <th scope="col">교보핫트랙스 온라인예치금</th>
                        <th scope="col" class="last">쿠폰</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="first"><strong><fmt:formatNumber pattern="#,###" value="${userProperty.totPoint}"/></strong>원</td>
                        <td><strong><fmt:formatNumber pattern="#,###" value="${userProperty.mileage}"/></strong>원</td>
                        <td><strong><fmt:formatNumber pattern="#,###" value="${userProperty.deposit}"/></strong>원</td>
                        <td class="last"><strong>${userProperty.usableCouponCount}</strong>장</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </c:if>
</div>

<h2 class="hidden_obj">사은품 선택</h2>
<div class="box_gray03 pd14 mgt10">
    <ul class="list_type02">
        <li>현재 진행 중인 사은품 이벤트 입니다. 아래 항목 중 원하시는 사은품을 선택해 주시기 바랍니다.</li>
        <li>음반/DVD의 부록, 포스터(케이스) 또는 선택형이 아닌 사은품은 주문 시 자동으로 지급됩니다.</li>
    </ul>
</div>

<c:set var="seq" value="-1" />
<c:forEach items="${giftList}" var="l" varStatus="s" >
    <c:if test="${seq ne l.fgiftMasterSeq && !s.first}">
                <li class="t_right pd5" style="width:200px;display:inline-block;">
                    <p class="t_center pd5"><input type="radio" value="none" seq="${seq }" name="sellPrdtBcode${seq }"/></p>
                    <p class="t_center"><img src="${imageServer}/images/order/img_noselect.gif" alt="noSelect" /></p>
                    <p class="t_center pd5 txt_line1">사은품 받지 않음</p>
                </li>
            </ul>
        </div>
    </c:if>
    <c:if test="${seq ne l.fgiftMasterSeq}">
        <div class="pd5 mgt30 typeI_list" style="padding:10px 0; border-bottom:1px solid #DADADA;">
            <h3 class="tit">${l.title } <span class="f_right mgr5">증정기간 : <ui:mask pattern = "####-##-##">${l.prsntStartDay }</ui:mask> ~ <c:if test="${l.prsntLimitYn  eq 'N'}"><ui:mask pattern = "####-##-##">${l.prsntEndDay }</ui:mask></c:if></span></h3>
            <ul style="padding:10px 0;margin-top:5px; border-top:1px solid #DADADA;">
    </c:if>
    <li class="t_right pd5" style="width:200px;display:inline-block;">
        <p class="t_center pd5"><input type="radio" value="${l.fgiftSeq }" seq="${l.fgiftMasterSeq }" name="sellPrdtBcode${l.fgiftMasterSeq }" title="${l.fgiftTitle }" /></p>
        <p class="t_center"><img src="<ui:variable key="image.server.host,image.upload.uri" prepare="http://" postfix='/'/>${l.imgUrl}" alt="${l.fgiftTitle }" style="width:120px;height:120px;"/></p>
        <p class="t_center pd5 txt_line1">${l.fgiftTitle }</p>  
    </li>
    <c:set var="seq" value="${l.fgiftMasterSeq}" />
</c:forEach>
        <li class="t_right pd5" style="width:200px;display:inline-block;">
            <p class="t_center pd5"><input type="radio" value="none" seq="${seq }" name="sellPrdtBcode${seq }"/></p>
            <p class="t_center"><img src="${imageServer}/images/order/img_noselect.gif" alt="noSelect" /></p>
            <p class="t_center pd5 txt_line1">사은품 받지 않음</p>
        </li>
    </ul>
</div>
<div class="btn_area t_center mgt50 c_both">
    <a href="/ht/order/cart" class="btn_type04">이전으로</a>
    <a href="javascript://" onclick="goOrder()" class="btn_type03">주문하기</a>
</div>
</body>
</html>