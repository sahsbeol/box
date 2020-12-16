<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
	
		<table>
			<colgroup> 
				<col width="50%" /> 
				<col width="45%" /> 
				<col width="5%" />						
			</colgroup>
			<thead>
				<tr>  
					<th>곡명</th>    
					<th>아티스트/음반</th>
					<th class="bg_none">듣기</th> 
				</tr>
			</thead>    
			<tbody>
				<c:forEach items="${recordAllSoundList}" var="sound" varStatus="status">
					<tr>
						<td class="left">${sound.trkName}<em></em></td>
						<td>${sound.name}/<a href="/ht/record/detail/${sound.sellPrdtBcode}">${sound.sbttl}<c:if test="${empty sound.sbttl}">${sound.rcrdName}</c:if></a></td>
						<td>
							<c:if test="${sound.audioYn eq 'Y'}">
								<a href="javascript:musicPlayer.base.openPlayerHot('${sound.rcrdCd}','${sound.cdNo}','${sound.trkNo}');"><img src="${imageServer}/images/sound/btn_listen.png" class="iepngfix" alt="듣기" /></a>
							</c:if>
							<c:if test="${sound.audioYn ne 'Y'}">
								<img src="${imageServer}/images/sound/btn_listen_off.png" class="iepngfix" alt="듣기" />
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody> 
		</table>							
		<div class="pager">
            <ui:paginationScript name="pageHolder" scriptName="pageGoRecordAllSoundList" parameters="code,recordType"/>
        </div><!-- end pager -->