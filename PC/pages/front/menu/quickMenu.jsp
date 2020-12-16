<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script type="text/javascript">
<!--
jQuery(function($){
    $(document).ready(function(){
        $("#quickmenu").css("height", $(document).height());
        $("#quickmenu").css("padding-top", $("#container").offset().top);
        $("#quickmenu .sall_box").css("top", $("#container").offset().top);
    });
    
    $(window).scroll(function(){
        // console.log($("#container").offset().top + "::" + $(window).scrollTop());
        if($(window).scrollTop() > $("#container").offset().top){
            $("#quickmenu").css("padding-top", 0);
            $("#quickmenu .sall_box").css("top", 0);
            $("#quickmenu .ssrch_box").css("top", "30px");
        }else{
            $("#quickmenu").css("padding-top", $("#container").offset().top-$(window).scrollTop());
            $("#quickmenu .sall_box").css("top", $("#container").offset().top-$(window).scrollTop());
            $("#quickmenu .ssrch_box").css("top", $("#container").offset().top-$(window).scrollTop()+30);
        }
    });
    
    $("#btnFold").click(function(e){
        e.preventDefault();
        if($("#quickmenu").hasClass("fold")){
            $("#quickmenu").css("width", "80px");
            $("#quickmenu .foldbtn").css("right","75px");
            $("#quickmenu").removeClass("fold");
        }else{
            $("#quickmenu").css("width","0");
            $("#quickmenu .foldbtn").css("right","-5px");
            $("#quickmenu").addClass("fold");
        }
    });
    
    //최근본상품
    $("div#quickmenu .prod .btn_area .btn_prev").click(function(e) {
        e.preventDefault();
        var prod = $(this).parents(".prod");
        var length = prod.find("ul").length;
        var idx = prod.find("ul").index(prod.find("ul.active"));
        
        prod.find("ul.active").removeClass("active");
        if(idx < 1){
            prod.find("ul:last").addClass("active");
        }else{
            prod.find("ul").eq(idx-1).addClass("active");
        }
    });
     
    $("div#quickmenu .prod .btn_area .btn_next").click(function(e) {
        e.preventDefault();
        var prod = $(this).parents(".prod");
        var length = prod.find("ul").length;
        var idx = prod.find("ul").index(prod.find("ul.active"));
        
        prod.find("ul.active").removeClass("active");
        if(idx < length-1){
            prod.find("ul").eq(idx+1).addClass("active");
        }else{
            prod.find("ul:first").addClass("active");
        }
    });
    
    //서비스전체보기
    $("div#quickmenu > ul.top_box_m > li#serviceAllShow_m > a").click(function(e) {
        e.preventDefault();
        $(".ssrch_box").hide();
        
        if ($(".sall_box").css("display") == "none") {
            $(".sall_box").attr("style","display:block");
            $(".sall_box").css("top", $("#quickmenu").css("padding-top"));
        } else {
            $(".sall_box").attr("style","display:none");
        }
    });
    
    //닫기
    $("div#quickmenu > div.sall_box > div.submenu1_10on > a").click(function(e) {
        e.preventDefault();
        $(".sall_box").attr("style","display:none");
    });
    
    //퀵검색
    $("div#quickmenu > ul.top_box_m > li#serviceSearch > a").click(function(e) {
        e.preventDefault();
        
        $(".sall_box").hide();
        
        if (typeof fn_FocusTerm == 'function'){
            fn_FocusTerm();
        }else if ($(".ssrch_box").css("display") != "block") {
            var posY = $("#quickmenu").css("padding-top");
            posY = parseInt(posY.replace("px", ""))+30;
            posY = posY + "px";
            
            $(".ssrch_box").css('display','block').animate({opacity: 1.0, right:'90px'}, 500);
            $(".ssrch_box").css("top", posY);
            $(".ssrch_box [type=text]").focus().select();
        } else {
            $(".ssrch_box").css({display:'none',opacity:0.0,right:0});
        }
    });
    
    // GNB 검색구분이 포커스를 잃은 경우 닫아줌
    $("body").click(function(e){
        if($(".ssrch_box").css("display") == "block"){
            if(!$("#quickmenu").has(e.target).length){
                $(".ssrch_box").css({display:'none',opacity:0.0,right:0});
            }
        }
    });
});
function qcSrchFrm(){
    var frm = $("form[name=qcSrchForm]");
    if($.trim(frm.find("input[name=searchTerm]").val()) == ""){
        alert("검색어를 입력해주세요");
        return false;
    }
    frm.find("input[name=searchTerm]").val(frm.find("input[name=searchTerm]").val().replace("-", ""));
    frm.submit();
}
//-->
</script>
<div id="quickmenu_box" >
    <div id="quickmenu">
        <!-- <ul class="top_box"> -->
        <ul class="top_box_m">
            <li class="all_cate" id="serviceAllShow_m"><a href="javascript://">전체보기</a></li>
            <li class="btn_srch" id="serviceSearch"><a href="javascript://">검색</a></li>
            <li class="btn_cart"><a href="${defaultHost}/ht/order/cart">장바구니<span id="cartCnt">(0)</span></a></li>
            <li class="btn_wish"><a href="${defaultHost}/ht/mypage/listWishProduct">좋아요♥<span id="wishCnt">(0)</span></a></li>
            <c:if test="${not empty listPick}">
                <li class="banner prod mgt0">
                    <c:forEach items="${listPick}" var="l">
                        <a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>>
                            <ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" clazz="PC_WING"/>
                        </a>
                    </c:forEach>
                    <div class="inner pd0"></div>
                </li>
                <!-- 아이돌차트 배너 추가 190404 -->
                <li class="prod mgt0">
                   <a href="https://www.idol-chart.com" target="_blank" style="padding:4px 0 0 0;">
                       <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/event/banner/banner_idolchart.jpg" alt="아이돌차트배너" id="PC_IDOL_WING"/>
                   </a>
                   <div class="inner" style="padding:5px 0 0 0;"></div>
                </li>
            </c:if>
            <li class="prod PC_RECENT">
                <p class="mgt10" style="line-height:14px;">최근본상품</p>
                <div class="inner">
                    <c:forEach items="${listRecent}" varStatus="s1" step="3" end="8"> 
                        <ul class="mgt10<c:if test="${s1.first}"> active</c:if>">
                            <c:forEach items="${listRecent}" var="l" begin="${s1.index}" end="${s1.index+2}">
                                <c:choose>
                                    <c:when test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">
                                        <li><a href="/ht/record/detail/${l.sellPrdtBcode}" title="${fn:escapeXml(l.prdtName)}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" rcrdImgType="midi" ratingCode="${l.rtngCode}" width="60" alt="${fn:escapeXml(l.prdtName)}" style="width:60px;height:60px;"/></a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" title="${fn:escapeXml(l.prdtName)}"><ui:image src="${l.productImageUrl}" server="product" size="100" alt="${fn:escapeXml(l.prdtName)}" style="width:60px;height:60px;"/></a></li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </ul>
                    </c:forEach>
                    <c:if test="${not empty listRecent}">
                        <div class="btn_area">
                            <button class="btn_prev" type="button">이전 내용</button>
                            <button class="btn_next" type="button">다음 내용</button>
                        </div>
                    </c:if>
                </div>
            </li>
        </ul>
        <p class="btn_top"><a href="#" onclick="moveTop();return false;">TOP <span>▲</span></a></p>
        <p class="btn_bottom"><a href="#" onclick="moveBottom();return false;">DOWN <span>▼</span></a></p>
        <p class="foldbtn"><a href="#" id="btnFold">▶</a></p>
        <!-- 핫트랙스 서비스 전체보기 위치이동 -->
        <div class="sall_box" style="display:none;">
            <div class="submenu1_10on">
                <!-- 
                <p class="menu_alltit_top ir">핫트랙스 서비스 전체보기</p>
                <a href="#" class="close ir" id="serviceAllHide">닫기</a>
                -->
                <div class="list_cate">  
                    <ul>
                        <li class="et">
                            <dl>
                                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000020">디자인문구</a></dt>
                                <c:forEach items="${categoryList000020}" var="l">
                                    <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=${l.cateId}">${l.cateName}</a></dd>
                                </c:forEach>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000007">고급필기구</a></dt>
                                <c:forEach items="${categoryList000007}" var="l">
                                    <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=${l.cateId}">${l.cateName}</a></dd>
                                </c:forEach>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000021">오피스</a></dt>
                                <c:forEach items="${categoryList000021}" var="l">
                                    <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=${l.cateId}">${l.cateName}</a></dd>
                                </c:forEach>
                            </dl>
                        </li>
                        <%-- <li>
                            <dl>
                                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000018">화방</a></dt>
                                <c:forEach items="${categoryList000018}" var="l">
                                    <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=${l.cateId}">${l.cateName}</a></dd>
                                </c:forEach>
                            </dl>
                        </li> --%>
                        <li>
                            <dl>
                                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000022">디지털</a></dt>
                                <c:forEach items="${categoryList000022}" var="l">
                                    <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=${l.cateId}">${l.cateName}</a></dd>
                                </c:forEach>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000023">취미/펫</a></dt>
                                <c:forEach items="${categoryList000023}" var="l">
                                    <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=${l.cateId}">${l.cateName}</a></dd>
                                </c:forEach>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000024">가구/수납</a></dt>
                                <c:forEach items="${categoryList000024}" var="l">
                                    <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=${l.cateId}">${l.cateName}</a></dd>
                                </c:forEach>
                            </dl>
                        </li>
                        <li class="et">
                            <dl>
                                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000025">리빙/생활가전</a></dt>
                                <c:forEach items="${categoryList000025}" var="l">
                                    <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=${l.cateId}">${l.cateName}</a></dd>
                                </c:forEach>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000026">키친/푸드</a></dt>
                                <c:forEach items="${categoryList000026}" var="l">
                                    <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=${l.cateId}">${l.cateName}</a></dd>
                                </c:forEach>
                            </dl>
                        </li>
                    </ul>
                    <ul>
                        <li>
                            <dl>
                                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000027">여행/자동차</a></dt>
                                <c:forEach items="${categoryList000027}" var="l">
                                    <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=${l.cateId}">${l.cateName}</a></dd>
                                </c:forEach>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000028">패션잡화</a></dt>
                                <c:forEach items="${categoryList000028}" var="l">
                                    <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=${l.cateId}">${l.cateName}</a></dd>
                                </c:forEach>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000006">뷰티/헬스</a></dt>
                                <c:forEach items="${categoryList000006}" var="l">
                                    <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=${l.cateId}">${l.cateName}</a></dd>
                                </c:forEach>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000029">유아동</a></dt>
                                <c:forEach items="${categoryList000029}" var="l">
                                    <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=${l.cateId}">${l.cateName}</a></dd>
                                </c:forEach>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt><a href="${defaultHost}/ht/recordMain">CD</a></dt>
                                <c:forEach items="${categoryList0003}" var="l">
                                    <dd><a href="${defaultHost}/ht/record/category/${l.cateId}">${l.cateName}</a></dd>
                                </c:forEach>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt><a href="${defaultHost}/ht/dvdMain">DVD</a></dt>
                                <c:forEach items="${categoryList000400}" var="l">
                                    <dd><a href="${defaultHost}/ht/record/category/${l.cateId}">${l.cateName}</a></dd>
                                </c:forEach>
                            </dl>
                        </li>
                        <li class="et">
                            <dl>
                                <dt><a href="${defaultHost}/ht/dvdMain">Blu-Ray</a></dt>
                                <c:forEach items="${categoryList000401}" var="l">
                                    <dd><a href="${defaultHost}/ht/record/category/${l.cateId}">${l.cateName}</a></dd>
                                </c:forEach>
                            </dl>
                        </li>
                    </ul>
                </div>
            </div>    
        </div>
        <div class="ssrch_box" style="display:none;">
            <form name="qcSrchForm" action="/ht/search/searchMain" method="post">
                <input type="hidden" name="viewType"/>
                <input type="hidden" name="searchMenu"/>
                <input type="hidden" name="exLink" value="${krywordsUrl}"/>
                <input type="hidden" name="exTxt" value="${keywords}"/>
                <input type="text" id="search_keyword" class="search_keyword" name="searchTerm" value="${choiceKeyword.keyword}" title="검색어 키워드" style="ime-mode:active;" />
                <a href="#" class="search_btn" onclick="qcSrchFrm();return false;"><span>검색</span></a>
            </form>
        </div>
        <!-- //핫트랙스 서비스 전체보기 위치이동 -->
        <div class="pm_product new_product_m" style="display:none" ></div>
    </div>
</div>
