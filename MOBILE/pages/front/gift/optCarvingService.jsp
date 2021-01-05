<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="shortcut icon" href="http://image.kyobobook.co.kr/newimages/apps/b2c/kyobo.ICO"/>
<link rel="apple-touch-icon" href='http://image.kyobobook.com/mimages/static/images/common/apple-touch-icon.png' class="ico_homeAdd">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta name="format-detection" content="telephone=no">
<link href="http://mobile.kyobobook.co.kr/css/m_welcome.css" rel="stylesheet">
<link href="http://mobile.kyobobook.co.kr/css/m_order.css" rel="stylesheet">
<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
//document.domain = 'kyobobook.co.kr';

jQuery(function($){
    $("input[name='engracode']").click(function() {
        var engracode = $(this).val();
        var info = engracode.split("|") || [];
        var price = info[1];

        if(info.length >= 3) {
            var lastDiscountPrice = $("input[name='lastDiscountPrice']").val();
            if(!isNaN(lastDiscountPrice) && lastDiscountPrice >= 20000 && info.length == 4) {
                price = 0;
            }

            $("#carving-face").val(info[0]);
            $("#price").val(price);
        }
    });
});



    function fnTab1(self,elm){
        if(!jQuery(self).hasClass('on')){
            jQuery(self).addClass('on').siblings().removeClass('on')
            jQuery(elm).hide();
            jQuery(jQuery(self).attr('href')).show();
        }
        return false;
    }
    
    function setParentWindowCarvedSealInfo() {
        if($("#carving-contents").val() == "") {
            alert("각인 내용을 입력해 주세요.");
            return false;
        } else {
            var str = $("#carving-contents").val();
            var len = 0;
            for(var i=0; i<str.length; i++) {
                len += str.charCodeAt(i) < 128? 1 : 2;
            }

            if(len > 20) {
                alert("한글 10자, 영문 20자까지 가능합니다.");
                return false;
            }
        }

        if($("input[name='engracode']:checked").length == 0) {
            alert("각인 서체를 선택해 주세요.");
            return false;
        }

        var engracode = $("input[name='engracode']:checked").val();
        var carvedSealInfoArr = engracode.split("|") || [];

        opener.setCarvedSealInfo(carvedSealInfoArr, $("#carving-contents").val());
        window.close();
    }
</script>
<title>각인신청 | 교보문고</title>
</head>
<body id="windowPopup">
<input type="hidden" name="lastDiscountPrice" value="${ext.lastDcPrice}"/>
<div id="accessibility">
    <ul>
        <li><a accesskey="1" href="#content">본문으로 바로가기</a></li>
    </ul>
</div>

<!-- 각인신청 -->
<div class="window_pop">
    <div class="window_inner">
        <div class="window_header">
            <h2>각인신청</h2>
        </div>
        <div id="content" class="window_container">

            <div class="order_tab01">
                <a href="#fontLang1" onclick="fnTab1(this,'.font_lang_cont');return false" style="width:33%;" class="on">영문서체</a>
                <a href="#fontLang2" onclick="fnTab1(this,'.font_lang_cont');return false" style="width:33%;">한글서체</a>
                <a href="#fontLang3" onclick="fnTab1(this,'.font_lang_cont');return false" style="width:33%;" class="last">한문서체</a>
            </div>

            <!-- 영문서체 -->
            <div id="fontLang1" class="font_lang_cont">
                <h3 class="blind">영문서체</h3>
                <div class="option_font">
                    <span class="radio_block">
                        <input type="radio" name="engracode" value="필기체|5000|2300000028379|N" id="font_en_1" class="radio_type1" checked="checked"/>
                        <label for="font_en_1"><img src="http://image.kyobobook.co.kr/mimages/static2/images/common/img/font_en_1.png" alt="" class="font_sample" /> 필기체</label>
                    </span>
                    <span class="radio_block">
                        <input type="radio" name="engracode" value="잉크버로우체|5000|2300000028379|N" id="font_en_2" class="radio_type1"/>
                        <label for="font_en_2"><img src="http://image.kyobobook.co.kr/mimages/static2/images/common/img/font_en_2.png" alt="" class="font_sample" /> 잉크버로우체</label>
                    </span>
                    <span class="radio_block">
                        <input type="radio" name="engracode" value="모노테입체|5000|2300000028379|N" id="font_en_3" class="radio_type1"/>
                        <label for="font_en_3"><img src="http://image.kyobobook.co.kr/mimages/static2/images/common/img/font_en_3.png" alt="" class="font_sample" /> 모노테입체</label>
                    </span>
                    <span class="radio_block">
                        <input type="radio" name="engracode" value="양재난초체|5000|2300000028379|N" id="font_en_4" class="radio_type1"/>
                        <label for="font_en_4"><img src="http://image.kyobobook.co.kr/mimages/static2/images/common/img/font_en_4.png" alt="" class="font_sample" /> 양재난초체</label>
                    </span>
                    <span class="radio_block">
                        <input type="radio" name="engracode" value="브랜들리 핸드체|5000|2300000028379|N" id="font_en_5" class="radio_type1"/>
                        <label for="font_en_5"><img src="http://image.kyobobook.co.kr/mimages/static2/images/common/img/font_en_5.png" alt="" class="font_sample" /> 브랜들리 핸드체</label>
                    </span>
                    <span class="radio_block">
                        <input type="radio" name="engracode" value="고딕체|5000|2300000028379|N" id="font_en_6" class="radio_type1"/>
                        <label for="font_en_6"><img src="http://image.kyobobook.co.kr/mimages/static2/images/common/img/font_en_6.png" alt="" class="font_sample" /> 고딕체</label>
                    </span>
                    <span class="radio_block">
                        <input type="radio" name="engracode" value="명조체|5000|2300000028379|N" id="font_en_7" class="radio_type1"/>
                        <label for="font_en_7"><img src="http://image.kyobobook.co.kr/mimages/static2/images/common/img/font_en_7.png" alt="" class="font_sample" /> 명조체</label>
                    </span>
                </div>
            </div>

            <!-- 한글서체 -->
            <div id="fontLang2" class="font_lang_cont" style="display:none;" >
                <h3 class="blind">한글서체</h3>
                <div class="option_font">
                    <span class="radio_block">
                        <input type="radio" name="engracode" value="양재난초체|5000|2300000028386|N" id="font_ko_1" class="radio_type1" checked="checked" />
                        <label for="font_ko_1"><img src="http://image.kyobobook.co.kr/mimages/static2/images/common/img/font_ko_1.png" alt="" class="font_sample" /> 양재난초체</label>
                    </span>
                    <span class="radio_block">
                        <input type="radio" name="engracode" value="필기체|5000|2300000028386|N" id="font_ko_2" class="radio_type1"/>
                        <label for="font_ko_2"><img src="http://image.kyobobook.co.kr/mimages/static2/images/common/img/font_ko_2.png" alt="" class="font_sample" /> 필기체</label>
                    </span>
                    <span class="radio_block">
                        <input type="radio" name="engracode" value="명조체|5000|2300000028386|N" id="font_ko_3" class="radio_type1"/>
                        <label for="font_ko_3"><img src="http://image.kyobobook.co.kr/mimages/static2/images/common/img/font_ko_3.png" alt="" class="font_sample" /> 명조체</label>
                    </span>
                    <span class="radio_block">
                        <input type="radio" name="engracode" value="고딕체|5000|2300000028386|N" id="font_ko_4" class="radio_type1"/>
                        <label for="font_ko_4"><img src="http://image.kyobobook.co.kr/mimages/static2/images/common/img/font_ko_4.png" alt="" class="font_sample" /> 고딕체</label>
                    </span>
                </div>
            </div>

            <!-- 한문서체 -->
            <div id="fontLang3" class="font_lang_cont" style="display:none;" >
                <h3 class="blind">한문서체</h3>
                <div class="option_font">
                    <span class="radio_block">
                        <input type="radio" name="engracode" value="휴먼옛체|5000|2300000028409|N" id="font_ch_1" class="radio_type1" checked="checked" />
                        <label for="font_ch_1"><img src="http://image.kyobobook.co.kr/mimages/static2/images/common/img/font_ch_1.png" alt="" class="font_sample" /> 휴먼옛체</label>
                    </span>
                    <span class="radio_block">
                        <input type="radio" name="engracode" value="한양해서체|5000|2300000028409|N" id="font_ch_2" class="radio_type1"/>
                        <label for="font_ch_2"><img src="http://image.kyobobook.co.kr/mimages/static2/images/common/img/font_ch_2.png" alt="" class="font_sample" /> 한양해서체</label>
                    </span>
                    <span class="radio_block">
                        <input type="radio" name="engracode" value="명조체|5000|2300000028409|N" id="font_ch_3" class="radio_type1"/>
                        <label for="font_ch_3"><img src="http://image.kyobobook.co.kr/mimages/static2/images/common/img/font_ch_3.png" alt="" class="font_sample" /> 명조체</label>
                    </span>
                    <span class="radio_block">
                        <input type="radio" name="engracode" value="고딕체|5000|2300000028409|N" id="font_ch_4" class="radio_type1"/>
                        <label for="font_ch_4"><img src="http://image.kyobobook.co.kr/mimages/static2/images/common/img/font_ch_4.png" alt="" class="font_sample" /> 고딕체</label>
                    </span>
                </div>
            </div>

            <div class="pop_section margin_top15">
                <table class="table_style1 type2">
                    <caption>각인옵션</caption>
                    <tbody>
                        <tr>
                            <th>각인서체</th>
                            <td><input type="text" id="carving-face" title="각인 서체" readonly="readonly"/></td>
                        </tr>
                        <tr>
                            <th>각인내용</th>
                            <td>
                                <input type="text" id="carving-contents" title="각인 내용 입력" class="input_style" maxlength="20" title="각인내용"/>
                            </td>
                        </tr>
                        <tr>
                            <th>추가금액</th>
                            <td><input type="text" id="price" title="추가금액 입력" readonly="readonly"/>원</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div class="para border_none margin_top5">
                <p class="ico_ex1">안내</p>
                <ul class="bull_dot margin_top10">
                    <li>고급필기구 단품가 2만원 이상 구입시 각인무료</li>
                    <li>고급필기구 단품가 2만원 미만 구입시 각인비용 5,000원<br />
                        - 제품 특성 및 브랜드에 따라 각인 불가 상품있습니다.<br />
                        - 각인 된 상품은 반품, 교환 불가합니다.</li>
                    <li>영문 이니셜 각인시 ‘성’은 맨 앞 글자만 대문자로 하시는 것이 가장 보기 좋습니다. 예) K.D.Hong</li>
                </ul>
            </div>

            <ul class="btn_group">
                <li style="width:50%;"><a href="#" class="btn_white_l">취소</a></li>
                <li style="width:50%;"><a href="javascript:setParentWindowCarvedSealInfo();" class="btn_white_l btn_blue">확인</a></li>
            </ul>

        </div>
        <button type="button" class="close_window" onclick="self.close();">팝업 닫기</button>
    </div>
</div>
</body>
</html>
