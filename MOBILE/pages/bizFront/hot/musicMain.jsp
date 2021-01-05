<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<head>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="none"/>
<script type="text/javascript" src="/js/biz/m_hott.js?${tmpKey}"></script>
<script type="text/javascript">
$(window).scroll(function() {
	 var scrolltop = $(document).scrollTop();
    var height = $(document).height();
    var height_win = $(window).height();
	if (Math.round( $(window).scrollTop()) == $(document).height() - $(window).height()) {
		main.swiperRest();
	}  
});
$(document).ready(function() {
// 	sideMenu(); //side menu
// 	topMenu();//gnb
	recordSlide(); //main record
	subFn();
	$("#loading").hide();
    /* 탭메뉴:sub */
    $(".album-container .swiper-wrapper").hide();
    $(".recent-container .swiper-wrapper").hide();
    $(".list_realtime").hide();
    $(""+$(".album-container").parent().find(".list_type .on a").attr("href")+"").show();
    $(""+$(".recent-container").parent().find(".list_type .on a").attr("href")+"").show();
    $(""+$(".realtime_chart").find(".list_type .on a").attr("href")+"").show();
    $(".list_type li").click(function(){
        $(this).parent().children("li").removeClass("on");
        $(this).addClass("on");
        $(this).parent().parent().find(".swiper-wrapper").hide();
        $($(this).children("a").attr("href")).show();
        $($(this).children("a").attr("href")).children(".swiper-scrollbar").show();
        return false;
    });
    $(".realtime_chart .list_type li").click(function(){
        $(this).parent().children("li").removeClass("on");
        $(this).addClass("on");
        $(this).parent().parent().find(".list_realtime").hide();
        $($(this).children("a").attr("href")).show();
        return false;
    });
    $("#layer_banner_r").appendTo("body");
    $("#app_bar").appendTo("body");
	  //메인탭스와이퍼 재설정
    var interval = setInterval(function(){
    	main.swiperRest();
    },600);
    setTimeout(function(){
    	clearInterval(interval);
    },3000);
    recobelTemplet(true)
});
function recobelTemplet(checkF){
	var nowPage = Number($("#rcPage").text());
	var page = nowPage+1>5?0:nowPage+1;
	var searchTxt = "";
	if (checkF) {
		searchTxt = $("[name=sellPrdtBcode]:eq(0)").val();
	} else {
		
		if (page == 0) {
			$(".album_recomm:eq(4)").attr("style","display:none;");
			$(".album_recomm:eq(0)").attr("style","display:;");
			$("#rcPage").text('1');
			searchTxt = $("[name=sellPrdtBcode]:eq(0)").val();
		} else {
			$(".album_recomm:eq("+(nowPage-1)+")").attr("style","display:none;");
			$(".album_recomm:eq("+nowPage+")").attr("style","display:;");
			$("#rcPage").text(page);
			searchTxt = $("[name=sellPrdtBcode]:eq("+(nowPage)+")").val();
		}
	}
	$.ajax({
	    type: "POST"
	   ,async:false
	   ,url: "/m/biz/musicRecoTemplate"
	   ,data:{sellPrdtBcode:searchTxt}
	   ,dataType: "html"
	   ,success : function(htmlStr){
		    $(".list_recomm").empty();
	       	$(".list_recomm").append(htmlStr);
		  	//로딩바 숨기기
	   }
	   ,error: function(data) {
	       alert('<fmt:message key="error.common.system"/>');
	   }
	}); 
}
</script>
<title>음반 메인 - NEW ME HOTTRACKS</title>
</head>
            <div class='record_wrap'>
				<!-- 음반배너 -->
                <div class="swiper-container bnr-container">
                    <div class="swiper-wrapper">
                    <c:forEach items="${mainRollBnrList}" var="l" varStatus="st">
                    <c:if test="${l.signWayGbn eq 'C1451' || l.signWayGbn eq 'C1452' || l.signWayGbn eq 'C1453'}">
						<div class="swiper-slide">
						<input type="hidden" class="flag" value="${l.flagCd}"/>
						<c:if test="${l.signWayGbn eq 'C1451'}">
							<a href='${l.bnrLnkUrl}' class="MB_MAIN_MUSIC_1"><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/></a>
							<div class='slide_circle'></div>
						</c:if>
						<c:if test="${l.signWayGbn eq 'C1452'}">
	                           <a href='${l.bnrLnkUrl}' class="MB_MAIN_MUSIC_1">
	                               <h2>${l.bnrTitle}</h2>
	                           </a>
	 						  <div class='slide_circle'>
	 							  <span class="ico_badge on">
	 								  <ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" />
	 							  </span>
	 						  </div>
	                    </c:if>
						<c:if test="${l.signWayGbn eq 'C1453'}">
	                          <a href='${l.bnrLnkUrl}' class="MB_MAIN_MUSIC_1">
	                              <h2>${l.bnrTitle}</h2>
	                              <span>${l.bnrSubTitle}</span>
	                          </a>
							  <div class='slide_circle'>
								  <span class="ico_badge on">
									  <ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/>
								  </span>
							  </div>
	                    </c:if>
	                    </div>
	                    </c:if>
                    </c:forEach>
                    </div>
                    <!-- Add Pagination -->
                    <div class='pagination_wrap font_t'>
                    	<a href="javascript:" class='paging_link_r'>
	                        <div class="swiper-pagination" id="record_swiper"></div>
							<div class="plus_inner_r">
								//<a href="javascript:" class="btn_plus_r"></a>
							</div>
						</a>
                        <div class='bnr_type type_ad'>
                        	<p class='type_ad'>광고</p>
                            <p class='type_en'>응모</p>
                        </div>
                    </div>
                </div>
				<!-- //음반배너-->
				<!-- 예약음반 -->
				<div class="record_booking">
					<h2 class='tit_record'>예약음반</h2>
					<ul class='list_type clear'>
						<!-- 활성화된 li에 class='on' -->
						<li class='MB_MAIN_MUSIC_2 on'><i></i><a href="#prod01">가요</a></li>
						<li class='MB_MAIN_MUSIC_2_1'><i></i><a href="#prod02">팝</a></li>
						<li class='MB_MAIN_MUSIC_2_2'><i></i><a href="#prod03">클래식</a></li>
						<li class='MB_MAIN_MUSIC_2_3'><i></i><a href="#prod04">영상</a></li>
					</ul>
					<c:forEach varStatus="s1" begin="1" end="4"> 
					<div class="swiper-container album-container">
					        <c:if test="${s1.index eq 1}"><c:set var="list" value="${reServeBnrListSong}"/></c:if>
                            <c:if test="${s1.index eq 2}"><c:set var="list" value="${reServeBnrListPop}"/></c:if>
                            <c:if test="${s1.index eq 3}"><c:set var="list" value="${reServeBnrListClassic}"/></c:if>
                            <c:if test="${s1.index eq 4}"><c:set var="list" value="${reServeBnrListDvd}"/></c:if>
				      <div id="prod0${s1.index}" class="swiper-wrapper">
				      <c:forEach items="${list}" var="l"  begin="0" end="19" >
				        <div class="swiper-slide">
							<div  class='album_wrapper'>
								<div class='album_inner'>
                                   	<i style="background: #fff url('${l.productImageUrl }') center center no-repeat; background-size:contain;">
								        <c:if test="${l.dDay > 0}"><span class='font_t'>D-${l.dDay}</span></c:if>
								        <c:if test="${l.dDay eq 0}"><span class='font_t'>D-DAY</span></c:if>
									</i>
								</div>
								<div class='album_brief'>
									<p>발매일 <strong class="ml5 font_t"><ui:mask pattern="####.##.##">${l.rlseDt}</ui:mask></strong></p>
									<h2>${fn:escapeXml(l.artiName)}</h2>
									<h3>${fn:escapeXml(l.basePrdtName)}</h3>
									<span class='font_t'><fmt:formatNumber type="number">${l.lastDcPrice }</fmt:formatNumber></span>
									<c:if test="${l.prdtSellPrice ne l.lastDcPrice}"><em class='font_t'><fmt:parseNumber integerOnly="true">${hfn:rate(l.prdtSellPrice, l.lastDcPrice)}</fmt:parseNumber>%</em></c:if>
								</div>
							</div>
							<a href="/m/record/detail/${l.sellPrdtBcode}" class='album_link MB_MAIN_MUSIC_2_4'></a>
						</div>
                    </c:forEach>
					  	<!-- 스크롤바 -->
				      </div>
	  					<div class="swiper-scrollbar"></div>
				    </div>
                    </c:forEach>
				</div>
				<!-- //예약음반 -->
				<!-- 최근발매 -->
				<div class="record_booking">
					<h2 class='tit_record'>최근발매</h2>
					<ul class='list_type clear'>
						<!-- 활성화된 li에 class='on' -->
						<li class='MB_MAIN_MUSIC_3 on'><i></i><a href="#prod05">가요</a></li>
						<li class='MB_MAIN_MUSIC_3_1'><i></i><a href="#prod06">팝</a></li>
						<li class='MB_MAIN_MUSIC_3_2'><i></i><a href="#prod07">클래식</a></li>
						<li class='MB_MAIN_MUSIC_3_3'><i></i><a href="#prod08">영상</a></li>
					</ul>
					<c:forEach varStatus="s1" begin="5" end="8"> 
					<div class="swiper-container recent-container">
					        <c:if test="${s1.index eq 5}"><c:set var="list" value="${listSong}"/></c:if>
                            <c:if test="${s1.index eq 6}"><c:set var="list" value="${listPop}"/></c:if>
                            <c:if test="${s1.index eq 7}"><c:set var="list" value="${listClassic}"/></c:if>
                            <c:if test="${s1.index eq 8}"><c:set var="list" value="${listDvd}"/></c:if>
				      <div id="prod0${s1.index}"  class="swiper-wrapper">
				      <c:forEach items="${list}" var="l" begin="0" end="19">
				        <div class="swiper-slide">
							<div class='album_wrapper'>
								<div class='album_inner'>
	                                <i style="background: #fff url('${l.productImageUrl }') center center no-repeat; background-size:contain;"></i>
								</div>
								<div class='album_brief'>
									<h2>${fn:escapeXml(l.artiName)}<br>${fn:escapeXml(l.basePrdtName)}</h2>
									<span class='font_t'><fmt:formatNumber type="number">${l.lastDcPrice }</fmt:formatNumber></span>
									<c:if test="${l.prdtSellPrice ne l.lastDcPrice}"><em class='font_t'><fmt:parseNumber integerOnly="true">${hfn:rate(l.prdtSellPrice, l.lastDcPrice)}</fmt:parseNumber>%</em></c:if>
								</div>
							</div>
							<a href="/m/record/detail/${l.sellPrdtBcode}" class='album_link MB_MAIN_MUSIC_3_4'></a>
						</div>
				      </c:forEach>
				      </div>
					  <!-- 스크롤바 -->
  					<div class="swiper-scrollbar"></div>
				    </div>
				    </c:forEach>
				</div>
				<!-- //최근발매 -->
				<!-- 실시간차트 -->
				<div class="realtime_chart">
					<h2 class='tit_record'>실시간 차트</h2>
					<ul class='list_type clear'>
						<!-- 활성화된 li에 on : class 추가 -->
						<li class='MB_MAIN_MUSIC_4 on'><i></i><a href="#prod09">음반</a></li>
						<li class='MB_MAIN_MUSIC_4_1'><i></i><a href="#prod10">영상</a></li>
					</ul>
					<ul id="prod09" class='list_realtime'>
					<c:forEach items="${list1}" var="l"  begin="0" end="4" varStatus="st">
						<li class="MB_MAIN_MUSIC_4_2">
							<strong class='font_t'>${st.index+1}</strong>
							<i><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" rcrdImgType="large" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></i>
							<div class='desc_real'>
 								<c:if test="${l.hasPosterCaseYn ne 'N'}"><span class='flg1'>지관통+포스터 증정</span></c:if>
								<c:if test="${l.rcrdStat eq '9'}"><span class='flg2'>예약</span></c:if>
								<h2>${l.artiName}<br>${fn:escapeXml(l.rcrdName)}</h2>
								<em class='font_t'><fmt:formatNumber type="number">${l.lastDcPrice }</fmt:formatNumber></em>
								<c:if test="${l.prdtSellPrice ne l.lastDcPrice}"><em class='em_per font_t'><fmt:parseNumber integerOnly="true">${hfn:rate(l.prdtSellPrice, l.lastDcPrice)}</fmt:parseNumber>%</em></c:if>
							</div>
							<a href="/m/record/detail/${l.sellPrdtBcode}"></a>
						</li>
					</c:forEach>
					</ul>
					<ul id="prod10" class='list_realtime'>
					<c:forEach items="${list2}" var="l" begin="0" end="4" varStatus="st">
						<li class="MB_MAIN_MUSIC_4_2">
							<strong class='font_t'>${st.index+1}</strong>
							<i><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" rcrdImgType="large" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></i>
							<div class='desc_real'>
 								<c:if test="${l.hasPosterCaseYn ne 'N'}"><span class='flg1'>지관통+포스터 증정</span></c:if>
								<c:if test="${l.rcrdStat eq '9'}"><span class='flg2'>예약</span></c:if>
								<h2>${l.artiName}<br>${fn:escapeXml(l.rcrdName)}</h2>
								<em class='font_t'><fmt:formatNumber type="number">${l.lastDcPrice }</fmt:formatNumber></em>
								<c:if test="${l.prdtSellPrice ne l.lastDcPrice}"><em class='em_per font_t'><fmt:parseNumber integerOnly="true">${hfn:rate(l.prdtSellPrice, l.lastDcPrice)}</fmt:parseNumber>%</em></c:if>
							</div>
							<a href="/m/record/detail/${l.sellPrdtBcode}"></a>
						</li>
					</c:forEach>
					</ul>
					<ul class='list_bnr'>
					<c:forEach items="${hotEventlist}" varStatus="st" var="l">
						<li class="MB_MAIN_MUSIC_5">
							<span><ui:image src="${l.eventImageUrl}" alt="${l.eventTitle}" /></span>
							<div class='desc_realbnr'>
								<h2>${fn:escapeXml(l.eventTitle) }</h2>
								<p>${fn:escapeXml(l.eventDtlCont)}</p>
							</div>
							<a href="/m/biz/eventDetail?eventId=${l.eventId}"></a>
						</li>
						</c:forEach>
					</ul>
				</div>
				<!-- //실시간차트 -->
				<!-- 맞춤추천 -->
				<c:forEach items="${listRecobell}" var="l" varStatus="st" begin="0" end="4" >
					<c:if test="${st.index eq '0'}"><c:set var="totalPage" value="0"/></c:if>
					<c:set var="totalPage" value="${totalPage + 1}"/>
					<input type="hidden" name="sellPrdtBcode" value="${l.sellPrdtBcode}"/>
				</c:forEach>
				<div class='recomm_wrap'>
					<c:choose>
					<c:when test="${isLogin}">
						<h2 class='tit_record'>${user.userName}님.<span>을 위한</span><br>추천</h2>
					</c:when>
					<c:otherwise>
						<h2 class='tit_record'>회원님<span>을 위한</span><br>추천</h2>
					</c:otherwise>
					</c:choose>
					<h3>좋아할 최신앨범</h3>
					<c:forEach items="${listRecobell}" var="l" varStatus="st" begin="0" end="4" >
					<div class='album_recomm' <c:if test="${st.index ne '0'}">style="display:none;"</c:if>>
						<span>
							<c:if test="${l.sellPrdtGbn eq 'P' || l.sellPrdtGbn eq 'G'}">
								<ui:image src="${l.productImageUrl}" server="product" alt="${fn:escapeXml(l.prdtName)}"/>
							</c:if>
							<c:if test="${l.sellPrdtGbn eq 'R'}">
								<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
							</c:if>
							<c:if test="${l.sellPrdtGbn eq 'D'}">
								<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
							</c:if>
						</span>
						<div class='desc_recomm'>
							<h4>${l.prdtName}</h4>
							<em class='rec_prc font_t'><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></em>
							<c:if test="${not empty rate}">
							<em class='rec_per font_t'>${rate}%</em>
							</c:if>
						</div>
						<a href="javascript:;" class="MB_MAIN_MUSIC_7" onclick="location.href='/p/${l.sellPrdtBcode}?foo=bar&rccode=mo_main2';return false;"></a>
					</div>
					</c:forEach>
					<ul class='list_recomm clear'>
					</ul>
					<div class='seemore_wrap'>
						<i><img src="../../images/biz/common/ico_refresh.png" alt="새로고침"></i>
						<p><span>연관 추천</span> 새로보기</p><small class='font_t'><b id="rcPage">1</b>&nbsp;/&nbsp;</small><small id="rcTotalPage">${totalPage}</small>
						<a href="javascript:" class="btn_change MB_MAIN_MUSIC_7_2" id="pdBtn" onclick="recobelTemplet(false);"></a>
					</div>
				</div>
				<!-- //맞춤추천 -->
				<!-- 뮤직매거진 -->
				<div class='magazine_wrap'>
					<h2 class='tit_record'>뮤직매거진</h2>
					<a href="/m/biz/idol/news" class='btn_genre MB_MAIN_MUSIC_8'><img src="../../images/biz/common/arrow_wh_L.png" alt="다음 장르"></a>
	                <c:forEach items="${idolNews}" var="l"  begin="11" end="11" varStatus="st">
					<div class="music_mag">
						<span><img src="${l.image }" alt=""></span>
						<h3>${l.title }</h3>
						<em class='font_ns'>${l.pubdt}</em>
						<a href="/m/biz/idol/newsDetail?cntid=${l.cntid }" class="MB_MAIN_MUSIC_8_1"></a>
					</div>
					</c:forEach>
					<div class="swiper-container mag-container">
					    <div class="swiper-wrapper">
					    <c:forEach items="${idolNews}" var="l" varStatus="st" begin="0" end="9">
					      <div class="swiper-slide">
						      <i style="background:url('${l.image }') center top no-repeat; background-size:cover;"></i>
							  <div class="desc_magazine">
							  	 <h4>${l.title } </h4>
							  	 <span><strong class="font_ns">${l.pubdt}</strong></span>
							  </div>
							  <a href="/m/biz/idol/newsDetail?cntid=${l.cntid }" class="MB_MAIN_MUSIC_8_2"></a>
					      </div>
					      </c:forEach>
					    </div>
						<!-- 스크롤바 -->
    					<div class="swiper-scrollbar"></div>
					  </div>
				</div>
				<!-- //뮤직매거진 -->
				<!-- 컬처이벤트 -->
				<c:if test="${not empty cultureEventListBnr}">
				<div class="culture_wrap">
					<h2 class='tit_record'>컬처 이벤트</h2>
					<a href="/m/biz/hot/eventMain" class='btn_genre MB_MAIN_MUSIC_9'><img src="../../images/biz/common/arrow_wh_L.png" alt="다음 장르"></a>
					<div class="swiper-container culture-container">
					    <div class="swiper-wrapper">
						<c:forEach items="${cultureEventListBnr}" var="l" varStatus="status">
					      <div class="swiper-slide">
						      <i style="background:url('http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.eventImageUrl}') center top no-repeat; background-size:cover;"></i>
							  <div class="desc_magazine">
							  	 <h4>${l.eventTitle}</h4>
							  	 <span class="font_t mt10"><ui:mask pattern="####.##.##">${l.eventStartDt}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.eventEndDt}</ui:mask></span>
							  </div>
							  <a href="/m/biz/eventDetail?eventId=${l.eventId}" class="MB_MAIN_MUSIC_9_1"></a>
					      </div>
						</c:forEach>
					    </div>
						<!-- 스크롤바 -->
    					<div class="swiper-scrollbar"></div>
					  </div>
				</div>
				</c:if>
				<!-- //컬처이벤트 -->
				<!-- 팬사인회 -->
				<div class="sign_wrap">
					<h2 class='tit_record'>팬사인회</h2>
					<a href="/m/help/signMain" class='btn_genre MB_MAIN_MUSIC_10'><img src="../../images/biz/common/arrow_wh_L.png" alt="다음 장르"></a>
					<ul class='list_schedule'>
					<c:forEach items="${listSign}" var="l" varStatus="status">
						<li class="MB_MAIN_MUSIC_10_1">
							<h3>${l.deptname}</h3>
							<p>${l.title }</p>
							<span class='font_t'><ui:mask pattern="####.##.##">${l.startdate}</ui:mask> ~ <ui:mask pattern="####.##.##">${l.enddate}</ui:mask></span>
							<a href="/m/help/signDetail?boardseq=${l.boardseq}"></a>
						</li>
					</c:forEach>
					</ul>
				</div>
				<!-- //팬사인회 -->
				<!-- 탑골공원 -->
				<div class="tapgol_wrap">
					<!-- 활성화된 슬라이드의 첫 이미지가 배경 -->
					<span class='bg_wrap'><ui:image prdtGbn="${mdBnrList[0].sellPrdtGbn}" rcrdCd="${mdBnrList[0].rcrdCd}" ratingCode="A" alt="${fn:escapeXml(mdBnrList[0].prdtName)}"/></span>
					<p class='bg_tapgol'></p>
					<div class="swiper-container tapgol-container">
						<div class="swiper-wrapper">
						<c:forEach varStatus="s1" begin="1" end="5"> 
					        <c:if test="${s1.index eq 1}"><c:set var="list" value="${md1stList}"/></c:if>
                            <c:if test="${s1.index eq 2}"><c:set var="list" value="${md2ndList}"/></c:if>
                            <c:if test="${s1.index eq 3}"><c:set var="list" value="${md3rdList}"/></c:if>
                            <c:if test="${s1.index eq 4}"><c:set var="list" value="${md4thList}"/></c:if>
                            <c:if test="${s1.index eq 5}"><c:set var="list" value="${md5thList}"/></c:if>
                            <c:if test="${not empty list}">
								<div class="swiper-slide">
									<div class="tapgol_a">
									<c:forEach items="${list}" varStatus="s2" var="l" begin="0" end="2">
									<c:if test="${s2.index eq 0}">
									<div class="tit_tapgol">
	                                    <h3>${list[s2.index].title}</h3>
	                                </div>
									</c:if>
									<a href="/m/record/detail/${l.sellPrdtBcode}" class="MB_MAIN_MUSIC_11">
										<i><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></i>
										<div class='desc_tapgol'>
											<span>${fn:escapeXml(l.artiName)}</span>
											<h2>${fn:escapeXml(l.basePrdtName)}</h2>
										</div>
									</a>
									</c:forEach>
									</div>
								</div>
                            </c:if>
						</c:forEach>
						</div>
						<!-- 스크롤바 -->
						<div class="swiper-scrollbar"></div>
				    </div>
				</div>
				<!-- //탑골공원 -->
            </div>
<!-- /////////상단 롤링 배너 레이어///////// -->
<c:if test="${not empty mainRollBnrList and fn:length(mainRollBnrList) > 0}">
	<div id="layer_banner_r">
		<div class="layer_banner_top">
			<h2>전체보기</h2>
			<a href="javascript:;" class="btn_close">닫기</a>
		</div>
		<div class="layer_wrap">
			<div class="layer_cont">
				<ul>
					<c:forEach items="${mainRollBnrList}" var="l" varStatus="st">
	                    <c:if test="${l.signWayGbn eq 'C1451'}">
	                    <li class="type01">
							<a href='${l.bnrLnkUrl}'><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/></a>
						</li>
						</c:if>
						<c:if test="${l.signWayGbn eq 'C1452'}">
						<li class="type02">
	                           <a href='${l.bnrLnkUrl}'>
	                               <h2>${l.bnrTitle}</h2>
	                           </a>
	 						  <div class='slide_circle'>
	 							  <span class="ico_badge on">
	 								  <ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" />
	 							  </span>
	 						  </div>
 						  </li>
	                    </c:if>
						<c:if test="${l.signWayGbn eq 'C1453'}">
						<li class="type03">
	                          <a href='${l.bnrLnkUrl}'>
	                              <h2>${l.bnrTitle}</h2>
	                              <span>${l.bnrSubTitle}</span>
								  <div class='slide_circle'>
									  <span class="ico_badge on">
										  <ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/>
									  </span>
								  </div>
	                          </a>
						  </li>
	                    </c:if>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</c:if>
<!--// 상단 롤링 배너 레이어 -->