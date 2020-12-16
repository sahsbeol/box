<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="record"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>주요 레이블 안내 | 수입음반 입고안내 | CD - HOTTRACKS</title>
<script type="text/javascript">
//통합 검색
function goSearchLable(searchTerm, searchMenu, subMenu, menuGroup) {
    //if(!serviceCheck()){
        // location.href = "/ht/search/searchMain?searchTerm="+encodeURI(searchTerm)+"&searchMenu="+searchMenu+"&subMenu="+subMenu+"&menuGroup="+menuGroup;
        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", "/ht/search/searchMain");
        document.body.appendChild(form);
        
        form.appendChild(getInputTag("searchTerm", searchTerm));
        form.appendChild(getInputTag("searchMenu", searchMenu));
        form.appendChild(getInputTag("subMenu", subMenu));
        form.appendChild(getInputTag("menuGroup", menuGroup));
         
        form.submit();
    //}
}

</script>
</head>
<body>
<div id="container"> 
    <!-- music 현재 페이지 위치 소스 입니다 -->
    <div class="page_music">
        <div class="page-location">
            <p class="title"><img src="${imageServer}/images/music/title_music_s14.gif" alt="수입음반 입고안내" /></p>
            <ul>
                <li><a href="/">홈</a> <span>&gt;</span></li>
                <li><a href="<ui:recordConstants key="url_record_main" />">음반</a> <span>&gt;</span></li>
                <li><a href="/ht/record/lableStockedList">수입음반 입고안내</a> <span>&gt;</span></li> 
                <li><strong>주요 레이블 안내</strong></li>
            </ul> 
        </div>
    </div>
    <!-- //music 현재 페이지 위치 소스 입니다 --> 
    <!-- snb -->
    <div class="snb_mnew"> 
        <div class="snb_music">
            <ul>
                <li><a href="/ht/record/lableStockedList">레이블 입고 안내</a></li>
                <li class="on"><a href="/ht/record/labelInfo">주요 레이블 안내</a></li>
            </ul>
        </div>    
    </div>
    <!-- //snb --> 
    <!-- music -->
    <div id="music">
        <div class="contents">
            <div class="stitle">
                <h3>주요 레이블 안내</h3>
            </div>
            <div class="label_guide">
                <p><img src="${imageServer}/images/music/img_label_guide_01.gif"  alt="pop" /></p>
                <div class="pop_label">
                    <ul>
                        <li class="p1"><a href="javascript:goSearchLable('EMI','LABLE_NAME','', 'RECORD', 'RECORD')">#</a></li>
                        <li class="p2"><a href="javascript:goSearchLable('Warner Music','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p3"><a href="javascript:goSearchLable('Universal','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p4"><a href="javascript:goSearchLable('BMG','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p5"><a href="javascript:goSearchLable('Sony','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p6"><a href="javascript:goSearchLable('GEFFEN','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p7"><a href="javascript:goSearchLable('RHINO','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p8"><a href="javascript:goSearchLable('Vanguard','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p9"><a href="javascript:goSearchLable('Virgin','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p10"><a href="javascript:goSearchLable('EPIC','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p11"><a href="javascript:goSearchLable('ISLAND','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p12"><a href="javascript:goSearchLable('ATLANTIC','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p13"><a href="javascript:goSearchLable('INTERSCOPE','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p14"><a href="javascript:goSearchLable('INTERSCOPE','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p15"><a href="javascript:goSearchLable('Columbia','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p16"><a href="javascript:goSearchLable('Blue Note','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p17"><a href="javascript:goSearchLable('ECM','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p18"><a href="javascript:goSearchLable('GRP','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p19"><a href="javascript:goSearchLable('Venus','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p20"><a href="javascript:goSearchLable('Verve','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p21"><a href="javascript:goSearchLable('MERCURY','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p22"><a href="javascript:goSearchLable('RCA','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p23"><a>#</a></li>
                        <li class="p24"><a href="javascript:goSearchLable('ROADRUNNER','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p25"><a href="javascript:goSearchLable('TOMMY BOY','LABLE_NAME','', 'RECORD')">#</a></li>
                    </ul>
                    <p class="all_label"><a href="/ht/record/labelAllView?searchIndex=0"><img src="${imageServer}/images/music/btn_all_label.gif"  alt="레이블 전체보기" /></a></p>
                </div>
                <p><img src="${imageServer}/images/music/img_label_guide_02.gif"  alt="pop" /></p>
                <div class="classic_label">
                    <ul>
                        <li class="p1"><a href="javascript:goSearchLable('Deutsche Grammophon','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p2"><a href="javascript:goSearchLable('DECCA','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p3"><a href="javascript:goSearchLable('PHILIPS','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p4"><a href="javascript:goSearchLable('EMI CLASSICS','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p5"><a href="javascript:goSearchLable('NEXOS','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p6"><a href="javascript:goSearchLable('RCA VICTOR','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p7"><a href="javascript:goSearchLable('harmonia mundi','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p8"><a href="javascript:goSearchLable('hyperion','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p9"><a href="javascript:goSearchLable('ERATO','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p10"><a href="javascript:goSearchLable('BERLIN CLASSICS','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p11"><a href="javascript:goSearchLable('CHANNEL CLASSIC','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p12"><a href="javascript:goSearchLable('TACET','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p13"><a href="javascript:goSearchLable('NAIVE','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p14"><a href="javascript:goSearchLable('BBC','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p15"><a href="javascript:goSearchLable('TAHRA','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p16"><a href="javascript:goSearchLable('SONY CLASSICAL','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p17"><a href="javascript:goSearchLable('WARNER CLASSICS','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p18"><a href="javascript:goSearchLable('RCA LIVING STEREO','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p19"><a href="javascript:goSearchLable('KING RECORDS','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p20"><a href="javascript:goSearchLable('DYNAMIC','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p21"><a href="javascript:goSearchLable('ELATUS','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p22"><a href="javascript:goSearchLable('BRILLIANT CLASSICS','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p23"><a href="javascript:goSearchLable('ARCHIV','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p24"><a href="javascript:goSearchLable('DELOS','LABLE_NAME','', 'RECORD')">#</a></li>
                        <li class="p25"><a href="javascript:goSearchLable('CHANDOS','LABLE_NAME','', 'RECORD')">#</a></li>
                    </ul>
                    <p class="all_label"><a href="/ht/record/labelAllView?searchIndex=0"><img src="${imageServer}/images/music/btn_all_label.gif"  alt="레이블 전체보기" /></a></p>
                </div>
            </div>
        </div>
    </div>
    <!-- //music --> 
</div>
</body>
</html>