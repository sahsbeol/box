<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript" src="/js/jquery-barcode.min.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
var page = 1;
jQuery(function($){
    $(document).ready(function(){
        $("#wrap").addClass("mypage01");
        $("#LocOffLineCoupon").addClass("active");
    });
    
    $(window).scroll(function(){
        // 남은 개수가 0인경우 더이상 호출 하지 않기 위한 용도
        if($("input[name=eof]").val() == "0"){
           if(parseInt($(window).scrollTop() + $(window).height()) >= parseInt($("#footer").offset().top)){
               $("input[name=eof]").val("1");
               page++;
               fnLoadOrder();
           }
        }
    });
    
    $("#btnEditOpen").click(function(e){
        e.preventDefault();
        $("#editButton").hide(0, function(){
            $("#editForm").slideDown("slow", function(){$("input[name=cpnId]").select();});
        });
    });
    
    $("#btnEditClose").click(function(e){
        e.preventDefault();
        $("#editForm").slideUp("slow", function(){
            $("#editButton").slideDown();
        });
    });
    
    $("#btnEditReg").click(function(e){
        e.preventDefault();
        
        var cpnId = $("input[name=cpnId]");
        cpnId.val($.trim(cpnId.val()));
        if($.trim(cpnId.val()) == ""){
            alert("쿠폰번호를 입력해주세요");
            cpnId.focus();
        }else{
            $.ajax({
                type: "GET"
                ,url: "/m/getCouponDown"
                ,async: false
                ,data: 'couponId=' + cpnId.val()
                ,dataType: "json"
                ,success: function(data) {
                    if (data.save) {
                        alert("쿠폰이 다운로드 되었습니다.");
                        location.reload();
                    } else {
                        alert(data.errorMessage);
                    }
                }
                ,error: function() {
                    alert('<fmt:message key="error.common.system"/>');
                }
            });
        }
    });
    
    //document.ready --> window.load
    $(window).load(function(){
        fnLoadOrder();
    });
    
});
function fnLoadOrder(){
    $.ajax({
         type: "POST"
        ,url: "/m/offLine/layerOffCouponList"
        ,data: {page : page}
        ,dataType: "html"
        ,async : false
        ,success : function(htmlStr){
            $("#orderList").append(htmlStr);
            $("input[name=eof]").val("0");
        }
        ,error: function(data) {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}
function showBarcode(cpnId,offCpnName, offUseYn){
    $(".t_c").html(offCpnName);
    $("#barcode").barcode(cpnId, "code128");
    $(".bar_hidden").val(cpnId);
    
    if(offUseYn == 'N')
        $(".ly_conts .btn_barcode").show();
    else {
        $(".ly_conts .btn_barcode").hide();
    }
        
    if($(".ly_box").hasClass("active")){
        $(".ly_box").removeClass("active");
    }else{
        $(".ly_box").addClass("active");
    }
}
function dateToYYYYMMDD(date){
    return date.substr(0,4) + "." +date.substr(4,2) + "."+date.substr(6,2); 
}
// 여러개 layer 클래스 열어주고 닫아주는 역할
function openClose(id){
    $("#header").css("z-index",1);
    for(var i=1; i<4 ; i++){
        if(id == "ly_box_off"+i){
            $(".ly_box_off"+i).addClass("active");
        }else{
            $(".ly_box_off"+i).removeClass("active");
        }
    }
}
function closeOffbarcode(id){
    for(var i=1; i<4; i++){
        if(id == 1){
            $(".ly_box_off"+i).removeClass("active");
            $("#header").css("z-index",998);
            continue;
        }else{
            if(id-1 == i){
                $(".ly_box_off"+i).addClass("active");
            }else{
                $(".ly_box_off"+i).removeClass("active");
            }
        }
    }
}
function popupBarcode(cpnId, offCpnName, offUseYn, startDt, endDt, rmrk2){
    $(".ly_box_off1 #barcode_off").barcode("${user.userNum}", "code128");
    $(".t_c_off").html(offCpnName);
    $(".t_c_off_val").val(offCpnName);
    $(".bar_hidden_off").val(cpnId);
    $(".text2").html("사용점포 : ${zalStore.stVar1}");
    $(".coupon_dt").html("유효기간 : "+ dateToYYYYMMDD(startDt)+"-" + dateToYYYYMMDD(endDt));
    
    if(offUseYn == 'N')
        $(".ly_conts_off1 .btn_barcode").show();
    else {
        $(".ly_conts_off1 .btn_barcode").hide();
    }
    openClose("ly_box_off1");
}

function completeBarcode(){
    var offCpnId = $(".bar_hidden_off").val();
    $.ajax({
        type: "POST"
       ,url: "/m/offLine/updateUseBarcode"
       ,async: false
       ,data: { offCpnId : offCpnId}
       ,dataType: "JSON"
       ,success : function(data){
            alert("사용완료 되었습니다.");
            location.reload();
       }
       ,error: function(data) {
           alert("사용되지 않았습니다.");
       }
   });
}

//영업점 쿠폰 바코드 보여주기 
function showOffbarcode(){
    // 쿠폰 바코드
    $(".ly_box_off2 .t_c_off2").html($(".t_c_off_val").val());
    var bar =  $(".bar_hidden_off").val();
    $(".ly_conts_off2 #barcode_off2").barcode(bar, "code128");
    
    openClose("ly_box_off2");
}

//카페자우 쿠폰 사용전 최종 확인
function chkUseCpn(){
    openClose("ly_box_off3");
}
function completeOffBarcode(){
    var offCpnId = $(".bar_hidden_off").val();
    $.ajax({
        type: "POST"
       ,url: "/m/offLine/completeOffBarcode"
       ,data: { offCpnId : offCpnId}
       ,async: false
       ,dataType: "JSON"
       ,success : function(data){
            if(data.result == "T"){
                alert("쿠폰 사용에 성공하였습니다.");
            }else{
                alert("쿠폰 발급에 실패했습니다.");
            }
            location.reload();
       }
       ,error: function(data) {
            alert("쿠폰을 사용하는데 에러가 발생했습니다.");
        }
       });
}
</script>
</head>
<input type="hidden" name="eof" value="1"/>
<div class="ly_box" onclick="showBarcode()">
        <div class="ly_conts">
            <p class="t_c"></p>
            <div id="barcode" style="margin:10px auto;"></div>
            <hr class="line01"/>
            <div id="btn_barcode">
                <input class="bar_hidden" type="hidden" value="">
                <span class="btn_area"><a class="btn" href="javascript://" onclick="completeBarcode();">사용</a></span><br>
                <p style="padding : 8px 0 8px;">●사용완료 버튼은 영업점 결제시, <br> 카운터에서 체크하는 버튼입니다.</p>
            </div>
        </div>
</div>
<!--  영업점 쿠폰 바코드 보여주기 전 -->
<div class="ly_box_off1">
    <div class="ly_conts_off1">
        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/15_2_close_bt.png" onclick="closeOffbarcode(1);return false;" class="close_bt"/>
        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/15_2_top.png" class="ly_cont_top"/>
        <p class="t_c_off"></p>
        <p class="coupon_dt"></p>
        <input type="hidden" class="t_c_off_val"/>
        <p class="text1">영업점 내 카페자우에서 이용하세요!</p>
        <p class="text1">※ 카페자우 오픈 및 마감시간은</p>
        <p class="text1">영업점 영업시간과 상이할수 있습니다.</p>
        <p class="text2"></p>
        <div id="btn_barcode_off">
            <input class="bar_hidden_off" type="hidden" value="">
            <span class="btn_area" onclick="showOffbarcode();"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/15_2_bt.png" /></span><br>
        </div>
        <p class="text3">회원번호</p>
        <div id="barcode_off" style="margin:10px auto;"></div>
    </div>
</div>
<!--  영업점 쿠폰 바코드 보여주기 후 -->
<div class="ly_box_off2">
    <div class="ly_conts_off2">
        <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/15_3_close_bt.png" onclick="closeOffbarcode(2);return false;"  class="close_bt" style="top:-40px;"/>
        <p class="t_c_off2"></p>
        <div id="barcode_off2" style="margin:10px auto;"></div>
        <span class="btn_area" onclick="chkUseCpn();"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/15_3_bt.png"/></span><br>
        <hr/>
        <img id="off_alm" src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/15_3_notice.png"/>
    </div>
</div>

<!--  영업점 바코드 쿠폰 -->
<div class="ly_box_off3">
    <div class="ly_conts_off3">
        <p>쿠폰을 사용하시겠습니까?</p>
        <div class="ly_option">
            <span onclick="closeOffbarcode(3);">취소</span>
            <span onclick="completeOffBarcode();">동의</span>
        </div>
    </div>
</div>
<!-- //TODO:쿠폰이미지만들자 -->
<!-- content -->
<div class="gray_box">
    <hr class="hr_01"/>
    <div id="my_content">
        <div class="my_smenu4">
            <a href="/m/mypage/totsaved" class="btn_totsaved"></a>
            <a href="/m/mypage/deposit" class="btn_deposit"></a>
            <a href="/m/mypage/coupon" class="btn_coupon active"></a>
            <a href="/m/offLine/listReceipt" class="btn_recepit"></a>
        </div>
        <div class="my_smenu_ment">
        고객님의 보유 쿠폰은 <span class="col_orange"><fmt:formatNumber type="number" value="${totalOffCouponCnt}"/></span>장 입니다.
        </div>
        <div class="my_smenu2">
            <a href="/m/mypage/coupon" class="my_info "><span>온라인 쿠폰(<span><fmt:formatNumber type="number" value="${totalCouponCnt}"/>)</span></span></a>
            <a href="/m/offLine/offLineCoupon" class="my_info active" style="float:right;"><span>영업점 쿠폰(<fmt:formatNumber type="number" value="${totalOffCouponCnt}"/>)</span></a>
        </div>
        <div class="my_list" id="orderList"></div>
    </div>
</div>
<!-- //content -->
</body>
</html>
