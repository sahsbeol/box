<%@page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="none"/>
<script type="text/javascript">
var histSwiper = null;
$(document).ready(function(){

	// history 페이지 오픈
	$('#sidemenu_wrapper .side_history, #app_bar .btn_history').on('click', function(){
		if(histSwiper == null){
			$.ajax({
		        type: "POST"
		        ,url: "/m/biz/history"
		        ,dataType: "html"
		        ,success : function(html){		        	
		            $("#ly_biz_recent").append(html);         
		            
		            histSwiper = new Swiper('#history_wrapper > .swiper-container', {
		                direction: 'vertical',
		                slidesPerView: 'auto',
		                mousewheelControl: true,
		                freeMode: true
		           });
		            
		            historyOpen();
		        } 
		        ,error: function(data) {
		        }
		    });
		}else{
			historyOpen();
		}
		
	});

	$('#app_bar .btn_today').on('click', function(){
		if($(".btn_today").hasClass("active") === true){//benefit open
			benefitClose();
        }else{
        	if($("#benefit_wrapper").length == 0){
        		$("#wrap").addClass("today");
        		$("#content").after("<div id='benefit_wrapper'></div>");
        		$.ajax({
			        type: "POST"
			        ,url: "/m/biz/todayBenefit"
			        ,dataType: "html"
			        ,success : function(html){		        	
			            $("#benefit_wrapper").append(html);
			  			benefitOpen();
			        } 
			        ,error: function(data) {
			        }
			    });
        	}else{
        		benefitOpen();
        	}	
        }
	});
});

function benefitOpen(){
	$("#app_bar .btn_today").addClass('active');
    $("#app_bar .btn_today").children('span').hide(0);
    $('#header').append('<div class="dim"></div>');
    $('body').addClass('fixed').on('touchmove', function(e){e.preventDefault();return false;});
    TweenLite.to($('#header .dim'),0.7,{ease:Power4.easeOut,opacity:0.8});
    TweenLite.to($('#benefit_wrapper'),0.7,{ease:Power4.easeOut,top:0,onComplete:function(){
    }});
}

function benefitClose(){
	$("#app_bar .btn_today").children('span').show(0);
    $('body').removeClass('fixed').off('touchmove');
    $('.btn_today').removeClass('active');
    TweenLite.to($('#benefit_wrapper'),0.7,{ease:Power4.easeOut,top:'100%'});
    TweenLite.to($('#header .dim'),0.7,{ease:Power4.easeOut,opacity:0,onComplete:function(){
        $('#header .dim').remove();
    }});
}

function historyOpen(){
	$('body').addClass('fixed').on('touchmove', function(e){e.preventDefault();return false;});
    $('#header').append('<div class="dim"></div>').css({zIndex:98});
    gnbClose();
    TweenLite.to($('#header .dim'),0.7,{ease:Power4.easeOut,opacity:0.8});
    TweenLite.to($('#history_wrapper'),0.6,{ease:Power4.easeOut,left:0,onComplete:function(){
//         histSwiper.onResize();
    }});
}

function gnbClose(){
    $('body').removeClass('fixed').off('touchmove');
    TweenLite.to($('#sidemenu_wrapper'),0.7,{ease:Power4.easeOut,left:'100%'});
    TweenLite.to($('#header .dim'),0.7,{ease:Power4.easeOut,opacity:0,onComplete:function(){
        $('#header .dim').remove();
        $('#gnb .dp2').css('height','0');
        $('#gnb .dp1').removeClass('active');
    }})
}

</script>
<!-- app bar -->
<div id="app_bar">
	<a href="javascript:" class="btn_home" onclick="location.href='${defaultHost}/';return false;">HOTTRACKS</a>
	<a href="javascript:" class="btn_today" onclick="javascript:;"><span class='img_today'>오늘,혜택</span></a>
	<a href="javascript:" class="btn_cart" onclick="location.href='${defaultHost}/m/order/cart';return false;" >장바구니<c:if test="${cartCount > 0}"><em class="font_t">${cartCount}</em></c:if></a>
	<!-- 최근 본상품 있을경우 on : class 추가 -->
	<a href="javascript:" class="btn_history <c:if test="${not empty listRecent}">on</c:if>">
		<c:if test="${not empty listRecent}">	
			<c:forEach items="${listRecent}" var="l" varStatus="st" end="0">
			    <c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><ui:image src="${l.productImageUrl}" server="product" size="150" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
			    <c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
			    <c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
			</c:forEach>
		</c:if>
	</a>	
</div>
<!--// app bar -->
<div id="ly_biz_recent"></div>