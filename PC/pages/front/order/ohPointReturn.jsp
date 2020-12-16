<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<html>
<head>
<script language="JavaScript">
if ("0000" == "${param.RESP_CODE}") {
    opener.document.forms['OPOINT_Result'].OH_RESP_CODE.value   = "${param.RESP_CODE}";
    opener.document.forms['OPOINT_Result'].OH_RESP_MSG.value    = "${param.RESP_MSG}";
    opener.document.forms['OPOINT_Result'].OH_MID.value         = "${param.MID}";
    opener.document.forms['OPOINT_Result'].OH_TRANS_DTTM.value  = "${param.TRANS_DTTM}";
    opener.document.forms['OPOINT_Result'].OH_M_REF_NO.value    = "${param.M_REF_NO}";
    opener.document.forms['OPOINT_Result'].OH_CHANNEL_TYPE.value ="${param.CHANNEL_TYPE}";
    opener.document.forms['OPOINT_Result'].OH_TRAN_DATE.value   = "${param.TRAN_DATE}";
    opener.document.forms['OPOINT_Result'].OH_TRAN_TIME.value   = "${param.TRAN_TIME}";
    opener.document.forms['OPOINT_Result'].OH_CARD_NO.value     = "${param.CARD_NO}";
    opener.document.forms['OPOINT_Result'].OH_TID.value         = "${param.TID}";
    opener.document.forms['OPOINT_Result'].OH_USABLE_POINT.value ="${param.USABLE_POINT}";
    opener.document.forms['OPOINT_Result'].OH_MATCH_KEY.value   = "${param.MATCH_KEY}";
    opener.document.forms['OPOINT_Result'].OH_VERIFY_V.value    = "${param.VERIFY_V}";
    opener.location.href("javascript:ohPointSearch();");
} else {
    alert("${param.RESP_MSG}");
}
window.close();
</script>
</head>
<body>
</body>
</html>