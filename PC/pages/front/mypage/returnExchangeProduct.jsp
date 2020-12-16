<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=950">
<title>반품/교환 상품조회</title>

<link rel="stylesheet" type="text/css" href="/css/common.css" />
<link rel="stylesheet" type="text/css" href="/css/layout.css" />
<link rel="stylesheet" type="text/css" href="/css/contents.css" />
<link rel="stylesheet" type="text/css" href="/css/shop.css" />

<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/js/contents.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/common"></script>
<%--
121008000301
20121010
20121012
--%>
<script type="text/javascript" charset="utf-8">
jQuery(function($){
    //select 활성화 체크박스 클릭했을때
    $("input[name=orderPrdtInseqs]").change(function(){
        $(this).parents("tr").find("select[name=orderCount]").attr("disabled", !$(this).is(":checked"));
    });
    
    // checkbox 활성화 라디오버튼 클릭했을때
    $("input[name=orderNum]").change(function() {
        $("input[name=orderPrdtInseqs]").attr("checked", false);
        $("input[name=orderPrdtInseqs]").attr("disabled", true);
        $("select[name=orderCount]").attr("disabled", true);
        
        var orderNumKey = $(this).prev().val();
        $(".chk"+ orderNumKey).find("input[name=orderPrdtInseqs]").attr("disabled", false);
        $(".chk"+ orderNumKey).find("select[name=orderCount]").attr("disabled", true);
    });
    
    $("#submitFrm").click(function(){
        if($("input[name=orderPrdtInseqs]:checked").length != 0) {
            $("input[name=orderPrdtInseqs]:checked").each(function (){
                var orderPrdtInseq = $(this).val();
                var orderCount = $(this).parents("tr:eq(0)").find("select[name=orderCount]").val();
                orderPrdtInseq += "_" + orderCount;
                $(this).val(orderPrdtInseq);
            });
        }
        
        $("#returnExchangeForm").ajaxSubmit({
            url:'/ht/mypage/ajaxGetReturnExchangeProduct'
            ,dataType:'json'
            ,success:function(data){
                if(data.success){
                    parent.opener.setReturnExchangeProducts(data);
                    window.close();
                }else{
                    var errorMessages = data.errorMessages;
                    var errorStr="";
                    for(i=0; i<errorMessages.length; i++) {
                        errorStr += errorMessages[i] + "\n";
                    }
                    alert(errorStr);
                }
            }
            ,error:function(data){
                alert("<fmt:message key='error.common.system'/>");
            }
        });
    });
});
</script>
</head>
<body class="popup" style="width:600px;">
<h1><img src="${imageServer}/images/renewal/common/tit_pop_return_exchange_product.gif" alt="반품/교환 상품조회" /></h1>
<div class="pop_cont" style="height:320px;overflow-y:scroll;">
    <p class="tbl_desc">반품/교환 신청은 발송완료일로부터 7일 이내에 가능합니다. 반품/교환을 원하시는 상품 및 수량을 선택하세요.</p>
    <form name="returnExchangeForm" id="returnExchangeForm">
        <table class="table02 t_center">
            <caption>반품/교환 상품조회 <span>선택, 상품명, 가격, 신청수량</span>
            </caption>
            <colgroup>
                <col style="width:60px" />
                <col style="width:*" />
                <col style="width:80px" />
                <col style="width:80px" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col" class="fir">선택</th>
                    <th scope="col">상품명</th>
                    <th scope="col">가격</th>
                    <th scope="col" class="last">신청수량</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty list}" ><tr><td colspan="4" class="no_data">반품/교환신청 가능한 내역이 없습니다.</td></tr></c:if>
                <c:forEach items="${list}" var="l" varStatus="st">
                    <tr style="background-color:#FAFAFA;">
                        <td>
                            <input type="hidden" name="orderNumKey" value="${l.orderNum}${st.count}"/>
                            <input type="radio" name="orderNum" class="radios orderNum" value="${l.orderNum}"/>
                        </td>
                        <td colspan="3" class="t_left">주문번호 : ${l.orderNum} (${l.vndrName})</td>
                    </tr>
                    <c:forEach items="${l.deliveryProducts}" var="sl" varStatus="sst">
                        <tr class="chk${l.orderNum}${st.count}">
                            <td>
                                <input type="checkbox" name="orderPrdtInseqs" class="radios" value="${sl.orderPrdtInseq}" disabled="disabled"/>
                            </td>
                            <td class="t_left">${sl.prdtName} <c:if test="${not empty sl.specName}" ><span class="point02">(${sl.specName})</span></c:if></td>
                            <td class="t_right"><fmt:formatNumber value="${sl.snglPrdtSellPrice}" pattern="#,###"/>원</td>
                            <td>
                                <select name="orderCount" style="width:54px;" disabled="disabled">
                                    <c:forEach var ="i" begin="1" end="${sl.rtnPossibleCount}">
                                        <option>${i}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                    </c:forEach>
                </c:forEach>
            </tbody>
        </table>
        <div class="btn_area t_center mgt30">
            <a href="javascript://" class="btn_type01" id="submitFrm" style="width:51px">저장</a>
            <a href="javascript://" class="btn_type05" onclick="self.close()" style="width:51px">취소</a>
        </div>
    </form>
</div>
<div class="pop_close">
    <a href="javascript://" onclick="self.close()">닫기</a>
</div>
</body>
</html>