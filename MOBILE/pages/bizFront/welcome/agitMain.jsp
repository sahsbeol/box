<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp"%>
<ui:decorator name="bizWelcome"/>
<style>
/* CSS 페이지 임시 적용 */
#header {border:none; -webkit-box-shadow: 1px 1px 4px 0px rgba(219,219,219,1); -moz-box-shadow: 1px 1px 4px 0px rgba(219,219,219,1); box-shadow: 1px 1px 4px 0px rgba(219,219,219,1);}
#header .agit_menu {padding:0px; margin-top:-4px; padding-right: 10px;}
#header .agit_menu ul {overflow: initial;}
#header .agit_menu ul li {position: relative;float: left;width: 18.5%;text-align: center;margin: 0px;padding-bottom: 3px;}
#header .agit_menu ul li i {position: relative; display: block; margin: 0 auto; margin-bottom: 0px; width: 42px; height: 42px; border-radius: 0px; overflow: hidden; border: none;}
#header .agit_menu ul li a {color:#000;}
#header .agit_menu ul li:first-child {margin-left:10px;}
#header .agit_menu ul li .icon00:before{position:absolute;content:'';width: 37.5px;height:30px;left:50%;margin-left: -18.75px;top:50%;margin-top:-15px;background:url('../../images/biz/sub/icon_agitm0.png') no-repeat;background-size:cover;}    
#header .agit_menu ul li .icon01:before{position:absolute; content:''; width:30px; height:30px; left:50%; margin-left:-15px; top:50%; margin-top:-15px; background:url('../../images/biz/sub/icon_agitm1.png') no-repeat; background-size:cover;}
#header .agit_menu ul li .icon02:before{position:absolute; content:''; width:30px; height:30px; left:50%; margin-left:-15px; top:51.5%; margin-top:-15px; background:url('../../images/biz/sub/icon_agitm2.png?20200602') no-repeat; background-size:cover;}
#header .agit_menu ul li .icon03:before{position:absolute; content:''; width:30px; height:30px; left:50%; margin-left:-15px; top:50%; margin-top:-15px; background:url('../../images/biz/sub/icon_agitm3.png') no-repeat; background-size:cover;}
#header .agit_menu ul li .icon04:before{position:absolute; content:''; width:30px; height:30px; left:50%; margin-left:-15px; top:50%; margin-top:-15px; background:url('../../images/biz/sub/icon_agitm4.png') no-repeat; background-size:cover;}
#header .agit_menu ul li .icon05:before{position:absolute; content:''; width:30px; height:30px; left:50%; margin-left:-15px; top:50%; margin-top:-15px; background:url('../../images/biz/sub/icon_agitm5.png') no-repeat; background-size:cover;}
#header .agit_menu ul li.active {border-bottom: 4px solid #2DC8C4;}
#header .agit_menu ul li.active a{color:#000;}
#header .agit_menu ul li.active i{border-color:#2DC8C4;}
#header .agit_menu ul li.active .icon00:before{background-position:-37.5px 0;}
#header .agit_menu ul li.active .icon01:before{background-position:-30px 0;}
#header .agit_menu ul li.active .icon02:before{background-position:-30px 0;}
#header .agit_menu ul li.active .icon03:before{background-position:-30px 0;}
#header .agit_menu ul li.active .icon04:before{background-position:-30px 0;}
#header .agit_menu ul li.active .icon05:before{background-position:-30px 0;}

.life_wrapper .btn_more {padding:80px 37.5px 0 37.5px;}
.life_wrapper .btn_more a {position: relative;display: block;font-size: 1.167em;padding: 15px 0;box-sizing: border-box;text-align: center;border:1px solid #000;}
.life_wrapper .btn_more a:before {content: '';position: absolute;right:calc(50% - 36px) !important;top:21px;width:5.5px;height: 10px;background: url(../../images/biz/common/arrow_r01.png) no-repeat;background-size: 100%; transform:rotate(90deg);}
.agit_wrap {padding-top: 48px;}
.agit_wrap .pd_filter {padding: 30px 10px 35px 40px; clear: both;}
.agit_wrap .pd_filter .pd_total {float: left; font-size: 1.167em;}
.agit_wrap .pd_filter .pd_total .font_t {color: #419BF9; font-weight: bold; margin-right: 2px;}

.agit_wrap .agit_list a .tag_new {position: absolute;top: 10px;left: -40px;width: 59.5px;height: 21px;font-size: 12px;color: #fff;background: #FF6A5B;z-index: 9;text-align: center;padding: 3px 0 0 0;}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		var agitTypeCd = "${agitTypeCd}" != "" ? "${agitTypeCd}" : "";
		
		$('#gnbAgit').addClass('active');
		$('#agit_navi').css('display','block');
		$('.top_menu').css('display','none');
    	if(agitTypeCd != ""){
    		$('.agit-menu li[code='+agitTypeCd+']').addClass("active");
    	}
		
		sideMenu(); //side menu
		topMenu(); //main tob menu
		
		agitFn();
		$("#loading").hide();
		
		
		
		$('.btn_more').click(function(){
			$fn.setAgitMainList();
		});
		
		$fn.setAgitMainList();
		
		$('.page-menu.menu-agit').addClass('active');
		$('#header').addClass('play-header');
		$('#content').addClass('agit-content');
		$('.coin-wrap').addClass('music');
		$('.coin-wrap .coin').html("<p>문구</p>기프트");
		$('.coin-wrap .coin').attr("onclick","location.href='/m/biz/welcomeMain'");
	});
	$(window).scroll(function() {
		 var scrolltop = $(document).scrollTop();
	     var height = $(document).height();
	     var height_win = $(window).height();
		if (Math.round( $(window).scrollTop()) == $(document).height() - $(window).height()) {
			//main.swiperRest();
		}  
	});
	
$fn = {	
	setAgitMainList:function() {
		var sslVal = '${pageContext.request.scheme}';
		$("#loading2").show();
		$('.btn_more').show();
		
		$.ajax({
			url: "/m/biz/welcome/getAgitMainList"
			,type:"POST"
			,data:{
				agitTypeCd : $('#agitTypeCd').val(),
				page : $('#pageCnt').val() 
			}
	        ,dataType: "json"
	        ,success : function(data){
				var append = '';
	            
	           	if(!isEmpty(data)) {
					var list = data.agitList;
					var list2 = list.bizSvcPrdtList;
					var listCount = data.listCount;
					if(!isEmpty(list)) {
						for(var i=0; i < list.length; i++) {
							var prdtList = list[i].bizSvcPrdtList;
							
							append += '	<div class="agit_list">';
							append += '	<div class="thum">';
							if(isEmpty(list[i].linkUrl)){
								append += '	<a href="javascript:;" class="btn_thum">';
									if(list[i].newVidio == 'Y'){
										append += '<div class="tag_new">'+'새 동영상'+'</div>';	
									}
							}else{
								append += '<a href="'+list[i].linkUrl+'">';
							}
							append += '<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/'+list[i].imageUrl+'" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';" >';
							append += '</a>';
							
							if(isEmpty(list[i].linkUrl)){
								append += '<a href="javascript:;" class="btn_agit">';
								append += '</a>';
							}else{
								append += '<a href="'+list[i].linkUrl+'">';
								append += '</a>';
							}
							append += '</div>';
							if(list[i].youtubeUrl != '/' && list[i].youtubeUrl != '' && !isEmpty(list[i].youtubeUrl)){
								append += '<div class="box_video">';
									append += '<iframe width="560" height="315" src="'+list[i].youtubeUrl+'" frameborder="0" allow="accelerometer; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>';
									append += '</iframe>';
								append += '</div>';
							}
							
							if(list[i].agitTypeCd == 'C1511'){
								append += '<p class="flag">'+'핫트연구소'+'</p>';
							}else if(list[i].agitTypeCd == 'C1512'){
								append += '<p class="flag">'+'문구하울'+'</p>';
							}else if(list[i].agitTypeCd == 'C1513'){
								append += '<p class="flag">'+'보이는이야기'+'</p>';
							}else if(list[i].agitTypeCd == 'C1515'){
								append += '<p class="flag">'+'뷰어'+'</p>';
							}else{
								append += '<p class="flag">'+'핫트뿅뿅'+'</p>';
							}
							
							if(isEmpty(list[i].linkUrl)){
								append += '<a href="javascript:;">';
							}else{
								append += '<a href="'+list[i].linkUrl+'">';
							}
							 append += '<div class="desc '; 
							if(list[i].youtubeUrl != '/' && list[i].youtubeUrl != '' && !isEmpty(list[i].youtubeUrl)){
								append += 'youtube"';
							} 
							
							append += '>';
							append += '<p class="tit">' + list[i].mainText + '</p>';
							append += '<p class="txt">' + list[i].subText +'</p>';
							append += '</div>';
							append += '</a>'; 
							if(!isEmpty(prdtList)){
								append += '<div class="thum_list">';
								append += 	'<ul>';
									for(var j=0; j < prdtList.length; j++ ){
										append += '	<li>';
										append += '<a href="/p/'+prdtList[j].sellPrdtBcode+'">';
											if(prdtList[j].sellPrdtGbn != 'R' && prdtList[j].sellPrdtGbn != 'D'){
												append += '<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+prdtList[j].productImageUrl+'" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';" server="product" ssl="';
												if(sslVal == 'http'){
													append += 'N"';
												}else{
													append += 'y"';
												}
												append += '/>';
											}
											if(prdtList[j].sellPrdtGbn == 'R'){
												append += '<img rcrdCd="'+prdtList[j].rcrdCd+'" prdtGbn="R" ratingCode="A" alt="'+prdtList[j].title+'" ssl="';
												if(sslVal == 'http'){
													append += 'N"';
												}else{
													append += 'y"';
												}
												append += '/>';
											}
											if(prdtList[j].sellPrdtGbn == 'D'){
												append += '<img rcrdCd="'+prdtList[j].rcrdCd+'" prdtGbn="D" ratingCode="A" alt="'+prdtList[j].title+'" ssl="';
												if(sslVal == 'http'){
													append += 'N"';
												}else{
													append += 'y"';
												}
												append += '/>';
											}
										append += '</a>';
										append += '</li>';
									}
									append += '	</ul>';
									append += '</div>';
								
							} 
							append += '</div>';

						} 
						
						$('#agitClass').append(append);
						$('#pageCnt').val(Number($('#pageCnt').val())+1);
						$('#listCount').text(listCount);
						
						if(list.length < 7){
							$('.btn_more').hide();
						}
					}else{
						if($('#lifeMainList > .life_inner').length == 0){
							$('#listCount').text('0');
						}
						
						$('.btn_more').hide();
					}
	            }
	        }
	        ,complete: function() {
	        	$("#loading2").hide();
	        	
	        	new Swiper('.swiper-container.life-container', {
	                slidesPerView: 'auto',
	                spaceBetween: 4,
	                speed: 1000,
	                freeMode: true,
	                freeModeMomentumBounce: false
	             });
	        }
	        ,error: function(request, status, error) {
	            if(request.status != 0){
	                alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
	            }
	            $("#loading2").hide();
	        }
	    });
	}
};

</script>
</head>
<body>
	<!-- content -->
	<div id="loading2" class="loadingbar"><img src="/images/common/ajax-loader.gif"/></div>
	<div id="content">
		<input type="hidden" id="pageCnt" value="1">
		<div class="main_wrapper agit_wrap">
			<input type="hidden" id="agitTypeCd" value="${agitTypeCd}"/>
			<div class="pd_filter">
                <p class="pd_total"><em class="font_t">
                <fmt:formatNumber value="${agitListCnt}" pattern=",###"/></em>건</p>
            </div>
			<c:if test="${empty agitTypeCd or agitTypeCd ne 'SOSO'}">
				<div class="agit01">
					<div class="agit_list_wrap" id="agitClass">
					</div>
						<div class="btn_more font_ns">
		                    <a href="#n" onclick="">더보기</a>
		                </div>
				</div>
			</c:if>
			
			<c:if test="${empty agitTypeCd or agitTypeCd eq 'SOSO'}">
				<div class="agit02" id="sosoClass">
					<h5>소소클래스</h5>
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<c:forEach items="${sosoList}" var="soso">
								<div class="swiper-slide">
									<a href="javascript:;" onclick="location.href='/m/biz/eventDetail?eventId=${soso.eventId}';return false;">
										<div class="thum">
											<ui:image src="${soso.imageUrl}" alt="${soso.eventTitle}"/>
										</div> 
										<strong>${soso.eventTitle}</strong>
										<p>${soso.eventDtlCont}</p> 
										<span class="date font_t">
											<fmt:parseDate var="startDt" value="${soso.startDt}" pattern="yyyyMMdd"/>
											<fmt:parseDate var="endDt" value="${soso.endDt}" pattern="yyyyMMdd"/>
														
											<fmt:formatDate value="${startDt}" pattern="yyyy.MM.dd"/> ~										
											<fmt:formatDate value="${endDt}" pattern="yyyy.MM.dd" />
										</span>
									</a>
								</div>
							</c:forEach>
						</div>
						
			
						<!-- 스크롤바 -->
						<div class="swiper-scrollbar"></div>
			
						<!-- swiper-pagination -->
						<div class="pagination_wrap">
							<div class="swiper-pagination"></div>
						</div>
					</div>
				</div>
			
				<!-- TODO 나중에 지워질수도있음 2020.01.10 -->
				<div class="agit03">
					<h5>만족도 솔직 생생후기!</h5>
					<div class="insta_a">
						<!-- LightWidget WIDGET -->
						<script src="https://cdn.lightwidget.com/widgets/lightwidget.js"></script>
						<iframe src="https://cdn.lightwidget.com/widgets/17fd78c7b9805bdba9a639175f1c8a6d.html" scrolling="no" allowtransparency="true" class="lightwidget-widget" style="width:100%;border:0;overflow:hidden;"></iframe>
					</div>
				</div>
		
				<div class="agit04">
					<a href="javascript:;" traget="_blank" onFocus="this.blur()" onclick="winOpen3('http://naver.me/FmpaCVTO?newPop=chromeYes');return false;"><img src="/images/biz/sub/img_agit.png" alt=""></a>
				</div>
			</c:if>
		</div>
	</div>
	<!--// content -->
</body>
</html>