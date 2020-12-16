<%@page contentType="video/x-ms-asf;charset=euc-kr"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String agent = request.getHeader("user-agent");
	
	System.out.println(agent);
%>
<ASX Version="3.0"> 

<TITLE><c:if test="${not empty _playList}"><c:out value="${_playList[0].albumNm}"/></c:if></TITLE>
<Logo href="http://media.hottracks.co.kr/audio/httsicon.gif" Style = "ICON"></Logo> 

<%	
	// WMP 가 아닌 경우 음원 리스트 반환하지 않음.......
	if(agent != null && agent.startsWith( "Windows-Media-Player/") )
	{
%>
<c:forEach var="entity" items="${_playList}">
<ENTRY>	    
<TITLE><c:out value="${entity.cdNo}"/>/<c:out value="${entity.trackNo}"/>||<c:out value="${entity.trackSong}"/></TITLE>											
<REF HREF="mms://media.hottracks.co.kr/<c:out value="${entity.path}"/>/<c:out value="${entity.url1}"/>/<c:out value="${entity.url2}"/>/<c:out value="${entity.url3}"/>/<c:out value="${entity.musicCd}"/><c:out value="${entity.cdNo}"/><c:out value="${entity.trackNo}"/>.asf"/>
<c:if test="${entity.fullYn eq 'N'}">
<starttime value = "00:00:10"/>                                              
<Duration value = "00:01:00" />
</c:if>  
</ENTRY>
</c:forEach>		
<%
	}
%>
</ASX>