<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ul class="txt_list">
    <li><strong>상품군 : </strong>귀금속/보석/시계류</li>
    <li><strong>제조사 : </strong>${prdtNotiInfo.mnftr}</li>
    <li><strong>제조국 : </strong>${prdtNotiInfo.plorg}</li>
    <li><strong>치수 : </strong>${prdtNotiInfo.size1}</li>
    <li><strong>중량 : </strong>${prdtNotiInfo.size2}</li>
    <li><strong>품질 보증서 : </strong>${prdtNotiInfo.etc1 eq 'Y'?'제공':'제공안함'}</li>
    <li><strong>수입여부 : </strong>${prdtNotiInfo.impYn eq 'Y'?'수입':'국산'}</li>
    <li><strong>소재/순도/밴드재질: </strong>${prdtNotiInfo.material}</li>
    <li><strong>착용시 주의사항: </strong>${prdtNotiInfo.caution}</li>
    <li><strong>주요 사항 : </strong>${prdtNotiInfo.mainPoint}</li>
    <li><strong>품질보증기준 : </strong>${prdtNotiInfo.wrntPolicy}</li>
    <li><strong>A/S : </strong>${prdtNotiInfo.asMngrName} / ${prdtNotiInfo.asTelNum}</li>
</ul>