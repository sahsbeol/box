<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<title>브랜드메인 - NEW ME HOTTRACKS</title>
<script type="text/javascript" src="/js/owl.carousel.min.js"></script>
<script>
jQuery(function($){
    $(document).ready(function() {
        $("#record_carousel").owlCarousel({
            navigation : true,
            slideSpeed : 0,
            paginationSpeed : 0,
            singleItem : true,
            rewindSpeed :  0
        });
        
        $(".tab_alphabet_list li:first a").click();
    });
    
    $(".tab_alphabet_list li a").click(function(){
        $(".tab_alphabet_list li.active").removeClass("active");
        $(this).parent().addClass("active");
        $(".layer_ctgr li:first a").click();
    });
    
    $(".layer_ctgr li a").click(function(){
        $(".layer_ctgr li.active").removeClass("active");
        $(this).parent().addClass("active");
        
        loadBrandNameList(1);
    });
    
    $(".exm_txt").click(function(){
        $("#brandKeywords").focus();
    });
    
    $("#brandKeywords").focus(function(){
        $(".exm_txt").hide();
    });
    
    $("#brandKeywords").keypress(function(event) {
        if(event.which == 13){
            event.preventDefault();
            getBrandSearchList();
        }
    });
});

function getBrandSearchList(){
    var brandName = $("#brandKeywords").val();
    $.ajax({
          type : "get"
        , url : "/ht/hot/getSearchBrandList"
        , dataType : "html"
        , data :{searchStr:brandName,categoryCode:'0000'} 
        , success : function (result){
            $("#autoBrandComplete").html(result);
            $("#autoBrandComplete").show();
        }
        , error : function(){
            alert("잘못된 접근입니다. 관리자에게 문의 해 주세요");
        }
    });
}

function loadBrandNameList(page){
    var koreanCode = null;
    var englishCode = null;
    var categoryCode = $(".layer_ctgr li.active a").attr("id");
    if($(".tab_alphabet_list li.active a").hasClass("layer_kor")){
        koreanCode = $(".tab_alphabet_list li.active a").attr("id");
    }
    if($(".tab_alphabet_list li.active a").hasClass("layer_eng")){
        englishCode = $(".tab_alphabet_list li.active a").attr("id");
    }
    $.ajax({
          type : "get"
        , url : "/ht/hot/getSubBrandList"
        , dataType : "html"
        , data : { koreanCode:koreanCode,englishCode:englishCode,categoryCode:categoryCode,page:page}
        , success : function(result){
            $("#brandNameList").html(result);
        }
        , error : function(){
            alert("잘못된 접근입니다. 관리자에게 문의 해 주세요");
        }
    });
}
</script>
</head>
<body>
<!-- brand_in_banner -->
<div class="brand_in_banner tab_wrap">
    <h2 class="tit"><img src="${imageServer}/images/renewal/common/tit_hot_brand_in.gif" alt="Hot Brand In" /></h2>
    <p class="tit_comt">핫트랙스의 다양한 브랜드를 쉽고 빠르게 만나보세요.</p>
    <ul class="prod_tab tab_btn">
        <c:forEach items="${hotBrandLists}" var="l" varStatus="st">
            <li><a href="#hbi0${st.count}"<c:if test="${st.first}"> class="on"</c:if>><span>${l.brandEngName}</span></a></li>
        </c:forEach>
    </ul>
    <div class="brand_in_list_wrap tab_pannels">
        <c:forEach items="${hotBrandLists}" var="l" varStatus="st">
            <ul id="hbi0${st.count}" class="brand_in_list pannel"<c:if test="${st.first}"> style="display:block;"</c:if>>
                <li class="first"><a href="/ht/hot/brandDetail?brandId=${l.brandId}"><ui:image src="${l.brandImageC0296}" server="brand" alt="${l.brandName}" width="950" height="440"/></a></li>
                <li><a href="/ht/hot/brandDetail?brandId=${l.brandId}"><ui:image src="${l.brandImageC0297}" server="brand" alt="${l.brandName}" width="290" height="140"/></a></li>
                <li><a href="/ht/hot/brandDetail?brandId=${l.brandId}"><ui:image src="${l.brandImageC0298}" server="brand" alt="${l.brandName}" width="290" height="140"/></a></li>
                <li class="last"><a href="/ht/hot/brandDetail?brandId=${l.brandId}"><ui:image src="${l.brandImageC0299}" server="brand" alt="${l.brandName}" width="290" height="140"/></a></li>
            </ul>
        </c:forEach>
    </div>
</div>
<!-- //brand_in_banner -->
<!-- new_brand -->
<div class="new_brand_Wrap">
    <h2 class="tit"><img src="${imageServer}/images/renewal/common/tit_new_brand.gif" alt="new brand" /></h2>
    <p class="tit_comt">핫트랙스의 새로운 브랜드와 함께 하세요.</p>
    <div class="new_brand_banner tab_wrap02">
        <c:forEach items="${newBrandLists}" varStatus="s1" step="4" end="11">
            <ul id="nb${s1.count}" class="new_brand_list tab_pannels">
                <c:forEach items="${newBrandLists}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
                    <li<c:if test="${st.first}"> class="first"</c:if>>
                        <a href="/ht/hot/brandDetail?brandId=${l.brandId}">
                            <c:if test="${st.first}"><span class="img_box"><ui:image src="${l.brandImageC029A}" server="brand" alt="${l.brandName}" width="478" height="464"/></span></c:if>
                            <c:if test="${!st.first}"><span class="img_box"><ui:image src="${l.brandImageC029B}" server="brand" alt="${l.brandName}" width="195" height="199"/></span></c:if>
                            <div class="brand_info">
                                <strong class="brand_name">
                                    ${l.brandEngName}
                                    <span class="lang_ko">${l.brandName}</span>
                                </strong>
                                <c:if test="${st.first}">
                                    <span class="brand_comt">${hfn:lineToBr(l.baseBrandSmry)}</span>
                                </c:if>
                            </div>
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </c:forEach>
        <div class="indicator tab_btn">
            <ul>
                <c:forEach items="${newBrandLists}" varStatus="s1" step="4" end="11">
                    <li><a href="#nb${s1.count}"<c:if test="${s1.first}"> class="on"</c:if>><span>${s1.count}</span></a></li>
                </c:forEach>
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
                    <label for="brandKeywords" class="hidden_obj">검색</label><input type="text" id="brandKeywords" class="search_keyword" title="검색어 입력" style="width:306px;">
                    <a href="javascript://" onclick="getBrandSearchList()" class="search_btn"><span>검색</span></a>
                    <span class="exm_txt">브랜드명으로 찾기</span>
                    <div id="autoBrandComplete" class="search_txt" style="display:none;"></div>
                </div>
            </fieldset>
        </form>
    </div>
    <div class="tab_search_wrap">
        <p class="tit_search_lineup"><span>가나다순</span>으로 찾기</p>
        <ul class="tab_alphabet_list">
            <c:forEach items="${koreanCodes}" var="l" varStatus="st">
                <li><a href="javascript://" id="${l.code}" class="layer_kor">${l.codeName}</a></li>
            </c:forEach>
        </ul>
        <p class="tit_search_lineup"><span>알파벳순</span>으로 찾기</p>
        <ul class="tab_alphabet_list">
            <c:forEach items="${englishCodes}" var="l" varStatus="st">
                <li><a href="javascript://" id="${l.code}" class="layer_eng">${l.codeName}</a></li>
            </c:forEach>
        </ul>
    </div>
    <ul class="tab_keyword layer_ctgr">
        <li class="first"><a href="javascript://" id="0000">ALL</a></li>
        <li><a href="javascript://" id="000020">디자인문구</a></li>
        <li><a href="javascript://" id="000022">디지털</a></li>
        <li><a href="javascript://" id="000007">고급필기구</a></li>
        <li><a href="javascript://" id="000021">오피스</a></li>
        <li><a href="javascript://" id="000025">리빙/생활가전</a></li>
        <li><a href="javascript://" id="000026">키친/푸드</a></li>
        <li><a href="javascript://" id="000024">가구/수납</a></li>
        <li><a href="javascript://" id="000028">패션잡화</a></li>
        <li><a href="javascript://" id="000006">뷰티/헬스</a></li>
        <li><a href="javascript://" id="000027">여행/자동차</a></li>
        <li><a href="javascript://" id="000023">취미/펫</a></li>
        <li><a href="javascript://" id="000029">유아동</a></li>
    </ul>
    <div class="alphabet_view" id="brandNameList"></div>
</div>
<!-- //brand_search -->
<!-- //컨텐츠 -->
</body>
</html>