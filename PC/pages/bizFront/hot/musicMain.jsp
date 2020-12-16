<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<head>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="none"/>
<script type="text/javascript" src="/js/biz/m_hott.js?${tmpKey}"></script>
<script type="text/javascript">
$(document).ready(function() {
	topMenu();//gnb
	recordSlide(); //main record
	footerFn();
	
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
    var html = "<div class='plus_inner'><a href='javascript:' class='btn_plus'><img src='../../images/biz/sub/record/ico_plus.png' alt='더보기'></a></div>";
    $(".pagination_wrap .swiper-pagination-fraction").append(html);
    console.log(html);
});
</script>
<title>음반 메인 - NEW ME HOTTRACKS</title>
</head>
            <div class='record_wrap'>
				<!-- 음반배너 -->
                <div class="swiper-container bnr-container">
                    <div class="swiper-wrapper">
                    <c:forEach items="${mainRollBnrList}" var="l" varStatus="st">
						<c:if test="${l.SIGN_WAY_GBN eq 'C1451'} }">
							<div class="swiper-slide"><a href='${l.bnrLnkUrl}'><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" clazz="prdt-photo"/></a></div>
						</c:if>
						<c:if test="${l.SIGN_WAY_GBN eq 'C1452'} }">
	                       <div class="swiper-slide">
	                           <a href='${l.bnrLnkUrl}'>
	                               <h2>${l.bnrTitle}</h2>
	                           </a>
	 						  <div class='slide_circle'>
	 							  <span class="ico_badge on">
	 								  <ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" clazz="prdt-photo"/>
	 							  </span>
	 						  </div>
	                       </div>
	                    </c:if>
						<c:if test="${l.SIGN_WAY_GBN eq 'C1453'} }">
	                      <div class="swiper-slide">
	                          <a href='${l.bnrLnkUrl}'>
	                              <h2>${l.bnrTitle}</h2>
	                              <span>${l.bnrSubTitle}</span>
	                          </a>
							  <div class='slide_circle'>
								  <span class="ico_badge on">
									  <ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" clazz="prdt-photo"/>
								  </span>
							  </div>
	                      </div>
	                    </c:if>
                    </c:forEach>
                    <div class="swiper-slide"><a href='javascript:'><img src="../../images/biz/sub/record/bnr_03.png" alt="배너1"></a></div>
                    <div class="swiper-slide"><a href='javascript:'><img src="../../images/biz/sub/record/bnr_03.png" alt="배너1"></a></div>
                    </div>
                    <!-- Add Pagination -->
                    <div class='pagination_wrap font_t'>
                        <div class="swiper-pagination"></div>
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
					<a href="javascript:" class='btn_genre'><img src="../../images/biz/common/arrow_wh_L.png" alt="다음 장르"></a>
					<ul class='list_type clear'>
						<!-- 활성화된 li에 class='on' -->
						<li class='on'><i></i><a href="#prod01">가요</a></li>
						<li class=''><i></i><a href="#prod02">팝</a></li>
						<li class=''><i></i><a href="#prod03">클래식</a></li>
						<li class=''><i></i><a href="#prod04">영상</a></li>
					</ul>
					<c:forEach varStatus="s1" begin="1" end="4"> 
					<div class="swiper-container album-container">
					        <c:if test="${s1.index eq 1}"><c:set var="list" value="${reServeBnrListSong}"/></c:if>
                            <c:if test="${s1.index eq 2}"><c:set var="list" value="${reServeBnrListPop}"/></c:if>
                            <c:if test="${s1.index eq 3}"><c:set var="list" value="${reServeBnrListClassic}"/></c:if>
                            <c:if test="${s1.index eq 4}"><c:set var="list" value="${reServeBnrListDvd}"/></c:if>
				      <div id="prod0${s1.index}" class="swiper-wrapper">
				      <c:forEach items="${list}" var="l">
				        <div class="swiper-slide">
							<div  class='album_wrapper'>
								<div class='album_inner'>
                                   <ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
									<span class='font_t'>
									<fmt:parseDate var="sDate" value="${l.regstDtm}" pattern="yyyyMMdd" />
							        <fmt:parseNumber value="${sDate.time / (1000*60*60*24)}" integerOnly="true" var="isDate" scope="request" />
							        <fmt:parseDate var="tDate" value="${date}" pattern="yyyyMMdd" />
							        <fmt:parseNumber value="${tDate.time / (1000*60*60*24)}" integerOnly="true" var="itDate" scope="request" />
								        <c:if test="${(isDate-itDate) eq 0 }">D-DAY</c:if>
										<c:if test="${(isDate-itDate) eq 1 }">D-1</c:if>
										<c:if test="${(isDate-itDate) eq 2 }">D-2</c:if>
									</span>
								</div>
								<div class='album_brief'>
									<p>[발매일:<fmt:formatDate value = "${l.regstDtm}" pattern = "MM월dd일" var = "date"/>]</p>
									<h2>${fn:escapeXml(l.artiName)}</h2>
									<h3>${fn:escapeXml(l.basePrdtName)}</h3>
									<span class='font_t'><fmt:formatNumber type="number">${l.lastDcPrice }</fmt:formatNumber></span>
									<c:if test="${l.prdtSellPrice ne l.lastDcPrice}"><em class='font_t'><fmt:parseNumber integerOnly="true">${hfn:rate(l.prdtSellPrice, l.lastDcPrice)}</fmt:parseNumber>%</em></c:if>
								</div>
							</div>
							<a href="/m/record/detail/${l.sellPrdtBcode}" class='album_link'></a>
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
					<a href="javascript:" class='btn_genre'><img src="../../images/biz/common/arrow_wh_L.png" alt="다음 장르"></a>
					<ul class='list_type clear'>
						<!-- 활성화된 li에 class='on' -->
						<li class='on'><i></i><a href="#prod05">가요</a></li>
						<li class=''><i></i><a href="#prod06">팝</a></li>
						<li class=''><i></i><a href="#prod07">클래식</a></li>
						<li class=''><i></i><a href="#prod08">영상</a></li>
					</ul>
					<c:forEach varStatus="s1" begin="5" end="8"> 
					<div class="swiper-container recent-container">
					        <c:if test="${s1.index eq 5}"><c:set var="list" value="${listSong}"/></c:if>
                            <c:if test="${s1.index eq 6}"><c:set var="list" value="${listPop}"/></c:if>
                            <c:if test="${s1.index eq 7}"><c:set var="list" value="${listClassic}"/></c:if>
                            <c:if test="${s1.index eq 8}"><c:set var="list" value="${listDvd}"/></c:if>
				      <div id="prod0${s1.index}"  class="swiper-wrapper">
				      <c:forEach items="${list}" var="l">
				        <div class="swiper-slide">
							<div class='album_wrapper'>
								<div class='album_inner'>
	                                <ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/>
								</div>
								<div class='album_brief'>
									<h2>${fn:escapeXml(l.artiName)}<br>${fn:escapeXml(l.basePrdtName)}</h2>
									<span class='font_t'><fmt:formatNumber type="number">${l.lastDcPrice }</fmt:formatNumber></span>
									<c:if test="${l.prdtSellPrice ne l.lastDcPrice}"><em class='font_t'><fmt:parseNumber integerOnly="true">${hfn:rate(l.prdtSellPrice, l.lastDcPrice)}</fmt:parseNumber>%</em></c:if>
								</div>
							</div>
							<a href="/m/record/detail/${l.sellPrdtBcode}" class='album_link'></a>
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
					<a href="javascript:" class='btn_genre'><img src="../../images/biz/common/arrow_wh_L.png" alt="다음 장르"></a>
					<ul class='list_type clear'>
						<!-- 활성화된 li에 on : class 추가 -->
						<li class='on'><i></i><a href="#prod09">음반</a></li>
						<li class=''><i></i><a href="#prod10">영상</a></li>
					</ul>
					<ul id="prod09" class='list_realtime'>
					<c:forEach items="${list1}" var="l"  begin="0" end="4" varStatus="st">
						<li>
							<strong class='font_t'>${st.index+1}</strong>
							<i><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></i>
							<div class='desc_real'>
<%-- 								<c:if test=""><span class='flg1'>지관통+포스터 증정</span></c:if><c:if test=""><span class='flg2'>예약</span></c:if> --%>
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
						<li>
							<strong class='font_t'>${st.index+1}</strong>
							<i><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></i>
							<div class='desc_real'>
<%-- 								<c:if test=""><span class='flg1'>지관통+포스터 증정</span></c:if><c:if test=""><span class='flg2'>예약</span></c:if> --%>
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
						<li>
							<span><ui:image src="${l.imageUrl}" alt="${l.eventTitle}" /></span>
							<div class='desc_realbnr'>
								<h2>${fn:escapeXml(l.eventTitle) }</h2>
								<p>${fn:escapeXml(l.eventDtlCont)}</p>
							</div>
							<a href="/m/hot/eventDetail?eventId=${l.eventId}"></a>
						</li>
						</c:forEach>
					</ul>
				</div>
				<!-- //실시간차트 -->
				<!-- 맞춤추천 -->
				<div class='recomm_wrap'>
					<c:choose>
					<c:when test="${isLogin}">
						<h2 class='tit_record'>${user.userName}님.<span>을 위한</span><br>추천</h2>
					</c:when>
					<c:otherwise>
						<h2 class='tit_record'>고객님<span>을 위한</span><br>추천</h2>
					</c:otherwise>
					</c:choose>
					<h3>좋아할 최신앨범</h3>
					<div class='album_recomm'>
					<c:if test="${isLogin}">
						<c:forEach items="${listRecobell}" var="l" varStatus="st">
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
						<a href="javascript:;" onclick="location.href='/p/${l.sellPrdtBcode}?foo=bar&rccode=mo_main1';return false;"></a>
						</c:forEach>
					</c:if>
					</div>
					<ul class='list_recomm clear'>
					<c:forEach items="${listRecobell}" var="l" varStatus="st" begin="1" end="3">
						<li>
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
							<div class='desc_recomm lst_desc'>
								<h4>${l.prdtName}</h4>
								<em class='rec_prc font_t'><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></em>
								<c:if test="${not empty rate}">
								<em class='rec_per font_t'>${rate}%</em>
								</c:if>
							</div>
							<a href="javascript:;" onclick="location.href='/p/${l.sellPrdtBcode}?foo=bar&rccode=mo_main1';return false;"></a>
						</li>
					</c:forEach>
					</ul>
					<div class='seemore_wrap'>
						<i><img src="../../images/biz/common/ico_refresh.png" alt="새로고침"></i>
						<p><span>연관 추천</span> 새로보기</p><small class='font_t'><b>1</b>&nbsp;/&nbsp;12</small>
						<a href="javascript:"></a>
						<a href="javascript:;" class="btn_change" id="pdBtn" onclick="munguGift.loadTemplate($('.main_wrapper .pdTitle:visible').next().attr('type'), 'cont08');">
						<span>다른 테마 또 보여줘<em class="font_t"><strong id="pdPage">0</strong>/<font id="pdTotalPage">${totalPage}</font></em></span></a>
					</div>
					<a href="javascript:"></a>
				</div>
				<!-- //맞춤추천 -->
				<!-- 뮤직매거진 -->
				<div class='magazine_wrap'>
					<h2 class='tit_record'>뮤직매거진</h2>
					<a href="javascript:" class='btn_genre'><img src="../../images/biz/common/arrow_wh_L.png" alt="다음 장르"></a>
	                <c:forEach items="${idolNews}" var="l"  begin="11" end="11" varStatus="st">
					<div class="music_mag">
						<span><img src="${l.image }" alt="테스트이미지"></span>
						<h3>${l.title }</h3>
						<em class='font_t'>${l.pubdt }</em>
						<a href="/m/idol/newsDetail?cntid=${l.cntid }"></a>
					</div>
					</c:forEach>
					<div class="swiper-container mag-container">
					    <div class="swiper-wrapper">
					    <c:forEach items="${idolNews}" var="l" varStatus="st" begin="0" end="9">
					      <div class="swiper-slide">
						      <i><img src="${l.image }" alt="테스트이미지"></i>
							  <div class="desc_magazine">
							  	 <h4>${l.title } </h4>
							  	 <span class='font_t'>${l.pubdt }</span>
							  </div>
							  <a href="/m/idol/newsDetail?cntid=${l.cntid }"></a>
					      </div>
					      </c:forEach>
					    </div>
						<!-- 스크롤바 -->
    					<div class="swiper-scrollbar"></div>
					  </div>
				</div>
				<!-- //뮤직매거진 -->
				<!-- 컬처이벤트 -->
				<div class="culture_wrap">
					<h2 class='tit_record'>컬처 이벤트</h2>
					<a href="javascript:" class='btn_genre'><img src="../../images/biz/common/arrow_wh_L.png" alt="다음 장르"></a>
					<div class="swiper-container culture-container">
					    <div class="swiper-wrapper">
						<c:forEach items="${cultureEventListBnr}" var="l" varStatus="status">
					      <div class="swiper-slide">
						      <i><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}"/></i>
							  <div class="desc_magazine">
							  	 <h4>${l.bnrTitle}</h4>
							  	 <span class='font_t'>${l.bnrSubTitle}</span>
							  </div>
							  <a href="javascript:"></a>
					      </div>
						</c:forEach>
					    </div>
						<!-- 스크롤바 -->
    					<div class="swiper-scrollbar"></div>
					  </div>
				</div>
				<!-- //컬처이벤트 -->
				<!-- 팬사인회 -->
				<div class="sign_wrap">
					<h2 class='tit_record'>팬사인회</h2>
					<a href="javascript:" class='btn_genre'><img src="../../images/biz/common/arrow_wh_L.png" alt="다음 장르"></a>
					<ul class='list_schedule'>
					<c:forEach items="${listSign}" var="l" varStatus="status">
						<li>
							<h3>${l.deptname}</h3>
							<p>${l.title }</p>
							<span class='font_t'><ui:mask pattern="####/##/##">${l.startdate}</ui:mask> ~ <ui:mask pattern="####/##/##">${l.enddate}</ui:mask></span>
							<a href="/m/help/signDetail?boardseq=${l.boardseq}"></a>
						</li>
					</c:forEach>
					</ul>
				</div>
				<!-- //팬사인회 -->
				<!-- 탑골공원 -->
				<div class="tapgol_wrap">
					<!-- 활성화된 슬라이드의 첫 이미지가 배경 -->
					<span class='bg_wrap'><ui:image prdtGbn="${mainRollBnrList[0].sellPrdtGbn}" rcrdCd="${mainRollBnrList[0].rcrdCd}" ratingCode="A" alt="${fn:escapeXml(mainRollBnrList[0].prdtName)}"/></span>
					<p class='bg_tapgol'></p>
					<div class="tit_tapgol">
						<h3>추억의 인기가요</h3>
						<h2>온라인 탑골공원 ♥</h2>
					</div>
					<div class="swiper-container tapgol-container">
				      <div class="swiper-wrapper">
				      <c:forEach items="${mainRollBnrList}" var="l" varStatus="status">
				        <div class="swiper-slide">
							<i><ui:image prdtGbn="${l.sellPrdtGbn}" rcrdCd="${l.rcrdCd}" ratingCode="A" alt="${fn:escapeXml(l.prdtName)}"/></i>
							<div class='desc_tapgol'>
								<span>${fn:escapeXml(l.artiName)}</span>
								<h2>${fn:escapeXml(l.basePrdtName)}</h2>
							</div>
							<a href="/m/record/detail/${l.sellPrdtBcode}"></a>
						</div>
				      </c:forEach>
<!-- 				        <div class="swiper-slide"> -->
<!-- 							<i><img src="../../images/biz/sub/record/bg_test.png" alt="테스트이미지"></i> -->
<!-- 							<div class='desc_tapgol'> -->
<!-- 								<span>CHEN(첸)</span> -->
<!-- 								<h2>사월, 그리고 꽃: FLOWER<br> VER [미니 1집]</h2> -->
<!-- 							</div> -->
<!-- 							<a href="javascript:"></a> -->
<!-- 						</div> -->
				      </div>
					  <!-- 스크롤바 -->
  					<div class="swiper-scrollbar"></div>
				    </div>
				</div>
				<!-- //탑골공원 -->
            </div>

