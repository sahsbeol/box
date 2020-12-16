<%@page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="htNoQuick"/>
<html>
<head>
<style>
/* CSS 페이지 임시 적용 */
.agit .agit_tit {background: #242832 url('../../images/biz/sub/icon_agit_tit01.png') 50% 30px no-repeat; height: 268px; box-sizing: border-box; padding-top: 86px;}
.agit .agit_tit h3 span {color:#fff;}
.agit .agit_menu {position: absolute;width: 100%;margin-top: -116px;}
.agit .agit_menu ul {width: 710px;height: 129px;margin:0 auto;}
.agit .agit_menu ul li {width: 113px;float: left;font-size:16px;text-align: center;}
.agit .agit_menu ul li.on:hover {width: 113px;height: 129px;background:none;}
.agit .agit_menu ul li:hover {width: 113px;height: 129px;background: url(../../images/biz/sub/btn_menuon.png) center top no-repeat;}
.agit .agit_menu ul li p{margin-top:2px; color:#fff;}
.agit .agit_menu ul li.on a{width: 113px;height: 129px;background: url(../../images/biz/sub/btn_menuon.png) center top no-repeat;}
.agit .agit_menu ul li a img {padding-top: 25px;}
.agit .agit_menu ul li + li {margin-left: 6px;}
.agit .pd_filter{overflow:hidden;padding-top: 40px;width: 800px;position: relative;left: 50%;margin-left: -400px;}
.agit .pd_filter .pd_total{font-size:18px; float:left; line-height:23px;}
.agit .pd_filter .pd_total em{color:#419BF9; margin-right:2px; font-weight:bold;}
.agit .cont02 {margin: 20px 0 130px 0; padding:0px;}
.agit .cont02 ul li a .tag_new {position: absolute; top: 0px; left: 0px; width: 54px; height: 17px; font-size: 12px; color: #fff; background: #FF6A5B; z-index: 9; text-align: center; padding: 3px 0 0 0;}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$("#gnbAgit").addClass("on");
	gnb();//gnb
	nav();//nav
	if($('.header_wrap').length >0){
		bodyScroll();//body scroll
	}
	$('#content').addClass('agit');
	agitFn();
});

// 유투브 팝업
function youtubePopup(el, youtubeUrl) {
	/* 유튜브 */
	function playerVars(src,option){
		var def = {
			'autoplay' : 1,
			'control' : 1,
			'loop' : 0,
			'rel' : 0,
			'modestbranding' : 0,
		};
		if(option) $.extend(def,option);
		var s = '';
		$.each(def,function(p,v){
			s = s+p+'='+v+'&';
		});

		console.log(src+'?'+s.replace(/&$/gi,''));
		return src = src+'?'+s.replace(/&$/gi,'');
	}
	
	function setSrc($id,option){
		var src = youtubeUrl;
		//var src = 'https://www.youtube.com/embed/'+ $id.data('id'); 개발 시 변경
		$('.video_yt').attr('src',playerVars(src,option));
	}	
	
	/* 레이어팝업 */
    var winH = window.innerHeight;
    var body = $('body');
    var popup = $('.layer_popup');
    var popup_close = $('.layer_close');

    function showLayerPopup(el) {
        var $el = $(el),
            $inner = $el.find('.inner_layer');
        // console.log(winH);

        body.css('overflow', 'hidden').bind('touchmove', function (e) {
            e.preventDefault()
        });
        $el.show();
        popup.append("<div id='dim'></div>");

        if ($inner.outerHeight() < winH) {
            $inner.css('margin-top', '-' + $inner.outerHeight() / 2 + 'px');
        } else {
            $inner.css('top', '0px');
            body.unbind('touchmove');
            $('body').css('position', 'fixed');
        }

        $(window).resize(function () {
            winH = window.innerHeight;
            if ($inner.outerHeight() < winH) {
                $inner.removeAttr('style');
                $inner.css('margin-top', '-' + $inner.outerHeight() / 2 + 'px');
            } else {
                $inner.removeAttr('style');
                $inner.css('top', '0px');
                body.unbind('touchmove');
                $('body').css('position', 'fixed')
            }
        });

		setSrc($(this)); //유튜브
    }

    popup_close.on({
        click: function (e) {
            e.preventDefault();
            var $popup = $(this).closest(popup);

            $popup.hide();
            $popup.find('.inner_layer').css('margin-top', '0');
            $('body').removeAttr('style');
            body.unbind('touchmove');
            popup.find("#dim").remove();

			$('.video_yt').attr('src','');
        }
    });

    showLayerPopup(el);
}

</script>
</head>
	<body>
		<div class="agit_tit">
			<h3><span>아지트</span></h3>
		</div>
		<div class="agit_menu">
			<ul>
				<!-- 선택 시 on 클래스 추가 -->
				<li <c:if test="${empty agitType}">class="on"</c:if>>
					<a href="/ht/biz/agit">
						<img src="../../images/biz/sub/icon_agit20.png" alt="">
						<p>전체보기</p>
					</a>
				</li>
				<li <c:if test="${agitType == 'C1511'}">class="on"</c:if>>
					<a href="/ht/biz/agit?agitTypeCd=C1511">
						<img src="../../images/biz/sub/icon_agit21.png" alt="">
						<p>핫트연구소</p>
					</a>
				</li>
				<li <c:if test="${agitType == 'C1515'}">class="on"</c:if>>
					<a href="/ht/biz/agit?agitTypeCd=C1515">
						<img src="../../images/biz/sub/icon_agit22.png?20200602" alt="">
						<p>뷰어</p>
					</a>
				</li>
				<li <c:if test="${agitType == 'C1514'}">class="on"</c:if>>
					<a href="/ht/biz/agit?agitTypeCd=C1514">
						<img src="../../images/biz/sub/icon_agit31.png" alt="">
						<p>핫트뿅뿅</p>
					</a>
				</li>
				<li <c:if test="${agitType == 'C1512'}">class="on"</c:if>>
            		<a href="/ht/biz/agit?agitTypeCd=C1512">
               			<img src="../../images/biz/sub/icon_agit51.png" alt="">
						<p>문구하울</p>
					</a>
				</li>
				<li <c:if test="${agitType == 'C1513'}">class="on"</c:if>>
					<a href="/ht/biz/agit?agitTypeCd=C1513">
						<img src="../../images/biz/sub/icon_agit41.png" alt="">
						<p>보이는이야기</p>
					</a>
				</li>
		    </ul>
		</div>
				
		<div class="pd_filter">
			<p class="pd_total"><em class="font_t">${agitListCount}</em>건</p>
		</div>
		<div class="cont02">
			<div class="inner">
				<ul>
					<c:forEach items="${agitList}" var="agit">
						<li>
							<c:choose>
								<c:when test="${empty agit.linkUrl}">
									<a href="javascript:youtubePopup('.popup_video', '${agit.youtubeUrl}');">
								</c:when>
								<c:otherwise>
									<a href="${agit.linkUrl}">
								</c:otherwise>
							</c:choose>
							<c:if test="${agit.newVidio eq 'Y'}">
								<div class="tag_new">새 동영상</div>
							</c:if>
								<div class="thum">
									<ui:image src="${agit.imageUrl}" alt="${agit.imageAlt}"/>
								</div>
							</a>
							<a href="javascript:;">
								<div class="cont">
									<c:choose>
										<c:when test="${agit.agitTypeCd eq 'C1511'}">
											<span class="flag">핫트연구소</span>
										</c:when>
										<c:when test="${agit.agitTypeCd eq 'C1512'}">
											<span class="flag">문구하울</span>
										</c:when>
										<c:when test="${agit.agitTypeCd eq 'C1513'}">
											<span class="flag">보이는 이야기</span>
										</c:when>
										<c:when test="${agit.agitTypeCd eq 'C1515'}">
											<span class="flag">뷰어</span>
										</c:when>
										<c:otherwise>
											<span class="flag">핫트뿅뿅</span>
										</c:otherwise>
									</c:choose>
									<p class="tit">${agit.mainText}</p>
									<p class="txt">${agit.subText}</p>
								</div>
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		
		<div class="pagination_v2"><ui:bizPagination name="pageHolder" url="/ht/biz/agit?" parameters="agitTypeCd"/></div>
		<div class="layer_popup popup_video">
	    <div class="inner_layer" style="width:932px; height:524px;">
	        <div class="cont">
				<!-- TODO 초기화 -->
				<iframe class="video_yt" width="100%" height="506" src="" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	        </div>
    		<a href="javascript:;" class="layer_close"><span>닫기</span></a>
	    </div>
	</div>
	</body>
</html>