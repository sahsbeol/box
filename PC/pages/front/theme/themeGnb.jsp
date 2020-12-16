<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui"%>
<script type="text/javascript">
</script>
<p class="diary_top_banner">
    <c:forEach items="${listGnb}" var="l" varStatus="st">
        <ui:banner bnrLinkUrl="${l.bnrLinkUrl}" bannerImageUrl="${l.bnrImageUrl}" bnrTgtGbn="${l.bnrTgtGbn}" bnrSeq="${l.bnrSeq}" newWdwYn="${l.bnrNewWdwYn}" width="950px" height="165px"/>
    </c:forEach>
</p>