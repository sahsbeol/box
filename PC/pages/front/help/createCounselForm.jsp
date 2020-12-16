<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>쇼핑몰 이용상담 | SOS상담 | 고객센터 - HOTTRACKS</title>
<script type="text/javascript">
var isLogin = ${isLogin};

jQuery(function($) {
    $("select[name=email3]").change(function() {
        $("input[name=email2]").val($(this).val());
    });
    
    
    $(document).ready(function(){
        $("input[type=radio][name=sosCounselCode]").change(function(){
            if($(this).val() == 'C066A'|| $(this).val() == 'C0667'|| $(this).val() == 'C0666'){
                $("#table_order").hide();
            }else{
                $("#table_order").show();
            }
        });
            
    });
    
    
    $("form[name=createForm]").submit(function() {
        if ($("input[name=sosCounselCode]:checked").length == 0) {
            alert("상담구분을 선택해주세요.");
            $("#order_counsel1").focus();
            return false;
        }
        
        if ($("input[name=sosCounselCode]:checked").val() == "C0661"
                || $("input[name=sosCounselCode]:checked").val() == "C0662"
                || $("input[name=sosCounselCode]:checked").val() == "C0663"
                || $("input[name=sosCounselCode]:checked").val() == "C0664"
                || $("input[name=sosCounselCode]:checked").val() == "C0665") {
            if ($("input[name=orderNum]").val() == "") {
                alert("주문을 선택해주세요.");
                $("button[name=searchOrder]").focus();
                return false;
            }
            if ($("input[name=productBarcode]").val() == "") {
                alert("상품코드를 선택해주세요.");
                $("button[name=orderProductInseq]").focus();
                return false;
            }
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
function searchOrder() {
    if (isLogin) {
        window.open("/ht/help/popupSearchOrder", "", "width=900,height=680");
    } else {
        window.open("/ht/help/popupNoUserLoginForm", "", "width=400,height=350");
    }
}

function searchOrderProduct() {
    var deliveryId = $("input[name=deliveryId]").val();
    
    if (deliveryId == "") {
        alert("먼저 주문을 선택해주세요.");
    } else {
        window.open("/ht/help/popupSearchOrderProduct?deliveryId=" + deliveryId, "", "width=900,height=680");
    }
}

function submitFrm(){
    $("form[name=createForm]").submit();
}

function resetFrm(){
    $("form[name=createForm]").reset();
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

<c:import url="/menu/help/lnb"/>

<div class="sub_contents">
    
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_list_sos_counsel.gif" alt="SOS상담" /></h3>
    <ul class="list_type02">
        <li>등록된 상담내역은 수정이 되지 않으므로 삭제 후 재등록을 이용해 주세요.</li>
        <li>상담을 접수하시기 전에 <span class="point02">[FAQ]</span> 서비스에 관련 내용이 있는지 확인하시기 바랍니다.</li>
        <li><span class="point02">영업점(오프라인) 문의는 우측 영업점 이용상담을 클릭해 주세요.</span></li>
        <li>음반 공동구매 문의는 SOS 답변이 불가하오니 고객센터로 문의해주시기 바랍니다.</li>
    </ul>
    
    <div class="tab1">
        <ul>
            <li><a href="javascript://" class="on"><span>쇼핑몰 이용상담</span></a></li>
            <li><a href="/ht/help/createStoreCounselForm"><span>영업점 이용상담</span></a></li>
        </ul>
    </div>
    
    <form name="createForm" method="post" action="/ht/help/createCounsel">
        <input type="hidden" name="deliveryId"/>
        <input type="hidden" name="offerHandphoneNumber"/>
        <input type="hidden" name="offerEmailAddress"/>
        <input type="hidden" name="sosCounselGubun" value="S"/>
        
        <h4 class="tit01 mgt0">상담구분</h4>
        <table class="table02">
            <caption>상담구분 <span>주문상담, 일반상담</span></caption>
            <colgroup>
                <col width="17%" />
                <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row">주문상담</th>
                    <td>
                        <input name="sosCounselCode" value="C0661" type="radio" name="order_counsel" id="order_counsel1"/> <label for="order_counsel1" class="mgr15">결제</label>
                        <input name="sosCounselCode" value="C0662" type="radio" name="order_counsel" id="order_counsel2"/> <label for="order_counsel2" class="mgr15">배송</label>
                        <input name="sosCounselCode" value="C0663" type="radio" name="order_counsel" id="order_counsel3" <c:if test="${param.sosCounselCode == 'C0663'}">checked="checked"</c:if>/> <label for="order_counsel3" class="mgr15">주문취소/변경</label>
                        <input name="sosCounselCode" value="C0664" type="radio" name="order_counsel" id="order_counsel4"/> <label for="order_counsel4" class="mgr15">반품</label>
                        <input name="sosCounselCode" value="C0665" type="radio" name="order_counsel" id="order_counsel5"/> <label for="order_counsel5" class="mgr15">교환</label>
                    </td>
                </tr>
                <th scope="row">일반상담</th>
                    <td>
                        <input name="sosCounselCode" value="C0666" type="radio" name="usual_counsel" id="usual_counsel1"/> <label for="usual_counsel1" class="mgr15">증빙서류</label>
                        <input name="sosCounselCode" value="C0667" type="radio" name="usual_counsel" id="usual_counsel2"/> <label for="usual_counsel2" class="mgr15">회원</label>
                        <input name="sosCounselCode" value="C0668" type="radio" name="usual_counsel" id="usual_counsel3"/> <label for="usual_counsel3" class="mgr15">통합포인트/핫트랙스 온라인 예치금</label>
                        <input name="sosCounselCode" value="C0669" type="radio" name="usual_counsel" id="usual_counsel4"/> <label for="usual_counsel4" class="mgr15">이벤트/쿠폰</label>
                        <input name="sosCounselCode" value="C066A" type="radio" name="usual_counsel" id="usual_counsel5"/> <label for="usual_counsel5" class="mgr15">기타문의</label>
                    </td>
                </tr>
            </tbody>
        </table>
        
        <div id="table_order">
            <h4 class="tit01">관련주문</h4>
            <table class="table02">
                <caption>관련주문 <span>주문번호, 상품코드</span></caption>
                <colgroup>
                    <col width="17%" />
                    <col width="*" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row"><label for="order_num">주문번호</label></th>
                        <td>
                            <input type="text" name="orderNum" class="input_txt" id="order_num" style="width:290px;" readonly="readonly"/>
                            <a href="javascript://" onclick="searchOrder()" class="btn_type01">주문선택</a>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="p_code">상품코드</label></th>
                        <td>
                            <input name="productBarcode" type="text" class="input_txt" id="p_code" style="width:290px;" readonly="readonly"/>
                            <input name="orderProductInseq" type="hidden"/>
                            <input name="returnCount" type="hidden"/>
                            <a href="javascript://" onclick="searchOrderProduct()" class="btn_type01">상품선택</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <h4 class="tit01">상담내용</h4>
        <table class="table02">
            <caption>상담내용 <span>제목, 내용</span></caption>
            <colgroup>
                <col width="17%" />
                <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row"><label for="tit">제목</label></th>
                    <td><input name="counselTitle" type="text" class="input_txt" id="tit" style="width:98%;" /></td>
                </tr>
                <tr>
                    <th scope="row"><label for="desc">내용</label></th>
                    <td><textarea name="counselContent" id="desc" cols="50" rows="50" style="width:98%; height:80px;"></textarea></td>
                </tr>
            </tbody>
        </table>
        
        <h4 class="tit01">개인정보입력</h4>
        <table class="table02">
            <caption>개인정보입력 <span>이름, 핸드폰, 이메일</span></caption>
            <colgroup>
                <col width="17%" />
                <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row"><label for="name">이름</label></th>
                    <td><input name="offerer" value="${loginUser.name}" type="text" class="input_txt" id="name" style="width:145px;" /></td>
                </tr>
                <tr>
                    <th scope="row">핸드폰</th>
                    <td>
                        <c:set var="telNums" value="${fn:split(loginUser.userAddress.handPhoneNum, '-')}"/>
                        <input name="handPhoneNum1" value="${telNums[0]}" type="text" class="input_txt" style="width:46px;" maxlength="4" title="핸드폰 앞자리 입력"/> -
                        <input name="handPhoneNum2" value="${telNums[1]}" type="text" class="input_txt" style="width:46px;" maxlength="4" title="핸드폰 중간자리 입력"/> -
                        <input name="handPhoneNum3" value="${telNums[2]}" type="text" class="input_txt" style="width:46px;" maxlength="4" title="핸드폰 마지막자리 입력"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row">이메일</th>
                    <td>
                        <input name="email1" value="${fn:substringBefore(loginUser.userAddress.emailAddr, '@')}" type="text" class="input_txt" style="width:118px;" title="이메일 주소 입력"/> @
                        <input name="email2" value="${fn:substringAfter(loginUser.userAddress.emailAddr, '@')}" type="text" class="input_txt" style="width:100px;" title="이메일 회사 입력"/>
                        <select name="email3" class="select" title="이메일 회사 선택" style="width:120px;">
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
                        <input name="emailReceiveYn" type="checkbox" id="receive_mail" />
                        <label for="receive_mail">답변내용 이메일로 받기</label>
                    </td>
                </tr>
            </tbody>
        </table>
        
        <div class="btn_area t_center mgt50">
            <a href="javascript://" onclick="submitFrm()" class="btn_type03">접수</a>
            <a href="javascript://" onclick="cancelFrm()" class="btn_type04 mgl10">취소</a>
        </div>
     </form>
</div>
<!-- //sub contents -->
</body>
</html>