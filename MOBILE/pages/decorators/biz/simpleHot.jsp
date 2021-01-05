<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
		<!-- 태그 라이브러리 -->
		<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
		
		<meta charset="utf-8"/>
		<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,viewport-fit=cover">
		<meta name="format-detection" content="telephone=no, address=no, email=no" /> 
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"> 
		
		<title><decorator:title default="HOTTRACKS - 생활 속 감성충전소"/></title>
		<c:import url="/pages/decorators/biz/importHeader.jsp"/>
		
		<decorator:head/>
	</head>
	<script>
		$(document).ready(function(){	
			sideMenu();//side menu	
			
			// app bar 호출
			$.ajax({
		        type: "POST"
		        ,url: "/m/biz/quickmenu"
		        ,dataType: "html"
		        ,success : function(html){
		            $("body").append(html);
		        } 
		        ,error: function(data) {
		        }
		    });
		});
	</script>
	<body>
<!-- 		<div id="loading" class="loadingbar"> -->
<!-- 			<img src="/images/common/ajax-loader.gif"/> -->
<!-- 		</div> -->
		
		<div id="wrap" class='content_new'>
			<!-- 데코레이터 공통 컨텐츠 영역 -->
			<decorator:body/>
			<!-- //데코레이터 공통 컨텐츠 영역 -->
		</div>
	</body>
</html>