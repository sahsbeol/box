<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ul class="txt_list">
    <li><strong>상품군 : </strong>상품권/쿠폰</li>
    <li><strong>발행자 : </strong>${prdtNotiInfo.mnftr}</li>
    <li><strong>제조국 : </strong>${prdtNotiInfo.plorg}</li>
    <li><strong>수입여부 : </strong>${prdtNotiInfo.impYn eq 'Y'?'수입':'국산'}</li>
    <li><strong>유효기간/이용조건 : </strong>${prdtNotiInfo.dtInfo}</li>
    <li><strong>이용가능매장 : </strong>${prdtNotiInfo.mainPoint}</li>
    <li><strong>잔액환급조건 : </strong>${prdtNotiInfo.addPrice}</li>
    <li><strong>소비자상담 : </strong>${prdtNotiInfo.asMngrName} / ${prdtNotiInfo.asTelNum}</li>
</ul>