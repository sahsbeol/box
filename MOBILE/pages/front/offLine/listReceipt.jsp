<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<title>영업점영수증 | 혜택관리 | MY HOTTRACKS - HOTTRACKS</title>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/js/jquery-barcode.min.js"></script>
<style type="text/css">
.col_orange{font-size : 1.5em;}
.col_blue {color :#2a498c;}
table { width : 100%;height: auto; }
table th, tr{ text-align: center; height : auto; }
table td{ padding : 8px 20px;  background-color: #eeeeee;border: 1px solid #ccc; }
table td.tranType {border-right:1px solid white; background-color: white;}
table td.saleAmtH {background-color: white; }
table td.saleAmtH a.col_orange, table td.saleAmtH a.col_blue{float: right; font-weight:bold; font-size: 1em;}
table td.saleDate, .storeName { font-size: 1.2em; font-weight: bold;}
table td.saleDate:first-child {border : 2px solid;}

.my_smenu_ment{color :#ff6600; font-weight: bold;text-align: center; width: 100%; padding: 20px 0 10px; color: #696969; font-size: 1.2em;}
#receiptTable .col_orange { font-size : 1em;}
#my_content .my_comment { border: 1px solid #eee; border-radius: 2px; margin: 10px 0; padding: 10px; font-size: 1em; letter-spacing: -1px; text-align: center;}
select[name=year],select[name=month],select[name=company]{ width: 33%; background:#eee url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/mobile/common/bg_select_gray.jpg) no-repeat 93% 50%; border: 1px solid #ccc; text-align-last: center; float: left; margin: 20px 0;padding-left: 13px; height : 35px;}

div.receipt_back { text-align: center; position: fixed; left: 0; top: 0; width: 100%; height: 100%;background: url(/images/season01/bg_layer02.png); z-index: 999;}
div.receipt_back div.receipt_inner { border-radius: 10px; height:calc(100% - 116px); margin: 0 auto;width:calc(100% - 80px);max-width:323px;min-width:250px;top: 38px;  text-align: center; position: relative; display:block; padding:20px 15px;background-color: #fff; }
div.receipt_back div.receipt_inner a.btn_cls{ position: absolute; top: -27px; right: 5px; display: block; background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/btn_close04.png) no-repeat 50% 50%; background-size: 25px;  text-overflow: ellipsis; text-indent: -999px; text-align: left; width: 20px; height: 20px;}
div.receipt_back div.receipt_inner div#barcode_layer { padding:0; width:165px; margin:10px auto;height:80px; }
div.receipt_back div.receipt_inner div#barcode_click_layer { display:block;height:35px;margin:15px auto 25px;}
div.receipt_back div.receipt_inner div#getOneReceipt { display:block;height:calc(100% - 103px);overflow: scroll;text-align:left;font-size:10px;font-family:Dotum; }

@media only screen and (min-width : 341px) {
    div.receipt_back div.receipt_inner div#getOneReceipt { font-size: 10.5px; } 
}
@media only screen and (min-width : 353px) {
    div.receipt_back div.receipt_inner div#getOneReceipt { font-size: 11px; } 
}
@media only screen and (min-width : 365px) {
    div.receipt_back div.receipt_inner div#getOneReceipt { font-size: 11.5px; } 
}
@media only screen and (min-width : 378px) {
    div.receipt_back div.receipt_inner div#getOneReceipt { font-size: 12px; } 
}
@media only screen and (min-width : 390px) {
    div.receipt_back div.receipt_inner div#getOneReceipt { font-size: 12.5px; } 
}
@media only screen and (min-width : 403px) {
    div.receipt_back div.receipt_inner div#getOneReceipt { font-size: 13px; } 
} 

div.receipt_back div.receipt_inner div#getOneReceipt pre{ font-size: 12px; text-align: left;width : 100%; margin: auto;}
div.receipt_back div.btn_white_l { position: absolute; top: -19px; right: -18px; display: block; background: url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/btn_close04.png) no-repeat 50% 50%; background-size: 25px; text-overflow: ellipsis; text-indent: -999px; text-align: left; width: 20px; height: 20px;}
div.receipt_back > .paging.receipt {margin-top:20px; padding:0 15px;text-align:center; }
div.receipt_back > .paging.receipt > a { display:inline-block; width:34px;height:32px;overflow:hidden; line-height:99px;}
div.receipt_back > .paging.receipt .prev { margin-right:2px;background:url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/common/8_left_bt.png) no-repeat;background-size:100% auto; }
div.receipt_back > .paging.receipt .next { margin-left:2px;background:url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/common/8_right_bt.png) no-repeat;background-size:100% auto; }
div.receipt_back > .paging.receipt ul { display:inline; }
div.receipt_back > .paging.receipt ul li { display:inline;margin:0 1px; border : 0; }
div.receipt_back > .paging.receipt ul li a { border: 0; width:32px;height:30px;text-align:center;font-size:14px;font-weight:bold;color:#c3c3c3;line-height:30px;}
div.receipt_back > .paging.receipt ul li a.active {color:#424242;}

#my_content .my_smenu2 a.my_info.active {border-top-right-radius: 0px;border-bottom-right-radius: 0px;}
</style>

<script type="text/javascript">
var page = '${page}';
var year = '${yr}';
var month = '${mm}';
var company = 'A';
function dateToYYYYMMDD(date){
    return date.substr(0,4) + "." +date.substr(4,2) + "."+date.substr(6,2); 
}
function goPage(page, date){
    getReceiptList(page);
}
function setPage(page, totPage, date){
    $("div.paging").find("ul").empty();
    
    for(var a=0; a<totPage/5; a++){
        var active = "";
        if(a+1 == page)
            active = "class='active'";
        $("div.paging").find("ul").append("<li><a href='javascript://' onclick='goPage("+(a+1)+","+ date +")'"+active+">"+(a+1)+"</a></li>");
    }
}

function getReceiptList(page){
    year = $("select[name='year'] option:selected").val();
    month = $("select[name='month'] option:selected").val();
    company = $("select[name='company'] option:selected").val();
    page = parseInt(page);
    
    $("#receiptTable").empty();
    $(".my_smenu_ment").empty();
    
    $("#loading").show();
    
    $.ajax({
        url:"http://mplus.hottracks.co.kr/json/getReceiptList?userId=${userNum}&date="+year + month+"&gbn="+company, 
        dataType: "jsonp",
        type : "POST",
        jsonp : "callback",
        crossDomain: true,
        success: function(data, textStatus, jqXHR ){
            setPage(page, data[0].resultCnt, year + month);
            if(data[0].resultCnt == 0 ){
                $(".my_smenu_ment").append("총 <span class='col_orange'> 0 건</span>이 있습니다.");
                $("#receiptTable").append("<tr><td colspan=\"4\">내역이 없습니다.</td></tr>");
            }else{  
                $(".my_smenu_ment").append("총 <span class='col_orange'>"+data[0].resultCnt+" 건</span>이 있습니다.");
                var end=0;
                if( data[0].resultCnt <(page-1)*5+5 )
                    end = data[0].resultCnt;
                else end = (page-1)*5+5;
                
                for(var i=(page-1)*5+1; i <= end; i++ ){
                   
                    $("table #receiptTable").append("<tr>");
                    var date = data[i].saleDate;
                    var dd = date.substr(0,4) + "." +date.substr(4,2) + "."+date.substr(6,2);
                    var storeN = data[i].storeName;
                    var saleAmt= "0";
                    var tran = "";
                    if(data[i].saleAmtH != "0"){
                        storeN =  "<span class=\"col_orange\" style='margin-left : 15px;'> 핫트랙스 " + storeN +"</span>";
                        saleAmt = data[i].saleAmtH;
                    }else if(data[i].saleAmtM != "0"){
                    	storeN =  "<span class=\"col_blue\" style='margin-left : 15px;'> 교보문고 " + storeN +"</span>";
                        saleAmt = data[i].saleAmtM;
                    }
                    if(data[i].tranType == "구매")
                        tran ="결제금액";
                    else{
                        tran= data[i].tranType;
                        saleAmt = -saleAmt;
                    }

                    $("table #receiptTable").append("<td colspan='2' class=\'saleDate\''><a href=\'javascript://\' onclick=\'getReceipt(\""+data[i].saleDate+"\",\""+data[i].storeCD+"\",\""+data[i].posNo+"\",\""+data[i].tranNo+"\");return false;\'>"+ dd  + storeN +"</span></a></td>");
                    $("table #receiptTable").append("</tr>");
                    $("table #receiptTable").append("<tr>");
                    $("table #receiptTable").append("<td class='tranType'><a href=\'javascript://\' onclick=\'getReceipt(\""+data[i].saleDate+"\",\""+data[i].storeCD+"\",\""+data[i].posNo+"\",\""+data[i].tranNo+"\");return false;\'>"+tran+"</a></td>");
                    
                    if(data[i].saleAmtH != "0"){
                        $("table #receiptTable").append("<td class=\'saleAmtH\'><a href=\'javascript://\' class=\'col_orange\' onclick=\'getReceipt(\""+data[i].saleDate+"\",\""+data[i].storeCD+"\",\""+data[i].posNo+"\",\""+data[i].tranNo+"\");return false;\'>"+price_format(saleAmt) +" 원</a></td>");
                    } if(data[i].saleAmtM != "0"){
                    	$("table #receiptTable").append("<td class=\'saleAmtH\'><a href=\'javascript://\' class=\'col_blue\' onclick=\'getReceipt(\""+data[i].saleDate+"\",\""+data[i].storeCD+"\",\""+data[i].posNo+"\",\""+data[i].tranNo+"\");return false;\'>"+price_format(saleAmt) +" 원</a></td>");
                    }
                    $("table #receiptTable").append("<input type=\'hidden\' class=\'posNo\' value="+data[i].posNo+" />");
                    $("table #receiptTable").append("<input type=\'hidden\' class=\'storeCD\' value="+data[i].storeCD+" />");
                    $("table #receiptTable").append("<input type=\'hidden\' class=\'tranNo\' value="+data[i].tranNo+" />");
                    $("table #receiptTable").append("</tr>");
                }
            } 
            $("#loading").hide();
        },
        error : function(data){alert('서비스 점검 중 입니다.');$("#loading").hide();}
    });
}

jQuery(function($){
        $("#wrap").addClass("mypage01");
        $("#locGift").addClass("active");
        $(".conts").hide();
        
        $("#receiptTable").empty();
        $(".my_smenu_ment").empty();
        $(".receipt_back").hide();
        
         getReceiptList(1);
});
// 닫기 버튼
function closeBtn(){
    $(".receipt_back").hide();
    $(".mini.mypage01 #header div.snb01").show();
    $("#header div.head").show();
    return false;
}
// 영수증 보여주기
function getReceipt(saleDate, storeCD, posNo, tranNo){
    $.ajax({
        url : "http://mplus.hottracks.co.kr/json/getReceipt?saleDate="+saleDate+"&storeCD="+storeCD+"&posNo="+posNo+"&tranNo="+tranNo,
        dataType: "jsonp",
        jsonp : "callback",
        success: function(data) {
            var result = data.receipt;
            var temp = result.indexOf("BMP");
            result = result.substring(temp+5);
            
            var cut = new Array(/\[BMP\]/gi,/\[LIN\]/gi, /\[NOR\]/gi, /\[VB\]/gi, /\[CT\]/gi, /\[U\]/gi, /\[A\]/gi, /\[NOR\]/gi, /\[CNT\]/gi, /\[VBL\]/gi,/\[BLD\]/gi,/\[JNL\]/gi,/\[CUT\]/gi);
            
            for(var i=0; i<cut.length; i++){
                result = result.replace(cut[i],"<br>");
            }
            
            var b = result.indexOf("BAR");
            var bar = result; 
            bar = bar.substring(b+4, b+24);
            result = result.replace(/\[BAR\]/gi, "<br>");
            result = result.split(" ").join("&nbsp;");

            $("#barcode_layer").barcode(bar, "code128");
            $("#getOneReceipt").html(result);
            $("#getOneReceipt").show();
            $(".receipt_back").show();
            $(".mini.mypage01 #header div.snb01").hide();
            $("#header div.head").hide();

        }, 
        error : function(data){
            alert('서비스 점검 중 입니다.');
        }
    });
}
</script>
</head>
<body>
<div class="gray_box">
    <hr class="hr_01"/>
    <!-- sub contents -->
    <div id="my_content">
        <div class="my_smenu4">
            <a href="/m/mypage/totsaved" class="btn_totsaved">통합포인트</a>
            <a href="/m/mypage/deposit" class="btn_deposit">예치금</a>
            <a href="/m/mypage/coupon" class="btn_coupon">쿠폰</a>
            <a href="/m/offLine/listReceipt" class="btn_recepit active">영업점영수증</a>
        </div>
        <div class="my_smenu_ment"></div>
        <div class="my_smenu2">
            <a href="#" class="my_info active" onclick="location.href='${defaultHost}/m/offLine/listReceipt';return false;"><span>영업점 영수증</span></a>
            <a href="#" class="my_info" onclick="location.href='${defaultHost}/m/offLine/savePointByOffBill';return false;" ><span>영수증 후 적립</span></a>
        </div>
        <div class="my_smenu3">
            <select name="year" onchange="getReceiptList(1);">
                <option value="${yr }" selected="selected">${yr }년</option>
                <option value="${yr -1}">${yr-1}년</option>
                <option value="${yr -2}">${yr-2}년</option>
            </select>
            <select name="month" onchange="getReceiptList(1);">
                <option value="01" <c:if test="${mm eq '01' }"> selected="selected"</c:if>> 01월</option>
                <option value="02" <c:if test="${mm eq '02' }"> selected="selected"</c:if>> 02월</option>
                <option value="03" <c:if test="${mm eq '03' }"> selected="selected"</c:if>> 03월</option>
                <option value="04" <c:if test="${mm eq '04' }"> selected="selected"</c:if>> 04월</option>
                <option value="05" <c:if test="${mm eq '05' }"> selected="selected"</c:if>> 05월</option>
                <option value="06" <c:if test="${mm eq '06' }"> selected="selected"</c:if>> 06월</option>
                <option value="07" <c:if test="${mm eq '07' }"> selected="selected"</c:if>> 07월</option>
                <option value="08" <c:if test="${mm eq '08' }"> selected="selected"</c:if>> 08월</option>
                <option value="09" <c:if test="${mm eq '09' }"> selected="selected"</c:if>> 09월</option>
                <option value="10" <c:if test="${mm eq '10' }"> selected="selected"</c:if>> 10월</option>
                <option value="11" <c:if test="${mm eq '11' }"> selected="selected"</c:if>> 11월</option>
                <option value="12" <c:if test="${mm eq '12' }"> selected="selected"</c:if>> 12월</option>
            </select>
            <select name="company" onchange="getReceiptList(1);">
                <option value="A">전체</option>
                <option value="H">핫트랙스</option>
                <option value="K">교보문고</option>
                
            </select>
        </div>
        <table class="table" summary="스마트영수증" border="1">
            <caption>스마트 영수증 조회 결과</caption>
            <colgroup>
                <col width="*"></col>
                <col width="*"></col>
                <col width="*"></col>
                <col width="*"></col>
            </colgroup>
            <thead>
                <tr>
                </tr>
            </thead>
            <tbody id="receiptTable">
                <tr>
                </tr>
            </tbody>
        </table>
        <div class="my_comment">※ 영업점 영수증은 최근 3년까지 내역만 제공합니다. ※</div>
        <div class="receipt_back">
            <div class="receipt_inner">
                <div onclick="closeBtn();" class="btn_white_l">닫기</div>
                <div id="barcode_layer"></div>
                <div id="getOneReceipt" class="my_list"></div>
            </div>
        </div>
        <div class="paging mb30 receipt"><ul></ul></div>
    </div>
</div>
</body>
</html>