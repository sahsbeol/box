<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<script type="text/javascript" src="/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
function removeImage() {
    $("input[name=imageFile]").val("");
}

function sendButton() {
    if (confirm("저장하시겠습니까?")) {
        $("#returnExchangeForm").ajaxSubmit({
            url:'/ht/mypage/addReturnExchangeProduct'
            , dataType:'json'
            , success: function(data){
                if(data.success) {
                    alert('<fmt:message key="message.save.success"/>');
                    document.location.href='/ht/mypage/returnExchange';
                }else{
                    var errorMessages = data.errorMessages;
                    var errorStr="";
                    for(i=0; i<errorMessages.length; i++) {
                        errorStr += errorMessages[i] + "\n";
                    }
                    alert(errorStr);
                }
            }
            , error: function(data){
                alert("<fmt:message key='error.common.system'/>");
            }
        });
    }
}

function returnExchangeList(){
    document.location.href="/ht/mypage/returnExchange";
}

function setReturnExchangeProducts(data){
    var list = data.list;
    var orderNum = data.orderNum;
    setReturnExchangeProduct(list, orderNum);
}

function setReturnExchangeProduct(list, orderNum){
    var tbody = $("#productTbody");
    tbody.empty();
    
    var sendOrderNum;
    for(var i=0; i<list.length; i++) {
        product = list[i];
        countCpnYn = product.countCpnYn;
        var product = list[i];
        sendOrderNum = product.orderNum;
        var countCpnYn = product.countCpnYn;
        var price;
        if(countCpnYn != null){
            // 수량쿠폰여부 체크
            if(countCpnYn == 'Y') {
                price = (product.snglPrdtSellPrice - product.cpnDscntAmt) * product.rtnCount;
            }else {
                if(product.rtnCount == product.rtnPossibleCount) {
                    price =    (product.snglPrdtSellPrice * product.rtnCount) - product.cpnDscntAmt;    
                }
                price = product.snglPrdtSellPrice * product.rtnCount;
            }
        }else{
            price = product.snglPrdtSellPrice * product.rtnCount;
        }
        
        var tdHtmls = "<td><a href='#'>"+ orderNum +"</a><input type='hidden' name='orderProductInseq' value='"+ product.orderPrdtInseq +"' /></td>";
            tdHtmls +="<td class='t_left'>"+ product.prdtName +specName(product.specName) + "</td>";
            tdHtmls +="<td class='t_right'>"+ price_format(price) +"원</td>";
            tdHtmls +="<td>"+ product.rtnCount +"<input type='hidden' name='returnCount' value='"+ product.rtnCount +"' /></td>";
        var tr= $("<tr class='tr"+(product.sellPrdtBcode)+"'></tr>");
        $(tr).html(tdHtmls);
        $(tr).appendTo(tbody);
    }
    var divHtmls = "<input type='hidden' name='orderNum' value='"+ sendOrderNum +"' />";
    var div = $("<div class='sendOrderNumDiv'></div>");
    $(div).html(divHtmls);
    $(div).appendTo(tbody);
}

/* 
<tr>
    <td><a href="#n">140619000119</a></td>
    <td class="t_left"><a href="#n">[에이치티엠엘]HTML - U1 Ecobag(Wine)외 7건</a></td>
    <td>1,000원</td>
    <td>1</td>
</tr>
*/

function specName(specName){
    var rv="";
    if(specName == null) {
        return rv;
    }else{
        rv="<span class='point02'> (" + specName + ") </span>";
        return rv;
    }
}

function rtnExchangeSearch(){
    window.open('/ht/mypage/returnExchangeProduct', '', 'width=600,height=480');
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

<c:import url="/menu/mypage/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
<form id="returnExchangeForm" class="returnExchangeForm" name="returnExchangeForm" method="post" enctype="multipart/form-data">
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_return_exchange.gif" alt="반품/교환신청" /></h3>
    <ul class="list_type02 tit_desc">
        <li>핫트랙스 배송상품의 경우, 반품신청을 하시면 지정 택배사로 방문회수 접수를 해드립니다.</li>
        <li>업체개별 배송상품의 경우, 수령하신 택배사를 통해 해당업체로 직접 반품해주시기 바랍니다.</li>
        <li class="mgt10">교환신청은 동일상품(옵션 포함)으로의 교환만 가능하며, 재발송 상품과 하자상품과의 교환으로 진행됩니다.</li>
        <li>단, 업체개별 배송상품의 경우 교환방법이 다를 수 있으니 해당업체에 미리 확인하시기 바랍니다.</li>
    </ul>

    <h4 class="tit01">신청구분</h4>
    <div class="box_gray radio_wrap">
        <label for="division_1"><input type="radio" name="sosCounselCode" value="C0664" id="division_1" name="division" checked="checked" /> 반품</label>
        <label for="division_2"><input type="radio" name="sosCounselCode" value="C0665" id="division_2" name="division" /> 교환</label>
    </div>

    <h4 class="tit01">상품선택</h4>
    <div class="tbl_top">반품/교환 신청은 발송완료일로부터 7일 이내에 가능합니다. <a href="javascript://" class="btn_type01" onclick="rtnExchangeSearch()">반품교환상품조회</a></div>
    <table class="bbs_list01">
        <caption>상품선택 <span>주문번호, 상품, 가격, 신청수량</span></caption>
        <colgroup>
            <col style="width:126px" />
            <col style="width:*" />
            <col style="width:84px" />
            <col style="width:110px" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">주문번호</th>
                <th scope="col">상품</th>
                <th scope="col">가격</th>
                <th scope="col" class="last">신청수량</th>
            </tr>
        </thead>
        <tbody id="productTbody">
            <tr class="tr${list.sellPrdtBcode}">
                <td colspan="4" class="no_data">반품/교환 상품을  선택해 주세요.</td>
            </tr>
            <!-- 
            <tr>
                <td><a href="#n">140619000119</a></td>
                <td class="t_left"><a href="#n">[에이치티엠엘]HTML - U1 Ecobag(Wine)외 7건</a></td>
                <td>1,000원</td>
                <td>1</td>
            </tr>
            -->
        </tbody>
    </table>

    <h4 class="tit01">신청사유</h4>
    <div class="box_gray">
        <ui:select name="returnExchangeResonCode" key="P0052" title="신청사유 선택" clazz="select" style="width:120px;margin-right:30px;">신청사유 선택</ui:select>  
        빠른 확인처리를 위해 상세한 반품/교환 사유를 써주세요.
    </div>
    <div class="return_reason">
        <textarea rows="10" cols="80" title="반품/교환 사유 입력" name="counselContent"></textarea>
        <div class="img_attach_wrap">
            <span class="label">사진첨부 : (500KB이하)</span>
            <div class="img_attach">
                <input type="text" title="이미지파일" id="taeget" style="width:350px;" />
                <span class="file_wrap">
                    <input type="file" name="imageFile" class="file" value="파일선택" title="파일선택" onChange="$('#taeget').val($(this).val());" />
                </span>
                <a href="javascript://" class="btn_type01" onclick="removeImage()">삭제</a>
            </div>
        </div>
    </div>
    <div class="btn_area t_center mgt50">
        <a href="javascript://" class="btn_type03" onclick="sendButton()">신청하기</a>
        <a href="javascript://" class="btn_type04 mgl10" onclick="returnExchangeList()">목록으로</a>
    </div>

</div>
<!-- //sub contents -->
</body>
</html>