<%@page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizWelcome"/>
<style>
.life_wrapper{color:#000; font-family:font_ms, 'Nanum Myeongjo', sans-serif; overflow: hidden;}
.life_wrapper .life_inner {padding-bottom:50px;}
.life_wrapper .life_inner:nth-last-of-type(1) {padding-bottom:0;}
.life_wrapper .life_inner img {width:100%;}
.life_wrapper .life_inner .desc_txt {padding-left:48px;padding-bottom: 83px;}
.life_wrapper .life_inner .desc_txt a {width:100%;}
.life_wrapper .life_inner.ver01 .desc_txt {margin-top:48px;}
.life_wrapper .life_inner.ver02 .desc_txt {margin-top:28px;}
.life_wrapper .life_inner.ver01 b {display: block;margin-right:40px;height:8px;background: #000;}
.life_wrapper .life_inner .desc_txt h2 {margin-bottom:13px;font-size:2.250em;font-weight: 400;text-overflow: ellipsis;white-space: nowrap;overflow: hidden; width:92%;}
.life_wrapper .life_inner .desc_txt h2:after{position: absolute; right: 10px; margin-top: 8px; content: ''; width: 9px; height: 16px; background: url('../../images/biz/sub/icon_agit_arr02.png') no-repeat; background-size: 9px 16px;}
.life_wrapper .life_inner .desc_txt p {padding-right: 20px;font-size:1.167em;line-height: 1.429em;font-weight: 400;color:#777; margin-top: 10px;}
.life_wrapper .life_inner .desc_txt p.htag a {margin-right:10px;}

.life_wrapper .life_filter {width: 100%;height: 94.5px;border: 1px solid #ffe1de;padding: 5px 0 5px 0;box-sizing: border-box;background: #fff; box-shadow: none; margin-left: 1px;}
.life_wrapper .life_filter.fixed {position: fixed;top: 61px;z-index: 99;left: 0;}
.life_wrapper .life_filter ul {width: fit-content;height: 82.5px; background:#fff;}
.life_wrapper .life_filter ul li {float:left;width:82.5px;height: 82.5px;box-sizing: border-box;border: 1px solid #ffe1de; border-right: none;}
.life_wrapper .life_filter ul li:last-child {box-sizing: border-box;border: 1px solid #ffe1de;}
.life_wrapper .life_filter ul li:first-child.active{border: 1px solid #FF6A5B;box-sizing: border-box;z-index: 1; margin: 0px;}
.life_wrapper .life_filter ul li:last-child.active{border: 1px solid #FF6A5B;box-sizing: border-box;z-index: 1; margin: 0px;}
.life_wrapper .life_filter ul li.new a:before {background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/ico_tagnew.png') no-repeat;background-size:contain;position: absolute;content: '';right: 3px;top: 6px;width:16px;height:16px;}
.life_wrapper .life_filter ul li a {position: absolute;top: 0px;left: 5.5px;font-size: 14px;line-height: 20px;height: 100%;width: 71.5px;color: #707070;text-align: center;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;-webkit-line-clamp: 2;-webkit-box-orient: vertical;-webkit-box-pack: center;display:-webkit-box;}
.life_wrapper .life_filter ul li.active {border: 1px solid #FF6A5B;box-sizing: border-box;z-index: 1;}
.life_wrapper .life_filter ul li.active a {color: #000; font-weight: bold;}

.life_wrapper .btn_more {padding:80px 37.5px 0 37.5px;}
.life_wrapper .btn_more a {position: relative;display: block;font-size: 1.167em;padding: 15px 0;box-sizing: border-box;text-align: center;border:1px solid #000;}
.life_wrapper .btn_more a:before {content: '';position: absolute;right:calc(50% - 36px) !important;top:21px;width:5.5px;height: 10px;background: url(../../images/biz/common/arrow_r01.png) no-repeat;background-size: 100%; transform:rotate(90deg);}


.life_wrapper .pd_filter{padding:30px 10px 35px 40px;clear: both;}
.life_wrapper .pd_filter.fixed1 {margin-bottom: 121px;}
.life_wrapper .pd_filter.fixed2 {margin-bottom: 182px;}
.life_wrapper .pd_filter .pd_total{float:left; font-size:1.167em;}
.life_wrapper .pd_filter .pd_total .font_t{color:#419BF9; font-weight:bold; margin-right:2px;}
.life_wrapper .pd_filter .form_select{float:right; width:80px; border:0; position:relative; display:inline-block; box-sizing:border-box;}
.life_wrapper .pd_filter .form_select:after{content:''; position:absolute; right:0px; top:50%; margin-top:-3px; background:url('../../images/biz/sub/icon_btn_arrow.png') 0 0 no-repeat; width:10px; height:6px; background-size:10px 6px;}
.life_wrapper .pd_filter .form_select select{width:100%; background:none; border:0; padding:0; padding-right:10px; height:21px; line-height:21px; color:#000; font-family: font_ms, 'Nanum Myeongjo', sans-serif;}
.life_wrapper .pd_filter .form_select select{-webkit-appearance: none; -moz-appearance: none; appearance: none;}
.life_wrapper .pd_filter .form_select select::-ms-expand {display:none;}

.life_filter .pd_filter .tag_list {height: 60px;padding:17px 10px 17px 40px;box-sizing: border-box;}
.life_filter .pd_filter .tag_list ul li {margin:0 4px;}
.life_filter .pd_filter .tag_list ul li a {font-weight: 400;padding: 6px 24px 5px 13px;}
.life_filter .pd_filter .tag_list .btn_sympathy {position: absolute;right: 18px;top: 50%;margin-top: -0.857em;font-size: 1.167em;padding: 5px 0 5px 20px;}
.life_filter .pd_filter .tag_list .btn_sympathy.active {color:#FF6A5B;}
.life_filter .pd_filter .tag_list .btn_sympathy:before {content:'';position: absolute;left:0;top:5px;width:16px;height:16px;background: url(../../images/biz/sub/ico_sympathy.png) no-repeat;background-size:contain;}
.life_filter .pd_filter .tag_list .btn_sympathy.active:before {background: url(../../images/biz/sub/ico_sympathy_on.png) no-repeat;background-size:contain;}

.life_wrapper .life_inner .desc_txt .like_heart {position: relative;float: right;width: 32px;margin-right: 19.5px;margin-top:7px;}
.life_wrapper .life_inner .desc_txt .like_heart .heart {display: block;width: 32px;font-size: 1.167em;letter-spacing: -0.03em;padding: 36px 0 0 0;box-sizing: border-box;text-align: center;background-position: center;background: url(../../images/biz/sub/heart_off.gif) 50% 0% no-repeat;background-size: 32px;}
.life_wrapper .life_inner .desc_txt .like_heart .heart.on {background: url(../../images/biz/sub/heart_on.gif) 50% 0% / 32px no-repeat !important;}
.life_wrapper .life_inner .desc_txt .like_heart a {position: absolute;left:0;top:0;bottom:0;width:100%;height:100%;}

.life_wrapper .life_inner .life_suggest {padding-left: 40px;}
.life_wrapper .life_inner .life_suggest .life-container {width:auto; z-index:0;}
.life_wrapper .life_inner .life_suggest .life-container .swiper-slide {width:200px;}
.life_wrapper .life_inner .life_suggest .life-container .img_life img {width:200px;height:340px;}

.life_wrapper .life_inner .life_suggest .life-container .txt_life {margin-top:20px;}
.life_wrapper .life_inner .life_suggest .life-container .txt_life h2{font-size:1.333em;line-height:1.250em;height:38px;text-overflow: ellipsis;max-width: 200px;overflow: hidden;display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;overflow: hidden;}
.life_wrapper .life_inner .life_suggest .life-container .txt_life p {margin-top: 5px;font-size:1.167em;line-height:1.250em;color:#777;text-overflow: ellipsis;max-width: 200px;overflow: hidden;white-space: nowrap;}

.life_wrapper .life_inner .life_suggest .only_one {position: relative;left:calc(100% - 220px);width:200px;}
.life_wrapper .life_inner .life_suggest .only_one a {position: absolute;left:0;top:0;width:100%;height:100%;}
.life_wrapper .life_inner .life_suggest .only_one img {width:200px;height:340px;}
.life_wrapper .life_inner .life_suggest .only_one .txt_life {margin-top:20px;width:200px;}
.life_wrapper .life_inner .life_suggest .only_one .txt_life h2{font-size:1.333em;line-height:1.250em;height:38px;text-overflow: ellipsis;max-width: 200px;overflow: hidden;display: -webkit-box;-webkit-line-clamp: 2;-webkit-box-orient: vertical;overflow: hidden;}
.life_wrapper .life_inner .life_suggest .only_one .txt_life p {margin-top: 5px;font-size:1.167em;line-height:1.250em;color:#777;text-overflow: ellipsis;max-width: 200px;overflow: hidden;white-space: nowrap;}
</style>
<script type="text/javascript">
$(document).ready(function() {
	$('#gnblife').addClass('active');
	
	var lifeSwiper2 = new Swiper('.swiper-container.lifeHash-container', {//해시태그
    	slidesPerView: 'auto',
    	speed: 300,
    	freeMode: true,
    	freeModeMomentumBounce: false,
    	initialSlide: $('[name=hashTag] > .active').index()
    });
	
	$('.tag_list li').click(function(){
		$(this).siblings().removeClass('active');	
		if($(this).hasClass('active')){
			$(this).removeClass('active');	
		}else{
			$(this).addClass('active');
		}
		
		$('#pageCnt').val('1');
		$('#lifeMainList').empty();
		
		$fn.setLifeMainList();
	});
	
	$(document).on("click",".htag",function() {
		$('[name=hashTag] > li').removeClass('active');
		$('#pageCnt').val('1');
		$fn.setLifeMainList($(this).find("a").attr("code"));
	});
	
	$('.btn_sympathy').click(function(){
		if ('${isLogin}' == "true") {
		
			if($(this).hasClass('active')){
				$(this).removeClass('active');	
			}else{
				$(this).addClass('active');
			}
			
			$('#pageCnt').val('1');
			$('#lifeMainList').empty();
			
			$fn.setLifeMainList();
		
		} else {
			
			needLogin();
			
		}
	});

	$('.btn_more').click(function(){
		$fn.setLifeMainList();
	});
	
	// 정렬순서 변경
	$('#productOrderBy').change(function(){
		$('#lifeMainList').empty();
		$('#pageCnt').val('1');
		$fn.setLifeMainList();
	});
	
	// 해시태그 클릭시
	$('[name=hashTag] > li').click(function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
		}else{
			$(this).siblings().removeClass("active");
			$(this).addClass("active");	
		}
		
		$('#lifeMainList').empty();
		$('#pageCnt').val('1');
		$fn.setLifeMainList();
	});
	
	$fn.setLifeMainList();
	
	$('.page-menu.menu-life').addClass('active');
	$('#header').addClass('play-header');
	$('#content').addClass('life-content');
	$('.coin-wrap').addClass('music');
	$('.coin-wrap .coin').html("<p>문구</p>기프트");
	$('.coin-wrap .coin').attr("onclick","location.href='/m/biz/welcomeMain'");
});

$fn = {
	setLifeMainList:function(hTag) {
		$("#loading2").show();
		$('.btn_more').show();
		
		var tag = $('[name=hashTag] > .active').attr("code");
		
		if(!isEmpty(hTag)){
			tag = hTag;
		}
			
		$.ajax({
			url: "/m/biz/welcome/getLifeMainList"
			,type:"POST"
			,data:{
				productOrderBy : $('#productOrderBy').val(),
				hashTag : tag,
				page : $('#pageCnt').val() 
			}
	        ,dataType: "json"
	        ,success : function(data){
	        	var append = '';
                
               	if(!isEmpty(data)) {
					var list = data.list;
					var listCount = data.listCount;
					if(!isEmpty(list)) {
						for(var i=0; i < list.length; i++) {
							var mainParam = list[i].lifeMainParam;
							var subParam = list[i].lifeSubParam;
							var hashParam = list[i].lifeHashParam;
							var mainClass = '';
							var wishCnt = '';
							
							if(isEmpty(mainParam.imgUrl)){
								mainClass = 'ver01';
							}else{
								mainClass = 'ver02';
							}
							append += '<div class="life_inner '+mainClass+'">';
							if(isEmpty(mainParam.imgUrl)){
								append += '	<b></b>';
							}else{
								if(subParam.length > 1){
									append += '		<a href="/p/'+subParam[0].sellPrdtBcode+'?foo=bar&rccode=mo_life"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/'+mainParam.imgUrl+'" alt="" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';"></a>';
								}else{
									append += '	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/'+mainParam.imgUrl+'" alt="" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
								}
							}
							
							append += '	<div class="desc_txt">';
							if(subParam.length > 1){
								append += '		<a href="/p/'+subParam[0].sellPrdtBcode+'?foo=bar&rccode=mo_life">';
							}else{
								append += '		<a href="#n">';
							}
							append += '			<h2>'+mainParam.mainText+'</h2>';
							append += '			<p>'+mainParam.subText+'</p>';
							append += '		</a>';
							if(!isEmpty(hashParam)){
								append += '		<p class="htag">';
								for(var j=0; j < hashParam.length; j++) {
									append += '		<a href="/m/biz/lifeMain?productOrderBy=R&hashTag='+hashParam[j].code+'" code="'+hashParam[j].code+'">#'+hashParam[j].codeName+'</a>';
								}
								append += '		</p>';
							}
							append += '		<div class="like_heart clear">';
// 							if(mainParam.wishCnt > 999){
// 								wishCnt = '999+';
// 							}else{
// 								wishCnt = mainParam.wishCnt;
// 							}
								
// 							if(mainParam.userWishYn == 'Y'){
// 								append += '	<span class="heart on" code="'+mainParam.svcSeq+'">'+wishCnt+'</span>';
// 							}else{
// 								append += '	<span class="heart" code="'+mainParam.svcSeq+'">'+wishCnt+'</span>';
// 							}
							
// 							append += '			<a href="javascript:" onclick="addBizWishLife(this);return false;" class="btn_life" svcSeq="'+mainParam.svcSeq+'"></a>';
							append += '		</div>';
							append += '	</div>';
							append += '	<div class="life_suggest">';
							
							if(subParam.length > 1){
								append += '	<div class="swiper-container life-container">';
								append += '		<div class="swiper-wrapper">';
								for(var j=0; j < subParam.length; j++) {
									append += '		<div class="swiper-slide">';
									append += '			<a href="/p/'+subParam[j].sellPrdtBcode+'?foo=bar&rccode=mo_life">';
									append += '				<div class="img_life">';
									append += '					<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/'+subParam[j].imgUrl+'" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
									append += '				</div>';
									append += '				<div class="txt_life">';
									append += '					<h2>'+subParam[j].title+'</h2>';
									append += '					<p>'+subParam[j].prdtName+'</p>';
									append += '				</div>';
									append += '			</a>';
									append += '		</div>';
								}
								append += '		</div>';
								append += '	</div>';
							}else{
								append += '	<div class="only_one">';
								for(var j=0; j < subParam.length; j++) {
									append += '	<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/'+subParam[j].imgUrl+'" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
									append += '	<div class="txt_life">';
									append += '		<h2>'+subParam[j].title+'</h2>';
									append += '		<p>'+subParam[j].prdtName+'</p>';
									append += '	</div>';
									append += '	<a href="/p/'+subParam[j].sellPrdtBcode+'"></a>';
								}
								append += '	</div>';
							}
							append += '		</div>';
							append += '	</div>';
						}
						
						$('#lifeMainList').append(append);
						$('#pageCnt').val(Number($('#pageCnt').val())+1);
						$('#listCount').text(listCount);
						
						if(list.length < 5){
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
	<input type="hidden" id="htagParam" value="${c.hashTag}">
	<div id="loading2" class="loadingbar"><img src="/images/common/ajax-loader.gif"/></div>
	<!-- content -->
	<div id="content">
		<input type="hidden" id="pageCnt" value="1">
		<div class="swiper-slide">
			<div class="life_wrapper">
				<div class="swiper-container lifeHash-container life_filter">
                	<ul class="swiper-wrapper" name="hashTag">
						<c:forEach items="${hashList}" var="l">	
							<li code="${l.code}" class="swiper-slide <c:if test="${l.code eq c.hashTag}">active</c:if>"><a href="#" onclick="javacript:event.preventDefault();"><span>${fn:replace(l.codeName, ' ', '<br>')}</span></a></li>
						</c:forEach>
	                </ul>
                </div>
                <div class="pd_filter">
                    <p class="pd_total"><em class="font_t" id="listCount">0</em>개</p>
                    <div class="form_select">
                        <select id="productOrderBy">
                            <option value="R">최근등록순</option>
	                        <option value="P">인기순</option>
	                        <option value="RD">랜덤순</option>
                        </select>
                    </div>
                </div>

				<div id="lifeMainList">
				</div>
				<div class="btn_more font_ns">
                    <a href="#n" onclick="">더보기</a>
                </div>
			</div>
		</div>
	</div>
</body>
</html>