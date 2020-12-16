<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>${store.deptname} | 영업점 - New Me Hottracks</title>
<style type="text/css">
.main_slide_navi{left: 46%;}
.blackText{ position: absolute; background: url('http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/company/bg_10x10.png'); top: 393px; font-size: 11px; width: 660px; height: 104px; z-index: 5; padding: 20px; color: white;}
div#contents_area .blackText li{margin : 6px;}
div#contents_area .blackText li:FIRST-CHILD{font-size: 20px; font-weight: bold; margin-bottom: 10px;}
#main_spot .main_sec2 .main_slide_navi{z-index : 6;}
.bannerList{display :inline;}
.event{ position: relative; display: inline-block;}

h3{display: inline-block; border-top:15px;margin-right: 160px;}
.event{ position: relative; display: inline-block;}
.event .eventMore { top:20px; }
.notification{ height:auto; }
.notification .storeInfoWrap{ clear: both; position: relative; width: 680px; border: 1px solid #d3d6d9; left: -3px; }
.notification .storeInfoWrap.storeInfo{width: 680px; }
.notification .storeInfoWrap .storeInfo dl dd.w240{ width :150px; }
.notification .storeInfoWrap .storeInfo dl dd.w600{ width : 595px; }
#mapLayer { margin-top : 20px; }
#mapLayer iframe{ border : 1px solid #d3d6d9; }

</style>
<script type="text/javascript" src="/js/fn_htts_slide.js"></script>
<script type="text/javascript">
jQuery(function($){
    $(document).ready(function(){
        if("${listBnrStore[0].imgUrl}"!= null || "${listBnrStore[0].imgUrl}" != ""){
            slideDiv(".main_sec2", 6000, ".main_sec2");
            $(".blackText").show();
        }else{
            slideDiv(".main_sec2", 6000, ".main_sec2");
            $(".blackText").hide();
        }
    });
    
});
function clickMoreBtn(deptcode, section){
    console.log(section);
    if(section =='S'){
        location.href="/company/store/event?deptcode="+deptcode+"&section="+section;
    }else{
        location.href="/company/store/event?deptcode="+deptcode;
    }
}
</script>
<c:if test="${store.deptcode eq '030020'}">
<script type="text/javascript">
if(getCookie("hottracks3981") != "yes"){//이미지높이보다 23 크게
    var top = 0;
    var left = 520;
    var popup = window.open('/company/popup?boardseq=3981','_hottracks3981','width=500, height=423, top='+top+',left='+left+' ,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no');
    popup.focus();
}
</script>
</c:if>
</head>
<body>
<div id="container">
<p class="cont_topBg_recruit"><img src="http://image.hottracks.co.kr/info/layout/bg_snb_shop.png" alt="핫트랙스 영업점의 여러가지 소식을 알려드립니다"/></p>
<c:import url="/company/store/lnb?deptcode=${c.deptcode}"/>
<!-- contents area -->
<div id="contents_area">
    <!-- location -->
    <div id="location">
        <h2>${store.deptname}</h2>
        <em class="location">HOME &gt; 영업점 &gt; <strong>${store.deptname}</strong></em>
    </div>
    <!-- //location -->  
    <!-- 영업점 배너 -->
    
    <c:if test="${not empty store && not empty listBnrStore}">
        <div class="blackText">
            <ul>
                <li>핫트랙스 ${store.deptname}</li>
                <li>* 전화번호 : ${store.rdpTlnm} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 영업시간 : ${store.rdpTime}</li>
                <li>* 정기휴일 : ${store.rdpOffday}</li>
                <li>* 주소 : ${store.rdpAddr}</li>
            </ul>
        </div>
    </c:if>
            
    <c:if test="${not empty listBnrStore }">
        <div id="main_spot">
            <div class="main_sec2">
                <ul class="main_slide_btn slide_view">
                    <c:forEach items="${listBnrStore}" var="l" varStatus="st">
                        <li class="main_slide_img">
                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/${l.imgUrl}" alt="${l.imgAlt}" width ="${l.bnrWidth }" height ="${l.bnrHeight }"/>
                        </li>
                    </c:forEach>
                </ul>
                <ul class="main_slide_navi">
                    <c:forEach items="${listBnrStore}" var="l" varStatus="st">
                        <li class="slide_navi ${st.first?'active':''}"><a href="javascript://"><img src="${imageServer}/images/common/ic_navi0${st.count}.png"/></a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </c:if>
    
    <c:if test="${not empty events || not empty signs}">
        <c:set var="cntEvent" value="${fn:length(events)}"/>
        <c:set var="cntSign" value="${fn:length(signs)}"/>
        <c:choose>
            <c:when test="${cntSign > 1}">
                <c:choose>
                    <c:when test="${cntEvent > 0}">
                        <c:set var="maxEvent" value="1"/>
                        <c:set var="maxSign" value="2"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="maxEvent" value="${cntEvent}"/>
                        <c:set var="maxSign" value="${3-cntEvent}"/>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${cntEvent > 2}">
                        <c:set var="maxEvent" value="${3-cntSign}"/>
                        <c:set var="maxSign" value="${cntSign}"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="maxEvent" value="${cntEvent-cntSign}"/>
                        <c:set var="maxSign" value="${cntSign}"/>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
        <c:forEach begin="0" end="1" varStatus="s1">
            <c:if test="${s1.index eq 0}">
                <c:set var="list" value="${events}"/>
                <c:set var="endIdx" value="${maxEvent-1}"/>
                <c:set var="titImg" value="${imageServer}/images/bt_event.png"/>
                <c:set var="titTxt" value="이벤트안내"/>
            </c:if>
            <c:if test="${s1.index eq 1}">
                <c:set var="list" value="${signs}"/>
                <c:set var="endIdx" value="${maxSign-1}"/>
                <c:set var="titImg" value="${imageServer}/images/bt_sign.png"/>
                <c:set var="titTxt" value="사인회"/>
            </c:if>
            <c:if test="${not empty list}">
                <div class="event" >
                    <h3><img src="${titImg}" alt="${titTxt}" /></h3>
                    <div class="eventInfoWrap">
                        <ol class="bannerList">
                            <c:forEach items="${list}" var="l" varStatus="st" end="${endIdx}">
                                <li <c:if test="${st.first}">class="firstChild"</c:if>>
                                    <div class="bannerImg">
                                        <a href="/company/store/eventView?deptcode=${store.deptcode}&boardseq=${l.boardseq}" title="${l.title }"><img src="http://info.hottracks.co.kr${l.imgurl }" alt="${l.title }" width="209" height="77"/></a>
                                        <c:choose>
                                            <c:when test="${l.prosGbn eq 'N'}"><div class="bannerIcon"><img src="http://image.hottracks.co.kr/info/story/ico_now.png" alt="NOW" class="png24" /></div></c:when>
                                            <c:when test="${l.prosGbn eq 'S'}"><div class="bannerIcon"><img src="http://image.hottracks.co.kr/info/story/ico_soon.png" alt="SOON" class="png24" /></div></c:when>
                                            <c:otherwise><div class="bannerIcon"><img src="http://image.hottracks.co.kr/info/story/ico_end.png" alt="END" class="png24" /></div></c:otherwise>
                                        </c:choose>
                                    </div>
                                    <ul class="bannerTxt">
                                        <li><a href="/company/store/eventView?deptcode=${store.deptcode}&boardseq=${l.boardseq}" title="${l.title }">${l.title}</a></li>
                                        <li><ui:mask pattern="####/##/##">${l.startdate}</ui:mask>~<ui:mask pattern="####/##/##">${l.enddate}</ui:mask></li>
                                        <li>
                                            <c:set var="arrDpCdName" value="${fn:split(l.deptnames, ',') }"/> 
                                            <c:choose>
                                                <c:when test="${fn:length(arrDpCdName) > 3 }">${arrDpCdName[0] }, ${arrDpCdName[1] }, ${arrDpCdName[2] } 외</c:when>
                                                <c:otherwise>${l.deptnames}</c:otherwise>
                                            </c:choose>
                                        </li>
                                    </ul>
                                </li>
                            </c:forEach>
                        </ol>
                    </div>
                    <p class="eventMore"><a href="#" onclick="clickMoreBtn('${store.deptcode}',null); return false;" title="더보기"><img src="http://image.hottracks.co.kr/info/common/btn_more.png" alt="더보기" /></a></p>
                </div>
            </c:if>
        </c:forEach>
    </c:if>
    <hr />
    <!-- 지점하단 -->
    
    <div class="notification">
        <!-- 지점추천상품미리보기(공통) -->
        <c:if test="${not empty notices }">
            <div class="bbsPrev">
                <!-- 지점공지미리보기(공통) -->
                <h4><img src="http://image.hottracks.co.kr/info/shop/title_notice.png" alt="알려드립니다" /></h4>
                <div class="noticePrev">
                    <ul>
                        <c:forEach items="${notices}" var="item" varStatus="status" begin="0" end="4">
                        <li>
                            <div class="bbsTxt">
                                <a href="/company/store/eventView?deptcode=${store.deptcode }&boardseq=${item.boardseq}" title="${item.title }">${item.title}</a>
                                <c:if test="${item.newYn eq 'Y'}"><img src="http://image.hottracks.co.kr/info/common/icon_new.png" alt="New" /></c:if>
                            </div>
                            <div class="bbsDate"><ui:mask pattern="####/##/##">${item.registerdate}</ui:mask></div>
                        </li>
                        </c:forEach>
                    </ul>
                    <p class="bbsMore"><a href="/company/store/board?deptcode=${store.deptcode }" title="더보기"><img src="http://image.hottracks.co.kr/info/common/btn_more.png"  alt="더보기" /></a></p>
                </div>
            </div>
        </c:if>
        <c:if test="${not empty storys }">
        <div class="bbsPrev">
            <h4><img src="http://image.hottracks.co.kr/info/shop/title_shopStory.png" alt="영업점이야기" /></h4>
            <div class="storyPrev">
                <ul>
                    <c:forEach items="${storys}" var="item" varStatus="status" begin="0" end="4">
                    <li>
                        <div class="bbsTxt">
                            <a href="/company/store/storyView?deptcode=${store.deptcode}&boardseq=${item.boardseq}" title="${item.title }" slist="slist" boardseq="">${item.title }</a>
                            <c:if test="${item.newYn eq 'Y'}"><img src="http://image.hottracks.co.kr/info/common/icon_new.png" alt="New" /></c:if>
                        </div>
                        <div class="bbsDate"><ui:mask pattern="####/##/##">${item.registerdate}</ui:mask></div>
                    </li>
                    </c:forEach>
                </ul>
                <p class="bbsMore" style="top:-42px;"><a href="/company/store/story?deptcode=${store.deptcode }" title="더보기"><img src="http://image.hottracks.co.kr/info/common/btn_more.png"  alt="더보기" /></a></p>
            </div>
        </div><!-- //bbsPrev -->
        </c:if>
        <!-- 지점별 영업점 안내(공통) -->
    <h3 class="hidden">영업지점별 안내</h3>
    <div class="storeInfoWrap">
        <div class="guide"><span class="TL"></span><span class="TR"></span></div><!-- connering 공통 -->
        <div class="storeInfo"><!-- 지점별 정보입력 -->
            <dl>
                <dt><img src="http://image.hottracks.co.kr/info/shop/txt_info_location.png" alt="소재지" /></dt>
                <dd>${store.rdpAddr }</dd>
                <%-- <dd>${store.rdpAddr}<span><a href="#none" id="btnMap"><img src="http://image.hottracks.co.kr/info/shop/ico_map.png" alt="약도"/></a></span></dd> --%>
                <dt><img src="http://image.hottracks.co.kr/info/shop/txt_info_num.png" alt="대표전화" /></dt>
                <dd class="w240">${store.rdpTlnm}<br/>교보문고 관련 문의는<br/>(도서 및 기타 문고상품 포함)<br/>1544-1900으로 문의바랍니다.</dd>
            </dl>
            <c:if test="${not empty store.rdpTime && not empty store.rdpOffday}">
                <dl>
                    <c:if test="${not empty store.rdpTime}">
                        <dt><img src="http://image.hottracks.co.kr/info/shop/txt_info_time.png" alt="영업시간" /></dt>
                        <dd><ui:br>${store.rdpTime}</ui:br></dd>
                    </c:if>
                    <c:if test="${not empty store.rdpOffday}">
                        <dt><img src="http://image.hottracks.co.kr/info/shop/txt_info_offday.png" alt="정기휴일" /></dt>
                        <dd class="w240">${store.rdpOffday}</dd>
                    </c:if>
                </dl>
            </c:if>
            <c:if test="${not empty store.rdpTraffic}">
                <dl>
                    <dt class="w600"><img src="http://image.hottracks.co.kr/info/shop/txt_info_traffic.png" alt="교통편안내" /></dt>
                    <dd class="w600"><ui:br>${store.rdpTraffic}</ui:br></dd>
                </dl>
            </c:if>
            <c:if test="${not empty store.rdpParking}">
                <dl>
                    <dt class="w600"><img src="http://image.hottracks.co.kr/info/shop/txt_info_parking.png" alt="주차안내" /></dt>
                    <dd class="w600"><ui:br>${store.rdpParking}</ui:br></dd>
                </dl>
            </c:if>
            <div class="clear"></div><!-- browserBug-->
        </div><!-- //지점별 정보입력 -->
        <div class="guide"><span class="BL"></span><span class="BR"></span></div><!-- //connering 공통 -->
    </div><!-- storeInfoWrap:지점별 영업점 안내 -->
    <hr />
    <div id="mapLayer">
        <iframe src="/company/store/map?rdpAddr=${store.rdpAddr}&deptname=${store.deptname}" width="681" height="300"></iframe>
    </div>
    <hr />
    </div><!-- //notification -->
    
    <hr />
</div><!-- //contents area -->
</div><!-- //container -->
</body>
</html>