<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="popup"/>
<head>
<script type="text/javascript">
jQuery(function($){
    $("input[name=searchTerm]").focus();
    
    /* 음반 및 DVD > 품절상품 제외 리스트 보여주기 여부 */
    $("div.list-size02")
        .mousemove(function() {
            $(this).find("ul").show();
        })
        .mouseout(function() {
            $(this).find("ul").hide();
        });
    
    /* 검색어 입력시 */
    $("form[name='searchedForm'] input[name='searchTerm']").keypress(function(e) {
        if (e.which == 13) {
            $(this).val($.trim($(this).val()));
            $("input#btnSearch").click();
        }
    });
    
    /* 정렬순서 클릭 시 */
    $("ul.sort a").click(function() {
        $("form[name='searchedForm'] input[name='sort']").val($(this).attr("id"));
        $("form[name='searchedForm']").submit();
    });
    
    /* 리스트 사이즈 50 클릭 시 */
    $("a#listSize50").click(function() {
        $("a.#listSize").text($(this).text());
        $("form[name='searchedForm'] input[name='listSize']").val("50");
        $("form[name='searchedForm']").submit();
    });
    
    /* 리스트 사이즈 100 클릭 시 */
    $("a#listSize100").click(function() {
        $("a.#listSize").text($(this).text());
        $("form[name='searchedForm'] input[name='listSize']").val("100");
        $("form[name='searchedForm']").submit();
    });
    
    /* 품절 여부 마우스 오버 시 */
    $("a#saleYn").mouseover(function() {
        $("ul#ulSaleYn").show(); 
    });
    
    /* 품절 상품 제외 클릭 시 */
    $("a#saleYnY").click(function() {
        $("a.#saleYn").text($(this).text());
        $("form[name='searchedForm'] input[name='saleYn']").val("Y");
        $("form[name='searchedForm']").submit();
    });
    
    /* 품절 상품 포함 클릭 시 */
    $("a#saleYnN").click(function() {
        $("a.#saleYn").text($(this).text());
        $("form[name='searchedForm'] input[name='saleYn']").val("N");
        $("form[name='searchedForm']").submit();
    });
    
    /* 검색 폼 전송 시 */
    $("form[name='searchedForm']").submit(function() {
        //if(!serviceCheck()){
            var searchFlag = $("form[name='searchedForm'] input[name='searchFlag']");
            if ($("form[name='searchedForm'] input[name='searchFlag1']").attr("checked")) {
                searchFlag.val("R");
            } else if ($("form[name='searchedForm'] input[name='searchFlag2']").attr("checked")) {
                searchFlag.val("E");
            }
            if($("input[name=prevQuery]").val() == "" && (searchFlag.val() == "R" || searchFlag.val() == "E" )){
                $("input[name=prevQuery]").val("@where { }");
            }
            if(!(searchFlag.val() == "R") && !(searchFlag.val() == "E")){
                $("input[name=prevQuery]").val("");
            }   
            var _str = $("form[name='searchedForm'] input[name='searchTerm']").val();
            if (_str.replace(/^\s\s*/, '').replace(/\s\s*$/, '') == "" && $("input[name=detailSearch]").val() != 'Y') {
                alert("검색어를 입력해주세요!");
                return false;
            }
            if(isNaN($("input[name=minPrice]").val()) || isNaN($("input[name=maxPrice]").val()) ){
                alert("가격에는 숫자만 입력 가능합니다.");
                return;
            }
            if($("input[name=detailSearch]").val() == 'Y' && $("input[name=keywordSubmit]").val() == 'Y') {
                var tmp = $("form[name=searchedForm]").find("input[name=searchTerm]").val();
                $("form[name=searchForm]").find("input[name=searchTerm]").val(tmp);
                $("form[name=searchForm]").submit();
                return false;
            }
            return true;
        //}
    });
    
    /* 음반/DVD 상세 검색 클릭 시 */
    $("div.search_txt a").click(function() {
        $("form[name='searchForm'] input[name='searchTerm']").val($(this).text());
        $("a#searchMenu1").click();
        $("a#anchorSearch").click();
    });
     
    
    /* 사용처 없음 */
    $("form[name='searchedForm'] input[name='searchTerm']").blur(function(e) {
        $("div.at_search").hide();
    });
});

/* 탭 클릭시 */
function clkMenu(target) {
    //if(!serviceCheck()){
        if(target == 'TOTAL'){
            $("form[name='searchedForm'] input[name='searchMenu']").val(target);
        }
        $("form[name='searchedForm'] input[name='menuGroup']").val(target);
        $("form[name='searchedForm']").submit();
    //}
}


/* 통합검색 - 분류 선택시 */
function srchMenuSub(searchMenu, subMenu, menuGroup, text) {
    $("form[name='searchedForm'] input[name='searchMenuText']").val(text);
    $("form[name='searchedForm'] input[name='searchMenu']").val(searchMenu);
    $("form[name='searchedForm'] input[name='subMenu']").val(subMenu);
    $("form[name='searchedForm'] input[name='menuGroup']").val(menuGroup);
    $("ul.search_n_box").hide();
}

/* 검색 링크 */
function searchMain(searchTerm, searchMenu, subMenu, menuGroup){
    //if(!serviceCheck()){
        location.href = "/ht/findProduct?searchTerm="+encodeURI(searchTerm)+"&searchMenu="+searchMenu+"&subMenu="+subMenu+"&menuGroup="+menuGroup;
    //}
}

function setProduct(sellPrdtBcode, prdtSellPrice, prdtDscntPrice){
    var productImageUrl = $("#prod"+sellPrdtBcode).find(".photo").attr("src");
    var brandName = $("#prod"+sellPrdtBcode).find(".brand").text();
    var prdtName = $("#prod"+sellPrdtBcode).find(".name").text(); 
    var product = "{sellPrdtBcode:'"+sellPrdtBcode+"',prdtName:'"+prdtName+"',brandName:'"+brandName+"',prdtSellPrice:'"+prdtSellPrice+"',prdtDscntPrice:'"+prdtDscntPrice+"',productImageUrl:'"+productImageUrl+"'}";
    errMsg = parent.opener.setProduct(eval("("+product+")"));
    if(!isEmpty(errMsg))    alert(errMsg);
    // window.close();
}
</script>
</head>
<body>
<div class="pop_cont">
    <form name="searchedForm" method="post" action="/ht/findProduct">
        <input type="hidden" name="listSize" value="${searchCriteria.listSize}"/>
        <input type="hidden" name="saleYn" value="${searchCriteria.saleYn}"/>
        <input type="hidden" name="musicAlbumTrack" value="${searchCriteria.musicAlbumTrack}"/>
        <input type="hidden" name="searchMenu" value="${searchCriteria.searchMenu}"/>
        <input type="hidden" name="subMenu" value="${searchCriteria.subMenu}"/>
        <input type="hidden" name="sort" value="${searchCriteria.sort}"/>
        <input type="hidden" name="menuGroup" value="${searchCriteria.menuGroup}"/>
        <input type="hidden" name="categoryGroup" value="${searchCriteria.categoryGroup}" class="srchFlg"/>
        <input type="hidden" name="brandGroup" value="${searchCriteria.brandGroup}" class="srchFlg"/>
        <input type="hidden" name="searchFlag" value="${searchCriteria.searchFlag}" class="srchFlg"/>
        <input type="hidden" name="minPrice" value="${searchCriteria.minPrice}" class="srchFlg"/>
        <input type="hidden" name="maxPrice" value="${searchCriteria.maxPrice}" class="srchFlg"/>
        <input type="hidden" name="baseMinPrice" value="${searchCriteria.baseMinPrice}" class="srchFlg"/>
        <input type="hidden" name="baseMaxPrice" value="${searchCriteria.baseMaxPrice}" class="srchFlg"/>
        <input type="hidden" name="viewType" value="${searchCriteria.viewType}"/>
        <input type="hidden" name="prevQuery" value="${prevQuery}" class="srchFlg"/>
        <input type="hidden" name="categoryBrandCount" value="${searchCriteria.categoryBrandCount}"/>
        <input type="hidden" name="cmpsr" value="${searchCriteria.cmpsr}"/>
        <input type="hidden" name="rcrd_name" value="${searchCriteria.rcrd_name}"/>
        <input type="hidden" name="cndtr" value="${searchCriteria.cndtr}"/>
        <input type="hidden" name="prfmr_kor" value="${searchCriteria.prfmr_kor}"/>
        <input type="hidden" name="vocal" value="${searchCriteria.vocal}"/>
        <input type="hidden" name="oscal" value="${searchCriteria.oscal}"/>
        <input type="hidden" name="istmt_kor" value="${searchCriteria.istmt_kor}"/>
        <input type="hidden" name="label_name" value="${searchCriteria.label_name}"/>
        <input type="hidden" name="jmcode" value="${searchCriteria.jmcode}"/>
        <input type="hidden" name="trk_name" value="${searchCriteria.trk_name}"/>
        <input type="hidden" name="arti_name" value="${searchCriteria.arti_name}"/>
        <input type="hidden" name="ctgr_name" value="${searchCriteria.ctgr_name}"/>
        <input type="hidden" name="minDay" value="${searchCriteria.minDay}"/>
        <input type="hidden" name="maxDay" value="${searchCriteria.maxDay}"/>
        <input type="hidden" name="drctr" value="${searchCriteria.drctr}"/>
        <input type="hidden" name="actor" value="${searchCriteria.actor}"/>
        <input type="hidden" name="detailSearch" value="${searchCriteria.detailSearch}"/>
        <input type="hidden" name="deliveryVendorId" value="${searchCriteria.deliveryVendorId}"/>
        <input type="hidden" name="couponYn" value="${searchCriteria.couponYn}"/>
        <input type="hidden" name="freeDeliveryYn" value="${searchCriteria.freeDeliveryYn}"/>
        <div class="pop_tit">
            <input type="text" name="searchTerm" value="${searchCriteria.searchTerm}" class="input_txt" style="width:250px;"/>
            <a href="javascript://" onclick="document.searchedForm.submit()" class="btn_type01" id="btnSearch">검색</a>
        </div>
        <ul class="list_type02">
            <li>
                <span class="bold">'${searchCriteria.searchTerm}'</span>검색 결과 총 <strong class="bold point02"><fmt:formatNumber value="${giftSize + officeSize + recordSize + bluRaySize + dvdSize}" pattern="#,###"/></strong>개의 상품이 있습니다.
            </li>
        </ul>
        <div class="search_cate_tab">
            <ul>
                <c:if test="${empty searchCriteria.categoryGroup && empty searchCriteria.brandGroup}">
                    <c:if test="${searchCriteria.searchMenu eq 'TOTAL'}">
                        <li><a href="javascript:clkMenu('TOTAL');" class="${searchCriteria.menuGroup eq 'TOTAL'?'on':''}">전체 <span>(<fmt:formatNumber pattern=",###">${giftSize + officeSize + recordSize + bluRaySize + dvdSize + trackSize}</fmt:formatNumber>)</span></a></li>
                    </c:if>
                    <c:if test="${searchCriteria.searchMenu eq 'TOTAL' || searchCriteria.searchMenu eq 'GIFT'}">
                        <li><a href="javascript:clkMenu('GIFT');" class="${searchCriteria.menuGroup eq 'GIFT'?'on':''}">디자인 <span>(<fmt:formatNumber pattern=",###">${giftSize}</fmt:formatNumber>)</span></a></li>
                    </c:if>
                    <c:if test="${(searchCriteria.searchMenu eq 'TOTAL' || searchCriteria.searchMenu eq 'OFFICE') && not empty officeSize}">
                        <li><a href="javascript:clkMenu('OFFICE');" class="${searchCriteria.menuGroup eq 'OFFICE'?'on':''}">오피스 <span>(<fmt:formatNumber pattern=",###">${officeSize}</fmt:formatNumber>)</span></a></li>
                    </c:if>
                    <c:if test="${searchCriteria.searchMenu eq 'TOTAL' || searchCriteria.menuGroup eq 'RECORD'}">
                        <li><a href="javascript:clkMenu('RECORD');" class="${searchCriteria.menuGroup eq 'RECORD'?'on':''}">음반 <span>(<fmt:formatNumber pattern=",###">${recordSize}</fmt:formatNumber>)</span></a></li>
                    </c:if>
                    <c:if test="${searchCriteria.searchMenu eq 'TOTAL' || searchCriteria.menuGroup == 'BLURAY'}">
                        <li><a href="javascript:clkMenu('BLURAY');" class="${searchCriteria.menuGroup eq 'BLURAY'?'on':''}">BLU-RAY <span>(<fmt:formatNumber pattern=",###">${bluRaySize}</fmt:formatNumber>)</span></a></li>
                    </c:if>
                    <c:if test="${searchCriteria.searchMenu eq 'TOTAL' || searchCriteria.menuGroup eq 'DVD'}">
                        <li><a href="javascript:clkMenu('DVD');" class="${searchCriteria.menuGroup eq 'DVD'?'on':''}">DVD <span>(<fmt:formatNumber pattern=",###">${dvdSize}</fmt:formatNumber>)</span></a></li>
                    </c:if>
                </c:if>
                <c:if test="${not empty searchCriteria.categoryGroup && empty searchCriteria.brandGroup}">
                    <li class="ch"><a href="javascript://" class="on">${fn:substringAfter(searchCriteria.categoryGroup, '_')} <span>(<fmt:formatNumber pattern=",###">${searchCriteria.categoryBrandCount}</fmt:formatNumber>)</span></a></li>
                </c:if>
                <c:if test="${empty searchCriteria.categoryGroup && not empty searchCriteria.brandGroup}">
                    <li class="ch"><a href="javascript://" class="on">${searchCriteria.brandGroup} <span>(<fmt:formatNumber pattern=",###">${searchCriteria.categoryBrandCount}</fmt:formatNumber>)</span></a></li>
                </c:if>
            </ul>
        </div>
        <div class="tbl_top c_both mgt20">
            <div class="f_left">
                <ul class="tab_btn02 sort">
                    <li class="${searchCriteria.sort eq 'ACC'?'active':''}"><a href="javascript://" id="ACC">정확도</a></li>
                    <li class="${searchCriteria.sort eq 'DAT'?'active':''}"><a href="javascript://" id="DAT">최신순</a></li>
                    <li class="${searchCriteria.sort eq 'POP'?'active':''}"><a href="javascript://" id="POP">인기순</a></li>
                    <li class="${searchCriteria.sort eq 'DCR'?'active':''}"><a href="javascript://" id="DCR">할인율순</a></li>
                    <li class="${searchCriteria.sort eq 'ODC'?'active':''}"><a href="javascript://" id="ODC">판매순</a></li>
                    <li class="${searchCriteria.sort eq 'LOP'?'active':''}"><a href="javascript://" id="LOP">낮은가격순</a></li>
                    <li class="${searchCriteria.sort eq 'HIP'?'active':''}"><a href="javascript://" id="HIP">높은가격순</a></li>
                </ul>
            </div>
            <div class="btn_r">
                <ul class="tab_btn02 sort">
                    <li class="${searchCriteria.listSize eq '50'?'active':''}"><a href="javascript://" id="listSize50">50개</a></li>
                    <li class="${searchCriteria.listSize eq '100'?'active':''}"><a href="javascript://" id="listSize100">100개</a></li>
                </ul>
            </div>
        </div>
    </form>
    <div class="prod_list_brd">
        <ul>
            <c:forEach items="${listProduct}" var="l" varStatus="st">
                <!-- 기프트 -->
                <c:if test="${fn:startsWith(l.categoryId, '0000')}">
                    <li id="prod${l.productBarcode}">
                        <div class="hide">
                            <p class="brand">${l.brandName}</p>
                            <p class="name">${l.productName}</p>
                        </div>
                        <div class="cover"><a href="javascript://" onclick="setProduct('${l.productBarcode}', '${l.productPrice}', '${l.productDcPrice}')"><ui:image src="${l.productImageUrl}" server="product" size="100" width="98" height="98" alt="${l.productName}" clazz="photo"/></a></div>
                        <div class="p_txt">
                            <div class="txt_info"><a href="javascript://" onclick="setProduct('${l.productBarcode}', '${l.productPrice}', '${l.productDcPrice}')" class="tit">${l.brandName} - ${l.productName}</a></div>
                            <span class="price">
                                <c:if test="${l.productPrice > l.productDcPrice}">
                                    <span class="ori_price"><fmt:formatNumber value="${l.productPrice}" type="number" /></span>
                                    <span class="dis_price"><strong><fmt:formatNumber value="${l.productDcPrice}" type="number" /></strong> (${hfn:rate(l.productPrice, l.productDcPrice)}%)</span>
                                </c:if>
                                <c:if test="${l.productPrice <= l.productDcPrice}">
                                    <span class="dis_price"><strong><fmt:formatNumber value="${l.productPrice}" type="number" /></strong></span>
                                </c:if>
                            </span>
                        </div>
                    </li>
                </c:if>
                <!-- //기프트 -->
                <!-- CD -->
                <c:if test="${fn:startsWith(l.categoryId, '0003')}">
                    <li id="prod${l.sell_prdt_bcode}">
                        <div class="hide">
                            <p class="brand">${l.rcrd_name}</p>
                            <p class="name">${l.rcrd_name}</p>
                        </div>
                        <div class="cover">
                            <a href="javascript://" onclick="setProduct('${l.sell_prdt_bcode}', '${l.prdt_sell_price}', '${l.fc_get_dc_price}')">
                                <ui:image rcrdCd="${l.rcrd_cd}" prdtGbn="R" ratingCode="${l.rtngCode }" width="98" height="98" alt="${l.ctgr_name}" clazz="photo"/>
                                <span class="blank"><span>새창</span></span>
                            </a>
                        </div>
                        <div class="p_txt">
                            <div class="txt_info">
                                <a href="javascript://" onclick="setProduct('${l.sell_prdt_bcode}', '${l.prdt_sell_price}', '${l.fc_get_dc_price}')" class="tit">${l.label_name} - ${l.rcrd_name}</a>
                            </div>
                            <span class="price">
                                <c:if test="${l.prdt_sell_price > l.fc_get_dc_price}">
                                    <span class="ori_price"><fmt:formatNumber value="${l.prdt_sell_price}" type="number" /></span>
                                    <span class="dis_price"><strong><fmt:formatNumber value="${l.fc_get_dc_price}" type="number" /></strong> (${hfn:rate(l.prdt_sell_price, l.fc_get_dc_price)}%)</span>
                                </c:if>
                                <c:if test="${l.prdt_sell_price <= l.fc_get_dc_price}">
                                    <span class="dis_price"><strong><fmt:formatNumber value="${l.prdt_sell_price}" type="number" /></strong></span>
                                </c:if>
                                <c:if test="${l.prdt_saved_rate_double > 0}">
                                    <c:set var="savedPrice" value="${l.fc_get_dc_price * l.prdt_saved_rate_double / 100}"/>
                                    <span class="save_price"> | <fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" type="number" />원 (${l.prdt_saved_rate_double}%적립)</span>
                                </c:if>
                            </span>
                        </div>
                    </li>
                </c:if>
                <!-- //CD -->
                <!-- DVD -->
                <c:if test="${fn:startsWith(l.categoryId, '0004')}">
                    <li id="prod${l.sell_prdt_bcode}">
                        <div class="hide">
                            <p class="brand">${l.rcrd_name}</p>
                            <p class="name">${l.rcrd_name}</p>
                        </div>
                        <div class="cover">
                            <a href="javascript://" onclick="setProduct('${l.sell_prdt_bcode}', '${l.prdt_sell_price}', '${l.fc_get_dc_price}')">
                                <ui:image rcrdCd="${l.rcrd_cd}" prdtGbn="D" ratingCode="${l.rtngCode }" width="64" height="98" alt="${l.ctgr_name}" clazz="photo"/>
                                <span class="blank"><span>새창</span></span>
                            </a>
                        </div>
                        <div class="p_txt">
                            <div class="txt_info">
                                <a href="javascript://" onclick="setProduct('${l.sell_prdt_bcode}', '${l.prdt_sell_price}', '${l.fc_get_dc_price}')" class="tit">${l.label_name} - ${l.rcrd_name}</a>
                            </div>
                            <span class="price">
                                <c:if test="${l.prdt_sell_price > l.fc_get_dc_price}">
                                    <span class="ori_price"><fmt:formatNumber value="${l.prdt_sell_price}" type="number" /></span>
                                    <span class="dis_price"><strong><fmt:formatNumber value="${l.fc_get_dc_price}" type="number" /></strong> (${hfn:rate(l.prdt_sell_price, l.fc_get_dc_price)}%)</span>
                                </c:if>
                                <c:if test="${l.prdt_sell_price <= l.fc_get_dc_price}">
                                    <span class="dis_price"><strong><fmt:formatNumber value="${l.prdt_sell_price}" type="number" /></strong></span>
                                 </c:if>
                                <c:if test="${l.prdt_saved_rate_double > 0}">
                                    <c:set var="savedPrice" value="${l.fc_get_dc_price * l.prdt_saved_rate_double / 100}"/>
                                    <span class="save_price"> | <fmt:formatNumber value="${savedPrice+(10-(savedPrice%10))%10}" type="number" />원 (${l.prdt_saved_rate_double}%적립)</span>
                                </c:if>
                            </span>
                        </div>
                    </li>
                </c:if>
                <!-- //DVD -->
            </c:forEach>
        </ul>
    </div>
    <div class="paging"><ui:pagination template="defaultPost" name="pageHolder" url="?" parameters="searchMenu,subMenu,searchTerm,sort,menuGroup,categoryGroup,brandGroup,searchFlag,prevQuery,deliveryVendorId,couponYn,freeDeliveryYn,minPrice,maxPrice,baseMaxPrice,baseMinPrice,searchMenuText,listSize,saleYn,viewType,categoryBrandCount,cmpsr,rcrd_name,cndtr,prfmr_kor,vocal,oscal,istmt_kor,label_name,jmcode,trk_name,arti_name,ctgr_name,minDay,maxDay,drctr,actor"/></div><!-- end pager -->
</div>
</body>
</html>
