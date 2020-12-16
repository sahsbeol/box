<%@page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="htNoQuick"/>
<!DOCTYPE ui:decorator PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
$(document).ready(function(){
	gnb();//gnb
	nav();//nav
	if($('.header_wrap').length >0){
		bodyScroll();//body scroll
	}
	tasteFn();//taste
	
	$('#searchChange').click(function(){
		var keywordLen = $("#keywordLen").val();
		var curPage = $("#search_curPage").text();
		
		if(Number(curPage)+1 > Number(keywordLen)){
			$("#search_curPage").text(1);
		}else{
			$("#search_curPage").text(Number(curPage)+1);
		}
		
		$fn.setRecobellSearchList();
	});
	
	$('#ctgrChange').click(function(){
		var ctgrLen = $("#ctgrLen").val();
		var curPage = $("#ctgr_curPage").text();
		
		if(Number(curPage)+1 > Number(ctgrLen)){
			$("#ctgr_curPage").text(1);
		}else{
			$("#ctgr_curPage").text(Number(curPage)+1);
		}
		
		$fn.setRecobellCtgrPrdtList();
	});
	
	$('.btn_more').click(function(e){
		if($(this).hasClass("on")){
			$('[name=relation_item]').hide();
			$(this).find("span").html('더보기');
			$(this).removeClass("on");
		}else{
			$('[name=relation_item]').show();
			$(this).find("span").html('접기');
			$(this).addClass("on");
		}
    });
	
	$('.slide_banner').on('afterChange', function(event, slick, currentSlide, nextSlide){
		 var code = $('.slick-current > a').attr('code');
		 
		 $fn.setRecobellRelationList(code);
	});
	
	$fn.setRecobellSearchList();
	$fn.setRecobellCtgrPrdtList();
	$fn.setRecobellRelationList($('.slick-current > a').attr('code'));
});

$fn = {
	setRecobellSearchList:function() {
		var key = $("#search_curPage").text() -1;
		var searchTxt = $("[name=keyword]:eq("+key+")").val();
		$.ajax({
			url: "/ht/biz/personal/getRecobellSearchList"
			, data: {
				keyword : searchTxt
			}
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
	        	var append = '';
               	$('#recobellSearchList').empty();
	        	
                if(!isEmpty(data)) {
					var list = data.recobellSearchList;
					if(!isEmpty(list)) {
						for(var i=0; i < list.length; i++) {
							append += '<li>';
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
	                	    	append += '			<a href="/ht/record/detail/'+list[i].sellPrdtBcode+'?foo=bar&rccode=pc_taste2_1">';
	                	    }else{
	                	    	append += '			<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'&foo=bar&rccode=pc_taste2_1">';
	                	    }
							append += '		<div class="thum">';
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
	                	    	append += '			<img src="http://image.kyobobook.co.kr/newimages/music/large/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
	                	    }else{
	                	    	append += '			<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].prdtImgUrl+'" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
	                	    }
							append += '		</div>';
							append += '		<div class="cont">';
							append += '			<p class="tit">'+list[i].prdtName+'</p>';
							append += '			<p class="price font_t">';
							if(list[i].lastDcRate != 0){
		                	    append += '				<span class="percent">'+list[i].lastDcRate+'%</span>';
	                	    }
							append += '				<span>'+price_format(list[i].lastCpnPrice)+'</span>';
							append += '			</p>';
							append += '		</div>';
							append += '	</a>';
							append += '</li>';
							
							if (i == 2)	break;
	                	}
					}else{
						var keywordLen = $("#keywordLen").val();
						var curPage = $("#search_curPage").text();
						
						if(keywordLen == 1){
							$(".cont01").hide();
							return false;
						}else{
							if(curPage == keywordLen){
								$("[name=keyword]:eq("+(curPage-1)+")").remove();
								$("#keywordLen").val(Number($("#keywordLen").val())-1);
								$("#search_totalPage").text('/'+$("#keywordLen").val());
								$("#search_curPage").text(1);									
							}else{
								$("[name=keyword]:eq("+(curPage-1)+")").remove();
								$("#keywordLen").val(Number($("#keywordLen").val())-1);
								$("#search_totalPage").text('/'+$("#keywordLen").val());
								$("#search_curPage").text($("#search_curPage").text());
							}
						}
						
						$fn.setRecobellSearchList();
					}
                	
					$('#keyValue').html('# '+searchTxt);
					$('#recobellSearchList').html(append);
                }
	        }
	        ,error: function(request, status, error) {
	            if(request.status != 0){
	                alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
	            }
	        }
	    });
	}
	, setRecobellRelationList:function(code) {
		$.ajax({
			url: "/ht/biz/personal/getRecobellRelationList"
			, data: {
				code : code
			}
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
	        	var append = "";
               	$('#recobellRelationList').empty();
	        	
                if(!isEmpty(data)) {
					var list = data.recobellRelationList;
					if(!isEmpty(list)) {
						for(var i=0; i < list.length; i++) {
							if(i < 8){
								append += '<li>';
							}else{
								append += '<li name="relation_item" style="display:none;">';
							}
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
	                	    	append += '			<a href="/ht/record/detail/'+list[i].sellPrdtBcode+'?foo=bar&rccode=pc_taste2_2">';
	                	    }else{
	                	    	append += '			<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'&foo=bar&rccode=pc_taste2_2">';
	                	    }
							append += '		<div class="thum">';
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
	                	    	append += '			<img src="http://image.kyobobook.co.kr/newimages/music/large/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
	                	    }else{
	                	    	append += '			<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].prdtImgUrl+'" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
	                	    }
							append += '		</div>';
							append += '		<div class="cont">';
							append += '			<p class="tit">'+list[i].prdtName+'</p>';
							append += '			<p class="price font_t">';
							if(list[i].lastDcRate != 0){
		                	    append += '				<span class="percent">'+list[i].lastDcRate+'%</span>';
	                	    }
							append += '				<span>'+price_format(list[i].lastCpnPrice)+'</span>';
							append += '			</p>';
							append += '		</div>';
							append += '	</a>';
							append += '</li>';
							
							if (i == 15)	break;
	                	}
					}
                	
					$('#recobellRelationList').html(append);
                }
	        }
	        ,error: function(request, status, error) {
	            if(request.status != 0){
	                alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
	            }
	        }
	    });
	}
	, setRecobellCtgrPrdtList:function() {
		var key = $("#ctgr_curPage").text() -1;
		var ctgrId = $("[name=ctgr]:eq("+key+")").val();
		var ctgrNm = $("[name=ctgr]:eq("+key+")").attr("ctgrNm");
		
		$.ajax({
			url: "/ht/biz/personal/getRecobellCtgrPrdtList"
			, type:"POST"
			, data: {
				ctgrId : ctgrId
			}
	        ,dataType: "json"
	        ,success : function(data){
	        	var append = "";
               	$('#recobellCtgrPrdtList').empty();
	        	
                if(!isEmpty(data)) {
					var list = data.recobellCtgrPrdtList;
					if(!isEmpty(list)) {
						for(var i=0; i < list.length; i++) {
							append += '<li>';
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
	                	    	append += '			<a href="/ht/record/detail/'+list[i].sellPrdtBcode+'?foo=bar&rccode=pc_taste2_3">';
	                	    }else{
	                	    	append += '			<a href="/ht/product/detail?barcode='+list[i].sellPrdtBcode+'&foo=bar&rccode=pc_taste2_3">';
	                	    }
							append += '		<div class="thum">';
							if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
	                	    	append += '			<img src="http://image.kyobobook.co.kr/newimages/music/large/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
	                	    }else{
	                	    	append += '			<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].prdtImgUrl+'" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
	                	    }
							append += '		</div>';
							append += '		<div class="cont">';
							append += '			<p class="tit">'+list[i].prdtName+'</p>';
							append += '			<p class="price font_t">';
							if(list[i].lastDcRate != 0){
		                	    append += '				<span class="percent">'+list[i].lastDcRate+'%</span>';
	                	    }
							append += '				<span>'+price_format(list[i].lastCpnPrice)+'</span>';
							append += '			</p>';
							append += '		</div>';
							append += '	</a>';
							append += '</li>';
							
							if (i == 5)	break;
	                	}
					}
					$('#ctgrValue').html('# '+ctgrNm);
					$('#recobellCtgrPrdtList').html(append);
                }
	        }
	        ,error: function(request, status, error) {
	            if(request.status != 0){
	                alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
	            }
	        }
	    });
	}
};
</script>
<style>
#container .content {width: 100%;}
</style>
</head>
<body>
	<input type="hidden" id="keywordLen" value="${fn:length(keywordList)}">
	<c:forEach items="${keywordList}" var="list" varStatus="st" begin="0" end="${fn:length(keywordList)}">
		<input type="hidden" name="keyword" value="${list.keyword}">
	</c:forEach>
	
	<c:set var="ctgrCnt" value="${fn:length(recobellCtgrList)}" />
	
	<c:forEach items="${recobellCtgrList}" var="list" varStatus="st" begin="0" end="${fn:length(recobellCtgrList)}">
		<input type="hidden" name="ctgr" value="${list.ctgrId}" ctgrNm="${list.ctgrNm}">
	</c:forEach>

	<c:if test="${empty recobellCtgrList}">
		<c:set var="ctgrCnt" value="3" />
		<input type="hidden" name="ctgr" value="000020" ctgrNm="다이어리">
		<input type="hidden" name="ctgr" value="000026" ctgrNm="키친/푸드">
		<input type="hidden" name="ctgr" value="000025" ctgrNm="리빙/생활가전">
	</c:if>

	<input type="hidden" id="ctgrLen" value="${ctgrCnt}">
	
	<!-- 컨텐츠 -->
	<div class="content personal_taste taste02" id="content">
		<div class="taste_top">
			<div class="inner950">
				<h3>개인의 취향</h3>
				<p>${userName}님을 위한 발견</p>
				<ul>
					<li><a href="/ht/biz/personal/personalRecommend"><span>추천</span></a></li>
					<li class="active"><a href="/ht/biz/personal/personalRecent"><span>최근,관심</span></a></li>
					<li><a href="/ht/biz/personal/personalLike"><span>좋아요</span></a></li>
					<li><a href="/ht/biz/personal/personalBest"><span>지금,인기</span></a></li>
				</ul>
			</div>
		</div>
		<c:if test="${not empty keywordList}">
			<div class="cont01">
				<h3>최근에 <em id="keyValue"></em> 검색하셨나요?</h3>
				<div class="pd_list col03">
					<ul id="recobellSearchList">
					</ul>
				</div>
				<div class="btn_wrapper">
					<a href="#" onclick="javacript:event.preventDefault();" id="searchChange" class="btn_change"><span>다른 검색어로 추천해줘<em class="font_t"><strong id="search_curPage">1</strong><font id="search_totalPage">/${fn:length(keywordList)}</font></em></span></a>
				</div>
			</div>
		</c:if>
		<c:if test="${not empty recentProductList}">
			<div class="cont02">
				<h3>최근 본 상품과 가장 비슷한 상품이에요</h3>
				<div class="slide_banner_wrap">
					<div class="slide_banner">
						<c:forEach items="${recentProductList}" var="list" varStatus="st" begin="0" end="${fn:length(recentProductList)}">
							<div class="slide-item">
								<c:if test="${list.sellPrdtGbn eq 'R' || list.sellPrdtGbn eq 'D'}"><a href="/ht/record/detail/${list.sellPrdtBcode}foo=bar&rccode=pc_taste2_2" code="${list.sellPrdtBcode}"></c:if>
	                            <c:if test="${list.sellPrdtGbn eq 'P' || list.sellPrdtGbn eq 'G' || list.sellPrdtGbn eq 'S'}"><a href="/ht/product/detail?barcode=${list.sellPrdtBcode}foo=bar&rccode=pc_taste2_2" code="${list.sellPrdtBcode}"></c:if>
									<div class="thum">
										<c:if test="${list.sellPrdtGbn eq 'R' || list.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${list.rcrdCd}" prdtGbn="${list.sellPrdtGbn}" ratingCode="A" rcrdImgType="midi" width="${list.sellPrdtGbn eq 'R'?'150':'99'}" clazz="photo" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
	                            		<c:if test="${list.sellPrdtGbn eq 'P' || list.sellPrdtGbn eq 'G' || list.sellPrdtGbn eq 'S'}"><ui:image src="${list.productImageUrl}" size="400" server="product" clazz="photo" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
									</div>
									<div class="cont">
										<p class="price font_t">
			                    			<c:if test="${list.lastDcRate > 0}"><span class="percent"><fmt:parseNumber var="rate" type="number" integerOnly="true">${list.lastDcRate}</fmt:parseNumber>${rate}%</span></c:if>
											<fmt:formatNumber type="number">${list.lastCpnPrice}</fmt:formatNumber>
										</p>
										<p class="tit">${list.prdtName}</p>
									</div>
								</a>
							</div>
						</c:forEach>
					</div>
					<div class="custom_paging_wrap">
						<div class="custom_paging"></div>
					</div>
				</div>
				<div class="inner950">
					<div class="pd_list">
						<ul id="recobellRelationList">
						</ul>
					</div>
					<div class="btn_wrapper">
						<a href="#" onclick="javacript:event.preventDefault();" class="btn_more"><span>더보기</span></a>
					</div>
				</div>
			</div>
		</c:if>
		<div class="cont03">
			<h3>${userName}님이 관심있을 <em id="ctgrValue"></em> 중에 골라 봤어요</h3>
			<div class="pd_list col03">
				<ul id="recobellCtgrPrdtList">
				</ul>
			</div>
			<div class="btn_wrapper">
				<a href="#" onclick="javacript:event.preventDefault();" id="ctgrChange" class="btn_change"><span>다른 카테고리 추천해줘<em class="font_t"><strong id="ctgr_curPage">1</strong>/${ctgrCnt}</em></span></a>
			</div>
		</div>
	</div>
	<!-- // 컨텐츠 -->
</body>
</html>