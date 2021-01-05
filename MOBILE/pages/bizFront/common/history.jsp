<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>

<ui:decorator name="none"/>
<script type="text/javascript">
var likeFlag = "true";
jQuery(function($){	
	
	// history 페이지 close
    $('.btn_close').on('click', function(){//history close
    	
	    $.ajax({
	        type: "POST"
	        ,url: "/m/biz/quickmenu"
	        ,dataType: "html"
	        ,success : function(html){
	            //$("body").append(html);	
	            gnbClose();
	            TweenLite.to($('#header .dim'),0.7,{ease:Power4.easeOut,opacity:0,onComplete:function(){
	                $('#header .dim').remove();
	            }})
	            TweenLite.to($('#history_wrapper'),0.6,{ease:Power4.easeOut,left:'100%'});

                //편집모드라면 편집취소
                if($('#btn_edit').hasClass('cancel')){
                	$('.txt_blue').trigger("click");
                }
	        } 
	        ,error: function(data) {
	        }
	    });
    	
    });	
    
	// 최근 본 상품 필터값 설정시
    $('.history_inner .list_kind li').click(function(){
    	$(this).toggleClass('active');
    	
    	// 1. 클릭한 구분값 처리
    	var gbnLen = $('#filterDiv li').length;
    	var gbnActiveLen = $('#filterDiv .active').length;
    	    	
    	// 활성화된 필터값이 있을 경우
    	if(gbnActiveLen > 0){    		    		
    		for(var i=0; i<gbnLen; i++){
        		// 구분값이 활성화되어 있을 경우 구분값을 가져옴
        		if($('.category_type li:eq('+i+')').hasClass("active")){
        			var gbnNm = $('.category_type li:eq('+i+')').find('i').attr('class');
        			gbnNm = gbnNm.substr(0,5);        			
        			$("."+gbnNm).removeClass('hide');
        		}else{
        			var gbnNm = $('.category_type li:eq('+i+')').find('i').attr('class');
        			gbnNm = gbnNm.substr(0,5);
        			$("."+gbnNm).addClass('hide');
        		}               		
        	}
    	}else{	// 모든 필터값이 비활성화일경우
    		$('.box_history ul li').removeClass('hide');	
    	}
    	
		var listLiLen = $('.box_history li').length;	// 리스트 아이템 수
		var listActiveLen = $('.box_history .hide').length;		// 감춰진 아이템 수
		
		if(listLiLen == listActiveLen){        			
// 			$('.vacant_history').show();
			$('#rcnt_vacant').show();
			$('.box_history').hide();
		}else{
// 			$('.vacant_history').hide();
			$('#rcnt_vacant').hide();
			$('.box_history').show();
		}
    	    	    	
    	// 날짜별 영역 컨트롤
    	fn_dayByDayControl();
    });
    
 	// [최근 본 상품] 클릭시
 	$('.btn_histShop').on('click', function(){
 		$(this).addClass('active');
 		setRcntItemList();
 	});
 	
 	// [좋아요] 클릭시
	$('.btn_histGood').on('click', function(){
		
		if(likeFlag == "true"){		
			loadTemplate("product","R");	// [좋아요] 상품 조회, 최신등록순
			likeFlag = "false";
		}
	
		$('.btn_histGood').addClass('active');
		$('.btn_histShop').removeClass('active');
		$('#recentDiv').hide();
		$('#likeDiv').show();
		$('#recentListDiv').hide();
 		$('#likeListDiv').show(); 		
		$('.txt_blue').hide();
		$(".history_inner").addClass('like_inner');
		$('#rcnt_vacant').hide();
	});
 	
	// [좋아요] > [상품] 클릭시
	$('.productLi').on('click', function(){
		$(this).addClass('on');
		$('.brandLi').removeClass('on');
		$('#likeListDiv').attr('class','topValue');
// 		$('.vacant_history').hide();
		$('#rcnt_vacant').hide();
	});
	
	// [좋아요] > [브랜드] 클릭시
	$('.brandLi').on('click', function(){
		$(this).addClass('on');
		$('.productLi').removeClass('on');
		$('#likeListDiv').attr('class','leftValue');
// 		$('.vacant_history').hide();
		$('#rcnt_vacant').hide();
	});
	
});

//편집 이벤트
function Fn_edit(){
	if($('#btn_edit').hasClass('edit')){  		
		$('#btn_edit').attr('class','cancel');
		$('#btn_edit').text('취소');
		$('#editDiv').show();
		$('#filterDiv').hide();
		
		$(".history_inner").find('.box_history li').addClass('chk_off');
		$(".history_inner").find('.box_history li').append("<a href='javascript:' class='chk_delete'></a>");
		
		historyDelete();
	}else{
		$('#btn_edit').attr('class','edit');
		$('#btn_edit').text('편집');
		$('#editDiv').hide();
		$('#filterDiv').show();
		
		$(".history_inner").find('.box_history li').removeClass('chk_on');
		$(".history_inner").find('.box_history li').removeClass('chk_off');
		$('a').remove('.chk_delete');
	}     
}

function setRcntItemList(){		
		var listLiLen = $('.box_history li').length;	// 리스트 아이템 수
 		if(listLiLen > 0){
 	 		$('.txt_blue').show();
 	 		$(".history_inner").removeClass('like_inner');
 	 		$('#recentDiv').show();
 		}else{
			$('.txt_blue').hide();
			$(".history_inner").addClass('like_inner');
// 			$('.vacant_history').show();
			$('#rcnt_vacant').show();
			$('#recentDiv').hide();
 		}
	 		$('.btn_histGood').removeClass('active'); 	 		
 	 		$('#likeDiv').hide();
 	 		$('#recentListDiv').show();
 	 		$('#likeListDiv').hide();
//  	 		histSwiper.onResize();
}

// 최근 본 상품 삭제
function Fn_bizRcntItemDel(target){
	
	if("A" == target){
		$(".box_history li").addClass("chk_on");		
	}
	
    if($(".history_inner").find(".box_history li.chk_on").length > 0){    	
        if(confirm("해당 최근 본 상품을 삭제하시겠습니까?")){
            var arr1 = new Array();
            var arr2 = new Array();
            var arr3 = new Array();
            var arr4 = new Array();
            var arr5 = new Array();
                       
            $(".history_inner").find(".box_history li.ic_01.chk_on").each(function(){
            	arr1.push($(this).find("[name=sellPrdtBcode]").val());                
            });
            $(".history_inner").find(".box_history li.ic_02.chk_on").each(function(){
            	arr2.push($(this).find("[name=sellPrdtBcode]").val());
            });
            $(".history_inner").find(".box_history li.ic_03.chk_on").each(function(){
            	arr3.push($(this).find("[name=sellPrdtBcode]").val());
            });
            $(".history_inner").find(".box_history li.ic_04.chk_on").each(function(){
            	arr4.push($(this).find("[name=sellPrdtBcode]").val());        	
            });
            $(".history_inner").find(".box_history li.ic_05.chk_on").each(function(){
            	arr5.push($(this).find("[name=sellPrdtBcode]").val());
            });            
                        
            $.ajax({
                type: 'POST'
                ,url: '/m/biz/removeRecentProduct'
                ,data: {ic01Data:arr1.join(",")
                		, ic02Data:arr2.join(",")
	                	, ic03Data:arr3.join(",")
	                	, ic04Data:arr4.join(",")
	                	, ic05Data:arr5.join(",")
                		}
                ,async: false
                ,dataType: 'json'
                ,success: function(data) {
                    var delList = data.delList.split(",");
                    for(var i=0 in delList){                    	
                    	// li 지우기                    	                    	
                    	$("input:hidden[name=sellPrdtBcode]:input[value="+delList[i]+"]").closest("li").remove();
                    }
                    fn_dayByDayControl();
                    setRcntItemList();
                  	//편집모드 해제
                	$('.txt_blue').trigger("click");
                }
                ,error: function(data) {
                    alert('<fmt:message key="error.common.system"/>');
                }
            });            
        }
    }else{
        alert("선택하신 상품이 없습니다. 최근 본 상품에서 삭제하실 상품을 클릭해주세요.");
    }
}

function fn_dayByDayControl(){
	for(var j=0; j<7; j++){  
		var listLen = $('#listRecent'+j+' li').length;
		var hideLen = $('#listRecent'+j+' .hide').length;
		    		
		if(listLen == hideLen){
			$('#listRecent'+j).hide();
		}else{
			$('#listRecent'+j).show();
		}
	}	
}

// [좋아요] - 상품, 브랜드 조회 (최신등록순:R, 마감임박순:T, 인기순:T)
function loadTemplate(target, productOrderBy, page){
	
	if(page == null || page == "undefined"){
		page = 1;
	}
	
	$.ajax({
        type: "POST"
        ,url: "/m/biz/history/likeGoodsTemplate"
        ,data: {  target : target, productOrderBy : productOrderBy, page : page }
        ,dataType: "html"
        ,success : function(data){
            
      		$("#listDiv").empty();
        	$("#listDiv").append(data);    
        	
//         	histSwiper.onResize();
        	
        	$(".swiper-wrapper").css('transform','translate3d(0px, 0px, 0px)');
        }
        ,error: function(data) {        	
            alert('<fmt:message key="error.common.system"/>');
        }
    });    
}
</script>
<div id="history_wrapper">
	<!-- 
	<div class="swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
			 -->
				<div class="top_header">
					<a href="javascript:;" class="btn_close">닫기</a>
					<h2>히스토리</h2>
				</div>
				<div class="history_inner category_wrap">
					<div class="category_type">
						<a href="javascript:" class='btn_histShop active'>최근 본 쇼핑정보</a>
						<a href="javascript:" class='btn_histGood'>좋아요</a>						
						<div class="txt_blue" onclick="Fn_edit(); return false;">
							<a href="javascript:"><em class='edit' id="btn_edit">편집</em></a>
						</div>								
						<p class='bott_border'></p>												
						<div id="recentDiv">						
							<div id="filterDiv">											
								<ul class='list_kind clear'>
									<c:if test="${not empty listRecent}">	
										<c:forEach items="${listRecent}" var="l" varStatus="st">
											<c:if test='${l.rcntGbn eq "ic_01"}'>
												<li class="<c:if test='${l.rcntGbnYn eq \"Y\"}'>active</c:if>"><!-- 활성화시, active : class 추가 -->
													<i class='ic_01'></i><!-- 순서대로 ic_01 ~ 05 -->
													<span>상품</span>
													<a href="javascript:"></a>
												</li>
											</c:if>
											<c:if test='${l.rcntGbn eq "ic_02"}'>										
												<li class="<c:if test='${l.rcntGbnYn eq \"Y\"}'>active</c:if>">
													<i class='ic_02'></i>
													<span>검색</span>
													<a href="javascript:"></a>
												</li>
											</c:if>
											<c:if test='${l.rcntGbn eq "ic_03"}'>
												<li class="<c:if test='${l.rcntGbnYn eq \"Y\"}'>active</c:if>">
													<i class='ic_03'></i>
													<span>기획전</span>
													<a href="javascript:"></a>
												</li>
											</c:if>
											<c:if test='${l.rcntGbn eq "ic_04"}'>
												<li class="<c:if test='${l.rcntGbnYn eq \"Y\"}'>active</c:if>">
													<i class='ic_04'></i>
													<span>이벤트</span>
													<a href="javascript:"></a>
												</li>
											</c:if>
											<c:if test='${l.rcntGbn eq "ic_05"}'>
												<li class="<c:if test='${l.rcntGbnYn eq \"Y\"}'>active</c:if>">
													<i class='ic_05'></i>
													<span>브랜드</span>
													<a href="javascript:"></a>
												</li>
											</c:if>
										</c:forEach>
									</c:if>	
								</ul>
							</div>
							<div id="editDiv" style="display: none">
								<ul class='list_erase clear'>
									<li>
										<img src="/images/biz/common/chk_black.png" alt="선택삭제">
										<span>선택삭제</span>
										<a href="javascript:" onclick="Fn_bizRcntItemDel('P');return false;"></a>
									</li>
									<li>
										<img src="/images/biz/common/ic_delete.png" alt="전체삭제">
										<span>전체삭제</span>
										<a href="javascript:" onclick="Fn_bizRcntItemDel('A');return false;"></a>
									</li>
								</ul>						
							</div>
						</div>
						<div id="likeDiv" style="display: none">
							<ul class='list_history clear'><!-- 활성화시, li에 on : class 추가 -->
								<li class='productLi on'><a href="javascript:" onclick="loadTemplate('product','R'); return false;">상품</a></li>
								<li class='brandLi'><a href="javascript:" onclick="loadTemplate('brand','R'); return false;">브랜드</a></li>								
							</ul>
						</div>												
					</div>
					
					<div id="recentListDiv">
						<c:choose>
							<c:when test="${empty listRecent0 && empty listRecent1 && empty listRecent2 && empty listRecent3 && empty listRecent4 && empty listRecent5 && empty listRecent6}">								
								<script type="text/javascript">
									$('.txt_blue').hide();
									$(".history_inner").addClass('like_inner');
// 									$('.vacant_history').show();
									$('#rcnt_vacant').show();
									$('#recentDiv').hide();
								</script>	
							</c:when>
							<c:otherwise>														
								<c:if test="${not empty listRecent0}">											
									<div class="box_history pd_list" id="listRecent0">
										<h4 class='tdy font_t'>Today</h4>
										<ul class='catalog_history'>
											<c:forEach items="${listRecent0}" var="l" varStatus="st">																
												<li class='${l.rcntGbn} <c:if test="${fn:contains('P,G,S', l.sellPrdtGbn)}">																		
																			<c:if test="${l.prdtStatCode eq 'C0313' || l.prdtStatCode eq 'C0314' || l.prdtStatCode eq 'C0315'}">sold_out</c:if>																		
																		</c:if>
																		<c:if test="${fn:contains('R,D,C', l.sellPrdtGbn)}">																		
																			<c:if test="${l.rcrdStat eq '2' || l.rcrdStat eq '3' || l.rcrdStat eq '4'}">sold_out</c:if>
																		</c:if>
																		<c:if test="${l.prdtStatCode eq 'N'}">sold_out</c:if>'>
													<input type="hidden" name="sellPrdtBcode" value="${l.sellPrdtBcode}"/>													
													<c:if test="${l.rcntGbn eq 'ic_01'}">
														<a href="/p/${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_02'}">
														<a href="/m/biz/search/searchMain?searchTerm=${l.prdtName}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_03'}">
														<a href="/m/biz/eventDetail?eventId=${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_04'}">
														<a href="/m/biz/eventDetail?eventId=${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_05'}">
														<a href="/m/biz/hot/brandDetail?brandId=${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>																																				
														<c:choose>
															<c:when test="${l.rcntGbn eq 'ic_01'}">
																<i>
																	<c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><ui:image src="${l.productImageUrl}" server="product" size="150" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																	<c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																	<c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																</i>																												
																<div class="desc_type01">
																	<h2>${fn:escapeXml(l.prdtName)}</h2>
																	<p>
																		<fmt:parseNumber var="rate" integerOnly="true" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
																		<span class='font_t percent'><c:if test="${rate > 0}">${rate}%</c:if></span>
																		<span class='font_t'><fmt:formatNumber type="number" value="${l.lastCpnPrice}"/></span>
																	</p>
																</div>
															</c:when>
															<c:otherwise>
																<div class="desc_type02">
																	<h2>${fn:escapeXml(l.prdtName)}</h2>
																</div>
															</c:otherwise>
														</c:choose>													
													</a>
													<a href="javascript:" class='chk_delete'></a>
													<c:if test="${l.rcntGbn eq 'ic_01'}">
														<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt ne '0'}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_05'}">
														<a href="javascript:" onclick="addBizWishBrand('${l.sellPrdtBcode}');return false;" class='btn_like<c:if test="${l.wishUserPrdtCnt ne '0'}"> on</c:if> ${l.sellPrdtBcode}' ><span>좋아요</span></a><!-- 활성화시 on : class 추가 -->
													</c:if>
													<div class="run_out <c:if test="${fn:contains('P,G,S', l.sellPrdtGbn)}">
																			<c:if test="${l.prdtStatCode eq 'C0313'}">out01</c:if>
																			<c:if test="${l.prdtStatCode eq 'C0314' || l.prdtStatCode eq 'C0315'}">out02</c:if>																		
																		</c:if>
																		<c:if test="${fn:contains('R,D,C', l.sellPrdtGbn)}">
																			<c:if test="${l.rcrdStat eq '2'}">out01</c:if>
																			<c:if test="${l.rcrdStat eq '3' || l.rcrdStat eq '4'}">out02</c:if>
																		</c:if>
																		<c:if test="${l.prdtStatCode eq 'N'}">out03</c:if>"><!-- 품절유형 out01 ~ 03 : class 추가 -->
														<span class='out01'>일시<br>품절</span>
														<span class='out02'>품절</span>
														<span class='out03'>종료</span>
													</div>
												</li>
											</c:forEach>										
										</ul>
									</div>									
								</c:if>
								<c:if test="${not empty listRecent1}">
									<div class="box_history pd_list" id="listRecent1">
										<h4 class='lst font_t'><span class='year'>${listRecent1[0].yyyy}</span> ${listRecent1[0].mmdd} <i class='${listRecent1[0].yoil}'></i><!-- sun·mon·tue·wed·thur·fri·sat : class 추가 --></h4>
										<ul class='catalog_history'>
											<c:forEach items="${listRecent1}" var="l" varStatus="st">
												<li class='${l.rcntGbn} <c:if test="${fn:contains('P,G,S', l.sellPrdtGbn)}">																		
																			<c:if test="${l.prdtStatCode eq 'C0313' || l.prdtStatCode eq 'C0314' || l.prdtStatCode eq 'C0315'}">sold_out</c:if>																		
																		</c:if>
																		<c:if test="${fn:contains('R,D,C', l.sellPrdtGbn)}">																		
																			<c:if test="${l.rcrdStat eq '2' || l.rcrdStat eq '3' || l.rcrdStat eq '4'}">sold_out</c:if>
																		</c:if>
																		<c:if test="${l.prdtStatCode eq 'N'}">sold_out</c:if>'>
													<input type="hidden" name="sellPrdtBcode" value="${l.sellPrdtBcode}"/>					
													<c:if test="${l.rcntGbn eq 'ic_01'}">
														<a href="/p/${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_02'}">
														<a href="/m/biz/search/searchMain?searchTerm=${l.prdtName}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_03'}">
														<a href="/m/biz/eventDetail?eventId=${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_04'}">
														<a href="/m/biz/eventDetail?eventId=${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_05'}">
														<a href="/m/biz/hot/brandDetail?brandId=${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>																																						
														<c:choose>
															<c:when test="${l.rcntGbn eq 'ic_01'}">
																<i>
																	<c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><ui:image src="${l.productImageUrl}" server="product" size="150" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																	<c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																	<c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																</i>														
																<div class="desc_type01">
																	<h2>${fn:escapeXml(l.prdtName)}</h2>
																	<p>
																		<fmt:parseNumber var="rate" integerOnly="true" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
																		<span class='font_t percent'><c:if test="${rate > 0}">${rate}%</c:if></span>
																		<span class='font_t'><fmt:formatNumber type="number" value="${l.lastCpnPrice}"/></span>
																	</p>
																</div>
															</c:when>
															<c:otherwise>
																<div class="desc_type02">
																	<h2>${fn:escapeXml(l.prdtName)}</h2>
																</div>
															</c:otherwise>
														</c:choose>													
													</a>
													<c:if test="${l.rcntGbn eq 'ic_01'}">
														<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt ne '0'}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_05'}">
														<a href="javascript:" onclick="addBizWishBrand('${l.sellPrdtBcode}');return false;" class='btn_like<c:if test="${l.wishUserPrdtCnt ne '0'}"> on</c:if> ${l.sellPrdtBcode}' ><span>좋아요</span></a><!-- 활성화시 on : class 추가 -->
													</c:if>
													<div class="run_out <c:if test="${fn:contains('P,G,S', l.sellPrdtGbn)}">
																			<c:if test="${l.prdtStatCode eq 'C0313'}">out01</c:if>
																			<c:if test="${l.prdtStatCode eq 'C0314' || l.prdtStatCode eq 'C0315'}">out02</c:if>																		
																		</c:if>
																		<c:if test="${fn:contains('R,D,C', l.sellPrdtGbn)}">
																			<c:if test="${l.rcrdStat eq '2'}">out01</c:if>
																			<c:if test="${l.rcrdStat eq '3' || l.rcrdStat eq '4'}">out02</c:if>
																		</c:if>
																		<c:if test="${l.prdtStatCode eq 'N'}">out03</c:if>"><!-- 품절유형 out01 ~ 03 : class 추가 -->
														<span class='out01'>일시<br>품절</span>
														<span class='out02'>품절</span>
														<span class='out03'>종료</span>
													</div>												
												</li>
											</c:forEach>
										</ul>
									</div>							
								</c:if>
								<c:if test="${not empty listRecent2}">
									<div class="box_history pd_list" id="listRecent2">
										<h4 class='lst font_t'><span class='year'>${listRecent2[0].yyyy}</span> ${listRecent2[0].mmdd} <i class='${listRecent2[0].yoil}'></i><!-- sun·mon·tue·wed·thur·fri·sat : class 추가 --></h4>
										<ul class='catalog_history'>
											<c:forEach items="${listRecent2}" var="l" varStatus="st">
												<li class='${l.rcntGbn} <c:if test="${fn:contains('P,G,S', l.sellPrdtGbn)}">																		
																			<c:if test="${l.prdtStatCode eq 'C0313' || l.prdtStatCode eq 'C0314' || l.prdtStatCode eq 'C0315'}">sold_out</c:if>																		
																		</c:if>
																		<c:if test="${fn:contains('R,D,C', l.sellPrdtGbn)}">																		
																			<c:if test="${l.rcrdStat eq '2' || l.rcrdStat eq '3' || l.rcrdStat eq '4'}">sold_out</c:if>
																		</c:if>
																		<c:if test="${l.prdtStatCode eq 'N'}">sold_out</c:if>'>
													<input type="hidden" name="sellPrdtBcode" value="${l.sellPrdtBcode}"/>																											
													<c:if test="${l.rcntGbn eq 'ic_01'}">
														<a href="/p/${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_02'}">
														<a href="/m/biz/search/searchMain?searchTerm=${l.prdtName}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_03'}">
														<a href="/m/biz/eventDetail?eventId=${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_04'}">
														<a href="/m/biz/eventDetail?eventId=${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_05'}">
														<a href="/m/biz/hot/brandDetail?brandId=${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>																										
														<c:choose>
															<c:when test="${l.rcntGbn eq 'ic_01'}">
																<i>
																	<c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><ui:image src="${l.productImageUrl}" server="product" size="150" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																	<c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																	<c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																</i>														
																<div class="desc_type01">
																	<h2>${fn:escapeXml(l.prdtName)}</h2>
																	<p>
																		<fmt:parseNumber var="rate" integerOnly="true" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
																		<span class='font_t percent'><c:if test="${rate > 0}">${rate}%</c:if></span>
																		<span class='font_t'><fmt:formatNumber type="number" value="${l.lastCpnPrice}"/></span>
																	</p>
																</div>
															</c:when>
															<c:otherwise>
																<div class="desc_type02">
																	<h2>${fn:escapeXml(l.prdtName)}</h2>
																</div>
															</c:otherwise>
														</c:choose>													
													</a>
													<c:if test="${l.rcntGbn eq 'ic_01'}">
														<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt ne '0'}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_05'}">
														<a href="javascript:" onclick="addBizWishBrand('${l.sellPrdtBcode}');return false;" class='btn_like<c:if test="${l.wishUserPrdtCnt ne '0'}"> on</c:if> ${l.sellPrdtBcode}' ><span>좋아요</span></a><!-- 활성화시 on : class 추가 -->
													</c:if>
													<div class="run_out <c:if test="${fn:contains('P,G,S', l.sellPrdtGbn)}">
																			<c:if test="${l.prdtStatCode eq 'C0313'}">out01</c:if>
																			<c:if test="${l.prdtStatCode eq 'C0314' || l.prdtStatCode eq 'C0315'}">out02</c:if>																		
																		</c:if>
																		<c:if test="${fn:contains('R,D,C', l.sellPrdtGbn)}">
																			<c:if test="${l.rcrdStat eq '2'}">out01</c:if>
																			<c:if test="${l.rcrdStat eq '3' || l.rcrdStat eq '4'}">out02</c:if>
																		</c:if>
																		<c:if test="${l.prdtStatCode eq 'N'}">out03</c:if>"><!-- 품절유형 out01 ~ 03 : class 추가 -->
														<span class='out01'>일시<br>품절</span>
														<span class='out02'>품절</span>
														<span class='out03'>종료</span>
													</div>												
												</li>
											</c:forEach>
										</ul>
									</div>							
								</c:if>
								<c:if test="${not empty listRecent3}">
									<div class="box_history pd_list" id="listRecent3">
										<h4 class='lst font_t'><span class='year'>${listRecent3[0].yyyy}</span> ${listRecent3[0].mmdd} <i class='${listRecent3[0].yoil}'></i><!-- sun·mon·tue·wed·thur·fri·sat : class 추가 --></h4>
										<ul class='catalog_history'>
											<c:forEach items="${listRecent3}" var="l" varStatus="st">										
												<li class='${l.rcntGbn} <c:if test="${fn:contains('P,G,S', l.sellPrdtGbn)}">																		
																			<c:if test="${l.prdtStatCode eq 'C0313' || l.prdtStatCode eq 'C0314' || l.prdtStatCode eq 'C0315'}">sold_out</c:if>																		
																		</c:if>
																		<c:if test="${fn:contains('R,D,C', l.sellPrdtGbn)}">																		
																			<c:if test="${l.rcrdStat eq '2' || l.rcrdStat eq '3' || l.rcrdStat eq '4'}">sold_out</c:if>
																		</c:if>
																		<c:if test="${l.prdtStatCode eq 'N'}">sold_out</c:if>'>
													<input type="hidden" name="sellPrdtBcode" value="${l.sellPrdtBcode}"/>																
													<c:if test="${l.rcntGbn eq 'ic_01'}">
														<a href="/p/${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_02'}">
														<a href="/m/biz/search/searchMain?searchTerm=${l.prdtName}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_03'}">
														<a href="/m/biz/eventDetail?eventId=${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_04'}">
														<a href="/m/biz/eventDetail?eventId=${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_05'}">
														<a href="/m/biz/hot/brandDetail?brandId=${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>																																							
														<c:choose>
															<c:when test="${l.rcntGbn eq 'ic_01'}">
																<i>
																	<c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><ui:image src="${l.productImageUrl}" server="product" size="150" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																	<c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																	<c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																</i>														
																<div class="desc_type01">
																	<h2>${fn:escapeXml(l.prdtName)}</h2>
																	<p>
																		<fmt:parseNumber var="rate" integerOnly="true" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
																		<span class='font_t percent'><c:if test="${rate > 0}">${rate}%</c:if></span>
																		<span class='font_t'><fmt:formatNumber type="number" value="${l.lastCpnPrice}"/></span>
																	</p>
																</div>
															</c:when>
															<c:otherwise>
																<div class="desc_type02">
																	<h2>${fn:escapeXml(l.prdtName)}</h2>
																</div>
															</c:otherwise>
														</c:choose>													
													</a>
													<c:if test="${l.rcntGbn eq 'ic_01'}">
														<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt ne '0'}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_05'}">
														<a href="javascript:" onclick="addBizWishBrand('${l.sellPrdtBcode}');return false;" class='btn_like<c:if test="${l.wishUserPrdtCnt ne '0'}"> on</c:if> ${l.sellPrdtBcode}' ><span>좋아요</span></a><!-- 활성화시 on : class 추가 -->
													</c:if>
													<div class="run_out <c:if test="${fn:contains('P,G,S', l.sellPrdtGbn)}">
																			<c:if test="${l.prdtStatCode eq 'C0313'}">out01</c:if>
																			<c:if test="${l.prdtStatCode eq 'C0314' || l.prdtStatCode eq 'C0315'}">out02</c:if>																		
																		</c:if>
																		<c:if test="${fn:contains('R,D,C', l.sellPrdtGbn)}">
																			<c:if test="${l.rcrdStat eq '2'}">out01</c:if>
																			<c:if test="${l.rcrdStat eq '3' || l.rcrdStat eq '4'}">out02</c:if>
																		</c:if>
																		<c:if test="${l.prdtStatCode eq 'N'}">out03</c:if>"><!-- 품절유형 out01 ~ 03 : class 추가 -->
														<span class='out01'>일시<br>품절</span>
														<span class='out02'>품절</span>
														<span class='out03'>종료</span>
													</div>												
												</li>
											</c:forEach>
										</ul>
									</div>							
								</c:if>
								<c:if test="${not empty listRecent4}">
									<div class="box_history pd_list" id="listRecent4">
										<h4 class='lst font_t'><span class='year'>${listRecent4[0].yyyy}</span> ${listRecent4[0].mmdd} <i class='${listRecent4[0].yoil}'></i><!-- sun·mon·tue·wed·thur·fri·sat : class 추가 --></h4>
										<ul class='catalog_history'>
											<c:forEach items="${listRecent4}" var="l" varStatus="st">
												<li class='${l.rcntGbn} <c:if test="${fn:contains('P,G,S', l.sellPrdtGbn)}">																		
																			<c:if test="${l.prdtStatCode eq 'C0313' || l.prdtStatCode eq 'C0314' || l.prdtStatCode eq 'C0315'}">sold_out</c:if>																		
																		</c:if>
																		<c:if test="${fn:contains('R,D,C', l.sellPrdtGbn)}">																		
																			<c:if test="${l.rcrdStat eq '2' || l.rcrdStat eq '3' || l.rcrdStat eq '4'}">sold_out</c:if>
																		</c:if>
																		<c:if test="${l.prdtStatCode eq 'N'}">sold_out</c:if>'>
													<input type="hidden" name="sellPrdtBcode" value="${l.sellPrdtBcode}"/>
													<c:if test="${l.rcntGbn eq 'ic_01'}">
														<a href="/p/${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_02'}">
														<a href="/m/biz/search/searchMain?searchTerm=${l.prdtName}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_03'}">
														<a href="/m/biz/eventDetail?eventId=${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_04'}">
														<a href="/m/biz/eventDetail?eventId=${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_05'}">
														<a href="/m/biz/hot/brandDetail?brandId=${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>																																								
														<c:choose>
															<c:when test="${l.rcntGbn eq 'ic_01'}">
																<i>
																	<c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><ui:image src="${l.productImageUrl}" server="product" size="150" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																	<c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																	<c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																</i>														
																<div class="desc_type01">
																	<h2>${fn:escapeXml(l.prdtName)}</h2>
																	<p>
																		<fmt:parseNumber var="rate" integerOnly="true" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
																		<span class='font_t percent'><c:if test="${rate > 0}">${rate}%</c:if></span>
																		<span class='font_t'><fmt:formatNumber type="number" value="${l.lastCpnPrice}"/></span>
																	</p>
																</div>
															</c:when>
															<c:otherwise>
																<div class="desc_type02">
																	<h2>${fn:escapeXml(l.prdtName)}</h2>
																</div>
															</c:otherwise>
														</c:choose>													
													</a>
													<c:if test="${l.rcntGbn eq 'ic_01'}">
														<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt ne '0'}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_05'}">
														<a href="javascript:" onclick="addBizWishBrand('${l.sellPrdtBcode}');return false;" class='btn_like<c:if test="${l.wishUserPrdtCnt ne '0'}"> on</c:if> ${l.sellPrdtBcode}' ><span>좋아요</span></a><!-- 활성화시 on : class 추가 -->
													</c:if>
													<div class="run_out <c:if test="${fn:contains('P,G,S', l.sellPrdtGbn)}">
																			<c:if test="${l.prdtStatCode eq 'C0313'}">out01</c:if>
																			<c:if test="${l.prdtStatCode eq 'C0314' || l.prdtStatCode eq 'C0315'}">out02</c:if>																		
																		</c:if>
																		<c:if test="${fn:contains('R,D,C', l.sellPrdtGbn)}">
																			<c:if test="${l.rcrdStat eq '2'}">out01</c:if>
																			<c:if test="${l.rcrdStat eq '3' || l.rcrdStat eq '4'}">out02</c:if>
																		</c:if>
																		<c:if test="${l.prdtStatCode eq 'N'}">out03</c:if>"><!-- 품절유형 out01 ~ 03 : class 추가 -->
														<span class='out01'>일시<br>품절</span>
														<span class='out02'>품절</span>
														<span class='out03'>종료</span>
													</div>												
												</li>
											</c:forEach>
										</ul>
									</div>							
								</c:if>
								<c:if test="${not empty listRecent5}">
									<div class="box_history pd_list" id="listRecent5">
										<h4 class='lst font_t'><span class='year'>${listRecent5[0].yyyy}</span> ${listRecent5[0].mmdd} <i class='${listRecent5[0].yoil}'></i><!-- sun·mon·tue·wed·thur·fri·sat : class 추가 --></h4>
										<ul class='catalog_history'>
											<c:forEach items="${listRecent5}" var="l" varStatus="st">
												<li class='${l.rcntGbn} <c:if test="${fn:contains('P,G,S', l.sellPrdtGbn)}">																		
																			<c:if test="${l.prdtStatCode eq 'C0313' || l.prdtStatCode eq 'C0314' || l.prdtStatCode eq 'C0315'}">sold_out</c:if>																		
																		</c:if>
																		<c:if test="${fn:contains('R,D,C', l.sellPrdtGbn)}">																		
																			<c:if test="${l.rcrdStat eq '2' || l.rcrdStat eq '3' || l.rcrdStat eq '4'}">sold_out</c:if>
																		</c:if>
																		<c:if test="${l.prdtStatCode eq 'N'}">sold_out</c:if>'>
													<input type="hidden" name="sellPrdtBcode" value="${l.sellPrdtBcode}"/>					
													<c:if test="${l.rcntGbn eq 'ic_01'}">
														<a href="/p/${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_02'}">
														<a href="/m/biz/search/searchMain?searchTerm=${l.prdtName}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_03'}">
														<a href="/m/biz/eventDetail?eventId=${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_04'}">
														<a href="/m/biz/eventDetail?eventId=${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_05'}">
														<a href="/m/biz/hot/brandDetail?brandId=${l.sellPrdtBcode}" class='btn_erase'>
													</c:if>																									
														<c:choose>
															<c:when test="${l.rcntGbn eq 'ic_01'}">
																<i>
																	<c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><ui:image src="${l.productImageUrl}" server="product" size="150" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																	<c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																	<c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																</i>														
																<div class="desc_type01">
																	<h2>${fn:escapeXml(l.prdtName)}</h2>
																	<p>
																		<fmt:parseNumber var="rate" integerOnly="true" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
																		<span class='font_t percent'><c:if test="${rate > 0}">${rate}%</c:if></span>
																		<span class='font_t'><fmt:formatNumber type="number" value="${l.lastCpnPrice}"/></span>
																	</p>
																</div>
															</c:when>
															<c:otherwise>
																<div class="desc_type02">
																	<h2>${fn:escapeXml(l.prdtName)}</h2>
																</div>
															</c:otherwise>
														</c:choose>													
													</a>
													<c:if test="${l.rcntGbn eq 'ic_01'}">
														<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt ne '0'}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_05'}">
														<a href="javascript:" onclick="addBizWishBrand('${l.sellPrdtBcode}');return false;" class='btn_like<c:if test="${l.wishUserPrdtCnt ne '0'}"> on</c:if> ${l.sellPrdtBcode}' ><span>좋아요</span></a><!-- 활성화시 on : class 추가 -->
													</c:if>
													<div class="run_out <c:if test="${fn:contains('P,G,S', l.sellPrdtGbn)}">
																			<c:if test="${l.prdtStatCode eq 'C0313'}">out01</c:if>
																			<c:if test="${l.prdtStatCode eq 'C0314' || l.prdtStatCode eq 'C0315'}">out02</c:if>																		
																		</c:if>
																		<c:if test="${fn:contains('R,D,C', l.sellPrdtGbn)}">
																			<c:if test="${l.rcrdStat eq '2'}">out01</c:if>
																			<c:if test="${l.rcrdStat eq '3' || l.rcrdStat eq '4'}">out02</c:if>
																		</c:if>
																		<c:if test="${l.prdtStatCode eq 'N'}">out03</c:if>"><!-- 품절유형 out01 ~ 03 : class 추가 -->
														<span class='out01'>일시<br>품절</span>
														<span class='out02'>품절</span>
														<span class='out03'>종료</span>
													</div>												
												</li>
											</c:forEach>
										</ul>
									</div>							
								</c:if>
								<c:if test="${not empty listRecent6}">
									<div class="box_history pd_list" id="listRecent6">
										<h4 class='lst font_t'><span class='year'>${listRecent6[0].yyyy}</span> ${listRecent6[0].mmdd} <i class='${listRecent6[0].yoil}'></i><!-- sun·mon·tue·wed·thur·fri·sat : class 추가 --></h4>
										<ul class='catalog_history'>
											<c:forEach items="${listRecent6}" var="l" varStatus="st">
												<li class='${l.rcntGbn} <c:if test="${fn:contains('P,G,S', l.sellPrdtGbn)}">																		
																			<c:if test="${l.prdtStatCode eq 'C0313' || l.prdtStatCode eq 'C0314' || l.prdtStatCode eq 'C0315'}">sold_out</c:if>																		
																		</c:if>
																		<c:if test="${fn:contains('R,D,C', l.sellPrdtGbn)}">																		
																			<c:if test="${l.rcrdStat eq '2' || l.rcrdStat eq '3' || l.rcrdStat eq '4'}">sold_out</c:if>
																		</c:if>
																		<c:if test="${l.prdtStatCode eq 'N'}">sold_out</c:if>'>	
													<input type="hidden" name="sellPrdtBcode" value="${l.sellPrdtBcode}"/>																
													<a href="/p/${l.sellPrdtBcode}">																								
														<c:choose>
															<c:when test="${l.rcntGbn eq 'ic_01'}">
																<i>
																	<c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><ui:image src="${l.productImageUrl}" server="product" size="150" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																	<c:if test="${l.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																	<c:if test="${l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${l.prdtName}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
																</i>														
																<div class="desc_type01">
																	<h2>${fn:escapeXml(l.prdtName)}</h2>
																	<p>
																		<fmt:parseNumber var="rate" integerOnly="true" type="number" value="${hfn:rate(l.prdtSellPrice,l.lastCpnPrice)}"/>
																		<span class='font_t percent'><c:if test="${rate > 0}">${rate}%</c:if></span>
																		<span class='font_t'><fmt:formatNumber type="number" value="${l.lastCpnPrice}"/></span>
																	</p>
																</div>
															</c:when>
															<c:otherwise>
																<div class="desc_type02">
																	<h2>${fn:escapeXml(l.prdtName)}</h2>
																</div>
															</c:otherwise>
														</c:choose>													
													</a>
													<c:if test="${l.rcntGbn eq 'ic_01'}">
														<a href="javascript:" onclick="addBizWishProduct(this);return false;" class="btn_like<c:if test="${l.wishUserPrdtCnt ne '0'}"> active</c:if>" prdtId="${l.sellPrdtBcode}"><span>좋아요</span></a>
													</c:if>
													<c:if test="${l.rcntGbn eq 'ic_05'}">
														<a href="javascript:" onclick="addBizWishBrand('${l.sellPrdtBcode}');return false;" class='btn_like<c:if test="${l.wishUserPrdtCnt ne '0'}"> on</c:if> ${l.sellPrdtBcode}' ><span>좋아요</span></a><!-- 활성화시 on : class 추가 -->
													</c:if>
													<div class="run_out <c:if test="${fn:contains('P,G,S', l.sellPrdtGbn)}">
																			<c:if test="${l.prdtStatCode eq 'C0313'}">out01</c:if>
																			<c:if test="${l.prdtStatCode eq 'C0314' || l.prdtStatCode eq 'C0315'}">out02</c:if>																		
																		</c:if>
																		<c:if test="${fn:contains('R,D,C', l.sellPrdtGbn)}">
																			<c:if test="${l.rcrdStat eq '2'}">out01</c:if>
																			<c:if test="${l.rcrdStat eq '3' || l.rcrdStat eq '4'}">out02</c:if>
																		</c:if>
																		<c:if test="${l.prdtStatCode eq 'N'}">out03</c:if>"><!-- 품절유형 out01 ~ 03 : class 추가 -->
														<span class='out01'>일시<br>품절</span>
														<span class='out02'>품절</span>
														<span class='out03'>종료</span>
													</div>												
												</li>
											</c:forEach>
										</ul>
									</div>							
								</c:if>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="vacant_history" style="display: none" id="rcnt_vacant">
						<img src="/images/biz/sub/benefit/no_history.png" alt="히스토리 내역없음">
						<p><span>아직 쇼핑 히스토리가 없어요<br> 핫트랙스에는<br> 보물 같은 아이들이 많답니다</span><br><br>우리 함께 찾아볼까요?</p>
						<a href="javascript:;" onclick="location.href='/m/biz/personal/personalRecommend';return false;">이대로만 따라가요</a>
					</div>					
					<div id="likeListDiv" class="topValue" style="display: none">
						<!-- 제품 -->
						<div id="listDiv">						
						</div>										
					</div>
				<!-- 	
				</div>
			</div>
		</div>
		 -->
	</div>
</div>