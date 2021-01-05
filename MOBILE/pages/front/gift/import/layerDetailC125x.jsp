<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ul class="txt_list">
    <li><strong>상품군 : </strong>디지털 콘텐츠(음원, 게임, 인터넷강의 등)</li>
    <li><strong>제작자/공급자 : </strong>${prdtNotiInfo.mnftr}</li>
    <li><strong>제조국 : </strong>${prdtNotiInfo.plorg}</li>
    <li><strong>수입여부 : </strong>${prdtNotiInfo.impYn eq 'Y'?'수입':'국산'}</li>
    <li><strong>이용조건/이용기간 : </strong>${prdtNotiInfo.dtInfo}</li>
    <li><strong>상품제공방식 : </strong>${prdtNotiInfo.mainPoint}</li>
    <li><strong>최소 시스템 사양 필수 소프트웨어 : </strong>${prdtNotiInfo.caution}</li>
    <li><strong>청약철회 또는 계약의 해제,해지에 따른 효과 : </strong>${prdtNotiInfo.addPrice}</li>
    <li><strong>소비자상담 : </strong>${prdtNotiInfo.asMngrName} / ${prdtNotiInfo.asTelNum}</li>
</ul>