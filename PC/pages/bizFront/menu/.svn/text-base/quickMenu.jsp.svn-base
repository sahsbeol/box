<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script type="text/javascript">
var firstYn = true;
$(document).ready(function(){
	loadHistoryTemplate(1);
});
function loadHistoryTemplate(page){
	
	if(page == null || page == "undefined"){
		page = 1;
	}
	
	$.ajax({
        type: "POST"
        ,url: "/menu/biz/getHistoryTemplete"
        ,data: { page : page }
        ,dataType: "html"
        ,success : function(data){
            
      		$("#recentFacelist").empty();
        	$("#recentFacelist").append(data);    
        	if(firstYn == true){
        		skyScraper();//scroll
        		firstYn = false;
        	}else{
        		//편집모드라면 편집취소
        		if($('.lastest_prd .history_inner').hasClass('case01')){
        			$('.txt_blue').trigger("click");
        		}
        	}
        	skyScraper02();
        	
        }
        ,error: function(data) {        	
            alert('<fmt:message key="error.common.system"/>');
        }
    });    
}
</script>
<aside id='skyscraper' class="quick_menu">
	<c:if test="${not empty skyBrnInfo}">
		<div class='bnr_wrap'>
			<a href="${skyBrnInfo.bnrLinkUrl}" class='btn_banner'>
				<ui:image src="${skyBrnInfo.imageUrlPc}" alt="${skyBrnInfo.imageAlt}"/>
			</a>
			<a href="${skyBrnInfo.bnrLinkUrl}" class='btn_large'>
				<ui:image src="${skyBrnInfo.overImageUrlPc}" alt="${skyBrnInfo.imageAlt}"/>
			</a>
		</div>
	</c:if>	
	<div id="recentFacelist">
	</div>
	<div class='btn_goTop'>
		<a href="javascript:"><img src="/images/biz/common/go_top.png" alt="페이지 상단으로 가기">TOP</a>
	</div>
</aside>