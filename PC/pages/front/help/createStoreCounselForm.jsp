<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>영업점 이용상담 | SOS상담 | 고객센터 - HOTTRACKS</title>
<script type="text/javascript">
jQuery(function($) {
    $("select[name=email3]").change(function() {
        $("input[name=email2]").val($(this).val());
    });
    
    $("form[name=createForm]").submit(function() {
        if ($("select[name=storeId]").val() == "") {
            alert("매장을 선택해주세요.");
            $("select[name=storeId]").focus();
            return false;
        }
        
        if ($("input[name=sosCounselCode]:checked").length == 0) {
            alert("상담구분을 선택해주세요.");
            $("#division1").focus();
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
        <li>영업점 이용상담의 문의는 등록하신 <span class="point02">이메일 또는 전화번호로 회신</span>을 드립니다.</li>
    </ul>
    
    <div class="tab1">
        <ul>
            <li><a href="/ht/help/createCounselForm"><span>쇼핑몰 이용상담</span></a></li>
            <li><a href="javascript://" class="on"><span>영업점 이용상담</span></a></li>
        </ul>
    </div>
    
    <form name="createForm" method="post" action="/ht/help/createCounsel">
        <input type="hidden" name="offerHandphoneNumber"/>
        <input type="hidden" name="offerEmailAddress"/>
        <input type="hidden" name="sosCounselGubun" value="T"/>
        <h4 class="tit01 mgt0">영업점 선택</h4>
        <table class="table02">
            <caption>영업점 선택</caption>
            <tbody>
                <tr>
                    <td>
                        <select name="storeId" class="select" style="width:100px;" title="영업점 선택">
                            <option value="">선택하세요.</option>
                            <c:forEach items="${listStore}" var="l">
                                <c:if test="${l.rdpCode != '549' && l.rdpCode != '561'}">
                                <option value="${fn:substring(l.rdpCode, 1, 3)}">${l.deptname}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
            </tbody>
        </table>
        
        <h4 class="tit01">상담구분</h4>
        <table class="table02">
            <caption>상담구분 선택</caption>
            <tbody>
                <tr>
                    <td>
                        <input name="sosCounselCode" value="C066B" type="radio" name="p_division" id="division1" /> <label for="division1" class="mgr15">상품</label>
                        <input name="sosCounselCode" value="C066C" type="radio" name="p_division" id="division2" /> <label for="division2" class="mgr15">교환/환불</label>
                        <input name="sosCounselCode" value="C066G" type="radio" name="p_division" id="division6" /> <label for="division2" class="mgr15">AS</label>
                        <input name="sosCounselCode" value="C066D" type="radio" name="p_division" id="division3" /> <label for="division3" class="mgr15">멤버쉽</label>
                        <input name="sosCounselCode" value="C066E" type="radio" name="p_division" id="division4" /> <label for="division4" class="mgr15">서비스[친절]</label>
                        <input name="sosCounselCode" value="C066O" type="radio" name="p_division" id="division6" /> <label for="division6" class="mgr15">서비스[불친절]</label>
                        <input name="sosCounselCode" value="C066F" type="radio" name="p_division" id="division5" /> <label for="division5" class="mgr15">기타</label>
                    </td>
                </tr>
            </tbody>
        </table>
        
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
<!--                         
                        <input name="emailReceiveYn" type="checkbox" id="receive_mail" />
                        <label for="receive_mail">답변내용 이메일로 받기</label>
 -->
                    </td>
                </tr>
                <tr>
                    <td colspan="2">영업점 이용상담의 문의는 등록하신 <span class="point02">이메일 또는 전화번호로 회신</span>을 드립니다.</td>
                </tr>
            </tbody>
        </table>
        <div class="btn_area t_center mgt50">
            <a href="javascript://" onclick="submitFrm()" class="btn_type03">접수</a>
            <a href="javascript://" onclick="cancelFrm()" class="btn_type04 mgl10">취소</a>
        </div>
    </form>
</div>
</body>
</html>