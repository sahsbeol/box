<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<title>
<c:forEach varStatus="st" begin="6" end="${fn:length(c.ctgrId)}" step="2">
    <c:if test="${!st.first}"> | </c:if>
    <ui:category id="${fn:substring(c.ctgrId, 0, st.index)}" full="false"/>
</c:forEach>
- NEW ME HOTTRACKS
</title>
<script type="text/javascript">
jQuery(function($){
    $("img.lazy").lazyload({placeholder:'/images/no_image2.gif',threshold:200});
    $(".paging a").click(function(e){
        e.preventDefault();
        location.href = $(this).attr("href") + "#cateProductList";
    });
});

function _loadGroupProduct(grpPrdtBcode, name, cnt){
    var tit = document.getElementById("layerProductTit");
    while(tit.firstChild)    tit.removeChild(tit.firstChild);
    
    var prdtName = document.createElement("span");
    prdtName.classList.add("ellipsis");
    prdtName.appendChild(document.createTextNode(name));
    tit.appendChild(prdtName);
    
    var groupCnt = document.createElement("strong");
    groupCnt.classList.add("rel_cnt");
    groupCnt.appendChild(document.createTextNode(" 연관상품 " + price_format(cnt) + "개"));
    tit.appendChild(groupCnt);
    
    $.ajax({
        url:"/ht/gift/getProductByGroup"
      , data:{grpPrdtBcode:grpPrdtBcode}
      , dataType:"json"
      , success:function(data){
          var obj = document.getElementById("layerProduct");
          while(obj.firstChild)    obj.removeChild(obj.firstChild);
          
          if(data && data.list){
              for(var i = 0;i < data.list.length; i++){
                  var prod = data.list[i];
                  var li = document.createElement("li");
                  li.classList.add("card");
                  
                  var anchor = document.createElement("a");
                  anchor.href = "/p/" + prod.sellPrdtBcode;
                  anchor.target = "_blank";
                  li.appendChild(anchor);
                  
                  var span = document.createElement("span");
                  span.classList.add("thumb");
                  anchor.appendChild(span);
                  
                  var img = document.createElement("img");
                  img.src = "http://image.kyobobook.co.kr/newimages/giftshop_new/goods/200/" + prod.productImageUrl;
                  span.appendChild(img);
                  
                  var p = document.createElement("p");
                  anchor.appendChild(p);
                  
                  var title = document.createElement("span");
                  title.classList.add("title");
                  title.appendChild(document.createTextNode(prod.prdtName));
                  p.appendChild(title);
                  
                  var price = document.createElement("strong");
                  price.appendChild(document.createTextNode(price_format(prod.lastCpnPrice)));
                  var unit = document.createElement("span");
                  unit.classList.add("unit");
                  unit.appendChild(document.createTextNode("원"));
                  price.appendChild(unit);
                  p.appendChild(price);
                  
                  obj.appendChild(li);
              }
          }
          
          $(".layer_relate-items").addClass("active");
          $(".layer_back").css("height", "100%");
          $("body").addClass("fix");
      }
    });
}

function _closeProductGroup(){
    $(".layer_relate-items").removeClass("active");
    $(".layer_back").css("height", "0");
    $("body").removeClass("fix");
}
</script>
<style type="text/css">
body.fix { overflow:hidden; }
.layer_back { position: fixed; left: 0px; top: 0px; width: 100%; height: 0; opacity: 0.7; background: rgb(0, 0, 0); z-index: 9998; }
.layer_relate-items { position:fixed;bottom: -320px;width:100%;background: #ececec;z-index: 99;width: 100%;z-index:9999;transition-property: bottom;transition-duration: 0.3s;transition-timing-function: cubic-bezier(0.4, 0.3, 0, 1);height: 320px;left: 0;overflow: hidden; min-height: 320px;}
.layer_relate-items.active { bottom: 0px;transition-duration: 0.5s;}
.layer_relate-items .layer_title { padding: .5em 0;font-size: 1.5em;color: #fff;text-align: center;line-height: 1.5em;height: 1.5em;font-weight: normal;background-color: #da2128; }
.layer_relate-items .layer_title .ellipsis { max-width: 800px;text-overflow: ellipsis;-o-text-overflow: ellipsis;overflow: hidden;white-space: nowrap;word-wrap: normal !important;display: inline-block;text-overflow: ellipsis;-webkit-box-orient: vertical;word-wrap:break-word;vertical-align: top;}
.layer_relate-items .layer_title .close { background: url('//pics.gmkt.kr/pc/ko/item/list/close_grouplpsrp.png') center center no-repeat;font-size:0;display:block;width: 46px;height: 46px;position:absolute;right:0;top:0;background-size: contain;}
.layer_relate-items .layer_cont { height:auto;background-color:#f1f2f3;padding:1em 0;width: 100%;box-sizing: border-box;}
.layer_relate-items .layer_title { font-family:"Malgun Gothic"  }
.layer_relate-items .layer_cont .items_list .card span { font-family: Noto Sans KR  }
.layer_relate-items .layer_cont .items_list .card strong { font-family: Tahoma, Gulim, '굴림' ;  }

.layer_cont .items_list { height: auto;position: relative;overflow: visible;margin:0 auto;width: 1200px;}
.layer_cont .items_list .relate-item-slider { overflow:hidden;position: relative;padding-bottom:30px;width: 1064px;margin:0 auto;height: 226px;}
.layer_cont .items_list .relate-item-slider ul { position:absolute; top:0; left:0; height: 226px; }
.layer_cont .items_list .card:last-child { padding-right: 0;}
.layer_cont .items_list .card { float: left;width: 140px;padding-right: 14px;height: 225px;position: relative;}
.layer_cont .items_list .card a { display: block;width: 138px;height: 221px;background: #fff;box-shadow: 1px 1px 1px 0 rgba(0,0,0,0.1);border-radius: 2px;overflow: hidden;position: relative;border: 1px solid #dedede;position: absolute;top: 0;}
.layer_cont .items_list .card a:hover { border:1px solid #233549; text-decoration:none; }
.layer_cont .items_list .card a:focus { border:1px solid #15c068; text-decoration:none; }
.layer_cont .items_list .card .thumb { width:140px; height:140px;text-align: center;display: block;}
.layer_cont .items_list .card .thumb img { max-width: 140px;height: 140px;width: 140px;border-bottom: 1px solid rgba(0,0,0,0.02); }
.layer_cont .items_list .card p { padding: 9px 13px 15px;}
.layer_cont .items_list .card p .title { font-size: 14px;line-height: 18px;text-align: left;overflow: hidden;text-overflow: ellipsis;display: block;line-clamp: 2;box-orient: vertical;word-wrap:break-word;height: 36px;letter-spacing: -0.4px;color: #5e636d;margin-bottom: 9px;}
.layer_cont .items_list .card p strong { font-size: 16px;line-height: 16px;color: #222;font-weight: bold;}
.layer_cont .items_list .card p .unit { font-size: 15px;line-height: 15px;padding-left: 1px;font-weight: normal;}
.layer_cont .items_list .btn_prev { background: url(//pics.gmkt.kr/pc/ko/item/list/sp_grouplpsrp_arrow.png) 0 0 no-repeat;width: 50px;height: 50px;display: block;font-size: 0;background-position: 0px  0px;padding: 0;position: absolute;z-index: 10;left: 0;top: 90px;}
.layer_cont .items_list .btn_next { background: url(//pics.gmkt.kr/pc/ko/item/list/sp_grouplpsrp_arrow.png) 0 0 no-repeat;width: 50px;height: 50px;display: block;font-size: 0;background-position: -54px 0px;padding: 0;position: absolute;z-index: 10;right: 0;top: 90px;}
.layer_cont .items_list .btn_prev.disabled { background-position:0 -54px }
.layer_cont .items_list .btn_next.disabled { background-position:-54px  -54px }
</style>
</head>
<body>

<!-- Location -->
<div class="page_location shop">
    <div class="loc">
        <a href="/" class="home">Home</a>
        <c:forEach varStatus="st" begin="6" end="${fn:length(c.ctgrId)}" step="2">
            <c:if test="${st.last}"><em><ui:category id="${ctgrId}" full="false"/></em></c:if>
            <c:if test="${!st.last && st.first}"><a href="/ht/gift/giftCategoryMain?ctgrId=${fn:substring(c.ctgrId, 0, st.index)}"><ui:category id="${fn:substring(c.ctgrId, 0, st.index)}" full="false"/></a></c:if>
            <c:if test="${!st.last && !st.first}"><a href="/ht/gift/giftCategorySub?ctgrId=${fn:substring(c.ctgrId, 0, st.index)}"><ui:category id="${fn:substring(c.ctgrId, 0, st.index)}" full="false"/></a></c:if>
        </c:forEach>
    </div>
    <a href="/ht/hot/eventMain?ctgrId=${fn:substring(c.ctgrId, 0, 6)}" class="more_event"><span><ui:category id="${fn:substring(c.ctgrId, 0, 6)}" full="false"/> 이벤트 더보기</span></a>
</div>
<!-- //Location -->

<!-- Office_design -->
<div class="office_design02" id="giftCateMid">
    <c:import url="/menu/gift/lnb?ctgrId=${c.ctgrId}"/>
    
    <!-- Cate_prod -->
    <div class="cate_prod" style="position: relative;z-index:800;">
        <!-- 카테고리 -->
        <dl class="cate_list ">
            <dt>${subCategory.cateName}</dt>
            <dd>
                <ul>
                    <c:forEach items="${subCategoryChildList}" var="l" varStatus="st">
                        <li>
                            <a href="/ht/gift/giftCategorySub?ctgrId=${l.cateId}"<c:if test="${fn:startsWith(c.ctgrId, l.cateId)}"> class="active"</c:if>><span>${l.cateName} (<fmt:formatNumber type="number" value="${l.productCount}"/>)</span></a>
                            <c:if test="${not empty l.childCategoryList}">
                                <div class="fourDepthList">
                                    <ol>
                                        <c:forEach items="${l.childCategoryList}" var="child" varStatus="childStatus">
                                            <li><a href="${child.frontUrl}" class="txt_line1" title="${child.cateName}">${child.cateName}</a></li>
                                        </c:forEach>
                                    </ol>
                                </div>
                            </c:if>
                        </li>
                    </c:forEach>
                </ul>
            </dd>
        </dl>
        <c:forEach items="${subCategoryChildList}" var="l" varStatus="st">
            <c:if test="${not empty l.childCategoryList}">
                <dl class="sub_cate_list<c:if test="${fn:startsWith(c.ctgrId, l.cateId)}"> active</c:if>">
                    <dt>${l.cateName}</dt>
                    <dd>
                        <ul>
                            <c:forEach items="${l.childCategoryList}" var="child" varStatus="childStatus">
                                <li><a href="${child.frontUrl}" class="txt_line1<c:if test="${fn:startsWith(c.ctgrId, child.cateId)}"> active</c:if>" title="${child.cateName}">${child.cateName}</a></li>
                            </c:forEach>
                        </ul>
                    </dd>
                </dl>
            </c:if>
        </c:forEach>
        <!-- //카테고리 -->
        <c:if test="${not empty listBest && not empty listSale && not empty listHot}">
            <div class="tab_wrap">
                <ul class="cate_tab tab_btn">
                    <li><a href="#ct01" class="on"><span>FOR YOU</span></a></li>
                    <li><a href="#ct02"><span>BEST</span></a></li>
                    <li><a href="#ct03"><span>SALE</span></a></li>
                    <li><a href="#ct04"><span>HOT</span></a></li>
                </ul>
                <div class="tab_pannels">
                    <c:forEach begin="0" end="3" varStatus="s1">
                        <c:if test="${s1.index eq 0}"><c:set var="list" value="${listRecobell}"/></c:if>	<!-- 레코벨 추천상품 -->
                        <c:if test="${s1.index eq 1}"><c:set var="list" value="${listBest}"/></c:if>
                        <c:if test="${s1.index eq 2}"><c:set var="list" value="${listSale}"/></c:if>
                        <c:if test="${s1.index eq 3}"><c:set var="list" value="${listHot}"/></c:if>
                        <div id="ct0${s1.count}" class="prod_list_normal pannel">
                            <ul>
                                <c:forEach items="${list}" var="l" varStatus="st" end="2">
                                    <c:if test="${not empty l.sellPrdtBcode}">
                                        <li>
                                            <span class="img">
                                                <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${l.sellPrdtBcode}<c:if test="${s1.index eq 0}">?foo=bar<c:if test="${fn:length(c.ctgrId) eq 8}">&rccode=pc_category2</c:if><c:if test="${fn:length(c.ctgrId) eq 10}">&rccode=pc_category3</c:if><c:if test="${fn:length(c.ctgrId) eq 12}">&rccode=pc_category4</c:if></c:if>"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="A" rcrdImgType="large" width="${l.sellPrdtGbn eq 'R'?'200':'132'}" clazz="photo" alt="${fn:escapeXml(l.prdtName)}"/></a></c:if>
                            					<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}<c:if test="${s1.index eq 0}">&foo=bar<c:if test="${fn:length(c.ctgrId) eq 8}">&rccode=pc_category2</c:if><c:if test="${fn:length(c.ctgrId) eq 10}">&rccode=pc_category3</c:if><c:if test="${fn:length(c.ctgrId) eq 12}">&rccode=pc_category4</c:if></c:if>"><ui:image src="${l.prdtImgUrl}" src2="${l.productImageUrl2}" alt="${l.prdtName}" server="product" ratingCode="${l.nyoSellBanYn}" size="200"/></a></c:if>
                                                <div class="hide_util">
                                                    <a href="javascript://" onclick="productPreview('${l.sellPrdtBcode}', '${c.ctgrId}')" class="zoom"><span>확대</span></a>
                                                    <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}<c:if test="${s1.index eq 0}">&foo=bar&rccode=pc_category2</c:if>" target="_blank" class="nblank"><span>새창</span></a>
                                                    <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                                                </div>
                                            </span>
                                            <c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${l.sellPrdtBcode}<c:if test="${s1.index eq 0}">?foo=bar<c:if test="${fn:length(c.ctgrId) eq 8}">&rccode=pc_category2</c:if><c:if test="${fn:length(c.ctgrId) eq 10}">&rccode=pc_category3</c:if><c:if test="${fn:length(c.ctgrId) eq 12}">&rccode=pc_category4</c:if></c:if>"></c:if>
                        					<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G' || l.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}<c:if test="${s1.index eq 0}">&foo=bar<c:if test="${fn:length(c.ctgrId) eq 8}">&rccode=pc_category2</c:if><c:if test="${fn:length(c.ctgrId) eq 10}">&rccode=pc_category3</c:if><c:if test="${fn:length(c.ctgrId) eq 12}">&rccode=pc_category4</c:if></c:if>"></c:if>
                                                <span class="name">${l.prdtName}</span>
                                                <span class="icon">
                                                    <c:set var="reviewCount" value="${l.reviewCount}"/>
                                                    <c:set var="wishPrdtCnt" value="${l.wishPrdtCnt}"/>
                                                    <c:if test="${l.reviewCount > 99}"><c:set var="reviewCount" value="99+"/></c:if>
                                                    <c:if test="${l.wishPrdtCnt > 99}"><c:set var="wishPrdtCnt" value="99+"/></c:if>
                                                    <c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}"><em class="ico_free">무료배송</em></c:if>
                                                    <c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><em class="ico_coupon">쿠폰</em></c:if>
                                                    <c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}"><em class="ico_gift">GIFT</em></c:if>
                                                    <c:if test="${l.wishPrdtCnt > 0}"><em class="ico_like">${wishPrdtCnt}</em></c:if>
                                                    <c:if test="${l.reviewCount > 0}"><em class="ico_review">${reviewCount}</em></c:if>
                                                </span>
                                                <em class="price">
                                                    <c:if test="${l.basePrdtSellPrice > l.lastCpnPrice}"><span class="dc"><fmt:formatNumber value="${l.basePrdtSellPrice}" pattern="#,###"/></span></c:if>
                                                    <span class="sale"><fmt:formatNumber value="${l.lastCpnPrice}" pattern="#,###"/></span>
                                                    <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                                    <c:if test="${l.prdtStatCode eq 'C0312' && l.basePrdtSellPrice > l.lastCpnPrice}"><span class="pc">${hfn:rate(l.basePrdtSellPrice, l.lastCpnPrice)}%</span></c:if>
                                                </em>
                                            </a>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>
    </div>
    <!-- //Cate_prod -->
</div>
<!-- //Office_design -->

<div class="search_sort_tab04 mgt50" id="cateProductList">
    <div id="ulSort" class="f_left">
        <c:set var="baseLink" value="?ctgrId=${c.ctgrId}&page=1&listSize=${c.listSize}&benefitGbn=${c.benefitGbn}&saleYn=${c.saleYn}"/>
        <a href="${baseLink}&productOrderBy=P#cateProductList"<c:if test="${c.productOrderBy eq 'P'}"> class="active"</c:if>>인기순</a>
        <a href="${baseLink}&productOrderBy=R#cateProductList"<c:if test="${c.productOrderBy eq 'R'}"> class="active"</c:if>>신상품순</a>
        <a href="${baseLink}&productOrderBy=L#cateProductList"<c:if test="${c.productOrderBy eq 'L'}"> class="active"</c:if>>낮은가격순</a>
        <a href="${baseLink}&productOrderBy=H#cateProductList"<c:if test="${c.productOrderBy eq 'H'}"> class="active"</c:if>>높은가격순</a>
        <a href="${baseLink}&productOrderBy=T#cateProductList"<c:if test="${c.productOrderBy eq 'T'}"> class="active"</c:if>>높은할인율순</a>
        <a href="${baseLink}&productOrderBy=W#cateProductList"<c:if test="${c.productOrderBy eq 'W'}"> class="active"</c:if>>좋아요♥</a>
        <a href="${baseLink}&productOrderBy=Q#cateProductList"<c:if test="${c.productOrderBy eq 'Q'}"> class="active"</c:if>>상품평</a>
    </div>
    <div class="btn_l">
        <c:set var="baseLink" value="?ctgrId=${c.ctgrId}&page=1&productOrderBy=${c.productOrderBy}&listSize=${c.listSize}&saleYn=${c.saleYn}"/>
        <select class="select" id="ulBenefitGbn" style="margin-left:3px;" onchange="location.href='${baseLink}&benefitGbn='+this.value+'#cateProductList';return false;">
            <option value="">전체상품</option>
            <option value="H"<c:if test="${c.benefitGbn eq 'H'}"> selected="selected"</c:if>>핫트랙스배송</option>
            <option value="N"<c:if test="${c.benefitGbn eq 'N'}"> selected="selected"</c:if>>무료배송</option>
            <option value="A"<c:if test="${c.benefitGbn eq 'A'}"> selected="selected"</c:if>>무료+핫트랙스배송</option>
        </select>
        <c:set var="baseLink" value="?ctgrId=${c.ctgrId}&page=1&productOrderBy=${c.productOrderBy}&listSize=${c.listSize}&benefitGbn=${c.benefitGbn}"/>
        <select class="select" id="ulSaleYn" style="margin-left:3px;" onchange="location.href='${baseLink}&saleYn='+this.value+'#cateProductList';return false;">
            <option value="N"<c:if test="${c.saleYn eq 'N' || empty c.saleYn}"> selected="selected"</c:if>>품절포함</option>
            <option value="Y"<c:if test="${c.saleYn eq 'Y'}"> selected="selected"</c:if>>품절제외</option>
        </select>
        <c:set var="baseLink" value="?ctgrId=${c.ctgrId}&page=1&productOrderBy=${c.productOrderBy}&benefitGbn=${c.benefitGbn}&saleYn=${c.saleYn}"/>
        <select class="select" id="ulListSize" style="margin-left:3px;" onchange="location.href='${baseLink}&listSize='+this.value+'#cateProductList';return false;">
            <option value="40"<c:if test="${c.listSize eq '40'}"> selected="selected"</c:if>>40개</option>
            <option value="80"<c:if test="${c.listSize eq '80'}"> selected="selected"</c:if>>80개</option>
            <option value="120"<c:if test="${c.listSize eq '120'}"> selected="selected"</c:if>>120개</option>
        </select>
    </div>
</div>
<c:if test="${empty productList }">
   <div class="t_center mgt25 mgb25"><img src="${imageServer}/images/common/no_result.gif" alt="상품이 존재하지 않습니다" /></div>
</c:if>
<c:if test="${not empty productList }">
    <div class="prod_list_normal">
        <c:forEach items="${productList}" varStatus="s1" step="4">
            <ul>
                <c:forEach items="${productList}" var="l" varStatus="st" begin="${s1.index}" end="${s1.index+3}">
                    <li>
                        <span class="img">
                            <c:if test="${s1.index < 4}"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}&ctgrId=${c.ctgrId}"><ui:image src="${l.productImageUrl}" src2="${l.productImageUrl2}" alt="${fn:escapeXml(l.prdtName)}" server="product" ratingCode="${l.nyoSellBanYn}" size="200"/></a></c:if>
                            <c:if test="${s1.index > 3}"><a href="/ht/product/detail?barcode=${l.sellPrdtBcode}&ctgrId=${c.ctgrId}"><ui:image src="${l.productImageUrl}" src2="${l.productImageUrl2}" alt="${fn:escapeXml(l.prdtName)}" server="product" ratingCode="${l.nyoSellBanYn}" size="200" lazy="Y" clazz="lazy"/></a></c:if>
                            <div class="hide_util">
                                <a href="javascript://" onclick="productPreview('${l.sellPrdtBcode}')" class="zoom"><span>확대</span></a>
                                <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" target="_blank" class="nblank"><span>새창</span></a>
                                <a href="javascript://" onclick="addWishProduct('${l.sellPrdtBcode}')" class="zzim"><span>좋아요</span></a>
                            </div>
                        </span>
                        <a href="/ht/product/detail?barcode=${l.sellPrdtBcode}">
                            <span class="make">${l.brandName}</span>
                            <span class="name">${l.prdtName}</span>
                            <span class="icon">
                                <c:set var="reviewCount" value="${l.reviewCount}"/>
                                <c:set var="wishPrdtCnt" value="${l.wishPrdtCnt}"/>
                                <c:if test="${l.reviewCount > 99}"><c:set var="reviewCount" value="99+"/></c:if>
                                <c:if test="${l.wishPrdtCnt > 99}"><c:set var="wishPrdtCnt" value="99+"/></c:if>
                                <c:if test="${fn:substring(l.prdtIcon,8,9) eq '1'}"><em class="ico_free">무료배송</em></c:if>
                                <c:if test="${fn:substring(l.prdtIcon,0,1) eq '1'}"><em class="ico_coupon">쿠폰</em></c:if>
                                <c:if test="${fn:substring(l.prdtIcon,2,3) eq '1'}"><em class="ico_gift">GIFT</em></c:if>
                                <c:if test="${l.wishPrdtCnt > 0}"><em class="ico_like">${wishPrdtCnt}</em></c:if>
                                <c:if test="${l.reviewCount > 0}"><em class="ico_review">${reviewCount}</em></c:if>
                            </span>
                            <em class="price">
                                <c:if test="${l.prdtSellPrice > l.lastCpnPrice}"><span class="dc"><fmt:formatNumber value="${l.prdtSellPrice}" pattern="#,###"/></span></c:if>
                                <span class="sale"><fmt:formatNumber value="${l.lastCpnPrice}" pattern="#,###"/></span>
                                <c:if test="${l.prdtStatCode ne 'C0312'}"><span class="pc"><img src="${imageServer}/images/renewal/common/ic_status_soldout.gif" alt="품절"/></span></c:if>
                                <c:if test="${l.prdtStatCode eq 'C0312' && l.prdtSellPrice > l.lastCpnPrice}"><span class="pc">${hfn:rate(l.prdtSellPrice, l.lastCpnPrice)}%</span></c:if>
                            </em>
                            <!--
                            <span class="info">
                                <c:if test="${not empty l.grpPrdtBcode && l.groupCnt > 1}">
                                    <a href="#" onclick="_loadGroupProduct('${l.grpPrdtBcode}', '${l.prdtName}', '${l.groupCnt}');return false;">연관상품 <strong class="c_red"><fmt:formatNumber type="number">${l.groupCnt}</fmt:formatNumber>개</strong></a>
                                </c:if>
                            </span>
                            -->
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </c:forEach>
    </div>
</c:if>
<div class="paging"><ui:pagination name="pageHolder" url="/ht/gift/giftCategorySub?" parameters="ctgrId,productOrderBy,productListType,listSize,listLine,benefitGbn,saleYn"/></div>
<div class="layer_back" onclick="_closeProductGroup();"></div>
<div class="layer_relate-items">
    <h2 class="layer_title">
        <span id="layerProductTit"></span>
        <a href="#" onclick="_closeProductGroup();return false;" class="close" title="연관상품닫기">연관상품 닫기</a>
    </h2>
    <div class="layer_cont">
        <div class="scroll">
            <div class="items_list"> 
                <div class="relate-item-slider">
                    <ul id="layerProduct" id="relate-item-list" style="width: 924px; left: 0px;"></ul>
                </div>
                <a class="btn_prev disabled">이전</a>
                <a class="btn_next disabled">다음</a>
                <div class="dots"><a href="#" class="active"><span>1</span></a> </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>