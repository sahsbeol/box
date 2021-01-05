<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn"%>
<ui:decorator name="orderSheet" />
<html>
<head>
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="expires" content="wed, 04 jul 1973 16:00:00 gmt">
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">
<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/jquery.timers-1.2.js"></script>
<style type="text/css">
#content {padding:0px !important;}
.card_box {display:none;}
.card_box.active {display:block;}
.cash_box {display:none;}
.cash_box.active {display:block;}
.smile_box {display:none;}
.smile_box.active {display:block;}
.payco_box {display:none;}
.payco_box.active {display:block;}
#useCouponList {position: relative;}
.input_line {width:5%; text-align:center; padding-top:2px; color:#ccc;}
#ly_content .br_list li:first-child {border:none;}
</style>

<script type="text/javascript">

var payClickChk = '';

$('.rdo_chs label input').on('focus',function(){
    var targetLink = '#' + $(this).attr('value');
    $('.r_cont').hide();
    $(targetLink).show();
});

jQuery(function($) {
    $(document).ready(function(){
        //$('body').addClass('bg_gray');//상단 mini 모드
        
        //주문건 없을경우 처리
        if($('#orderCnt').val() == 0){
        	alert("잘못된 접근 입니다.");
        	location.href = "/m/order/cart";
        }
        
        var chkPay = $("input[name=pymntMeansCode]:checked").val();
        if (chkPay == "C011E") {
            // 네이버페이
            $(".cash_box").addClass("active");
        } else {
            $(".cash_box.active").removeClass("active");
        }
        
        // 자동완성 전체끄기
        $("input[type=text]").attr("autocomplete", "off");
        
        // 주문상품 열기
		$(".box_slidelist .btn_tit").click(function(e) {
			e.preventDefault();
			var item = $($(this).attr("href"));
			if (item.hasClass("active")) {
				item.removeClass("active");
				item.find(".roundbox").slideUp();
			} else {
				item.addClass("active");
				item.find(".roundbox").slideDown();
			}
		});
    });
    
    <%-- 결제수단 선택 이벤트 --%>
    $(".btnpay").click(function() {
        var chkPay = $("input[name=pymntMeansCode]:checked").val();
        if (chkPay == "C011E") {
        	// 네이버페이
        	$(".card_box.active").removeClass("active");
            $(".cash_box").addClass("active");
            $(".smile_box.active").removeClass("active");
            $(".payco_box.active").removeClass("active");
        } else if (chkPay == "C011I") {
        	$(".card_box.active").removeClass("active");
        	$(".cash_box.active").removeClass("active");
        	$(".smile_box").addClass("active");
        	$(".payco_box.active").removeClass("active");
        } else if (chkPay == "C011J") {
        	$(".card_box").addClass("active");
            $(".cash_box.active").removeClass("active");
            $(".smile_box.active").removeClass("active");
            $(".payco_box.active").removeClass("active");
        } else if (chkPay == "C011N") {
        	$(".card_box.active").removeClass("active");
            $(".cash_box.active").removeClass("active");
            $(".smile_box.active").removeClass("active");
            $(".payco_box").addClass("active");
        } else {
        	$(".card_box.active").removeClass("active");
            $(".cash_box.active").removeClass("active");
            $(".smile_box.active").removeClass("active");
            $(".payco_box.active").removeClass("active");
        }
    });
    
    $('.chk_agree').click(function (){
        if ($(this).find('input[name=agreeCheck]').attr('checked')){
        	$(this).find('input[name=agreeCheck]').removeAttr('checked');
            $(this).removeClass('active');
        } else {
            $(this).find('input[name=agreeCheck]').attr('checked',true);
            $(this).addClass('active');
        }
    });

    $('.chk_gsSave').click(function (){
        if ($(this).find('input[name=gsSaveCheck]').attr('checked')){
            $(this).find('input[name=gsSaveCheck]').removeAttr('checked');
            $(this).removeClass('active');
        } else {
            $(this).find('input[name=gsSaveCheck]').attr('checked',true);
            $(this).addClass('active');
        }
    });
    
    
    <%-- 통합포인트 입력시 사용가능한 통합포인트 이상만 입력 가능하도록... --%>
    $("form#orderSheetForm input[name=totmileage]").blur(function(){
        var usableTotMileage = Number($("form#orderSheetForm input[name=userTotPoint]").val());
        var inputTotMileage = Number(isEmpty($(this).val())? 0 : $(this).val());
        
        var orderAmt = calculateOrderAmtExceptDiscountMethod("totmileage");
        
        if(inputTotMileage > 0) {
            usableTotMileage = Math.floor(eval(usableTotMileage/10))*10;
            
            if(inputTotMileage % 10 != 0) {
                alert("통합포인트는 10원단위로 사용 가능합니다.");
                inputTotMileage = Math.floor(eval(inputTotMileage/10))*10;
                $(this).val(inputTotMileage);
            }
            
            if(inputTotMileage > usableTotMileage || inputTotMileage > orderAmt) {
                if(usableTotMileage > orderAmt) {
                    usableTotMileage = orderAmt;
                }
                alert("사용가능한 통합포인트는 " + price_format(usableTotMileage) + "원 입니다.");
                $(this).val(usableTotMileage);
            }
        } else {
            $(this).val(inputTotMileage);
        }
        
        calculateDiscountPrice();
        calculateOrderAmt();
    });
    
    <%-- 마일리지 입력시 사용가능한 마일리지 이상만 입력 가능하도록... --%>
    $("form#orderSheetForm input[name=mileage]").blur(function(){
        var usableMileage = Number($("form#orderSheetForm input[name=userMileage]").val());
        var inputMileage = Number(isEmpty($(this).val())? 0 : $(this).val());
        
        var orderAmt = calculateOrderAmtExceptDiscountMethod("mileage");
        
        if(inputMileage > 0) {
            usableMileage = Math.floor(eval(usableMileage/10))*10;
            
            if(inputMileage % 10 != 0) {
                alert("마일리지는 10원단위로 사용 가능합니다.");
                inputMileage = Math.floor(eval(inputMileage/10))*10;
                $(this).val(inputMileage);
            }
            
            if(inputMileage > usableMileage || inputMileage > orderAmt) {
                if(usableMileage > orderAmt) {
                    usableMileage = orderAmt;
                }
                alert("사용가능한 마일리지는 " + price_format(usableMileage) + "원 입니다.");
                $(this).val(usableMileage);
            }
        } else {
            $(this).val(inputMileage);
        }
        
        calculateDiscountPrice();
        calculateOrderAmt();
    });
    
    <%-- 예치금 입력시 사용가능한 예치금 이상만 입력 가능하도록... --%>
    $("form#orderSheetForm input[name=deposit]").blur(function(){
        var usableDeposit = Number($("form#orderSheetForm input[name=userDeposit]").val());
        var inputDeposit = Number($(this).val());
        var orderAmt = calculateOrderAmtExceptDiscountMethod("deposit");
        
        if(isEmpty(inputDeposit)) {
            $(this).val(0);
        } else if(inputDeposit > usableDeposit || inputDeposit > orderAmt) {
            if(usableDeposit > orderAmt) {
                usableDeposit = orderAmt;
            }
            alert("사용가능한 예치금은 " + price_format(usableDeposit) + "원 입니다.");
            $(this).val(usableDeposit);
        }
        
        calculateDiscountPrice();
        calculateOrderAmt();
    });
    
    <%-- 결제하기 버튼 클릭 이벤트--%>
    $("#btnPayment").click(function(){
    	
    	if (payClickChk =="CHK") {return;}
    	
    	payClickChk = "CHK";
    	

    	$("input[name=buyerName]").val($("input[name=receiverName]").val());
    	$("input[name=telephone1]").val($("input[name=receiverTelePhone1]").val());
    	$("input[name=telephone2]").val($("input[name=receiverTelePhone2]").val());
    	$("input[name=telephone3]").val($("input[name=receiverTelePhone3]").val());
    	$("input[name=handPhone1]").val($("input[name=receiverHandPhone1]").val());
    	$("input[name=handPhone2]").val($("input[name=receiverHandPhone2]").val());
    	$("input[name=handPhone3]").val($("input[name=receiverHandPhone3]").val());
    	
    	var chkPay = $("input[name=pymntMeansCode]:checked").val();
    	
    	if(fnCheckOrderFrm()){
    		var httsPartner = getCookie("LinkCookieKey");
            // 직원구매 MOBSTEP , 모바일 MOB
            if ('${userProperty.gradeId}' == '99') {
                if ("${not empty devInfo?'Y':'N'}" == "Y") {
                    $("input[name=linkTmsYn]").val('MOBASTEP');
                } else {
                    $("input[name=linkTmsYn]").val('MOBSTEP');
                }
            } else {
                if ("${not empty devInfo?'Y':'N'}" == "Y") {
                    $("input[name=linkTmsYn]").val('MOBA' + httsPartner);
                } else {
                    $("input[name=linkTmsYn]").val('MOB' + httsPartner);
                }
            }
            
            $("form#orderSheetForm input").each(function() {
                $(this).val($.trim($(this).val()));
            });
            
            
            // 파라메터 유효성 체크
            $("form#orderSheetForm").ajaxSubmit({
                url: "/m/order/checkBeforePayment"
                ,dataType: "json"
                ,success: function checkSuccess(data) {
                	
                    if (data.save) {
                        var orderNum = isEmpty(data.orderNum)? "" : data.orderNum;
                        var prdtName = isEmpty($("input[name=prdtName]:eq(0)").val())? "" : $("input[name=prdtName]:eq(0)").val(); 
                        var orderAmt =$("form#orderSheetForm").find("input[name=orderAmt]").val();
                        
                        if(orderAmt == 0) {
                            // 보조결제 수단만으로 결제
                            $("form#orderSheetForm").find("input[name=orderNum]").val(orderNum);
                            $("form#orderSheetForm").find("input[name=prdtName]").val(prdtName);
                            $("form#orderSheetForm").ajaxSubmit({
                                url: "/m/order/orderOnlySubPayment"
                                ,dataType: "json"
                                ,success: function saveSuccess(data) {
                                    if(data.save) {
                                        $("form#orderSheetForm").attr("action", "${defaultHost}/m/order/orderComplete");
                                        $("form#orderSheetForm").attr("target", "");
                                        $("form#orderSheetForm").submit();
                                    } else {
                                        var errorMessages = data.errorMessages;
                                        alert(errorMessages.join("\n"));
                                        location.href = "${defaultHost}/m/order/cart";
                                    }
                                },error: function(xhr, status, error) {
                                    alert("<fmt:message key='error.common.system'/>");
                                    location.href = "${defaultHost}/m/order/cart";
                                }
                            });
                        } else if (chkPay=="C011E") {
                        	// 네이버페이결제
                            $("form#orderSheetForm").find("input[name=orderNum]").val(orderNum);
                            $("form#orderSheetForm").find("input[name=prdtName]").val(prdtName);

                            // 결제창 띄우기
                            $("form#orderSheetForm").ajaxSubmit({
                                url: "/m/order/payNaverNPayRequest"
                                ,dataType: "json"
                                ,success: function saveSuccess(data) {
                                    location.href = "https://m.pay.naver.com/payments/" + data.nReserveId;
                                },error: function(xhr, status, error) {
                                    alert("<fmt:message key='error.common.system'/>");
                                    location.href = "${defaultHost}/m/order/cart";
                                }
                            });
                        } else if (chkPay=="C011D") {
                        	// 휴대폰 결제
                            $("form#orderSheetForm").find("input[name=orderNum]").val(orderNum);
                            $("form#orderSheetForm").find("input[name=prdtName]").val(prdtName);
                            $("form#orderSheetForm").attr("target", "");
                            $("form#orderSheetForm").attr("action", "/m/order/payMobilRequest");
                            $("form#orderSheetForm").submit();
                        } else if (chkPay=="C011I") {
                            // 스마일페이 결제
                            $("form#orderSheetForm").find("input[name=orderNum]").val(orderNum);
                            $("form#orderSheetForm").find("input[name=prdtName]").val(prdtName);
                            $("form#orderSheetForm").attr("target", "");
                            $("form#orderSheetForm").attr("action", "/m/order/payCacaoReq");
                            $("form#orderSheetForm").submit();
                        } else if (chkPay=="C011H") {
                            // 직카카오결제
                            $("form#orderSheetForm").find("input[name=orderNum]").val(orderNum);
                            $("form#orderSheetForm").find("input[name=prdtName]").val(prdtName);

                            // 결제창 띄우기
                            $("form#orderSheetForm").ajaxSubmit({
                                url: "/m/order/payDiCacaoPayRequest"
                                ,dataType: "json"
                                ,success: function saveSuccess(data) {
                                    if ("${not empty device?'Y':'N'}" == "Y") {
                                    	// 어플
                                    	location.href = data.res.nextRedirectAppUrl;    
                                    } else {
                                    	// 웹
                                    	location.href = data.res.nextRedirectMobileUrl;
                                    }
                                },error: function(xhr, status, error) {
                                    alert("<fmt:message key='error.common.system'/>");
                                    location.href = "${defaultHost}/m/order/cart";
                                }
                            });
                        } else if (chkPay=="C011J" || chkPay=="C011K" || chkPay=="C011L" || chkPay=="C011M" || chkPay=="C011N") {
                            // NICE PAY 결제
                            $("form#orderSheetForm").find("input[name=orderNum]").val(orderNum);
                            $("form#orderSheetForm").find("input[name=prdtName]").val(prdtName);
                            $("form#orderSheetForm").attr("target", "");
                            $("form#orderSheetForm").attr("action", "/m/order/payNiceRequest");
                            $("form#orderSheetForm").submit();
                        } else {
                            // 결제창 띄우기
                            $("form#orderSheetForm").find("input[name=orderNum]").val(orderNum);
                            $("form#orderSheetForm").find("input[name=prdtName]").val(prdtName);
                            $("form#orderSheetForm").attr("target", "");
                            $("form#orderSheetForm").attr("action", "/m/order/payRequest");
                            $("form#orderSheetForm").submit();
                        }
                    } else {
                        var errorMessages = data.errorMessages;
                        alert(errorMessages.join("\n"));
                        payClickChk = "";
                    }
                }
                ,error: function(xhr, status, error) {
                    alert("<fmt:message key='error.common.system'/>");
                    payClickChk = "";
                }
            });
    	} else {
    		payClickChk = "";
    	}
    });
    
    $("[name=cashRepCode]").change(function(){
    	var index = $("input[name=cashRepCode]").index(this) + 1;
    	if (index == 1) {
            $(".cash_biz.active").removeClass("active");
            $("#cashRcpPri").addClass("active");
    	} else if (index == 2) {
            $(".cash_info.active").removeClass("active");
            $("#cashRcpPub").addClass("active");
    	} else {
            $(".cash_biz.active").removeClass("active");
            $(".cash_info.active").removeClass("active");
    	}
    });
    
    $("[name=cashRepCodeKi]").change(function(){
    	$(".cash_info_in.active").removeClass("active");
    	if ($(this).val() == "01") {
            $("#infoCash").addClass("active");
    	} else if ($(this).val() == "02") {
    		$("#infoCard").addClass("active");
    	}
    });
    

    <%-- GSPOINT 입력시 사용가능한 포인트 이상만 입력 가능하도록 --%>
    $("form#orderSheetForm input[name=gsPointUse]").blur(function(){
        var userGsPoint = Number($("form#orderSheetForm input[name=userGsPoint]").val());
        userGsPoint = Math.floor(eval(userGsPoint/10))*10;
        
        var inputGsPoint = Number(isEmpty($(this).val())? 0 : $(this).val());
        
        var orderAmt = calculateOrderAmtExceptDiscountMethod("gsPoint");
        
        if(inputGsPoint > 0) {
            if(inputGsPoint % 10 != 0) {
                alert("Gs Point는 10원단위로 사용 가능합니다.");
                inputGsPoint = Math.floor(eval(inputGsPoint/10))*10;
                $(this).val(inputGsPoint);
            }
            inputGsPoint = Math.floor(eval(inputGsPoint/10))*10;
            
            if(inputGsPoint > userGsPoint || inputGsPoint > orderAmt) {
                if(userGsPoint > orderAmt) {
                    userGsPoint = orderAmt;
                }
                alert("사용가능한 Gs Point는 " + price_format(userGsPoint) + "원 입니다.");
                $(this).val(userGsPoint);
            }
        } else {
            $(this).val(inputGsPoint);
        }
        
        calculateDiscountPrice();
        calculateOrderAmt();
    });
    
    <%-- OkPOINT 입력시 사용가능한 포인트 이상만 입력 가능하도록 --%>
    $("form#orderSheetForm input[name=okPointUse]").blur(function(){
        var userOkPoint = Number($("form#orderSheetForm input[name=userokPoint]").val());
        userOkPoint = Math.floor(eval(userOkPoint/10))*10;
        
        var inputOkPoint = Number(isEmpty($(this).val())? 0 : $(this).val());
        
        var orderAmt = calculateOrderAmtExceptDiscountMethod("okPoint");
        
        if(inputOkPoint > 0) {
            if(inputOkPoint % 10 != 0) {
                alert("Ok 캐쉬백은 10원단위로 사용 가능합니다.");
                inputOkPoint = Math.floor(eval(inputOkPoint/10))*10;
                $(this).val(inputOkPoint);
            }
            inputOkPoint = Math.floor(eval(inputOkPoint/10))*10;
            
            if(inputOkPoint > userOkPoint || inputOkPoint > orderAmt) {
                if(userOkPoint > orderAmt) {
                	userOkPoint = orderAmt;
                }
                alert("사용가능한 Ok 캐쉬백는 " + price_format(userOkPoint) + "원 입니다.");
                $(this).val(userOkPoint);
            }
        } else {
            $(this).val(inputOkPoint);
        }
        
        calculateDiscountPrice();
        calculateOrderAmt();
    });
    
    <%-- LPOINT 입력시 사용가능한 포인트 이상만 입력 가능하도록 --%>
    $("form#orderSheetForm input[name=lPointUse]").blur(function(){
        var userlPoint = Number($("form#orderSheetForm input[name=userlPoint]").val());
        userlPoint = Math.floor(eval(userlPoint/10))*10;
        
        var inputlPoint = Number(isEmpty($(this).val())? 0 : $(this).val());
        
        var orderAmt = calculateOrderAmtExceptDiscountMethod("lPoint");
        
        if(inputlPoint > 0) {
            if(inputlPoint % 10 != 0) {
                alert("L.Point는 10원단위로 사용 가능합니다.");
                inputlPoint = Math.floor(eval(inputlPoint/10))*10;
                $(this).val(inputlPoint);
            }
            inputlPoint = Math.floor(eval(inputlPoint/10))*10;
            
            if(inputlPoint > userlPoint || inputlPoint > orderAmt) {
                if(userlPoint > orderAmt) {
                    userlPoint = orderAmt;
                }
                alert("사용가능한 L.Point는 " + price_format(userlPoint) + "원 입니다.");
                $(this).val(userlPoint);
            }
        } else {
            $(this).val(inputlPoint);
        }
        
        calculateDiscountPrice();
        calculateOrderAmt();
    });
    
    $("[name=password]").on("change keyup paste", function() {
	    $("[name=password]").val($("[name=password]").val().replace(/[^0-9]/g,''));
	});
});

<%-- 통합포인트 전체사용 체크 이벤트 --%>
function totPointAllUse(){
    var totmileage = $("form#orderSheetForm input[name=userTotPoint]").val();
    var orderAmt = calculateOrderAmtExceptDiscountMethod("totmileage");
    totmileage = Math.floor(eval(totmileage/10))*10;
    
    if(totmileage == 0) {
        alert("사용가능한 통합포인트가 없습니다.");
    } else {
        if(totmileage > orderAmt) {
            totmileage = orderAmt;
        }
        $("form#orderSheetForm input[name=totmileage]").val(totmileage).select();
    }
    
    calculateDiscountPrice();
    calculateOrderAmt();
}

<%-- 마일리지 전체사용 체크 이벤트 --%>
function mileAllUse(){
    var mileage = $("form#orderSheetForm input[name=userMileage]").val();
    var orderAmt = calculateOrderAmtExceptDiscountMethod("mileage");
    mileage = Math.floor(eval(mileage/10))*10;
    
    if(mileage == 0) {
        alert("사용가능한 마일리지가 없습니다.");
    } else {
        if(mileage > orderAmt) {
            mileage = orderAmt;
        }
        $("form#orderSheetForm input[name=mileage]").val(mileage).select();
    }
    
    calculateDiscountPrice();
    calculateOrderAmt();
}

<%-- 예치금 전체사용 체크 이벤트 --%>
function depositAllUse(){
    var deposit = $("form#orderSheetForm input[name=userDeposit]").val();
    var orderAmt = calculateOrderAmtExceptDiscountMethod("deposit");
    
    if(deposit == 0) {
        alert("사용가능한 예치금이 없습니다.");
    } else {
        if(deposit > orderAmt) {
            deposit = orderAmt;
        }
        $("form#orderSheetForm input[name=deposit]").val(deposit).select();
    }    
    
    calculateDiscountPrice();
    calculateOrderAmt();
}

function showRecentAddr(){
	//var username = "${loginUser.userAddress.name}";
	//alert(username);
	$("#zipcode").load("/m/order/recentAddr");
    $("#zipcode").show();
}
function showZipcode(){
	$("#zipcode").load("/m/zipcode?ssl=Y");
	$("#zipcode").show();
}
function closeZipcode(){
    $("#zipcode").empty;
    $("#zipcode").hide();
}

function searchGsPoint(){
    document.getElementById("lGetPoint").innerHTML = "0P";
    document.getElementById("gsGetPoint").innerHTML = "0P";
    document.getElementById("okGetPoint").innerHTML = "0P";
    $("input[name=userlPoint]").val(0);	
    $("input[name=userGsPoint]").val(0);
    $("input[name=userokPoint]").val(0);
    
    $("input[name=gsPointUse]").val(0); 
    $("input[name=okPointUse]").val(0);
    $("input[name=lPointUse]").val(0);
    
    calculateDiscountPrice();
    calculateOrderAmt();
    
    $("#lPoint").hide();
    $("#gsPoint").show();
    $("#okPoint").hide();
}

function closeGsPoint(){
    $("#gsPoint").hide();
}

function searchLPoint(){
    document.getElementById("lGetPoint").innerHTML = "0P";
    document.getElementById("gsGetPoint").innerHTML = "0P";
    document.getElementById("okGetPoint").innerHTML = "0P";
    $("input[name=userlPoint]").val(0); 
    $("input[name=userGsPoint]").val(0);
    $("input[name=userokPoint]").val(0);
	
    $("input[name=gsPointUse]").val(0); 
    $("input[name=okPointUse]").val(0);
    $("input[name=lPointUse]").val(0);
    
    calculateDiscountPrice();
    calculateOrderAmt();
    
    $("#gsPoint").hide();
    $("#lPoint").show();
    $("#okPoint").hide();
}

function closeLPoint(){
    $("#lPoint").hide();
}

function searchOkPoint(){
    document.getElementById("lGetPoint").innerHTML = "0P";
    document.getElementById("gsGetPoint").innerHTML = "0P";
    document.getElementById("okGetPoint").innerHTML = "0P";
    $("input[name=userlPoint]").val(0); 
    $("input[name=userGsPoint]").val(0);
    $("input[name=userokPoint]").val(0);
	
    $("input[name=gsPointUse]").val(0); 
    $("input[name=okPointUse]").val(0);
    $("input[name=lPointUse]").val(0);
    
    calculateDiscountPrice();
    calculateOrderAmt();
    
    $("#gsPoint").hide();
    $("#lPoint").hide();
    $("#okPoint").show();
}

function closeOkPoint(){
    $("#okPoint").hide();
}

function conLPoint(){
    if ($("input[name=lIdInput]").val().replace(/(^\s*)|(\s*$)/gi,"") == "") {alert("카드번호를 입력해야 합니다.");return;}
    if ($("input[name=lPwInput]").val().replace(/(^\s*)|(\s*$)/gi,"") == "") {alert("비밀번호를 입력해야 합니다.");return;}
    
    $("input[name=lCard]").val($("input[name=lIdInput]").val().replace(/(^\s*)|(\s*$)/gi,""));
    $("input[name=lPw]").val($("input[name=lPwInput]").val().replace(/(^\s*)|(\s*$)/gi,""));
    $("form#lPoint").ajaxSubmit({
        url: "/m/order/lPointSearch"
        ,dataType: "json"
        ,success: function checkSuccess(data) {

            if (data.result.rspC =="0") {
                document.getElementById("lGetPoint").innerHTML = data.result.avlPt + "P";
                $("input[name=userlPoint]").val(data.result.avlPt);
                $("input[name=userlCardNo]").val(data.result.lCard);
                $("input[name=userlPw]").val(data.result.lPw);
                $("#lPoint").hide();
            } else {
                alert(data.result.rspMsgCn);
            }
        }
        ,error: function(xhr, status, error) {
            alert("<fmt:message key='error.common.system'/>");
        }
    });
}

function conGsPoint(){
    if ($("input[name=gsIdInput]").val().replace(/(^\s*)|(\s*$)/gi,"") == "") {alert("GS 아이디를 입력해야 합니다.");return;}
    if ($("input[name=gsPwInput]").val().replace(/(^\s*)|(\s*$)/gi,"") == "") {alert("비밀번호를 입력해야 합니다.");return;}
    
    $("input[name=gsId]").val($("input[name=gsIdInput]").val().replace(/(^\s*)|(\s*$)/gi,""));
    $("input[name=gsPw]").val($("input[name=gsPwInput]").val().replace(/(^\s*)|(\s*$)/gi,""));
    $("form#gsPoint").ajaxSubmit({
        url: "/m/order/gsPointSearch"
        ,dataType: "json"
        ,success: function checkSuccess(data) {
            if (data.result.result =="00000") {
                document.getElementById("gsGetPoint").innerHTML = data.result.gsPoint + "P";
                $("input[name=userGsPoint]").val(data.result.gsPoint);
                $("input[name=userGsCardNo]").val(data.result.gsCardNum);
                $("#gsPoint").hide();
            } else {
                alert(data.result.remark);
            }
        }
        ,error: function(xhr, status, error) {
            alert("<fmt:message key='error.common.system'/>");
        }
    });
}

function conOkPoint(){
    if ($("input[name=okIdInput]").val().replace(/(^\s*)|(\s*$)/gi,"") == "") {alert("카드번호를 입력해야 합니다.");return;}
    if ($("input[name=okPwInput]").val().replace(/(^\s*)|(\s*$)/gi,"") == "") {alert("비밀번호를 입력해야 합니다.");return;}
    
    $("input[name=okId]").val($("input[name=okIdInput]").val().replace(/(^\s*)|(\s*$)/gi,""));
    $("input[name=okPw]").val($("input[name=okPwInput]").val().replace(/(^\s*)|(\s*$)/gi,""));
    
    $("form#okPoint").ajaxSubmit({
        url: "/m/order/okPointSearch"
        ,dataType: "json"
        ,success: function checkSuccess(data) {
            if (data.result.sReplyCode =="000000") {
                document.getElementById("okGetPoint").innerHTML = data.result.sAvPoint + "P";
                $("input[name=userokPoint]").val(data.result.sAvPoint);
                $("input[name=userokCardNo]").val($("input[name=okId]").val());
                $("input[name=userokCardPw]").val($("input[name=okPw]").val());
                $("#okPoint").hide();
            } else {
                alert(data.result.sReplyMessage);
            }
        }
        ,error: function(xhr, status, error) {
            alert("<fmt:message key='error.common.system'/>");
        }
    });
}

<%-- 결제금액 계산(특정 할인수단 제외하고 계산) --%>
function calculateOrderAmtExceptDiscountMethod(exceptDiscountMethod) {
    var totalPrdtAmt = isEmpty($("input[name=totalPrdtAmt]").val())? 0 : Number($("input[name=totalPrdtAmt]").val());
    var totalDlvyAmt = isEmpty($("input[name=totalDlvyAmt]").val())? 0 : Number($("input[name=totalDlvyAmt]").val());
    
    var mileage = isEmpty($("input[name=mileage]").val())? 0 : Number($("input[name=mileage]").val());
    var deposit = isEmpty($("input[name=deposit]").val())? 0 : Number($("input[name=deposit]").val());
    var totPoint = isEmpty($("input[name=totmileage]").val())? 0 : Number($("input[name=totmileage]").val());
    var gsPoint = isEmpty($("input[name=gsPointUse]").val())? 0 : Number($("input[name=gsPointUse]").val());
    var okPoint = isEmpty($("input[name=okPointUse]").val())? 0 : Number($("input[name=okPointUse]").val());
    var lPoint = isEmpty($("input[name=lPointUse]").val())? 0 : Number($("input[name=lPointUse]").val());
    
    var cpnDscntPrice = isEmpty($("input[name=cpnDscntPrice]").val())? 0 : Number($("input[name=cpnDscntPrice]").val());
    var discountPrice = 0;
    
     if(exceptDiscountMethod == "deposit") {
        discountPrice = cpnDscntPrice + mileage + totPoint + gsPoint + okPoint + lPoint;
    } else if(exceptDiscountMethod == "mileage") {
        discountPrice = cpnDscntPrice + deposit + totPoint + gsPoint + okPoint + lPoint;
    } else if(exceptDiscountMethod == "totmileage") {
        discountPrice = cpnDscntPrice + mileage + deposit + gsPoint + okPoint + lPoint;
    } else if(exceptDiscountMethod == "gsPoint") {
        discountPrice = cpnDscntPrice + mileage + deposit + totPoint + okPoint + lPoint;
    } else if(exceptDiscountMethod == "okPoint") {
        discountPrice = cpnDscntPrice + mileage + deposit + totPoint + gsPoint + lPoint;
    } else if(exceptDiscountMethod == "lPoint") {
        discountPrice = cpnDscntPrice + mileage + deposit + totPoint + gsPoint + okPoint;
    }
    
    
    return eval(totalPrdtAmt + totalDlvyAmt - discountPrice);
}

<%-- 할인가격 계산 --%>
function calculateDiscountPrice() {
    var discountPrice = 0;
    var mileage = isEmpty($("input[name=mileage]").val())? 0 : Number($("input[name=mileage]").val());
    var deposit = isEmpty($("input[name=deposit]").val())? 0 : Number($("input[name=deposit]").val());
    var totmileage = isEmpty($("input[name=totmileage]").val())? 0 : Number($("input[name=totmileage]").val());
    var gsPointUse = isEmpty($("input[name=gsPointUse]").val())? 0 : Number($("input[name=gsPointUse]").val());
    var okPointUse = isEmpty($("input[name=okPointUse]").val())? 0 : Number($("input[name=okPointUse]").val());
    var lPointUse = isEmpty($("input[name=lPointUse]").val())? 0 : Number($("input[name=lPointUse]").val());
    var cpnDscntPrice = isEmpty($("input[name=cpnDscntPrice]").val())? 0 : Number($("input[name=cpnDscntPrice]").val());
    
    discountPrice = eval(mileage + deposit + cpnDscntPrice + totmileage + gsPointUse + okPointUse + lPointUse);
    $("input[name=discountPrice]").val(eval(discountPrice * (-1)));
    
    discountPrice = discountPrice > 0 ? "-" + price_format(discountPrice) : 0;
    $("#discountPrice").html(discountPrice);
}

<%-- 결제금액 계산 --%>
function calculateOrderAmt() {
    var totalPrdtAmt = isEmpty($("input[name=totalPrdtAmt]").val())? 0 : Number($("input[name=totalPrdtAmt]").val());
    var totalDlvyAmt = isEmpty($("input[name=totalDlvyAmt]").val())? 0 : Number($("input[name=totalDlvyAmt]").val());
    var discountPrice = isEmpty($("input[name=discountPrice]").val())? 0 : Number($("input[name=discountPrice]").val());
    
    var orderAmt = totalPrdtAmt + totalDlvyAmt + discountPrice;
    $("input[name=orderAmt]").val(orderAmt);
    $("#orderAmt").html(price_format(orderAmt));
    
    // 결제금액에 따른 결제수단 처리
    if(orderAmt > 0) {
        $("input[name=pymntMeansCode]").attr("disabled", false);
        $("#paymentArea").show();
    } else {
        $("input[name=pymntMeansCode]").attr("disabled", true);
        $("#paymentArea").hide();
    }
    
    // 에스크로 영역처리
    //checkEscrow();
}

<%-- 우편번호 찾기 콜백 함수 --%>
function callbackZipcode(zipcode, address) {
    $("input[name=receiverAddress]").val(address);
    $("#receiverAddress").text("["+zipcode.substring(0,3)+"-"+zipcode.substring(4,7)+"]"+address);
    $("input[name=receiverPostNum1]").val(zipcode.substring(0,3));
    $("input[name=receiverPostNum2]").val(zipcode.substring(4,7));
    $("input[name=receiverDetailAddress]").val("");
    closeZipcode();
}

<%-- 도로명 주소 콜백 함수 --%>
function callbackRoadCode(zipcode, address1, address2, address3, address4 ) {
    $("input[name=receiverAddress]").val(address1);
    $("#receiverAddress").text("["+zipcode.substring(0,3)+"-"+zipcode.substring(4,7)+"]"+address1);
    $("input[name=receiverPostNum1]").val(zipcode.substring(0,3));
    $("input[name=receiverPostNum2]").val(zipcode.substring(4,7));
    $("input[name=receiverDetailAddress3]").val(address2);
    $("input[name=receiverDetailAddress4]").val(address3);
    $("input[name=receiverDetailAddress]").val("");
    document.getElementById("receiverDetailAddressView3").innerHTML = address2;
    document.getElementById("receiverDetailAddressView4").innerHTML = address3;
    closeZipcode();
}

function fnFocusEm(chkTarget, bgTarget, msg){
    $(".chk_required").removeClass("chk_required");
    
    alert(msg);
    chkTarget.focus();
    bgTarget.addClass("chk_required");
    return false;
}

function fnCheckOrderFrm(){
    if(!$("input[name=agreeCheck]").attr('checked')){
        return fnFocusEm($("#agreeCheck"), $(".agree-check"), "주문동의가 필요합니다.");
    }else if(isEmpty($("input[name=receiverName]").val())){
        return fnFocusEm($("input[name=receiverName]"), $("input[name=receiverName]"), "이름을 입력해주세요.");
    }else if(isEmpty($("input[name=receiverHandPhone1]").val())){
        return fnFocusEm($("input[name=receiverHandPhone1]"), $("input[name=receiverHandPhone1]"), "휴대폰번호를 입력해주세요.");
    }else if(isEmpty($("input[name=receiverHandPhone2]").val())){
        return fnFocusEm($("input[name=receiverHandPhone2]"), $("input[name=receiverHandPhone2]"), "휴대폰번호를 입력해주세요.");
    }else if(isEmpty($("input[name=receiverHandPhone3]").val())){
        return fnFocusEm($("input[name=receiverHandPhone3]"), $("input[name=receiverHandPhone3]"), "휴대폰번호를 입력해주세요.");
    }else if(isEmpty($("input[name=receiverPostNum1]").val())){
        return fnFocusEm($("input[name=receiverPostNum1]"), $("input[name=receiverPostNum1]"), "우편번호를 입력해주세요.");
    }else if(isEmpty($("input[name=receiverPostNum2]").val())){
        return fnFocusEm($("input[name=receiverPostNum2]"), $("input[name=receiverPostNum2]"), "우편번호를 입력해주세요.");
    }else if(isEmpty($("input[name=receiverAddress]").val())){
        return fnFocusEm($("input[name=receiverAddress]"), $("input[name=receiverAddress]"), "기본주소를 입력해주세요.");
    }else if(isEmpty($("input[name=receiverDetailAddress]").val())){
        return fnFocusEm($("input[name=receiverDetailAddress]"), $("input[name=receiverDetailAddress]"), "상세주소를 입력해주세요.");
    }else if($("input[name=pymntMeansCode]:checked").length == 0){
        var totalPrdtAmt = isEmpty($("input[name=totalPrdtAmt]").val())? 0 : Number($("input[name=totalPrdtAmt]").val());
        var totalDlvyAmt = isEmpty($("input[name=totalDlvyAmt]").val())? 0 : Number($("input[name=totalDlvyAmt]").val());
        var discountPrice = isEmpty($("input[name=discountPrice]").val())? 0 : Number($("input[name=discountPrice]").val());
        
        var orderAmt = totalPrdtAmt + totalDlvyAmt + discountPrice;
        if(orderAmt > 0)
            return fnFocusEm($("input[name=pymntMeansCode]:first"), $("input[name=pymntMeansCode]:first").parent(), "결제수단을 선택해주세요.");
    }
    //네이버페이 결제시 
    else if($("input[name=pymntMeansCode]:checked").val() == 'C011E'){
    	//개인소득공제 휴대폰 또는 카드번호 미입력 로직 체크
    	if($("input[name=cashRepCode]:checked").val() == '01'){
    		if($("select[name=cashRepCodeKi] option:selected").val() == '01'){
    	    	if(isEmpty($("input[name=cashRepHp1]").val())){
    	    		return fnFocusEm($("input[name=cashRepHp1]"), $("input[name=cashRepHp1]"), "휴대폰번호를 입력해주세요.");
    	    	}else if(isEmpty($("input[name=cashRepHp2]").val())){ 
    	    		return fnFocusEm($("input[name=cashRepHp2]"), $("input[name=cashRepHp2]"), "휴대폰번호를 입력해주세요.");
    	    	}else if(isEmpty($("input[name=cashRepHp3]").val())){ 
    	    		return fnFocusEm($("input[name=cashRepHp3]"), $("input[name=cashRepHp3]"), "휴대폰번호를 입력해주세요.");
    	    	}
        	}
    		if($("select[name=cashRepCodeKi] option:selected").val() == '02'){
    			if(isEmpty($("input[name=cashRepCd1]").val())){
    	    		return fnFocusEm($("input[name=cashRepCd1]"), $("input[name=cashRepCd1]"), "카드번호를 입력해주세요.");
    	    	}else if(isEmpty($("input[name=cashRepCd2]").val())){ 
    	    		return fnFocusEm($("input[name=cashRepCd2]"), $("input[name=cashRepCd2]"), "카드번호를 입력해주세요.");
    	    	}else if(isEmpty($("input[name=cashRepCd3]").val())){ 
    	    		return fnFocusEm($("input[name=cashRepCd3]"), $("input[name=cashRepCd3]"), "카드번호를 입력해주세요.");
    	    	}else if(isEmpty($("input[name=cashRepCd4]").val())){ 
    	    		return fnFocusEm($("input[name=cashRepCd4]"), $("input[name=cashRepCd4]"), "카드번호를 입력해주세요.");
    	    	}
    		}
    	}
    	//사업자번호 미입력 로직 체크
    	if($("input[name=cashRepCode]:checked").val() == '02'){
	    	if(isEmpty($("input[name=cashRepbizNum1]").val())){
	    		return fnFocusEm($("input[name=cashRepbizNum1]"), $("input[name=cashRepbizNum1]"), "사업자번호를 입력해주세요.");
	    	}else if(isEmpty($("input[name=cashRepbizNum2]").val())){ 
	    		return fnFocusEm($("input[name=cashRepbizNum2]"), $("input[name=cashRepbizNum2]"), "사업자번호를 입력해주세요.");
	    	}else if(isEmpty($("input[name=cashRepbizNum3]").val())){ 
	    		return fnFocusEm($("input[name=cashRepbizNum3]"), $("input[name=cashRepbizNum3]"), "사업자번호를 입력해주세요.");
	    	}
    	}
    }
    
    return true;
}

function openCouponPopup() {
    if($("input[name=usableCpnCount]").val() != 0){
        //window.open('', 'popupCouponList', 'width=670,height=720');
        $("form#orderSheetForm").attr("action", "/m/order/popupCouponList");
        $("form#orderSheetForm").attr("target", "#useCouponList");
        $("form#orderSheetForm").submit();
        $("#useCouponList").show();
    } else {
        alert("사용 가능하신 쿠폰이 없습니다.");
    }
}

function openCouponList() {
	$("form#orderSheetForm").ajaxSubmit({
        url: '/m/order/popupCouponList'
        ,dataType: 'html'
        ,success: function(html) {
        	$("#useCouponList").html(html);
            $("#useCouponList").show();
        }
        ,error: function(data) {
            alert('<fmt:message key="error.common.system"/>');
        }
    });

	
    //$("#useCouponList").load("/m/order/popupCouponList?ssl=Y");
}
function closeCouponList(){
    $("#useCouponList").empty;
    $("#useCouponList").hide();
}

function applyCoupon(totalCpnDscntPrice, couponInfoList, dlvyCouponInfoList, orderCouponInfo) {
    if(!isEmpty(totalCpnDscntPrice)) {
        $("input[name=cpnDscntPrice]").val(totalCpnDscntPrice);
        $("#cpnDscntPrice").html(totalCpnDscntPrice);
    }
    
    $("form#orderSheetForm").find("input[name=applyCouponInfo]").remove();
    $("form#orderSheetForm").find("input[name=applyDlvyCouponInfo]").remove();
    $("form#orderSheetForm").find("input[name=applyOrderCouponInfo]").remove();
    
    for(var i=0;i<couponInfoList.length;i++) {
        $("form#orderSheetForm").append("<input type='hidden' name='applyCouponInfo' value='" + couponInfoList[i] + "'/>");
    }
    
    for(var j=0;j<dlvyCouponInfoList.length;j++) {
        $("form#orderSheetForm").append("<input type='hidden' name='applyDlvyCouponInfo' value='" + dlvyCouponInfoList[j] + "'/>");
    }
    
    $("form#orderSheetForm").append("<input type='hidden' name='applyOrderCouponInfo' value='" + orderCouponInfo + "'/>");
    
    calculateDiscountPrice();
    calculateOrderAmt();
}

function select_address2(zip1, rcvrAddr, rcvrDtlAddr, rcvrTelNum, rcvrHdphnNum, name){
     $("input[name=receiverAddress]").val(rcvrAddr);
     
     $("input[name=receiverName]").val(name);
     
     if(zip1.indexOf("-") > -1){
         $("#receiverAddress").text("["+zip1.split("-")[0]+"-"+zip1.split("-")[1]+"]"+ rcvrAddr);
         $("input[name=receiverPostNum1]").val(zip1.split("-")[0]);
         $("input[name=receiverPostNum2]").val(zip1.split("-")[1]);
     }else if(zip1.length == 5 || zip1.length == 6){
         $("#receiverAddress").text("["+zip1.substring(0, 3)+"-"+zip1.substring(3, 6)+"]"+ rcvrAddr);
         $("input[name=receiverPostNum1]").val(zip1.substring(0, 3));
         $("input[name=receiverPostNum2]").val(zip1.substring(3, 6));
     }else{
         $("#receiverAddress").text("["+zip1+"]"+ rcvrAddr);
         $("input[name=receiverPostNum1]").val(zip1);
         $("input[name=receiverPostNum2]").val("");
     }
     
     $("input[name=receiverDetailAddress]").val(rcvrDtlAddr);
     
     $("input[name=receiverTelePhone1]").val(rcvrTelNum.split("-")[0]);
     $("input[name=receiverTelePhone2]").val(rcvrTelNum.split("-")[1]);
     $("input[name=receiverTelePhone3]").val(rcvrTelNum.split("-")[2]);
     
     $("input[name=receiverHandPhone1]").val(rcvrHdphnNum.split("-")[0]);
     $("input[name=receiverHandPhone2]").val(rcvrHdphnNum.split("-")[1]);
     $("input[name=receiverHandPhone3]").val(rcvrHdphnNum.split("-")[2]);
     
     closeZipcode();
     // self.close();
}
//maxlength 체크
function maxLengthCheck(object){
	if (object.value.length > object.maxLength) {
		object.value = object.value.slice(0, object.maxLength);
	}
}
</script>

</head>
<body>
	<input type="hidden" id="orderCnt" value="${fn:length(cartList)}">
	<!-- 주문 정보 -->
		<div class="orderlist">
	    <c:set value="no" var="preOrderProduct" />
		<c:forEach items="${cartList}" var="cart">
				<h2 class="tit_h2">${cart.dlvyVndrId eq '0625'?'핫트랙스':'업체개별'} 배송 </h2>
				<div class="roundbox pb10">
					<c:forEach items="${cart.cartProductList}" var="product" varStatus="productStatus">
                		<c:if test="${product.rcrdStat eq '9' }"><c:set value="ok" var="preOrderProduct" /></c:if>
						<div class="p_name">
							<a href="#n"> <span class="thumb" onclick="location.href='http://m.hottracks.co.kr/p/${product.sellPrdtBcode}';return false;"> <c:if test="${fn:contains('DR' ,product.sellPrdtGbn) }">
										<ui:image rcrdCd="${product.rcrdCd}" prdtGbn="${product.sellPrdtGbn}" width="${product.sellPrdtGbn eq 'R'?'100':'66'}" alt="${product.prdtName}" ratingCode="${product.rtngCode }" ssl="${serviceYn}" />
									</c:if> <c:if test="${!fn:contains('DR' ,product.sellPrdtGbn) }">
										<ui:image src="${product.productImageUrl}" server="product" size="100" alt="${product.prdtName}" ssl="${serviceYn}" />
									</c:if> </span>
								<div class="name">
									<input type="hidden" name="prdtName" value="${product.prdtName}" /> <strong>${product.prdtName}</strong>
									<c:if test="${product.sellPrdtGbn eq 'S'}">
										<span>${product.specName}</span>
									</c:if>
									<c:if test="${!empty product.optnList}">
										<c:forEach items="${product.optnList}" var="optn" varStatus="optnStatus">
											<span>${optn}</span>
											<c:if test="${fn:length(product.optnList) > optnStatus.count}"></c:if>
										</c:forEach>
									</c:if>

									<c:if test="${product.cvslPrdtYn eq 'true'}">
										<span> <c:choose>
												<c:when test="${product.cvslPrice > 0}">유료각인 : ${product.cvslFont} ${product.cvslCont} ( + <fmt:formatNumber value="${product.cvslPrice}" pattern="#,###" />)</c:when>
												<c:otherwise>무료각인 : ${product.cvslFont} ${product.cvslCont} ( + <fmt:formatNumber value="${product.cvslPrice}" pattern="#,###" />)</c:otherwise>
											</c:choose> </span>
									</c:if>
									<c:if test="${product.orderMakeYn eq 'true'}">
										<span>기타정보 : ${product.orderMakeCont}</span>
									</c:if>
									<c:if test="${!empty product.cartProductFreeGiftList}">
										<c:forEach items="${product.cartProductFreeGiftList}" var="productFreeGift">
		                                    <span>사은품 : ${productFreeGift.freeGiftName}</span>
		                                </c:forEach>
									</c:if>
								</div> </a>
						</div>
					<ul class="br_list">
	                    <li>
	                        <span class="fl_l col_grey">판매가</span>
	                        <span class="fl_r"><span class="col_black"><fmt:formatNumber value="${product.sellPrice}" pattern="#,###"/>원[<fmt:formatNumber value="${(product.prdtSellPrice-product.sellPrice)/product.prdtSellPrice * 100}" pattern="#,###"/>%↓]</span></span>
	                    </li>
	                    <li>
	                        <span class="fl_l col_grey">수량</span>
	                        <span class="fl_r">${product.prdtCount}개</span>
	                    </li>
	                    <li>
	                        <span class="fl_l col_grey">총금액</span>
	                        <span class="fl_r f_bold"><fmt:formatNumber value="${product.sumSellPrice}" pattern="#,###"/><span class="f_normal">원</span></span>
	                    </li>
                	</ul>
					</c:forEach>
				</div>
			</c:forEach>
			
			<!-- 예약 상품 주문 시 -->
			<div class="roundbox mt30 f14" id="preOrderLayer" style="display:<c:if test="${preOrderProduct eq 'no'}">none</c:if><c:if test="${preOrderProduct eq 'ok'}">block</c:if>;">              
		        <p class="col_red">주문 상품 목록에 발매 예정인 음반 예약 상품이 포함되어 있습니다.</p>
		        <p>예약 상품 발매 후 배송이 진행됩니다. 기 출시 상품을 먼저 받아보시려면 예약 상품과 별도로 주문하시기 바랍니다.</p>
		    </div>
	</div>
	
	<form id="orderSheetForm" action="#" method="post">
		<input type="hidden" name="linkTmsYn" value="" /> <input type="hidden" name="orderNum" value="" /> <input type="hidden" name="prdtName" value="" /> <input type="hidden" name="productClassCount" value="${cartProductSum.sumOfProductClassCount}" /> <input type="hidden" name="orderCount" value="${cartProductSum.sumOfOrderCount}" /> <input type="hidden" name="orderAmt" value="${cartProductSum.totalOrderAmt}" /> <input type="hidden" name="buyerName" id="buyerName" value="${loginUser.userAddress.name}" maxlength="30" class="input_txt" title="주문자명" /> <input type="hidden" name="telephone1" value="" /> <input type="hidden" name="telephone2" value="" /> <input type="hidden" name="telephone3" value="" /> <input type="hidden" name="handPhone1" value="" /> <input type="hidden" name="handPhone2" value="" /> <input type="hidden" name="handPhone3" value="" /> <input type="hidden" name="orderInfoSmsYn" id="orderInfoSmsN" value="Y" />

		<!-- 배송지 정보 -->
		<div class="orderlist">
			<h2 class="tit_h2">배송지 정보
				<c:if test="${loginUser ne null}">
				<a href="javascript://" onclick="showRecentAddr()" class="ml10 bt_sbrg1 f_normal" id="recentAddrBtn">최근 배송지</a>
			</c:if>
			</h2>
		<div class="roundbox pd10">
			<!--<span class="col_black">회원 정보를 수정하신 경우,재로그인 하셔야 변경된 정보가 반영됩니다.</span>-->
			<div id="zipcode"></div>
			<ul class="br_list">
				<li class="br_none pb15"><h3 class="tit_h3 mb10">이름<span class="s_point">&#42;</span></h3> <input type="text" name="receiverName" maxlength="30" class="i_input" title="수령인명" value="${loginUser.userAddress.name}" style="width: calc(100% - 12px);" /></li>
				<li class="pt12 pb15">
					<h3 class="tit_h3 mb10">주소<span class="s_point">&#42;</span><a href="javascript://" onclick="execDaumPostcode()" class="bt_sbgb ml10">우편번호 검색</a></h3>
					<div id="dwrap" style="display:none;margin:10px 0;position:relative">
						<img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/bt_close_b.png" id="btnFoldWrap" style="cursor:pointer; position:absolute; right:-4px; top:-38px; z-index:1; width:30px; height:auto;" onclick="foldDaumPostcode()" alt="접기 버튼">
					</div>
					<div id="receiverAddress" class="mt10" style="padding: 5px; text-align: left; font-size: 14px; border: 1px solid #dbdbdb; border-radius: 3px; background: #fff; width:calc(100% - 12px);">[${loginUser.userAddress.postNum1}-${loginUser.userAddress.postNum2}] ${loginUser.userAddress.addr1}</div> <input class="i_input mt10" name="receiverDetailAddress" style="width: calc(100% - 12px);" maxlength="50" placeholder="상세주소" type="text" class="i_input" title="수령인 상세주소" value="${loginUser.userAddress.addr2}" /> <span id="receiverDetailAddressView3" class="hid_obj" name="receiverDetailAddressView3"></span> <span id="receiverDetailAddressView4" class="hid_obj" name="receiverDetailAddressView4"></span> <input type="hidden" name="receiverPostNum1" value="${loginUser.userAddress.postNum1}" /> <input type="hidden" name="receiverPostNum2" value="${loginUser.userAddress.postNum2}" /> <input name="receiverAddress" type="hidden" class="i_input" title="수령인 기본주소" readonly="readonly" value="${loginUser.userAddress.addr1}" /> <input
					name="receiverDetailAddress3" maxlength="50" type="hidden" class="i_input" title="수령인 상세주소"/>
					<input name="receiverDetailAddress4" maxlength="50" type="hidden" class="i_input" title="수령인 상세주소" />
				</li>

				<li class="pt12 pb15"><h3 class="tit_h3 mb10">휴대폰<span class="s_point">&#42;</span></h3> <input type="number" name="receiverHandPhone1" class="i_input inputNumberText" maxlength="4" pattern="[0-9]*" inputmode="numeric" min="0" oninput="maxLengthCheck(this)" title="수령인 휴대폰 지역번호 입력" style="width: calc(30% - 12px); ime-mode: disabled;" placeholder="" value="${fn:split(loginUser.userAddress.handPhoneNum, '-')[0]}" /><span class="input_line">-</span><input type="number" name="receiverHandPhone2" class="i_input inputNumberText" pattern="[0-9]*" inputmode="numeric" min="0" oninput="maxLengthCheck(this)" maxlength="4" title="수령인 휴대폰 중간자리 입력" style="width: calc(30% - 12px); ime-mode: disabled;" placeholder="" value="${fn:split(loginUser.userAddress.handPhoneNum, '-')[1]}" /><span class="input_line">-</span><input type="number" name="receiverHandPhone3" class="i_input inputNumberText" pattern="[0-9]*" inputmode="numeric" min="0" oninput="maxLengthCheck(this)" maxlength="4" title="수령인 휴대폰 뒷자리 입력" style="width: calc(30% - 12px); ime-mode: disabled;" placeholder="" value="${fn:split(loginUser.userAddress.handPhoneNum, '-')[2]}" /></li>
				<li class="pt12 pb15"><h3 class="tit_h3 mb10">전화번호</h3> <input type="number" name="receiverTelePhone1" class="i_input inputNumberText" oninput="maxLengthCheck(this)" pattern="[0-9]*" inputmode="numeric" min="0" maxlength="4" title="수령인 전화번호 지역번호 입력" style="width: calc(30% - 12px); ime-mode:disabled;" placeholder="" value="${fn:split(loginUser.userAddress.telNum, '-')[0]}" /><span class="input_line">-</span><input type="number" name="receiverTelePhone2" pattern="[0-9]*" inputmode="numeric" min="0" class="i_input inputNumberText" oninput="maxLengthCheck(this)" maxlength="4" title="수령인 전화번호 중간자리 입력" style="width: calc(30% - 12px); ime-mode:disabled;" placeholder="" value="${fn:split(loginUser.userAddress.telNum, '-')[1]}" /><span class="input_line">-</span><input type="number" name="receiverTelePhone3" class="i_input inputNumberText" pattern="[0-9]*" inputmode="numeric" min="0" maxlength="4" oninput="maxLengthCheck(this)" title="수령인 전화번호 뒷자리 입력" style="width: calc(30% - 12px); ime-mode:disabled;" placeholder="" value="${fn:split(loginUser.userAddress.telNum, '-')[2]}" /></li>
				<!--<li><input name="giftMessage" maxlength="100" type="text" class="i_input userInfo mt10" title="전달메시지" placeholder="전달메시지" style="width: calc(100% - 12px);" /></li>-->
				<li class="pt12 pb15"><h3 class="tit_h3 mb10">주문 요청사항</h3> <input name="orderMessage" maxlength="100" type="text" class="i_input userInfo" title="주문 요청사항 " placeholder="상품 주문 시 업체에게 전달되는 메시지입니다." style="width: calc(100% - 12px);" /></li>
				<li class="pt12 pb20"><h3 class="tit_h3 mb10">배송 요청사항</h3> <input name="deliveryMessage" maxlength="100" type="text" class="i_input userInfo" title="배송 요청사항 " placeholder="택배 배송 시 요청사항을 입력해주세요." style="width: calc(100% - 12px);" /></li>
			</ul>
		</div>
		</div>
		
		<c:if test="${isLogin}">
			<c:if test="${groupSellYn != 'Y'}">
				<!-- 공동구매가 아니면 -->
				<c:if test="${userProperty.gradeId != '99'}">
				
				<div class="orderlist">
					<h2 class="tit_h2">사용 가능 쿠폰</h2>
				<div class="roundbox pd10">
	                <div class="" style="width:calc(100% - 10px);">
	                    <a href="javascript://" onclick="openCouponList()" class="bt_mbgb" style="width:calc(100% - 10px);">쿠폰 <strong>${usableCpnCount + dlvyCpnSum + fn:length(orderCouponList) }장</strong></a>
	                    <input type="hidden" name="usableCpnCount" value="${usableCpnCount + dlvyCpnSum + fn:length(orderCouponList) }" />
	                </div>
	            </div>
	            </div>
	            <div class="bg_f5f6f1 f14" style="padding:10px 10px 0 10px;">
	            	<div id="useCouponList" class="mb10" style="display:none;"></div>
		            <div class="pd10 line_salmon">총 쿠폰 할인금액 : 
		                <span class="fl_r col_black f_normal">원</span>
		                <span class="fl_r col_red f_bold" id="cpnDscntPrice"></span>
		                <input type="hidden" name="cpnDscntPrice" title="쿠폰 입력" value="0"/>
		            </div>
	            </div>
	            
				</c:if>
			</c:if>
			<div class="orderlist">
				<h2 class="tit_h2">할인 정보</h2>
				<div class="roundbox pd10">
	            <ul class="br_list low_p mg0">
	                <li class="br_none pd10_0">
	                    <strong class="tit f_normal">통합포인트</strong>
	                    <span class="price col_black"><fmt:formatNumber type="number" value="${userProperty.totPoint}"/>원</span>
	                    <input type="hidden" name="userTotPoint" value="${userProperty.totPoint}"/>
	                    <span class="count">
	                        <input type="number" name="totmileage" id="totmileage" class="i_input inputNumberText col_red mtm2 t_r" title="통합포인트 사용액 입력" value="0" style="width:60px;height:11px;"> 원
	                    </span>
	                    <a href="javascript:totPointAllUse();" class="ml10 bt_sbrg1 f12 mtm2">모두사용</a>
	                </li>
	                <li class="pd10_0">
	                    <strong class="tit f_normal">마일리지</strong>
	                    <span class="price col_black"><fmt:formatNumber type="number" value="${userProperty.mileage}"/>원</span>
	                    <input type="hidden" name="userMileage" value="${userProperty.mileage}"/>
	                    <span class="count">
	                        <input type="number" name="mileage" id="mileage" class="i_input inputNumberText col_red mtm2 t_r" title="마일리지 사용액 입력" value="0" style="width:60px;height:11px;"> 원
	                    </span>
	                    <a href="javascript:mileAllUse();" class="ml10 bt_sbrg1 f12 mtm2">모두사용</a>
	                </li>
	                <li class="pd10_0">
	                    <strong class="tit f_normal">예치금</strong>
	                    <span class="price col_black"><fmt:formatNumber type="number" value="${userProperty.deposit}"/>원</span>
	                    <input type="hidden" name="userDeposit" value="${userProperty.deposit}"/>
	                    <span class="count">
	                        <input type="number" name="deposit" id="deposit" class="i_input inputNumberText col_red mtm2 t_r" title="예치금 사용액 입력" value="0" style="width:60px;height:11px;"> 원
	                    </span>
	                    <a href="javascript:depositAllUse();" class="ml10 bt_sbrg1 f12 mtm2">모두사용</a>
	                </li>
	            </ul>
	        	</div>
        	</div>
			<c:if test="${groupSellYn != 'Y'}">
				<!-- 공동구매가 아니면 -->
				<div class="orderlist">
					<h2 class="tit_h2">제휴포인트</h2>
				<div class="roundbox pd10">
		            <ul class="br_list low_p mg0">
		                <li class="br_none pd10_0">
		                    <strong class="tit f_normal">GS&amp;POINT</strong>
		                    <input type="hidden" name="userGsPoint" value=""/>
		                    <input type="hidden" name="userGsCardNo" value=""/>
		                    <span class="price col_black" id="gsGetPoint" name="gsGetPoint">0P</span>
		                    <span class="count">
		                        <input type="number" name="gsPointUse" id="gsPointUse" class="i_input inputNumberText col_red mtm2 t_r" title="GS Point 사용액 입력" value="0" style="width:60px;height:11px;"> P
		                    </span>
		                    <a href="javascript:searchGsPoint();" class="bt_sbrg1 ml14 mtm2" style="width:41px;">조회</a>
		                </li>
		                <li class="pd10_0">
		                    <strong class="tit f_normal">OK캐쉬백</strong>
		                    <input type="hidden" name="userokPoint" value=""/>
		                    <input type="hidden" name="userokCardNo" value=""/>
		                    <input type="hidden" name="userokCardPw" value=""/>
		                    <span class="price col_black" id="okGetPoint" name="okGetPoint">0P</span>
		                    <span class="count">
		                        <input type="number" name="okPointUse" id="okPointUse" class="i_input inputNumberText col_red mtm2 t_r" title="Ok 캐쉬백 사용액 입력" value="0" style="width:60px;height:11px;"> P
		                    </span>
		                    <a href="javascript:searchOkPoint();" class="bt_sbrg1 ml14 mtm2" style="width:41px;">조회</a>
		                </li>
		                <li class="pd10_0">
		                    <strong class="tit f_normal">L.POINT</strong>
		                    <input type="hidden" name="userlPoint" value=""/>
		                    <input type="hidden" name="userlCardNo" value=""/>
		                    <input type="hidden" name="userlPw" value=""/>
		                    <span class="price col_black" id="lGetPoint" name="lGetPoint">0P</span>
		                    <span class="count">
		                        <input type="number" name="lPointUse" id="lPointUse" class="i_input inputNumberText col_red mtm2 t_r" title="L.Point 사용액 입력" value="0" style="width:60px;height:11px;"> P
		                    </span>
		                    <a href="javascript:searchLPoint();" class="bt_sbrg1 ml14 mtm2" style="width:41px;">조회</a>
		                </li>
		            </ul>
            
					<div id="gsPoint" class="mt10 mb10 layer_a" style="position: relative; display: none;">
						<!-- GsPoint -->
						<div id="ly_header">
							<h1>GS&amp;POINT</h1>
						</div>
						<div id="ly_content">
							<div class="pd5">
								<ul class="br_list" id="gsPointInfo" style="margin: 0 auto;">
									<li><span class="f14 tit mt7">아이디</span><input type="text" name="gsIdInput" id="gsIdInput" class="i_input fl_r" title="Gs아이디" value="" style="width: 70%;"></li>
									<li><span class="f14 tit mt7">비밀번호</span><input type="password" name="gsPwInput" id="gsPwInput" class="i_input fl_r" title="Gs비밀번호" value="" style="width: 70%;"></li>
									<li class="t_c clear"><a href="javascript:conGsPoint();" class="bt_mbgb">조회</a></li>

								</ul>
							</div>
							<a href="javascript:closeGsPoint();" class="btn_cls">닫기</a>
						</div>
						<!-- //GsPoint -->
					</div>
					<div id="lPoint" class="mt10 mb10 layer_a" style="position: relative; display: none;">
						<!-- LPoint -->
						<div id="ly_header">
							<h1>L.POINT</h1>
						</div>
						<div id="ly_content">
							<div class="pd5">
								<ul class="br_list" id="lPointInfo" style="margin: 0 auto;">
									<li><span class="f14 tit mt7">카드번호</span><input type="number" name="lIdInput" id="lIdInput" class="i_input fl_r" title="카드번호" value="" pattern="[0-9]*" inputmode="numeric" min="0"style="width: 70%;"></li>
									<li><span class="f14 tit mt7">비밀번호</span><input type="password" name="lPwInput" id="lPwInput" class="i_input fl_r" title="비밀번호" value="" style="width: 70%;"></li>
									<li class="t_c clear"><a href="javascript:conLPoint();" class="bt_mbgb">조회</a></li>

								</ul>
							</div>
							<a href="javascript:closeLPoint();" class="btn_cls">닫기</a>
						</div>
						<!-- //LPoint -->
					</div>
					<div id="okPoint" class="mt10 mb10 layer_a" style="position: relative; display: none;">
						<!-- okPoint -->
						<div id="ly_header">
							<h1>OK캐쉬백</h1>
						</div>
						<div id="ly_content">
							<div class="pd5">
								<ul class="br_list" id="okPointInfo" style="margin: 0 auto;">
									<li><span class="f14 tit mt7">카드번호</span><input type="number" name="okIdInput" id="okIdInput" class="i_input fl_r" title="카드번호" value="" pattern="[0-9]*" inputmode="numeric" min="0"style="width: 70%;"></li>
									<li><span class="f14 tit mt7">비밀번호</span><input type="password" name="okPwInput" id="okPwInput" class="i_input fl_r" title="비밀번호" value="" style="width: 70%;"></li>
									<li class="t_c clear"><a href="javascript:conOkPoint();" class="bt_mbgb">조회</a></li>

								</ul>
							</div>
							<a href="javascript:closeOkPoint();" class="btn_cls">닫기</a>
						</div>
						<!-- //okPoint -->
					</div>
				</div>
				</div>
			</c:if>
		</c:if>

		<div class="orderlist">
		<h2 class="tit_h2">주문 합계</h2>
		<div class="order_fee nt_line">
			<ul class="">
				<!--<li><span class="fl_l">총 상품수량</span> <span
					class="fl_r col_black">${cartProductSum.sumOfProductClassCount}종
						(${cartProductSum.sumOfOrderCount}개)</span></li>-->
				<li><span class="fl_l">총 상품금액</span> <span class="fl_r col_black"><fmt:formatNumber value="${cartProductSum.totalPrdtAmt}" />원</span> <input type="hidden" name="totalPrdtAmt" value="${cartProductSum.totalPrdtAmt}" />
				</li>
				<li><span class="fl_l">총 배송비</span> <span class="fl_r col_black"><fmt:formatNumber value="${cartProductSum.totalDlvyAmt}" />원</span> <input type="hidden" name="totalDlvyAmt" value="${cartProductSum.totalDlvyAmt}" />
				</li>
				<li><span class="fl_l">총 주문금액</span> <span class="fl_r col_black"><fmt:formatNumber type="number" value="${cartProductSum.totalOrderAmt}" />원</span> <input type="hidden" name="totalDlvyAmt" value="${cartProductSum.totalDlvyAmt}" />
				</li>
				<li><span>총 할인금액</span><span class="fl_r"><span class="col_red f_bold" id="discountPrice">0</span><span class="col_black">원</span></span><input type="hidden" name="discountPrice" value="0" />
				</li>
				<li class="amount"><span class="fl_l mb10">총 결제금액</span><span class="fl_r"><span class="col_red f_bold" id="orderAmt"><fmt:formatNumber value="${cartProductSum.totalOrderAmt}" /></span><span class="f14 col_black f_normal">원</span></span></li>
				<li class="mb0">
				<span class="fl_l">통합포인트 적립</span><span class="fl_r col_black"><c:if test="${isLogin && userProperty.userGradeId != '99'}"><fmt:formatNumber value="${cartProductSum.totalSavedPrice}" /></c:if><c:if test="${!isLogin || userProperty.userGradeId == '99'}">0</c:if><span class="f14 col_black">원</span></span>
			</li>
			</ul>
		</div>
		</div>

		<div id="paymentArea" class="orderlist pb20">
			<h2 class="tit_h2">결제 선택</h2>
			<div class="roundbox pd10">
				<div class="l_box rdo_chs">
					<ul class="btnpay_list mt10">
						<li class="btnpay"><input type="radio" value="C011J" name="pymntMeansCode" title="신용카드 선택" checked="checked" class="mtm5"/>
							<span>신용카드</span></li>
						<li class="btnpay"><input type="radio" value="C011K" name="pymntMeansCode" title="실시간 계좌이체 선택" class="mtm5"/>
							<span>실시간 계좌이체</span></li>
						<li class="btnpay"><input type="radio" value="C011D" name="pymntMeansCode" title="휴대폰 선택" class="mtm5"/>
							<span>휴대폰</span></li>
					    <c:if test="${limitOrderProductYn eq 'N'}">
						<li class="btnpay"><input type="radio" value="C011L" name="pymntMeansCode" title="무통장입금 선택" class="mtm5"/>
							<span>무통장</span></li>
					    </c:if>
						<li class="btnpay bg_npay w_3"><input type="radio" value="C011E" name="pymntMeansCode" title="네이버페이 선택" class="mtm5"/>
							<span>
								<img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/common/images/order/txt_npay_b.png" alt="네이버페이" style="width:auto;height:19px;margin-top:-2.5px;"/>
							</span></li>
						<li class="btnpay bg_smilepay w_3"><input type="radio" value="C011I" name="pymntMeansCode" title="스마일페이 선택" class="mtm5"/>
							<span>
								<img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/common/images/order/txt_smile_b.png" alt="스마일페이" style="width:auto;height:19px;margin-top:-2.5px;"/>
							</span>
							<!--<span style="margin:1px 0 0 29px;">
								<img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/common/images/order/tool_dc_mb.png" alt="15% 적립" style="width:auto;height:20px;"/>
							</span>--></li>
						<!-- <li class="btnpay bg_kakaopay w_3"><input type="radio" value="C011H" name="pymntMeansCode" title="카카오페이 선택" class="mtm5"/>
							<span>
								<img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/common/images/order/txt_kakao_b.png" alt="카카오페이" style="width:auto;height:19px;margin-top:-2.5px;"/>
							</span></li> -->
							
						<li class="btnpay bg_kakaopay w_3"><input type="radio" value="C011M" name="pymntMeansCode" title="카카오페이 선택" class="mtm5"/>
							<span>
								<img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/common/images/order/txt_kakao_b.png" alt="카카오페이" style="width:auto;height:19px;margin-top:-2.5px;"/>
							</span></li>
						<li class="btnpay"><input type="radio" value="C011N" name="pymntMeansCode" title="페이코 선택" class="mtm5"/>
							<span>
								<img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/common/images/order/txt_payco_b.png" alt="PAYCO" style="width:auto;height:16px;margin-top:-2.5px;"/>
								<strong class="paycoDiscount">4천원 할인</strong>
							</span>
						</li>
					</ul>
				</div>

				<!-- 신용카드 -->
				<div id="bill01" class="clear r_cont pt10 mb20">
					<ul class="info_txt clear">
						<li class="pt10 pb10 col_grey">아이폰 결제 시 세션 오류가 나는 경우, 설정 &gt; safari &gt; 쿠키 허용 항목을 “항상”으로 설정해주세요.</li>
					</ul>
				</div>

				<!-- 네이버페이 -->
				<div class="cash_box mb20">
					<strong class="chk_wrap chk_cash mt10 mb10 f14">현금영수증 발급신청</strong>
					<div class="l_box rdo_chs" style="clear: both; padding-top: 5px;">
						<label><input type="radio" name="cashRepCode" value="01" title="" checked="checked" class="mtm5"/> 개인소득공제</label> <label class="ml10"><input type="radio" name="cashRepCode" value="02" title="" class="mtm5"/> 사업자증빙</label> <label class="ml10"><input type="radio" name="cashRepCode" value="03" title="" class="mtm5"/> 미신청</label>
					</div>
					<div class="cash_info active" id="cashRcpPri">
						<select class="select" name="cashRepCodeKi" title="">
							<option value="01" selected="selected">휴대폰</option>
							<option value="02">카드번호</option>
						</select>
						<div class="cash_info_in active" id="infoCash">
							<input type="number" name="cashRepHp1" id="cashRepHp1" class="i_input inputNumberText" value="${fn:split(loginUser.userAddress.handPhoneNum, '-')[0]}" title="" pattern="[0-9]*" inputmode="numeric" min="0"  oninput="maxLengthCheck(this)" maxlength="4" style="width: 14%;"> <input type="number" name="cashRepHp2" id="cashRepHp2" class="i_input inputNumberText" value="${fn:split(loginUser.userAddress.handPhoneNum, '-')[1]}" title="" pattern="[0-9]*" inputmode="numeric" min="0" oninput="maxLengthCheck(this)" maxlength="4" style="width: 14%;"> <input type="number" name="cashRepHp3" id="cashRepHp3" class="i_input inputNumberText" value="${fn:split(loginUser.userAddress.handPhoneNum, '-')[2]}" title="" pattern="[0-9]*" inputmode="numeric" min="0" oninput="maxLengthCheck(this)" maxlength="4" style="width: 14%;">
						</div>
						<div class="cash_info_in" id="infoCard">
							<input type="number" name="cashRepCd1" id="cashRepCd1" class="i_input inputNumberText" title="" pattern="[0-9]*" inputmode="numeric" min="0" style="width: calc(10% - 3.5px);"> <input type="password" name="cashRepCd2" id="cashRepCd2" class="i_input inputNumberText" title="" pattern="[0-9]*" inputmode="numeric" min="0" style="width: calc(10% - 3.5px);"> <input type="password" name="cashRepCd3" id="cashRepCd3" class="i_input inputNumberText" title="" pattern="[0-9]*" inputmode="numeric" min="0" style="width: calc(10% - 3.5px);"> <input type="number" name="cashRepCd4" id="cashRepCd4" class="i_input inputNumberText" title="" pattern="[0-9]*" inputmode="numeric" min="0" style="width: calc(10% - 3.5px);">
						</div>
					</div>
					<div class="cash_biz" id="cashRcpPub">
						<div class="cash_biz_in active" id="infobiz">
							<span class="fl_l f14 mt7 mr5">사업자 번호</span><input type="number" name="cashRepbizNum1" id="cashRepbizNum1" class="i_input inputNumberText" title="" pattern="[0-9]*" inputmode="numeric" min="0" style="width: 14%;"> <input type="number" name="cashRepbizNum2" id="cashRepbizNum2" class="i_input inputNumberText" title="" pattern="[0-9]*" inputmode="numeric" min="0" style="width: 14%;"> <input type="number" name="cashRepbizNum3" id="cashRepbizNum3" class="i_input inputNumberText" title="" pattern="[0-9]*" inputmode="numeric" min="0" style="width: 14%;">
						</div>
					</div>
				</div>
				
				<!-- 신용카드 할인 안내  -->
				<div class="card_box active mb20">
				    <h2 class="f16 col_black pd10_0 tb_line">신용카드 할인 안내</h2>
				        <ul class="pd5">
				            <li class="mt10">
				            	<strong class="col_red">신한카드</strong>
		                        <p>· 2~6개월, 12개월(부분) 무이자</p>
		                    </li>
				            <li class="mt10">
				            	<strong class="col_red">하나카드</strong>
		                        <p>· 2~3개월 무이자</p>
		                    </li>
				            <li class="mt10">
				            	<strong class="col_red">국민카드</strong>
		                        <p>· 2~5개월 무이자</p>
				            </li>
				            <li class="mt10">
				            	<strong class="col_red">비씨, NH농협, 현대, 삼성카드</strong>
		                        <p>· 2~6개월 무이자</p>
		                    </li>
		                    <li class="mt10">
				            	<strong>유의사항</strong>
		                        <p>· 행사 제외 카드 : 법인, 체크, 선불, 기프트, 하이브리드 등</p>
		                        <p>· 무이자 적용 최소 결제 금액 등 상세 내용은 결제 팝업창에서 확인해 주시기 바랍니다.</p>
		                    </li>
				        </ul>
				</div>
				<!-- / 신용카드 할인 안내 -->

				<!-- 스마일페이 할인 안내  -->
				<div class="smile_box mb20">
					<h2>스마일페이 안내</h2>
					<ul class="pd5">
			            <li>· 앱 설치 없이 G마켓/옥션 ID 로그인 또는 회원가입 후 간편 결제</li>
			            <li>· 국내 신용/체크 카드 등록 후 이용 가능(은행 계좌이체 불가)</li>
			            <li>· 실 결제 금액의 0.5% 스마일캐시 적립(1회 최대 5천 원)</li>
			            <li>· 스마일캐시는 교보핫트랙스 및 G마켓, 옥션, G9 등에서 사용 가능</li>
		        	</ul>
				</div>
				<!-- / 스마일페이 할인 안내  -->
				
				<!-- PAYCO 안내  -->
				<div class="payco_box mb20">
				    <h2 class="f16 col_black pd10_0 tb_line">PAYCO 안내</h2>
			        <ul class="pd5">
			            <li>PAYCO는 엔에이치엔페이코가 만든 안전한 간편결제 서비스입니다.</li>
			            <li>휴대폰과 카드 명의자가 동일해야 결제 가능합니다.</li>
			            <li>* 지원 카드: 모든 국내 신용/체크카드</li>
			            <li>PAYCO 유상 충전 포인트로 결제 시 2% 적립</li>
			        </ul>
			        <h2 class="f16 col_black pd10_0 tb_line"></h2>
			        <ul class="pd5">
			            <li><strong class="col_red">1. 20,000원이상 PAYCO 결제시, 4,000원 즉시할인</strong></li>
			            <li>대상: PAYCO 90일 휴면 회원 or 생애 첫 결제 회원 </li>
			            <li>기간: ~9월 30일</li>
			            <li>*타 프로모션과 중복 적용 불가</li>
			            <li>*기타 상세내용은 페이코  이벤트 공지사항을 참고 바랍니다.</li>
			        </ul>
			        <ul class="pd5">
			            <li><strong class="col_red">2. PAYCO 결제 리워드 프로모션</strong></li>
			            <li>온라인 가맹정에서 PAYCO로 결제한 구매 금액의 0.2% PAYCO 포인트로 적립</li>
			            <li>지급일자는 결제 완료된 달의 다음 달 15일에 포인트 또는 쿠폰으로 지급</li>
			            <li>*타 프로모션과 중복 적용 불가</li>
			            <li>*기타 상세내용은 페이코  이벤트 공지사항을 참고 바랍니다.</li>
			        </ul>
				</div>
				<!-- / PAYCO 안내 -->
			</div>
		
		</div>

		<c:if test="${!isLogin}">
		<div class="pd0_10 bg_f5f6f1 clear">
			<div class="roundbox line_salmon bg_white pd10">
				<span class="f14 mr10">비밀번호</span><input name="password" maxlength="4" type="password" class="i_input inputNumberText" title="비밀번호 입력" style="width:80px;" />
            	<p class="f14 col_red t_l mt5"><span class="s_point">*</span>비회원 주문 시 비밀번호 숫자 4자리를 입력해주세요.</p>
        	</div>
        </div>
        <div class="bg_f5f6f1 pt20"></div>
		</c:if>

		<div class="pd0_10 bg_f5f6f1 clear">
			<div class="roundbox line_salmon bg_white pd10">
				<span class="chk_wrap chk_agree"> <input type="checkbox" name="agreeCheck" id="agreeCheck" />
				<label for="cart1" class="fl_l"></label>
				<div class="fl_l"><p class="f14">주문 상품의 상품명, 가격, 배송 정보에 동의합니다.</p><p class="f14 col_grey">(전자상거래법 제8조 2항)</p></div>
				</span>
			</div>
		</div>

		<div class="btn_area box_flex pt30 pb40 bg_f5f6f1">
			<a href="#n" class="bt_bbgb btnPayment" id="btnPayment">결제하기</a>
			<!--<a href="#n" class="btn br_484848">이전단계</a>-->
		</div>
	</form>
	<form id="gsPoint" action="#" method="post" style="hegiht: 0">
		<input type="hidden" name="gsId" value="" /> <input type="hidden" name="gsPw" value="" />
	</form>
	<form id="okPoint" action="#" method="post" style="hegiht: 0">
		<input type="hidden" name="okId" value="" /> <input type="hidden" name="okPw" value="" />
	</form>
	<form id="lPoint" action="#" method="post" style="hegiht: 0">
		<input type="hidden" name="lCard" value="" /> <input type="hidden" name="lPw" value="" />
	</form>
	
<!-- 다음 주소 api start -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
<script>
    // 우편번호 찾기 화면을 넣을 element
     var element_wrap = document.getElementById('dwrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
    	element_wrap.style.display = 'none';
    }

    function execDaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    // document.getElementById("sample2_extraAddress").value = extraAddr;
                
                } else {
                    // document.getElementById("sample2_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $("input[name=receiverAddress]").val(addr);
                $("#receiverAddress").text("["+data.zonecode.substring(0,3)+"-"+data.zonecode.substring(3,6)+"]"+addr);
                $("input[name=receiverPostNum1]").val(data.zonecode.substring(0,3));
                $("input[name=receiverPostNum2]").val(data.zonecode.substring(3,6));
                $("input[name=receiverDetailAddress]").val("");
                $("input[name=receiverDetailAddress]").focus();
                
             // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script>
<!-- / 다음 주소 api end -->

</body>
</html>