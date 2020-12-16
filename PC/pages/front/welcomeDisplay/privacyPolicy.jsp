<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<link rel="stylesheet" type="text/css" href="/css/contents.css" />
<ui:decorator name="popup"/>
<div id="popup">
	<div class="pop-head" >
		<h1><img src="${imageServer}/images/popup/h1_logo.gif" alt="Hottracks" /></h1>
		<h2><img src="${imageServer}/images/popup/h2_popup_member_03.gif" alt="개인정보 추가 수집 동의" /></h2>
	</div> 
	<div class="pop_body">
 
 		<div class="txtbox">
			 <p>개인정보 추가 수집에 대한 동의란, 교보핫트랙스의 부가서비스 및 맞춤식 서비스 이용시 또는 이벤트 응모 과정에서 회원가입시 수집하지 않았던 개인정보를 추가로 수집할 때에 이용자들에게 고지하고 동의를 받는 경우를 말합니다. <br /><br />
				*이벤트 당첨시 경품배송 : 주소, 연락처 <br />
				*크리에이티브리그 : 재학중인 학교/학과, 재학증명서류, SNS계정, 사진이미지, 자기소개, 졸업후희망진로 등<br /> 
			</p>
		</div>
		
		<div class="order_btn h15_top"> 
            <span class="newbtn_053"><button onclick="self.close()" class="ir">닫기</button></span>
        </div> 
		  
	</div>  
</div> 