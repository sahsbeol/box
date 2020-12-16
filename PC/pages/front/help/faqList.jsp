<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:if test="${faqCriteria.categoryCode eq 'C0391'}"><c:set var="step1" value="주문결제"/><c:set var="step2" value="주문FAQ"/></c:if>
<c:if test="${faqCriteria.categoryCode eq 'C0392'}"><c:set var="step1" value="배송"/><c:set var="step2" value="주문FAQ"/></c:if>
<c:if test="${faqCriteria.categoryCode eq 'C0393'}"><c:set var="step1" value="반품/교환/환불"/><c:set var="step2" value="주문FAQ"/></c:if>
<c:if test="${faqCriteria.categoryCode eq 'C0394'}"><c:set var="step1" value="세금계산서/증빙"/><c:set var="step2" value="주문FAQ"/></c:if>
<c:if test="${faqCriteria.categoryCode eq 'C0401'}"><c:set var="step1" value="회원정보"/><c:set var="step2" value="회원FAQ"/></c:if>
<c:if test="${faqCriteria.categoryCode eq 'C0402'}"><c:set var="step1" value="통합포인트/예치금/쿠폰"/><c:set var="step2" value="회원FAQ"/></c:if>
<c:if test="${faqCriteria.categoryCode eq 'C0403'}"><c:set var="step1" value="상품문의"/><c:set var="step2" value="회원FAQ"/></c:if>
<c:if test="${faqCriteria.categoryCode eq 'C0404'}"><c:set var="step1" value="이벤트"/><c:set var="step2" value="회원FAQ"/></c:if>
<c:if test="${faqCriteria.categoryCode eq 'C0411'}"><c:set var="step1" value="영업점"/><c:set var="step2" value="기타FAQ"/></c:if>
<c:if test="${faqCriteria.categoryCode eq 'C0412'}"><c:set var="step1" value="사이트이용/장애"/><c:set var="step2" value="기타FAQ"/></c:if>
<c:if test="${faqCriteria.categoryCode eq 'C0413'}"><c:set var="step1" value="기타"/><c:set var="step2" value="기타FAQ"/></c:if>
<html>
<head>
<title>${step1} | ${step2} | 고객센터 - HOTTRACKS</title>
<script type="text/javascript">
jQuery(function($){
    <%-- faq 제목 클릭 이벤트 --%>
    $("tbody tr td a.click").click(function(event) {
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
    
    <%-- 자주찾는 검색어 처리 --%>
    $("a.searchText").click(function(event) {
        event.preventDefault(); // # 링크 이동 중지
        
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
    <c:choose>
        <c:when test="${faqCriteria.categoryCode eq 'C0391' || faqCriteria.categoryCode eq 'C0392' || faqCriteria.categoryCode eq 'C0393' || faqCriteria.categoryCode eq 'C0394'}">
            <div class="loc"><a href="/" class="home">Home</a><em>주문 FAQ</em></div>
        </c:when>
        <c:when test="${faqCriteria.categoryCode eq 'C0401' || faqCriteria.categoryCode eq 'C0402' || faqCriteria.categoryCode eq 'C0403' || faqCriteria.categoryCode eq 'C0404'}">
            <div class="loc"><a href="/" class="home">Home</a><em>회원 FAQ</em></div>
        </c:when>
        <c:otherwise>
            <div class="loc"><a href="/" class="home">Home</a><em>기타 FAQ</em></div>
        </c:otherwise>
    </c:choose>
</div>
<!-- //sub top -->

<c:import url="/menu/help/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    <c:choose>
        <c:when test="${faqCriteria.categoryCode eq 'C0391' || faqCriteria.categoryCode eq 'C0392' || faqCriteria.categoryCode eq 'C0393' || faqCriteria.categoryCode eq 'C0394'}">
            <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_order_faq.gif" alt="주문 FAQ" /></h3>
        </c:when>
        <c:when test="${faqCriteria.categoryCode eq 'C0401' || faqCriteria.categoryCode eq 'C0402' || faqCriteria.categoryCode eq 'C0403' || faqCriteria.categoryCode eq 'C0404'}">
            <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_member_faq.gif" alt="회원 FAQ" /></h3>
        </c:when>
        <c:otherwise>
            <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_etc_faq.gif" alt="기타 FAQ" /></h3>
        </c:otherwise>
    </c:choose>
    <!-- search -->
    <div class="search_box02">
        <form method="get" action="/ht/help/faqList${faqCriteria.categoryCode}" name="faqSearchForm">
            <fieldset>
                <legend>FAQ Search</legend>
                <label for="search_faq" class="stit"><img src="${imageServer}/images/renewal/common/stit_faq_search.gif" alt="FAQ Search"/></label>
                <span class="text_box">
                    <input type="text" id="search_faq" name="title" value="${faqCriteria.title}" title="검색어 입력" />
                    <a href="#" class="search_btn searchText"><span>검색</span></a>
                    <span class="exm_txt">검색어를 입력하세요</span>
                </span>
            </fieldset>
        </form>
    </div>
    <!-- search -->

    <!-- tab -->
    <div class="tab1 typeS">
        <c:choose>
            <c:when test="${faqCriteria.categoryCode eq 'C0391' || faqCriteria.categoryCode eq 'C0392' || faqCriteria.categoryCode eq 'C0393' || faqCriteria.categoryCode eq 'C0394'}">
                <ul> 
                    <li><a href="/ht/help/faqListC0391" <c:if test="${faqCriteria.categoryCode eq 'C0391'}">class="on"</c:if>><span>주문결제</span></a></li>
                    <li><a href="/ht/help/faqListC0392" <c:if test="${faqCriteria.categoryCode eq 'C0392'}">class="on"</c:if>><span>배송</span></a></li> 
                    <li><a href="/ht/help/faqListC0393" <c:if test="${faqCriteria.categoryCode eq 'C0393'}">class="on"</c:if>><span>반품/교환/환불</span></a></li>
                    <li><a href="/ht/help/faqListC0394" <c:if test="${faqCriteria.categoryCode eq 'C0394'}">class="on"</c:if>><span>세금계산서/증빙</span></a></li>
                </ul>  
            </c:when>
            <c:when test="${faqCriteria.categoryCode eq 'C0401' || faqCriteria.categoryCode eq 'C0402' || faqCriteria.categoryCode eq 'C0403' || faqCriteria.categoryCode eq 'C0404'}">
                <ul> 
                    <li><a href="/ht/help/faqListC0401" <c:if test="${faqCriteria.categoryCode eq 'C0401'}">class="on"</c:if>><span>회원정보</span></a></li>
                    <li><a href="/ht/help/faqListC0402" <c:if test="${faqCriteria.categoryCode eq 'C0402'}">class="on"</c:if>><span>통합포인트/예치금/쿠폰</span></a></li>
                    <li><a href="/ht/help/faqListC0403" <c:if test="${faqCriteria.categoryCode eq 'C0403'}">class="on"</c:if>><span>상품문의</span></a></li>
                    <li><a href="/ht/help/faqListC0404" <c:if test="${faqCriteria.categoryCode eq 'C0404'}">class="on"</c:if>><span>이벤트</span></a></li> 
                </ul>
            </c:when>
            <c:otherwise>
                <ul> 
                    <li><a href="/ht/help/faqListC0411" <c:if test="${faqCriteria.categoryCode eq 'C0411'}">class="on"</c:if>><span>영업점</span></a></li>
                    <li><a href="/ht/help/faqListC0412" <c:if test="${faqCriteria.categoryCode eq 'C0412'}">class="on"</c:if>><span>사이트이용/장애</span></a></li> 
                    <li><a href="/ht/help/faqListC0413" <c:if test="${faqCriteria.categoryCode eq 'C0413'}">class="on"</c:if>><span>기타</span></a></li> 
                </ul> 
            </c:otherwise>
        </c:choose> 
    </div>
    <!-- //tab -->
    <!-- list -->
    <table class="bbs_list01 tbl_slide">
        <caption></caption>
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
        <tbody>
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