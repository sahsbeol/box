<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/common.js"></script>
<script type="text/javascript">
jQuery(function($){
});

function _buyNoew(){
    $("form#onClickBuyNowForm").ajaxSubmit({
        url: "/ht/bt/onClickBuyNow"
        ,dataType: "json"
        ,success: function checkSuccess(data) {
            if (data.result == 'OK') {
                alert("주문 되었습니다.");
            } else {
                if (data.resMsg == 'NoUser') {
                    alert("로그인 후 이용 가능 합니다.");
                }
            }
        }
        ,error: function(xhr, status, error) {
            alert("<fmt:message key='error.common.system'/>");
        }
    });
}

function prodDetailPopup(bcode) {
    window.open('/ht/bt/productDetail/' + bcode,'', 'width=940px, height=1000px, scrollbars=yes');
}

function callLastAddr() {
    
}
</script>
</head>
<body>
<div class="btob_cont">
<h1 class="btob_tit">기대감!만족감!아이디어!최선의 모습으로 감동을 드리는 핫트랙스 B2B멤버십 회원</h1>
<form id="onClickBuyNowForm" name="onClickBuyNowForm">
    <input type="hidden" name="btoburl" value="${btoburl}"/>
    <!-- 왼쪽 메뉴 -->
    <div class="mem_info">
        <div class="mem_info_l">
            <c:if test="${userYn =='Y'}">
                <p><em>${userInfo.name}</em>님, 안녕하세요.<br>고객님은 현재 <em>${userInfo.userGbn}</em>입니다.</p>
                <a href="/ht/bt/${btoburl}" class="more_info"><span>주문하기</span></a>
                <c:if test="${userInfo.gradeId == 'C1401'}">
                   <a href="/ht/bt/${btoburl}/confirm" class="more_info"><span>승인하기</span></a>
                </c:if>
                <a href="/ht/bt/${btoburl}/ordList" class="more_info"><span>주문내역</span></a>
            </c:if>
            <c:if test="${userYn == 'N'}">
                <p><em>로그인 후 이용 가능 합니다.</em></p>
            </c:if>
            <c:if test="${userYn == 'E'}">
                <p><em>이용자 등록이 되지 않았습니다.</em></p>
            </c:if>
        </div>
        <div class="mem_info_r">
            <table class="table04 ">
                <colgroup>
                    <col width="100px" />
                    <col width="*" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">주문자명</th>
                        <td>
                            <input name="ordName" class="input_txt" type="text" value="서국영"/>
                            <a class="btn_type01" onclick="javascript:callLastAddr();" href="javascript://">최근배송지</a>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">전화번호</th>
                        <td><input name="ordTel" class="input_txt" type="text" value="0237006539"/></td>
                    </tr>
                    <tr>
                        <th scope="row">핸드폰번호</th>
                        <td><input name="ordHp" class="input_txt" type="text" value="01029907461"/></td>
                    </tr>
                    <tr>
                        <th scope="row">주소</th>
                        <td>
                            <input name="ordZipcod" class="input_txt" style="width:50px;" type="text" value="10881"/>
                            <input name="ordAddr1" class="input_txt" style="width:200px;" type="text" value="경기도 부천시 상일로 "/>
                            <input name="ordAddr2" class="input_txt" style="width:200px;" type="text" value="반달마을 1819동 1107호"/>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">주문자요청</th>
                        <td><input name="ordMemo" class="input_txt" style="width:calc(100% - 12px);" type="text" value="금액 확인후 전화 부탁"/></td>
                    </tr>
                </tbody>
            </table>
            <div class="btn_wrap">
                <a class="btn_type11 bg_red" id="onClickBuyNow" href="#" onclick="_buyNoew();return false;">구매하기</a>
            </div>
        </div>
    </div>
    <div class="cate_prod">
        <div class="tab_wrap">
            <ul class="cate_tab tab_btn">
                <c:forEach items="${cateList}" var="cl" varStatus="st">
                    <li><a href="#ct0${cl.ctgrId}" <c:if test="${st.index == 0}">class="on"</c:if>><span>${cl.ctgrName}</span></a></li>
                </c:forEach>
            </ul>
            <div class="tab_pannels">
                <c:forEach items="${cateList}" var="cl" varStatus="st">
                    <c:set var="count" value="0"/>
                    <div id="ct0${cl.ctgrId}" class="btob_prod_list pannel">
                        <c:set var="cnt" value="0"/>
                        <c:forEach items="${cateProductList}" var="cpl" varStatus="st">
                            <c:if test="${not empty cpl.sellPrdtBcode && cl.ctgrId eq cpl.ctgrId}">
                                <div class="prod">
                                    <span class="img"><a href="" onclick="javascript:prodDetailPopup('${cpl.sellPrdtBcode}');return false;"><ui:image src="${cpl.productImageUrl}" src2="${cpl.productImageUrl2}" alt="${cpl.prdtName}" server="product" size="200"/></a></span>
                                    <span class="name">${cpl.prdtName}</span>
                                    <em class="price">
                                        <fmt:formatNumber var="dscntRate" pattern="##">${hfn:rate(cpl.prdtSellPrice, cpl.lastCpnPrice)}</fmt:formatNumber>
                                        <c:if test="${cpl.prdtSellPrice > cpl.lastCpnPrice}"><span class="pc">${dscntRate}%</span></c:if>
                                        <span class="sale"><fmt:formatNumber value="${cpl.lastCpnPrice}" pattern="#,###"/><em>원</em></span>
                                        <c:if test="${cpl.prdtSellPrice > cpl.lastCpnPrice}"><span class="dc"><fmt:formatNumber value="${cpl.prdtSellPrice}" pattern="#,###"/><em>원</em></span></c:if>
                                        <span class="count">
                                            <input name="sellPrdtBcode" title="상품코드" type="hidden" value="${cpl.sellPrdtBcode}"/>
                                            <input name="ordQty" title="수량입력" class="inputNumberText" style="ime-mode: disabled;width:50px;" type="text" maxlength="4" value="0"/>개
                                        </span>
                                    </em>
                                </div>
                                <c:choose>
                                    <c:when test="${cnt < 3}"><c:set var="cnt">${cnt + 1}</c:set></c:when>
                                    <c:otherwise>
                                        <c:set var="cnt" value="0"/>
                                        <hr/>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                        </c:forEach>
                        <c:if test="${cnt > 0}"><hr/></c:if>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</form>
</div>
</body>
</html>