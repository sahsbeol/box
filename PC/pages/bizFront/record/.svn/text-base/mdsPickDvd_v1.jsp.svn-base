<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<script type="text/javascript">
<!--
/* slide */
var mdsPickRoller;
var mdsPickRollSpeed = 4000;
var isOverToMdsPick = false;
var curPos = 0;
var curLoc = 0;
var sWidth = 175;
var dispCnt = 5;
var slides;
var numberOfSlides;
var lastPos;

jQuery(function($){
    $(document).ready(function(){
        slides = $('.md_bottom .small');
        numberOfSlides = slides.length;
        lastPos = parseInt((numberOfSlides-1)/dispCnt);
        
        $('#slidesContainers').css({
            'overflow':'hidden',
            'width':sWidth*dispCnt,
            'height':'100'
        });
        
        $('#slideInner').css('width', sWidth*numberOfSlides);

        // 기존의 스레드를 클리어 해줌
        clearInterval(mdsPickRoller);
        mdsPickRoller = setInterval(nextSlide, mdsPickRollSpeed);
    });
    
    $('.md_bottom').hover(function(){isOverToMdsPick = true;},function(){isOverToMdsPick = false;});
});
function nextSlide(){ if(!isOverToMdsPick){manageControls(-1);} }

function manageControls(position){
    if(position > 0 && curPos == 0){
        curLoc = sWidth*dispCnt*lastPos*(-1);
        curPos = lastPos;
    }else if (position < 0 && curPos == lastPos){
        curLoc = 0;
        curPos = 0;
    }else{
        curLoc += sWidth*dispCnt*position;
        curPos -= position;
    }
    
    $('#slideInner').animate({
        'marginLeft':curLoc
    });
}
//-->
</script>
    <h3><img src="${imageServer}/images/main/h3_dvd_mdchoice.gif"  alt="md choice" /></h3>
    <div class="md_tab">
        <ul>
            <li <c:if test="${c.ctgrId eq '000400'}">class="on"</c:if>><a href="javascript://" onclick="reloadMd('000400)">BLU-RAY</a></li>
            <li class="dvd <c:if test="${c.ctgrId eq '000401'}">on</c:if>"><a href="javascript://" onclick="reloadMd('000401)" class="dvd">DVD</a></li>
        </ul>
    </div>
    <div class="md_dvd" style="display:hidden;">
        <div class="md_top">
            <c:forEach items="${list1}" var="l" varStatus="status">
                <dl class="big">
                    <dt><a href="#"><ui:image rcrdCd="${l.code}" prdtGbn="${l.sellPrdtGbn}" width="116px" height="175px"/></a></dt>
                    <dd class="album_name">
                        <a href="/ht/record/detail/${l.sellPrdtBcode}">
                            <ui:substring beginIndex="0" endIndex="20" shortString="...">${l.name}</ui:substring>
                        </a>
                    </dd>
                    <dd class="price"><span class="bold"><fmt:formatNumber value="${l.discountPrice}" pattern=",###"/></span><span class="f_orange">[${l.discountRate}%+${l.prdtSavedRate}%P]</span></dd>
                    <dd class="release_date">발매일: <ui:mask pattern="##월##일"><ui:substring beginIndex="4" endIndex="8">${l.releaseDate}</ui:substring></ui:mask></dd>
                    <dd class="desc_album">"해리포터와 죽음의 성물" 블루에리에서만 최초 공개되는 최종편 2분의 오프닝.</dd>
                </dl>
            </c:forEach>
        </div>
        <div class="md_bottom">
            <div id="slidesContainers">
                <div id="slideInner">
                <c:forEach items="${list2}" var="l" varStatus="status">
                    <dl class="small">
                        <dt><a href="#"><ui:image rcrdCd="${l.code}" prdtGbn="${l.sellPrdtGbn}" width="66px" height="100px"/></a></dt>
                        <dd class="album_name">
                            <a href="/ht/record/detail/${l.sellPrdtBcode}">
                                <ui:substring beginIndex="0" endIndex="20" shortString="...">${l.name}</ui:substring>
                            </a>
                        </dd>
                        <dd class="price"><span class="bold"><fmt:formatNumber value="${l.discountPrice}" pattern=",###"/></span><span class="f_orange">[${l.discountRate}%+${l.prdtSavedRate}%P]</span></dd>
                        <dd class="release_date">발매일: <ui:mask pattern="##월##일"><ui:substring beginIndex="4" endIndex="8">${l.releaseDate}</ui:substring></ui:mask></dd>
                    </dl>
                </c:forEach>
                </div>
            </div>
            <p class="control prev"><a href="javascript://" onclick="manageControls(1)"><img src="${imageServer}/images/main/btn_md_prev.gif"/></a></p>
            <p class="control next"><a href="javascript://" onclick="manageControls(-1)"><img src="${imageServer}/images/main/btn_md_next.gif"/></a></p>
        </div>
    </div>
