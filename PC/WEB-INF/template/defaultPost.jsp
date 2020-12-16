<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script type="text/javascript">
function pageSubmit(page){
	var pageInput = $("input[name=page]");
	
	if(pageInput.length > 0) {
		pageInput.val(page);
	} else {
		$("<input />").attr({"type":"hidden","name":"page","value":page}).appendTo("form[name=searchedForm]");
		//$("<input />").attr({"type":"hidden","name":"pageSubmit","value":"Y"}).appendTo("form[name=searchedForm]");
	}
	
	$("form[name=searchedForm]").submit();
}
</script>
<c:if test="${pageInfo.totalPage > 0}">
    <a title="맨 처음 페이지로 이동" onclick="pageSubmit(1);" class="first" href="javascript://">처음</a>
    <c:if test="${pageInfo.startPage > 1}">
        <a onclick="pageSubmit(${pageInfo.previousScalePage})" class="prev02" href="javascript://">이전</a>
    </c:if>
    <ul>
        <c:forEach items="${pageInfo.pages}" var="page" varStatus="status">
            <c:if test="${pageInfo.currentPage != page}">
                <li><a onclick="pageSubmit(${page})" href="javascript://">${page}</a></li>
            </c:if>
            <c:if test="${pageInfo.currentPage == page}">
                <li class="active"><a href="javascript://">${page}</a></li>
            </c:if>
        </c:forEach>
    </ul>
    <c:if test="${pageInfo.nextScalePage <= pageInfo.totalPage}">
        <a title="${pageInfo.nextScalePage}페이지로 이동" href="javascript://" onclick="pageSubmit(${pageInfo.nextScalePage})" class="next02">다음</a>
    </c:if>
</c:if>
