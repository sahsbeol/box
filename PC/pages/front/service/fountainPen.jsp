<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="popup"/>
<html>
<head>
<title>만년필 사용법 - NEW ME HOTTRACKS</title>
<style type="text/css">
.dictionary,
.dictionary li { float: left;width: 715px; }
.dictionary { padding: 0 0 115px;border-top: 1px solid #eaeaea; }
.dictionary li { padding: 21px 0 8px;border-bottom: 1px solid #eaeaea; }
.dictionary li dl.term dt { float: left;padding: 0 0 0 7px; width: 58px; }
.dictionary li dl.term dd { float: left; width: 650px;}
.dictionary li dl.words { float: left; margin: -1px 0 0; width: 650px;}
.dictionary li dl.words dt,.dictionary li dl.words dd { float: none; width: 650px;}
.dictionary li dl.words dt { padding: 0 0 8px 0; font-weight: bold; color: #666;}
.dictionary li dl.words dd { padding: 0 0 18px; line-height: 18px;}
</style>
</head>
<body>
<div style="width:830px;">
    <h1><img src="${imageServer}/images/renewal/common/tit_pop_service02.gif" alt="만년필 사용법" /></h1>
    <div class="pop_cont">
        <ul class="list_type02">
            <li>만년필에 대한 정확한 사용방법 안내로 오랜 시간 사용자와 함께하는 명품 필기구로 남게 도와드립니다.<span class="f_right"><a href="/ht/help/fFaqListPage" target="_blank" class="btn_type01">FAQ 바로 가기</a></span></li>
        </ul>
        <div class="search_sort_tab mgt20">
            <ul>
                <li><a href="/ht/brandStory?type=1" style="border-right:none;">브랜드 스토리<span class="arrow"> </span></a></li>
                <li><a href="/ht/fountainPen?type=1" class="on">만년필 사용법<span class="arrow"> </span></a></li>
                <li><a href="/ht/carvingService" style="border-right:none;">각인서비스<span class="arrow"> </span></a></li>
                <li><a href="/ht/fountainPenFaq?type=1">자주묻는 질문<span class="arrow"> </span></a></li>
            </ul>
        </div>
        <div class="tbl_top c_both">
            <div class="f_left">
                <ul class="tab_btn02 sort">
                    <li class="${type eq '1'?'active':''}"><a href="/ht/fountainPen?type=1">만년필의 정의</a></li>
                    <li class="${type eq '2'?'active':''}"><a href="/ht/fountainPen?type=2">만년필 선택방법</a></li>
                    <li class="${type eq '3'?'active':''}"><a href="/ht/fountainPen?type=3">만년필 기본상식</a></li>
                    <li class="${type eq '4'?'active':''}"><a href="/ht/fountainPen?type=4">필기구 용어사전</a></li>
                </ul>
            </div>
        </div>
        <div class="t_left">
            <c:choose>
                <c:when test="${type eq 1}">
                    <h3><img src="${imageServer}/images/service/h3_fountainPen01.gif" alt="만년필의 정의" /></h3>
                    <div class="define" style="background:url('${imageServer}/images/service/fountainPen01_bg.gif') no-repeat 368px 0;">
                        <p class="mgt10"><img src="${imageServer}/images/service/fountainPen01_p01.gif" alt="만년필(萬年筆; Fountain Pen)은 BC 5000년경의 고대시대부터 거위의 깃털을 이용하여 필기하였던 펜의 발달된 형태이며, 잉크를 찍어가며 잉크액이 촉 끝에 스며들게 하여 필기하던 예전과 달리 카트리지 안에 잉크를 담아 두어 계속적인 잉크의 리필로 인해 오래 사용할 수 있으며 사용과 보관상의 잇점을 최대화할 수 있는 펜이다. " /></p>
                        <p class="mgt10"><img src="${imageServer}/images/service/fountainPen01_p02.gif" alt="모세관현상과 동일한 원리로 잉크가 주입되며 두 갈래로 갈라진 촉의 모양에 따라 필기 굵기의 형태가 달라질 수 있다." /></p>
                        <p class="mgt10"><img src="${imageServer}/images/service/fountainPen01_p03.gif" alt="펜을 쥐는 각도와 사용자에 따른 필기방법도 다양한 것이 특징이다.또한 만년필의 장점은 잉크병을 휴대할 필요가 없다는 것과, 끝임없이 펜촉을 잉크에 찍어 쓰는 번거로움이 없다는 점 등이지만, 가장 뛰어난 장점은 그 쓰는 감촉에 있다. " /></p>
                        <p class="mgt10"><img src="${imageServer}/images/service/fountainPen01_p04.gif" alt="즉, 그 펜을 쓰는 느낌이 언제까지나 변하지 않는다는 것에 최대의 매력이 있다. " /></p>
                    </div><!-- end define -->
                </c:when>
                <c:when test="${type eq 2}">
                    <h3 style="margin-bottom:20px;"><img src="${imageServer}/images/service/h3_fountainPen02.gif" alt="초보자의 만년필의 선택방법" /></h3>
                    <ul class="explain-list">
                        <li style="margin-bottom:30px;padding-bottom:10px;border-bottom:1px solid #DADADA;">
                            <h4><img src="${imageServer}/images/service/h4_fountainPen01.gif" alt="* 선택 포인트 *" /></h4>
                            <p class="mgt10"><img src="${imageServer}/images/service/h4_fountainPen01_explain.gif" alt="선택 포인트 설명" /></p>
                        </li>
                        <li style="margin-bottom:30px;padding-bottom:10px;border-bottom:1px solid #DADADA;">
                            <h4><img src="${imageServer}/images/service/h4_fountainPen02.gif" alt="(1) 디자인" /></h4>
                            <p class="mgt10"><img src="${imageServer}/images/service/h4_fountainPen02_explain.gif" alt="디자인 설명" /></p>
                        </li>
                        <li style="margin-bottom:30px;padding-bottom:10px;border-bottom:1px solid #DADADA;">
                            <h4><img src="${imageServer}/images/service/h4_fountainPen03.gif" alt="(2) 펜촉" /></h4>
                            <p class="mgt10"><img src="${imageServer}/images/service/h4_fountainPen03_explain.gif" alt="펜촉 설명" /></p>
                        </li>
                        <li style="margin-bottom:30px;padding-bottom:10px;border-bottom:1px solid #DADADA;">
                            <h4><img src="${imageServer}/images/service/h4_fountainPen04.gif" alt="(3) 재질" /></h4>
                            <p class="mgt10"><img src="${imageServer}/images/service/h4_fountainPen04_explain.gif" alt="재질 설명" /></p>
                        </li>
                        <li style="margin-bottom:30px;padding-bottom:10px;border-bottom:1px solid #DADADA;">
                            <h4><img src="${imageServer}/images/service/h4_fountainPen05.gif" alt="(4) 가격" /></h4>
                            <p><img src="${imageServer}/images/service/h4_fountainPen05_explain.gif" alt="가격 설명" /></p>
                        </li>
                    </ul>
                </c:when>
                <c:when test="${type eq 3}">
                    <h3 style="margin-bottom:10px;"><img src="${imageServer}/images/service/h3_fountainPen04_01.gif" alt="만년필의 구조와 특성" /></h3>
                    <div class="construction-plan"><img src="${imageServer}/images/service/h4_fountainPen04_section01.gif" alt="만년필의 기본 구조 및 명칭" /></div>
                    <h3 style="margin-bottom:10px;"><img src="${imageServer}/images/service/h3_fountainPen04_02.gif" alt="펜촉의 기본 구조 및 명칭" /></h3>
                    <div class="pen-plan"><img src="${imageServer}/images/service/h4_fountainPen04_section02.gif" alt="펜촉의 기본 구조 및 명칭 설명" /></div>
                    <h3 style="margin-bottom:10px;"><img src="${imageServer}/images/service/h3_fountainPen04_03.gif" alt="만년필 펜촉 세척방법" /></h3>
                    <div class="use-guide"><img src="${imageServer}/images/service/h4_fountainPen04_section03.gif" alt="세척 방법설명" /></div>
                    <h3 style="margin-bottom:10px;"><img src="${imageServer}/images/service/h3_fountainPen04_04.gif" alt="만년필 부품의 기능" /></h3>
                    <div class="part-function"><img src="${imageServer}/images/service/h4_fountainPen04_section04.gif" alt="만년필 부품의 기능 설명" /></div>
                </c:when>
                <c:otherwise>
                    <h3 class="title01"><img src="${imageServer}/images/service/h3_fountainPen05_01.gif" alt="필기구 용어사전 필기구에 대한 용어 및 이용방법에 대한 자세한 정보 제공을 통해 제품의 사용을 도와드립니다." /></h3>
                    <ul class="dictionary">
                        <li>
                            <dl class="term">
                                <dt><img src="${imageServer}/images/service/char01.gif" alt="ㄱ에 해당 하는 단어" /></dt>
                                <dd>
                                    <dl class="words">
                                        <dt>건메탕</dt>
                                        <dd>내구성이 뛰어나며 강해서 배럴등에 사용 됩니다.</dd>
                                        <dt>골드 플레이트, 실버 플레이트(금도금,은도금)</dt>
                                        <dd>금속에 금,은으로 피막을 만들기 위한 전해가공으로 이 처리를 한 제품은 내구성이 현격히 상승합니다.</dd>
                                        <dt>그립</dt>
                                        <dd>
                                            말 그대로 잡는 부분. 그립감이 좋다, 하는 것은 잡을 때의 느낌이 좋다는 것을 말하는 것이다.<br /> 
                                            그립감을 중시하여 만들어진 샤프는 펜텔의 에르고노믹스, 파일롯의 닥터그립, 제브라의 에어피트, 미츠비시의 알파젤 등이 있다.
                                        </dd>
                                        <dt>금촉</dt>
                                        <dd>
                                            만년필의 펜촉은 사용하는 잉크가 산성이기 때문에 아무래도 내산성이 뛰어난 금이 사용 됩니다.<br />
                                            순금은 24K-1000 /  18금은 18K-750 / 14금은 14K-585 로 표기 됩니다.
                                        </dd>
                                        <dt>금도금</dt>
                                        <dd>열과 압력으로 물리적인 처리를 하여 금속에 입히는 것, 14k도금/18k도금.</dd>
                                    </dl>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl class="term">
                                <dt><img src="${imageServer}/images/service/char02.gif" alt="ㄴ에 해당 하는 단어" /></dt>
                                <dd>
                                    <dl class="words">
                                        <dt>노크</dt>
                                        <dd>
                                            노크란 샤프를 누를때를 말한다.흔히 좋은 샤프들은 노크감이 좋다고 하는데 노크감이 좋다는 것은 노크가 딱딱 끊긴다는 것이다.<br />
                                            노크감이 좋은 것은 사람마다 다르지만 노크가 딱딱 끊기는것이 좋다.
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl class="term">
                                <dt><img src="${imageServer}/images/service/char03.gif" alt="ㄹ에 해당 하는 단어" /></dt>
                                <dd>
                                    <dl class="words">
                                        <dt>락카</dt>
                                        <dd>
                                            화학적으로 합성된 도료를 두껍게 필하여 마감.열이나 습도에 강함.
                                        </dd>
                                        <dt>롤러펜 (수성펜)</dt>
                                        <dd>
                                            만년필의 부드러운 필기감과 볼펜의 실용성을 동시에 갖춘 필기구.
                                        </dd>
                                        <dt>로듐</dt>
                                        <dd>
                                            백금계의 금속.플래티늄보다 고가의 귀금속 입니다.<br />
                                            극소량으로 뛰어난 광택과 경도,내식성을 가진다.
                                        </dd>
                                        <dt>레진</dt>
                                        <dd>
                                            수지의 일종.주세와 경화제를 섞어서 실리콘 틀에 부어서 모양을 만듭니다.<br />
                                            미묘한 색채 표현 및 크리스탈 마감과 같은 느낌으로 많은 메카에서 사용.
                                        </dd>
                                        <dt>리필심</dt>
                                        <dd>
                                            볼펜 종류의 필기구의 잉크를 다썻을때, 잉크를 교체해줄수 있는 심을 말한다.
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl class="term">
                                <dt><img src="${imageServer}/images/service/char04.gif" alt="ㅁ 에 해당 하는 단어" /></dt>
                                <dd>
                                    <dl class="words">
                                        <dt>마끼에</dt>
                                        <dd>
                                            마끼예는 금,은 가루를 칠기의 표면에 뿌려 무늬를 나타내는 것으로 7세기 나라 시대로부터 오늘날까지 일본에서 개발되어 전해 내려오고  있는 독특한 일본의 공예 기법.<br />
                                            옻기에 옻을 이용하여 그림이나 무늬를 넣고,금은분을 뿌린 후에 더욱 가공,연마하는것을 말합니다.
                                        </dd>
                                        <dt>무게중심</dt>
                                        <dd>
                                            말그대로 무게의 중심 위치이다.필기구를 손가락 위에 올리고 평행이 되는 곳을 찾으면 그곳이 무게중심이라고 할 수 있다.  <br />
                                            무게중심이 아래쪽이면 살짝잡아도 글씨가 많이씩 나가는 경우가 있고위쪽에 있다면 살짝 잡을경우 뒤로 넘어가는 경우도 생긴다.
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl class="term">
                                <dt><img src="${imageServer}/images/service/char05.gif" alt="ㅂ에 해당 하는 단어" /></dt>
                                <dd>
                                    <dl class="words">
                                        <dt>버메일</dt>
                                        <dd>
                                            스털링 실버에 금도장을 한 것 입니다.
                                        </dd>
                                        <dt>배럴</dt>
                                        <dd>
                                            샤프내부의 샤프심을 넣어두고 샤프심을 배출하는 통.<br />
                                            배럴을 고정시키고 노크를하면 샤프심이 나온다
                                        </dd>
                                        <dt>브라스</dt>
                                        <dd>
                                            신주,황동이라고 불리운다.동과 아연의 합금.
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl class="term">
                                <dt><img src="${imageServer}/images/service/char06.gif" alt="ㅅ 에 해당 하는 단어" /></dt>
                                <dd>
                                    <dl class="words">
                                        <dt>샤프심 농도</dt>
                                        <dd>
                                            샤프심 농도란 샤프심이 얼마나 진하고 연한가를 나타낸다.<br />
                                            B의 숫자가 클수록 진하나 무르고 빨리 닳는다.<br />
                                            H의 숫자가 클수록 연하나 단단하고 천천히 닳는다.
                                        </dd>
                                        <dt>샤프심 배출량</dt>
                                        <dd>
                                            말그대로 샤프심이 한번 노크 됐을때 얼마나 나오는지 이다. 이것으로 샤프의 가격이 큰 차이가 나게 된다.<br />
                                            일반적으로 펜텔의 샤프들은 한번 노크시 0.5mm의 배출량을 보이며 로트링, 소수의 파카 제품, 소수의 제브라 제품들 또한 그러하다 반면에 국산 제품들은 샤프심의 배출량이 들쭉날쭉하다.
                                        </dd>
                                        <dt>스털링 실버</dt>
                                        <dd>
                                            순도 92.5% 이상의 은을 순은이라고 합니다. <br />
                                            이 순도 높은 은 제품만을 스털링 실버라고 합니다.
                                        </dd>
                                        <dt>슬릿</dt>
                                        <dd>
                                            절개선이라고도 하며 만년필의 펜촉의 선단부터 잘려진 선으로, 펜심을 지나온 잉크를 펜 포인트까지 전달하는 것 외에 잉크의 유량이나 펜촉의 탄력에도 영향을 줍니다.
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl class="term">
                                <dt><img src="${imageServer}/images/service/char07.gif" alt="ㅇ 에 해당 하는 단어" /></dt>
                                <dd>
                                    <dl class="words">
                                        <dt>아크릴</dt>
                                        <dd>
                                            투과성이 탁월하며 가공성도 뛰어나 절단,접착등의 우수한 가공성을 보여줍니다.
                                        </dd>
                                        <dt>에보나이트</dt>
                                        <dd>
                                            가장 오래된 만년필 소재 입니다.기계적 강도가 강한것이 특징이며 잉크의 흡수력이 좋기 때문에 펜촉에 에보나이트를 사용하는 경우도 많습니다.
                                        </dd>
                                        <dt>유격</dt>
                                        <dd>
                                            간단히 말하면 어느 사이의 '틈'. 보통 샤프심과 샤프촉 사이의 틈을 말한다.<br />
                                            - 유격 찾는 법 - 샤프심을 한 2mm만 뽑아본 다음 손톱으로 잡고 양쪽으로 약간 휘어본다.
                                        </dd>
                                        <dt>이리듐</dt>
                                        <dd>
                                            펜촉의 선단에 붙어있는 은색의 빛나는 작은 금속 입니다.치밀하고 내구성이 뛰어나며 마모가 잘 안되어 펜 소재로 좋습니다.
                                        </dd>
                                        <dt>잉크</dt>
                                        <dd>
                                            만년필의 잉크는 내수성,보존성이 있는 잉크와 수용성 잉크가 있다.색의 종류와 성분이 다양하며 카트리지 잉크와 병잉크가 있습니다.
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl class="term">
                                <dt><img src="${imageServer}/images/service/char08.gif" alt=" ㅋ 에 해당 하는 단어" /></dt>
                                <dd>
                                    <dl class="words">
                                        <dt>크롬</dt>
                                        <dd>
                                            주석과 비슷한 은벅색의 단단한 금속입니다.녹에  강하며, 녹 방지를 목적으로 크롬 도장을 주로 합니다.
                                        </dd>
                                        <dt>컨버터</dt>
                                        <dd>
                                            컨버터는 일반적으로 병행 사용방식으로 사용되는 만년필의 잉크 흡입기로 사용합니다.
                                        </dd>
                                        <dt>클립</dt>
                                        <dd>
                                            사전적 의미는 샤프나 만년필의 뚜껑 따위에 달려 주머니 따위에 끼우는 쇠이다. 
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl class="term">
                                <dt><img src="${imageServer}/images/service/char09.gif" alt="ㅌ 에 해당 하는 단어" /></dt>
                                <dd>
                                    <dl class="words">
                                        <dt>투톤장식</dt>
                                        <dd>
                                            2가지의 색이 혼재되어 있는 마감 방식, 펜촉에 금과 은 2가지 색으로 마감칠 되어 있는 것.
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                        </li>
                                            <li>
                            <dl class="term">
                                <dt><img src="${imageServer}/images/service/char10.gif" alt="ㅍ 에 해당 하는 단어" /></dt>
                                <dd>
                                    <dl class="words">
                                        <dt>팔라듐</dt>
                                        <dd>
                                            백금계 금속. 가공성이 뛰어나고 화학약품에 대하여 저항력이 강합니다.
                                        </dd>
                                        <dt>펜촉</dt>
                                        <dd>
                                            만년필의 펜촉은 펜심과 닙으로 분리된다. 닙은 그 소재에 따라 내구성 및 필기감이 달라집니다.<br />
                                            저가형 라인은 스텐스틸을 사용. 후 실버나 금도장을 한 제품이 대다수.<br />
                                            고가의 제품은 14k 이상의 것이 보급,녹이나 부식에 강하며 잉크에도 부패되지 않는  강한 내구성을 가지고 있습니다.
                                        </dd>
                                        <dt>펜심</dt>
                                        <dd>
                                            잉크탱크에서 펜심으로 잉크를 전달하기 위해 중요한 부분,<br />
                                            모세관 현상에 의해 펜촉으로 잉크를 제공 합니다.
                                        </dd>
                                        <dt>폴리카보네이트</dt>
                                        <dd>
                                            흠집이나 충격에 강하며 투명성이 뛰어나며 열에도 강한 성질을 지닌 수지 입니다.
                                        </dd>
                                        <dt>플래티늄</dt>
                                        <dd>
                                            플래티늄은 아름다운 은백색의 광택을 가지고 있어,희소가치가 있는 고가의 귀금속 입니다.
                                        </dd>
                                        <dt>필기감</dt>
                                        <dd>
                                            필기감이란 말 그대로 필기 도구를 이용하여 필기 할 때의 느낌을 말하는 것이다. 필기구에 따라 차이가  날 수 있다.
                                        </dd>
                                        <dt>필압</dt>
                                        <dd>
                                            필기를 할 때 세게 누르고 쓰는 정도를 나타낼때 쓴다.
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl class="term">
                                <dt><img src="${imageServer}/images/service/char11.gif" alt="ㅎ 에 해당 하는 단어" /></dt>
                                <dd>
                                    <dl class="words">
                                        <dt>화이트 골드</dt>
                                        <dd>
                                            금에 10~15% 팔라듐을 혼합한 것 입니다.
                                        </dd>
                                    </dl>
                                </dd>
                            </dl>
                        </li>
                    </ul>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>