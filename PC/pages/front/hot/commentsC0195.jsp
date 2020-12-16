<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none" />
<div class="comment_area">
    <div class="commnt_write">
        <form name="eventCommentForm" method="post" onsubmit="return false">
            <table class="table02">
            <caption>개인정보입력 <span>이름, 아이디, 핸드폰, 이메일</span></caption>
            <colgroup>
                <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row"><label for="name">영수증번호<br/>※ 영수증 제일 하단의 바코드 밑 숫자 20자리를 입력해주세요.</label>
                    </th>
                </tr>
                <tr>
                    <td><input name="userDtl" value="" type="text" class="i_input" id="userDtl"/></td>
                </tr>
                <tr>
                    <th scope="row"><label for="name">이 름</label></th>
                </tr>
                <tr>
                    <td><input name="userName" value="" type="text" class="i_input"/></td>
                </tr>
                <tr>
                    <th scope="row">핸드폰 번호</th>
                </tr>
                <tr>
                    <td>
                        <input name="handPhoneNum1" value="" type="text" class="i_input handPhoneNum" maxlength="3" title="핸드폰 앞자리 입력"/> -
                        <input name="handPhoneNum2" value="" type="text" class="i_input handPhoneNum" maxlength="4" title="핸드폰 중간자리 입력"/> -
                        <input name="handPhoneNum3" value="" type="text" class="i_input handPhoneNum" maxlength="4" title="핸드폰 마지막자리 입력"/>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="name">주소</label></th>
                </tr>
                <tr>
                    <td><textarea name="userAddr" id="userAddr" cols="100" rows="2" placeholder ="주소지 정보를 입력해주세요."></textarea></td>
                </tr>
            </tbody>
        </table>
            <p class="info mt5">
                <a href="javascript:saveOff()" class="btn btn_type01 bg_orange fl_r">등록</a>
            </p>
        </form>
    </div>
</div>