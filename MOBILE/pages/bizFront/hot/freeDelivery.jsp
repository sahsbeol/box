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
		$("body").addClass("bg_goods ship");
		
		$("#subTitle").text("무료배송");
		
		topTitle();
		categoryFn();
		
		$('a[resizing_select=${c.ctgrId}]').addClass('on');
		
		//상품 불러오기
	    obj.loadData(1);


// 	    (스크롤)페이징
// 	    $(window).scroll(function(){
// 	        if ($(window).scrollTop() >= $(document).height() - $(window).height() - 100){
// 	        	obj.loadData();
// 	        }
// 	    });
	});
	
	var obj = {
		loadData : function(resizing_select){	/*	페이징		*/
		    if($("[name=eofObj]").val() == "0"){
		        $("#loading").show();
		        $("input[name=eofObj]").val("1");
		        
		        $.ajax({
		            type: "GET"
		           ,async:false
		           ,url: "/m/biz/hot/best?dispMstrId=${c.dispMstrId}&lazy=Y&pagingLoad=true&ctgrId=" + resizing_select
		           ,dataType: "html"
		           ,success : function(htmlStr){
	        		   $('.list_price a').removeClass('on');
	        		   $('a[resizing_select='+resizing_select+']').addClass('on');
	        		   
	        		   $("#dataList").empty();
		        	   
		               $("#dataList").append(htmlStr);
		               $("#loading").hide();
		               $("img.lazy").lazyload({placeholder:'/images/no_image2.gif',effect : "fadeIn"});
		               
		               if($.trim(htmlStr) != ""){
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
	};
</script>

<div id="content">
	<div class="goods_wrap category_wrap">
		<input type="hidden" name="eofObj" value="0"/>
		<h2 class='tit_product'>무료배송</h2>
		<div class="sales_inner">
			<ul class='list_price clear'>
				<li><a href="javascript:" resizing_select='1' onclick="javascript:obj.loadData('1');">~ 1만원</a></li>
				<li><a href="javascript:" resizing_select='2' onclick="javascript:obj.loadData('2');">~ 2만원</a></li>
				<li><a href="javascript:" resizing_select='3' onclick="javascript:obj.loadData('3');">~ 3만원</a></li>
			</ul>
			<div class="choice_price"></div>
			<div class="pd_list">
				<ul id="dataList" class="clear">
					<!-- //prod -->
				</ul>
			</div>
		</div>
	</div>
</div>