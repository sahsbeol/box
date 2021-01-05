<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ul class="txt_list">
    <li><strong>상품군 : </strong>화장품</li>
    <li><strong>제조사 : </strong>${prdtNotiInfo.mnftr}</li>
    <li><strong>제조국 : </strong>${prdtNotiInfo.plorg}</li>
    <li><strong>용량 또는 중량 : </strong>${prdtNotiInfo.size1}</li>
    <li><strong>수입여부 : </strong>${prdtNotiInfo.impYn eq 'Y'?'수입':'국산'}</li>
    <li><strong>주요성분: </strong>${prdtNotiInfo.components}</li>
    <li><strong>제품 주요 사항: </strong>${prdtNotiInfo.mainPoint}</li>
    <li><strong>사용기한 또는  개봉 후 사용기간: </strong>${prdtNotiInfo.dtInfo}</li>
    <li><strong>식품의약품안전청 심사필 유무 : </strong>${prdtNotiInfo.etc1}</li>
    <li><strong>사용방법 : </strong>${prdtNotiInfo.useMethd}</li>
    <li><strong>사용 시 주의사항 : </strong>${prdtNotiInfo.caution}</li>
    <li><strong>품질보증기준 : </strong>${prdtNotiInfo.wrntPolicy}</li>
    <li><strong>소비자상담 : </strong>${prdtNotiInfo.asMngrName} / ${prdtNotiInfo.asTelNum}</li>
</ul>