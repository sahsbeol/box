<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizFull"/>
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
		           ,url: "/m/biz/mypage/todayFreeDelivery?lazy=Y&pagingLoad=true&productOrderBy="+ $('#orderBySelect').val() +"&ctgrId="+ $('#selectOption').val() +"&page="+ obj.page
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
           categoryFn();
           $("#subTitle").text("무료배송");
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
	  	
	    $("#selectOption").change(function(){
    	   	obj.page = 1;
   			obj.loadData();
   		});
       $("#orderBySelect").change(function(){
    	   	obj.page = 1;
   			obj.loadData();
   		});
	});
</script>

<div id="content">
	<div class="curtain_zone">
		<div class="inner">
			<p><span>오늘부터 무료배송</span> 혜택이 시작돼요!</p>
			<a href="javascript:;" class="btn_close">닫기</a>
		</div>
	</div>
	<div class="benefit_wrap category_wrap curtain"><!-- 상단 알림 있을시, curtain : class 추가 -->
		<input type="hidden" name="eofObj" value="0"/>
		<div class="choice_wrap addSel">
			<div class="pd_filter">
				<div class="form_select">
					<select id="selectOption" class='resize_select'>
						<option value="">전체</option>
						<option value="000020">디자인문구</option>
						<option value="000022">디지털</option>
						<option value="000007">고급필기구</option>
						<option value="000021">오피스</option>
						<option value="000025">리빙/생활가전</option>
						<option value="000026">키친/푸드</option>
						<option value="000024">가구/수납</option>
						<option value="000028">패션잡화</option>
						<option value="000006">뷰티/헬스</option>
						<option value="000027">여행/자동차</option>
						<option value="000023">취미/펫</option>
						<option value="000029">유아동</option>
						<option value="0003">CD</option>
						<option value="0004">DVD</option>
					</select>
				</div>	
			</div>
			<div class="pd_filter">
				<p class="pd_total"><em class="font_t" id="totalCnt"></em>개</p>
				<div class="form_select">
					<select id="orderBySelect">
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
		<div class="pd_list coupon">
			<ul id="dataList">
			</ul>
		</div>
		<!--//상품 -->
	</div>
</div>