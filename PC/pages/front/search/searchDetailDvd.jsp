<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<head>
<title>DVD상세검색 - NEW ME HOTTRACKS</title>
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
    });
    
    if(isEmpty){
        alert("검색어를 입력해주세요!");
        return;
    }
    
    $("input[name='searchMenu']").val("RECORD");
    $("form[name='"+formName+"']").submit();
}

// indxe로 찾기
function searchIndex(urlParam ,objName) {
    var rdoValue = $("input:radio[name='rdoDvd']:checked").val();
    var searchMenu = "";
    
    if(rdoValue == "allBluRay")             searchMenu = "B_ALL";
    else if(rdoValue == "allDvd")           searchMenu = "D_ALL";
    else if(rdoValue == "classicBluRay")    searchMenu = "B_CLASSIC";
    else if(rdoValue == "classicDvd")       searchMenu = "D_CLASSIC";
    
    var url = "/ht/search/searchPopupIndex/"+urlParam+"?subMenu="+objName+"&searchTerm=A";
    var win = window.open(url, "", "toolbar=no, width=680, height=600, scrollbars=yes, resizable=no, target=new");
    win.focus();
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
    $('#allBluRayDvd').show();
    $('#classicBluRayDvd').hide();
    
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
    
    
    // 검색항목 선택
    $("input:radio[name='rdoDvd']").change(function(event) {
        event.preventDefault();
        
        var checkedVal = $(this).val();
        if(checkedVal == "allBluRay" || checkedVal == "allDvd") {
            $('#allBluRayDvd').show();
            $('#classicBluRayDvd').hide();
            $("#allBluRayDvd input:text, #allBluRayDvd select").val("");
            
            if(checkedVal == "allBluRay") {
                $('#allDvdCategoryList').hide();
                $('#allBluRayCategoryList').show();
                $('#allBluRayCategoryList input:radio:first').click();
                $("#search11").click();
            } else {
                $('#allDvdCategoryList').show();
                $('#allBluRayCategoryList').hide();
                $('#allDvdCategoryList input:radio:first').click();
                $("#search13").click();
            }   
        } else if(checkedVal == "classicBluRay" || checkedVal == "classicDvd") {
            $('#allBluRayDvd').hide();
            $('#classicBluRayDvd').show();
            $("#classicBluRayDvd input:text, #classicBluRayDvd select").val("");
            
            if(checkedVal == "classicBluRay") {
                $("#search22").click();
            } else {
                $("#search24").click();
            }   
        } 
    });
    
    // 출간일 선택
    $("input:radio[name='rdoTerms']").click(function() {
        var checkedVal = $(this).val();
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
            <li><a href="/ht/search/searchDetail/Record"><span>CD</span></a></li>
            <li><a href="/ht/search/searchDetail/Dvd" class="on"><span>BLU-RAY | DVD</span></a></li>
        </ul>
    </div>
    <form name="formDvd" method="post" action="/ht/search/searchMain" id="allBluRayDvd">
        <input type="hidden" name="searchTerm" value=" "/>
        <input type="hidden" name="searchMenu" value=""/>
        <input type="hidden" name="subMenu" value=""/>
        <input type="hidden" name="pageNo" value="1"/>
        <input type="hidden" name="detailSearch" value="Y"/>
        <h4 class="tit04">검색입력</h4>
        <div class="tbl_search">
            <table class="table_search">
                <caption>DVD 검색입력</caption>
                <colgroup>
                    <col width="135" />
                    <col width="*" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row"><div class="tit">검색항목 선택</div></th>
                        <td class="rdarea">
                            <span><input type="radio" name="rdoDvd" value="allBluRay" id="search11"  /> <label for="search11">모든 BLU-RAY</label></span>
                            <span><input type="radio" name="rdoDvd" value="classicBluRay" id="search12" /> <label for="search12">클래식 MUSIC BLU-RAY 만 찾기</label></span><br />
                            <span><input type="radio" name="rdoDvd" value="allDvd" id="search13" checked="checked" /> <label for="search13">모든 DVD </label></span>
                            <span><input type="radio" name="rdoDvd" value="classicDvd" id="search14" /> <label for="search14">클래식 MUSIC DVD 만 찾기</label></span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit">상품명</div></th>
                        <td><input name="rcrd_name" type="text" class="input_txt" id="" style="width:612px;" title="검색 상품명"/></td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit">감독</div></th>
                        <td>
                            <input name="drctr" type="text" class="input_txt" id="" style="width:612px;" title="검색감독명"/>
                            <a href="#" onclick="searchIndex('DvdAll', 'INDEX_DRCTR');return false;" class="btn_index"><img src="${imageServer}/images/renewal/common/btn_index_search.gif" alt="index로 찾기" /></a>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit">배우/출연진</div></th>
                        <td>
                            <input name="actor" type="text" class="input_txt" id="" style="width:612px;" title="검색배우/출연진명"/>
                            <a href="#" onclick="searchIndex('DvdAll', 'INDEX_ACTOR');return false;" class="btn_index"><img src="${imageServer}/images/renewal/common/btn_index_search.gif" alt="index로 찾기" /></a>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit">가수/아티스트</div></th>
                        <td><input name="arti_name" type="text" class="input_txt" id="" style="width:612px;" title="검색가수/아티스트명"/></td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit">레이블/제작사</div></th>
                        <td><input name="label_name" type="text" class="input_txt" id="" style="width:612px;" title="검색레이블/제작사명"/></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <h4 class="tit04">상세옵션</h4>
        <div class="tbl_search">
            <table>
                <caption>상세옵션</caption>
                <colgroup>
                    <col width="135" />
                    <col width="*" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row"><div class="tit">분야별</div></th>
                        <td class="rdarea">
                            <div id="allBluRayCategoryList" style="display:none;">
                                <span><label><input type="radio" name="ctgr_id_2d" value=""/> 전체</label></span>
                                <c:forEach items="${allBluRayCategoryList }" var="l" varStatus="st">
                                    <span><label><input type="radio" name="ctgr_id_2d" value="${l.cateId}"/> ${l.cateName}</label></span>
                                </c:forEach>
                            </div>
                            <div id="allDvdCategoryList">
                                <span><label><input type="radio" name="ctgr_id_2d" value="" checked="checked"/> 전체</label></span>
                                <c:forEach items="${allDvdCategoryList }" var="l">
                                    <span><label><input type="radio" name="ctgr_id_2d" value="${l.cateId}"/> ${l.cateName}</label></span>
                                </c:forEach>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit">출간일</div></th>
                        <td>
                            <div class="rdarea">
                                <span><input type="radio" name="rdoTerms" value="input" id="date1-1" checked="checked" /> <label for="date1-1">기간 직접입력</label></span>
                                <span><input type="radio" name="rdoTerms" value="month" id="date1-2" /> <label for="date1-2">최근 3개월 이내</label></span>
                                <span><input type="radio" name="year" value="input" id="date1-3" /> <label for="date1-3">1년 이내</label></span>
                            </div>
                            <span class="wid01">
                                <input type="text" class="input_txt" name="minDay" value="" id="mindatepicker" size="20" style="width:115px;" title="출간일검색시작일자"/>
                            </span>
                            <span class="wid02 t_center">~</span>
                            <span class="wid01">
                                <input type="text" class="input_txt" name="minDay" value="" id="maxdatepicker" size="20" style="width:115px;" title="출간일검색종료일자"/>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><div class="tit">가격</div></th>
                        <td>
                            <div>
                                <span class="wid01"><input name="minPrice" type="text" class="input_txt" id="" style="width:115px;" title="검색최소가격"/> 원 부터</span>
                                <span class="wid01"><input name="maxPrice" type="text" class="input_txt" id="" style="width:115px;" title="검색최대가격"/> 원 까지</span>
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
            <a href="javascript://" onclick="searchSubmit('formDvd')" class="btn_type03">검색</a>
        </div>
    </form>
    <form name="formAll" method="post" action="/ht/search/searchMain" id="classicBluRayDvd">
        <input type="hidden" name="searchTerm" value=" "/>
        <input type="hidden" name="searchMenu" value=""/>
        <input type="hidden" name="subMenu" value=""/>
        <input type="hidden" name="pageNo" value="1"/>
        <input type="hidden" name="detailSearch" value="Y"/>
        <h4 class="tit04">검색입력</h4>
        <div class="tbl_search">
            <table class="table_search">
                <caption>MUSIC 검색입력</caption>
                <colgroup>
                    <col width="135" />
                    <col width="*" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row"><div class="tit">검색항목 선택</div></th>
                        <td class="rdarea">
                            <span><input type="radio" name="rdoDvd" value="allBluRay" id="search21" /> <label for="search21">모든 BLU-RAY</label></span>
                            <span><input type="radio" name="rdoDvd" value="classicBluRay" id="search22" checked="checked" /> <label for="search22">클래식 MUSIC BLU-RAY 만 찾기</label></span><br />
                            <span><input type="radio" name="rdoDvd" value="allDvd" id="search23" /> <label for="search23">모든 DVD </label></span>
                            <span><input type="radio" name="rdoDvd" value="classicDvd" id="search24" /> <label for="search24">클래식 MUSIC DVD 만 찾기</label></span>
                        </td>
                </tr>
                <tr>
                    <th scope="row"><div class="tit">상품(음반)명</div></th>
                    <td><input name="rcrd_name" type="text" class="input_txt" id="" style="width:612px;" title="검색상품(음반)명입력"/></td>
                </tr>
                <tr>
                    <th scope="row"><div class="tit">곡명</div></th>
                    <td><input name="trk_name" type="text" class="input_txt" id="" style="width:612px;" title="검색음반곡명입력"/></td>
                </tr>
                <tr>
                    <th scope="row"><div class="tit">작곡가</div></th>
                    <td>
                        <input name="cmpsr" type="text" class="input_txt" id="" style="width:612px;" title="검색음반작곡가명입력"/>
                        <a href="#" onclick="searchIndex('DvdClassic', 'INDEX_CMPSR');return false;" class="btn_index"><img src="${imageServer}/images/renewal/common/btn_index_search.gif" alt="index로 찾기" /></a>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><div class="tit">지휘자</div></th>
                    <td>
                        <input name="cndtr" type="text" class="input_txt" id="" style="width:612px;" title="검색음반지휘자명입력"/>
                        <a href="#" onclick="searchIndex('DvdClassic', 'INDEX_CNDTR');return false;" class="btn_index"><img src="${imageServer}/images/renewal/common/btn_index_search.gif" alt="index로 찾기" /></a>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><div class="tit">연주자</div></th>
                    <td>
                        <input name="pmfmr_kor" type="text" class="input_txt" id="" style="width:612px;" title="검색음반연주자명입력"/>
                        <a href="#" onclick="searchIndex('DvdClassic', 'INDEX_PMFMR_KOR');return false;" class="btn_index"><img src="${imageServer}/images/renewal/common/btn_index_search.gif" alt="index로 찾기" /></a>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><div class="tit">보컬</div></th>
                    <td>
                        <input name="vocal" type="text" class="input_txt" id="" style="width:612px;" title="검색음반보컬명입력"/>
                        <a href="#" onclick="searchIndex('DvdClassic', 'INDEX_VOCAL');return false;" class="btn_index"><img src="${imageServer}/images/renewal/common/btn_index_search.gif" alt="index로 찾기" /></a>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><div class="tit">오케스트라</div></th>
                    <td>
                        <input name="ocstr" type="text" class="input_txt" id="" style="width:612px;" title="검색음반오케스트라명입력"/>
                        <a href="#" onclick="searchIndex('Classic', 'INDEX_OCSTR');return false;" class="btn_index"><img src="${imageServer}/images/renewal/common/btn_index_search.gif" alt="index로 찾기" /></a>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><div class="tit">악기</div></th>
                    <td>
                        <input name="istmt_kor" type="text" class="input_txt" id="" style="width:612px;" title="검색음반악기명입력"/>
                        <a href="#" onclick="searchIndex('DvdClassic', 'INDEX_ISTMT_KOR');return false;" class="btn_index"><img src="${imageServer}/images/renewal/common/btn_index_search.gif" alt="index로 찾기" /></a>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><div class="tit">레이블</div></th>
                    <td>
                        <input name="label_name" type="text" class="input_txt" id="" style="width:612px;" title="검색음반레이블명입력"/>
                        <a href="#" onclick="searchIndex('DvdClassic', 'INDEX_LABEL_NAME');return false;" class="btn_index"><img src="${imageServer}/images/renewal/common/btn_index_search.gif" alt="index로 찾기" /></a>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><div class="tit">카탈로그 번호</div></th>
                    <td><input name="jmcode" type="text" class="input_txt" id="" style="width:612px;" title="검색음반카탈로그번호입력"/></td>
                </tr>
            </tbody>
        </table>
    </div>
    <h4 class="tit04">상세옵션</h4>
    <div class="tbl_search">
        <table>
            <caption>상세옵션</caption>
            <colgroup>
                <col width="135" />
                <col width="*" />
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row"><div class="tit">출간일</div></th>
                    <td>
                        <div class="rdarea">
                            <span><input type="radio" name="rdoTerms" value="input" id="date2-1" checked="checked" /> <label for="date2-1">기간 직접입력</label></span>
                            <span><input type="radio" name="rdoTerms" value="month" id="date2-2" /> <label for="date2-2">최근 3개월 이내</label></span>
                            <span><input type="radio" name="rdoTerms" value="year" id="date2-3" /> <label for="date2-3">1년 이내</label></span>
                        </div>
                        <span class="wid01">
                            <input type="text" class="input_txt" name="minDay" value="" id="minalldatepicker" style="width:115px;" title="출간일검색시작일자"/>
                        </span>
                        <span class="wid02 t_center">~</span>
                        <span class="wid01">
                            <input type="text" class="input_txt" name="maxDay" value="" id="maxalldatepicker" style="width:115px;" title="출간일검색종료일자"/>
                        </span>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><div class="tit">가격</div></th>
                    <td>
                        <div>
                            <span class="wid01"><input name="minPrice" type="text" class="input_txt" id="" style="width:115px;" title="검색최소가격"/> 원 부터</span>
                            <span class="wid01"><input name="maxPrice" type="text" class="input_txt" id="" style="width:115px;" title="검색최대가격"/> 원 까지</span>
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
        <a href="javascript:searchSubmit('formAll');" class="btn_type03">검색</a>
    </div>
    </form>
</div>
</body>
</html>