<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
<title>음반상세검색 - NEW ME HOTTRACKS</title>
<link rel="stylesheet" type="text/css" href="/css/jquery-ui-1.8.16.custom.css"/>
<script type="text/javascript" src="/js/jquery-ui-1.8.14.custom.min.js"></script>
<script type="text/javascript">

function searchSubmit(formName) {
    if(isNaN($("input[name=minPrice]").val()) || isNaN($("input[name=maxPrice]").val()) ){
        alert("가격에는 숫자만 입력 가능합니다.");
        return;
    }
    
    var isEmpty = true;
    
    $(".table_search").find("input[type=text]").each(function(){
        if($(this).val() != ""){
            isEmpty = false;
        }
    })
    
    if(isEmpty){
        alert("검색어를 입력해주세요!");
        return;
    }
    
    
    $("form[name='"+formName+"']").submit();
}

// indxe로 찾기
function searchIndex(urlParam ,objName) {

    var url = "/ht/search/searchPopupIndex/"+urlParam+"?subMenu="+objName+"&searchTerm=A";
    window.open(url, "", "toolbar=no, width=680, height=600, scrollbars=yes, resizable=no, target=new");
}

function fillValue(result) {
    $("input[name='"+result.objName+"']").val(result.objValue);
}

var imageServer = "<ui:variable key='image.server.host,image.upload.uri' prepare='http://' postfix='/'/>";

$(document).ready(function(){   

    toDay = ${toDay};
    month = ${month};
    year  = ${year};

    // 처음 화면
    $('#recordClassic').show();
    $('#recordAll').hide();
    
    $("#mindatepicker, #maxdatepicker, #minalldatepicker, #maxalldatepicker").datepicker({
        showOn: "button",
        buttonImage: "${imageServer}/images/renewal/common/btn_calendar.gif",
        buttonImageOnly: false, 
        buttonText : "", 
        dateFormat : "yymmdd", 
        monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'], 
        showMonthAfterYear: true, 
        dayNamesMin: ['일','월','화','수','목','금','토'], 
        changeYear: false, 
        showButtonPanel: false
        //showButtonPanel: false, 
        //onSelect : function(date){
            //location.href = "?stdDt=" + date + "&<ui:param skip='stdDt' />";
        //}
    }); 

    // 초기화 버튼 클릭 이벤트 핸들...
    //$('span#initForm').click(function(event) {
        //$("input:text, select").val("");
    //});
    
    // 검색항목 선택
    $("input:radio[name='rdoRecord']").change(function(event) {
        event.preventDefault();
        
        if($(this).val() == "Y") {
            $('#recordClassic').show();
            $('#recordAll').hide();
            $("'#recordClassic input:text, '#recordClassic select").val("");
            $("#search11").click();
        } else if($(this).val() == "N") {
            $('#recordClassic').hide();
            $('#recordAll').show();
            $("#recordAll input:text, #recordAll select").val("");
            $("#search14").click();
        } 
    });
    
    // 출간일 선택
    $("input:radio[name='rdoTerms']").click(function() {
        if($(this).val() == "input") {
            $("input[name='minDay']").val("");
            $("input[name='maxDay']").val("");
            
        } else if($(this).val() == "month") {
            $("input[name='minDay']").val(toDay);
            $("input[name='maxDay']").val(month);
        } else if($(this).val() == "year") {
            $("input[name='minDay']").val(toDay);
            $("input[name='maxDay']").val(year);
        } 
    });
});
</script>
</head>
<body>
<div class="list_section mgl0">
    <!-- Location -->
    <div class="page_location">
        <div class="loc">
            <a href="/" class="home">Home</a><em>CD/DVD 상세검색</em>
        </div>
    </div>
    <!-- //Location -->

    <div class="tab1 mgt45">
        <ul>
            <li><a href="/ht/search/searchDetail/Record" class="on"><span>CD</span></a></li>
            <li><a href="/ht/search/searchDetail/Dvd"><span>BLU-RAY | DVD</span></a></li>
        </ul>
    </div>

    <form name="formClassic" method="post" action="/ht/search/searchMain" id="recordClassic">
        <input type="hidden" name="searchTerm" value=" "/>
        <input type="hidden" name="searchMenu" value="RECORD"/>
        <input type="hidden" name="subMenu" value="R_CLASSIC"/>
        <input type="hidden" name="pageNo" value="1"/>
        <input type="hidden" name="detailSearch" value="Y"/>
        <h4 class="tit04">검색입력</h4>
        <div class="tbl_search">
            <table class="table_search">
                <caption>클래식 음반 검색입력</caption>
                <colgroup>
                    <col width="135" />
                    <col width="*" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row"><div class="tit">검색항목 선택</div></th>
                        <td class="rdarea">
                            <span><input type="radio" name="rdoRecord" value="Y" id="search11" checked="checked" /> <label for="search11">클래식 음반만 찾기</label></span>
                            <span><input type="radio" name="rdoRecord" value="N" id="search12" /> <label for="search12">모든음반</label></span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit"><label for="cmpsr">작곡가</label></div></th>
                        <td>
                            <input type="text" name="cmpsr" class="input_txt" id="cmpsr" style="width:612px;" />
                            <a href="javascript://" onclick="searchIndex('RcClassic', 'INDEX_CMPSR')" class="btn_index"><img src="${imageServer}/images/renewal/common/btn_index_search.gif" alt="index로 찾기" /></a>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit"><label for="rcrd_name01">음반명</label></div></th>
                        <td><input type="text" name="rcrd_name" class="input_txt" id="rcrd_name01" style="width:612px;" /></td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit"><label for="cndtr">지휘자</label></div></th>
                        <td>
                            <input type="text" name="cndtr" class="input_txt" id="cndtr" style="width:612px;" />
                            <a href="javascript://" onclick="searchIndex('RcClassic', 'INDEX_CNDTR')" class="btn_index"><img src="${imageServer}/images/renewal/common/btn_index_search.gif" alt="index로 찾기" /></a>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit"><label for="prfmr_kor">연주자</label></div></th>
                        <td>
                            <input type="text" name="prfmr_kor" class="input_txt" id="prfmr_kor" style="width:612px;" />
                            <a href="javascript://" onclick="searchIndex('RcClassic', 'INDEX_PRFMR_KOR')" class="btn_index"><img src="${imageServer}/images/renewal/common/btn_index_search.gif" alt="index로 찾기" /></a>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit"><label for="vocal">보컬</label></div></th>
                        <td>
                            <input type="text" name="vocal" class="input_txt" id="vocal" style="width:612px;" />
                            <a href="javascript://" onclick="searchIndex('RcClassic', 'INDEX_VOCAL')" class="btn_index"><img src="${imageServer}/images/renewal/common/btn_index_search.gif" alt="index로 찾기" /></a>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit"><label for="ocstr">오케스트라</label></div></th>
                        <td>
                            <input type="text" name="ocstr" class="input_txt" id="ocstr" style="width:612px;" />
                            <a href="javascript://" onclick="searchIndex('RcClassic', 'INDEX_OCSTR')" class="btn_index"><img src="${imageServer}/images/renewal/common/btn_index_search.gif" alt="index로 찾기" /></a>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit"><label for="istmt_kor">악기</label></div></th>
                        <td><input type="text" name="istmt_kor" class="input_txt" id="istmt_kor" style="width:612px;" /></td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit"><label for="label_name01">레이블</label></div></th>
                        <td>
                            <input type="text" name="label_name" class="input_txt" id="label_name01" style="width:612px;" />
                            <a href="javascript://" onclick="searchIndex('RcClassic', 'INDEX_LABEL_NAME')" class="btn_index"><img src="${imageServer}/images/renewal/common/btn_index_search.gif" alt="index로 찾기" /></a>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit"><label for="jmcode">카탈로그 번호</label></div></th>
                        <td><input type="text" name="jmcode" class="input_txt" id="jmcode" style="width:612px;" /></td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit"><label for="trk_name01">곡명</label></div></th>
                        <td>
                            <input type="text" name="trk_name" class="input_txt" id="trk_name01" style="width:612px;" />
                            <p class="txt">* 곡명 입력 시, 타 검색 조건은 입력할 수 없습니다.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <h4 class="tit04">상세옵션</h4>
        <div class="tbl_search">
            <table class="table_search">
                <caption>상세옵션</caption>
                <colgroup>
                    <col width="135" />
                    <col width="*" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row"><div class="tit">분야별</div></th>
                        <td>
                            <select name="ctgr_id_2d" class="select" style="width:125px;" title="상세검색 분야 선택">
                                <c:forEach items="${classicCategoryList }" var="list">
                                    <option value="${list.cateId}">${list.cateName}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit">출간일</div></th>
                        <td>
                            <div class="rdarea">
                                <span><input type="radio" name="rdoTerms" value="input" id="date1-1" checked="checked" /> <label for="date1-1">기간 직접입력</label></span>
                                <span><input type="radio" name="rdoTerms" value="month" id="date1-2" /> <label for="date1-2">최근 3개월 이내</label></span>
                                <span><input type="radio" name="rdoTerms" value="year" id="date1-3" /> <label for="date1-3">1년 이내</label></span>
                            </div>
                            <span class="wid01">
                                <input type="text" name="minDay" id="mindatepicker" class="input_txt" style="width:115px;" title="출간일검색시작일자"/>
                            </span>
                            <span class="wid02 t_center">~</span>
                            <span class="wid01">
                                <input type="text" name="maxDay" id="maxdatepicker" class="input_txt" style="width:115px;" title="출간일검색종료일자"/>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit">가격</div></th>
                        <td>
                            <div>
                                <span class="wid01"><input type="text" name="minPrice" class="input_txt" style="width:115px;" title="검색최소가격"/> 원 부터</span>
                                <span class="wid01"><input type="text" name="maxPrice" class="input_txt" style="width:115px;" title="검색최대가격"/> 원 까지</span>
                                * 콤마(,)없이 입력해 주세요
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit">정렬방식</div></th>
                        <td>
                            <select name="sort" class="select" style="width:125px;" title="검색결과정렬방식선택">
                                <option value="ODC">인기순</option>
                                <option value="DAT">신상품순</option>
                                <option value="LOP">낮은가격순</option>
                                <option value="HIP">높은가격순</option>
                                <option value="DCR">높은할인율순</option>
                                <option value="LIK">좋아요순</option>
                                <option value="RVW">상품평순</option>
                            </select>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="btn_area t_center mgt50">
            <a href="javascript://" onclick="searchSubmit('formClassic')" class="btn_type03">검색</a>
        </div>
    </form>
    <form name="formAll" method="post" action="/ht/search/searchMain" id="recordAll">
        <input type="hidden" name="searchTerm" value=" "/>
        <input type="hidden" name="searchMenu" value="RECORD"/>
        <input type="hidden" name="pageNo" value="1"/>
        <input type="hidden" name="detailSearch" value="Y"/>
        <h4 class="tit04">검색입력</h4>
        <div class="tbl_search">
            <table class="table_search">
                <caption>모든음반 검색입력</caption>
                <colgroup>
                    <col width="135" />
                    <col width="*" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row"><div class="tit">검색항목 선택</div></th>
                        <td class="rdarea">
                             <span><input type="radio" name="rdoRecord" value="Y" id="search13" /> <label for="search13">클래식 음반만 찾기</label></span>
                            <span><input type="radio" name="rdoRecord" value="N" id="search14" checked="checked" /> <label for="search14">모든음반</label></span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit"><label for="rcrd_name02">음반명</label></div></th>
                        <td><input type="text" name="rcrd_name" class="input_txt" id="rcrd_name02" style="width:612px;" /></td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit"><label for="arti_name">가수/뮤지션</label></div></th>
                        <td>
                            <input type="text" name="arti_name" class="input_txt" id="arti_name" style="width:612px;" />
                            <a href="javascript://" onclick="searchIndex('RcAll', 'INDEX_ARTI_NAME')" class="btn_index"><img src="${imageServer}/images/renewal/common/btn_index_search.gif" alt="index로 찾기" /></a>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit"><label for="label_name02">레이블/제작사</label></div></th>
                        <td>
                            <input type="text" name="label_name" class="input_txt" id="label_name02" style="width:612px;" />
                            <a href="javascript://" onclick="searchIndex('RcAll', 'INDEX_LABEL_NAME')" class="btn_index"><img src="${imageServer}/images/renewal/common/btn_index_search.gif" alt="index로 찾기" /></a>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit"><label for="trk_name02">곡명</label></div></th>
                        <td>
                            <input type="text" name="trk_name" class="input_txt" id="trk_name02" style="width:612px;" />
                            <p class="txt">* 곡명 입력 시, 타 검색 조건은 입력할 수 없습니다.</p>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <h4 class="tit04">상세옵션</h4>
        <div class="tbl_search">
            <table class="table_search">
                <caption>상세옵션</caption>
                <colgroup>
                    <col width="135" />
                    <col width="*" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row"><div class="tit">분야별</div></th>
                        <td>
                            <select name="ctgr_id_2d" class="select" style="width:125px;" title="상세검색 분야 선택">
                                <c:forEach items="${allCategoryList }" var="list">
                                    <option value="${list.cateId}">${list.cateName}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit">출간일</div></th>
                        <td>
                            <div class="rdarea">
                                <span><input type="radio" name="rdoTerms" value="input" id="date2-1" checked="checked" /> <label for="date2-1">기간 직접입력</label></span>
                                <span><input type="radio" name="rdoTerms" value="month" id="date2-2" /> <label for="date2-2">최근 3개월 이내</label></span>
                                <span><input type="radio" name="rdoTerms" value="year" id="date2-3" /> <label for="date2-3">1년 이내</label></span>
                            </div>
                            <span class="wid01">
                                <input type="text" name="minDay" id="minalldatepicker" class="input_txt" style="width:115px;" title="출간일검색시작일자"/>
                            </span>
                            <span class="wid02 t_center">~</span>
                            <span class="wid01">
                                <input type="text" name="maxDay" id=maxalldatepicker class="input_txt" style="width:115px;" title="출간일검색종료일자"/>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit">가격</div></th>
                        <td>
                            <div>
                                <span class="wid01"><input type="text" name="minPrice" class="input_txt" style="width:115px;" title="검색최소가격"/> 원 부터</span>
                                <span class="wid01"><input type="text" name="maxPrice" class="input_txt" style="width:115px;" title="검색최대가격"/> 원 까지</span>
                                * 콤마(,)없이 입력해 주세요
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit">정렬방식</div></th>
                        <td>
                            <select name="sort" class="select" style="width:125px;" title="검색결과정렬방식선택">
                                <option value="ODC">인기순</option>
                                <option value="DAT">신상품순</option>
                                <option value="LOP">낮은가격순</option>
                                <option value="HIP">높은가격순</option>
                                <option value="DCR">높은할인율순</option>
                                <option value="LIK">좋아요순</option>
                                <option value="RVW">상품평순</option>
                            </select>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="btn_area t_center mgt50">
            <a href="javascript://" onclick="searchSubmit('formAll')" class="btn_type03">검색</a>
        </div>
    </form>
</div>
</body>
</html>