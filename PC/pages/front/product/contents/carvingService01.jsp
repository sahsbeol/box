<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@ taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title>각인서비스 &lt; 만년필 집중탐구 | 핫트랙스</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" href="/css/service.css" />
	<script type="text/javascript">
	<!--
	jQuery(function($){
		var face01 = $("div.english");
		var facePattern01 = face01.find("div.face");
			face01.find("ul.menu li a").click(function(){
				facePattern01.hide();
				$("#"+$(this).attr("href").split("#")[1]).show();
				face01.find("ul.menu li a").parent().attr("class","");
				$(this).parent().attr("class","selected");
			});

		var face02 = $("div.multi-lan");
		var facePattern02 = face02.find("div.face");
			face02.find("ul.menu li a").click(function(){
				facePattern02.hide();
				$("#"+$(this).attr("href").split("#")[1]).show();
				face02.find("ul.menu li a").parent().attr("class","");
				$(this).parent().attr("class","selected");
			});

	});
	//-->
	</script>
</head>
<body>
<div id="wrap">
	<div id="service-head">
		<h1><img src="${imageServer}/images/service/h1_title.gif" alt="hottracks 만년필 집중탐구" /></h1>
		<ul>
			<li><a href="/ht/product/contents/brandStory01"><img src="${imageServer}/images/service/main_navi01_off.gif" alt="브랜드 스토리" /></a></li>
			<li><a href="/ht/product/contents/fountainPen01"><img src="${imageServer}/images/service/main_navi02_off.gif" alt="만년필 사용법" /></a></li>
			<li><a href="/ht/product/contents/carvingService01"><img src="${imageServer}/images/service/main_navi03_on.gif" alt="각인서비스" /></a></li>
			<li><a href="/ht/product/contents/packingService01"><img src="${imageServer}/images/service/main_navi04_off.gif" alt="포장서비스" /></a></li>
			<li><a href="/ht/product/contents/faq01"><img src="${imageServer}/images/service/main_navi05_off.gif" alt="자주묻는 질문" /></a></li>
		</ul>
	</div><!-- end service-head -->
	<div id="body-service">
		<h2><img src="${imageServer}/images/service/h2_title_03.gif" alt="각인 서비스" /></h2>
		<div class="guide-word">
			<p class="lines">
				<img src="${imageServer}/images/service/h2_explains_03.gif" alt="쓰시는 분의 품격을 높여 드립니다." />
			</p>
			<p class="btn-faq"><a href="/html/help/faqList"><img src="${imageServer}/images/service/btn_go_faq.gif" alt="faq바로 가기" /></a></p>
		</div><!-- guide-word -->
		<div class="details-area">
			<div class="carving-guide">
				<dl>
					<dt><img src="${imageServer}/images/service/dt_carving_title.gif" alt="각인서비스 안내" /></dt>
					<dd>
						<ul class="main">
							<li><img src="${imageServer}/images/service/carving_list01.gif" alt="고급필기구 단품가  2만원 이상 구입하시는 모든 분께 영문 이니셜 각인을 무료로 제작." />
								<ul class="sub">
									<li><img src="${imageServer}/images/service/carving_list01_sub01.gif" alt="- 제품 특성 및 브랜드 별 각인이 되지 않을 수 있습니다." /></li>
									<li><img src="${imageServer}/images/service/carving_list01_sub02.gif" alt="- 각인 된 상품은 교환, 반품이 되지 않습니다." /></li>
								</ul>
							</li>
							<li>
								<img src="${imageServer}/images/service/carving_list02.gif" alt="2.고급필기구 단품가 2만원 미만 구매 시 이니셜 유료 각인 5,000원 입니다.
								-  글자체 별 각인 비용 상이합니다. (아래 각인체 및 비용 참고)" />
							</li>
							<li><img src="${imageServer}/images/service/carving_list03.gif" alt="영문 풀네임은 유료 각인 5,000원 입니다." /></li>
							<li><img src="${imageServer}/images/service/carving_list04.gif" alt="한글 각인은 유료 각인 10,000원 입니다." /></li>
							<li><img src="${imageServer}/images/service/carving_list05.gif" alt="한문 각인은 유료 각인 12,000원 입니다." /></li>
						</ul>
						<p><img src="${imageServer}/images/service/carving_notice.gif" alt="신청 방법 : 아래  서체 리스트에서 서체선정 후 각인내용을 입력하시고  신청 버튼을 눌러 주세요." /></p>
					</dd>
				</dl>
			</div><!-- end carving-guide -->
			<h4><img src="${imageServer}/images/service/carving_step01.gif" alt="STEP01" /></h4>
			<div class="typeface">
				<div class="english">
					<h5><img src="${imageServer}/images/service/h5_english.gif" alt="영문서체" /></h5>
					<ul class="menu type02">
						<li class="selected"><a href="#initials"><img src="${imageServer}/images/service/carving_initials_on.gif" alt="이니셜각인 5,000원" /></a></li>
						<li><a href="#full-name" class="end-menu"><img src="${imageServer}/images/service/carving_full_off.gif" alt="풀네임각인 5,000원" /></a></li>
					</ul>
					<div id="initials" class="face">
						<img src="${imageServer}/images/service/initials_sample.gif" alt="이니셜 K.D Hong 각인 서체는 필기체 Fiolex girls 모노라임 크로스바 바탕체 고딕사체 고딕체 로마체 슬로건0cp 제공합니다" />
					</div><!-- end initials -->
					<div id="full-name" class="face">
						<img src="${imageServer}/images/service/full_sample.gif"  alt="샘플 Hong Kil Dong 풀네임 각인 서체는 필기체 Fiolex girls 모노라임 크로스바 바탕체 고딕사체 고딕체 로마체 슬로건0cp 제공합니다" />
					</div><!-- end full-name -->
				</div><!-- end english -->
				<div class="multi-lan">
					<h5><img src="${imageServer}/images/service/h5_multi_lan.gif" alt="한글 한문 서체" /></h5>
					<ul class="menu type02">
						<li class="selected"><a href="#korea"><img src="${imageServer}/images/service/carving_korea_on.gif" alt="한글각인 10,000원" /></a></li>
						<li><a href="#china" class="end-menu"><img src="${imageServer}/images/service/carving_china_off.gif" alt="한문각인 12,000원" /></a></li>
					</ul>
					<div id="korea" class="face">
						<img src="${imageServer}/images/service/korea_sample.gif" alt="홍길동 샘플 한글 각인 서체는 바탕체 필기체 휴면옛체 고딕체 해서체 양제난초체 펜흘림 다운필기 제공합니다." />
					</div><!-- end korea -->
					<div id="china" class="face">
						<img src="${imageServer}/images/service/china_sample.gif" alt="洪吉同 샘플 각인 한문 서체는  고딕체 휴면옛체 바탕체 한양해서체 를 제공 합니다" />
					</div><!-- end china -->
				</div><!-- end multi-lan -->
			</div><!-- end typeface -->
			<h4><img src="${imageServer}/images/service/carving_step02.gif" alt="STEP02" /></h4>
			<div class="carving-form">
				<form action="/ht/product/contents/">
					<fieldset>
						<legend>각인 신청 서식</legend>
						<dl>
							<dt><label for="carving-contents"><img src="${imageServer}/images/service/carving_contents.gif" alt="각인 내용" /></label></dt>
							<dd><input type="text" id="carving-contents" /></dd>
							<dt><label for="carving-face"><img src="${imageServer}/images/service/carving_face.gif" alt="각인 서체" /></label></dt>
							<dd><input type="text" id="carving-face" /></dd>
							<dt><label for="price"><img src="${imageServer}/images/service/carving_price.gif" alt="추가금액" /></label></dt>
							<dd><input type="text" id="price" /></dd>
						</dl>
					</fieldset>
				</form>
				<div class="btn-set">
					<button type="submit"><img src="${imageServer}/images/service/btn_request_carving.gif" alt="신청" /></button>
					<button type="reset"><img src="${imageServer}/images/service/btn_reset_carving.gif" alt="취소" /></button>
				</div><!-- end btn-set -->
			</div><!-- end carving -->
		</div><!-- end details-area -->
	</div><!-- end service-body -->
</div><!-- end service -->
</body>
</html>
                                                                                           