<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>조르기 &lt; 핫트랙스</title>
	<link rel="stylesheet" type="text/css" href="/css/popup.css" />
</head>
<body>
<div id="popup">
	<div class="pop-head" >
		<h1><img src="${imageServer}/images/popup/h1_logo.gif" alt="Hottracks" /></h1>
		<h2><img src="${imageServer}/images/popup/h2_popup_pester_write.gif" alt="이 상품을 정말 가지고 싶어요!" /></h2>
	</div><!-- end pop-head -->
	<div class="pop-body">
		<div class="pester-write">
		<form action="#">
			<p class="info"><img src="${imageServer}/images/popup/pester_write_info.gif" alt="정말로 꼭 가지고 싶은 아이템을 선물로 받고 싶으세요? 그럼, 지금 바로 “조르기” 메일을 보내 보세요." /></p>
			<div class="product-info">
				<p class="photo"><img src="${imageServer}/images/popup/photo.gif" alt="상품명" /></p>
				<p class="brand">[마키]</p>
				<p class="product-name">레시피 이젤 카드 앨범 - Buon Appetito(10)</p>
				<p class="price">25,000원</p>
			</div><!-- end product-info -->
			<dl class="mail-form">
				<dt class="mail-subject"><img src="${imageServer}/images/popup/text_mail_subject.gif" alt="메일제목" /></dt>
				<dd class="mail-subject"><input type="text" /></dd>
				<dt class="sender"><img src="${imageServer}/images/popup/text_sender.gif" alt="보내는 사람" /></dt>
				<dd class="sender">
					<input type="text" title="이름" class="name" />
					<input type="text" title="메일주소" class="mail" />
				</dd>
				<dt class="recipient"><img src="${imageServer}/images/popup/text_recipient.gif" alt="받는 사람" /></dt>
				<dd class="recipient">
					<input type="text" title="이름" class="name" />
					<input type="text" title="메일주소" class="mail" />
				</dd>
				<dt class="message"><img src="${imageServer}/images/popup/text_message.gif" alt="메시지" /></dt>
				<dd class="message">
					<textarea cols="70" rows="5"></textarea>
				</dd>
			</dl>
			<div class="word-input">
				<p class="word-pic"><img src="${imageServer}/images/popup/word_pic.gif" alt="6HJH6CTN" /></p>
				<p class="word-input">
					좌측에 보이는 문자를 입력해 주세요.<br />
					<input type="text" title="문자입력" />
				</p>
			</div><!-- end word-input -->
			<div class="button">
				<a href="#"><img src="${imageServer}/images/popup/btn_preview.gif" alt="미리보기" /></a>
				<input type="image" src="${imageServer}/images/popup/btn_mail_send.gif" alt="메일보내기" />
			</div><!-- end button -->
		</form>
		</div><!-- end pester-write -->
	</div><!-- end pop-body -->
	<div class="popup-foot">
		<button type="button" onclick="self.close()"><img src="${imageServer}/images/popup/btn_close.gif" alt="닫기" /></button>
	</div><!-- end close-popup -->
</div><!-- end popup -->
</body>
</html>