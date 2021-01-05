<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<style type="text/css">
.table02 {
    height : auto;
    width  : 96%; 
    margin : 8px;
    border : 1px solid #dedede;
}
.table02 td, th{
    border : 1px solid #dedede;
}
.table02 th{
    background-color: #eeeeee;
    width : 100px; 
}
select {
    width : 200px;
    max-width : 250px;
}
.table02 td, td > select, td > input , td > textarea{
    padding-left : 10px;
    padding-right : 10px; 
    margin-bottom : 7px;
    padding-top : 5px;
    background-color: #fff;
}
.table02 span{
    width : 100%;
}
.table02 td > input{
    border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;
}
.table02 td > textarea{
    border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px;
}
.list_type02{
    margin-top : 20px;
}
.list_type02 li{
    color: #898989;
    text-align: center;
}
.btn_gray, .btn_orange {
    width : 180px;
    height : 40px; 
}
.btn_gray{
    border : 1px solid #dedede;
}
.btnorder1{
    width : 100px;
    height : 40px;
    background-color: #ff6600;
    margin-right : 10px;
    float: center;
    margin-top: 0px;
    margin-bottom: 4px;
}
input#order_num, input#p_code{
    width:180px;
    margin-bottom:10px;
}
</style>
<title>쇼핑몰 이용상담 | SOS상담 | 고객센터 - HOTTRACKS</title>
<script type="text/javascript">
var isLogin = ${isLogin};
jQuery(function($) {
    $("#wrap").addClass("mypage_v2");
    $("#locSos").addClass("active");
    $(document).ready(function(){
        var index = $("#storeSelect option").index($("#storeSelect option:selected"));
        if(index == 0){
            // 영업점
            $("input[name=sosCounselGubun]").val("T");
            
            $("select[name=storeId]").show();
            for(var i=1; i<6; i++){
                $("#order_counsel"+i).attr("disabled", true);
                $("#usual_counsel"+i).attr("disabled", true);
            }
            for(var i=1; i<=6; i++){
                $("#division"+i).attr("disabled", false);
            }
            $("#initOption").attr("selected", true);
            $("#third").hide();
            
        }else if(index == 1){
            // 핫트랙스몰
            $("input[name=sosCounselGubun]").val("S");
            
            $("select[name=storeId]").hide();
            for(var i=1; i<=6; i++){
                $("#division"+i).attr("disabled", true);
             }
            for(var i=1; i<6; i++){
                $("#order_counsel"+i).attr("disabled", false);
                $("#usual_counsel"+i).attr("disabled", false);
             }
            $("#initOption").attr("selected", true);
            $("select[name=sosCounselCode]").attr("selected", false);
        }
     });
     
     for(var i=1; i<6; i++){
        $("#order_counsel"+i).attr("disabled", true);
        $("#usual_counsel"+i).attr("disabled", true);
     }
     $("#third").hide();
     
     if ($("select[name=sosCounselCode] option:selected").val() == "C0661"
         || $("select[name=sosCounselCode] option:selected").val() == "C0662"
         || $("select[name=sosCounselCode] option:selected").val() == "C0663"
         || $("select[name=sosCounselCode] option:selected").val() == "C0664"
         || $("select[name=sosCounselCode] option:selected").val() == "C0665") {
         $("#third").show();
     }
     
     $("select[name=sosCounselCode]").change(function(){
        if ($("select[name=sosCounselCode] option:selected").val() == "C0661"
            || $("select[name=sosCounselCode] option:selected").val() == "C0662"
            || $("select[name=sosCounselCode] option:selected").val() == "C0663"
            || $("select[name=sosCounselCode] option:selected").val() == "C0664"
            || $("select[name=sosCounselCode] option:selected").val() == "C0665") {
            $("#third").show();
        }else{
            $("#third").hide();
        }
     });
     
     
     $("#storeSelect").change(function(){
        var index = $("#storeSelect option").index($("#storeSelect option:selected"));
        if(index == 0){
            // 영업점
            $("input[name=sosCounselGubun]").val("T");
            $("select[name=storeId]").show();
            for(var i=1; i<6; i++){
                $("#order_counsel"+i).attr("disabled", true);
                $("#usual_counsel"+i).attr("disabled", true);
            }
            for(var i=1; i<=6; i++){
                $("#division"+i).attr("disabled", false);
            }
            $("#initOption").attr("selected", true);
            $("#third").hide();
            
        }else if(index == 1){
            // 핫트랙스몰
            $("input[name=sosCounselGubun]").val("S");
            $("select[name=storeId]").hide();
            for(var i=1; i<=6; i++){
                $("#division"+i).attr("disabled", true);
             }
            for(var i=1; i<6; i++){
                $("#order_counsel"+i).attr("disabled", false);
                $("#usual_counsel"+i).attr("disabled", false);
             }
            $("#initOption").attr("selected", true);
            $("select[name=sosCounselCode]").attr("selected", false);
        }
    });
    
     
    $("form[name=createForm]").submit(function() {
        if ($("select[name=sosCounselCode] option:selected").length == 0) {
            alert("상담구분을 선택해주세요.");
            return false;
        }
        
        //alert($("#order_num").val()); 
        //alert($("select[name=sosCounselCode] option:selected").text());
        
        if (confirm("접수하시겠습니까?")) {
            $("input[name=offerHandphoneNumber]").val($("input[name=handPhoneNum1]").val()
                                                            + "-" + $("input[name=handPhoneNum2]").val()
                                                            + "-" + $("input[name=handPhoneNum3]").val());
            
            $("input[name=offerEmailAddress]").val($("input[name=email1]").val() + "@" + $("input[name=email2]").val());
            
            return true;
        } else {
            return false;
        }
    });
});
function closeOrder(){
    $("#layer").empty();
    $("#layer").hide();
}
function searchOrder() {
    if (isLogin) {
        $("#layer").load("/m/help/popupSearchOrder");
        $("#layer").show();
        //location.href = "/m/help/popupSearchOrder";
    } else {
        location.href ="/m/nouserLoginForm";
    }
}

function submitFrm(){
    if($("select[name=sosCounselCode] option:selected").val()=='notSelected'){
        alert("상담구분을 선택해주세요.");
        return false;
    }
    if ($("select[name=sosCounselCode] option:selected").val() == "C0661"
        || $("select[name=sosCounselCode] option:selected").val() == "C0662"
        || $("select[name=sosCounselCode] option:selected").val() == "C0663"
        || $("select[name=sosCounselCode] option:selected").val() == "C0664"
        || $("select[name=sosCounselCode] option:selected").val() == "C0665") {
        if ($("#order_num").val() == "") {
            alert("주문을 선택해주세요.");
            $("button[name=searchOrder]").focus();
            return false;
        }
        if($("#p_code").val() == ""){
            alert("상품을 선택해주세요.");
            return false;
        }
    }
    if ($("input[name=offerer]").val() == "") {
        alert("이름을 입력해주세요.");
        $("input[name=offerer]").focus();
        return false;
    }
    
    if ($("input[name=handPhoneNum1]").val() == ""
            || $("input[name=handPhoneNum2]").val() == ""
            || $("input[name=handPhoneNum3]").val() == "") {
        alert("핸드폰 전화번호를 입력해주세요.");
        $("input[name=handPhoneNum1]").focus();
        return false;
    }
    
    if ($("input[name=counselTitle]").val() == "") {
        alert("제목을 입력해주세요.");
        $("input[name=counselTitle]").focus();
        return false;
    }

    if ($("textarea[name=counselContent]").val() == "") {
        alert("내용을 입력해주세요.");
        $("textarea[name=counselContent]").focus();
        return false;
    }
    
    if ($("input[name=emailReceiveYn]").attr("checked")) {
        if ($("input[name=email1]").val() == "") {
            alert("이메일을 입력해주세요.");
            $("input[name=email1]").focus();
            return false;
        }
        
        if ($("input[name=email2]").val() == "") {
            alert("이메일을 입력해주세요.");
            $("input[name=email2]").focus();
            return false;
        }
    }
   
    $("form[name=createForm]").submit();
}

function resetFrm(){
    $("form[name=createForm]").reset();
}

</script>
</head>
<body>
<div class="sub_contents">
    <form name="createForm" method="post" action="/m/help/createCounsel">
        <input type="hidden" name="deliveryId"/>
        <input type="hidden" name="offerHandphoneNumber"/>
        <input type="hidden" name="offerEmailAddress"/>
        <input type="hidden" name="sosCounselGubun" value="S"/>
        
        <table class="table02">
            <caption>상담구분 <span>주문상담, 일반상담</span></caption>
            <colgroup>
                <col width="*" />
                <col width="*" />
                <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <td colspan="2">영업점 이용상담의 문의는 등록하신 이메일 또는 전화번호로 회신을 드립니다.</td>
                </tr>
                <tr style="margin-top:30px;">
                    <th rowspan="3">주문상담</th>
                    <td>
                    <select id="storeSelect">
                        <option id="offline" class="mgr20" value="nHTmall">영업점</option>
                        <option id="online" class="mgr20" value="HTmall" selected="selected">핫트랙스몰</option>
                    </select>
                    </td>
                </tr>
                <tr>
                    <td>
                    <!-- offline -->
                    <select name="storeId" class="select" title="영업점 선택">
                        <option value="">선택하세요.</option>
                        <c:forEach items="${listStore}" var="l">
                            <option value="${fn:substring(l.rdpCode, 1, 3)}">${l.deptname}</option>
                        </c:forEach>
                    </select>
                    <!-- offline -->
                    <!-- online -->
                    <select name="sosCounselCode">
                        <!-- online -->
                        <option id="initOption" value="notSelected">선택하세요.</option>
                        <option value="C0661" id="order_counsel1" class="mgr20">결제 </option>
                        <option value="C0662" id="order_counsel2" class="mgr20">배송</option>
                        <option value="C0663" id="order_counsel3" class="mgr20">주문취소/변경</option> 
                        <option value="C0664" id="order_counsel4" class="mgr20">반품</option>
                        <option value="C0665" id="order_counsel5" class="mgr20">교환</option>
                        <option value="C0666" id="usual_counsel1" class="mgr20">증빙서류</option>
                        <option value="C0667" id="usual_counsel2" class="mgr20">회원</option>
                        <option value="C0668" id="usual_counsel3" class="mgr20">통합포인트/핫트랙스 온라인 예치금</option>
                        <option value="C0669" id="usual_counsel4" class="mgr20">이벤트/쿠폰</option>
                        <option value="C066A" id="usual_counsel5" class="mgr20">기타문의</option>
                        <!-- offline -->
                        <option value="C066B" id="division1" class="mgr20">상품</option>
                        <option value="C066C" id="division2" class="mgr20">교환/환불</option>
                        <option value="C066D" id="division3" class="mgr20">멤버쉽</option>
                        <option value="C066E" id="division4" class="mgr20">서비스</option>
                        <option value="C066F" id="division5" class="mgr20">기타</option>
                        <option value="C066G" id="division6" class="mgr20">AS</option>
                    </select>
                    <!-- online -->
                    </td>
                </tr>
                <tr id="third">
                    <td>
                        <span id="orderAndProductCode" >
                            <label for="order_num"></label>
                            <input type="text" name="orderNum" class="i_input" id="order_num" readonly="readonly" size ="13"/>
                            <label for="p_code"></label>
                            <input name="productBarcode" type="text" class="i_input" id="p_code" readonly="readonly" size ="13"/>
                            <input name="orderProductInseq" type="hidden"/>
                            <input name="returnCount" type="hidden"/>
                            <a href="javascript://" onclick="searchOrder()" class="btn btnorder1" style="float: right;" >주문상품선택</a>
                            <!-- <a href="javascript://" onclick="searchOrderProduct()" class="btn btnorder1" style="float: left;" >상품선택</a> -->
                        </span> 
                </tr>
            </tbody>
        </table>
      
        <div id="layer" style="position:relative;width:100%;background-color:#fff;display:none;border:1px solid #2a2a2a;border-radius:5px;margin:10px 0;">
        </div>
        
        <table class="table02">
            <caption>개인정보입력 <span>이름, 아이디, 핸드폰, 이메일</span></caption>
            <colgroup>
                <col width="*" />
                <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row"><label for="name">이 름.</label><font color="#fe6000"> * </font></th>
                    <td><input name="offerer" id="offerer"  value="" type="text" class="i_input" style="width:145px;" /></td>
                </tr>
                <tr>
                    <th scope="row"><label for="name">아이디</label></th>
                    <td><input name="userId" value="${loginUser.userId}" type="text" class="i_input" style="width:145px;" readonly="readonly"/></td>
                </tr>
                <tr>
                    <th scope="row" style="padding-left: -10px;">연락처<font color="#fe6000"> * </font></th>
                    <td>
                        <c:set var="telNums" value="${fn:split(loginUser.userAddress.handPhoneNum, '-')}"/>
                        <input name="handPhoneNum1" value="${telNums[0]}" type="text" class="i_input" style="width:35px;" maxlength="3" title="핸드폰 앞자리 입력"/> -
                        <input name="handPhoneNum2" value="${telNums[1]}" type="text" class="i_input" style="width:35px;" maxlength="4" title="핸드폰 중간자리 입력"/> -
                        <input name="handPhoneNum3" value="${telNums[2]}" type="text" class="i_input" style="width:35px;" maxlength="4" title="핸드폰 마지막자리 입력"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row">이메일</th>
                    <td>
                        <input name="email1" value="${fn:substringBefore(loginUser.userAddress.emailAddr, '@')}" type="text" class="i_input" style="width : 80px;" /> @
                        <input name="email2" value="${fn:substringAfter(loginUser.userAddress.emailAddr, '@')}" type="text" class="i_input" style="width : 80px;" /> 
                    </td>
                </tr>
            </tbody>
        </table>
        
        <table class="table02">
            <caption>상담내용 <span>제목, 내용</span></caption>
            <colgroup>
                <col width="*" />
                <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row"><label for="tit">제 목<font color="#fe6000"> * </font></label></th>
                    <td><input name="counselTitle" type="text" class="i_input" id="tit" style="width:98%;" placeholder ="제목을 입력해주세요."/></td>
                </tr>
                <tr>
                    <th scope="row"><label for="desc">내 용<font color="#fe6000"> * </font></label></th>
                    <td><textarea name="counselContent" id="desc" cols="50" rows="50" style="width:98%; height:80px;" placeholder ="문의 내용을 입력해주세요."></textarea></td>
                </tr>
            </tbody>
        </table>
        
        <div class="btn_area box_flex mt30">
            <a class="btn btn_gray" style="background-color: #ededed; color: black;" href="/m/help/listSosCounsel">취 소</a>
            <a class="btn btn_orange" href="#" onclick="submitFrm();return false;" >상담 접수</a>
        </div>
<!-- //sub contents -->
</form>
</div>
</body>
</html>