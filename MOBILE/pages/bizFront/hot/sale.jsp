<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="bizFull"/>

<script type="text/javascript">
window.onpageshow = function(event) {
	if (window.performance && window.performance.navigation.type == 2) {
		 window.history.go(-1);
	}
};
window.onpagehide = function(event) {
	history.pushState(null, null, location.href);
};
	$(document).ready(function(){	
		//헤더 클래스 추가
		$("#header").addClass("goods_head");
		//바디 클래스 추가
		$("body").addClass("bg_goods discount");
		
		$("#subTitle").text("할인");
		
		topTitle();
		categoryFn();

		$('#selectOption [value=${c.ctgrId}]').attr("selected", "true");
	    
	    //(스크롤)페이징
// 	    $(window).scroll(function(){
// 	        if ($(window).scrollTop() >= $(document).height() - $(window).height() - 100){
// 	        	obj.loadData();
// 	       }
// 	    });
		obj.chageCtgry();
	});
	
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
		           ,url: "/m/biz/hot/best?dispMstrId=${c.dispMstrId}&lazy=Y&pagingLoad=true&ctgrId=" + $('#selectOption').val() //+ "&page=" + obj.page
		           ,dataType: "html"
		           ,success : function(htmlStr){
		        	   if(obj.page == 1){
		        		   $("#dataList").empty();
		        	   }
		        	   
		               $("#dataList").append(htmlStr);
		               $("#loading").hide();
		               $("img.lazy").lazyload({placeholder:'/images/no_image2.gif',effect : "fadeIn"});
		               
		               if($.trim(htmlStr) != ""){
		                   obj.page++;
		                   $("input[name=eofObj]").val("0");
		               }
		           }
		           ,error: function(data) {
		               alert('<fmt:message key="error.common.system"/>');
		               $("#loading").hide();
		           }
		       });
		    }
		}
		,chageCtgry : function(){	/*	카테고리 변경 시	*/
			obj.page = 1;
			obj.loadData();
		}
	};
</script>

<div id="content">
	<div class="goods_wrap category_wrap">
		<input type="hidden" name="eofObj" value="0"/>
		<h2 class='tit_product'>할인</h2>
		<div class="sales_inner">
			<div class="pd_filter">
				<div class="form_select">
					<select class='resize_select' id="selectOption" onchange="javascript:obj.chageCtgry();">
					    <option value="0000">전체</option>
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
					</select>
				</div>
			</div>
			<div class="pd_list">
				<ul id="dataList">
					<!-- //prod -->
				</ul>
			</div>
		</div>
	</div>
</div>