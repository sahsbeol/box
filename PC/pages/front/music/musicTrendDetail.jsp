<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="${decorator}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function(){
//jQuery(function($) {
    
    $("div.lookallboxA").hide();
    
    // 아이콘 선택
    $('.lookallboxA > p, .lookallboxB > p').live('click', function() {

        var iconIdx = 0;
        var iconClassName = "";
        var lookallbox = "A";
        var iConMaxLen = $("div.lookallboxA > p").length;
    
        if(!$(this).parent().hasClass('lookallboxA')) {
            lookallbox = "B";
            iConMaxLen = $("div.lookallboxB > p").length;
        }
        
        // 10개의 아이콘에서 선택된 아이콘 위치.
        iconIdx = iConMaxLen - $(this).nextAll('p').length;
        if(iconIdx < 10) {
            iconIdx = "0"+iconIdx;
        }
        
        // 선택된 아이콘 명을 클래스 명으로 사용.
        iconClassName = "look"+iconIdx;
        
        // 선택된 아이콘으로 클래스명 변경하고 댓글, 답글 아이콘 숨기기
        if(lookallbox == "A") {
            $("div.lookboxA p").removeClass().addClass(iconClassName);
            $("div.lookallboxA").hide();
        } else {
            $("div.lookboxB p").removeClass().addClass(iconClassName);
            $("div.lookallboxB").hide();
        }
        
        // 선택된 아이콘 ID
        $('input[name=iconId]').val(iconClassName);
    });
    
    // 댓글, 답글 입력
    $(".txetAreaCommentsA, .txetAreaCommentsB").live('click', function() {
        
        var iconClassName = "";
        
        if($(this).hasClass('txetAreaCommentsA')) {
            
            $('div.lookboxA p').each(function() {
                iconClassName = $(this).attr('class');
            });
            
            // 선택된 아이콘으로 클래스명 변경
            $("div.lookboxA p").removeClass().addClass(iconClassName); 
            $('.txetAreaCommentsB').text("");
            $('.addTrCommentB').remove();
            $('div.lookallboxA').hide();

        } else {

            $('div.lookboxB p').each(function() {
                iconClassName = $(this).attr('class');
            });
            
            // 선택된 아이콘으로 클래스명 변경
            $("div.lookboxB p").removeClass().addClass(iconClassName); 
            $('.txetAreaCommentsA').text("");
            $('div.lookallboxB').hide();
        }
        
        // 선택된 아이콘 ID
        $('input[name=iconId]').val(iconClassName);
    });

    // 댓글 등록
    $('.saveCommentsA').click(function() {

        if($('.txetAreaCommentsA').val()== "" ) {
            alert("댓글을 입력해주세요.");
            return false;
        }

        if("${userNum}" == "") {
            alert("로그인후 댓글 입력이 가능합니다.");
            return false;
        }       
        
        // 1,2,3,4,5,6,7,8,9
        $('.txetAreaCommentsA').val($('.txetAreaCommentsA').val().split(',').join('&sbquo;'));
        
        
        
        $('input[name=commentsGubun]').val(0);
        $('input[name=trendCmtSeq]').val(); // 상위 댓글 고유번호
        $('input[name=step]').val(0);       // 답글 단계
        
        var url = "/ht/music/ajaxAddTrendComments";
        
        $("#form").ajaxSubmit({
            url: url
            ,dataType: "json"
            ,success: callbackSaveSuccess
            ,error: function(xhr, status, error) {
                alert("<fmt:message key='error.common.system'/>");
            }
        });
    });

    // 답글 등록
    $('.saveCommentsB').live('click', function() {
        
        if($('.txetAreaCommentsB').val()== "" ) {
            alert("답글을 입력해주세요.");
            return false;
        }

        if("${userNum}" == "") {
            alert("로그인후 답글 입력이 가능합니다.");
            return false;
        } 
        
        // 1,2,3,4,5,6,7,8,9
        $('.txetAreaCommentsB').val($('.txetAreaCommentsB').val().split(',').join('&sbquo;'));
        $('input[name=commentsGubun]').val(1);
        
        var url = "/ht/music/ajaxAddTrendComments";
        
        $("#form").ajaxSubmit({
            url: url
            ,dataType: "json"
            ,success: callbackSaveSuccess
            ,error: function(xhr, status, error) {
                alert("<fmt:message key='error.common.system'/>");
            }
        });
    });
});

//전체 선택 처리
function chkAll(chk){
    $("input[name=chkTrkId]").attr("checked", chk.checked);
}

// 아이콘 보이기
function iconView(iconType) {
    if(iconType == "A") {
        $("div.lookallboxA").show();
    } else {
        $("div.lookallboxB").show();
    }
}

// 댓글, 답글 삭제(사용여부 Y/N)
function updateCommentsUseYn(trendCmtSeq) {

    $('input[name=trendCmtSeq]').val(trendCmtSeq);
    
    var url = "/ht/music/ajaxUpdateTrendCommentsUseYn";
    
    $("#form").ajaxSubmit({
        url: url
        ,dataType: "json"
        ,success: callbackDelSuccess
        ,error: function(xhr, status, error) {
            alert("<fmt:message key='error.common.system'/>");
        }
    });
}

//댓글, 답글 저장 콜백함수
function callbackSaveSuccess(data) {

    if (data.save) {
        $('div#errorMessagesArea').html('');
        alert('<fmt:message key="message.save.success"/>');
        $('.txetAreaCommentsA').val('');
        //window.location.reload(true);
        addComments(data);
        
    } else {
        //alert('저장실패 하였습니다. 상단에 오류메시지를 확인하세요');
        var errorMessages = data.errorMessages;
        $('div#errorMessagesArea').html('');
        alert(errorMessages);
        for (var i = 0; i < errorMessages.length; i++) {
            //$('div#errorMessagesArea').append('<strong style="color:red">' + errorMessages[i] + '</strong>' + '<br/>');
        }
    }
}

//댓글, 답글 삭제 콜백함수
function callbackDelSuccess(data) {
    
    if (data.save) {
        $('div#errorMessagesArea').html('');
        alert('<fmt:message key="message.delete.success"/>');
        //window.location.reload(true);
        addComments(data);
        
    } else {
        //alert('삭제실패 하였습니다. 상단에 오류메시지를 확인하세요');
        var errorMessages = data.errorMessages;
        $('div#errorMessagesArea').html('');
        alert(errorMessages);
        for (var i = 0; i < errorMessages.length; i++) {
            //$('div#errorMessagesArea').append('<strong style="color:red">' + errorMessages[i] + '</strong>' + '<br/>');
        }
    }
}


// 답글 등록 textarea 추가
function addTextArea(obj, trendCmtSeq, dispNo, step) {

    $('textarea').val('');
    $('input[name=trendCmtSeq]').val(trendCmtSeq);
    $('input[name=dispNo]').val(dispNo);
    $('input[name=step]').val(step);
    
    $('.addTrCommentB').remove();

    // 답글 textarea 등록
    var trTag = ""
        +"<tr class=\"addTrCommentB\">"
            +"<td colspan=\"5\" class=\"reinput\">"
                +"<div class=\"look_topbox\">"
                    +"<div class=\"view_register\">"
                        +"<fieldset>"
                            +"<legend>코멘트 등록</legend>"
                            +"<div class=\"lookbox lookboxB\">"
                                +"<p class=\"look01\"></p>"
                                +"<button type=\"button\" onclick=\"iconView(\'B\')\" class=\"chbtn\"></button>"
                            +"</div>"
                            +"<textarea name=\"comments\" class=\"txetAreaCommentsB\" onkeyup=\"chkByte(this, '1000');\" cols=\"90\" rows=\"3\" title=\"코멘트입력\"></textarea>"
                            +"<img class=\"saveCommentsB\" src=\"${imageServer}/images/event/btn_regiter.gif\" alt=\"등록\" />"
                            +"<p class=\"txt f_bl89\">현재<span class=\"f_red_b commentBByte\">0</span> / 1000 bytes (최대 한글 500자, 영문 1000자)</p>"
                        +"</fieldset>"
                    +"</div>"
                    +"<div class=\"lookallbox lookallboxB\" style=\"display:none;\">"
                        +"<p class=\"look01\"></p>"
                        +"<p class=\"look02\"></p>"
                        +"<p class=\"look03\"></p>"
                        +"<p class=\"look04\"></p>"
                        +"<p class=\"look05\"></p>"
                        +"<p class=\"look06\"></p>"
                        +"<p class=\"look07\"></p>"
                        +"<p class=\"look08\"></p>"
                        +"<p class=\"look09\"></p>"
                        +"<p class=\"look10\"></p>"
                    +"</div>"
                +"</div>"   
            +"</td>"
        +"</tr>";

    $(obj).parent().parent().after($(trTag));

    $('.txetAreaCommentsB').keyup(function(){
        chkByte(this, 1000);
    });
}   

// 입력한 글자수 체크
function chkByte(obj, maxLen)
{
    var str     = $(obj).val();
    var strLen  = str.length;  // 전체길이
    var maxLen  = maxLen;     // 제한할 글자수 크기
    var byteLen = 0;  // 한글일경우는 2 그밗에는 1을 더함
    var len     = 0;  // substring하기 위해서 사용

    for(var i=0; i< strLen; i++)
    {
        // 한글이면 2를 더한다.
        if (escape(str.charAt(i)).length > 4) {
            byteLen = byteLen+2;
        
        }else if (str.charAt(i) == ','){
            byteLen += 11;
        } else { // 그외의 경우는 1을 더한다.
            byteLen++;
        }

        // 전체 크기가 maxLen를 넘지않으면
        if(byteLen <= maxLen) {
           len = i + 1;
        }
    }

    // 현재 글자 Byte
    if($(obj).hasClass('txetAreaCommentsA')) {
        $('.commentAByte').text(byteLen);
        $('.commentBByte').text("0");
    } else {
        $('.commentAByte').text("0");
        $('.commentBByte').text(byteLen);
    }
    
    // 전체길이를 초과하면
    if(byteLen > maxLen) {
        alert("최대 한글 500자, 영문 "+maxLen+"자 까지 글자를 입력할 수 있습니다. \n 초과된 내용은 자동으로 삭제 됩니다. ");
        // 글자수를 초과하면 제한할수 글자전까지만 보여준다.
        $(obj).val(str.substr(0, len));
        $('.commentAByte').text(maxLen);
    }
    
    //obj.focus();   
}

//댓글, 답글 추가
function addComments(data) {
    
    var trendCommentsList = data.trendCommentsList;
    
    var tbody = $('#commentsTbody');

    $('#commentsTbody tr').remove();

    var addTag = "";
    
    for(var i=0; i < trendCommentsList.length; i++) {

        addTag = ""
        +"<tr>"
            +"<td><p class=\"look left\"><span class=\""+ trendCommentsList[i]["iconId"] +"\"></span> <em>"+trendCommentsList[i]["userId"] +"</em></p></td>";
            if(parseInt(trendCommentsList[i]["step"]) == 0) {
                addTag+="<td class=\"left\">"+ trendCommentsList[i]["comments"].split("&amp;sbquo;").join(",") +"</td>" 
                +"<td><p class=\"dfont\">"+ trendCommentsList[i]["strRegstDtm"] +"</p></td>"
                +"<td class=\"center\"><a href=\"javascript: ;\" onclick=\"addTextArea(this, '"+ trendCommentsList[i]["trendCmtSeq"] +"', '"+ trendCommentsList[i]["dispNo"] +"', '"+ trendCommentsList[i]["step"] +"')\"><img src=\"${imageServer}/images/culturezone/btn_re01.gif\" alt=\"답글달기\" /></a></td>"
                +"<td class=\"center\">";
                if(data.userNum == trendCommentsList[i]["userNum"] && "N" == trendCommentsList[i]["subExist"]) {
                    addTag+="<a href=\"javascript: ;\" onclick=\"updateCommentsUseYn('"+ trendCommentsList[i]["trendCmtSeq"] +"')\"><img src=\"${imageServer}/images/event/btn_x.gif\" alt=\"삭제\" /></a>";
                }
                addTag+="</td>";
            }

            <%-- 답글 --%>
            if(parseInt(trendCommentsList[i]["step"]) > 0) {
                addTag+="<td class=\"re\">"+ trendCommentsList[i]["comments"].split("&amp;sbquo;").join(",") +"</td>" 
                +"<td><p class=\"dfont\">"+ trendCommentsList[i]["strRegstDtm"] +"</p></td>"
                +"<td class=\"center\"></td>"
                +"<td class=\"center\">";
                if(data.userNum == trendCommentsList[i]["userNum"] && "N" == trendCommentsList[i]["subExist"]) {
                    addTag+="<a href=\"javascript: ;\" onclick=\"updateCommentsUseYn('"+ trendCommentsList[i]["trendCmtSeq"] +"')\"><img src=\"${imageServer}/images/event/btn_x.gif\" alt=\"삭제\" /></a>";
                }
                addTag+="</td>";
            }
            <%-- //답글 --%>

        addTag+="</tr>";
        
        tbody.append($(addTag));
    }
}

// 통합 검색
function searchMain(searchTerm, searchMenu, subMenu, menuGroup) {
    //if(!serviceCheck()){
        // location.href = "/ht/search/searchMain?searchTerm="+encodeURI(searchTerm)+"&searchMenu="+searchMenu+"&subMenu="+subMenu+"&menuGroup="+menuGroup;
        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", "/ht/search/searchMain");
        document.body.appendChild(form);
        
        form.appendChild(getInputTag("searchTerm", searchTerm));
        form.appendChild(getInputTag("searchMenu", searchMenu));
        form.appendChild(getInputTag("subMenu", subMenu));
        form.appendChild(getInputTag("menuGroup", menuGroup));
         
        form.submit();
    //}
}

</script>
</head>

<body>
<div id="wrap">
    <div id="body"> 
    <div id="errorMessagesArea"></div>

        <!-- 이곳부터 추가해주시면 됩니다 -->
        <div id="container"> 
          
            <!-- 기본 현재 페이지 위치 소스 입니다 -->
            <div class="page_${baseClass}">
                <div class="page-location">
                    <p class="title"><img src="${imageServer}/images/${baseClass}/title_${baseClass}_<c:if test="${baseClass eq 'music'}">s09</c:if><c:if test="${baseClass eq 'sound'}">s05</c:if>.gif" alt="뮤직공감" /></p>
                    <ul>
                        <li><a href="/ht/welcomeMain">홈</a> <span>&gt;</span></li>
                        <li><a href="/ht/${decorator}Main"><c:if test="${baseClass eq 'music'}">음반</c:if><c:if test="${baseClass eq 'sound'}">음원</c:if></a> <span>&gt;</span></li>
                        <li><a href="/ht/music/${decorator}Trend">음악공감</a> <span>&gt;</span></li>
                        <li><strong><ui:code codeId="${trendInfo.trendType}"/></strong></li>
                    </ul> 
                </div>
            </div> 
            <!-- //기본 현재 페이지 위치 소스 입니다 -->
              
            <!-- snb -->
            <div class="snb_mnew">
                <div class="snb_${baseClass}">
                    <ul>
                        <li><a href="/company/story/sign">사인회 &amp; 팬미팅</a></li>
                        <c:forEach items="${codes}" var="l" varStatus="s">
                            <li <c:if test="${trendInfo.trendType eq l.code}">class="on"</c:if>>
                                <c:choose>
                                    <c:when test="${l.code eq 'C1012'}"><a href="/ht/music/${decorator}TrendLiveSchedule?trendTypeCode=${l.code}">${l.codeName}</a></c:when>
                                    <c:otherwise><a href="/ht/music/${decorator}Trend?trendTypeCode=${l.code}">${l.codeName}</a></c:otherwise>
                                </c:choose>
                            </li>
                        </c:forEach>
                    </ul>
                </div>   
            </div> 
            <!-- //snb -->
            
            <!-- music -->
            <div id="${baseClass}">
             
                <div class="contents"> 
                  
                    <div class="stitle"><h3><ui:code codeId="${trendInfo.trendType}"/></h3></div>
                  
                    <div class="typeA_view">  
                        <div class="typeA_title">     
                            <p class="title_text">등록일 <fmt:formatDate value="${trendInfo.regstDtm }" pattern="yyyy-MM-dd" /> <span>|</span> 조회${trendInfo.viewCnt } <span>|</span> 댓글 ${trendInfo.commentsCnt }</p>
                        </div>
                        <table>
                            <colgroup>  
                                <col width="80%" /> 
                                <col width="20%" />  
                            </colgroup> 
                            <tbody> 
                                <tr> 
                                    <th class="bo_title">${trendInfo.title }</th>  
                                    <td class="bo_date"></td>
                                </tr> 
                                <!-- 음반 목록 S -->
                                <tr> 
                                    <td colspan="2" class="bo_contents">
                                        <p class="imgbox">${trendInfo.contents }</p>
                                        <c:forEach var="l" items="${trendRecordList }" varStatus="status" >
                                        <div class="inforbox">
                                            <a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" ratingCode="${l.ratingCode}" width="50" alt="${l.rcrdName}" /></a>
                                            <ul>
                                                <li>
                                                    <span><a href="/ht/record/detail/${l.sellPrdtBcode}">${l.prdtName}</a></span> 
                                                    <p><a href="javascript:searchMain('${l.artiName}', 'ARTI_NAME', '', 'RECORD', '1');">${l.artiName}</a></p>
                                                    <p>${l.makerName}</p>
                                                    <p><ui:mask pattern="####.##.##">${l.rlseDt}</ui:mask></p>
                                                </li>
                                            </ul>
                                        </div>
                                        </c:forEach>
                                    </td> 
                                </tr> 
                                <!-- 음반 목록 E -->
                            </tbody>  
                        </table> 
                        <!-- 댓글 남기기 FORM S -->
                        <form name="form" id="form">
                            <input type="hidden" name="trendSeq" value="${trendInfo.trendSeq}" />
                            <input type="hidden" name="commentsGubun" value="0" />
                            <input type="hidden" name="iconId" value="look01" />
                            <input type="hidden" name="trendCmtSeq" value="" />
                            <input type="hidden" name="dispNo" value="" />
                            <input type="hidden" name="step" value="" />
                            <input type="hidden" name="userNum" value="${userNum}" />
                        
                        <div class="typeA_re">
                            <p class="total"><img src="${imageServer}/images/culturezone/re_title.gif" alt="댓글남기기" /></p>

                            <table class="order_table01_re">
                                <colgroup> 
                                    <col width="18%" />
                                    <col width="52%" /> 
                                    <col width="15%" /> 
                                    <col width="8%" /> 
                                    <col width="6%" /> 
                                </colgroup> 
                                <thead>
                                    <tr>
                                        <td colspan="5">
                                            <div class="look_topbox">
                                                <div class="view_register"> 
                                                    <fieldset>
                                                        <legend>코멘트 등록</legend>
                                                        <div class="lookbox lookboxA">
                                                            <p class="look01"></p>
                                                            <button type="button" onclick="iconView('A')" class="chbtn"></button>
                                                        </div>
                                                        <textarea name="comments" class="txetAreaCommentsA" onkeyup="chkByte(this, '1000');" cols="90" rows="3" title="코멘트입력"></textarea>
                                                        <!-- <input type="image" src="${imageServer}/images/event/btn_regiter.gif" alt="등록" />  -->
                                                        <img class="saveCommentsA" src="${imageServer}/images/event/btn_regiter.gif" alt="등록" />
                                                        <p class="txt f_bl89">현재<span class="f_red_b commentAByte">0</span> / 1000 bytes (최대 한글 500자, 영문 1000자)</p>
                                                    </fieldset>
                                                </div>
                                                <div class="lookallbox lookallboxA" style="display:block;">
                                                    <p class="look01"></p>
                                                    <p class="look02"></p>
                                                    <p class="look03"></p>
                                                    <p class="look04"></p>
                                                    <p class="look05"></p>
                                                    <p class="look06"></p>
                                                    <p class="look07"></p>
                                                    <p class="look08"></p>
                                                    <p class="look09"></p>
                                                    <p class="look10"></p>
                                                </div>
                                            </div>  
                                        </td>
                                    </tr>   
                                </thead>
                                <tbody id="commentsTbody">
                                    <c:forEach var="l" items="${trendCommentsList }" varStatus="status" >
                                    <tr>
                                        <td><p class="look left"><span class="${l.iconId }"></span> <em>${l.userId}</em></p></td>
                                        <c:if test="${l.step eq 0 }">
                                            <td class="left">${fn:join(fn:split(l.comments, "&amp;sbquo;"), ",")}</td> 
                                            <td><p class="dfont"><fmt:formatDate value="${l.regstDtm }" pattern="yyyy.MM.dd HH:mm" /></p></td>
                                            <td class="center"><a href="javascript: ;" onclick="addTextArea(this, '${l.trendCmtSeq}', '${l.dispNo}', '${l.step}')"><img src="${imageServer}/images/culturezone/btn_re01.gif" alt="답글달기" /></a></td>
                                            <td class="center">
                                                <c:if test="${userNum eq l.userNum and 'N' eq l.subExist}">
                                                    <a href="javascript: ;" onclick="updateCommentsUseYn('${l.trendCmtSeq}')"><img src="${imageServer}/images/event/btn_x.gif" alt="삭제" /></a>
                                                </c:if>
                                            </td>
                                        </c:if>
                                        <!-- 답글 -->
                                        <c:if test="${l.step gt 0 }">
                                            <td class="re">${fn:join(fn:split(l.comments, "&amp;sbquo;"), ",")}</td> 
                                            <td><p class="dfont"><fmt:formatDate value="${l.regstDtm }" pattern="yyyy.MM.dd HH:mm" /></p></td>
                                            <td class="center"></td>
                                            <td class="center">
                                                <c:if test="${userNum eq l.userNum and 'N' eq l.subExist}">
                                                    <a href="javascript: ;" onclick="updateCommentsUseYn('${l.trendCmtSeq}')"><img src="${imageServer}/images/event/btn_x.gif" alt="삭제" /></a>
                                                </c:if>
                                            </td>   
                                        </c:if>
                                        <!-- //답글 -->
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>   
                        </form>
                    <!-- 댓글 남기기 FORM E -->
                        
                        <div class="pager_re_s">
                            <c:if test="${empty trendInfo.prevTrendSeq}" >
                                <p class="one"><span>이전글</span>이전글이 없습니다.</p> 
                            </c:if>
                            <c:if test="${not empty trendInfo.prevTrendSeq}" >
                                <p class="one"><span>이전글</span><a href="/ht/music/${decorator}TrendDetail?trendSeq=${trendInfo.prevTrendSeq}&trendType=${trendInfo.trendType}&searchSd=${musicTrendCriteria.searchSd}&concertDt=${musicTrendCriteria.concertDt}&page=${musicTrendCriteria.page}">${trendInfo.prevTitle}</a> <em><fmt:formatDate value="${trendInfo.prevRegstDtm}" pattern="yyyy.MM.dd" /></em></p> 
                            </c:if>
                            <c:if test="${empty trendInfo.nextTrendSeq}" >
                                <p class="two"><span>다음글</span>다음글이 없습니다.</p>  
                            </c:if>
                            <c:if test="${not empty trendInfo.nextTrendSeq}" >
                                <p class="two"><span>다음글</span><a href="/ht/music/${decorator}TrendDetail?trendSeq=${trendInfo.nextTrendSeq}&trendType=${trendInfo.trendType}&searchSd=${musicTrendCriteria.searchSd}&concertDt=${musicTrendCriteria.concertDt}&page=${musicTrendCriteria.page}">${trendInfo.nextTitle}</a> <em><fmt:formatDate value="${trendInfo.nextRegstDtm}" pattern="yyyy.MM.dd" /></em></p> 
                            </c:if>
                        </div>                          
                        
                        <div class="order_btn h30_top">
                            <c:if test="${not empty trendInfo.prevTrendSeq}" >
                                <a href="/ht/music/${decorator}TrendDetail?trendSeq=${trendInfo.prevTrendSeq}&trendType=${trendInfo.trendType}&searchSd=${musicTrendCriteria.searchSd}&concertDt=${musicTrendCriteria.concertDt}&page=${musicTrendCriteria.page}"><img src="${imageServer}/images/culturezone/btn_slist01.gif" alt="이전" /></a>
                            </c:if>
                            <c:choose>
                                <c:when test="${trendInfo.trendType eq 'C1012' }">
                                    <a href="/ht/music/${decorator}TrendLiveSchedule?trendTypeCode=${trendInfo.trendType}&searchSd=${musicTrendCriteria.searchSd}&concertDt=${musicTrendCriteria.concertDt}&page=${musicTrendCriteria.page}"><img src="${imageServer}/images/culturezone/btn_slist02.gif" alt="목록" /></a>
                                </c:when>
                                <c:otherwise>
                                    <a href="/ht/music/${decorator}Trend?trendTypeCode=${trendInfo.trendType}&page=${musicTrendCriteria.page}"><img src="${imageServer}/images/culturezone/btn_slist02.gif" alt="목록" /></a>                             
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${not empty trendInfo.nextTrendSeq}" >
                                <a href="/ht/music/${decorator}TrendDetail?trendSeq=${trendInfo.nextTrendSeq}&trendType=${trendInfo.trendType}&searchSd=${musicTrendCriteria.searchSd}&concertDt=${musicTrendCriteria.concertDt}&page=${musicTrendCriteria.page}"><img src="${imageServer}/images/culturezone/btn_slist03.gif" alt="다음" /></a> 
                            </c:if>
                        </div>                      
                    </div> 
                     
                </div>
                
            </div>
            <!-- //music -->
        </div>
        <!-- //이곳까지 추가해주시면 됩니다 --> 
    </div>
</div>

</body>
</html>
