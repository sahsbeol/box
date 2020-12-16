<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<script type="text/javascript">
jQuery(function($){
    $(".target").click(function(){
        var img = $(".target.on").find(".targetImg");
        if(img != undefined)    img.attr("src", img.attr("src").replace("_on.png", ".png"));
        $(".target.on").removeClass("on");
        
        $(this).addClass("on");
        img = $(this).find(".targetImg");
        img.attr("src", img.attr("src").replace(".png", "_on.png"));
    });
});
</script>
</head>
<body>
<div id="container">
<p class="cont_topBg_recruit"><img src="http://image.hottracks.co.kr/info/company/bg_snb_company.png" alt="반갑습니다. 일상을 즐거움으로 채워가는 핫트랙스입니다."/></p>
<c:import url="./layerLnb.jsp"/>
<!-- contents area -->
<div id="contents_area">
    <!-- location -->
    <div id="location">
        <em class="location"><img src="http://image.hottracks.co.kr/info/icon/icon_home.png"  alt="홈"/> &gt; 회사소개 &gt; <strong>B.I</strong></em>
        <h2>B.I</h2>
    </div>
    <!-- //location -->
    <div class="biWrap access_tab">
        <ul class="tab">
            <li class="target on">
                <a class="tablist01" href="#none" title="브랜드아이덴티티"><img src="http://image.hottracks.co.kr/info/company/tab_bi_on.png" alt="브랜드아이덴티티" class="targetImg"/></a>
                <div class="bx_tab_con" viewList="viewList">
                    <p class="alim"><img src="http://image.hottracks.co.kr/info/company/txt_biAlim.png" alt="핫트랙스의 BI는 대소문자로 조합된 로고타입을 통해 핫트랙스의 개성있는 이미지를 표현하고 있습니다.‘O’ 에 표현된 dot은 다양한 경험과 즐거움의 중심에 핫트랙스가 있음을 상징합니다." /></p>    
                    <h3><img src="http://image.hottracks.co.kr/info/company/txt_wartermark.png" alt="Wartermark(워터마크)" /></h3>
                    <p class="txt">워드마크는 핫트랙스를 대표하는 모든 시각매체에 핵심요소로 사용합니다. </p>
                    <p class="img"><img src="http://image.hottracks.co.kr/info/company/img_logo_en.png" alt="핫트랙스 영문로고타입" /></p>                    
                    <p class="txt">국문로고타입은 핫트랙스 브랜드를 국문으로 표현하고자 할 때 사용하며, 핫트랙스의 일관된 이미지와 가독성을 고려하여<br />제작된 로고타입입니다.(국문로고타입)</p>
                    <p class="img"><img src="http://image.hottracks.co.kr/info/company/img_logo_ko.png" alt="핫트랙스 국문로고타입" /></p>
                    <h3><img src="http://image.hottracks.co.kr/info/company/txt_signature.png" alt="Signatur(시그니처)" /></h3>
                    <p class="txt">핫트랙스의 시그니처는 워드마크와 슬로건을 이상적인 크기와 비례로 조합한 형태입니다.</p>
                    <p class="txt">슬로건 NEW ME는  ‘나를 새롭게 하는 핫트랙스’라는 의미를 더해주어, 핫트랙스가 상품과 경험을 통해 고객에게 제공하고자 하는<br />가치를 표현하고 있습니다.</p>
                    <p class="img"><img src="http://image.hottracks.co.kr/info/company/img_sign.png" alt="핫트랙스 시그니처" /></p>
                    <p class="centerBtnView1"><a href="http://image.kyobobook.co.kr/newimages/giftshop_new/common/hottracks_logo.zip"><img src="http://image.hottracks.co.kr/info/btn/btn_bidown.gif" alt="BI download" id="biDown"/></a></p>
                </div>
            </li>
            <li class="target"><a class="tablist02" href="#none" title="색상체계"><img src="http://image.hottracks.co.kr/info/company/tab_color.png" alt="색상체계" class="targetImg"/></a>
                <div class="bx_tab_con" viewList="viewList">
                    <p class="alim"><img src="http://image.hottracks.co.kr/info/company/txt_color.png" alt="기본적으로 PANTONE COLOR를 사용하며, 인쇄매체 적용시에는 별색 지정을 통해 정확한 PANTONE 색상을 구현할 것을 권장합니다. PROCESS COLOR 기준은 4도 분판 색상규정으로 별색 표현이 어려운 경우 제한적으로 사용합니다. 영상매체, 웹상에 적용시 반드시 RGB컬러로 적용해야 하며 지정된 배홥의 비율을 정확하게 사용해야 합니다." /></p>    
                    <h3><img src="http://image.hottracks.co.kr/info/company/txt_mainColor.png" alt="Main Color" /></h3>
                    <p class="img"><img src="http://image.hottracks.co.kr/info/company/img_mainColor.png" alt="핫트랙스 메인컬러 Hottracks Red Pantone 186C/ C10 M100 Y100 KO / R202 G14 B34, Hottracks Orange Pantone Orange 021C / C0 M60 Y100 KO / R235 G110 832" /></p>
                    <h3><img src="http://image.hottracks.co.kr/info/company/txt_subColor.png" alt="Sub Color" /></h3>
                    <p class="img"><img src="http://image.hottracks.co.kr/info/company/img_subColor.png" alt="핫트랙스 서브컬러 Hottracks Black Pantone Black 6C / C0 M0 Y0 K100 / R26 G24 B24, Hottracks Black Pantone 873C, Hottracks Black Pantone 877C" /></p>
                </div>
            </li>
            <li class="target"><a class="tablist03" href="#none" title="그래픽모티브"><img src="http://image.hottracks.co.kr/info/company/tab_gm.png" alt="그래픽모티브" class="targetImg"/></a>
                <div class="bx_tab_con" viewList="viewList">
                    <p class="alim"><img src="http://image.hottracks.co.kr/info/company/txt_gm.png" alt="그래픽 모티브는 핫트랙스에서 만날 수 있는 상품과 경험을 심플한 이미지로 아이콘화하여 사용합니다." /></p>    
                    <p><img src="http://image.hottracks.co.kr/info/company/img_gm.png" alt="핫트랙스 그래픽 모티브" /></p>
                    <h3><img src="http://image.hottracks.co.kr/info/company/txt_exam.png" alt="적용사례" /></h3>
                    <p><img src="http://image.hottracks.co.kr/info/company/img_exam.png" alt="적용사례예시" /></p>
                </div>
            </li>
        </ul>
    </div>
</div><!-- //contents area -->
</div><!-- //container -->
</body>
</html>