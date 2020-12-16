<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="popup"/>
<head>
<script type="text/javascript">
jQuery(function($){
    window.resizeTo(610,500);
});
</script>
</head>
<body>
<div style="width:600px;">
    <h1><img src="${imageServer}/images/renewal/common/tit_pop_txin_request_list.gif" alt="세금계산서 신청내역" /></h1>
    <div class="pop_cont">
        <ul class="list_type02 li_fl">
            <li>신청자명 : ${txinRequest.sscbrName}</li>
            <li>연락처 : ${txinRequest.sscbrTelNum}</li> 
            <li>주문번호 : <c:forEach items="${orderNumList}" var="orderNum" varStatus="status"><c:if test="${status.count>1}">,</c:if>${orderNum}</c:forEach> </li>
            <li>신청일자 : <fmt:formatDate value="${txinRequest.reqDtm}" pattern="yyyy-MM-dd"/></li>
            <li>발급일자 : <fmt:formatDate value="${txinRequest.issuedtm}" pattern="yyyy-MM-dd"/></li>
        </ul>
        <table class="table02 mgt15">
            <caption>세금계산서 신청내역 <span>사업자등록번호, 상호(법인명), 대표자명, 업태, 종목, 사업장소재지, 담당자명, 이메일 주소</span></caption>
            <colgroup>
                <col style="width:95px" />
                <col style="width:180px" />
                <col style="width:95px" />
                <col style="width:*" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row">사업자등록번호</th> 
                    <td>${txinRequest.bizRegNum}</td> 
                    <th scope="row">상호(법인명)</th>
                    <td>${txinRequest.vndrName}</td> 
                </tr>  
                <tr> 
                    <th scope="row">대표자명</th> 
                    <td>${txinRequest.primeName}</td> 
                    <th scope="row">업태</th> 
                    <td>${txinRequest.bizTypeInfo}</td> 
                </tr> 
                <tr> 
                    <th scope="row">종목</th>
                    <td>${txinRequest.bizKindInfo}</td> 
                    <th scope="row">사업장소재지</th> 
                    <td>${txinRequest.vndrAddr}</td> 
                </tr>   
                <tr> 
                    <th scope="row">담당자명</th> 
                    <td>${txinRequest.sscbrName}</td> 
                    <th scope="row">이메일 주소</th> 
                    <td>${txinRequest.emailAddr}</td> 
                </tr>
            </tbody>
        </table>
    </div>
    <div class="pop_close">
        <a href="javascript:self.close();">닫기</a>
    </div>
</div> 
</body>