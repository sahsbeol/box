<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<script type="text/javascript">
<!--
jQuery(function($){
    $(".srch_box02 .side_menu li a").click(function(){
        if(!$(this).hasClass("active")){
            $(".srch_box02 .side_menu li a.active").removeClass("active");
            $(".srch_box02 .srch_list_item.active").removeClass("active");
            
            $(this).addClass("active");
            $(".srch_box02 .srch_list_item").eq($(".srch_box02 .side_menu li").index($(this).parent())).addClass("active");
        }
    });
    
    // 자동완성/최근키워드 열기
    $("form[name=gnbSearchFrm] input[name=searchTerm]").focus(function(){
        $(".srch_box01").show();
    });
    
    // 자동완성/최근키워드 닫기
    $("body").click(function(e){
        if($(".srch_box01").css("display") == "block"){
            if(!$(".search").has(e.target).length && !$(".srch_box01").has(e.target).length){
                $(".srch_box01").hide();
            }
        }
    });
});

function gnbSrchFrm(){
    var frm = $("form[name=gnbSearchFrm]");
    if(frm.length < 1){
        frm = $("form[name=searchedForm]");
    }
    if($.trim(frm.find("input[name=searchTerm]").val()) == ""){
        alert("검색어를 입력해주세요");
        return false;
    }
    frm.submit();
}

function gnbSrchKerword(keyword){
    if($("form[name=gnbSearchFrm]").length < 1){
        _search(keyword);
    }else{
        
        $("form[name=gnbSearchFrm] input[name=searchTerm]").val(keyword);
        gnbSrchFrm();
    }
}

function rmRcntKerword(rcntKeySeq, id){
    $.ajax({
        type: "GET"
        , url: "/m/search/rmRecentKeyword"
        , data: "rcntKeySeq=" + rcntKeySeq
        , dataType: "json"
        , success: function(data) {
            $(id).slideUp();
        }
        , error: function() {
            //alert("<fmt:message key='error.common.system'/>");
        }
    });
}
//-->
</script>
<div id="gnb-search">
    <div id="srch_util" class="srch_cont">
        <!-- search -->
         <div class="search">
            <form name="gnbSearchFrm" action="${defaultHost}/m/search/searchMain" method="post">
                <input type="hidden" name="viewType"/>
                <input type="hidden" name="searchMenu"/>
                <fieldset>
                    <legend>검색</legend>
                    <div class="s_box">
                        <input type="text" class="s_input" name="searchTerm" value="" placeholder="검색어를 입력하세요" title="검색어를 입력하세요" autocomplete="off"/>
                        <a href="#" class="s_submit" onclick="gnbSrchFrm();return false;">검색</a>
                    </div>
                </fieldset>
            </form>
        </div>
        <!-- //.search -->
        <div class="srch_box01">
            <div class="search_auto_cmplt">
                <p class="tit">연관 검색어</p>
                <div class="srch_list">
                    <div class="srch_list" id="searchAutoCmplt"></div>
                </div>
            </div>
            <c:if test="${not empty listKeywordRecent}">
                <p class="tit">최근 검색어</p>
                <div class="srch_list">
                    <c:forEach items="${listKeywordRecent}" var="l" varStatus="st">
                        <p id="lyRcntItem${l.rcntKeySeq}">
                            <a href="#" onclick="gnbSrchKerword('${l.keyword}');return false;">${l.keyword}</a>
                            <a href="#" onclick="rmRcntKerword('${l.rcntKeySeq}', '#lyRcntItem${l.rcntKeySeq}');return false;" class="btn_del">삭제</a>
                        </p>
                    </c:forEach>
                </div>
            </c:if>
        </div>
        <div class="srch_box02">
            <!-- .side_menu -->
            <ul class="side_menu">
                <li><a href="#" onclick="return false;" class="active">인기 검색어</a></li>
                <li><a href="#" onclick="return false;">추천 검색어</a></li>
            </ul>
            <!-- //.side_menu -->
            <div class="srch_list">
                <div class="srch_list_item popular arrow active">
                    <c:forEach items="${listKeywordBest}" var="l" varStatus="st">
                        <p><a href="#" onclick="gnbSrchKerword('${l.keyword}');return false;" class="<c:if test="${l.prevRank eq 0 || l.prevRank > l.ranking}"> up</c:if><c:if test="${l.prevRank ne 0 && l.prevRank < l.ranking}"> down</c:if>"><em class="num">${st.count}</em>${l.keyword}</a></p>
                    </c:forEach>
                </div>
                <div class="srch_list_item recomend">
                    <c:forEach items="${listKeywordPick}" var="l" varStatus="st">
                        <p><a href="#" onclick="gnbSrchKerword('${l.keyword}');return false"><em class="num">${st.count}</em>${l.keyword}</a></p>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
    <div id="srch-close-box" onclick="closeGnbSearch()">
        <a href="javascript://">메뉴 레이어 닫기</a>
    </div>
</div>