<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<ui:decorator name="none"/>
<table class="table02 mgt30">
    <caption>사업자 등록증 신청<span>사업자등록번호, 상호명(법인명), 대표자명, 업태, 종목, 사업자소재지, 담당자명, 이메일, 신청자명, 산청자 연락처</span></caption>
    <colgroup>
        <col width="17%" />
        <col width="33%" />
        <col width="17%" />
        <col width="*" />
    </colgroup>
    <tbody>
        <tr>
            <th scope="row"><label for="bizRegNum">사업자등록번호</label></th>
            <td colspan="3">
                <input name="bizRegNum1" value="${searchTxinRequest.bizRegNum1}" maxlength="3" type="text" class="input_txt" id="bizRegNum" title="사업자등록번호 앞자리입력" style="width:44px;" /> -
                <input name="bizRegNum2" value="${searchTxinRequest.bizRegNum2}" maxlength="2" type="text" class="input_txt" title="사업자등록번호 중간자리입력" style="width:44px;" /> -
                <input name="bizRegNum3" value="${searchTxinRequest.bizRegNum3}" maxlength="5" type="text" class="input_txt" title="사업자등록번호 뒷자리입력" style="width:44px;" />
                <c:if test="${!empty loginUser}" >
                    <a href="#" onclick="searchTxinRequest();return false;" class="btn_type01">조회</a>
                    <a href="#" onclick="registTxin();return false;" class="btn_type01">등록</a>
                </c:if>
            </td>
        </tr>
        <tr>
            <th scope="row"><label for="vndrName">상호명</label></th>
            <td><input name="vndrName" value="${searchTxinRequest.vndrName}" type="text" class="input_txt" id="vndrName" style="width:170px;" /></td>
            <th scope="row"><label for="primeName">대표자명</label></th>
            <td><input name="primeName"  value="${searchTxinRequest.primeName}"type="text" class="input_txt" id="primeName" style="width:170px;" /></td>
        </tr>
        <tr>
            <th scope="row"><label for="bizKindInfo">업태</label></th>
            <td><input name="bizTypeInfo" value="${searchTxinRequest.bizTypeInfo}" type="text" class="input_txt" id="bizKindInfo" style="width:170px;" /></td>
            <th scope="row"><label for="division">종목</label></th>
            <td><input name="bizKindInfo" value="${searchTxinRequest.bizKindInfo}" type="text" class="input_txt" id="division" style="width:170px;" /></td>
        </tr>
        <tr>
            <th scope="row"><label for="vndrAddr">사업자 소재지</label></th>
            <td colspan="3"><input name="vndrAddr" value="${searchTxinRequest.vndrAddr}" type="text" class="input_txt" id="vndrAddr" style="width:465px;" /></td>
        </tr>
        <tr>
            <th scope="row"><label for="mngrName">담당자명</label></th>
            <td colspan="3"><input name="mngrName" value="${searchTxinRequest.mngrName}" type="text" class="input_txt" id="mngrName" style="width:170px;" /></td>
        </tr>
        <tr>
            <th scope="row"><label for="mail">이메일</label></th>
            <td colspan="3">
                <input name="emailAddr1" value="${searchTxinRequest.emailAddr1}" type="text" class="input_txt" id="mail" title="이메일 아이디입력" style="width:170px;" /> @
                <input name="emailAddr2" value="${searchTxinRequest.emailAddr2}" type="text" class="input_txt" title="이메일 도메인입력" style="width:170px;" />
                <select name="emailSelect" onchange="emailSelect()" class="select" title="이메일 도메인선택" style="width:120px;">
                    <option value="">직접입력</option>   
                    <option value="naver.com" <c:if test="${searchTxinRequest.emailAddr2 eq 'naver.com'}" >selected='selected'</c:if>>naver.com</option>
                    <option value="hanmail.net" <c:if test="${searchTxinRequest.emailAddr2 eq 'hanmail.net'}" >selected='selected'</c:if>>hanmail.net</option>
                    <option value="hotmail.com" <c:if test="${searchTxinRequest.emailAddr2 eq 'hotmail.com'}" >selected='selected'</c:if>>hotmail.com</option>
                    <option value="nate.com" <c:if test="${searchTxinRequest.emailAddr2 eq 'nate.com'}" >selected='selected'</c:if>>nate.com</option>
                    <option value="yahoo.co.kr" <c:if test="${searchTxinRequest.emailAddr2 eq 'yahoo.co.kr'}" >selected='selected'</c:if>>yahoo.co.kr</option>
                    <option value="empas.com" <c:if test="${searchTxinRequest.emailAddr2 eq 'empas.com'}" >selected='selected'</c:if>>empas.com</option>
                    <option value="dreamwiz.com" <c:if test="${searchTxinRequest.emailAddr2 eq 'dreamwiz.com'}" >selected='selected'</c:if>>dreamwiz.com</option>
                    <option value="freechal.com" <c:if test="${searchTxinRequest.emailAddr2 eq 'freechal.com'}" >selected='selected'</c:if>>freechal.com</option>
                    <option value="lycos.co.kr" <c:if test="${searchTxinRequest.emailAddr2 eq 'lycos.co.kr'}" >selected='selected'</c:if>>lycos.co.kr</option>
                    <option value="korea.com" <c:if test="${searchTxinRequest.emailAddr2 eq 'korea.com'}" >selected='selected'</c:if>>korea.com</option>
                    <option value="gmail.com" <c:if test="${searchTxinRequest.emailAddr2 eq 'gmail.com'}" >selected='selected'</c:if>>gmail.com</option>
                    <option value="hanmir.com" <c:if test="${searchTxinRequest.emailAddr2 eq 'hanmir.com'}" >selected='selected'</c:if>>hanmir.com</option>
                    <option value="paran.com" <c:if test="${searchTxinRequest.emailAddr2 eq 'paran.com'}" >selected='selected'</c:if>>paran.com</option>
                </select>
            </td>
        </tr>
        <tr>
            <th scope="row"><label for="applicant">신청자명</label></th>
            <td><input name="sscbrName" type="text" class="input_txt" id="applicant" style="width:170px;" /></td>
            <th scope="row"><label for="applicantTel1">신청자 연락처</label></th>
            <td>
                <input name="sscbrTelNum1" maxlength="3" id="applicantTel1" type="text" style="width:36px;" class="input_txt" title="신청자 연락처 첫 번째 자리"/> -
                <input name="sscbrTelNum2" maxlength="4" type="text" style="width:36px;" class="input_txt" title="신청자 연락처 두 번째 자리"/> -
                <input name="sscbrTelNum3" maxlength="4" type="text" style="width:36px;" class="input_txt" title="신청자 연락처 세 번째 자리"/>
            </td>
        </tr>
    </tbody>
</table>