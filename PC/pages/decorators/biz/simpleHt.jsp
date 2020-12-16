<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
		<!-- 태그 라이브러리 -->
		<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
		
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="Content-Script-Type" content="text/javascript">
		<meta http-equiv="Content-Style-Type" content="text/css">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=950">
		
		<title><decorator:title default="HOTTRACKS - 생활 속 감성충전소"/></title>
		<c:import url="/pages/decorators/biz/simpleImportHeader.jsp"/>
		
		<decorator:head/>
	</head>
	
	<body>
		<div id="wrap" class='content_new'>
			<!-- 데코레이터 공통 컨텐츠 영역 -->
			<!-- Container -->
		    <div id="container">
		        <!-- 컨텐츠 -->
		        <div class="content" id="content">
					<decorator:body/>
				</div>
        		<!-- //컨텐츠 -->
    		</div>
    		<!-- //Container -->
			<!-- //데코레이터 공통 컨텐츠 영역 -->
		</div>
	</body>
</html>