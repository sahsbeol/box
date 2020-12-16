<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<title>브랜드메인 - NEW ME HOTTRACKS</title>
<!--  SNS 공유 내용 -->
<meta property="og:type" content="website"/>
<meta property="og:title" content="HOTTRACKS - 생활 속 감성충전소"/>
<meta property="og:url" content="${defaultHost}/ht/hot/brandMain"/>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/logo_over.gif"/>
<!--  SNS 공유 내용 -->
<script type="text/javascript" src="/js/owl.carousel.min.js"></script>
<script>
$(document).ready(function() {
  $("#record_carousel").owlCarousel({
      navigation : true,
      slideSpeed : 0,
      paginationSpeed : 0,
      singleItem : true,
      rewindSpeed :  0
  });
});
</script>
</head>
<body>
<!-- brand_in_banner -->
<div class="brand_in_banner tab_wrap">
    <h2 class="tit"><img src="${imageServer}/images/renewal/common/tit_hot_brand_in.gif" alt="Hot Brand In" /></h2>
    <p class="tit_comt">핫트랙스의 다양한 브랜드를 쉽고 빠르게 만나보세요.</p>
    <ul class="prod_tab tab_btn">
        <li><a href="#hbi01" class="on"><span>QUUT</span></a></li>
        <li><a href="#hbi02"><span>Sassafras</span></a></li>
        <li><a href="#hbi03"><span>Can you imagine</span></a></li>
    </ul>
    <div class="brand_in_list_wrap tab_pannels">
        <ul id="hbi01" class="brand_in_list pannel" style="display:block;"><!-- QUUT -->
            <li class="first"><a href="#"><img src="${imageServer}/images/renewal/thums/950_440.jpg" alt="" /></a></li>
            <li><a href="#"><img src="${imageServer}/images/renewal/thums/290_140_1.jpg" alt="" /></a></li>
            <li><a href="#"><img src="${imageServer}/images/renewal/thums/290_140_2.jpg" alt="" /></a></li>
            <li class="last"><a href="#"><img src="${imageServer}/images/renewal/thums/290_140_3.jpg" alt="" /></a></li>
        </ul>
        <ul id="hbi02" class="brand_in_list pannel"><!-- Sassafras -->
            <li class="first"><a href="#"><img src="${imageServer}/images/renewal/thums/950_440.jpg" alt="" /></a></li>
            <li><a href="#"><img src="${imageServer}/images/renewal/thums/290_140_1.jpg" alt="" /></a></li>
            <li><a href="#"><img src="${imageServer}/images/renewal/thums/290_140_2.jpg" alt="" /></a></li>
            <li class="last"><a href="#"><img src="${imageServer}/images/renewal/thums/290_140_3.jpg" alt="" /></a></li>
        </ul>
        <ul id="hbi03" class="brand_in_list pannel"><!-- Can you imagine -->
            <li class="first"><a href="#"><img src="${imageServer}/images/renewal/thums/950_440.jpg" alt="" /></a></li>
            <li><a href="#"><img src="${imageServer}/images/renewal/thums/290_140_1.jpg" alt="" /></a></li>
            <li><a href="#"><img src="${imageServer}/images/renewal/thums/290_140_2.jpg" alt="" /></a></li>
            <li class="last"><a href="#"><img src="${imageServer}/images/renewal/thums/290_140_3.jpg" alt="" /></a></li>
        </ul>
    </div>
</div>
<!-- //brand_in_banner -->
<!-- new_brand -->
<div class="new_brand_Wrap">
    <h2 class="tit"><img src="${imageServer}/images/renewal/common/tit_new_brand.gif" alt="new brand" /></h2>
    <p class="tit_comt">핫트랙스의 새로운 브랜드와 함께 하세요.</p>
    <div class="new_brand_banner tab_wrap02">
        <ul id="nb1" class="new_brand_list tab_pannels">
            <li class="first">
                <a href="#">
                    <span class="img_box"><img src="${imageServer}/images/renewal/thums/478_464.jpg" alt="" /></span>
                    <div class="brand_info">
                        <strong class="brand_name">
                            Mamas & Papas11
                            <span class="lang_ko">마마스앤파파스</span>
                        </strong>
                        <span class="brand_comt">전세계 아기들과 함께하는<br /> 영국대표 프리미엄 영유아용품 최신 트랜드 브랜드</span>
                    </div>
                </a>
            </li>
            <li>
                <a href="#">
                    <span class="img_box"><img src="${imageServer}/images/renewal/thums/195_199_1.jpg" alt="" /></span>
                    <div class="brand_info">
                        <strong class="brand_name">
                            Friendskorea11
                            <span class="lang_ko">프렌즈코리아</span>
                        </strong>
                    </div>
                </a>
            </li>
            <li>
                <a href="#">
                    <span class="img_box"><img src="${imageServer}/images/renewal/thums/195_199_2.jpg" alt="" /></span>
                    <div class="brand_info">
                        <strong class="brand_name">
                            Cheetah11
                            <span class="lang_ko">치타</span>
                        </strong>
                    </div>
                </a>
            </li>
            <li class="last">
                <a href="#">
                    <span class="img_box"><img src="${imageServer}/images/renewal/thums/195_199_3.jpg" alt="" /></span>
                    <div class="brand_info">
                        <strong class="brand_name">
                            konfidence11
                            <span class="lang_ko">컨피던스</span>
                        </strong>
                    </div>
                </a>
            </li>
        </ul>
        <ul id="nb2" class="new_brand_list tab_pannels">
            <li class="first">
                <a href="#">
                    <span class="img_box"><img src="${imageServer}/images/renewal/thums/478_464.jpg" alt="" /></span>
                    <div class="brand_info">
                        <strong class="brand_name">
                            Mamas & Papas11
                            <span class="lang_ko">마마스앤파파스</span>
                        </strong>
                        <span class="brand_comt">전세계 아기들과 함께하는<br /> 영국대표 프리미엄 영유아용품 최신 트랜드 브랜드</span>
                    </div>
                </a>
            </li>
            <li>
                <a href="#">
                    <span class="img_box"><img src="${imageServer}/images/renewal/thums/195_199_1.jpg" alt="" /></span>
                    <div class="brand_info">
                        <strong class="brand_name">
                            Friendskorea11
                            <span class="lang_ko">프렌즈코리아</span>
                        </strong>
                    </div>
                </a>
            </li>
            <li>
                <a href="#">
                    <span class="img_box"><img src="${imageServer}/images/renewal/thums/195_199_2.jpg" alt="" /></span>
                    <div class="brand_info">
                        <strong class="brand_name">
                            Cheetah11
                            <span class="lang_ko">치타</span>
                        </strong>
                    </div>
                </a>
            </li>
            <li class="last">
                <a href="#">
                    <span class="img_box"><img src="${imageServer}/images/renewal/thums/195_199_3.jpg" alt="" /></span>
                    <div class="brand_info">
                        <strong class="brand_name">
                            konfidence11
                            <span class="lang_ko">컨피던스</span>
                        </strong>
                    </div>
                </a>
            </li>
        </ul>
        <ul id="nb3" class="new_brand_list tab_pannels">
            <li class="first">
                <a href="#">
                    <span class="img_box"><img src="${imageServer}/images/renewal/thums/478_464.jpg" alt="" /></span>
                    <div class="brand_info">
                        <strong class="brand_name">
                            Mamas & Papas11
                            <span class="lang_ko">마마스앤파파스</span>
                        </strong>
                        <span class="brand_comt">전세계 아기들과 함께하는<br /> 영국대표 프리미엄 영유아용품 최신 트랜드 브랜드</span>
                    </div>
                </a>
            </li>
            <li>
                <a href="#">
                    <span class="img_box"><img src="${imageServer}/images/renewal/thums/195_199_1.jpg" alt="" /></span>
                    <div class="brand_info">
                        <strong class="brand_name">
                            Friendskorea11
                            <span class="lang_ko">프렌즈코리아</span>
                        </strong>
                    </div>
                </a>
            </li>
            <li>
                <a href="#">
                    <span class="img_box"><img src="${imageServer}/images/renewal/thums/195_199_2.jpg" alt="" /></span>
                    <div class="brand_info">
                        <strong class="brand_name">
                            Cheetah11
                            <span class="lang_ko">치타</span>
                        </strong>
                    </div>
                </a>
            </li>
            <li class="last">
                <a href="#">
                    <span class="img_box"><img src="${imageServer}/images/renewal/thums/195_199_3.jpg" alt="" /></span>
                    <div class="brand_info">
                        <strong class="brand_name">
                            konfidence11
                            <span class="lang_ko">컨피던스</span>
                        </strong>
                    </div>
                </a>
            </li>
        </ul>
        <div class="indicator tab_btn">
            <ul>
                <li><a href="#nb1" class="on"><span>1</span></a></li>
                <li><a href="#nb2"><span>2</span></a></li>
                <li><a href="#nb3"><span>3</span></a></li>
            </ul>
        </div>
    </div>
</div>
<!-- //new_brand -->
<p class="main_bg_line"></p>
<!-- brand_search -->
<div class="brand_search_wrap">
    <h2 class="tit"><img src="${imageServer}/images/renewal/common/tit_brand_search.gif" alt="brand search" /></h2>
    <div class="top_search">
        <form>
            <fieldset>
                <div class="search_box" style="width:370px;">
                    <label for="search_keyword" class="hidden_obj">검색</label><input type="text" id="search_keyword" class="search_keyword" name="" value="" title="검색어 입력" style="width:306px;">
                    <a href="#" class="search_btn"><span>검색</span></a>
                    <span class="exm_txt">브랜드명으로 찾기</span>
                </div>
            </fieldset>
        </form>
    </div>
    <div class="tab_search_wrap">
        <p class="tit_search_lineup"><span>가나다순</span>으로 찾기</p>
        <ul class="tab_alphabet_list">
            <li class="active"><a href="#">가</a></li>
            <li><a href="#">나</a></li>
            <li><a href="#">다</a></li>
            <li><a href="#">라</a></li>
            <li><a href="#">마</a></li>
            <li><a href="#">바</a></li>
            <li><a href="#">사</a></li>
            <li><a href="#">아</a></li>
            <li><a href="#">자</a></li>
            <li><a href="#">차</a></li>
            <li><a href="#">카</a></li>
            <li><a href="#">타</a></li>
            <li><a href="#">파</a></li>
            <li><a href="#">하</a></li>
            <li><a href="#">기타</a></li>
        </ul>
        <p class="tit_search_lineup"><span>알파벳순</span>으로 찾기</p>
        <ul class="tab_alphabet_list">
            <li class="active"><a href="#">A</a></li>
            <li><a href="#">B</a></li>
            <li><a href="#">C</a></li>
            <li><a href="#">D</a></li>
            <li><a href="#">E</a></li>
            <li><a href="#">F</a></li>
            <li><a href="#">G</a></li>
            <li><a href="#">H</a></li>
            <li><a href="#">I</a></li>
            <li><a href="#">J</a></li>
            <li><a href="#">K</a></li>
            <li><a href="#">L</a></li>
            <li><a href="#">M</a></li>
            <li><a href="#">N</a></li>
            <li><a href="#">O</a></li>
            <li><a href="#">P</a></li>
            <li><a href="#">Q</a></li>
            <li><a href="#">R</a></li>
            <li><a href="#">S</a></li>
            <li><a href="#">T</a></li>
            <li><a href="#">U</a></li>
            <li><a href="#">V</a></li>
            <li><a href="#">W</a></li>
            <li><a href="#">X</a></li>
            <li><a href="#">Y</a></li>
            <li><a href="#">Z</a></li>
            <li><a href="#">ETC</a></li>
        </ul>
    </div>
    <ul class="tab_keyword">
        <li class="first active"><a href="#">ALL</a></li>
        <li><a href="#">오피스</a></li>
        <li><a href="#">디지털</a></li>
        <li><a href="#">키덜트</a></li>
        <li><a href="#">가구</a></li>
        <li><a href="#">홈인테리어</a></li>
        <li><a href="#">키친/푸드</a></li>
        <li><a href="#">여행/레저</a></li>
        <li><a href="#">패션/뷰티</a></li>
        <li><a href="#">베이비/키즈</a></li>
        <li><a href="#">Pet</a></li>
        <li><a href="#">CD</a></li>
        <li><a href="#">DVD</a></li>
    </ul>
    <div class="alphabet_view">
        <div class="alpha">가</div>
        <div class="list">
            <ul>
                <li><a href="#">가일아트</a></li>
                <li><a href="#">감*感</a></li>
                <li><a href="#">건망증</a></li>
                <li><a href="#">게스</a></li>
                <li><a href="#">고바우식품</a></li>
                <li><a href="#">고진샤</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
            </ul>
            <ul>
                <li><a href="#">가일아트</a></li>
                <li><a href="#">감*感</a></li>
                <li><a href="#">건망증</a></li>
                <li><a href="#">게스</a></li>
                <li><a href="#">고바우식품</a></li>
                <li><a href="#">고진샤</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
            </ul>
            <ul>
                <li><a href="#">가일아트</a></li>
                <li><a href="#">감*感</a></li>
                <li><a href="#">건망증</a></li>
                <li><a href="#">게스</a></li>
                <li><a href="#">고바우식품</a></li>
                <li><a href="#">고진샤</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
            </ul>
            <ul>
                <li><a href="#">가일아트</a></li>
                <li><a href="#">감*感</a></li>
                <li><a href="#">건망증</a></li>
                <li><a href="#">게스</a></li>
                <li><a href="#">고바우식품</a></li>
                <li><a href="#">고진샤</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
            </ul>
            <ul>
                <li><a href="#">가일아트</a></li>
                <li><a href="#">감*感</a></li>
                <li><a href="#">건망증</a></li>
                <li><a href="#">게스</a></li>
                <li><a href="#">고바우식품</a></li>
                <li><a href="#">고진샤</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
            </ul>
            <ul>
                <li><a href="#">가일아트</a></li>
                <li><a href="#">감*感</a></li>
                <li><a href="#">건망증</a></li>
                <li><a href="#">게스</a></li>
                <li><a href="#">고바우식품</a></li>
                <li><a href="#">고진샤</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
            </ul>
            <ul>
                <li><a href="#">가일아트</a></li>
                <li><a href="#">감*感</a></li>
                <li><a href="#">건망증</a></li>
                <li><a href="#">게스</a></li>
                <li><a href="#">고바우식품</a></li>
                <li><a href="#">고진샤</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
            </ul>
            <ul>
                <li><a href="#">가일아트</a></li>
                <li><a href="#">감*感</a></li>
                <li><a href="#">건망증</a></li>
                <li><a href="#">게스</a></li>
                <li><a href="#">고바우식품</a></li>
                <li><a href="#">고진샤</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
            </ul>
            <ul>
                <li><a href="#">가일아트</a></li>
                <li><a href="#">감*感</a></li>
                <li><a href="#">건망증</a></li>
                <li><a href="#">게스</a></li>
                <li><a href="#">고바우식품</a></li>
                <li><a href="#">고진샤</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
            </ul>
            <ul>
                <li><a href="#">가일아트</a></li>
                <li><a href="#">감*感</a></li>
                <li><a href="#">건망증</a></li>
                <li><a href="#">게스</a></li>
                <li><a href="#">고바우식품</a></li>
                <li><a href="#">고진샤</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
                <li><a href="#">고쿠요</a></li>
                <li><a href="#">골든벨클락</a></li>
            </ul>
        </div>
    </div>
</div>
<!-- //brand_search -->
</body>
</html>