<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div id="snb">
    <p><img src="http://image.hottracks.co.kr/info/story/txt_snb_story.png" alt="�̾߱�"/></p>
    <ul>
        <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/story/notice') >= 0}"> class="active"</c:if>><a href="/company/story/notice" class="snb_tit" title="�˷��帳�ϴ�">�˷��帳�ϴ�</a></li>
        <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/story/event') >= 0}"> class="active"</c:if>><a href="/company/story/event" class="snb_tit" title="�̺�Ʈ">�̺�Ʈ</a></li>
        <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/story/sign') >= 0}"> class="active"</c:if>><a href="/company/story/sign" class="snb_tit" title="����ȸ">����ȸ</a></li>
        <li<c:if test="${fn:indexOf(pageContext.request.requestURI,'/company/story/story') >= 0}"> class="active"</c:if>><a href="/company/story/story" class="snb_tit" title="��Ʈ�����̾߱�">��Ʈ�����̾߱�</a></li>
    </ul>
</div>
