<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="mypage"/>
<head>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
jQuery(function($) {
	$("span.newbtn_117").click(function () { 
		$("#form").ajaxSubmit({
			type: "POST"
			,url:"/ht/mypage/modifyUserInfo"
			,dataType: 'json'
			,success: function(data) {
	            if (data.save) {
	                alert("수정되었습니다.");
	                window.location.reload(true);
	            } else {
	                alert("수정에 실패하였습니다. - " + data.errorMessages);
	            }
	        }
	        ,error: function() {
	            alert('<fmt:message key="error.common.system"/>');
	        }
		});
	});
	
	$("span.newbtn_115").click(function () {
		history.go(-1);
	});
	
	
	$("select[name='emailSelect']").val("${fn:substringAfter(userAddressParam.emailAddr, '@')}");
	
	$("select[name='emailSelect']").change(function(){
		$("input[name='emailAddr2']").val($(this).val());
		if($(this).val() !=""){
			$("input[name='emailAddr2']").attr("disabled", "disabled");
		}else{
			$("input[name='emailAddr2']").attr("disabled", "");
		}
	});
	
	 $(document).ready(function(){
		 if($("select[name='emailSelect']").val()!=""){
			 $("input[name='emailAddr2']").attr("disabled", "disabled");
		 }else{
			 $("input[name='emailAddr2']").attr("disabled", false);
		 }
	 });
});

<%-- 우편번호 찾기 콜백 함수 --%>
function callbackZipcode(address, zipcode) {
	$("input[name='addr1']").val(address);
    $("input[name='postNum1']").val(zipcode.substring(0,3));
    $("input[name='postNum2']").val(zipcode.substring(4,7));
}
</script>
</head>
<body>
<form id="form" name="form">
<input type="hidden" value="${loginUser.name}" name="name"/>
<input type="hidden" value="${userAddressParam.addrSequence}" name="addrSequence"/>
<input type="hidden" value="${userAddressParam.addrGbn}" name="addrGbn"/>
<input type="hidden" value="${userAddressParam.addrTitle}" name="addrTitle"/>
<div id="mypage">
	<div class="contents"> 
		<p class="customertit09 ir">회원정보수정</p>
		<div class="sub_stitle"> 
			핫트랙스 온라인몰에서는 고객님의 부가정보만 수정 하실 수 있습니다.<br />
			비밀번호 등의 정보 수정은 인터넷 교보문고에 로그인 후 이용해 주시기 바랍니다. 
		</div>
		 
		<div class="order_infor h25_bottom"> 
			<div class="order_infor_title2s">
				<em><span class="newbtn_019"><button type="button" class="ir" onclick="document.location.href='https://www.kyobobook.co.kr/myroom/joinModForm.laf'">인터넷 교보문고 바로가기</button></span></em>  						
			</div>	 
			<table class="order_table02">
				<colgroup> 
					<col width="15%" />
					<col width="85%" /> 
				</colgroup> 
				<tbody> 
					<tr> 
						<th>회원 ID</th> 
						<td>${loginUser.id}</td>  
					</tr> 
					<tr> 
						<th>회원명</th> 
						<td>${loginUser.name}</td>  
					</tr>  
					<tr> 
						<th>전화번호</th>
						<td>
                            <input type="text" name="telNum1" maxlength="4" value="${userAddressParam.telNum1}" style="width:36px;ime-mode:disabled" class="input inputNumberText" /> -
                            <input type="text" name="telNum2" maxlength="4" value="${userAddressParam.telNum2}" style="width:36px;ime-mode:disabled" class="input inputNumberText" /> -
                            <input type="text" name="telNum3" maxlength="4" value="${userAddressParam.telNum3}" style="width:36px;ime-mode:disabled" class="input inputNumberText" />
						</td>
					</tr> 
					<tr>   
						<th>휴대폰</th>
						<td>
                            <input type="text" name="handPhoneNum1" maxlength="4" value="${userAddressParam.handPhoneNum1}" style="width:36px;ime-mode:disabled" class="input inputNumberText" /> -
                            <input type="text" name="handPhoneNum2" maxlength="4" value="${userAddressParam.handPhoneNum2}" style="width:36px;ime-mode:disabled" class="input inputNumberText" /> -
                            <input type="text" name="handPhoneNum3" maxlength="4" value="${userAddressParam.handPhoneNum3}" style="width:36px;ime-mode:disabled" class="input inputNumberText" />
						</td>
					</tr>  
					<tr>
						<th>이메일</th>
						<td>
							<input type="text" style="width:118px;" class="input" name="emailAddr1" value="${fn:substringBefore(userAddressParam.emailAddr, '@')}">
                            <span class="mm1">@</span>
                            <input type="text" style="width:100px;" class="input" name="emailAddr2" value="${fn:substringAfter(userAddressParam.emailAddr, '@')}">						
							<select name="emailSelect" style="width:115px;">  
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
						<th>주소</th> 
						<td>
							<input type="text" name="postNum1" style="width:36px;" class="input" readonly="readonly" value="${userAddressParam.postNum1 }" /> - 
							<input type="text" name="postNum2" style="width:36px;" class="input" readonly="readonly" value="${userAddressParam.postNum2 }" /> 
							<a href="javascript://"><img src="${imageServer}/images/order/btn_order_022.gif" onclick="window.open('/ht/listZipcode','popupZipcode','width=400,height=372'); return false;" alt="우편번호찾기" /></a><br />
							<span class="tmline2"><input type="text" name="addr1" style="width:260px;" class="input" value="${userAddressParam.addr1 }" /> 
							<input type="text" name="addr2" style="width:260px;" class="input" value="${userAddressParam.addr2 }" /></span>
						 </td>
					</tr>  
					<tr> 
						<th>생년월일</th> 
						<td><ui:mask pattern="####.##.##">${motherMallUser.birthDate}</ui:mask></td>  
					</tr>  
					<tr> 
						<th>E-mail 수신</th> 
						<td>
                            <ui:gubunRadio name="emailReceiveYn" key="ynBoolean" value="${motherMallUser.emailReceiveYn}" keyName="수신,수신안함"/>
						</td>  		
					</tr>  
					<tr> 
						<th>SMS수신</th> 
						<td>
                            <ui:gubunRadio name="smsReceiveYn" key="ynBoolean" value="${motherMallUser.smsReceiveYn}" keyName="수신,수신안함"/>
						</td>  
					</tr> 
					<tr> 
						<th>관심분야</th>
						<td>
							<c:forEach items="${interestAreaList}" var="v" varStatus="status">
								<input type="checkbox" class="checkboxs" name="itrstIDs" value="${v.itrstID }" <c:if test="${v.itrstCheck }">checked="checked"</c:if>>
								<label for="same" class="t03">${v.itrstAreaName}</label>
							</c:forEach>
						</td>  
					</tr> 
				</tbody>  
			</table> 
		</div>
		 
		<div class="order_btn">  
			<span class="newbtn_117"><button type="button" class="ir">수정</button></span>
			<span class="newbtn_115"><button type="button" class="ir">취소</button></span>
		</div>
	</div>
</div>
</form>
</body>