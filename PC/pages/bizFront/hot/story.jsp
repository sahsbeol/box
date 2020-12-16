<%@page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<html>
<head>
<title>${detail.eventTitle} - NEW ME HOTTRACKS</title>
<meta property="fb:app_id" content="981386905311018" />
<!--  SNS 공유 내용 -->
<meta property="og:type" content="website"/>
<meta property="og:title" content="${fn:escapeXml(detail.eventTitle)}"/>
<meta property="og:url" content="${defaultHost}/ht/hot/story?eventId=${detail.eventId}"/>
<c:choose>
    <c:when test="${not empty detail.eventRangeInfo}"><meta property="og:description" content="${detail.eventRangeInfo}"/></c:when>
    <c:otherwise><meta property="og:description" content="<ui:mask pattern="####.##.##">${detail.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${detail.eventEndDt}</ui:mask>"/></c:otherwise>
</c:choose>
<meta property="og:image" content="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" />
<link rel="image_src" href="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.thumUrl}" />
<!--  SNS 공유 내용 -->
<style type="text/css">
.tit_bucket { margin:60px 0 50px;text-align:center; }
.tit_bucket p { margin-top:20px; }
.bucket_cont { max-width:950px;margin-bottom:50px; }
#imageMid {height : 530px;position: relative; margin-top : -530px; z-index : -1;}

</style>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
isLogin = ${isLogin};
isEntryTerm = ${entryTermYn};
orderBy = 'regDtmDesc';

jQuery(function($){
    $(document).ready(function(){
    	$('#content').addClass('new_event_view');
        var page = 1;
        if(window.history && window.history.state && window.history.state.page){
            page = window.history.state.page;
        }
        loadEvent(page);
        getCategory($('.c_select .location_1').attr('value'));
    });
});

function couponDown(couponId) {
    if (!isLogin) {
        needLogin();
    } else {
        $.ajax({
            type: "GET"
            ,url: "/ht/getCouponDown"
            ,data: 'couponId=' + couponId
            ,dataType: "json"
            ,success: function(data) {
                if (data.save) {
                    alert("쿠폰이 다운로드 되었습니다.");
                } else {
                    alert(data.errorMessage);
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function goEventList(page) {
    if(page == null || page == undefined)    page = 1;
    location.href="/ht/hot/story?eventId=${detail.eventId}&page=" +page + "#bucketEventList";
}

function goEvent(){
    location.href = $(".e_select .e_txt a").attr("href");
}

var listEvent;
var pageHolder;
function loadEvent(page){
    if(!page || $.trim(page) == "")   page = 1;
    
    if(history.pushState){
        var state = { page: page };
        var title = "${detail.eventTitle}";
        var url = location.href.split("#")[0];
        history.pushState(state, title, url);
    }
    
    $.ajax({
        type: "GET"
        ,url: "/ht/hot/storyList"
        ,data: {eventId:"${detail.eventId}", page:page}
        ,dataType: "json"
        ,success: function(data) {
            if(data && data.list){
                listEvent = data.list;
                pageHolder = data.pageHolder;
            }
            
            _createEventList();
        }
        ,error: function() {
            alert('<fmt:message key="error.common.system"/>');
        }
    });
}

function _createEventList(){
    var obj = document.getElementById("lyEventList");
    while(obj.firstChild)    obj.removeChild(obj.firstChild);
    
    if(listEvent && listEvent.length > 0){
    	$(".thumb_title").css("display", "block");
        var ul = document.createElement("ul");
        ul.classList.add("thumb_list");
        obj.appendChild(ul);
        for(var i = 0; i < listEvent.length; i++){
            ul.appendChild(_createEventThumb("li", listEvent[i], "/ht/hot/story?eventId="+listEvent[i].eventId));
        }
        
        var hndl = function(page){ return function(e){ e.preventDefault();loadEvent(page); }; };
        obj.appendChild(_getPager(pageHolder, hndl));
    }
}

function _createEventThumb(tagName, event, linkUrl){
    var obj = document.createElement(tagName);
    
    if(linkUrl){
        var anchor = document.createElement("a");
        anchor.href = linkUrl;
        var imgSpan = document.createElement("span");
        imgSpan.classList.add("img");
        if(event.curEventYn){
            var em = document.createElement("em");
            em.classList.add("new");
            em.appendChild(document.createTextNode("NEW"));
            imgSpan.appendChild(em);
        }
        var img = document.createElement("img");
        img.src = "http://image.kyobobook.co.kr/newimages/giftshop_new/work/" + event.thumUrl;
        imgSpan.appendChild(img);
        anchor.appendChild(imgSpan);
        obj.appendChild(anchor);
    }else{
        var imgSpan = document.createElement("span");
        imgSpan.classList.add("img");
        var img = document.createElement("img");
        img.src = "http://image.kyobobook.co.kr/newimages/giftshop_new/work/" + event.thumUrl;
        imgSpan.appendChild(img);
        obj.appendChild(imgSpan);
    }
    return obj;
}


function goCommentList(page) {
    $('div#commentArea').load('/ht/hot/comment/${detail.eventTypeCode}?eventId=${detail.eventId}&orderBy='+orderBy+'&page=' + page);
}


function save(){
    if (preValidation()) {
        $('form[name="eventCommentForm"]').ajaxSubmit({
            url: '/ht/hot/saveEventComment'
            ,dataType: 'json'
            ,success: function(data) {
                if (data.save) {
                    alert('<fmt:message key="message.save.success"/>'); 
                    $('div#commentArea').load('/ht/hot/comment/${detail.eventTypeCode}?eventId=${detail.eventId}&orderBy='+orderBy);
                } else {
                    alert(data.errorMessages);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
    return false;
}

function preValidation() {
    if (!isLogin) {
        needLogin();
        return false;
    } else if (!isEntryTerm) {
        alert("해당기간이 아닙니다.");
        $("div.comment_box textarea[name=eventComment]").attr("disabled","disabled");
        $("div.comment_box textarea[name=eventComment]").val();
        return false;
    }

    return true;
}


function deleteComment(sequence) {
    if (preValidation()) {
        if (confirm('삭제하시겠습니까?')) {
            $.ajax({
                type: 'GET'
                ,url: '/ht/hot/deleteEventComment'
                ,data: 'eventId=${detail.eventId}&sequence=' + sequence
                ,dataType: 'json'
                ,success: function(data) {
                    if (data.save) {
                        alert('<fmt:message key="message.delete.success"/>');
                        $('div#commentArea').load('/ht/hot/comment/${detail.eventTypeCode}?eventId=${detail.eventId}&orderBy='+orderBy+'&temp='+ Math.random());
                    } else {
                        alert(data.errorMessages);
                    }
                }
                ,error: function(data) {
                    alert('<fmt:message key="error.common.system"/>');
                }
            });
        }
    }
}
function getCategory(ctgrId){
	$('.c_select .location_1').text($('li[ctgrId='+ctgrId+'] a').text()==''?'전체':$('li[ctgrId='+ctgrId+'] a').text());
	$.ajax({
	    type: "GET"
	   ,url: "/ht/biz/eventCategory"
	   ,data:{"ctgrId":ctgrId} 
	   ,dataType: "json"
	   ,success : function(data){
		   if (!isEmpty(data)) {
			   $(".e_select").attr("style","display: block;");
			   var htmlStr = "";
			   var list = data.listEvent;
			   var chkempty = false;
			   for(var i=0; i<list.length; i++){
				   if ("${detail.eventId}"==list[i].eventId) {
					   htmlStr += "<a href='javascript://' class='location_1'>"+list[i].eventTitle+"</a>";
					   chkempty = true
					};
				   if(i+1 == list.length && !chkempty){
					   htmlStr += "<a href='javascript://' class='location_1'>"+list[0].eventTitle+"</a>";
				   };
			   };
				htmlStr += "<ul class='location_nav'>";
			   for(var i=0; i<list.length; i++){
				   var select= "${detail.eventId}"==list[i].eventId?"class='active'":"";
					htmlStr += "<li><a href='javascript://' "+select+" onclick='location.href=\"/ht/biz/eventDetail?eventId="+list[i].eventId+"\";'>"+list[i].eventTitle+"</a></li>"
			   };
				htmlStr += "</ul>";
				$(".e_select").empty();
				$(".e_select").append(htmlStr);
				nav();
				if (list.length >= 30) {
					$(".e_select .location_nav").attr("style","max-height:500px; overflow:auto;");
				};
				if(list.length==0){
					$(".e_select").attr("style","display: none;");
				};
			} 
		}
	   ,error: function(data) {
	       alert('<fmt:message key="error.common.system"/>');
	   }
	});
}

var categorySwiper03 = null;

function replaceBtn(bcode){
	$fn.setRecobellRelationList(bcode);
	$('.dim, .replace-modal').css('visibility','visible');
//		$('html,body').addClass('noscroll');
}
$(function(){
    $('.replace-modal .close-btn').click(function(){
        $fn.init();
    	$('.dim, .replace-modal').css('visibility','hidden');
//	        $('html,body').removeClass('noscroll');
    });
    
});

$fn = {
		init:function(){
			$('#recobellRelationList').empty();
			
		}
		

		, setRecobellRelationList:function(bcode) {
			
			$.ajax({
				url: "/ht/biz/personal/getRecobellRelationList"
				, data: {
					code : bcode
				}
				, type:"POST"
		        ,dataType: "json"
		        ,success : function(data){
		        	var append = "";
		           	$('#recobellRelationList').empty();
		        	
		            if (data) {
		                if(!isEmpty(data)) {
							var list = data.recobellRelationList;
							if(!isEmpty(list)) {
								for(var i=0; i < list.length; i++) {
									var rate = 0;
									/* rate = 100 - Math.ceil(((list[i].lastCpnPrice / list[i].prdtSellPrice) * 100)); */
									rate = ((list[i].prdtSellPrice - list[i].lastCpnPrice) / list[i].prdtSellPrice) * 100;
									rate = Math.round(rate * 10);
									rate = Math.floor(rate / 10);
									append += '	<li>';
									append += '	<a href="/p/'+list[i].sellPrdtBcode+'?foo=bar&rccode=pc_soldout">';
									append += '		<div class="thum">';
									if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
				                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/music/midi/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" >';
			                	    }else{
				                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
			                	    }
									append += '		</div>';
									append += '	</a>';
									if(list[i].wishUserPrdtCnt > 0){
										append += '	<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like active" prdtId="'+list[i].sellPrdtBcode+'">';
									}else{
										append += '	<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like" prdtId="'+list[i].sellPrdtBcode+'">';
									}
									append += '		<span>'+'좋아요'+'</span>';
									append += '	</a>';
									append += '	<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'">';
									append += '	<div class="cont">';
									append += '		<p class="brand">'+list[i].brandName+'</p>';
									append += '		<p class="tit">'+list[i].prdtName+'</p>';
									append += '		<p class="price font_t">';
									if(rate != 0){
				                	    append += '				<span class="percent">'+rate+'%</span>';
			                	    }
									append += '					<span>'+price_format(list[i].lastCpnPrice)+'</span>';
									if(rate != 0){
										append += '					<span class="discount">'+price_format(list[i].prdtSellPrice)+'</span>';
			                	    }
									append += '		</p>';
									append += ' <div class="info">';
									if(list[i].reviewCount > 999){
										append += '<span class="reply">'+'999+'+'</span>';
									}else{
										append += '<span class="reply">'+list[i].reviewCount+'</span>';
									}
									if(list[i].wishPrdtCnt > 999){
										append += '<span class="like">'+'999+'+'</span>';
									}else{
										append += '<span class="like">'+list[i].wishPrdtCnt+'</span>';
									}
									append += ' </div>';
									append += ' <div class="badge">';
										if(list[i].prdtStatCode != 'C0312'){
											if(list[i].prdtStatCode == 'C0313'){
												append += ' <span class="badge03">'+'일시품절'+'</span>';
											}
											if(list[i].prdtStatCode != 'C0313'){
												append += ' <span class="badge03">'+'품절'+'</span>';
											}
										}else{
											if(list[i].prdtIcon.substring(0,1) == '1'){
												append += ' <span class="badge01">'+'쿠폰'+'</span>';
											}
											if(list[i].prdtIcon.substring(2,3) == '1'){
												append += ' <span class="badge01">'+'사은품'+'</span>';
											}
											if(list[i].prdtIcon.substring(8,9) == '1'){
												append += ' <span class="badge01">'+'무료배송'+'</span>';
											}
										}
									append += ' </div>';
								append += ' </div>';
							append += ' </a>';
						append += '</li>';
									
									if (i == 19)	break;
			                	}
							}
		                	
							$('#recobellRelationList').html(append);
							
		                }
		            }
		        }
		        ,error: function(request, status, error) {
		            if(request.status != 0){
		                alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
		            }
		        }
		        ,complete : function() {
		        	
		        	if(categorySwiper03 != null) {
		                //맨 앞으로 스와이퍼 이등
		                categorySwiper03.goToSlide(1);
		                //스와이퍼 삭제 
		        		categorySwiper03.destroySlider();
					}
		        	categorySwiper03 = $('.replace-modal .pd_list ul').bxSlider({
		        		touchEnabled: false,
		        		speed: 1000,
		        		minSlides: 4,
		        		maxSlides: 4,
		        		moveSlides: 4,
		        		slideWidth: 205,
		        		pager: true,
		        		pagerType: 'short',
		        		pagerShortSeparator: ''
		        	});
		        }
		    });
		}
};
</script>
</head>
<body>
<div class="event_top">
	<c:if test="${ newEventDispTypeCode.newEventDispTypeCode ne 'C1532' && newEventDispTypeCode.newEventDispTypeCode ne 'C1533' && newEventDispTypeCode.newEventDispTypeCode ne 'C1534' }">
	<div class="location_wrap">
	<button type="button" class="btn_home" onclick="location.href='/ht/biz/welcomeMain';">홈으로</button>
		<div class="location_nav_wrap c_select">
			<c:forEach items="${listCtgr}" var="l">
			<c:if test="${l.cateId eq detail.ctgrId}"><a href="javascript://" value="${l.cateId}" class="location_1">${l.cateName}</a></c:if>
			</c:forEach>
			<c:if test="${detail.ctgrId eq '0000'}"><a href="javascript://" value="0000" class="location_1">전체</a></c:if>
			<ul class="location_nav">
			<c:forEach items="${listCtgr}" var="l">
				<li ctgrId="${l.cateId}"><a href="javascript://" onclick="javascript:getCategory('${l.cateId}');"<c:if test="${l.cateId eq detail.ctgrId}">class='active'</c:if>>${l.cateName}</a></li>
			</c:forEach>
			</ul>
		</div>
		<div class="location_nav_wrap e_select">
		</div>
	</div>
	</c:if>
	<div class="sns">
		<ul>
			<li class="sns01"><a href="javascript://" onclick="goTwitter('${detail.eventTitle}', '${defaultHost}/ht/biz/eventDetail?eventId=${detail.eventId}')"></a></li>
			<li class="sns02"><a href="javascript://" onclick="goFaceBook('${detail.eventTitle}', '${defaultHost}/ht/biz/eventDetail?eventId=${detail.eventId}')"></a></li>
			<li class="sns03"><a href="javascript://" onclick="goPinterest('${detail.eventTitle}', '${defaultHost}/ht/biz/eventDetail?eventId=${detail.eventId}')"></a></li>
		</ul>
	</div>
</div>
<div class="event_title">
	<h5>${detail.eventTitle}</h5>
</div>
<div class="inner950">
	<div class="event_wrap w950">
	    <div class="event_info">
	        <!-- img -->
	        <c:if test="${not empty detail.imageUrl950 }">
	            <c:choose>
	                <c:when test="${fn:startsWith(detail.ctgrId, '00002000')}">
	                    <div> <!-- 이벤트 튼 배경화면 -->
	                        <script type="text/javascript">
	                        $("#container").css("background", "url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.imageUrl950}') no-repeat 50% 572px");
	                        $(".event_wrap").css("padding-top" ,"25px");
	                        </script>
	                    </div>
	                </c:when>
	                <c:otherwise>
	                    <div> <!-- 이벤트 튼 배경화면 -->
	                        <script type="text/javascript">
	                        $("#container").css("background", "url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/${detail.imageUrl950}') no-repeat 50% 80px");
	                        </script>
	                    </div>
	                </c:otherwise>
	            </c:choose>
	        </c:if>
	        <div class="event_img">
	            <c:if test="${not empty detail.imageUrl}"><div><ui:image src="${detail.imageUrl}" id="eventImageUrl" usemap="#eventImageMap" clazz="sns_img"/></div></c:if>
	            <c:if test="${detail.userTmplUseYn eq 'Y'}"><div>${detail.userTmpl}</div></c:if>
	            <c:if test="${not empty detail.userTmplHtml}">
	                <div id="userTemplate"></div>
	                <textarea name="userTmplHtml" style="display:none;">${detail.userTmplHtml}</textarea>
	                <script src="/js/fn_htts_slide_1.2.js?201710261756" type="text/javascript"></script>
	                <script src="/js/fn_htts_event_template.js?201710261756" type="text/javascript"></script>
	            </c:if>
	        </div>
	        <div style="display:block;">
	            <div>
	                <c:forEach items="${listDisplayType}" var="l" varStatus="st">
	                    <!-- 링크주소에 이벤트 코드가 있는경우 Import시 중복값으로 넘어감 -->
	                    <c:choose>
	                        <c:when test="${not empty param.eventId}">
	                            <c:import url="/ht/biz/bizListEventProduct?eventTypeInseq=${l.eventTypeInseq}&eventPrdtTypeCode=${l.eventPrdtTypeCode}&prdtInfoExpsYn=${l.prdtInfoExpsYn}&eventDispTypeCode=${detail.eventDispTypeCode}"/>
	                        </c:when>
	                        <c:otherwise>
	                            <c:import url="/ht/biz/bizListEventProduct?eventId=${detail.eventId}&eventTypeInseq=${l.eventTypeInseq}&eventPrdtTypeCode=${l.eventPrdtTypeCode}&prdtInfoExpsYn=${l.prdtInfoExpsYn}&eventDispTypeCode=${detail.eventDispTypeCode}"/>
	                        </c:otherwise>
	                    </c:choose>
	                </c:forEach>
	            </div>
	            <div class="thumb_box01" style="width:750px;margin:50px auto 0;display:block;">
	                <div class="story_title">다른 보이는이야기 보기</div>
	                <div id="lyEventList" ></div>
	            </div>
	            
	            <div class="dim"></div>
		        <div class="replace-modal">
		            <button type="button" class="close-btn"></button>
		            <div class="title-wrap">
		                <h2>하필 딱! 품절이지만 <b>괜찮아요</b></h2>
		                <p>찾으시는 상품과 비슷한 상품이 여기 있어요!</p>
		            </div>
		            <div class="content-wrap">
			            <div class="pd_list prod_list_normal">
						<ul id="recobellRelationList">
						</ul>
						</div>
		     		</div>
		     	</div>
	            
	            <%-- <div id="commentArea">
	                <c:choose>
	                    <c:when test="${not empty param.eventId }"><c:import url="/ht/hot/comment/${detail.eventTypeCode}"/></c:when>
	                    <c:otherwise><c:import url="/ht/hot/comment/${detail.eventTypeCode}?eventId=${detail.eventId }"/></c:otherwise>
	                </c:choose>
	            </div> --%> 
	        </div>
	    </div>
	</div>
</div>
</body>
</html>