<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="order"/>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>
<script type="text/javascript">
$(function(){
	$("input[name=click]").click(function(){
		$("#couponForm").ajaxSubmit({
			type : "POST"
			, success : function(result){
				if(result.save){
					alert("Complete")
				} else {
					var errorMessages = result.errorMessages;
					alert(errorMessages.join("\n"));
				}
			}
			,error: function(xhr, status, error) {
				alert("<fmt:message key='error.common.system'/>");
			}
		});
	})
});
</script>
</head>
<body>
<form id="couponForm">
	<input type="text" name="trackGcardNum" />
	<input type="button" name="click" value="jahskdja"/>
</form>
</body>
</html>