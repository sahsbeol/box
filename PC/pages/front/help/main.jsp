<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>고객센터 - HOTTRACKS</title>
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
    <div class="loc"><a href="/" class="home">Home</a><em>CS CENTER</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/help/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    <!-- search -->
    <div class="search_box02">
        <form method="get" action="/ht/help/faqSearchList" name="faqSearchForm">
            <fieldset>
                <legend>FAQ Search</legend>
                <label for="search_faq" class="stit"><img src="${imageServer}/images/renewal/common/stit_faq_search.gif" alt="FAQ Search"/></label>
                <span class="text_box">
                    <input type="text" id="search_faq" name="title" title="검색어 입력" />
                    <a href="#" class="search_btn"><span>검색</span></a>
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

    <!-- BEST FAQ -->
    <h3 class="s_title"><img src="${imageServer}/images/renewal/common/stit_best_faq.gif" alt="BEST FAQ"/><strong class="desc">고객님들께서 가장 많이 궁금해하시는 사항입니다.</strong></h3>
    <table class="bbs_list01 tbl_slide">
        <caption></caption>
        <colgroup>
            <col width="75" />
            <col width="120">
            <col width="*">
            <col width="100">
            <col width="90">
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">번호</th>
                <th scope="col">구분</th>
                <th scope="col">제목</th>
                <th scope="col">등록일</th>
                <th scope="col" class="last">조회수</th>
            </tr>
        </thead>
        <tbody id="faqListTbody">
            <c:forEach items="${faqList}" var="l" varStatus="st">
                <tr> 
                    <td>${st.count}</td>
                    <td><ui:code codeId="${l.categoryCode}"/></td>
                    <td class="t_left">
                        <input type="hidden" value="${l.seq}"/>
                        <a href="#faq${st.index}" class="click">${l.title}</a>
                    </td>
                    <td><fmt:formatDate value="${l.registDate}" pattern="yyyy.MM.dd hh:mm:ss"/></td>
                    <td id="faqHit${l.seq}">${l.hits}</td>
                </tr>
                <tr class="conts" id="faq${st.index}">
                    <td colspan="5"><div class="txt">${l.cont}</div></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <!-- //BEST FAQ -->

    <!-- NEWS &amp; NOTICE -->
    <h3 class="s_title"><img src="${imageServer}/images/renewal/common/stit_news_notice.gif" alt="NEWS &amp; NOTICE"/></h3>
    <table class="bbs_list01">
        <caption></caption>
        <colgroup>
            <col width="75" />
            <col width="*">
            <col width="110">
            <col width="90">
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">번호</th>
                <th scope="col">제목</th>
                <th scope="col">등록일</th>
                <th scope="col" class="last">조회수</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${noticeList}" var="l" varStatus="st">
                <tr>
                    <td>${st.count}</td>
                    <td class="t_left"><a href="/ht/help/listNotice?notiSeq=${l.notiSeq}&categoryId=0000">${l.title}</a></td>
                    <td><fmt:formatDate value="${l.registrationDate}" pattern="yyyy.MM.dd hh:mm:ss"/></td>
                    <td>${l.hit}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <!-- //NEWS &amp; NOTICE -->
</div>
<!-- //sub contents -->
</body>
</html>