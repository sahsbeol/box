<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="popup"/>
<html>
<head>
<title>각인서비스 - NEW ME HOTTRACKS</title>
<script type="text/javascript"><!--
jQuery(function($){
    $(document).ready(function(){
        window.resizeTo(865,1000);
    });
    
    var face01 = $(".english");
    var facePattern01 = face01.find(".face");

    face01.find("ul.menu li a").click(function(){
        facePattern01.hide();
        $("#"+$(this).attr("href").split("#")[1]).show();
        face01.find("ul.menu li a").parent().attr("class","");
        $(this).parent().attr("class","selected");
    });

    var face02 = $(".multi-lan");
    var facePattern02 = face02.find(".face");
    face02.find("ul.menu li a").click(function(){
        facePattern02.hide();
        $("#"+$(this).attr("href").split("#")[1]).show();
        face02.find("ul.menu li a").parent().attr("class","");
        $(this).parent().attr("class","selected");
    });

    $("input[name=engracode]").click(function() {
        var engracode = $(this).val();
        var info = engracode.split("|") || [];
        var price = info[1];

        if(info.length >= 3) {
            var lastDiscountPrice = $("input[name=lastDiscountPrice]").val();
            if(!isNaN(lastDiscountPrice) && lastDiscountPrice >= 20000 && info.length == 4) {
                price = 0;
            }

            $("#carving-face").val(info[0]);
            $("#price").val(price);
        }
    });

    if("${type}" != "product") {
        $("input[type=radio]").remove();
    }
});

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

    if($("input[name=engracode]:checked").length == 0) {
        alert("각인 서체를 선택해 주세요.");
        return false;
    }
    
    var engracode = $("input[name=engracode]:checked").val();
    var carvedSealInfoArr = engracode.split("|") || [];
    
    opener.setCarvedSealInfo(carvedSealInfoArr, $("#carving-contents").val());
    window.close();
}
//-->
</script>
<style type="text/css">
.details-area { clear: both;padding:24px 0 0 30px;}
.details-area ul.menu { float: left;margin: 0 0 29px;padding: 0 4px 1px;width: 711px;background: url("http://simage.kyobobook.co.kr/newimages/giftshop_new/common/images/service/brand_menu_bg.gif")  repeat-x 0 26px;}
.details-area ul.type02 { float: left;margin: 0;padding: 0 3px 1px;width: 342px;background: url("http://simage.kyobobook.co.kr/newimages/giftshop_new/common/images/service/brand_menu_bg.gif")  repeat-x 0 26px;}
.details-area ul.menu li { float: left;margin: 0 -1px 0 0;border: 1px solid #eaeaea;border-bottom: 0;background: #f7f7f7;}
.details-area ul.menu li a { float: left;display: block;padding: 7px 9px 0;height: 18px;}
.details-area ul.type01 li a { padding: 7px 0 0;width: 98px;text-align: center;}
.details-area ul.type02 li a { padding: 7px 8px 0;width: 153px;text-align: center;}
.details-area ul.menu li.selected { background: none;}
.details-area ul.menu li.selected a { height: 19px;background: #fff;}

.carving-guide { float: left;padding: 32px 0 29px;}
.carving-guide dl { padding: 0 0 25px 44px;}
.carving-guide dl dt,.carving-guide dl dd { float: left;}
.carving-guide dl dt { width: 174px;}
.carving-guide dl dd { padding: 1px 0 0;}
.carving-guide dl dd ul.main li { padding: 0 0 14px;}
.carving-guide dl dd ul.sub { padding: 0 0 0 23px;}
.carving-guide dl dd ul.sub li { padding:  3px 0 0;}
.details-area h4 { clear: both;padding: 0 0 9px;}
.typeface { float: left;position: relative;margin: 0 0 25px;padding: 17px 6px 16px;width: 701px;height: auto;border: 1px solid #eaeaea;background: #fbfbfb;}
.english { float: left;margin: 0 5px 0 0;width: 348px;min-height: 300px;}
.english h5,.multi-lan h5 { padding: 0 0 11px;text-align: center;}
.face { display: none;clear: both;width: 346px;height: 228px;}
.face img { margin: 0;vertical-align: middle;border-top: 0;}
.face ul { float: left;margin: -2px 0 0;padding: 10px;width: 326px;border: 1px solid #eaeaea;border-top: 0;}
.face ul li { float: left;padding: 3px 0 0 10px;width: 290px;height: 25px;}
.face ul li input { margin: 0 4px 0 0;vertical-align: middle;}
.multi-lan { float: left;width: 348pxmin-height: 300px;}
.carving-form fieldset legend { width: 0;height: 0;line-height: 0;font-size: 0;visibility: hidden;}
.carving-form fieldset dl { float: left;padding: 16px 186px 11px 129px;width: 398px;border: 1px solid #eaeaea;background: #fbfbfb;}
.carving-form fieldset dl dt ,.carving-form fieldset dl dd { float: left;}
.carving-form fieldset dl dt { clear: both;padding: 7px 0 0;width: 50px;}
.carving-form fieldset dl dd { padding: 0 0 7px;width: 348px;}
.carving-form fieldset dl dd input  { padding: 1px;width: 344px;height:19px;border: 1px solid #eaeaea;}
.btn-set { clear: both;padding: 18px 0 51px;text-align: center;}
#initials,
#korea { display: block;}
</style>
</head>
<body>
<div style="width:830px;">
    <h1><img src="${imageServer}/images/renewal/common/tit_pop_service03.gif" alt="각인 서비스" /></h1>
    <div class="pop_cont">
        <ul class="list_type02">
            <li>쓰시는 분의 품격을 높여드립니다.<span class="f_right"><a href="/ht/help/fFaqListPage" target="_blank" class="btn_type01">FAQ 바로 가기</a></span></li>
        </ul>
        <div class="search_sort_tab mgt20">
            <ul>
                <li><a href="/ht/brandStory?type=1" style="border-right:none;">브랜드 스토리<span class="arrow"> </span></a></li>
                <li><a href="/ht/fountainPen?type=1" style="border-right:none;">만년필 사용법<span class="arrow"> </span></a></li>
                <li><a href="/ht/carvingService" class="on">각인서비스<span class="arrow"> </span></a></li>
                <li><a href="/ht/fountainPenFaq?type=1">자주묻는 질문<span class="arrow"> </span></a></li>
            </ul>
        </div>
        <div class="tbl_top c_both"></div>
        <div class="details-area">
            <div class="carving-guide">
                <dl>
                    <dt><img src="${imageServer}/images/service/dt_carving_title.gif" alt="각인서비스 안내" /></dt>
                    <dd>
                        <ul class="main">
                            <li><img src="${imageServer}/images/service/carving2_list01.gif" alt="" /></li>
                            <li>
                                <img src="${imageServer}/images/service/carving2_list02.gif" alt="" />
                                <ul class="sub">
                                    <li><img src="${imageServer}/images/service/carving2_list02_sub01.gif" alt="" /></li>
                                    <li><img src="${imageServer}/images/service/carving2_list02_sub02.gif" alt="" /></li>
                                    <li><img src="${imageServer}/images/service/carving2_list02_sub03.gif" alt="" /></li>
                                </ul>
                            </li>
                            <li>
                                <img src="${imageServer}/images/service/carving2_list03.gif" alt="" />
                                <ul class="sub">
                                    <li><img src="${imageServer}/images/service/carving2_list03_sub01.gif" alt="" /></li>
                                </ul>
                            </li>
                        </ul>
                        <c:if test="${type eq 'product'}"><p><img src="${imageServer}/images/service/carving_notice.gif" alt="신청 방법 : 아래  서체 리스트에서 서체선정 후 각인내용을 입력하시고  신청 버튼을 눌러 주세요." /></p></c:if>
                    </dd>
                </dl>
            </div><!-- end carving-guide -->
            <c:if test="${type eq 'product'}"><h4><img src="${imageServer}/images/service/carving_step01.gif" alt="STEP01" /></h4></c:if>
            <div class="typeface">
                <div class="english">
                    <h5><img src="${imageServer}/images/service/h5_english.gif" alt="영문서체" /></h5>
                    <ul class="menu type02">
                        <li class="selected"><a href="#initials"><img src="${imageServer}/images/service/carving_initials_on.gif" alt="이니셜각인 5,000원" /></a></li>
                        <li><a href="#full-name" class="end-menu"><img src="${imageServer}/images/service/carving_full_off.gif" alt="풀네임각인 5,000원" /></a></li>
                    </ul>
                    <div id="initials" class="face">
                        <ul>
                            <li><input type="radio" name="engracode" value="필기체|5000|2300000028379|N" id="initials_sample01" /><label for="initials_sample01"><img src="${imageServer}/images/service2/initials_sample01.gif" alt="필기체" /></label></li>
                            <li><input type="radio" name="engracode" value="잉크버로우체|5000|2300000028379|N" id="initials_sample02" /><label for="initials_sample02"><img src="${imageServer}/images/service2/initials_sample02.gif" alt="잉크버로우체" /></label></li>
                            <li><input type="radio" name="engracode" value="모노테입체|5000|2300000028379|N" id="initials_sample03" /><label for="initials_sample03"><img src="${imageServer}/images/service2/initials_sample03.gif" alt="모노테입체" /></label></li>
                            <li><input type="radio" name="engracode" value="양재난초체|5000|2300000028379|N" id="initials_sample04" /><label for="initials_sample04"><img src="${imageServer}/images/service2/initials_sample04.gif" alt="양재난초체" /></label></li>
                            <li><input type="radio" name="engracode" value="브랜들리 핸드체|5000|2300000028379|N" id="initials_sample05" /><label for="initials_sample05"><img src="${imageServer}/images/service2/initials_sample05.gif" alt="브랜들리 핸드체" /></label></li>
                            <li><input type="radio" name="engracode" value="고딕체|5000|2300000028379|N" id="initials_sample06" /><label for="initials_sample06"><img src="${imageServer}/images/service2/initials_sample06.gif" alt="고딕체" /></label></li>
                            <li><input type="radio" name="engracode" value="명조체|5000|2300000028379|N" id="initials_sample07" /><label for="initials_sample07"><img src="${imageServer}/images/service2/initials_sample07.gif" alt="명조체" /></label></li>
                        </ul>
                    </div><!-- end initials -->
                    <div id="full-name" class="face">
                        <ul>
                            <li><input type="radio" name="engracode" value="필기체|5000|2300000028379|N" id="full_sample01" /><label for="full_sample01"><img src="${imageServer}/images/service2/full_sample01.gif" alt="필기체" /></label></li>
                            <li><input type="radio" name="engracode" value="잉크버로우체|5000|2300000028379|N" id="full_sample02" /><label for="full_sample02"><img src="${imageServer}/images/service2/full_sample02.gif" alt="잉크버로우체" /></label></li>
                            <li><input type="radio" name="engracode" value="모노테입체|5000|2300000028379|N" id="full_sample03" /><label for="full_sample03"><img src="${imageServer}/images/service2/full_sample03.gif" alt="모노테입체" /></label></li>
                            <li><input type="radio" name="engracode" value="양재난초체|5000|2300000028379|N" id="full_sample04" /><label for="full_sample04"><img src="${imageServer}/images/service2/full_sample04.gif" alt="양재난초체" /></label></li>
                            <li><input type="radio" name="engracode" value="브랜들리 핸드체|5000|2300000028379|N" id="full_sample05" /><label for="full_sample05"><img src="${imageServer}/images/service2/full_sample05.gif" alt="브랜들리 핸드체" /></label></li>
                            <li><input type="radio" name="engracode" value="고딕체|5000|2300000028379|N" id="full_sample06" /><label for="full_sample06"><img src="${imageServer}/images/service2/full_sample06.gif" alt="고딕체" /></label></li>
                            <li><input type="radio" name="engracode" value="명조체|5000|2300000028379|N" id="full_sample07" /><label for="full_sample07"><img src="${imageServer}/images/service2/full_sample07.gif" alt="명조체" /></label></li>
                        </ul>
                    </div><!-- end full-name -->
                </div><!-- end english -->
                <div class="multi-lan">
                    <h5><img src="${imageServer}/images/service/h5_multi_lan.gif" alt="한글 한문 서체" /></h5>
                    <ul class="menu type02">
                        <li class="selected"><a href="#korea"><img src="${imageServer}/images/service/carving2_korea_on.gif" alt="" /></a></li>
                        <li><a href="#china" class="end-menu"><img src="${imageServer}/images/service/carving2_china_off.gif" alt="" /></a></li>
                    </ul>
                    <div id="korea" class="face">
                        <ul>
                            <li><input type="radio" name="engracode" value="양재난초체|5000|2300000028386|N" id="korea_sample01" /><label for="korea_sample01"><img src="${imageServer}/images/service2/korea_sample01.gif" alt="양재난초체" /></label></li>
                            <li><input type="radio" name="engracode" value="필기체|5000|2300000028386|N" id="korea_sample02" /><label for="korea_sample02"><img src="${imageServer}/images/service2/korea_sample02.gif" alt="필기체" /></label></li>
                            <li><input type="radio" name="engracode" value="명조체|5000|2300000028386|N" id="korea_sample03" /><label for="korea_sample03"><img src="${imageServer}/images/service2/korea_sample03.gif" alt="명조체" /></label></li>
                            <li><input type="radio" name="engracode" value="고딕체|5000|2300000028386|N" id="korea_sample04" /><label for="korea_sample04"><img src="${imageServer}/images/service2/korea_sample04.gif" alt="고딕체" /></label></li>
                        </ul>
                    </div><!-- end korea -->
                    <div id="china" class="face">
                        <ul>
                            <li><input type="radio" name="engracode" value="휴먼옛체|5000|2300000028409|N" id="china_sample01" /><label for="china_sample01"><img src="${imageServer}/images/service2/china_sample01.gif" alt="휴먼옛체" /></label></li>
                            <li><input type="radio" name="engracode" value="한양해서체|5000|2300000028409|N" id="china_sample02" /><label for="china_sample02"><img src="${imageServer}/images/service2/china_sample02.gif" alt="한양해서체" /></label></li>
                            <li><input type="radio" name="engracode" value="명조체|5000|2300000028409|N" id="china_sample03" /><label for="china_sample03"><img src="${imageServer}/images/service2/china_sample03.gif" alt="명조체" /></label></li>
                            <li><input type="radio" name="engracode" value="고딕체|5000|2300000028409|N" id="china_sample04" /><label for="china_sample04"><img src="${imageServer}/images/service2/china_sample04.gif" alt="고딕체" /></label></li>
                        </ul>
                    </div><!-- end china -->
                </div><!-- end multi-lan -->
            </div><!-- end typeface -->
            <c:if test="${type eq 'product'}">
            <h4><img src="${imageServer}/images/service/carving_step02.gif" alt="STEP02" /></h4>
            <div class="carving-form">
                <form>
                    <fieldset>
                        <legend>각인 신청 서식</legend>
                        <dl>
                            <dt><label for="carving-contents"><img src="${imageServer}/images/service/carving_contents.gif" alt="각인 내용" /></label></dt>
                            <dd><input type="text" id="carving-contents" class="requiredInput" maxlength="20"/></dd>
                            <dt><label for="carving-face"><img src="${imageServer}/images/service/carving_face.gif" alt="각인 서체" /></label></dt>
                            <dd><input type="text" id="carving-face" readonly="readonly" class="requiredInput"/></dd>
                            <dt><label for="price"><img src="${imageServer}/images/service/carving_price.gif" alt="추가금액" /></label></dt>
                            <dd><input type="text" id="price" readonly="readonly" class="requiredInput"/></dd>
                        </dl>
                        <input type="hidden" name="lastDiscountPrice" value="${product.lastDiscountPrice}"/>
                    </fieldset>
                </form>
                <div class="btn-set">
                    <a href="javascript://" onclick="setParentWindowCarvedSealInfo()" class="btn_type01">신청</a>
                    <a href="javascript://" onclick="window.close()" class="btn_type02">취소</a>
                </div><!-- end btn-set -->
            </div><!-- end carving -->
            </c:if>
        </div><!-- end details-area -->
    </div>
</div>
</body>
</html>