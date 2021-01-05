<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizHot"/>
<script type="text/javascript">
	var obj = {
		 page : 1				/*	현재 페이지	*/
		,loadData : function(){	/*	페이징		*/
			if(_isEmpty(obj.page))    obj.page = 1;
		    
		    if($("[name=eofObj]").val() == "0"){
		        $("#loading").show();
		        $("input[name=eofObj]").val("1");
		        
		        $.ajax({
		            type: "GET"
		           ,async:false
		           ,url: "/m/biz/mypage/payGifts?lazy=Y&pagingLoad=true&productOrderBy="+ $('#orderBySelect').val() +"&page="+ obj.page
		           ,dataType: "html"
		           ,success : function(htmlStr){
		        	 	//페이징, 데이터 리스트 삭제
		        	   	$(".pd_list").children().remove();
		        	   	$(".pd_list").append("<ul id='dataList'></ul>");
		        	   	
		        	   	$(".pagination_v2").remove();
		      			
		      			//데이터 리스트, 페이징 추가
		        	   	if($("#totalCnt").text() == "0"){
		      				$("#dataList").parent().prepend(htmlStr);
		      			}else{
		      				$("#dataList").append(htmlStr);
		      			}
		      			
		               	$(".pd_list").after($(".pagination_v2"));
		               	
		        	   	//스크롤 최 상위로 이동
		        	   	$(window).scrollTop(0);
		        	   	
		               	$("#loading").hide();
		               	$("img.lazy").lazyload({placeholder:'/images/no_image2.gif',effect : "fadeIn"});
		               	$("input[name=eofObj]").val("0");
		           }
		           ,error: function(data) {
		               alert('<fmt:message key="error.common.system"/>');
		               $("#loading").hide();
		           }
		       });
		    }
		}
		,init : function(){
           benefitFn(); //slide
           $("#subTitle").text("구매사은품");
		}
		,changeOrderBy : function(){	/*	카테고리 변경 시	*/
			obj.page = 1;
			obj.loadData();
		}
	};
	
	function goList(page){
		obj.page = page;
		obj.loadData();
	}
	
	$(document).ready(function(){	
	    obj.init();
	  	//상품 불러오기
	    obj.loadData();
	});
</script>

<div id="content">
	<div class="curtain_zone">
		<div class="inner">
			<p>지금 구매 시, <span>증정 혜택</span>이 있어요!</p>
			<a href="javascript:;" class="btn_close">닫기</a>
		</div>
	</div>
	<div class="benefit_wrap category_wrap curtain"><!-- 상단 알림 있을시, curtain : class 추가 -->
		<input type="hidden" name="eofObj" value="0"/>
		<div class="choice_wrap">
			<div class="pd_filter">
				<p class="pd_total"><em class="font_t" id="totalCnt"></em>개</p>
				<div class="form_select">
					<select id="orderBySelect" onchange="javascript:obj.changeOrderBy();">
						<option value="R" selected="selected">최근순</option>
						<option value="T">할인율순</option>
						<option value="P">인기순</option>
						<option value="L">낮은가격순</option>
						<option value="H">높은가격순</option>
					</select>
				</div>
			</div>
		</div>
		
		<!-- 상품 -->
		<div class="pd_list pd_best">
			<ul id="dataList">
			</ul>
		</div>
		<!--//상품 -->
		
		<div class="pagination_v2">
		    <ui:bizpaginationScript name="pageHolder" scriptName="goList"/>
		</div>	
	</div>
</div>