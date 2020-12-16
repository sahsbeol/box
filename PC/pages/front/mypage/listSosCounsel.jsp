<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<title>SOS상담 | 쇼핑도우미 | MY HOTTRACKS - HOTTRACKS</title>
<script type="text/javascript">
jQuery(function($){
    $("tbody#sosTbody tr td a.click").click(function(event) {
        event.preventDefault(); // # 링크 이동 중지
        var returnSeq = $(this).attr("id");
        var tr = $($(this).attr("href"));
        if(!tr.hasClass("on")){
            $.ajax({
                type: "GET"
                , url: "/ht/mypage/getSosCounsel"
                , data: "returnSeq=" + returnSeq
                , dataType: "json"
                , success: function(data) {
                    var counsel = data.counsel;
                    var listProduct = counsel.listProduct;
                    var listProductStr = "";
                    var htmlStr = "";
                    
                    if (listProduct.length >= 1) {
                        listProductStr = "[" + counsel.orderNum + "] " + listProduct[0].productName;
                    }
                    
                    var htmlStr;
                    htmlStr += "<div class=\"one\">";
                    htmlStr += "    <p style='padding:5px 0;'><strong>문의]</strong> <em>" + counsel.counselTitle + "</em></p>";
                    htmlStr += "    <p style='padding:5px 0;color:#FF0000;'>" + listProductStr + "</p>";
                    htmlStr += "    <p style='padding:5px 0;'>" + counsel.counselContent + "</p>";
                    htmlStr += "</div>";
                    
                    if (counsel.sosProcessGubun == "E") {
                        htmlStr += "<div class=\"two\">";
                        htmlStr += "    <p style='padding:5px 0;'><strong>답변]</strong></span> <em>답변일시 : " + counsel.lastModifyDtm + "</em>";
                        htmlStr += "    <p style='padding:5px 0;'>" + counsel.replyContent + "</p>";
                        htmlStr += "</div>";
                     }
                     tr.find("div").html(htmlStr);
                }
                , error: function() {
                    alert("<fmt:message key='error.common.system'/>");
                }
            });
            
            tr.addClass("on");
        }else{
            tr.removeClass("on");
        }
    });
    
    $("tbody#sosTbody tr td a.del_click").click(function(event) {
        event.preventDefault(); // # 링크 이동 중지
        var returnSeq = $(this).attr("id");
        var tr = $($(this).attr("href"));
        
        if (confirm("삭제하시겠습니까?")) {
            $.ajax({
                type: "GET"
                , url: "/ht/mypage/deleteSosCounsel"
                , data: "returnSeq=" + returnSeq
                , dataType: "json"
                , success: function(data) {
                    if (data.isDeleted) {
                        tr.prev().remove();
                        tr.remove();
                    } else {
                        alert("삭제할 수 없습니다.");
                    }
                }
                , error: function() {
                    alert("<fmt:message key='error.common.system'/>");
                }
            });
        }
    });
});
</script>
</head>
<body>
<!-- sub top -->
<div class="page_location">
    <h2 class="title"><img src="${imageServer}/images/renewal/common/tit_my_hottracks.gif" alt="My Hottracks"/></h2>
    <div class="loc"><a href="/" class="home">Home</a><em>MY HOTTRACKS</em></div>
</div>
<!-- //sub top -->

<c:import url="/menu/mypage/lnb"/>

<!-- sub contents -->
<div class="sub_contents">
    
    <h3 class="page_title mgt0"><img src="${imageServer}/images/renewal/common/tit_list_sos_counsel.gif" alt="SOS상담" /></h3>
    <ul class="list_type02">
        <li>고객님이 접수하신 상담 및 처리내역을 확인하실 수 있습니다.</li>
        <li>고객센터 운영시간은 오전 9시~오후 6시 (토/일/공휴일 제외) 입니다.</li>
        <li>영업점 이용상담의 문의는 등록하신 <span class="point02">이메일 또는 전화번호로 회신</span>을 드립니다.</li>
    </ul>
    
    <div class="btn_area mgt50">
        <a href="/ht/help/sosCounselMain" class="btn_type01">SOS 상담접수</a>
    </div>
    <table class="bbs_list01 mgt15">
        <caption>SOS상담 <span>접수일, 상담구분, 제목, 답변여부, 삭제</span></caption>
        <colgroup>
            <col style="width:90px" />
            <col style="width:90px" />
            <col style="width:*" />
            <col style="width:90px" />
            <col style="width:80px" />
        </colgroup>
        <thead>
            <tr>
                <th scope="col" class="fir">접수일</th>
                <th scope="col">상담구분</th>
                <th scope="col">제목</th>
                <th scope="col">답변여부</th>
                <th scope="col" class="last">삭제</th>
            </tr>
        </thead>
        <tbody id="sosTbody">
            <c:forEach items="${listCounsel}" var="l">
                <tr> 
                    <td><fmt:formatDate value="${l.registDtm}" pattern="yyyy.MM.dd"/></td>
                    <td><ui:code codeId="${l.sosCounselCode}"/></td>
                    <td class="t_left"><a href="#sos-content0${l.returnSeq}" id="${l.returnSeq}" class="click">${l.counselTitle}</a></td> 
                    <td>${l.sosProcessGubun ne 'E'?'미완료':'완료'}</td> 
                    <td>
                        <c:if test="${empty l.returnStatusCode && l.sosProcessGubun eq 'N'}">
                            <a href="#sos-content0${l.returnSeq}" id="${l.returnSeq}" class="btn_type02 del_click">삭제</a>
                        </c:if>
                    </td>
                </tr>
                <tr class="conts" id="sos-content0${l.returnSeq}"><td colspan="5"><div class="txt"></div></td></tr>
            </c:forEach>
            <c:if test="${empty listCounsel}"><tr><td colspan="5" class="no_data">SOS상담 내역이 없습니다.</td></tr></c:if>
        </tbody>
    </table>

    <!-- paging -->
    <div class="paging">
        <ui:pagination name="pageHolder" url="/ht/mypage/listSosCounsel" parameters=""/>
    </div>
    <!-- //paging -->

</div>
<!-- //sub contents -->
</body>
</html>