<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<ui:decorator name="none"/>
 			<ul>
       		<c:forEach items="${list}" var="dto" varStatus="status">
                  	<li>
                  			<a href="#product-estimation"><c:out value="${dto.title}" escapeXml="true"/></a>
                  	</li>
             </c:forEach>
            <ul>
<script type="text/javascript">
jQuery(function($) {
	if("${averageGrade}" == ""){
		//do't change detail's img src 
	}else{
		var imgSrc = $("#imgAverageGrade").attr("src").replace("5","${averageGrade}");
		$("#imgAverageGrade").attr("src", imgSrc);
	}
});
</script>