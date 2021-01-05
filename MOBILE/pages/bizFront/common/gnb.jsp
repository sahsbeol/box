<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<script type="text/javascript">
jQuery(function($){
    var chkInt = 6; // sessionStorage.getItem('chkInt')를 출력
    //console.log(chkInt);
    /*if (chkInt && chkInt<5) {
			sessionStorage.setItem('chkInt', (parseInt(chkInt)+1));
			$("input[name=exLink]").val($("input[name=exLink"+(parseInt(chkInt)+1)+"]").val());
			$("input[name=exTxt]").val($("input[name=exTxt"+(parseInt(chkInt)+1)+"]").val());
			if ($("input[name=exLink"+(parseInt(chkInt)+1)+"]").val() != undefined) {
				$("#srcBtn").attr("onclick","location.href='"+$("input[name=exLink"+(parseInt(chkInt)+1)+"]").val()+"';return false;");
			} else {
				$("#srcBtn").attr("onclick","searchOpen();return false;");
			}
			$("#srcInput").attr("placeholder",$("input[name=exTxt"+(parseInt(chkInt)+1)+"]").val());
	}else{
	    sessionStorage.setItem('chkInt', 1);
		$("input[name=exLink]").val($("input[name=exLink1]").val());
		$("input[name=exTxt]").val($("input[name=exTxt1]").val());
		if ($("input[name=exLink1]").val() != null) {
			
		}
	}*/
	
	$("#srcBtn").attr("onclick","location.href='"+$("input[name=exLink1]").val()+"';return false;");
	$("#srcInput").attr("placeholder",$("input[name=exTxt1]").val());
		
	$('#header .btn_cart').on('click touchend', function(e) {
		location.href = "/m/order/cart";
	});
});
$(document).ready(function(){
    $('.coin').click(function(){
        $(this).addClass('on');
    })
    if($('.page-menu.menu-gift').is('.active')){
	    setTimeout(() => {
	      $('.dot-wrap').addClass('on');
	      $('.coin').show();
	    }, 500);
    }else{
    	$('.dot-wrap').addClass('on');
		$('.coin').show();
    }
    var f = (function(){
        var startPos = window.scrollY;
        function hamsoo(e){
            var endPos = window.scrollY;
            if(startPos < endPos && startPos > 10){
                $('#app_bar.confirm').addClass('active');
            } else{
              $('#app_bar.confirm').removeClass('active');
            } startPos = endPos;
        } return hamsoo;
    })();
	  window.addEventListener('scroll', f);
	  $(window).scroll(function(){
		  var sct =$(window).scrollTop()
		  if(sct >= 50){
			  $('.float-wrap').addClass('active')
			  $('.detail_input').addClass('activeTop')
			  if($('.float-wrap').is('active')){
				  setTimeout(() => {
					$('.float-wrap').removeClass('active') 
				  }, 2500);
			  }
		  } else if(sct < 50){
			  $('.float-wrap').removeClass('active')
			  $('.detail_input').removeClass('activeTop')
		  } 
	  })
});
function searchOpen(){
	$('body').addClass('fixed').on('touchmove', function(e){e.preventDefault();return false;});
	$('#wrap').append('<div class="search_dim"></div>');
	TweenLite.to($('#wrap .search_dim'),0.7,{ease:Power4.easeOut,opacity:0.8})
	TweenLite.to($('#search_menu'),0.7,{ease:Power4.easeOut,left:0,onComplete:function(){
		searchMenuSwiper.onResize();
	}});
}
</script>
<!-- header -->
<div id="header" class="bnr_top">
    <div class="inner">
    	<%-- <a href="javascript:;" class="btn_home" onclick="location.href='${defaultHost}/';return false;">홈버튼</a> --%>
    	<!-- 메인 -->
		<div class="main_wrap">
            <c:if test="${not empty listTrendKeyword}">
                <c:forEach items="${listTrendKeyword}" var="l" varStatus="st">
                    <c:set var="keywords" value="${l.keyword}"/>
                	<c:if test="${not empty l.requested}">
	                    <c:if test="${l.prevRank ne 2 || l.prevRank ne 3}"><c:set var="keywordsUrl" value="/e/${l.requested}"/></c:if>
	                    <c:if test="${l.prevRank eq 2}"><c:set var="keywordsUrl" value="/p/${l.requested}"/></c:if>
	                    <c:if test="${l.prevRank eq 3}"><c:set var="keywordsUrl" value="/b/${l.requested}"/></c:if>
	                	<input type="hidden" name="exLink${st.count}" value="${keywordsUrl}"/>
                    </c:if>
	                <input type="hidden" name="exTxt${st.count}" value="${keywords}"/>
                </c:forEach>
            </c:if>
			<input type="hidden" name="exLink" value="${krywordsUrl}"/>
			<input type="hidden" name="exTxt" value="${keywords}"/>
			<input type="text" class="MB_MAIN_TOP_1" id="srcInput" placeholder="">
	        <%-- <a href="javascript:;" class="btn_category MB_MAIN_TOP_3"><span>카테고리 보기</span></a>
	        <a href="javascript:;" onclick="location.href='${keywordsUrl}';return false;" id="srcBtn" class="btn_search MB_MAIN_TOP_2"><span>검색</span></a> --%>
	        
            <a href="#n" class="btn_cart">장바구니<c:if test="${cartCount > 0}"><em class="font_t">${cartCount}</em></c:if></a>
     		<a href="javascript:;" onclick="location.href='${keywordsUrl}';return false;" id="srcBtn" class="btn_search MB_MAIN_TOP_2"><span>검색</span></a>
     		<div class="MB_MAIN_GNB_10 coin-back">
			    <div class="coin-wrap">
			        <div class="dot-wrap">
			            <div class="hot-dot"></div>
			            <div class="small-dot"></div>
			        </div>
			        <div class="coin" onclick="location.href='/m/biz/musicMain'"></div>
			    </div>
			</div>
		</div>
		<!--// 메인 -->
        
		<!-- 서브 -->
		<div class="sub_wrap">
			<a href="javascript:;" onclick="locBack();return false;" class="btn_back">뒤로가기</a>
	        <!-- <a href="javascript:;" class="btn_category MB_MAIN_TOP_3">카테고리 보기</a> -->
	        <a href="#n" class="btn_cart">장바구니<c:if test="${cartCount > 0}"><em class="font_t">${cartCount}</em></c:if></a>
	        <a href="javascript:;" class="btn_search MB_MAIN_TOP_2">검색</a>
	        <a href="/" class="btn_bhome" style="display: none;">홈으로</a>
			<h2 id="subTitle">${subTitle}</h2>
		</div>
		<!--// 서브 -->
    </div>
    
	<div class="page-menu menu-gift">
		<div class="page-title">
			<h2>문구/기프트</h2>
		</div>
		<div class="top_menu">
			<ul class="clear">
				<li class="MB_MAIN_GNB_GIFT_1 active"><a href="/m/biz/sticker/stickerMain">스티커</a></li>
				<li class="MB_MAIN_GNB_GIFT_2 active"><a href="/m/diary/main">다이어리</a></li>
				<li class="MB_MAIN_GNB_GIFT_3"><a href="/e/68233">마스크&amp;위생</a></li>
				<li class="MB_MAIN_GNB_GIFT_4"><a href="/m/biz/hot/eventMain">이벤트</a></li>
			</ul>
		</div>
	</div>

	<div class="page-menu menu-music">
		<div class="page-title">
			<h2>음반</h2>
		</div>
		<div class="top_menu">
			<ul class="clear">
				<li class="MB_MAIN_GNB_MUSIC_1 active"><a href="/m/record/biz/category/0003">CD/LP</a></li>
				<li class="MB_MAIN_GNB_MUSIC_2"><a href="/m/dvd/biz/category/0004">DVD/BR</a></li>
				<li id="gnblife" class="MB_MAIN_GNB_MUSIC_3"><a href="/m/biz/idol/news">뮤직매거진<i class="this"></i></a></li>
				<li class="MB_MAIN_GNB_MUSIC_4"><a href="/m/help/signMain">팬사인회</a></li>
			</ul>
		</div>
	</div>

	<div class="page-menu menu-agit">
		<div class="page-title">
			<span class="play-mark"></span>
			<div class="page-sub">
				<h3 class="MB_MAIN_GNB_PLAY_1 active"><a href="/m/biz/agitMain?agitTypeCd=ALL">아지트</a></h3>
				<h3 class="MB_MAIN_GNB_PLAY_2"><a href="/m/biz/lifeMain?productOrderBy=R">이럴 때,</a></h3>
			</div>
			<p class="description-text">숏폼, 핫트랙스 영상 콘텐츠</p>
		</div>
		<div class="agit-menu">
			<ul class="clear">
				<li code="ALL">
					<a href="/m/biz/agitMain?agitTypeCd=ALL">
						<div class="agit-li"></div>
						<p>전체보기</p>
					</a>
				</li>
				<li code="C1511">
					<a href="/m/biz/agitMain?agitTypeCd=C1511">
						<div class="agit-li"></div>
						<p>핫트연구소</p>
					</a>
				</li>
				<li code="C1515">
					<a href="/m/biz/agitMain?agitTypeCd=C1515">
						<div class="agit-li"></div>
						<p>뷰어</p>
					</a>
				</li>
				<li code="C1514">
					<a href="/m/biz/agitMain?agitTypeCd=C1514">
						<div class="agit-li"></div>
						<p>핫트뿅뿅</p>
					</a>
				</li>
				<li code="C1512">
					<a href="/m/biz/agitMain?agitTypeCd=C1512">
						<div class="agit-li"></div>
						<p>문구하울</p>
					</a>
				</li>
				<li id="agit_menu6" code="C1513">
					<a href="/m/biz/agitMain?agitTypeCd=C1513">
						<div class="agit-li"></div>
						<p>보이는이야기</p>
					</a>
				</li>

			</ul>
		</div>
	</div>

	<div class="page-menu menu-life">
		<div class="page-title">
			<span class="play-mark"></span>
			<div class="page-sub">
				<h3 class="MB_MAIN_GNB_PLAY_1"><a href="/m/biz/agitMain?agitTypeCd=ALL">아지트</a></h3>
				<h3 class="MB_MAIN_GNB_PLAY_2 active"><a href="/m/biz/lifeMain?productOrderBy=R">이럴 때,</a></h3>
			</div>
			<p class="description-text">우리의 느슨한 연대</p>
		</div>
	</div>
</div>
<!--// header -->
