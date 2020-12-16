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
        if(img != undefined)    img.attr("src", img.attr("src").replace("on.gif", ".gif"));
        $(".target.on").removeClass("on");
        
        $(this).addClass("on");
        img = $(this).find(".targetImg");
        img.attr("src", img.attr("src").replace(".gif", "on.gif"));
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
        <em class="location"><img src="http://image.hottracks.co.kr/info/icon/icon_home.png"  alt="홈"/> &gt; 회사소개 &gt; <strong>핫트랙스소개</strong></em>
        <h2>핫트랙스소개</h2>
    </div>
    <!-- //location -->  
    <!-- tab menu -->
    <div class="comtabmn1 access_tab">
        <ul>
            <li class="target on">
                <a class="tablist01" href="#"><img src="http://image.hottracks.co.kr/info/btn/comtabmn1on.gif" class="targetImg" alt="브랜드 소개"/></a>
                <div class="bx_tab_con" viewList="viewList">
                    <h3><img src="http://image.hottracks.co.kr/info/company/txt_brand.png" alt="브랜드소개" /></h3>
                    <p><img src="http://image.hottracks.co.kr/info/company/cont_brand.png" alt="NEW HOTTRACKS 하단에 자세한 내용이 있습니다." /></p>
                    <br />
                    <br class="clle" />
                    <div class="hide_text">
                        <h3>브랜드 소개</h3>
                        <p>NEW ME HOTTRACKS</p>
                        <ul>
                            <li>트렌디한 아이템을 만나는 재미
                                <p>
                                                이제까지 만나보지 못했던 새로운 감각의 문구, 음반, 기프트 아이템들이 가득한 공간입니다.
                                                핫트랙스는 더 새롭고 유익한 상품을 선보이기 위해 지금도 국내외를 열심히 찾아디니고 있습니다.
                                </p>
                            </li>
                            <li>다양한 경험을 통해 얻는 즐거운
                                <p>
                                                여러가지 아이템으로 가득한 핫트랙스와 함께 더 많은 꿈과 경험을 펼쳐보세요. 새로운 다집을 담아줄 노트 한 권, 설레이는 마음으로
                                                써내려갈 편지 한 장, 낙심한 친구에게 응원을 전해줄 선물 하나, 새로운 기분을 전해줄 CD 한 장. 작은 불편함을 바꿔줄 유용한 아이템 하나...
                                                핫트랙스와 함께 하는 우리 모두의 경험은 특별하고 즐겁습니다.
                                </p>
                            </li>
                            <li>나를 표현하는 기쁨
                                <p>앞선 감각의 다양한 아이템과 복합문화공간에서는 색다른 경험은 재매와 즐거운을 넘어서는, 자신만의 스타일과 특별한 일상을 만들어가는 기쁨을 제공합니다.</p>
                            </li>
                        </ul>
                    </div>
                </div>
            </li>
            <li class="target">
                <a class="tablist02" href="#"><img src="http://image.hottracks.co.kr/info/btn/comtabmn2.gif" class="targetImg" alt="기업비전"/></a>
                <div class="bx_tab_con" viewList="viewList">
                <h3><img src="http://image.hottracks.co.kr/info/company/txt_vision.png" alt="기업비전" /></h3>    
                    <p><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/company/about/cont_vision.jpg" alt="KYOBO 교보핫트랙스 하단에 자세한 내용이 있습니다." /></p>
                    <br /><br class="clle" />
                    <div class="hide_text">
                        <p>핫트랙스는 사람들의 삶에 문화적 감성과 즐거움을 충전시켜 드리는 감성적 에너지 충전소 입니다.</p>
                        <dl>
                            <dt>핵심목적</dt>
                            <dd>감성적 에너지 충전소</dd>
                            <dd>우리의 사명은 모든 사람이 일, 학습, 휴식의 과정에서 문화적 감성과 즐거움을 충전할 수 있도록 도와드리는 것입니다.</dd>
                        </dl>
                        <dl>
                            <dt>핵심가치</dt>
                            <dd>우리는 우선 고객관점에서 생각하고 행동한다 (고객중심)</dd>
                            <dd>우리는 항상 정직, 성실한 자세로 성과책임을 다한다 (정직과 성실)</dd>
                            <dd>우리는 항상 새롭게 시도하고 실패해도 다시 도전한다 (도전과 창의)</dd>
                        </dl>
                        <dl>
                            <dt>비전화된 미래</dt>
                            <dd>Double up 2020 교보핫트랙스</dd>
                            <dd>우리의 비전은 2020년까지 매출 2배, 이익 2배, 역량 2배의 회사로 키우는 것입니다</dd>
                        </dl>
                        <p>KYOBO 교보핫트랙스</p>
                    </div>
                </div>
            </li>
        </ul>
        </div><!-- //tab menu -->
    </div><!-- //contents area -->
</div><!-- //container -->
</body>
</html>