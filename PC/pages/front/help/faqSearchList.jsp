<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<script type="text/javascript">
jQuery(function($){
    $("tbody#faqListTbody tr td a.click").click(function(event) {
        event.preventDefault(); // # 링크 이동 중지
        
        var selectHref = $(this).attr("href");
        if($(selectHref).hasClass("on")){
            $(selectHref).removeClass("on");
        }else{
            $(selectHref).addClass("on");
            
            var seq = $(this).siblings("input").val();
            var hit = $("#faqHit" + seq);
            var hitVal = parseInt(hit.text()) + 1;
            hit.text(hitVal);
            //setHit
            $.ajax({
                type: "GET"
                ,url: "/ht/help/AjaxFFaqSetHit"
                ,dataType: "html"
                ,data:{seq:seq}
            });  
        }
    });
    
    $(".wordlist a").click(function(event) {
        $("form[name='faqSearchForm'] .exm_txt").hide();
        event.preventDefault();
        
        $("form[name='faqSearchForm']").find("input[name='title']").val($(this).text());
        $("form[name='faqSearchForm']").submit();
    });
    
    $("form[name='faqSearchForm'] .exm_txt").click(function(){
        $("form[name='faqSearchForm'] .exm_txt").hide();
        $("form[name='faqSearchForm'] input[name='title']").focus();
    });
    
    $("form[name='faqSearchForm'] input[name='title']").focus(function(){
        $("form[name='faqSearchForm'] .exm_txt").hide();
    });
    
    $("form[name='faqSearchForm'] input[name='title']").blur(function(){
        if($(this).val() == ""){
            $("form[name='faqSearchForm'] .exm_txt").show();
        }
    });
    
    $("form[name='faqSearchForm'] input[name='title']").select();
});
</script>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_cs_center.gif" alt="CS Center"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>FAQ 바로찾기</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/help/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_faq_search.gif" alt="FAQ 바로찾기" /></h3>
    <!-- search -->
    <div class="search_box02">
        <form method="get" action="/ht/help/faqSearchList" name="faqSearchForm">
            <fieldset>
                <legend>FAQ Search</legend>
                <label for="search_faq" class="stit"><img src="${imageServer}/images/renewal/common/stit_faq_search.gif" alt="FAQ Search"/></label>
                <span class="text_box">
                    <input type="text" id="search_faq" name="title" value="${faqCriteria.title}" title="검색어 입력" />
                    <a href="#" class="search_btn searchText"><span>검색</span></a>
                    <span class="exm_txt">검색어를 입력하세요</span>
                </span>
            </fieldset>
            <div class="wordlist">
                <strong>자주찾는 검색어 :</strong>
                <a href="#">회원정보</a>,
                <a href="#">주문결제</a>,
                <a href="#">배송</a>,
                <a href="#">반품</a>,
                <a href="#">교환</a>,
                <a href="#">환불</a>,
                <a href="#">마일리지</a>,
                <a href="#">예치금</a>,
                <a href="#">쿠폰</a>,
                <a href="#">영업점</a>
            </div>
        </form>
    </div>
    <!-- search -->

    <!-- list -->
    <table class="bbs_list01 tbl_slide mgt30">
        <caption>FAQ</caption>
        <colgroup>
            <col width="75" />
            <col width="120">
            <col width="*">
            <col width="90">
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">번호</th>
                <th scope="col">구분</th>
                <th scope="col">제목</th>
                <th scope="col" class="last">조회수</th>
            </tr>
        </thead>
        <tbody id="faqListTbody">
            <c:forEach items="${faqList}" var="faq" varStatus="faqStatus">
                <tr>
                    <td>${pageHolder.startNumber + faqStatus.index}</td>
                    <td><ui:code codeId="${faq.categoryCode}"/></td>
                    <td class="t_left">
                        <a href="#faq${faqStatus.index}" class="click">${faq.title}</a>
                        <input type="hidden" value="${faq.seq}"/>
                    </td>
                    <td id="faqHit${faq.seq}">${faq.hits}</td>
                </tr>
                <tr class="conts" id="faq${faqStatus.index}">
                    <td colspan="4"><div class="txt">${faq.cont}</div></td>
                </tr>
            </c:forEach> 
            <c:if test="${empty faqList && !empty title}"><tr><td colspan="4" class="no_data">검색 결과가 존재하지 않습니다.</td></tr></c:if>
            <c:if test="${empty faqList && empty title}"><tr><td colspan="4" class="no_data">등록된 FAQ가 없습니다.</td></tr></c:if>
        </tbody>
    </table>
    <!-- //list -->
    <!-- paging -->
    <div class="paging mgt40">
        <ui:pagination name="pageHolder" url="/ht/help/faqList${faqCriteria.categoryCode}" parameters="categoryCode,title"/>
    </div>
    <!-- //paging -->
</div>
<!-- //sub contents -->
</body>
</html>