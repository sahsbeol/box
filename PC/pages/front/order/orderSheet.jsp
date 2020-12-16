<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="orderSheet"/>
<html>
<head>
<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>
<script type="text/javascript" src="/js/jquery.timers-1.2.js"></script>
<script type="text/javascript" src="/js/jquery.blockUI.js"></script>

<!-- LGUPLUS -->
<script type="text/javascript" src="https://xpayvvip.uplus.co.kr/xpay/js/xpay_crossplatform.js"></script>
<!-- LGUPLUS END-->

<!-- NICEPAY -->
<script src="https://web.nicepay.co.kr/v3/webstd/js/nicepay-2.0.js" type="text/javascript"></script>
<!-- NICEPAY END-->

<!-- smile Pay -->
<script src="https://pg.cnspay.co.kr/dlp/scripts/postmessage.js" type="text/javascript"></script>
<script src="https://pg.cnspay.co.kr/dlp/scripts/cnspay.js" type="text/javascript"></script>
<!-- smile Pay End -->



<script type="text/javascript">
/*
* 수정불가.
*/
var LGD_window_type = 'iframe';
/*
* 수정불가
*/
function launchCrossPlatform(){
    //lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), 'test', LGD_window_type, null, "", ""); //테스트
    lgdwin = openXpay(document.getElementById('LGD_PAYINFO'), 'service', LGD_window_type, null, "", ""); //리얼
}
/*
* FORM 명만  수정 가능
*/
function getFormObject() {
        return document.getElementById("LGD_PAYINFO");
}
 
/*
 * 인증결과 처리
 */
function payment_return() {
    var fDoc;
    fDoc = lgdwin.contentWindow || lgdwin.contentDocument;
    if (fDoc.document.getElementById('LGD_RESPCODE').value == "0000") {

            var LGD_PAYKEY      = fDoc.document.getElementById('LGD_PAYKEY').value;         // LG데이콤 인증KEY
            var msg = "인증결과 : " + fDoc.document.getElementById('LGD_RESPMSG').value + "\n";
            msg += "LGD_PAYKEY : " + LGD_PAYKEY +"\n\n";
            
            document.getElementById('LGD_PAYKEY').value = LGD_PAYKEY;
            
            var html = $("form#orderInfoForm").html(); 
            $("form#LGD_PAYINFO_COMPLETE_FORM").html($("form#LGD_PAYINFO").html());
            $("form#LGD_PAYINFO_COMPLETE_FORM").append(html);
            
            var replaceUrl = "${defaultHost}/ht/order/orderComplete";
            
            // 결제 최종요청
            $("form#LGD_PAYINFO_COMPLETE_FORM").ajaxSubmit({
                url: "/ht/order/payResponse"
                ,dataType: "json"
                ,success: function saveSuccess(data) {
                    if (data.save) {
                        parent.location.replace(replaceUrl);
                        return false;
                    } else {
                        var errorMessages = data.errorMessages;
                        alert(errorMessages.join("\n"));
                        parent.location.href = "http://www.hottracks.co.kr/ht/order/cart";
                    }
                }
                ,error: function(xhr, status, error) {
                    alert("<fmt:message key='error.common.system'/>");
                    parent.location.href = "http://www.hottracks.co.kr/ht/order/cart";
                }
            });


    } else {
        alert(fDoc.document.getElementById('LGD_RESPCODE').value + "\n" + fDoc.document.getElementById('LGD_RESPMSG').value);
        closeIframe();
        parent.location.reload();
    }
}






var mainPaySel; // 주결제수단선택 체크
var broType;    // 브라우져체크

jQuery(function($){
    $(".paymentCashRepArea").hide();
    $(".cashRepCodeCl02").hide();
    $(".cashRepCodeCl03").hide();
    
    
    <%-- 이메일 선택 이벤트 --%>
    $("select[name=emailSelect]").change(function() {
        $($(this).parent().find("input.email2")).val($(this).val());
    });
    
    <%-- 배송지 정보 선택 사항 --%>
    $("input[name=dlvyInfoSelect]").click(function() {
        // 주문 고객 정보와 동일
        if($(this).val() == "01") {
            // 수령인명(주문자명)
            $("input[name=receiverName]").val($("input[name=buyerName]").val());
            // 수령인 이메일(주문자 이메일)
            $("input[name=receiverEmail1]").val($("input[name=buyerEmail1]").val());
            $("input[name=receiverEmail2]").val($("input[name=buyerEmail2]").val());
            // 수령인 휴대폰 (주문자 휴대폰)
            $("input[name=receiverHandPhone1]").val($("input[name=handPhone1]").val());
            $("input[name=receiverHandPhone2]").val($("input[name=handPhone2]").val());
            $("input[name=receiverHandPhone3]").val($("input[name=handPhone3]").val());
         	// 수령인 전화번호 (주문자 전화번호)
            $("input[name=receiverTelePhone1]").val($("input[name=telephone1]").val());
            $("input[name=receiverTelePhone2]").val($("input[name=telephone2]").val());
            $("input[name=receiverTelePhone3]").val($("input[name=telephone3]").val());
            
            $("input[name=receiverPostNum1]").val($("input[name=postNum1]").val());
            $("input[name=receiverPostNum2]").val($("input[name=postNum2]").val());
            $("input[name=receiverAddress]").val($("input[name=addr1]").val());
            $("input[name=receiverDetailAddress]").val($("input[name=addr2]").val());
            
            $("input[name=receiverDetailAddress3]").val();
            $("input[name=receiverDetailAddress4]").val();
            document.getElementById("receiverDetailAddressView3").innerHTML = "";
            document.getElementById("receiverDetailAddressView4").innerHTML = "";
        }
        
        // 새로운 주소 입력
        if($(this).val() == "02") {
            $("table#receiverInfotable").find("input:not(.userInfo)").val("");
            $("table#receiverInfotable select option:eq(0)").attr("selected", "selected");
            document.getElementById("receiverDetailAddressView3").innerHTML = "";
            document.getElementById("receiverDetailAddressView4").innerHTML = "";
        }
    });
    
    <%-- 결제수단 선택 이벤트 --%>
    $("input[name=pymntMeansCode]").click(function() {
        var index = $("input[name=pymntMeansCode]").index(this) + 1;
        mainPaySel = index;
        var pymntMeansCode = $(this).val();
        
        $(".paymentArea").hide();
        
        // 결제권 안내 창 표현
        if (pymntMeansCode == "C0111") {$(".list01").show();$(".paymentCashRepArea").hide();}
        if (pymntMeansCode == "C0112") {$(".list02").show();$(".paymentCashRepArea").hide();}
        if (pymntMeansCode == "C011D") {$(".list03").show();mainPaySel=3;$(".paymentCashRepArea").hide();}  // 휴대폰 결제
        if (pymntMeansCode == "C0114") {$(".list04").show();$(".paymentCashRepArea").hide();}
        if (pymntMeansCode == "C0117") {$(".list05").show();$(".paymentCashRepArea").hide();}
        if (pymntMeansCode == "C011E") {$(".list06").show();mainPaySel=6;$(".paymentCashRepArea").show();}  // 네이버N페이
        if (pymntMeansCode == "C011H") {$(".list07").show();mainPaySel=8;$(".paymentCashRepArea").hide();}  // 직카카오페이
        if (pymntMeansCode == "C011I") {$(".list08").show();mainPaySel=9;$(".paymentCashRepArea").hide();}  // 스마일페이
        if (pymntMeansCode == "C011J") {$(".list01").show();$(".paymentCashRepArea").hide();}
        // 에스크로 영역 처리
        checkEscrow();
    });
    
    <%-- 현금영수증 선택 이벤트 --%>
    $("input[name=cashRepCode]").click(function() {
        var index = $("input[name=cashRepCode]").index(this) + 1;
        var pymntMeansCode = $(this).val();
        if (pymntMeansCode == "01") {
            var selKi = $("select[name=cashRepCodeKi]").val();
            if (selKi == "01") {$(".cashRepCodeKi").show();$(".cashRepCodeCl01").show();$(".cashRepCodeCl02").hide();$(".cashRepCodeCl03").hide();}
            if (selKi == "02") {$(".cashRepCodeKi").show();$(".cashRepCodeCl01").hide();$(".cashRepCodeCl02").hide();$(".cashRepCodeCl03").show();}
        }
        if (pymntMeansCode == "02") {$(".cashRepCodeKi").hide();$(".cashRepCodeCl01").hide();$(".cashRepCodeCl02").show();$(".cashRepCodeCl03").hide();}
        if (pymntMeansCode == "03") {$(".cashRepCodeKi").hide();$(".cashRepCodeCl01").hide();$(".cashRepCodeCl02").hide();$(".cashRepCodeCl03").hide();}
    });
    
    <%-- 현금영수증 선택 이벤트  --%>
    $("select[name=cashRepCodeKi]").change(function() {
        var selKi = $(this).val();
        if (selKi == "01") {$(".cashRepCodeCl01").show();$(".cashRepCodeCl02").hide();$(".cashRepCodeCl03").hide();}
        if (selKi == "02") {$(".cashRepCodeCl01").hide();$(".cashRepCodeCl02").hide();$(".cashRepCodeCl03").show();}
    });
    
    function fnFocusEm(chkTarget, bgTarget, msg){
        $(".chk_required").removeClass("chk_required");
        
        alert(msg);
        chkTarget.focus();
        bgTarget.addClass("chk_required");
        return false;
    }
    
    function fnCheckOrderFrm(){
        if(!$("#agreeCheck").is(":checked")){
            return fnFocusEm($("#agreeCheck"), $(".agree-check"), "주문동의가 필요합니다.");
        }else if($("input[name=orderInfoSmsYn]:checked").length == 0){
            return fnFocusEm($("input[name=orderInfoSmsYn]:first"), $("input[name=orderInfoSmsYn]:first").parent(), "SMS수신 여부의 체크가 필요합니다.");
        }else if(isEmpty($("input[name=receiverName]").val())){
            return fnFocusEm($("input[name=receiverName]"), $("input[name=receiverName]"), "이름을 입력해주세요.");
        }else if(isEmpty($("input[name=receiverEmail1]").val())){
            return fnFocusEm($("input[name=receiverEmail1]"), $("input[name=receiverEmail1]"), "이메일 주소를 입력해주세요.");
        }else if(isEmpty($("input[name=receiverEmail2]").val())){
            return fnFocusEm($("input[name=receiverEmail2]"), $("input[name=receiverEmail2]"), "이메일 주소를 입력해주세요.");
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
        
        return true;
    }
    
    <%-- 결제하기 버튼 클릭 이벤트--%>
    $("#btnPayment").click(function(){
        /* alert("테스트서버에서는 결제가 불가능합니다.\n관리자에게 문의하세요."); */
    	if(fnCheckOrderFrm()){
            // 바로콘 접속 확인 ----------------
            var httsPartner = getCookie("LinkCookieKey");
            $("input[name=linkTmsYn]").val(broType + httsPartner);
            
            // 직원구매 확인
            if ('${userProperty.gradeId}' == '99') {$("input[name=linkTmsYn]").val('STEP');}
            
            $("form#orderSheetForm input").each(function() {
                $(this).val($.trim($(this).val()));
            });
            
            // 파라메터 유효성 체크
            $("form#orderSheetForm").ajaxSubmit({
                url: "/ht/order/checkBeforePayment"
                ,dataType: "json"
                ,success: function checkSuccess(data) {
                    if (data.save) {
                        var orderNum = isEmpty(data.orderNum)? "" : data.orderNum;
                        var prdtName = isEmpty($("input[name=prdtName]:eq(0)").val())? "" : $("input[name=prdtName]:eq(0)").val(); 
                        var orderAmt =$("form#orderSheetForm").find("input[name=orderAmt]").val();
                        $.blockUI( { message : "<img src='/images/ajax/ajax-loader.gif'/>" });
                        
                        if(orderAmt == 0) {
                            // 보조결제 수단만으로 결제
                            $("form#orderSheetForm").find("input[name=orderNum]").val(orderNum);
                            $("form#orderSheetForm").find("input[name=prdtName]").val(prdtName);
                            
                            $("form#orderSheetForm").ajaxSubmit({
                                url: "/ht/order/orderOnlySubPayment"
                                ,dataType: "json"
                                ,success: function saveSuccess(data) {
                                    if(data.save) {
                                        var orderNum = $("form#orderSheetForm").find("input[name=orderNum]").val();
                                        $("form#orderSheetForm").attr("action", "${defaultHost}/ht/order/orderComplete");
                                        $("form#orderSheetForm").attr("target", "");
                                        $("form#orderSheetForm").submit();
                                    } else {
                                        var errorMessages = data.errorMessages;
                                        alert(errorMessages.join("\n"));
                                        location.href = "http://www.hottracks.co.kr/ht/order/cart";
                                    }
                                },error: function(xhr, status, error) {
                                    alert("<fmt:message key='error.common.system'/>");
                                    location.href = "http://www.hottracks.co.kr/ht/order/cart";
                                }
                            });
                        } else if (mainPaySel == 3) {
                            // 휴대폰 결제 모빌리언스
                        	alert("테스트서버에서는 예치금 결제만 가능합니다.");
                        	location.reload(true);
                        } else if (mainPaySel == 6) {
                            // 네이버 N 페이
                        	alert("테스트서버에서는 예치금 결제만 가능합니다.");
                        	location.reload(true);
                        } else if (mainPaySel == 9) {
                            // 스마일 페이
                        	alert("테스트서버에서는 예치금 결제만 가능합니다.");
                        	location.reload(true);
                        }  else if (mainPaySel == 8) {
                            // 직카카오 페이
                        	alert("테스트서버에서는 예치금 결제만 가능합니다.");
                        	location.reload(true);
                        } else {
                            // 나이스 신용카드, 실시간, 무통장
                        	alert("테스트서버에서는 예치금 결제만 가능합니다.");
                        	location.reload(true);
                        }
                        
                        /* 
                        else{
                            $("form#orderSheetForm").find("input[name=orderNum]").val(orderNum);
                            $("form#orderSheetForm").find("input[name=prdtName]").val(prdtName);
                            $("form#orderSheetForm").ajaxSubmit({
                                url: "/ht/order/payRequest"
                               ,dataType: "html"
                               ,success : function(htmlStr){
                                   $("#payReqDiv").empty();
                                   $("#payReqDiv").append(htmlStr);
                                   launchCrossPlatform();
                               }
                               ,error: function(data) {
                                   alert('<fmt:message key="error.common.system"/>');
                               }
                            });

                        }
                        */
                    } else {
                        var errorMessages = data.errorMessages;
                        alert(errorMessages.join("\n"));
                    }
                }
                ,error: function(xhr, status, error) {
                    alert("<fmt:message key='error.common.system'/>");
                }
            });
        }
    });
    
    <%-- 마일리지 전체사용 체크 이벤트 --%>
    $("form#orderSheetForm input[name=allUseMileage]").change(function(){
        if($(this).is(":checked")) {
            var mileage = $("form#orderSheetForm input[name=userMileage]").val();
            var orderAmt = calculateOrderAmtExceptDiscountMethod("mileage");
            mileage = Math.floor(eval(mileage/10))*10;
            
            if(mileage == 0) {
                alert("사용 가능한 마일리지가 없습니다.");
                $("form#orderSheetForm input[name=allUseMileage]").attr("checked", false);
            } else {
                if(mileage > orderAmt) {
                    mileage = orderAmt;
                }
                $("form#orderSheetForm input[name=mileage]").val(mileage);
            }
        } else {
            $("form#orderSheetForm input[name=mileage]").val(0);
        }
        
        
        calculateDiscountPrice();
        calculateOrderAmt();
    });
    
    <%-- 통합포인트 전체사용 체크 이벤트 --%>
    $("form#orderSheetForm input[name=allUseTotMileage]").change(function(){
        if($(this).is(":checked")) {
            var totmileage = $("form#orderSheetForm input[name=userTotPoint]").val();
            var orderAmt = calculateOrderAmtExceptDiscountMethod("totmileage");
            totmileage = Math.floor(eval(totmileage/10))*10;
            
            if(totmileage == 0) {
                alert("사용 가능한 통합포인트가 없습니다.");
                $("form#orderSheetForm input[name=allUseTotMileage]").attr("checked", false);
            } else {
                if(totmileage > orderAmt) {
                    totmileage = orderAmt;
                }
                $("form#orderSheetForm input[name=totmileage]").val(totmileage);
            }
        } else {
            $("form#orderSheetForm input[name=totmileage]").val(0);
        }
        
        
        calculateDiscountPrice();
        calculateOrderAmt();
    });
    
     <%-- GSPoint 적립체크  --%>
    $("form#orderSheetForm input[name=gsPointSave]").click(function(){
        if ($("input[name=userGsCardNo]").val()=="") {
            alert("GS&Point 아이디/비밀번호를 조회 후 적용 가능합니다.");
            $("form#orderSheetForm input[name=gsPointSave]").attr("checked", false);
        }
    });
    
    <%-- OkPoint 적립체크  --%>
    $("form#orderSheetForm input[name=okPointSave]").click(function(){
        if ($("input[name=userokCardNo]").val()=="") {
            alert("OK캐쉬백  아이디/비밀번호를 조회 후 적용 가능합니다.");
            $("form#orderSheetForm input[name=okPointSave]").attr("checked", false);
        }
    });
    
    <%-- LPoint 적립체크  --%>
    $("form#orderSheetForm input[name=lPointSave]").click(function(){
        if ($("input[name=userlCardNo]").val()=="") {
            alert("L.POINT 카드번호/비밀번호를 조회 후 적용 가능합니다.");
            $("form#orderSheetForm input[name=lPointSave]").attr("checked", false);
        }
    });
    
    
    <%-- 예치금 전체사용 체크 이벤트 --%>
    $("form#orderSheetForm input[name=allUseDeposit]").change(function(){
        if($(this).is(":checked")) {
            var deposit = $("form#orderSheetForm input[name=userDeposit]").val();
            var orderAmt = calculateOrderAmtExceptDiscountMethod("deposit");
            
            if(deposit == 0) {
                alert("사용 가능한 예치금이 없습니다.");
                $("form#orderSheetForm input[name=allUseDeposit]").attr("checked", false);
            } else {
                if(deposit > orderAmt) {
                    deposit = orderAmt;
                }
                $("form#orderSheetForm input[name=deposit]").val(deposit);
            }    
        } else {
            $("form#orderSheetForm input[name=deposit]").val(0);
        }
        
        calculateDiscountPrice();
        calculateOrderAmt();
    });
    
    <%-- 예치금 입력시 사용 가능한 예치금 이상만 입력 가능하도록... --%>
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
            alert("사용 가능한 예치금은 " + price_format(usableDeposit) + "원 입니다.");
            $(this).val(usableDeposit);
        }
        
        calculateDiscountPrice();
        calculateOrderAmt();
    });
    
    <%-- 마일리지 입력시 사용 가능한 마일리지 이상만 입력 가능하도록... --%>
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
                alert("사용 가능한 마일리지는 " + price_format(usableMileage) + "원 입니다.");
                $(this).val(usableMileage);
            }
        } else {
            $(this).val(inputMileage);
        }
        
        calculateDiscountPrice();
        calculateOrderAmt();
    });
    
    <%-- 마일리지 입력시 사용 가능한 마일리지 이상만 입력 가능하도록... --%>
    $("form#orderSheetForm input[name=totmileage]").blur(function(){
        var usableTotMileage = Number($("form#orderSheetForm input[name=userTotPoint]").val());
        var inputTotMileage = Number(isEmpty($(this).val())? 0 : $(this).val());
        
        var orderAmt = calculateOrderAmtExceptDiscountMethod("totmileage");
        
        if(inputTotMileage > 0) {
            usableTotMileage = Math.floor(eval(usableTotMileage/10))*10;
            
            if(inputTotMileage % 10 != 0) {
                alert("마일리지는 10원단위로 사용 가능합니다.");
                inputTotMileage = Math.floor(eval(inputTotMileage/10))*10;
                $(this).val(inputTotMileage);
            }
            
            if(inputTotMileage > usableTotMileage || inputTotMileage > orderAmt) {
                if(usableTotMileage > orderAmt) {
                    usableTotMileage = orderAmt;
                }
                alert("사용 가능한 마일리지는 " + price_format(usableTotMileage) + "원 입니다.");
                $(this).val(usableTotMileage);
            }
        } else {
            $(this).val(inputTotMileage);
        }
        
        calculateDiscountPrice();
        calculateOrderAmt();
    });
    
    <%-- GS 포인트 사용액 처리 --%>
    $("form#orderSheetForm input[name=gsPointUse]").blur(function(){
        var userGsPoint = Number($("form#orderSheetForm input[name=userGsPoint]").val());
        var inputGsPoint = Number($(this).val());
        
        // 최소금액 1000원 최소단위 100원 기준
        if (inputGsPoint < 1000 && inputGsPoint != 0) {
            alert("최소사용액은 1,000원 입니다.");
            $(this).val(0);
            return;
        }
        inputGsPoint = Math.floor(inputGsPoint / 10) * 10;
        $(this).val(inputGsPoint);
        
        var orderAmt = calculateOrderAmtExceptDiscountMethod("gsPoint");
        
        if(isEmpty(inputGsPoint)) {
            $(this).val(0);
        } else if(inputGsPoint > userGsPoint || inputGsPoint > orderAmt) {
            if(userGsPoint > orderAmt) {
                userGsPoint = orderAmt;
            }
            alert("사용 가능한 포인트는 " + price_format(userGsPoint) + "원 입니다.");
            $(this).val(Math.floor(userGsPoint / 10) * 10);
        }
        
        calculateDiscountPrice();
        calculateOrderAmt();

    });
    
    <%-- L 포인트 사용액 처리 --%>
    $("form#orderSheetForm input[name=lPointUse]").blur(function(){
        var userlPoint = Number($("form#orderSheetForm input[name=userlPoint]").val());
        var inputlPoint = Number($(this).val());
        
        if (Math.floor(inputlPoint / 10) * 10 != inputlPoint) {
            alert("제휴포인트는 10원 단위로 사용 가능합니다.");
        }
        
        // 최소단위 10원 기준
        inputlPoint = Math.floor(inputlPoint / 10) * 10;
        $(this).val(inputlPoint);
        
        var orderAmt = calculateOrderAmtExceptDiscountMethod("lPoint");
        
        if(isEmpty(inputlPoint)) {
            $(this).val(0);
        } else if(inputlPoint > userlPoint || inputlPoint > orderAmt) {
            if(userlPoint > orderAmt) {
                userlPoint = orderAmt;
            }
            alert("사용 가능한 포인트는 " + price_format(userlPoint) + "원 입니다.");
            $(this).val(Math.floor(userlPoint / 10) * 10);
        }
        
        calculateDiscountPrice();
        calculateOrderAmt();

    });
    
    // 제휴할인 선택 창 표시
    $("input[name=allyCash]").change(function(){
        allyCashInit();  // 제휴선택값 초기화
        $(this).attr("checked", true);
        $(".allyContent").hide();
        $(this).next().next().show();
    });
    
    // 제휴할인 선택 창 닫기
    $(".allyContent .btn_close a").click(function(event){
        event.preventDefault(); // # 링크 이동 중지
        
        allyCashInit();  // 제휴선택값 초기화
        $(".chkallyCash").attr("checked", false);
        $(".allyContent").hide();
    });
    
    
    // 제휴할인 선택 창 닫기
    $(".allyContent .confirm").click(function(event){
        event.preventDefault(); // # 링크 이동 중지
        
        var allyContent = $(this).parents(".allyContent");
        if(!allyContent.find("input.savePoint").is(":checked") && (allyContent.find("input.usePoint").val() == 0 || isEmpty(allyContent.find("input.usePoint").val()))){
            alert("사용 포인트 또는 적립 신청 중 최소 한 개 이상 이루어 져야 합니다.");
        }else{
            // allyCashInit();  // 제휴선택값 초기화
            $(".allyContent").hide();
        }
    });
    
    <%-- Ok 포인트 사용액 처리 --%>
    $("form#orderSheetForm input[name=okPointUse]").blur(function(){
        var userokPoint = Number($("form#orderSheetForm input[name=userokPoint]").val());
        var inputokPoint = Number($(this).val());
        
        // 최소금액 1000원 최소단위 100원 기준
        if (inputokPoint <= 10) {
            alert("최소사용액은 10원 입니다.");
            $(this).val(0);
            return;
        }
        inputokPoint = Math.floor(inputokPoint / 10) * 10;
        $(this).val(inputokPoint);
        
        var orderAmt = calculateOrderAmtExceptDiscountMethod("okPoint");
        
        if(isEmpty(inputokPoint)) {
            $(this).val(0);
        } else if(inputokPoint > userokPoint || inputokPoint > orderAmt) {
            if(userokPoint > orderAmt) {
                userokPoint = orderAmt;
            }
            alert("사용 가능한 포인트는 " + price_format(userokPoint) + "원 입니다.");
            $(this).val(Math.floor(userokPoint / 10) * 10);
        }
        
        calculateDiscountPrice();
        calculateOrderAmt();
    });
});

<%-- 우편번호 찾기 콜백 함수 --%>
function callbackZipcode(address, zipcode) {
    $("input[name=receiverAddress]").val(address);
    $("input[name=receiverPostNum1]").val(zipcode.substring(0,3));
    $("input[name=receiverPostNum2]").val(zipcode.substring(4,7));
}

<%-- 도로명 주소 콜백 함수 --%>
function callbackRoadCode(zipcode, address1, address2, address3, address4 ) {
    $("input[name=receiverAddress]").val(address1);
    $("input[name=receiverPostNum1]").val(zipcode.substring(0,3));
    $("input[name=receiverPostNum2]").val(zipcode.substring(4,7));
    $("input[name=receiverDetailAddress3]").val(address2);
    $("input[name=receiverDetailAddress4]").val(address3);
    document.getElementById("receiverDetailAddressView3").innerHTML = address2;
    document.getElementById("receiverDetailAddressView4").innerHTML = address3;
    
}

<%-- 쿠폰적용 --%>
function applyCoupon(totalCpnDscntPrice, couponInfoList, dlvyCouponInfoList, orderCouponInfo) {
    if(!isEmpty(totalCpnDscntPrice)) {
        $("input[name=cpnDscntPrice]").val(totalCpnDscntPrice);
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

<%-- 쿠폰팝업 --%>
function openCouponPopup() {
    if($("input[name=usableCpnCount]").val() != 0){
        window.open('', 'popupCouponList', 'width=670,height=720');
        $("form#orderSheetForm").attr("action", "/ht/order/popupCouponList");
        $("form#orderSheetForm").attr("target", "popupCouponList");
        $("form#orderSheetForm").submit();
    } else {
        alert("사용 가능하신 쿠폰이 없습니다.");
    }
}

<%-- 할인가격 계산 --%>
function calculateDiscountPrice() {
    var discountPrice = 0;
    var mileage = isEmpty($("input[name=mileage]").val())? 0 : Number($("input[name=mileage]").val());
    var deposit = isEmpty($("input[name=deposit]").val())? 0 : Number($("input[name=deposit]").val());
    var gsPoint = isEmpty($("input[name=gsPointUse]").val())? 0 : Number($("input[name=gsPointUse]").val());
    var totmileage = isEmpty($("input[name=totmileage]").val())? 0 : Number($("input[name=totmileage]").val());
    var okPoint = isEmpty($("input[name=okPointUse]").val())? 0 : Number($("input[name=okPointUse]").val());
    var lPoint = isEmpty($("input[name=lPointUse]").val())? 0 : Number($("input[name=lPointUse]").val());
    var cpnDscntPrice = isEmpty($("input[name=cpnDscntPrice]").val())? 0 : Number($("input[name=cpnDscntPrice]").val());
    discountPrice = eval(mileage + deposit + gsPoint + cpnDscntPrice + totmileage + okPoint + lPoint);
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
    $("#orderAmtBottom").html(price_format(orderAmt));
    
    // 결제금액에 따른 결제수단 처리
    if(orderAmt > 0) {
        $("input[name=pymntMeansCode]").attr("disabled", false);
        $("#paymentArea").show();
    } else {
        $("input[name=pymntMeansCode]").attr("disabled", true);
        $("#paymentArea").hide();
    }
    
    // 에스크로 영역처리
    checkEscrow();
}

<%-- 결제금액 계산(특정 할인수단 제외하고 계산) --%>
function calculateOrderAmtExceptDiscountMethod(exceptDiscountMethod) {
    var totalPrdtAmt = isEmpty($("input[name=totalPrdtAmt]").val())? 0 : Number($("input[name=totalPrdtAmt]").val());
    var totalDlvyAmt = isEmpty($("input[name=totalDlvyAmt]").val())? 0 : Number($("input[name=totalDlvyAmt]").val());
    
    var mileage = isEmpty($("input[name=mileage]").val())? 0 : Number($("input[name=mileage]").val());
    var deposit = isEmpty($("input[name=deposit]").val())? 0 : Number($("input[name=deposit]").val());
    var gsPoint = isEmpty($("input[name=gsPointUse]").val())? 0 : Number($("input[name=gsPointUse]").val());
    var totPoint = isEmpty($("input[name=totmileage]").val())? 0 : Number($("input[name=totmileage]").val());
    var okPoint = isEmpty($("input[name=okPointUse]").val())? 0 : Number($("input[name=okPointUse]").val());
    var lPoint = isEmpty($("input[name=lPointUse]").val())? 0 : Number($("input[name=lPointUse]").val());
    
    var cpnDscntPrice = isEmpty($("input[name=cpnDscntPrice]").val())? 0 : Number($("input[name=cpnDscntPrice]").val());
    var discountPrice = 0;
    
     if(exceptDiscountMethod == "deposit") {
        discountPrice = cpnDscntPrice + mileage + gsPoint + totPoint + okPoint + lPoint;
    } else if(exceptDiscountMethod == "mileage") {
        discountPrice = cpnDscntPrice + deposit + gsPoint + totPoint + okPoint + lPoint;
    } else if(exceptDiscountMethod == "gsPoint") {
        discountPrice = cpnDscntPrice + mileage + deposit + totPoint + okPoint + lPoint;
    } else if(exceptDiscountMethod == "totmileage") {
        discountPrice = cpnDscntPrice + mileage + deposit + gsPoint + okPoint + lPoint;
    } else if(exceptDiscountMethod == "okPoint") {
        discountPrice = cpnDscntPrice + mileage + deposit + gsPoint + totPoint + lPoint;
    } else if(exceptDiscountMethod == "lPoint") {
        discountPrice = cpnDscntPrice + mileage + deposit + gsPoint + totPoint + okPoint;
    }
    
    
    return eval(totalPrdtAmt + totalDlvyAmt - discountPrice);
}

<%-- 에스크로 영역 처리 --%>
function checkEscrow() {
    var pymntMeansCode = $("input[name=pymntMeansCode]:checked").val();
    var orderAmt = isEmpty($("input[name=orderAmt]").val())? 0 : Number($("input[name=orderAmt]").val());
    
    var escrowStdAmt = Number("${escrowStdAmt}");
    if(pymntMeansCode == "C0112" && orderAmt >= escrowStdAmt) {
        $("#escrowUseYnArea").css("display", "");
        $("#escrowUseYn").attr("disabled", false);
        $("#escrowUseYn").attr("checked", false);
    } else {
        $("#escrowUseYnArea").css("display", "none");
        $("#escrowUseYn").attr("disabled", true);
        $("#escrowUseYn").attr("checked", false);
    }
}

<%-- 결제수단 카드 선택시 아래 설명부분 카드별로 바뀌게 하기위한 함수 --%>
function card_Open(E) {
    $('#card_box div').removeClass('txt_box_on');
    var divName = '#card_box0' + E; 
    $(divName).addClass('txt_box_on');
}

<%-- 주문 faq --%>
function goOrderFaq() {
    var openNewWindow = window.open("about:blank");
    openNewWindow.location.href = "${defaultHost}/ht/help/faqListC0391";
}

function gsPointSearch() {
    if ($("input[name=gsIdInput]").val().replace(/(^\s*)|(\s*$)/gi,"") == "") {alert("GS 아이디를 입력해야 합니다.");return;}
    if ($("input[name=gsPwInput]").val().replace(/(^\s*)|(\s*$)/gi,"") == "") {alert("비밀번호를 입력해야 합니다.");return;}
    
    $("input[name=gsId]").val($("input[name=gsIdInput]").val().replace(/(^\s*)|(\s*$)/gi,""));
    $("input[name=gsPw]").val($("input[name=gsPwInput]").val().replace(/(^\s*)|(\s*$)/gi,""));
    
    $("form#gsPoint").ajaxSubmit({
        url: "/ht/order/gsPointSearch"
        ,dataType: "json"
        ,success: function checkSuccess(data) {
            if (data.result.result =="00000") {
                document.getElementById("gsGetPoint").innerHTML = data.result.gsPoint + "P";
                $("input[name=userGsPoint]").val(data.result.gsPoint);
                $("input[name=userGsCardNo]").val(data.result.gsCardNum);
            } else {
                alert(data.result.remark);
            }
        }
        ,error: function(xhr, status, error) {
            alert("<fmt:message key='error.common.system'/>");
        }
    });
}

<%-- L Point 조회 --%>
function fnLPointSearch() {
    if ($("input[name=lCardInput]").val().replace(/(^\s*)|(\s*$)/gi,"") == "") {alert("L Point 카드번호를 입력해야 합니다.");return;}
    if ($("input[name=lPwInput]").val().replace(/(^\s*)|(\s*$)/gi,"") == "") {alert("비밀번호를 입력해야 합니다.");return;}
    
    $("input[name=lCard]").val($("input[name=lCardInput]").val().replace(/(^\s*)|(\s*$)/gi,""));
    $("input[name=lPw]").val($("input[name=lPwInput]").val().replace(/(^\s*)|(\s*$)/gi,""));
    
    $("form#lPoint").ajaxSubmit({
        url: "/ht/order/lPointSearch"
        ,dataType: "json"
        ,success: function checkSuccess(data) {
            if (data.result.rspC =="0") {
                document.getElementById("lGetPoint").innerHTML = data.result.avlPt + "P";
                $("input[name=userlPoint]").val(data.result.avlPt);
                $("input[name=userlCardNo]").val(data.result.lCard);
                $("input[name=userlPw]").val(data.result.lPw);
            } else {
                alert(data.result.rspMsgCn);
            }
        }
        ,error: function(xhr, status, error) {
            alert("<fmt:message key='error.common.system'/>");
        }
    });
}

<%-- Ok Point 조회 --%>
function okPointSearch() {
    if ($("input[name=okIdInput]").val().replace(/(^\s*)|(\s*$)/gi,"") == "") {alert("카드번호를 입력해야 합니다.");return;}
    if ($("input[name=okPwInput]").val().replace(/(^\s*)|(\s*$)/gi,"") == "") {alert("비밀번호를 입력해야 합니다.");return;}
    
    $("input[name=okId]").val($("input[name=okIdInput]").val().replace(/(^\s*)|(\s*$)/gi,""));
    $("input[name=okPw]").val($("input[name=okPwInput]").val().replace(/(^\s*)|(\s*$)/gi,""));
    
    $("form#okPoint").ajaxSubmit({
        url: "/ht/order/okPointSearch"
        ,dataType: "json"
        ,success: function checkSuccess(data) {
            if (data.result.sReplyCode =="000000") {
                document.getElementById("okGetPoint").innerHTML = data.result.sAvPoint + "P";
                $("input[name=userokPoint]").val(data.result.sAvPoint);
                $("input[name=userokCardNo]").val($("input[name=okId]").val());
                $("input[name=userokCardPw]").val($("input[name=okPw]").val());
            } else {
                alert(data.result.sReplyMessage);
            }
        }
        ,error: function(xhr, status, error) {
            alert("<fmt:message key='error.common.system'/>");
        }
    });
}

function hidePreOrderLayer(){
    $("#preOrderLayer").hide();
}

function getCookie(name){
    var Found = false;
    var start, end;
    var i = 0;

    while(i <= document.cookie.length) {
        start = i;
        end = start + name.length;
        if(document.cookie.substring(start, end) == name) {
            Found = true;
            break;
        }
        i++;
    }

    if(Found == true) {
        start = end + 1;
        end = document.cookie.indexOf(";", start);
        if(end < start)    end = document.cookie.length;
        return document.cookie.substring(start, end);
    }
    return "";
} 

function toggleLayer(target){
    $("#" + target).toggle();
}

<%-- 쿠폰팝업시 주문 체크 오류 장바구니페이지 이동 --%>
function cartPageGo() {
    location.href = "http://www.hottracks.co.kr/ht/order/cart";
}

function allyCashInit() {
    // GS 초기화
    $("input[name=userGsPoint]").val("");
    $("input[name=userGsCardNo]").val("");
    $("input[name=gsPointUse]").val("0");
    document.getElementById("gsGetPoint").innerHTML = "0P";
    $("form#orderSheetForm input[name=gsPointSave]").attr("checked", false);
    
    // Ok 초기화
    $("input[name=userokPoint]").val("");
    $("input[name=userokCardNo]").val("");
    $("input[name=okPointUse]").val("0");
    document.getElementById("okGetPoint").innerHTML = "0P";
    $("form#orderSheetForm input[name=okPointSave]").attr("checked", false);
    
    // L 초기화
    $("input[name=userlPoint]").val("");
    $("input[name=userlCardNo]").val("");
    $("input[name=lPointUse]").val("0");
    document.getElementById("lGetPoint").innerHTML = "0P";
    $("form#orderSheetForm input[name=lPointSave]").attr("checked", false);
    
    calculateDiscountPrice();
    calculateOrderAmt();
}

function payinit() {
    var browerName   =navigator.appName;
    var browerAgent  = navigator.userAgent;
    var browserVer = 0 ; // 브라우저  버전정보 
    var browerType   =""; // 브라우져 종류
    //alert("browerName:" + browerName + "/browerAgent:" + browerAgent);
    
    // 브라우져 종류 설정.
    if(browerName.charAt(0) == "M"){ 
        browerType="MSIE";
        broType = "Ex";
    }else if(browerName.charAt(0) == "N"){
        if(browerAgent.indexOf("Chrome") != -1){
            browerType="Chrome";
            broType = "Ch";
        }else if(browerAgent.indexOf("Firefox") != -1){
            browerType="Firefox";
            broType = "Fi";
        }else if(browerAgent.indexOf("Mobile Safari") != -1){
            browerType="Mobile Safari";
            broType = "Sa";
        }else if(browerAgent.indexOf("Safari") != -1){
            browerType="Safari";
            broType = "Sa";
        } else {
            broType = "Ex";
        }
    } else {
        browserVer = "??";
        broType = "??";
    }
    
    /* if (browerType == "Chrome") {
        $(".payPhone").hide();
    } */
    
}
</script>


<script type="text/javascript">

    /**
    cnspay  를 통해 결제를 시작합니다.
    */
    function cnspay() {
	    // 결과코드가 00(정상처리되었습니다.)
	    if(document.payForm.resultCode.value == '00') {
	        XD.receiveMessage( smilepay_callback, "https://pg.cnspay.co.kr" );
	        var left = ($(window).width() - 950)/2*-1;
	        var top = ($(window).height() - 200)/2*-1;
	        $("#payReqDiv").css({position:"absolute",left:left,top:top});
	        cnspay_L.callPage("smilePay_layer", eval(false), smilepay_callback);
	    } else {
	        alert('[RESULT_CODE] : ' + document.payForm.resultCode.value + '\n[RESULT_MSG] : ' + document.payForm.resultMsg.value);
	        location.href = "/ht/order/cart";
	    }
    }
    
    //smilepay 결제버튼 완료 후 호출되는 콜백
    var replaceUrl = "${defaultHost}/ht/order/orderComplete";
    //var replaceUrl = "/ht/order/orderComplete";    
    var smilepay_callback = function (message){
        cnspay_L.destroy();
        
        if(message !=null && message.data != null && message.data != "null"){
            var obj = JSON.parse(message.data);  
            document.getElementsByName('SPU')[0].value = obj.SPU;
            document.getElementsByName('SPU_SIGN_TOKEN')[0].value = obj.SPU_SIGN_TOKEN;
            
            var html = $("form#orderInfoForm").html(); 
            $("form#payForm").append(html);
            // 매뉴얼 참조하여 부인방지코드값 관리
            $("form#payForm").ajaxSubmit({
                url: "/ht/order/payResponse"
                ,dataType: "json"
                ,success: function saveSuccess(data) {
                    if (data.save) {
                        parent.location.replace(replaceUrl);
                    } else {
                        var errorMessages = data.errorMessages;
                        alert(errorMessages.join("\n"));
                        parent.location.href = "${defaultHost}/ht/order/cart";
                        //parent.location.href = "/ht/order/cart";
                    }
                }
                ,error: function(xhr, status, error) {
                    alert("<fmt:message key='error.common.system'/>");
                    parent.location.href = "${defaultHost}/ht/order/cart";
                    //parent.location.href = "/ht/order/cart";
                }
            });
        }else{
            alert("결제가 취소되었습니다.");
            parent.location.href = "${defaultHost}/ht/order/cart";
        }       
    }
    
</script>

<!-- 다음 우편번호API -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

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

                $('[name=receiverAddress]').val(addr);
                $('[name=addr1]').val(addr);
                
                $('[name=receiverPostNum1]').val(data.zonecode.substring(0,3));
                $('[name=receiverPostNum2]').val(data.zonecode.substring(3,6));
                $('[name=postNum1]').val(data.zonecode.substring(0,3));
                $('[name=postNum2]').val(data.zonecode.substring(3,6));
                
                $('[name=receiverDetailAddress]').focus();
            }
        }).open();
    }
</script>
<!-- // 다음 우편번호API -->

<style type="text/css">
.allyCash {
    position: relative;
}
.allyCash li {
    float: left;
    padding: 5px 10px;
}
.allyCash li.txt_list {
    padding: 5px 10px 5px 0px;
}
.allyCash li .allyContent {
    display: none;
    position: absolute;
    top: 26px;
    left: 0;
    width: 635px;
    min-height: 187px;
    border: 1px solid #000;
    background-color: #FFF;
    margin-top: 10px;
    z-index: 99;
}
.allyCash li .allyContent h5 {
    background-color: #000;
    color: #FFF;
    padding: 10px;
}
.allyCash li .allyContent h5 .btn_close {
    position: absolute;
    right: 0px;
    top: 0px;
}
.allyCash li .allyContent .inner-table {
    width: 300px;
    float: left;
}
.allyCash li .allyContent .point-info {
    padding: 10px;
    float: right;
    width: 314px;
    border-left: 1px solid #dbdbdb;
    height:220px;
    color: #777;
}
.allyCash li .allyContent .point-info li {
    text-indent: -10px;
}
.allyCash li .allyContent .point-info .point-site {
    text-indent: 0;
}
.allyCash li .allyContent .point-info .point-site a {
    color: #000;
}
.allyCash li .allyContent .confirm {
	display: block;
	margin: 10px auto;
	font-size: 18px;
    width: 133px;
}
.help_box {
    padding: 15px;
    border: 1px solid #dbdbdb;
    font-size: 12px;
    background: #f5f5f1;
    line-height: 18px;
}
.order_list h3 {margin-top:30px;}
#slideToggle_a .order_list h3 {margin-top:50px;}

#paymentArea .evt_tag {
    position: absolute;
    left: 553px;
    margin-top: 37px;
}
#paymentArea .evt_tag img{
    width: auto;
    height: 20px;
}
_:-ms-fullscreen, :root #paymentArea .evt_tag {
    position: absolute;
    left: 543px;
    margin-top: 39px;
}
</style>
</head>
<body>
<!-- sub top -->
<div class="title_a">
    <h2 class="title">주문결제</h2>
</div>
<!-- / sub top -->

<%--<div class="order_sum">
        <div class="top">
            총 주문수량 : <span class="bold">${cartProductSum.sumOfProductClassCount}종 (${cartProductSum.sumOfOrderCount}개)</span> <span class="line">|</span>
            총 상품금액 : <span class="bold"><fmt:formatNumber value="${cartProductSum.totalPrdtAmt}"/></span>원 <span class="line">|</span>
            총 배송비 : <span class="bold"><fmt:formatNumber value="${cartProductSum.totalDlvyAmt}"/></span>원
        </div>
        <div class="sum_point">
    		통합포인트 적립 : <span class="bold"><c:if test="${isLogin && userProperty.gradeId != '99'}"><fmt:formatNumber value="${cartProductSum.totalSavedPrice}"/></c:if><c:if test="${!isLogin || userProperty.gradeId == '99'}">0</c:if></span>원 
    	</div>
        <div class="sum_price">
            주문합계: <strong><fmt:formatNumber value="${cartProductSum.totalOrderAmt}"/></strong>원
        </div>
</div>--%>

<div class="title_box mgt40">
    <h3 class="tit01_v2 f_left">주문자 정보</h3>
</div>
<form id="orderSheetForm" action="#" method="post">
    <input type="hidden" name="linkTmsYn" value=""/>
    <input type="hidden" name="orderNum" value=""/>
    <input type="hidden" name="prdtName" value=""/>
    <input type="hidden" name="productClassCount" value="${cartProductSum.sumOfProductClassCount}"/>
    <input type="hidden" name="orderCount" value="${cartProductSum.sumOfOrderCount}"/>
   <input type="hidden" name="orderAmt" value="${cartProductSum.totalOrderAmt}"/>
    <table class="table02_v1">
        <caption>주문자 정보 상세</caption>
        <colgroup>
            <col style="width:12%">
            <col style="width:30%">
			<col style="width:*%">
            <col style="width:12%">
            <col style="width:45%">
        </colgroup>
        <tbody>
            <tr>
                <th scope="row"><label for="buyerName">이름<span class="s_point">&#42;</span></label></th>
                <td><input type="text" name="buyerName" id="buyerName" value="${loginUser.name}" maxlength="30" class="input_txt" title="주문자명" style="width:162px;"/></td>
                <td></td>
                <th scope="row"><label for="buyerEmail1">이메일<span class="s_point">&#42;</span></label></th>
                <td>
                    <input type="text" name="buyerEmail1" value="${fn:split(loginUser.userAddress.emailAddr, '@')[0]}" id="buyerEmail1" maxlength="30" class="input_txt" title="이메일 아이디 입력" style="width:110px;"/><span class="c_gray"> @ </span>
                    <input type="text" name="buyerEmail2" value="${fn:split(loginUser.userAddress.emailAddr, '@')[1]}" id="buyerEmail2" maxlength="30" class="input_txt email2" title="이메일 회사 입력" style="width:110px;"/>
                    <select name="emailSelect" class="select" title="이메일 회사 선택" >
                        <option value="">직접입력</option>
                        <option value="naver.com">naver.com</option>
                        <option value="hanmail.net">hanmail.net</option>
                        <option value="hotmail.com">hotmail.com</option>
                        <option value="nate.com">nate.com</option>
                        <option value="yahoo.co.kr">yahoo.co.kr</option>
                        <option value="empas.com">empas.com</option>
                        <option value="dreamwiz.com">dreamwiz.com</option>
                        <option value="freechal.com">freechal.com</option>
                        <option value="lycos.co.kr">lycos.co.kr</option>
                        <option value="korea.com">korea.com</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="hanmir.com">hanmir.com</option>
                        <option value="paran.com">paran.com</option>
                    </select>
                </td>
            </tr>
            <tr>
            <th scope="row">휴대폰<span class="s_point">&#42;</span></th>
                <td>
                    <input type="text" name="handPhone1" class="input_txt inputNumberText" maxlength="4" value="${fn:split(loginUser.userAddress.handPhoneNum, '-')[0]}" title="휴대폰 지역번호 입력" style="width:40px;ime-mode:disabled;" /><span class="c_ccc"> - </span>
                    <input type="text" name="handPhone2" class="input_txt inputNumberText" maxlength="4" value="${fn:split(loginUser.userAddress.handPhoneNum, '-')[1]}" title="휴대폰 중간자리 입력" style="width:40px;ime-mode:disabled;" /><span class="c_ccc"> - </span>
                    <input type="text" name="handPhone3" class="input_txt inputNumberText" maxlength="4" value="${fn:split(loginUser.userAddress.handPhoneNum, '-')[2]}" title="휴대폰 뒷자리 입력" style="width:40px;ime-mode:disabled;" />
                </td>
                <td></td>
                <th scope="row">전화번호</th>
                <td>
                    <input type="text" name="telephone1" class="input_txt inputNumberText" maxlength="4" value="${fn:split(loginUser.userAddress.telNum, '-')[0]}" title="전화번호 지역번호 입력" style="width:40px;ime-mode:disabled;" /><span class="c_ccc"> - </span>
                    <input type="text" name="telephone2" class="input_txt inputNumberText" maxlength="4" value="${fn:split(loginUser.userAddress.telNum, '-')[1]}" title="전화번호 중간자리 입력" style="width:40px;ime-mode:disabled;" /><span class="c_ccc"> - </span>
                    <input type="text" name="telephone3" class="input_txt inputNumberText" maxlength="4" value="${fn:split(loginUser.userAddress.telNum, '-')[2]}" title="전화번호 뒷자리 입력" style="width:40px;ime-mode:disabled;" />
                </td>
            </tr>
            <tr>
                <th scope="row">SMS수신</th>
                <td colspan="4">
                    <span><input type="radio" name="orderInfoSmsYn" id="orderInfoSmsY" value="Y" checked="checked" /> <label for="orderInfoSmsY">주문배송정보 수신</label></span>
                    <span class="mgl10"><input type="radio" name="orderInfoSmsYn" id="orderInfoSmsN" value="N" /> <label for="orderInfoSmsN">수신하지 않음</label></span>
                </td>
            </tr>
        </tbody>
    </table>
    
    <ul class="list_type02_v2 mgt10">
	    <li class="c_black"><span class="s_point">&#42;</span>표시는 필수 입력 항목입니다.</li>
	    <li>주문자 정보를 수정해도 회원정보는 변경되지 않습니다. </li>
	    <li>회원정보 변경은 '교보문고 &gt; 마이룸 &gt; 회원정보수정'에서 가능합니다.</li>
    </ul>
    
    <div class="title_box mgt40">
        <h3 class="tit01_v2 f_left">배송지 정보</h3>
        <div class="f_left fs14" style="margin-left:39px;">
            <span><input name="dlvyInfoSelect" id="dlvyInfoSelect1" type="radio" value="01" class="radios"/><label for="dlvyInfoSelect1" style="margin-left:5px;">주문자 정보</label></span>
            <span class="mgl10"><input name="dlvyInfoSelect" id="dlvyInfoSelect2" type="radio" value="02" class="radios"/><label for="dlvyInfoSelect2" style="margin-left:5px;">새로운 주소</label></span>
        </div>
    </div>
    <table class="table02_v1" id="receiverInfotable">
        <caption>배송지 정보 상세</caption>
        <colgroup>
            <col style="width:12%">
            <col style="width:30%">
			<col style="width:*%">
            <col style="width:12%">
            <col style="width:45%">
        </colgroup>
        <tbody>
            <tr>
                <th scope="row">이름<span class="s_point">&#42;</span></th>
                <td><input type="text" name="receiverName" maxlength="30" class="input_txt" title="수령인명" style="width:162px;"/></td>
                <td></td>
                <th scope="row">이메일<span class="s_point">&#42;</span></th>
                <td>
                    <input type="text" name="receiverEmail1" maxlength="30" class="input_txt" title="수령인 이메일 아이디 입력" style="width:110px;"/><span class="c_gray"> @ </span>
                    <input type="text" name="receiverEmail2" class="input_txt email2" title="수령인 이메일 서버 입력" style="width:110px;"/>
                    <select name="emailSelect" class="select" title="수령인 이메일 서버 선택">
                        <option value="">직접입력</option>
                        <option value="naver.com">naver.com</option>
                        <option value="hanmail.net">hanmail.net</option>
                        <option value="hotmail.com">hotmail.com</option>
                        <option value="nate.com">nate.com</option>
                        <option value="yahoo.co.kr">yahoo.co.kr</option>
                        <option value="empas.com">empas.com</option>
                        <option value="dreamwiz.com">dreamwiz.com</option>
                        <option value="freechal.com">freechal.com</option>
                        <option value="lycos.co.kr">lycos.co.kr</option>
                        <option value="korea.com">korea.com</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="hanmir.com">hanmir.com</option>
                        <option value="paran.com">paran.com</option>
                    </select>
                </td>
            </tr>
            <tr>
            	<th scope="row">휴대폰<span class="s_point">&#42;</span></th>
                <td>
                    <input type="text" name="receiverHandPhone1" class="input_txt inputNumberText" maxlength="4" title="수령인 휴대폰 지역번호 입력" style="width:40px;ime-mode:disabled;" /><span class="c_ccc"> - </span>
                    <input type="text" name="receiverHandPhone2" class="input_txt inputNumberText" maxlength="4" title="수령인 휴대폰 중간자리 입력" style="width:40px;ime-mode:disabled;" /><span class="c_ccc"> - </span>
                    <input type="text" name="receiverHandPhone3" class="input_txt inputNumberText" maxlength="4" title="수령인 휴대폰 뒷자리 입력" style="width:40px;ime-mode:disabled;" />
                </td>
                <td></td>
                <th scope="row">전화번호</th>
                <td>
                    <input type="text" name="receiverTelePhone1" class="input_txt inputNumberText" maxlength="4" title="수령인 전화번호 지역번호 입력" style="width:40px;ime-mode:disabled;" /><span class="c_ccc"> - </span>
                    <input type="text" name="receiverTelePhone2" class="input_txt inputNumberText" maxlength="4" title="수령인 전화번호 중간자리 입력" style="width:40px;ime-mode:disabled;" /><span class="c_ccc"> - </span>
                    <input type="text" name="receiverTelePhone3" class="input_txt inputNumberText" maxlength="4" title="수령인 전화번호 뒷자리 입력" style="width:40px;ime-mode:disabled;" />
                </td>
            </tr>
            <tr>
                <th scope="row">주소<span class="s_point">&#42;</span></th>
                <td colspan="4">
                    <c:if test="${isLogin}">
                        <input type="hidden" name="addr1" value="${loginUser.userAddress.addr1}" class="userInfo"/>
                        <input type="hidden" name="addr2" value="${loginUser.userAddress.addr2}" class="userInfo"/>
                        <input type="hidden" name="postNum1" value="${loginUser.userAddress.postNum1}" class="userInfo"/>
                        <input type="hidden" name="postNum2" value="${loginUser.userAddress.postNum2}" class="userInfo"/>
                    </c:if>
                    <input type="text" class="input_txt" name="receiverPostNum1" readonly="readonly" title="수령인 우편번호 앞자리" style="width:40px;" /><span class="c_ccc"> - </span>
                    <input type="text" class="input_txt" name="receiverPostNum2" readonly="readonly" title="수령인 우편번호 뒷자리" style="width:40px;" />
                    <a href="javascript://" onclick="execDaumPostcode()" class="btn_type01_v2" style="margin-left:2px; width:73px;">우편번호 검색</a>
                    <div class="br">
                        <input name="receiverAddress" type="text" class="input_txt" title="수령인 기본주소" readonly="readonly" style="width:201px;" />
                        <input name="receiverDetailAddress" maxlength="50" type="text" class="input_txt" title="수령인 상세주소" style="width:201px;" />
                        <span id="receiverDetailAddressView3" name="receiverDetailAddressView3"></span>
                        <span id="receiverDetailAddressView4" name="receiverDetailAddressView4"></span>
                        <input name="receiverDetailAddress3" maxlength="50" type="hidden" class="input_txt" title="수령인 상세주소" style="width:188px;" />
                        <input name="receiverDetailAddress4" maxlength="50" type="hidden" class="input_txt" title="수령인 상세주소" style="width:188px;" />
                    </div>
                </td>
            </tr>
            <%--<tr>
                <th>전달메시지</th>
                <td colspan="3">
                    <input name="giftMessage" maxlength="100" type="text" class="input_txt userInfo" title="전달메시지 입력" style="width:90%;" />
                </td>
            </tr>--%>
            <tr>
                <th>주문 요청사항</th>
                <td colspan="4">
                    <input placeholder="상품 주문 시 업체에게 전달되는 메시지입니다. 요청사항을 입력해주세요." name="orderMessage" maxlength="100" type="text" class="input_txt userInfo" title="주문 요청사항 입력" style="width:781px;"/>
                </td>
            </tr>
            <tr>
                <th>배송 요청사항</th>
                <td colspan="4">
                    <input placeholder="택배 배송 시 요청사항을 입력해주세요." name="deliveryMessage" maxlength="100" type="text" class="input_txt userInfo" title="배송 요청사항 입력" style="width:781px;"/>
                </td>
            </tr>
            <c:if test="${!isLogin}">
                <tr>
                    <th>비밀번호<span class="s_point">&#42;</span></th>
                    <td colspan="3">
                        <input placeholder="비회원 주문 시 비밀번호 숫자 4자리를 입력해주세요. (필수)" name="password" maxlength="4" type="password" class="input_txt inputNumberText" title="비밀번호 입력" style="width:94%;" />
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>
    
    <ul class="list_type02_v2 mgt10">
	    <li class="c_black"><span class="s_point">&#42;</span>표시는 필수 입력 항목입니다.</li>
    </ul>
    
    <h2 class="tit01_v2 mgt50 fs18 bb_line">주문 상품 / 총 ${cartProductSum.sumOfOrderCount}개</h2>
    
    <!-- 주문상품 2개 이상은 접힘 -->
    <c:set var="cartListlength" value="${fn:length(cartList)}"/>
    <c:set value="no" var="preOrderProduct" />
    <c:forEach items="${cartList}" var="cart" varStatus="i">
    <div class="order_list">
    <h3 class="tit01_v2">${cart.dlvyVndrId eq '0625'?'핫트랙스':'업체개별'} 배송</h3>
    <table class="bbs_list_v2">
        <caption>${cart.dlvyVndrId eq '0625'?'핫트랙스':'업체개별'} 배송<span>상품코드, 상품, 상품명, 판매가, 수량, 가격, 통합포인트</span>
        </caption>
        <colgroup>
                <col style="width:11%">
                <col style="width:14%">
                <col style="width:35%">
                <col style="width:10%">                
                <col style="width:10%">
                <col style="width:10%">
                <col style="width:10%">
            </colgroup>
        <thead>
            <tr>
                <th scope="col">상품코드</th>
                <th scope="col">상품</th>
                <th scope="col">상품명</th>
                <th scope="col">판매가</th>
                <th scope="col">수량</th>
                <th scope="col">가격</th>
                <th scope="col">통합포인트</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <td colspan="7">
                		상품금액 <strong><fmt:formatNumber value="${cart.sellPriceSum}"/></strong>원 + 
                    	배송비 <strong><fmt:formatNumber value="${cart.dlvyAmtResult}"/></strong>원 =
                    <strong><fmt:formatNumber value="${cart.sellPriceSum + cart.dlvyAmtResult}"/></strong>원
                </td>
            </tr>
        </tfoot>
        <tbody>
            <c:forEach items="${cart.cartProductList}" var="product" varStatus="productStatus">
                <c:if test="${product.rcrdStat eq '9' }"><c:set value="ok" var="preOrderProduct" /></c:if>
                <tr>
                    <td>${product.primeSellPrdtBcode}</td>
                    <td>
                        <c:if test="${fn:contains('DR' ,product.sellPrdtGbn) }"><a href="${defaultHost}/ht/record/detail/${product.primeSellPrdtBcode}"><ui:image rcrdCd="${product.rcrdCd}" prdtGbn="${product.sellPrdtGbn}" clazz="photo" size="100" server="record"  alt="${product.prdtName}" ratingCode="${product.rtngCode }"  ssl="${serviceYn}"/></a></c:if>
                        <c:if test="${!fn:contains('DR' ,product.sellPrdtGbn) }"><a href="${defaultHost}/p/${product.primeSellPrdtBcode}"><ui:image src="${product.productImageUrl}" size="100" server="product" clazz="photo" alt="${product.prdtName}" ssl="${serviceYn}"/></a></c:if>
                    </td>
                    <td class="t_left">
                        <input type="hidden" name="prdtName" value="${product.prdtName}"/>
                        ${product.prdtName}
                        <c:if test="${product.sellPrdtGbn eq 'S'}"><p class="txt_option">${product.specName}</p></c:if>
                        <c:if test="${!empty product.optnList}">
                            <p class="txt_option"><c:forEach items="${product.optnList}" var="optn" varStatus="optnStatus">${optn}<span class="one_line"></span><c:if test="${fn:length(product.optnList) > optnStatus.count}"></c:if></c:forEach></span></p>
                        </c:if>
                        <c:if test="${product.cvslPrdtYn eq 'true'}">
                            <p class="txt_option">
                                <c:choose>
                                    <c:when test="${product.cvslPrice > 0}">유료각인 : ${product.cvslFont} ${product.cvslCont} ( + <fmt:formatNumber value="${product.cvslPrice}" pattern="#,###"/>)</c:when>
                                    <c:otherwise>무료각인 : ${product.cvslFont} ${product.cvslCont} ( + <fmt:formatNumber value="${product.cvslPrice}" pattern="#,###"/>)</c:otherwise>
                                </c:choose>
                            </p>
                        </c:if>
                        <c:if test="${product.orderMakeYn eq 'true'}">
                            <p class="txt_option">기타정보 : ${product.orderMakeCont}</p>
                        </c:if>
                    </td>
                    <td><fmt:formatNumber value="${product.sellPrice}" pattern="#,###"/>원<BR>[<fmt:formatNumber value="${(product.prdtSellPrice-product.sellPrice)/product.prdtSellPrice * 100}" pattern="#,###"/>%↓]</td>
                    <td>${product.prdtCount}</td>
                    <td><fmt:formatNumber value="${product.sumSellPrice}" pattern="#,###"/>원</td>
                    <td>
                        <c:if test="${isLogin && userProperty.gradeId != '99'}"><fmt:formatNumber value="${product.sumSavedPrice}" pattern="#,###"/>원</c:if>
                        <c:if test="${!isLogin || userProperty.gradeId == '99'}">0원</c:if>
                    </td>
                </tr>
                <c:if test="${!empty product.cartProductFreeGiftList || !empty product.cartProductSupplementList || !empty product.cartProductPosterCaseList}">
                    <tr> 
                        <td></td>
                        <td></td>
                        <td class="t_left">
                            <c:forEach items="${product.cartProductFreeGiftList}" var="productFreeGift">
                                <p class="pt5">사은품 : ${productFreeGift.freeGiftName}</p>
                            </c:forEach>
                            <c:forEach items="${product.cartProductSupplementList}" var="productSupplement">
                                <p class="pt5">부록 : ${productSupplement.suppName}</p>
                            </c:forEach>
                            <c:forEach items="${product.cartProductPosterCaseList}" var="productPosterCase">
                                <p class="pt5">포스터 증정</p>
                            </c:forEach>
                        </td>
                        <td></td>
                        <td>
                            <c:forEach items="${product.cartProductFreeGiftList}" var="productFreeGift">
                                <p class="pt5">${productFreeGift.prdtCount}개 </p>
                            </c:forEach>
                            <c:forEach items="${product.cartProductSupplementList}" var="productSupplement">
                                <p class="pt5">${product.prdtCount}개 </p>
                            </c:forEach>
                            <c:forEach items="${product.cartProductPosterCaseList}" var="productPosterCase">
                                <p>${product.prdtCount}개 </p>
                            </c:forEach>
                        </td>
                        <td></td>
                        <td></td>
                    </tr>
                </c:if>
            </c:forEach>
            <c:if test="${!empty cart.cartProductFgiftList}">
                <c:forEach items="${cart.cartProductFgiftList}" var="vndrFreeGift">
                    <tr>
                    	<td></td> 
                        <td></td>
                        <td class="t_left"><span>주문사은품</span> : ${vndrFreeGift.title} </td>
                        <td></td>
                        <td>1</td>
                        <td></td>
                        <td></td>
                    </tr>
                </c:forEach>
            </c:if>
            <c:if test="${!empty cart.cartProductFreeGiftList}">
                <c:forEach items="${cart.cartProductFreeGiftList}" var="vndrFreeGift">
                    <tr> 
                        <td></td>
                        <td></td>
                        <td class="t_left"><span>업체사은품</span> : ${vndrFreeGift.freeGiftName}</td>
                        <td></td>
                        <td>${vndrFreeGift.prdtCount}개</td>
                        <td></td>
                        <td></td>
                    </tr>
                </c:forEach>
            </c:if>
        </tbody>
    </table>
    </div>
    <c:if test="${i.first}">
        <div id="slideToggle_a" style="display:none;">
    </c:if>
    <c:if test="${i.last}">
        </div>
    </c:if>
</c:forEach>

     <c:if test="${cartListlength > 1}">
	     <div class="mgt20">
	       <p name="toggle-control" class="fs14 c_black t_center cursor">주문 상품 전체 보기<span class="bg_arrowdown"></span></p>
	       <p name="toggle-control" class="fs14 c_black t_center cursor" style="display:none;">주문 상품 간략 보기<span class="bg_arrowup"></span></p>
	     </div>
     </c:if>
     
     
    <!-- 예약 상품 주문 시 -->
    <div class="help_box fs14 mgt50" id="preOrderLayer" style="display:<c:if test="${preOrderProduct eq 'no'}">none</c:if><c:if test="${preOrderProduct eq 'ok'}">block</c:if>;">              
        <p class="c_red">주문 상품 목록에 발매 예정인 예약 상품이 포함되어 있습니다.</p>
        <p>예약 상품 발매 후 배송이 진행됩니다.</p>
        <p>기 출시 상품을 먼저 받아보시려면 예약 상품과 별도로 주문하시기 바랍니다.</p>
    </div>
     
	<script>
	$("p[name='toggle-control']").click(function(){
	    $('#slideToggle_a').slideToggle();
	    $("p[name='toggle-control']").toggle();
	});
	</script>
         
    <c:if test="${isLogin}">
        <div class="c_both">
            <div class="f_left">
                <h3 class="tit01_v2">할인 정보</h3>
                <table class="table02_v1">
                    <caption>할인적용 상세</caption>
                    <colgroup>
                        <col style="width:15%" />
                        <col style="width:*" />
                    </colgroup>
                    <tbody>
                        <%-- <c:if test="${groupSellYn != 'Y'}"> --%> <!-- 공동구매가 아니면 -->
                        <tr <c:if test="${userProperty.gradeId == '99'}">style="display:none;"</c:if>>
                            <th scope="row">쿠폰</th>
                            <td>
                                <input type="text" name="cpnDscntPrice" id="cpnDscntPrice" class="input_txt t_right" title="쿠폰 입력" style="width:90px" value="0" disabled="disabled" /> 원 
                                <a href="javascript://" onclick="openCouponPopup()" class="btn_type01_v2 mgl10">조회/적용</a>
                                <dl class="p_desc f_right">
                                    <dt>사용가능/전체쿠폰</dt>
                                    <dd>${usableCpnCount + dlvyCpnSum + fn:length(orderCouponList) }/${userProperty.usableCouponCount}장
                                        <input type="hidden" name="usableCpnCount" value="${usableCpnCount + dlvyCpnSum + fn:length(orderCouponList) }" />
                                    </dd>
                                </dl>
                            </td>
                        </tr>
                        <%-- </c:if> --%>
                        <tr>
                            <th scope="row">통합포인트</th>
                            <td>
                                <input name="totmileage" value="0" maxlength="10" id="totmileage" type="text" class="input_txt inputNumberText t_right" title="통합포인트 입력" style="width:90px;ime-mode:disabled;" /> 원 
                                <label class="mgl10"><input name="allUseTotMileage" id="allUseTotMileage" type="checkbox" class="checkbox checkboxs" title="모두사용" /> <span>모두사용</span></label>
                                <dl class="p_desc f_right">
                                    <dt>보유 통합포인트</dt>
                                    <dd>
                                        <fmt:formatNumber pattern="#,###" value="${userProperty.totPoint}"/>원
                                        <input type="hidden" name="userTotPoint" value="${userProperty.totPoint}"/>
                                    </dd>
                                </dl>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">마일리지</th>
                            <td>
                                <input name="mileage" value="0" maxlength="10" id="mileage" type="text" class="input_txt inputNumberText t_right" title="마일리지 입력" style="width:90px;ime-mode:disabled;" /> 원 
                                <label class="mgl10"><input name="allUseMileage" id="allUseMileage"  type="checkbox" class="checkbox" title="모두사용" /> <span>모두사용</span></label>
                                <dl class="p_desc f_right">
                                    <dt>보유 마일리지</dt>
                                    <dd>
                                        <fmt:formatNumber pattern="#,###" value="${userProperty.mileage}"/>원
                                        <input type="hidden" name="userMileage" value="${userProperty.mileage}"/>
                                    </dd>
                                </dl>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">예치금
                                <div class="tooltip_wrap">
                                    <a href="#tooltip" class="tooltip">?</a>
                                    <div class="layer_pop_wrap" id="tooltip" style="display: none;top:-2px;left:-2px">
                                        <div class=" layer_pop_container " style="width:643px;height:150px;">
                                            <h1>교보핫트랙스 온라인 예치금 안내</h1>
                                            <div class="layer_pop_cont">
                                                <ul>
                                                    <li>· 교보핫트랙스 온라인 예치금은 결제 후 환불, 배송비 정산 등으로 발생한 금액입니다.</li>
                                                    <li class="mgt5">· 개인 정보 보호를 위해 회원님께서 직접 환불 접수해주실 때까지 환불 금액을 임시로 보관해드리고 있습니다.</li>
                                                    <li class="mgt5">· 예치금은 핫트랙스 온라인몰에서만 사용 가능하며, 은행 계좌로 환불받으실 수 있습니다.</li>
                                                    <li class="mgt5">· 휴대폰, 신용카드 등으로 결제 시 입금 확인 시간이 소요되어 환불 처리가 다소 지연될 수 있습니다.</li>
                                                </ul>
                                            </div>
                                            <a href="#none" class="cls_btn" title="레이어팝업 닫기"><img src="${imageServer}/images/renewal/common/btn_cls.gif" alt="닫기"></a>
                                        </div>
                                    </div>
                                </div>
                            </th>
                            <td>
                                <input name="deposit" value="0" maxlength="10" id="deposit" type="text" class="input_txt inputNumberText t_right" title="예치금 입력" style="width:90px;ime-mode:disabled;" /> 원 
                                <label class="mgl10"><input name="allUseDeposit" id="allUseDeposit" type="checkbox" class="checkbox" title="모두사용" /> <span>모두사용</span></label>
                                <dl class="p_desc f_right">
                                    <dt>보유 예치금</dt>
                                    <dd>
                                        <fmt:formatNumber pattern="#,###" value="${userProperty.deposit}"/>원
                                        <input type="hidden" name="userDeposit" value="${userProperty.deposit}"/>
                                    </dd>
                                </dl>
                            </td>
                        </tr>
                        <c:if test="${groupSellYn != 'Y'}"> <!-- 공동구매가 아니면 -->
                        <tr <c:if test="${userProperty.gradeId == '99'}">style="display:none;"</c:if>>
                            <th scope="row">제휴포인트<br/>사용/적립</th>
                            <td>
                                <ul class="allyCash">
                                    <li class="txt_list">
                                        <input name="allyCash" id="allyCashGs" type="radio" value="01" class="chkallyCash"/><label for="allyCashGs" style="margin-left:5px;">GS&amp;POINT</label>
                                        <div class="allyContent" id="allyCashGsLayer">
                                            <h5>GS&amp;POINT<span class="btn_close"><a href="#"><img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/btn_layer_cls.png" style="width:40px;" alt="닫기"></a></span></h5>
                                            <table class="inner-table">
                                                <colgroup>
                                                    <col width="100px"/>
                                                    <col width="*"/>
                                                </colgroup>
                                                <tr>
                                                    <th class="pd10" scope="row"><label for="gsIdInput">GS 아이디</label></th>
                                                    <td class="pd10"><input class="input_txt" type="text" name="gsIdInput" id="gsIdInput" style="width:129px;" class="input userInfo" maxlength="20"/></td>
                                                </tr>
                                                <tr>
                                                    <th class="pd10" scope="row"><label for="gsPwInput">비밀번호</label></th>
                                                    <td class="pd10">
                                                        <input class="input_txt" type="password" name="gsPwInput" style="width:80px;" class="input userInfo"/>
                                                        <button type="button" onclick="gsPointSearch();" class="btn_type01_v2" style="height:22px;">조회</button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th class="pd10" scope="row">보유 포인트</th>
                                                    <td class="pd10"><span id="gsGetPoint" name="gsGetPoint">0 P</span></td>
                                                </tr>
                                                <tr>
                                                    <th class="pd10" scope="row"><label for="gsPointUse">사용 포인트</label></th>
                                                    <td class="pd10">
                                                        <input type="hidden" name="userGsPoint" value=""/>
                                                        <input type="hidden" name="userGsCardNo" value=""/>
                                                        <input type="text" id="gsPointUse" name="gsPointUse" style="width:129px;ime-mode:disabled;" class="input_txt usePoint input inputNumberText right" value="0" maxlength="10"/> P
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="pd10 no_line" colspan="2" class="no_line">
                                                        <input type="checkbox" name="gsPointSave" id="gsPointSave" class="v_bottom mgt15 savePoint checkboxs" /><label class="mgl5 fs14 c_black" for="gsPointSave">GS&POINT 적립 신청하기</label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <ul class="point-info">
                                                <li>- GS&amp;POINT는 1,000원 이상부터 10원 단위로 사용 가능합니다.</li>
					                            <li>- GS&amp;POINT 사용, 적립을 위해 GS&amp;POINT 아이디와 비밀번호를 정확히 입력해주세요.</li>
					                            <li>- GS&amp;POINT 비밀번호를 분실한 경우 'GS&amp;POINT 홈페이지 &#62; 비밀번호 찾기'에서 확인할 수 있습니다.</li>
                            					<li class="point-site"><a href="http://www.gsnpoint.com/" target="_blank">[GS&amp;POINT 홈페이지 바로가기]</a></li>
                                            </ul>
                                            <div class="c_both bt_line"></div>
                                            <a href="javascript://" class="btn_type04_v1 confirm">
	                                            <p>
	                                                <span class="button">확인</span>
	                                            </p>
                                            </a>
                                        </div>
                                    </li>
 
                                    <li>
                                        <input name="allyCash" id="allyCashL" type="radio" value="02" class="chkallyCash"/><label for="allyCashL" style="margin-left:5px;">L.POINT</label>
                                        <div class="allyContent" id="allyCashLLayer" style="display:none;">
                                            <h5>L.POINT<span class="btn_close"><a href="#"><img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/btn_layer_cls.png" style="width:40px;" alt="닫기"></a></span></h5>
                                            <table class="inner-table">
                                                <colgroup>
                                                    <col width="100px"/>
                                                    <col width="*"/>
                                                </colgroup>
                                                <tr>
                                                    <th class="pd10" scope="row"><label for="lCardInput">카드번호</label></th>
                                                    <td class="pd10"><input type="text" name="lCardInput" id="lCardInput" style="width:129px;" class="input_txt input userInfo" maxlength="20"/></td>
                                                </tr>
                                                <tr>
                                                    <th class="pd10" scope="row"><label for="lPwInput">비밀번호</label></th>
                                                    <td class="pd10">
                                                        <input type="password" name="lPwInput" style="width:80px;" class="input_txt input userInfo"/>
                                                        <button type="button" onclick="fnLPointSearch();" class="btn_type01_v2" style="height:22px;">조회</button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th class="pd10" scope="row">보유 포인트</th>
                                                    <td class="pd10"><span id="lGetPoint" name="lGetPoint">0 P</span></td>
                                                </tr>
                                                <tr>
                                                    <th class="pd10" scope="row"><label for="lPointUse">사용 포인트</label></th>
                                                    <td class="pd10">
                                                        <input type="hidden" name="userlPoint"/>
                                                        <input type="hidden" name="userlCardNo"/>
                                                        <input type="hidden" name="userlPw"/>
                                                        <input type="text" id="lPointUse" name="lPointUse" style="width:129px;ime-mode:disabled;" class="input_txt usePoint inputNumberText right" value="0" maxlength="10"/> P
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="pd10 no_line" colspan="2">
                                                        <input type="checkbox" name="lPointSave" id="lPointSave" class="v_bottom mgt15 savePoint checkboxs" /><label class="mgl5 fs14 c_black" for="lPointSave">L.POINT 적립 신청하기</label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <ul class="point-info">
                                                <li>- L.POINT는 10원 단위로 사용 가능하며 보유하고 있는 잔액 내에서 제한 없이 사용 가능합니다.</li>
                            					<li>- L.POINT 비밀번호는 L.POINT 홈페이지에서 설정 가능하며, 5회 이상 비밀번호 입력 오류 시 새로운 비밀번호를 등록하셔야 합니다.</li>
                           						<li class="point-site"><a href="https://www.lpoint.com/app/point/HPPG100200.do" target="_blank">[L.POINT 비밀번호 설정하기]</a></li>
                                            </ul>
                                            <div class="c_both bt_line"></div>
                                            <a href="javascript://" class="btn_type04_v1 confirm">
	                                            <p>
	                                                <span class="button">확인</span>
	                                            </p>
                                            </a>
                                        </div>
                                    </li>
                                    <li>
                                        <input name="allyCash" id="allyCashOk" type="radio" value="03" class="chkallyCash"/><label for="allyCashOk" style="margin-left:5px;">OK캐쉬백</label>
                                        <div class="allyContent" id="allyCashOkLayer">
                                            <h5>OK캐쉬백<span class="btn_close"><a href="#"><img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/btn_layer_cls.png" style="width:40px;" alt="닫기"></a></span></h5>
                                            <table class="inner-table">
                                                <colgroup>
                                                    <col width="100px"/>
                                                    <col width="*"/>
                                                </colgroup>
                                                <tr>
                                                    <th class="pd10" scope="row"><label for="okIdInput">카드번호</label></th>
                                                    <td class="pd10"><input type="text" name="okIdInput" id="okIdInput" style="width:129px;" class="input_txt input userInfo" maxlength="20"/></td>
                                                </tr>
                                                <tr>
                                                    <th class="pd10" scope="row"><label for="okPwInput">비밀번호</label></th>
                                                    <td class="pd10">
                                                        <input type="password" name="okPwInput" id="okPwInput" style="width:80px;" class="input_txt input userInfo" maxlength="20"/>
                                                        <button type="button" onclick="okPointSearch();" class="btn_type01_v2" style="height:22px;">조회</button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th class="pd10" scope="row">보유 포인트</th>
                                                    <td class="pd10"><span id="okGetPoint" name="okGetPoint">0P</span></td>
                                                </tr>
                                                <tr>
                                                    <th class="pd10" scope="row"><label for="okPointUse">사용 포인트</label></th>
                                                    <td class="pd10">
                                                        <input type="hidden" name="userokPoint" value=""/>
                                                        <input type="hidden" name="userokCardNo" value=""/>
                                                        <input type="hidden" name="userokCardPw" value=""/>
                                                        <input type="text" id="okPointUse" name="okPointUse" style="width:129px;ime-mode:disabled;" class="input_txt usePoint inputNumberText right" value="0" maxlength="10"/> P
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="pd10 no_line" colspan="2">
                                                        <input type="checkbox" name="okPointSave" id="okPointSave" class="v_bottom mgt15 savePoint checkboxs" /><label class="mgl5 fs14 c_black" for="okPointSave">OK캐쉬백 적립 신청하기</label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <ul class="point-info">
                                               <li>- OK캐쉬백은 10원 단위로 사용이 가능하며 보유하고 있는 잔액 내에서 제한 없이 사용하실 수 있습니다.</li>
					                           <li>- OK캐쉬백 웹회원 비밀번호는 OK캐쉬백 홈페이지에서 조회/변경이 가능합니다.</li>
					                           <li>- 카드번호가 잘못 입력되거나 유효하지 않을 경우 OK캐쉬백 잔액 확인이 불가할 수 있습니다.</li>
					                           <li class="point-site"><a href="http://www.okcashbag.com/" target="_blank">[OK캐쉬백 홈페이지 바로가기]</a></li>
                                            </ul>
                                            <div class="c_both bt_line"></div>
                                            <a href="javascript://" class="btn_type04_v1 confirm">
	                                            <p>
	                                                <span class="button">확인</span>
	                                            </p>
                                            </a>
                                        </div>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
	            <ul class="list_type02_v2 mgt10">
	              <li>쿠폰 또는 통합포인트 사용 시 예상 적립 통합포인트가 변동될 수 있습니다.</li>
	              <li>통합포인트/마일리지는 10원 단위로 사용 가능합니다.</li>
	              <li>예치금 확인 및 환불 신청은 '마이핫트랙스'에서 가능합니다.</li>
	            </ul>
            </div>
           
        </div>
    </c:if>
    
    <div id="paymentArea" class="f_left" style="width:640px;">
        <h3 class="tit01_v2">결제 선택</h3>
         <!-- 행사 태그 -->
         <!-- <div class="evt_tag">
        	<img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/common/images/order/tool_dc_m2.png" alt="15% 적립">
         </div> -->
         
        <table class="table02_v1">
            <caption>결제금액 상세</caption>
            <colgroup>
                <col style="width:*" />
            </colgroup>
            <tbody>
                <tr>
                    <%--<th>결제금액 : <strong class="point02" id="orderAmtBottom"><fmt:formatNumber value="${cartProductSum.totalOrderAmt}" pattern="#,###"/></strong>원</th>--%>
                    <th style="padding:10px 0 10px 15px;">
                        <span><input name="pymntMeansCode" value="C011J" id="pymntMeansCodeC011J" type="radio" checked="checked"> <label for="pymntMeansCodeC011J">신용카드</label></span>
                        <span class="mgl7"><input name="pymntMeansCode" value="C011K" id="pymntMeansCodeC011K" type="radio"> <label for="pymntMeansCodeC011K">실시간 계좌이체</label></span>
                        <span class="mgl7 payPhone"><input name="pymntMeansCode" value="C011D" id="pymntMeansCodeC011D" type="radio"> <label for="pymntMeansCodeC011D">휴대폰</label></span>
                        <span class="mgl7"><input name="pymntMeansCode" value="C011L" id="pymntMeansCodeC011L" type="radio"> <label for="pymntMeansCodeC011L">무통장</label></span>
                        <span class="mgl7">
                            <input name="pymntMeansCode" value="C011E" id="pymntMeansCodeC011E" type="radio">
                            <label for="pymntMeansCodeC011E"><img src="${imageServer}/images/order/txt_npay.png" alt="네이버페이"/></label>
                        </span>
                        <span class="mgl7">
                            <input name="pymntMeansCode" value="C011H" id="pymntMeansCodeC011H" type="radio">
                            <label for="pymntMeansCodeC011H"><img src="${imageServer}/images/order/txt_kakao.png" alt="카카오페이"/></label>
                        </span>
                        <span class="mgl7">
                            <input name="pymntMeansCode" value="C011I" id="pymntMeansCodeC011I" type="radio">
                            <label for="pymntMeansCodeC011I"><img src="${imageServer}/images/order/txt_smile.png" alt="스마일페이"/></label>
                        </span>
                        <span class="mgl7" id="escrowUseYnArea" style="display:none;"><input type="checkbox" name="escrowUseYn" id="escrowUseYn" class="checkboxs" value="Y" disabled="disabled"/><label for="escrowUseYn">에스크로 신청</label></span>
                    </th>
                </tr>
                <tr class="paymentArea list01">
                    <td>
                        <div class="tab_wrap">
                            <div class="tab_pannels">
                                <div id="card01" class="cont pannel p_lineh">
                                	<h3 class="pdt10"><strong class="c_black">신용카드 할인 안내</strong></h3>
                                    <!-- 신한카드 -->
                                    <div class="c_tit mgt10 c_red bold">신한카드</div>
                                    <p>· 2~6개월, 12개월(부분) 무이자</p>
                                    
                                    <!-- 하나카드 -->
                                    <div class="c_tit mgt10 c_red bold">하나카드</div>
                                    <p>· 2~3개월 무이자 </p>
                                    
                                    <!-- 국민카드 -->
                                    <div class="c_tit mgt10 c_red bold">국민카드</div>
                                    <p>· 2~5개월 무이자 </p>
                                    
                                    <!-- 비씨카드,NH농협카드,현대카드,삼성카드-->
                                    <div class="c_tit mgt10 c_red bold">비씨카드, NH농협카드, 현대카드, 삼성카드</div>
                                    <p>· 2~6개월 무이자 </p>
                                  
                                 	<!-- 공통 사항  -->
                                 	<h3 class="mgt20 pdb10"><strong class="c_black">유의사항</strong></h3>
                                    <p>· 행사 제외 카드 : 법인, 체크, 선불, 기프트, 하이브리드 등</p>
                                    <p>· 무이자 적용 최소 결제 금액 등 상세 내용은 결제 팝업창에서 확인해 주시기 바랍니다.</p>
                                </div>
                            </div>
                            <h3 class="mgt20 pdb10"><span class="normal c_black">기타 문의나 더 자세한 내용이 알고 싶으시면 고객센터 &gt; 주문 FAQ 를 이용해 주시기 바랍니다.</span></h3>
                        </div>
                    </td>
                </tr>
                <tr class="paymentArea list02" style="display:none;">
                    <td class="t_right v_top"><strong class="point04 mgt10 d_block">실시간 계좌이체안내</strong></td>
                    <td>
                        <div>
                            <span class="point02 bold">이용가능은행</span><br />
                            경남, 광주, 국민, 기업, 농협, 대구, 부산, 산업, 새마을금고, 수협, 신한, 신협, 외환, 우리, 우체국,<br />
                            전북, 제주, 하나, 한국씨티, SC제일, 동양증권, 신한금융투자, 삼성증권, 미래에셋증권, 한국투자증권, 한화증권<br />
                            <br />
                            
                            에스크로 시행령에 따라 고객님의 결제대금을 보호받으실 수 있습니다.<br /> 
                            '실시간 계좌이체'를 통해 결제하시면 ''LG U+'를 통해 결제대금을 보호 받으실 수 있습니다. <br /> 
                            결제금액 5만원 이상 에스크로 서비스 선택시 적용됩니다. <br /><br /> 
                            <p class="mgt30"><a href="javascript://" onclick="goValidEscrow('${lgdMid}')" class="btn_type06 mgl10"><span>서비스 가입 사실확인</span></a></p>
                            <p class="mgt30">기타 문의나 더 자세한 내용이 알고 싶으시면 고객센터 &gt; 주문 FAQ를 이용해 주시기 바랍니다..<a href="javascript://" onclick="goOrderFaq()" class="btn_type06 mgl10"><span>주문 FAQ 바로가기</span></a></p> 
                        </div> 
                    </td>
                </tr>
                <tr class="paymentArea list03" style="display:none;">
                    <td>
                    	 <div class="p_lineh">
                        	<h3 class="pdt10 pdb10"><strong class="c_black">휴대폰 결제 안내</strong></h3>
                            <p>· 교보핫트랙스에서 휴대폰으로 결제 가능한 최대 금액은 월 30만원이지만</p>
                            <p style="margin-left:8px;">개인별 한도 금액은 통신사 및 개인 설정에 따라 다를 수 있습니다.</p>
                            <p>· 휴대폰으로 결제하신 금액은 익월 휴대폰 요금에 함께 청구됩니다.</p>
                            <p>· 휴대폰 소액 결제로 구매하실 경우 세금계산서 및 현금영수증이 발급되지 않습니다.</p>
                            <p>· 휴대폰 소액 결제로 결제하신 상품을 취소할 경우 결제하신 당월 말까지 가능합니다.</p>
                            <p class="pdb10">· 휴대폰 결제로 별도의 수수료 부과는 없습니다.</p>
                        </div> 
                    </td>
                </tr>
                <tr class="paymentArea list04" style="display:none;">
                    <td class="t_right v_top"><strong class="point04 mgt10 d_block">상품권 결제안내</strong></td>
                    <td>
                        <div>
                            <p>▶ 사용가능 상품권 : 컬쳐랜드 문화상품권 (로그인 방식)</p>
                            <p class="mgt30">기타 문의나 더 자세한 내용이 알고 싶으시면 고객센터 &gt; 주문 FAQ를 이용해 주시기 바랍니다..<a href="javascript://" onclick="goOrderFaq()" class="btn_type06 mgl10"><span>주문 FAQ 바로가기</span></a></p> 
                        </div> 
                    </td>
                </tr>
                <tr class="paymentArea list05" style="display:none;">
                    <td class="t_right v_top"><strong class="point04 mgt10 d_block">무통장 입금안내</strong></td>
                    <td>
                        <div>
                            <p>1) 가상계좌는 일회성 계좌이므로 재사용시(다시 그 계좌로 입금하시는 경우) 타인의 계좌로 입금될 가능성이 있습니다. 이 경우는 고객의 책임이므로 사용에 주의하시기 바랍니다.</p>
                            <p>2) 가상계좌의 경우 CD 기에서 현금입금 하실 수 없습니다. CD 기에서 이체는 가능합니다</p>
                        </div> 
                    </td>
                </tr>
                <tr class="paymentArea list06" style="display:none;">
                    <td>
                        <div class="p_lineh">
                        	<h3 class="pdt10 pdb10"><strong class="c_black">네이버페이 안내</strong></h3>
                            <p>· 주문 변경 시 카드사 혜택 및 할부 적용 여부는 해당 카드사 정책에 따라 변경될 수 있습니다.</p> 
                            <p>· 네이버페이는 네이버ID로 별도 앱 설치 없이 신용카드 또는 은행 계좌 정보를 등록하여</p> 
                            <p style="margin-left:8px;">네이버페이 비밀번호로 결제할 수 있는 간편결제 서비스입니다.</p> 
                            <p>· 결제 가능한 신용카드 : 신한, 삼성, 현대, BC, 국민, 하나, 롯데, NH농협, 씨티</p> 
                            <p>· 결제 가능한 은행 : NH농협, 국민, 신한, 우리, 기업, SC제일, 부산, 경남, 수협, 우체국</p>
                            <p>· 네이버페이 카드 간편결제는 네이버페이에서 제공하는 카드사 무이자, 청구할인 혜택을</p>
                            <p class="pdb10" style="margin-left:8px;">받을 수 있습니다.</p>
                        </div> 
                    </td>
                </tr>
                <tr class="paymentArea list07" style="display:none;">
                    <td>
                    	<div class="p_lineh">
                    	  <h3 class="pdt10 pdb10"><strong class="c_black">카카오페이 안내</strong></h3>
		                  <p>· 카카오페이는 개인 신용카드를 카카오톡 앱에 등록/인증하여 결제하는 방식입니다.</p>
		                  <p>· 최초 1회 결제 정보만 입력하여 간편하게 결제하실 수 있는 모바일 결제 서비스입니다.</p>
		                  <p style="margin-left:7px;">본인 명의 휴대폰에서 본인 명의의 카드 등록 후 사용 가능합니다.</p>
		                  <p>· 카카오톡 앱 미설치 시 앱스토어에서 앱 설치후 회원가입을 하셔야 합니다.</p>
		                  <p class="pdb10">· 카카오톡 앱 내에서 카카오페이 가입 시 카드사 등록/인증을 하셔야 결제가 가능합니다.</p>
	               	  	</div>
                  	</td>
                </tr>
                <tr class="paymentArea list08" style="display:none;">
                    <td>
                    	<div class="p_lineh">
                    	  <h3 class="pdt10 pdb10"><strong class="c_black">스마일페이 안내</strong></h3>
		                    <p>· 앱 설치 없이 G마켓/옥션 ID 로그인 또는 회원가입 후 간편 결제</p>
                            <p>· 국내 신용/체크 카드 등록 후 이용 가능(은행 계좌이체 불가)</p>
                            <p>· 실 결제 금액의 0.5% 스마일캐시 적립(1회 최대 5천 원)</p>
                            <p>· 스마일캐시는 교보핫트랙스 및 G마켓, 옥션, G9 등에서 사용 가능</p>
                  	      	<!-- <h3 class="mgt20 pdb10">※ 스마일페이 결제 시 15% 캐시백</h3>
                         	<ul>
                         		<li>· 1만원 이상 스마일페이 (삼성카드) 결제 시 15% 캐시백 (최대 3만원)</li>
                         		<li>· 기간 : 2019년 12월 9일(월) ~ 31일(화)</li>
                         		<li>· 결제금액 기준: 쿠폰 할인금액,적립금,스마일캐시 사용금액 등을 제외한 스마일페이 실 결제금액</li>
                         		<li>· 적립일: 익월 말일</li>
                         		<li>· 1회 결제금액 기준 1만원 이상(무이자할부 건 포함) / 스마일페이 회원ID 기준 1회 적립</li>
                         		<li>· 결제 건을 전체 취소할 경우 차후 재 결제 시 적용</li>
                         		<li class="pdb10">· 적립된 스마일캐시는 유효기간(적립일로부터 90일) 내 미사용 및 구매 취소, 반품 시 자동 회수</li>
                         	</ul> -->
		                </div>
                   </td>
                </tr>
            </tbody>
        </table>
    </div>
    
    <div class="f_right" style="width:270px">
          <h3 class="tit01_v2 f_left">결제 금액</h3>
          <table class="table02_v1 fs14">
              <caption>결제금액 상세</caption>
              <colgroup>
                  <col style="width:50%" />
                  <col style="width:*" />
              </colgroup>
              <tbody>
                  <tr>
                      <td class="pd1510 c_gray">총 상품금액</td>
                      <td class="pd1510 t_right">
                          <span><fmt:formatNumber value="${cartProductSum.totalPrdtAmt}" pattern="#,###" /></span>원
                          <input type="hidden" name="totalPrdtAmt" value="${cartProductSum.totalPrdtAmt}"/>
                      </td>
                  </tr>
                  <tr>
                      <td class="pd1510 c_gray">총 배송비</td>
                      <td class="pd1510 t_right">
                          <span id="totalDlvyAmt"><fmt:formatNumber value="${cartProductSum.totalDlvyAmt}" pattern="#,###" /></span>원
                          <input type="hidden" name="totalDlvyAmt" value="${cartProductSum.totalDlvyAmt}"/>
                      </td>
                  </tr>
                  <tr>
                      <td class="pd1510 c_gray">총 주문금액</td>
                      <td class="pd1510 t_right">
                          <span id="totalDlvyAmt"><fmt:formatNumber value="${cartProductSum.totalOrderAmt}"/></span>원
                          <input type="hidden" name="totalDlvyAmt" value="${cartProductSum.totalOrderAmt}"/>
                      </td>
                  </tr>                  
                  <tr>
                      <td class="pd1510 c_gray">총 할인금액</td>
                      <td class="pd1510 t_right">
                          <strong class="c_red" id="discountPrice">0</strong>원
                          <input type="hidden" name="discountPrice" value="0"/>
                      </td>
                  </tr>
                  <tr>
                      <td class="pd1510"><span class="fs18">총 결제금액</span></td>
                      <td class="pd1510 t_right"><strong class="point02 fs20" id="orderAmt"><fmt:formatNumber value="${cartProductSum.totalOrderAmt}" pattern="#,###"/></strong>원</td>
                  </tr>
                  <tr>
                      <td class="pd1510 c_gray">통합포인트 적립</td>
                      <td class="pd1510 t_right"><span class=""><c:if test="${isLogin && userProperty.gradeId != '99'}"><fmt:formatNumber value="${cartProductSum.totalSavedPrice}"/></c:if><c:if test="${!isLogin || userProperty.gradeId == '99'}">0</c:if></span>원</td>
                  </tr>
              </tbody>
          </table>
      </div>
    
    <div id="paymentCashRepArea" class="f_left" style="width:640px;">
        <table class="paymentCashRepArea bt_line table02_v1" style="border-top: none !important;">
            <caption>현금영수증 선택</caption>
            <colgroup>
                <col style="width:*" />
            </colgroup>
            <tbody>
                <tr>
                    <td>
                    	<h3 class="pdb10"><strong class="c_black">현금영수증 선택</strong></h3>
                        <span class=""><input name="cashRepCode" value="01" id="cashRepCode01" type="radio" checked="checked"> <label for="cashRepCode01">개인소득공제용</label></span>
                        <span class="mgl10"><input name="cashRepCode" value="02" id="cashRepCode02" type="radio"> <label for="cashRepCode02">사업자증빙용</label></span>
                        <span class="mgl10"><input name="cashRepCode" value="03" id="cashRepCode03" type="radio"> <label for="cashRepCode03">미신청</label></span>
                        
                        <select name="cashRepCodeKi" class="cashRepCodeKi select mgl10" title="개인 현금영수증  인증선택" >
                            <option value="01">휴대폰</option>
                            <option value="02">카드번호</option>
                        </select>
                        <input type="text" name="cashRepHp1" class="cashRepCodeCl01 input_txt inputNumberText" maxlength="4" value="${fn:split(loginUser.userAddress.handPhoneNum, '-')[0]}" title="휴대폰 지역번호 입력" style="width:34px;ime-mode:disabled;" />
                        <input type="text" name="cashRepHp2" class="cashRepCodeCl01 input_txt inputNumberText" maxlength="4" value="${fn:split(loginUser.userAddress.handPhoneNum, '-')[1]}" title="휴대폰 중간자리 입력" style="width:34px;ime-mode:disabled;" />
                        <input type="text" name="cashRepHp3" class="cashRepCodeCl01 input_txt inputNumberText" maxlength="4" value="${fn:split(loginUser.userAddress.handPhoneNum, '-')[2]}" title="휴대폰 뒷자리 입력" style="width:34px;ime-mode:disabled;" />
                        
                        <input type="text" name="cashRepCd1" class="cashRepCodeCl03 input_txt inputNumberText" maxlength="4" title="카드번호 입력" style="width:34px;ime-mode:disabled;" />
                        <input type="password" name="cashRepCd2" class="cashRepCodeCl03 input_txt inputNumberText" maxlength="4" title="카드번호 입력" style="width:34px;ime-mode:disabled;" />
                        <input type="password" name="cashRepCd3" class="cashRepCodeCl03 input_txt inputNumberText" maxlength="4" title="카드번호 입력" style="width:34px;ime-mode:disabled;" />
                        <input type="text" name="cashRepCd4" class="cashRepCodeCl03 input_txt inputNumberText" maxlength="4" title="카드번호 입력" style="width:34px;ime-mode:disabled;" />
                        <select class="cashRepCodeCl02 select mgl10" title="선택" >
                            <option value="01">사업자등록번호</option>
                        </select>
                        <input type="text" name="cashRepbizNum1" class="cashRepCodeCl02 input_txt inputNumberText" maxlength="3" title="사업자등록번호입력" style="width:40px;ime-mode:disabled;" />
                        <input type="text" name="cashRepbizNum2" class="cashRepCodeCl02 input_txt inputNumberText" maxlength="2" title="사업자등록번호 입력" style="width:20px;ime-mode:disabled;" />
                        <input type="text" name="cashRepbizNum3" class="cashRepCodeCl02 input_txt inputNumberText" maxlength="5" title="사업자등록번호 입력" style="width:50px;ime-mode:disabled;" />
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="c_both"></div>
    
    <div class="price_agree mgt30">
    	<div>
    		<label>
    			<input name="agreeCheck" id="agreeCheck" value="Y" type="checkbox" class="checkbox" title="동의" style="width:20px; height:20px; vertical-align:text-bottom;"/>
    			<span class="c_black fs18"> 주문 상품의 상품명, 가격, 배송 정보에 동의합니다.</span>
    		</label>
    	<p style="margin:5px 23px;">(전자상거래법 제8조 2항)</p>
    	</div>
    </div>
    
    <div class="f_right mgt30">
        <a href="javascript://" id="btnPayment" class="btn_360 f_right" style="width:268px;">결제하기</a>
    </div>
</form>
<form id="gsPoint" action="#" method="post" style="hegiht:0">
    <input type="hidden" name="gsId" value=""/>
    <input type="hidden" name="gsPw" value=""/>
</form>
<form id="lPoint" action="#" method="post" style="hegiht:0">
    <input type="hidden" name="lCard" value=""/>
    <input type="hidden" name="lPw" value=""/>
</form>
<form id="okPoint" action="#" method="post" style="hegiht:0">
    <input type="hidden" name="okId" value=""/>
    <input type="hidden" name="okPw" value=""/>
</form>
<iframe id="pay_frame" name="pay_frame" style="border:0;width:0;height:0;display:" src=""></iframe>
<div id="payReqDiv" name="payReqDiv"></div>
<script type="text/javascript">
payinit();
</script>
</body>
</html>