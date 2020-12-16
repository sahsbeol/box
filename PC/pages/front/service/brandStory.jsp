<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="popup"/>
<html>
<head>
<title>브랜드스토리 - NEW ME HOTTRACKS</title>
</head>
<body>
<div style="width:830px;">
    <h1><img src="${imageServer}/images/renewal/common/tit_pop_service01.gif" alt="브랜드 스토리" /></h1>
    <div class="pop_cont">
        <ul class="list_type02">
            <li>고급필기구의 진정한 가치를  말해주는 브랜드 스토리를 모았습니다.</li>
        </ul>
        <div class="search_sort_tab mgt20">
            <ul>
                <li><a href="/ht/brandStory?type=1" class="on">브랜드 스토리<span class="arrow"> </span></a></li>
                <li><a href="/ht/fountainPen?type=1" style="border-right:none;">만년필 사용법<span class="arrow"> </span></a></li>
                <li><a href="/ht/carvingService" style="border-right:none;">각인서비스<span class="arrow"> </span></a></li>
                <li><a href="/ht/fountainPenFaq?type=1">자주묻는 질문<span class="arrow"> </span></a></li>
            </ul>
        </div>
        <div class="tbl_top c_both">
            <div class="f_left">
                <ul class="tab_btn02 sort">
                    <li class="${type eq '1'?'active':''}"><a href="/ht/brandStory?type=1">파카</a></li>
                    <li class="${type eq '2'?'active':''}"><a href="/ht/brandStory?type=2">워터맨</a></li>
                    <li class="${type eq '3'?'active':''}"><a href="/ht/brandStory?type=3">펠리칸</a></li>
                    <li class="${type eq '4'?'active':''}"><a href="/ht/brandStory?type=4">크로스</a></li>
                    <li class="${type eq '5'?'active':''}"><a href="/ht/brandStory?type=5">쉐퍼</a></li>
                    <li class="${type eq '6'?'active':''}"><a href="/ht/brandStory?type=6">파버카스텔</a></li>
                    <li class="${type eq '7'?'active':''}"><a href="/ht/brandStory?type=7">라미</a></li>
                    <li class="${type eq '8'?'active':''}"><a href="/ht/brandStory?type=8">까렌다쉬</a></li>
                    <li class="${type eq '9'?'active':''}"><a href="/ht/brandStory?type=9">그라폰</a></li>
                    <li class="${type eq '10'?'active':''}"><a href="/ht/brandStory?type=10">스위스밀리터리</a></li>
                    <li class="${type eq '11'?'active':''}"><a href="/ht/brandStory?type=11">플래티넘</a></li>
                    <li class="${type eq '12'?'active':''}"><a href="/ht/brandStory?type=12">세일러</a></li>
                    <li class="${type eq '13'?'active':''}"><a href="/ht/brandStory?type=13">피에르가르뎅</a></li>
                </ul>
            </div>
        </div>
        <div style="text-align:center;">
            <c:choose>
               <c:when test="${type eq 1}">
                    <div class="brand-name">
                        <img src="${imageServer}/images/service/brand_title01.gif"  alt="파카" />
                    </div><!-- end  brand-name -->
                    <div class="brand-explain01">
                        <img src="${imageServer}/images/service/brand01_sub01.gif"  alt="만년필의 명가의 탄생" />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain02">
                        <img src="${imageServer}/images/service/brand01_sub02.gif"  alt="역사 중심에선 파카" />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain03">
                        <img src="${imageServer}/images/service/brand01_sub03.gif" alt="파카를 사랑한 사람들" />
                    </div><!-- end brand-explain03  -->
                </c:when>
                <c:when test="${type eq 2}">
                    <div class="brand-name">
                        <img src="${imageServer}/images/service/brand_title02.gif"  alt="워터맨" />
                    </div><!-- end  brand-name -->
                    <div class="brand-explain01">
                        <img src="${imageServer}/images/service/brand02_sub01.gif"  alt="세기를 뛰어넘는 가치를 지닌 펜, 워터맨" />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain02">
                        <img src="${imageServer}/images/service/brand02_sub02.gif"  alt="워터맨, 만년필의 역사를 열다." />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain03">
                        <img src="${imageServer}/images/service/brand02_sub03.gif" alt="워터맨, 한국 명품만년필 시장을 이끌다" />
                    </div><!-- end brand-explain03  -->
                </c:when>
                <c:when test="${type eq 3}">
                    <div class="brand-name">
                        <img src="${imageServer}/images/service/brand_title03.gif"  alt="펠리칸" />
                    </div><!-- end  brand-name -->
                    <div class="brand-explain01">
                        <img src="${imageServer}/images/service/brand03_sub01.gif"  alt="펠리칸의 역사01 " />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain02">
                        <img src="${imageServer}/images/service/brand03_sub02.gif"  alt="펠리칸의 역사02" />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain03">
                        <img src="${imageServer}/images/service/brand03_sub03.gif" alt="펠리칸의 역사03" />
                    </div><!-- end brand-explain03  -->
                </c:when>
                <c:when test="${type eq 4}">
                    <div class="brand-name">
                        <img src="${imageServer}/images/service/brand_title04.gif"  alt="크로스" />
                    </div><!-- end  brand-name -->
                    <div class="brand-explain01">
                        <img src="${imageServer}/images/service/brand04_sub01.gif"  alt="160년 전통 미국 대표 명품 필기구 브랜드 - 크로스01 " />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain02">
                        <img src="${imageServer}/images/service/brand04_sub02.gif"  alt="160년 전통 미국 대표 명품 필기구 브랜드 - 크로스02" />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain03">
                        <img src="${imageServer}/images/service/brand04_sub03.gif" alt="160년 전통 미국 대표 명품 필기구 브랜드 - 크로스03" />
                    </div><!-- end brand-explain03  -->
                </c:when>
                <c:when test="${type eq 5}">
                    <div class="brand-name">
                        <img src="${imageServer}/images/service/brand_title05.gif"  alt="쉐퍼" />
                    </div><!-- end  brand-name -->
                    <div class="brand-explain01">
                        <img src="${imageServer}/images/service/brand05_sub01.gif"  alt="쉐퍼 브랜드 소개 01 " />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain02">
                        <img src="${imageServer}/images/service/brand05_sub02.gif"  alt="쉐퍼 브랜드 소개 02" />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain03">
                        <img src="${imageServer}/images/service/brand05_sub03.gif" alt="쉐퍼 브랜드 소개 03" />
                    </div><!-- end brand-explain03  -->
                </c:when>
                <c:when test="${type eq 6}">
                    <div class="brand-name">
                        <img src="${imageServer}/images/service/brand_title06.gif"  alt="파버카스텔" />
                    </div><!-- end  brand-name -->
                    <div class="brand-explain01">
                        <img src="${imageServer}/images/service/brand06_sub01.gif"  alt="49을 지켜 내려온 세계적인 장인정신
                            1761년에 독일에서 설립된 Faber - Castell社는 세계에서 가장 오래된 필기구의 명가입니다 " />
                    </div><!-- end brand-explain02  -->
                    <ul>
                        <li><img src="${imageServer}/images/service/brand06_sub02.gif" alt="파버카스텔 브랜드 세대별 리스트01" /></li>
                        <li><img src="${imageServer}/images/service/brand06_sub03.gif" alt="파버카스텔 브랜드 세대별 리스트02" /></li>
                        <li><img src="${imageServer}/images/service/brand06_sub04.gif" alt="파버카스텔 브랜드 세대별 리스트03" /></li>
                        <li><img src="${imageServer}/images/service/brand06_sub05.gif" alt="파버카스텔 브랜드 세대별 리스트04" /></li>
                        <li><img src="${imageServer}/images/service/brand06_sub06.gif" alt="파버카스텔 브랜드 세대별 리스트05" /></li>
                        <li><img src="${imageServer}/images/service/brand06_sub07.gif" alt="파버카스텔 브랜드 세대별 리스트06" /></li>
                        <li><img src="${imageServer}/images/service/brand06_sub08.gif" alt="파버카스텔 브랜드 세대별 리스트07" /></li>
                        <li><img src="${imageServer}/images/service/brand06_sub09.gif" alt="파버카스텔 브랜드 세대별 리스트08" /></li>
                    </ul>
                </c:when>
                <c:when test="${type eq 7}">
                    <div class="brand-name">
                        <img src="${imageServer}/images/service/brand_title07.gif"  alt="라미" />
                    </div><!-- end  brand-name -->
                    <div class="brand-explain01">
                        <img src="${imageServer}/images/service/brand07_sub01.gif"  alt="라미 브랜드 설명01 " />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain02">
                        <img src="${imageServer}/images/service/brand07_sub02.gif"  alt="라미 브랜드 설명01" />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain03">
                        <img src="${imageServer}/images/service/brand07_sub03.gif" alt="라미 브랜드 설명01" />
                    </div><!-- end brand-explain03  -->
                    <div class="brand-explain04">
                        <img src="${imageServer}/images/service/brand07_sub04.gif" alt="세계에서 누가 LAMY 를 사용 하나요?" />    
                    </div><!-- end brand-explain04 -->
                </c:when>
                <c:when test="${type eq 8}">
                    <div class="brand-name">
                        <img src="${imageServer}/images/service/brand_title08.gif"  alt="까렌다쉬" />
                    </div><!-- end  brand-name -->
                    <div class="brand-explain01">
                        <img src="${imageServer}/images/service/brand08_sub01.gif"  alt="까렌다쉬 브랜드 설명01 " />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain02">
                        <img src="${imageServer}/images/service/brand08_sub02.gif"  alt="까렌다쉬 브랜드 설명02" />
                    </div><!-- end brand-explain02  -->
                </c:when>
                <c:when test="${type eq 9}">
                    <div class="brand-name">
                        <img src="${imageServer}/images/service/brand_title09.gif"  alt="그라폰" />
                    </div><!-- end  brand-name -->
                    <div class="brand-explain01">
                        <img src="${imageServer}/images/service/brand09_sub01.gif"  alt="그라폰 브랜드 설명01 " />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain02">
                        <img src="${imageServer}/images/service/brand09_sub02.gif"  alt="그라폰 브랜드 설명02" />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain03">
                        <img src="${imageServer}/images/service/brand09_sub03.gif"  alt="그라폰 브랜드 설명02" />
                    </div><!-- end brand-explain03  -->
                </c:when>
                <c:when test="${type eq 10}">
                    <div class="brand-name">
                        <img src="${imageServer}/images/service/brand_title10.gif"  alt=" 스위스밀리터리" />
                    </div><!-- end  brand-name -->
                    <div class="brand-explain01">
                        <img src="${imageServer}/images/service/brand10_sub01.gif"  alt=" 스위스밀리터리 브랜드 설명01 " />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain02">
                        <img src="${imageServer}/images/service/brand10_sub02.gif"  alt=" 스위스밀리터리 브랜드 설명02" />
                    </div><!-- end brand-explain02  -->
                </c:when>
                <c:when test="${type eq 11}">
                    <div class="brand-name">
                        <img src="${imageServer}/images/service/brand_title11.gif"  alt="플래티넘" />
                    </div><!-- end  brand-name -->
                    <div class="brand-explain01">
                        <img src="${imageServer}/images/service/brand11_sub01.gif"  alt="플래티넘 브랜드 설명01 " />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain02">
                        <img src="${imageServer}/images/service/brand11_sub02.gif"  alt="플래티넘 브랜드 설명02" />
                    </div><!-- end brand-explain02  -->
                </c:when>
                <c:when test="${type eq 12}">
                    <div class="brand-name">
                        <img src="${imageServer}/images/service/brand_title12.gif"  alt="세일러" />
                    </div><!-- end  brand-name -->
                    <div class="brand-explain01">
                        <img src="${imageServer}/images/service/brand12_sub01.gif"  alt="세일러 브랜드 설명01 " />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain02">
                        <img src="${imageServer}/images/service/brand12_sub02.gif"  alt="세일러 브랜드 설명02" />
                    </div><!-- end brand-explain02  -->
                </c:when>
                <c:otherwise>
                    <div class="brand-name">
                        <img src="${imageServer}/images/service/brand_title13.gif"  alt="피에르가르뎅" />
                    </div><!-- end  brand-name -->
                    <div class="brand-explain01">
                        <img src="${imageServer}/images/service/brand13_sub01.gif"  alt="피에르가르뎅 브랜드 설명01 " />
                    </div><!-- end brand-explain02  -->
                    <div class="brand-explain02">
                        <img src="${imageServer}/images/service/brand13_sub02.gif"  alt="피에르가르뎅 브랜드 설명02" />
                    </div><!-- end brand-explain02  -->
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>