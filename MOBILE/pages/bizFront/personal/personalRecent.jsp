<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizFull"/>
<script>
$(document).ready(function() {
	
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

	$('#relationMore').click(function(){
		$('#recobellRelationList li').show();
		$('#relationMore').hide();
	});
	
	$('[name=recentItem]').click(function(){
		$('#relationMore').show();
		
		if($(this).hasClass("active")){
			location.href="/p/"+$(this).attr("sellCode")+"?foo=bar&rccode=mo_taste2_2";
		}else{
			$('[name=recentItem]').removeClass("active");
			$(this).addClass("active");
			
			$fn.setRecobellRelationList();
		}
	});
	
	tasteFn();
	
	$fn.setRecobellSearchList();		
	$fn.setRecobellRelationList();
	$fn.setRecobellCtgrPrdtList();
});

$fn = {
	setRecobellSearchList:function() {
		var key = $("#search_curPage").text() -1;
		var searchTxt = $("[name=keyword]:eq("+key+")").val();

		$.ajax({
			url: "/m/biz/personal/getRecobellSearchList"
			, data: {
				keyword : searchTxt
			}
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
	        	var append = "";
               	$('#recobellSearchList').empty();
	        	
	            if (data) {
	                if(!isEmpty(data)) {
						var list = data.recobellSearchList;
						if(!isEmpty(list)) {
							for(var i=0; i < list.length; i++) {
								append += '<li>';
								append += '	<a href="/p/'+list[i].sellPrdtBcode+'?foo=bar&rccode=mo_taste2_1">';
								append += '		<div class="thum">';
								if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
			                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/music/midi/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" >';
		                	    }else{
			                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
		                	    }
								append += '		</div>';
								append += '		<div class="desc">';
								append += '			<p class="tit">'+list[i].prdtName+'</p>';
								append += '			<p class="price font_t">';
								append += 				price_format(list[i].lastCpnPrice);
								if(list[i].lastDcRate != 0){
			                	    append += '				<span class="percent">'+list[i].lastDcRate+'%</span>';
		                	    }
								append += '			</p>';
								append += '		</div>';
								append += '	</a>';
								append += '</li>';
								
								if (i == 5)	break;
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
	        }
	        ,error: function(request, status, error) {
	            if(request.status != 0){
	                alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
	            }
	        }
	    });
	}
	, setRecobellRelationList:function() {
		$.ajax({
			url: "/m/biz/personal/getRecobellRelationList"
			, data: {
				code : $('[name=recentItem][class=active]').attr("sellCode")
			}
			, type:"POST"
	        ,dataType: "json"
	        ,success : function(data){
	        	var append = "";
               	$('#recobellRelationList').empty();
	        	
	            if (data) {
	                if(!isEmpty(data)) {
						var list = data.recobellRelationList;
						if(!isEmpty(list)) {
							for(var i=0; i < list.length; i++) {
								if(i < 4){
									append += '	<li>';
								}else{
									append += '	<li style="display:none;">';
								}
								append += '	<a href="/p/'+list[i].sellPrdtBcode+'?foo=bar&rccode=mo_taste2_3">';
								append += '		<div class="thum">';
								if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
			                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/music/midi/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" >';
		                	    }else{
			                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
		                	    }
								append += '		</div>';
								append += '		<div class="desc">';
								append += '			<p class="tit">'+list[i].prdtName+'</p>';
								append += '			<p class="price font_t">';
								if(list[i].lastDcRate != 0){
			                	    append += '				<span class="percent">'+list[i].lastDcRate+'%</span>';
		                	    }
								append += 				price_format(list[i].lastCpnPrice);
								append += '			</p>';
								append += '		</div>';
								append += '	</a>';
								append += '</li>';
								
								if (i == 19)	break;
		                	}
						}
	                	
						$('#recobellRelationList').html(append);
	                }
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
			url: "/m/biz/personal/getRecobellCtgrPrdtList"
			, type:"POST"
			, data: {
				ctgrId : ctgrId
			}
	        ,dataType: "json"
	        ,success : function(data){
	        	var append = "";
               	$('#recobellCtgrPrdtList').empty();
	        	
	            if (data) {
	                if(!isEmpty(data)) {
						var list = data.recobellCtgrPrdtList;
						if(!isEmpty(list)) {
							for(var i=0; i < list.length; i++) {
								append += '	<li>';
								append += '	<a href="/p/'+list[i].sellPrdtBcode+'?foo=bar&rccode=mo_taste2_4">';
								append += '		<div class="thum">';
								if(list[i].sellPrdtGbn == 'R' || list[i].sellPrdtGbn == 'D'){
			                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/music/midi/'+list[i].rcrdCd.substring( 1, 5 ).split("").reverse().join("")+'/'+list[i].rcrdCd+'.jpg" alt="'+list[i].prdtName+'" class="photo" >';
		                	    }else{
			                	    append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';">';
		                	    }
								append += '		</div>';
								append += '		<div class="desc">';
								append += '			<p class="tit">'+list[i].prdtName+'</p>';
								append += '			<p class="price font_t">';
								append += 				price_format(list[i].lastCpnPrice);
								if(list[i].lastDcRate != 0){
			                	    append += '				<span class="percent">'+list[i].lastDcRate+'%</span>';
		                	    }
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
	
	<!-- content -->
	<div id="content">
		<div class="personal_taste taste02">
			<div class="tab">
				<p>${userName}님을 위한 발견</p>
				<ul>
					<li><a href="/m/biz/personal/personalRecommend"><span>추천</span></a></li>
					<li class="active"><a href="/m/biz/personal/personalRecent"><span>최근,관심</span></a></li>
					<li><a href="/m/biz/personal/personalLike"><span>좋아요</span></a></li>
					<li><a href="/m/biz/personal/personalBest"><span>지금,인기</span></a></li>
				</ul>
			</div>
			<c:if test="${not empty keywordList}">
				<div class="cont01">
					<h3>최근에 <strong id="keyValue"></strong> 검색하셨나요?</h3>
					<div class="pd_list">
						<ul id="recobellSearchList">
						</ul>
					</div>
					<a href="#" onclick="javacript:event.preventDefault();" id="searchChange" class="btn_change"><span>다른 검색어로 추천해줘<em class="font_t"><strong id="search_curPage">1</strong><font id="search_totalPage">/${fn:length(keywordList)}</font></em></span></a>
				</div>
			</c:if>
			<c:if test="${not empty recentProductList}">
				<div class="cont02">
					<h3>최근에 본 상품과<br/>가장 비슷한 상품이에요</h3>
					<div class="swiper-container">
						<div class="swiper-wrapper">
							<c:forEach items="${recentProductList}" var="list" varStatus="st" begin="0" end="${fn:length(recentProductList)}">
								<div class="swiper-slide">
									<a href="#" onclick="javacript:event.preventDefault();" name="recentItem" sellCode="${list.sellPrdtBcode}" <c:if test="${st.index eq 0}">class="active"</c:if>>
										<div class="thum">
											<c:if test="${list.sellPrdtGbn eq 'P' || list.sellPrdtGbn eq 'G' || list.sellPrdtGbn eq 'S'}"><ui:image src="${list.productImageUrl}" size="400" server="product" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
							                <c:if test="${list.sellPrdtGbn eq 'R'}"><ui:image rcrdCd="${list.rcrdCd}" prdtGbn="R" ratingCode="A" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
							                <c:if test="${list.sellPrdtGbn eq 'D'}"><ui:image rcrdCd="${list.rcrdCd}" prdtGbn="D" ratingCode="A" alt="${fn:escapeXml(list.prdtName)}"/></c:if>
										</div>
										<div class="desc">
											<p class="tit">${list.prdtName}</p>
											<p class="price font_t">
												<fmt:parseNumber var="rate" type="number" value="${hfn:rate(list.prdtSellPrice,list.lastCpnPrice)}"/>
				                    			<fmt:parseNumber var="rate" type="number" value="${rate+(1-(rate%1))%1}" integerOnly="true"/>
				                    			<c:if test="${rate > 0}"><span class="percent">${rate}%</span></c:if>
												<fmt:formatNumber type="number">${list.lastCpnPrice}</fmt:formatNumber>
											</p>
										</div>
									</a>
								</div>
							</c:forEach>
						</div>
	
						<!-- swiper-pagination -->
						<div class="pagination_wrap">
							<div class="swiper-pagination"></div>
						</div>
					</div>
	
					<div class="pd_list">
						<ul id="recobellRelationList">
						</ul>
					</div>
	
					<a href="#" id="relationMore" onclick="javacript:event.preventDefault();" class="btn_more"><span>더보기</span></a>
				</div>
			</c:if>
			<div class="cont03">
				<h3>${userName}님이 관심 있을<br/><span id="ctgrValue"></span> 중에 골라봤어요</h3>
				<div class="pd_list">
					<ul id="recobellCtgrPrdtList">
					</ul>
				</div>
				<a href="#" onclick="javacript:event.preventDefault();" id="ctgrChange" class="btn_change"><span>다른 카테고리 추천해줘<em class="font_t"><strong id="ctgr_curPage">1</strong>/${ctgrCnt}</em></span></a>
			</div>
		</div>
	</div>
	<!--// content -->
</body>
<script type="text/javascript">
$(document).ready(function() {
	sideMenu(); //side menu
	footerFn(); //footer
});
</script>
</html>