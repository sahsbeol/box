<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="popup"/>
<html>
<head>
<script type="text/javascript">
jQuery(function() {
    // 선택버튼
    $("#selectBiz").click(function(event) {
        event.preventDefault();
        if(isEmpty($("input[name='userBizRegNumSeq']:checked").val())) {
            alert("<fmt:message key='error.not.selected'/>");
            return;
        }
        
        opener.callBackSearchTxinRequest($("input[name='userBizRegNumSeq']:checked").val());
        window.close();
    });
    
    $("#registBiz").click(function() {
        window.open('/ht/mypage/createFormTxinRequest', '' , 'width=820,height=460');
    });
    
    $("#cancelBiz").click(function(event) {
        event.preventDefault();
        self.close();
    });
});
</script>

</head>
<body>
<div style="width:820px">
    <h1><img src="${imageServer}/images/renewal/common/h2_popup_mypage07.gif" alt="사업자등록번호 조회" /></h1>
    <div class="pop_cont">
        <div class="t_right mgb25">
            <a href="#n" class="btn_type01" id="registBiz">등록</a>
        </div>
        <table class="table02 mgt15">
            <colgroup>  
                <col width="10%" />
                <col width="20%" />
                <col width="10%" />
                <col width="20%" />
                <col width="20%" />
                <col width="20%" />
            </colgroup>
            <thead>
                <tr>
                    <th scope="col">선택</th>
                    <th scope="col">상호(법인명)</th>
                    <th scope="col">대표자명</th>
                    <th scope="col">사업자등록번호</th>
                    <th scope="col">업태</th>
                    <th scope="col">종목</th>
                </tr>
            </thead>
            <tbody class="one">
                <c:if test="${empty userBusinessRegistNumList}"><tr><td colspan="6" class="no_data">검색된 사업자등록번호가 없습니다.</td></tr></c:if>
                <c:forEach items="${userBusinessRegistNumList}" var="l" varStatus="st" >
                    <tr> 
                        <td><input name="userBizRegNumSeq" type="radio" value="${l.userBizRegNumSeq}" class="radios" title="[${l.userBizRegNumSeq}]번 사업자등록번호 선택"/>${l.userBizRegNumSeq}</td>  
                        <td>${l.vndrName}</td> 
                        <td>${l.primeName}</td> 
                        <td>${l.bizRegNum}</td> 
                        <td>${l.bizTypeInfo}</td> 
                        <td>${l.bizKindInfo}</td> 
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="t_center mgt15">
            <a href="#n" class="btn_type01" id="selectBiz">선택</a>
            <a href="#n" class="btn_type02" id="cancelBiz">취소</a>
        </div>
    </div>
</div>
<div class="pop_close">
    <a href="javascript://" onclick="self.close()">닫기</a>
</div>
</body>
</html>