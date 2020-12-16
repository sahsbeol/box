<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<div class="box_frame <c:if test='${empty recentFacelist}'> no</c:if>"><!-- 히스토리 없는 경우, no : class 추가-->
	<a href="javascript:" class='btn_history PC_MAIN_HISTORY_1'>
		<img src="/images/biz/common/arr_L_bold.png" alt="히스토리 보기">
		<span>히스토리</span>
	</a>
	<ul class="list_history<c:if test='${empty recentFacelist}'> no</c:if>">
		<li class='no_history'>
			<img src="/images/biz/sub/history/no_history.png" alt="히스토리 없음">
			<p>아직<br> 쇼핑 히스토리가<br> 없어요</p>
		</li>
		<c:if test='${not empty recentFacelist}'>			
			<c:forEach items="${recentFacelist}" var="l" varStatus="st">			
				<c:choose>
					<c:when test="${l.rcntGbn eq 'ic_01'}">
						<li class="PC_MAIN_HISTORY_1_1 active ${l.rcntGbn} <c:if test="${l.prdtStatCode eq 'N'}">sold_out</c:if>">
							<div class='hover_wrap'>										
								<c:choose>
                                    <c:when test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}">				                        
                                       	<a href="/ht/record/detail/${l.sellPrdtBcode}" class='hv_recent hv_image'>
                                       		<span>${fn:escapeXml(l.prdtName)}</span>
                                       		<strong><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></strong>
                                       		<i>
                                       			<ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" rcrdImgType="midi" ratingCode="${l.rtngCode}" width="60" alt="${fn:escapeXml(l.prdtName)}" style="width:60px;height:60px;"/>
                                       		</i>	
                                       	</a>				                                        
                                    </c:when>
                                    <c:otherwise>				                                        			                                       
                                       	<a href="/ht/product/detail?barcode=${l.sellPrdtBcode}" class='hv_recent hv_image'>
                                       		<span>${fn:escapeXml(l.prdtName)}</span>
                                       		<strong><fmt:formatNumber type="number">${l.lastCpnPrice}</fmt:formatNumber></strong>
                                       		<i>				                                        	
                                       			<ui:image src="${l.productImageUrl}" server="product" size="100" alt="${fn:escapeXml(l.prdtName)}" style="width:60px;height:60px;"/>
                                       		</i>	
                                       	</a>				                                        
                                    </c:otherwise>
                                </c:choose>																					
								<a href="javascript:" class='btn_close' onclick="Fn_bizRcntFaceItemDel('${l.rcntGbn}', '${l.sellPrdtBcode}')"><img src="/images/biz/common/btn_close_s.png" alt="닫기"></a>
							</div>
							<a href="/p/${l.sellPrdtBcode}" class='thumb_sky'>
								<c:if test="${l.sellPrdtGbn ne 'R' && l.sellPrdtGbn ne 'D'}"><ui:image src="${l.productImageUrl}" server="product" size="150" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>
								<c:if test="${l.sellPrdtGbn eq 'R' || l.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="A" width="60" alt="${fn:escapeXml(l.prdtName)}" ssl="${pageContext.request.scheme eq 'http'?'N':'Y'}"/></c:if>								
								<p></p>
							</a>
						</li>										
					</c:when>
					<c:otherwise>						
						<li class='active ${l.rcntGbn} <c:if test="${l.prdtStatCode eq 'N'}">sold_out</c:if>'>
							<div class='hover_wrap'>								
								<c:if test="${l.rcntGbn eq 'ic_02'}">
									<a href="/ht/biz/bizSearchMain?searchTerm=${l.prdtName}" class='hv_recent'>
								</c:if>
								<c:if test="${l.rcntGbn eq 'ic_03'}">
									<a href="/ht/biz/eventDetail?eventId=${l.sellPrdtBcode}" class='hv_recent'>
								</c:if>
								<c:if test="${l.rcntGbn eq 'ic_04'}">
									<a href="/ht/biz/eventDetail?eventId=${l.sellPrdtBcode}" class='hv_recent'>
								</c:if>
								<c:if test="${l.rcntGbn eq 'ic_05'}">
									<a href="/ht/biz/hot/brandDetail?brandId=${l.sellPrdtBcode}" class='hv_recent'>
								</c:if>																
									<em class="${l.rcntGbn}">${l.rcntGbnName}</em>
									<span>${fn:escapeXml(l.prdtName)}</span>
								</a>								
								<a href="javascript:" class='sold_dim'></a>								
								<a href="javascript:" class='btn_close' onclick="Fn_bizRcntFaceItemDel('${l.rcntGbn}', '${l.sellPrdtBcode}')"><img src="/images/biz/common/btn_close_s.png" alt="닫기"></a>
							</div>							
							<c:if test="${l.rcntGbn eq 'ic_02'}">
								<a href="/ht/biz/bizSearchMain?searchTerm=${l.prdtName}" class='thumb_sky'>
							</c:if>
							<c:if test="${l.rcntGbn eq 'ic_03'}">
								<a href="/ht/biz/eventDetail?eventId=${l.sellPrdtBcode}" class='thumb_sky'>
							</c:if>
							<c:if test="${l.rcntGbn eq 'ic_04'}">
								<a href="/ht/biz/eventDetail?eventId=${l.sellPrdtBcode}" class='thumb_sky'>
							</c:if>
							<c:if test="${l.rcntGbn eq 'ic_05'}">
								<a href="/ht/biz/hot/brandDetail?brandId=${l.sellPrdtBcode}" class='thumb_sky'>
							</c:if>
								<em>${l.rcntGbnName}</em>
								<span>${fn:escapeXml(l.prdtName)}</span>
							</a>
						</li>												
					</c:otherwise>
				</c:choose>	
			</c:forEach>					
			
		</c:if>		
	</ul>
	<div class='pagination_wrap'>
		<span class='page_num' id="sky_pageNum">${currentPage}</span>
		<span class='page_sum'>${totalPage}</span>
	</div>		
	<div class='slider_turn'>
		<a href="javascript:" class='btn_sky_prev'><span class='PC_MAIN_HISTORY_1_2 sky_prev <c:if test='${currentPage > 1}'>on</c:if><c:if test='${currentPage < 2}'>off</c:if>'></span></a>
		<a href="javascript:" class='btn_sky_next'><span class='PC_MAIN_HISTORY_1_2 sky_next <c:if test='${currentPage < totalPage}'>on</c:if><c:if test='${currentPage >= totalPage}'>off</c:if>'></span></a>
	</div>	
	<div class="lastest_prd">
		<div class="history_inner category_wrap case01"><!-- case01 · case02 : class 추가 -->
			<div class="category_type">
				<span class='tit_history'><i><img src="/images/biz/sub/history/ic_history_black.png" alt="히스토리"></i>히스토리</span>
				<div class="txt_blue">
					<a href="javascript:" class='btn_editing'><em class='edit'>편집</em></a>
					<a href="javascript:" class='btn_cancel'><em class='cancel'>취소</em></a>
				</div>
				<a href="javascript:" class='close_history'><img src="/images/biz/common/btn_close_s.png" alt="히스토리 닫기"></a>
				<p class='bott_border'></p>
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
			<div class="area_overflow" id="histAll">											
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	//loadHistoryAllTemplate();
	
	// 이전 페이지 이동
    $('.btn_sky_prev').on('click', function(){
		var currentPage = Number($('#sky_pageNum').html());
		if(currentPage > 1){
			currentPage = currentPage - 1;
			loadFacelist(currentPage);
			
			$('.sky_next').removeClass('off');
			$('.sky_next').addClass('on');
			
			if(currentPage == 1){
				$('.sky_prev').removeClass('on');
				$('.sky_prev').addClass('off');
			}
		}
    });
	
	// 다음 페이지 이동
    $('.btn_sky_next').on('click', function(){
    	var currentPage = Number($('#sky_pageNum').html());
    	var totalPage = Number("${totalPage}");
    	
    	if(currentPage < totalPage){
			currentPage = currentPage + 1;
			loadFacelist(currentPage);
			
			$('.sky_prev').removeClass('off');
			$('.sky_prev').addClass('on');
			
			if(currentPage == totalPage){
				$('.sky_next').removeClass('on');
				$('.sky_next').addClass('off');
			}
		} 	
    });	
});

function loadFacelist(currentPage){
	$.ajax({
		url: "/menu/biz/loadFacelist"
		,data: { page : currentPage }
		, type:"POST"
        ,dataType: "json"
        ,success : function(data){
        	var append = '';
           	$('.list_history').empty();
        	
            if(!isEmpty(data)) {
				var list = data.recentFacelist;
				if(!isEmpty(list)) {
					for(var i=0; i < list.length; i++) {
						if(list[i].rcntGbn == 'ic_01'){
							if(list[i].prdtStatCode == 'N'){
								append += '<li class="active '+list[i].rcntGbn+' sold_out">';
							}else{
								append += '<li class="active '+list[i].rcntGbn+'">';
							}
							append += '<div class="hover_wrap">';
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
								append += '<a href="/ht/record/detail/'+list[i].sellPrdtBcode+'" class="hv_recent hv_image">';
							}else{
								append += '<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'" class="hv_recent hv_image">';
							}
							append += '	<span>'+list[i].prdtName+'</span>';
							append += '	<strong>'+price_format(list[i].lastCpnPrice)+'</strong>';
							append += '	<i>';
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
	                	    	append += '			<img src="http://image.kyobobook.co.kr/newimages/music/midi/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
	                	    }else{
	                	    	append += '			<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/100/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
	                	    }
							append += '	</i>';
							append += '</a>';
							append += '	<a href="javascript:" class="btn_close" onclick="Fn_bizRcntFaceItemDel('+list[i].rcntGbn+', '+list[i].sellPrdtBcode+')"><img src="/images/biz/common/btn_close_s.png" alt="닫기"></a>';
							append += '	</div>';
							append += '	<a href="/p/'+list[i].sellPrdtBcode+'" class="thumb_sky">';
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
	                	    	append += '			<img src="http://image.kyobobook.co.kr/newimages/music/midi/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
	                	    }else{
	                	    	append += '			<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/100/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
	                	    }								
							append += '		<p></p>';
							append += '	</a>';
							append += '</li>';
						}else{
							if(list[i].prdtStatCode == 'N'){
								append += '<li class="active '+list[i].rcntGbn+' sold_out">';
							}else{
								append += '<li class="active '+list[i].rcntGbn+'">';
							}
							append += '<div class="hover_wrap">';
							if(list[i].rcntGbn == 'ic_02'){
								append += '		<a href="/ht/biz/bizSearchMain?searchTerm='+list[i].prdtName+'" class="hv_recent">';
							}if(list[i].rcntGbn == 'ic_03' || list[i].rcntGbn == 'ic_04'){
								append += '		<a href="/ht/biz/eventDetail?eventId='+list[i].sellPrdtBcode+'" class="hv_recent">';
							}if(list[i].rcntGbn == 'ic_05'){
								append += '		<a href="/ht/biz/hot/brandDetail?brandId='+list[i].sellPrdtBcode+'" class="hv_recent">';
							}
							append += '			<em class="'+list[i].rcntGbn+'">'+list[i].rcntGbnName+'</em>';
							append += '			<span>'+list[i].prdtName+'</span>';
							append += '		</a>';
							append += '		<a href="javascript:" class="sold_dim"></a>';
							append += '		<a href="javascript:" class="btn_close" onclick="Fn_bizRcntFaceItemDel('+list[i].rcntGbn+', '+list[i].sellPrdtBcode+')"><img src="/images/biz/common/btn_close_s.png" alt="닫기"></a>';
							append += '	</div>';
							if(list[i].rcntGbn == 'ic_02'){
								append += '		<a href="/ht/biz/bizSearchMain?searchTerm='+list[i].prdtName+'" class="thumb_sky">';
							}if(list[i].rcntGbn == 'ic_03' || list[i].rcntGbn == 'ic_04'){
								append += '		<a href="/ht/biz/eventDetail?eventId='+list[i].sellPrdtBcode+'" class="thumb_sky">';
							}if(list[i].rcntGbn == 'ic_05'){
								append += '		<a href="/ht/biz/hot/brandDetail?brandId='+list[i].sellPrdtBcode+'" class="thumb_sky">';
							}
							append += '		<em>'+list[i].rcntGbnName+'</em>';
							append += '		<span>'+list[i].prdtName+'</span>';
							append += '	</a>';
							append += '</li>';
						}
					}
				}
				$('#sky_pageNum').html(currentPage);
				$('.list_history').html(append);
				
				skyScraper02();
            }
        }
        ,error: function(request, status, error) {
            if(request.status != 0){
                alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
            }
        }
    });
}

function Fn_bizRcntFaceItemDel(gbn, bCode){
	
	var arr1 = new Array();
    var arr2 = new Array();
    var arr3 = new Array();
    var arr4 = new Array();
    var arr5 = new Array();
    
    if("ic_01" == gbn){
    	arr1.push(bCode);
    }else if("ic_02" == gbn){
    	arr2.push(bCode);
    }else if("ic_03" == gbn){
    	arr3.push(bCode);
    }else if("ic_04" == gbn){
    	arr4.push(bCode);
    }else if("ic_05" == gbn){
    	arr5.push(bCode);
    }
    
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
        	        	
        	var len = $('.list_history .active').length;        	        	
        	var currentPage = Number("${currentPage}");
        	
        	len *= 1;
        	currentPage *= 1;
        	
        	if(len == 1 && currentPage > 1){
        		currentPage = currentPage - 1;
        	}
        	
        	loadHistoryTemplate(currentPage);
        	loadHistoryAllTemplate();
        }
        ,error: function(data) {
            alert('<fmt:message key="error.common.system"/>');
        }
    }); 
}

//최근 본 상품 삭제
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
                	loadHistoryAllTemplate(target);                	
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

function loadHistoryAllTemplate(target){
	
	$.ajax({
        type: "POST"
        ,url: "/menu/biz/getHistoryAllTemplete"
        ,data: {}
        ,dataType: "html"
        ,success : function(data){
            
      		$("#histAll").empty();
        	$("#histAll").append(data);

        	if(target != null){
        		editInit();
        		
        		//편집모드 해제
            	$('.txt_blue').trigger("click");
        	}        	
        }
        ,error: function(data) {        	
            alert('<fmt:message key="error.common.system"/>');
        }
    });    
}

function editInit(){	
	if($('.lastest_prd .history_inner').hasClass('case01')){				
		$('.catalog_history').addClass('edit');
		$('.catalog_history').removeClass('cancel');
		$('.catalog_history').find('li').removeClass('chk_off');
		
	}else{
		$('.catalog_history').addClass('cancel');
		$('.catalog_history').removeClass('edit');
		$('.catalog_history').find('li').addClass('chk_off');
	}	
}
</script>
