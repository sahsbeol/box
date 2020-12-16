<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="popup"/>
<html>
<head>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<link rel="stylesheet" type="text/css" href="/css/contents.css"/>
<script type="text/javascript" charset="utf-8">
</script>
</head>
<body>
<div id="popup">
	<div class="pop-head" >
		<h1><img src="${imageServer}/images/popup/h1_logo.gif" alt="Hottracks" /></h1>
		<h2><img src="${imageServer}/images/popup/h2_popup_mypage05.gif" alt="배송정보안내" /></h2>
	</div>
	<div class="pop_body"><!-- pop-body 을 pop_body으로 변경 -->

		<table class="order_table01">
			<colgroup>
				<col width="50%" />
				<col width="50%" />
			</colgroup>
			<thead>
				<tr>
					<th>택배사</th>
					<th>운송장번호</th>
				</tr>
			</thead>
			<tbody class="one">
				<tr>
					<c:choose>
						<c:when test="${empty dlvyInfo.sendNo}">
							<td colspan="2" class="center">현재 배송정보 : <ui:code codeId="${dlvyInfo.dlvyStatusCode}"></ui:code></td>
						</c:when>
						<c:otherwise>
							<td class="center">${dlvyInfo.tcbName}</td>
							<td class="link center">
								<a href="${dlvyInfo.tcbUrl}${dlvyInfo.sendNo }" target="_blank">${dlvyInfo.sendNo}</a>
							</td>	
						</c:otherwise>
					</c:choose>
				</tr>  
			</tbody>  
		</table>
	</div> 
	<div class="popup-foot">
		<button type="button" onclick="self.close()"><img src="${imageServer}/images/popup/btn_close.gif" alt="닫기" /></button>
	</div>  
</div> </body>
</html>