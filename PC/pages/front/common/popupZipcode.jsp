<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<c:choose>
    <c:when test="${param.ssl eq 'Y'}"><ui:decorator name="popupSsl"/></c:when>
    <c:otherwise><ui:decorator name="popup"/></c:otherwise>
</c:choose>
<html>
<head>
<script type="text/javascript">
jQuery(function($) {
    $(document).ready(function(){
        window.resizeTo(670, 865);
        if ('${criteria.road}'=='') {
        	
        } else {
            for(var i=1;i<= 4 ;i++){
                '${criteria.road}' == i ? $('.road0'+i).show() : $('.road0'+i).hide();
            }
        }
    });
    
    $("form[name='zipcodeSearchForm']").submit(function() {
        $("input[name='dong']").val($.trim($("input[name='dong']").val()));

        var dong = $("input[name='dong']").val();
        if(dong == "") {
            alert("지역명을 입력해주세요.");
            return false;
        }
    });
    
    $('input[name=road]').click(function(){
    	$("#zipcodeSearchForm2 input[type=text]").val("");
        // $("#zipcodeSearchForm2 select").val("");
        for(var i=1;i<= 4 ;i++){
            $(this).val() == i ? $('.road0'+i).show() : $('.road0'+i).hide();
        }
    });
});

function callbackParent(address, zipcode){
    opener.callbackZipcode(address, zipcode); 
    self.close();
}

function checkResultData() {
    <c:if test="${not empty zipcodes and zipcodesSize == 1}">
    callbackParent('<c:out value="${ zipcodes[0].addr }"/>', '<c:out value="${ zipcodes[0].postNum }"/>');
    </c:if>
}

function isAddressTypeCheck() {
    var addressType;
    for(var i=0; i< document.zipcodeSearchForm2.road.length; i++){
        if(document.zipcodeSearchForm2.road[i].checked == true){
            addressType = document.zipcodeSearchForm2.road[i].value;
            break;
        }
    }
    return addressType;
}


function roadSearch() {
    var frm = document.zipcodeSearchForm2;
    
    if (frm.si_do.value == "") {
        alert("검색하실 시/도를 선택해 주세요.");
        return;
    }
    
    if (frm.si_gu.value == "" && frm.si_do.value != "세종특별자치시") {
        alert("검색하실 시/군/구를 선택해 주세요.");
        return;
    }
    
    var addressType = isAddressTypeCheck();
    if (addressType != "1" && addressType != "2" && addressType != "3" && addressType != "4") {
        alert("비정상적인 검색 유형 입니다.");
        return;
    } else if (addressType == "1") {
        var roadName = frm.road_name.value;
        if (roadName.length < 2) {
            alert("검색하실 도로명을 두 글자 이상 입력해 주세요.");
            frm.road_name.focus();
            return;
        } else {
            frm.dong_name.value = "";
            frm.land_bsc_nmbr.value = "";
            frm.land_addt_nmbr.value = "";
            frm.bdng_name.value = "";
            frm.pob_name.value = "";
        }
    } else if (addressType == "2") {
        var dongName = frm.dong_name.value;
        if (dongName.length < 2) {
            alert("검색하실 동/읍/면/리/로/가를 두 글자 이상 입력해 주세요.");
            frm.dong_name.focus();
            return;
        } else {
            frm.road_name.value = "";
            frm.bdng_bsc_nmbr.value = "";
            frm.bdng_addt_nmbr.value = "";
            frm.bdng_name.value = "";
            frm.pob_name.value = "";
        }
    } else if (addressType == "3") {
        var bdngName = frm.bdng_name.value;
        if (bdngName.length < 1) {
            alert("검색하실 건물명을 한 글자 이상 입력해 주세요.");
            frm.bdng_name.focus();
            return;
        } else {
            frm.road_name.value = "";
            frm.dong_name.value = "";
            frm.bdng_bsc_nmbr.value = "";
            frm.bdng_addt_nmbr.value = "";
            frm.pob_name.value = "";
        }
    } else if (addressType == "4") {
        var pobName = frm.pob_name.value;
        if (pobName.length < 2) {
            alert("검색하실 사서함을 두 글자 이상 입력해 주세요.");
            frm.pob_name.focus();
            return;
        } else {
            frm.road_name.value = "";
            frm.dong_name.value = "";
            frm.bdng_bsc_nmbr.value = "";
            frm.bdng_addt_nmbr.value = "";
            frm.bdng_name.value = "";
        }
    }
    
    frm.searchCmd.value="Y";
    
    frm.submit();
}

function select_address(zip1, address1, address3, address4, landAddress){
    if(zip1 == ""){
        alert("주소를 선택하세요");
        return;
    }

    opener.callbackRoadCode(zip1, address1, address3, address4, landAddress); 
    self.close();
}

</script>
</head>
<body>
<div class="popup" style="width:650px;">
<h1><img src="${imageServer}/images/renewal/common/tit_address.gif" alt="우편번호찾기" /></h1>
<div class="pop_cont">
    <div class="tab_wrap">
        <ul class="ads_tab tab_btn">
            <li><a href="#ads02" <c:if test="${serchGubun == 'gibun'}">class="off"</c:if><c:if test="${serchGubun == 'road'}">class="on"</c:if>><span>도로명주소</span></a></li>
            <li><a href="#ads01" <c:if test="${serchGubun == 'gibun'}">class="on"</c:if><c:if test="${serchGubun == 'road'}">class="off"</c:if>><span>지번주소</span></a></li>
        </ul>
        <div class="tab_pannels">
            <div id="ads01" class="pannel" <c:if test="${serchGubun == 'road'}">style="display:none"</c:if>>
                <form name="zipcodeSearchForm" action="/ht/listZipcode">
                    <input type="hidden" name="ssl" value="${criteria.ssl}"/>
                    <div class="ads_box" style="overflow-y: auto;height:545px;">
                        <ul class="ads_info">
                            <li>동, 읍, 면의 이름을 입력하신 후 '우편번호 찾기'를 클릭하세요.<br />(예 서초동, 우표읍, 외서면)</li>
                        </ul>
                        <div class="box_gray03 t_center mgt10">
                            <div class="show">동 이름 <input type="text" name="dong" value="${criteria.dong}" id="region-name" class="input_txt" title="동 이름 입력"  />
                            <a href="javascript://" onclick="document.zipcodeSearchForm.submit();" class="btn_type01"><span>우편번호 찾기</span></a>
                            </div>
                        </div>
                        <div class="clear mgt20">
                            <p class="f_left fs11">검색결과</p>
                        </div>
                        <table class="table02 mgt5">
                            <caption>검색결과</caption>
                            <colgroup>
                                <col style="width:20%" />
                                <col style="width:auto" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col">우편번호</th>
                                    <th scope="col">지번주소</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${empty zipcodes}"><tr><td colspan="2" class="t_center">선택하신 검색유형의 검색 항목을 입력하시고 검색하세요.</td></tr></c:if>
                                <c:forEach items="${zipcodes}" var="zipcode" varStatus="status">
                                    <tr>
                                        <td>${zipcode.postNum}</td>
                                        <td><a href="javascript:callbackParent('${zipcode.addr}', '${zipcode.postNum}');">${zipcode.addr}</a></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </form>
            </div>
            <div id="ads02" class="pannel" <c:if test="${serchGubun == 'gibun'}">style="display:none"</c:if>>
                <form name="zipcodeSearchForm2" id="zipcodeSearchForm2" action="/ht/listZipcode2">
                    <input type="hidden" name="searchCmd" id="searchCmd" value="1"/> 
                    <div class="ads_combo">
                        <ul>
                            <li><label><input type="radio" name="road" id="road01" class="radio" value="1" <c:if test="${criteria.road == null || criteria.road == '1'}">checked</c:if>/> 도로명 + 건물번호</label></li>
                            <li><label><input type="radio" name="road" id="road02" class="radio" value="2" <c:if test="${criteria.road == '2'}">checked</c:if>/> 동(읍/면) + 지번</label></li>
                            <li><label><input type="radio" name="road" id="road03" class="radio" value="3" <c:if test="${criteria.road == '3'}">checked</c:if>/> 건물명(아파트명)</label></li>
                            <!-- 
                            <li><label><input type="radio" name="road" id="road04" class="radio" value="4" <c:if test="${criteria.road == '4'}">checked</c:if>/> 사서함</label></li>
                             -->
                        </ul>
                    </div>
                    <div class="ads_box">
                        <div class="road01">
                            <ul class="ads_info">
                                <li><strong>검색방법 : 시/도 및 시/군/구 선택 후 도로명(~로, ~길)과 건물번호 입력</strong></li>
                                <li>예) 광인사길 212 →</li>
                                <li><strong>경기도</strong> + <strong>파주시</strong> + <strong>광인사길</strong>(도로명) + <strong>212</strong>(건물번호1) 입력후 검색</li>
                            </ul>
                        </div>
                        <div class="road02" style="display:none;">
                            <ul class="ads_info">
                                <li><strong>검색방법 : 시/도 및 시/군/구 선택 후 기존 동명과 지번 입력</strong></li>
                                <li>예) 문발동 501-1 →</li>
                                <li><strong>경기도</strong> + <strong>파주시</strong> + <strong>문발동</strong> (동/읍/면) + <strong>501</strong> (번지1) + <strong>1</strong> (번지2) 입력 후 검색</li>
                            </ul>
                        </div>
                        <div class="road03" style="display:none;">
                            <ul class="ads_info">
                                <li><strong>검색방법 : 시/도 및 시/군/구 선택 후 건물명(아파트명) 입력</strong></li>
                                <li>예) 경기도 파주시 교보문고  →</li>
                                <li><strong>경기도</strong> + <strong>파주시</strong> + <strong>교보문고</strong> (건물명) 입력 후 검색</li>
                            </ul>
                        </div>
                        <div class="road04" style="display:none;">
                            <ul class="ads_info">
                                <li><strong>검색방법 : 시/도 및 시/군/구 선택 후 사서함 입력</strong></li>
                                <li>예) 경기도 파주시 사서함  →</li>
                                <li><strong>경기도</strong> + <strong>파주시</strong> + <strong>사서함</strong> 입력 후 검색</li>
                            </ul>
                        </div>
                        <table class="table02 ">
                            <caption>검색조건 입력</caption>
                            <colgroup>
                                <col style="width:16%" />
                                <col style="width:22%" />
                                <col style="width:16%" />
                                <col style="width:15%" />
                                <col style="width:16%" />
                                <col style="width:auto" />
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>시/도</th>
                                    <td>
                                        <select class="select" id="si_do" name="si_do" style="width:102px" onChange="document.zipcodeSearchForm2.submit();">
                                            <option value="" <c:if test="${criteria.si_do == null || criteria.si_do == ''}">selected</c:if>>선택</option>
                                            <option value="강원도" <c:if test="${criteria.si_do == '강원도'}">selected</c:if>>강원도</option>
                                            <option value="경기도" <c:if test="${criteria.si_do == '경기도'}">selected</c:if>>경기도</option>
                                            <option value="경상남도" <c:if test="${criteria.si_do == '경상남도'}">selected</c:if>>경상남도</option>
                                            <option value="경상북도" <c:if test="${criteria.si_do == '경상북도'}">selected</c:if>>경상북도</option>
                                            <option value="광주광역시" <c:if test="${criteria.si_do == '광주광역시'}">selected</c:if>>광주광역시</option>
                                            <option value="대구광역시" <c:if test="${criteria.si_do == '대구광역시'}">selected</c:if>>대구광역시</option>
                                            <option value="대전광역시" <c:if test="${criteria.si_do == '대전광역시'}">selected</c:if>>대전광역시</option>
                                            <option value="부산광역시" <c:if test="${criteria.si_do == '부산광역시'}">selected</c:if>>부산광역시</option>
                                            <option value="서울특별시" <c:if test="${criteria.si_do == '서울특별시'}">selected</c:if>>서울특별시</option>
                                            <option value="세종특별자치시" <c:if test="${criteria.si_do == '세종특별자치시'}">selected</c:if>>세종특별자치시</option>
                                            <option value="울산광역시" <c:if test="${criteria.si_do == '울산광역시'}">selected</c:if>>울산광역시</option>
                                            <option value="인천광역시" <c:if test="${criteria.si_do == '인천광역시'}">selected</c:if>>인천광역시</option>
                                            <option value="전라남도" <c:if test="${criteria.si_do == '전라남도'}">selected</c:if>>전라남도</option>
                                            <option value="전라북도" <c:if test="${criteria.si_do == '전라북도'}">selected</c:if>>전라북도</option>
                                            <option value="제주특별자치도" <c:if test="${criteria.si_do == '제주특별자치도'}">selected</c:if>>제주특별자치도</option>
                                            <option value="충청남도" <c:if test="${criteria.si_do == '충청남도'}">selected</c:if>>충청남도</option>
                                            <option value="충청북도" <c:if test="${criteria.si_do == '충청북도'}">selected</c:if>>충청북도</option>
                                        </select>
                                    </td>
                                    <th>시/군/구</th>
                                    <td colspan="3">
                                        <select class="select" id="si_gu" name="si_gu" title="시/군/구 선택">
                                            <option value="" <c:if test="${criteria.si_gu == null || criteria.si_gu == ''}">selected</c:if>>선택</option>
                                            <c:forEach items="${sido}" var="sido" varStatus="status">
                                            <option value="${sido.gu}" <c:if test="${criteria.si_gu == sido.gu}">selected</c:if>>${sido.gu}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr class="road01">
                                    <th>도로명</th>
                                    <td><input type="text" class="input_txt" title="도로명 입력" style="ime-mode:active;width:60px;" id="road_name" name="road_name" value="${criteria.road_name}"/></td>
                                    <th>+ 건물번호 1</th>
                                    <td><input type="text" class="input_txt" title="건물번호 입력" style="width:60px;" id="bdng_bsc_nmbr" name="bdng_bsc_nmbr" value="${criteria.bdng_bsc_nmbr}"/></td>
                                    <th>+ 건물번호 2</th>
                                    <td><input type="text" class="input_txt" title="건물번호 입력" style="width:40px;" id="bdng_addt_nmbr" name="bdng_addt_nmbr" value="${criteria.bdng_addt_nmbr}"/></td>
                                </tr>
                                <tr class="road02" style="display:none;">
                                    <th>동/읍/면</th>
                                    <td><input type="text" class="input_txt" title="동/읍/면 입력" style="ime-mode:active;width:60px;" id="dong_name" name="dong_name" value="${criteria.dong_name}"/></td>
                                    <th>+ 번지1</th>
                                    <td><input type="text" class="input_txt" title="번지1 입력" style="width:60px;" id="land_bsc_nmbr" name="land_bsc_nmbr" value="${criteria.land_bsc_nmbr}"/></td>
                                    <th>+ 번지2</th>
                                    <td><input type="text" class="input_txt" title="번지2 입력" style="width:40px;" id="land_addt_nmbr" name="land_addt_nmbr" value="${criteria.land_addt_nmbr}"/></td>
                                </tr>
                                <tr class="road03" style="display:none;">
                                    <th>건물명</th>
                                    <td colspan="5"><input type="text" class="input_txt" title="건물명 입력" style="ime-mode:active;width:300px;" id="bdng_name" name="bdng_name" value="${criteria.bdng_name}"/></td>
                                </tr>
                                <tr class="road04" style="display:none;">
                                    <th>사서함</th>
                                    <td colspan="5"><input type="text" class="input_txt" title="사서함 입력" style="width:300px;" id="pob_name" name="pob_name" value="${criteria.pob_name}"/></td>
                                </tr>
                                <tr>
                                    <td colspan="6" class="t_center">
                                        <a href="javascript://" onclick="roadSearch();" class="btn_type01">검색</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="clear mgt20">
                            <p class="f_left fs11">검색결과 : 총 
                                <c:if test="${not empty totalCount}"><fmt:formatNumber type="number">${totalCount}</fmt:formatNumber> 건</c:if>
                                <c:if test="${empty totalCount}">0 건</c:if>
                            </p>
                            <p class="f_right fs11"><c:if test="${not empty totalCount}">${pageHolder.startNumber} ~ ${pageHolder.startNumber + fn:length(zipcodes2)-1}</c:if></p>
                        </div>
                        <div style="overflow-y: auto;height:180px;">
                        <table class="table02 mgt5" >
                            <caption>검색결과</caption>
                            <colgroup>
                                <col style="width:20%" />
                                <col style="width:40%" />
                                <col style="width:auto" />
                            </colgroup>
                            <thead>
                                <tr>
                                    <th>우편번호</th>
                                    <th>도로명주소</th>
                                    <th>지번주소</th>
                                </tr>
                            </thead>
                            <tbody>
                               <c:forEach items="${zipcodes2}" var="zipcodes" varStatus="status">
                                    <tr>
                                    <td><a href="javascript:select_address('${zipcodes.postNum}','${zipcodes.si} ${zipcodes.gu} ${zipcodes.roadNm} ${zipcodes.bdngNmbr}','${zipcodes.bdngNm}','${zipcodes.dong}', '${zipcodes.si} ${zipcodes.gu} ${zipcodes.dong} ${zipcodes.landNmbr}')">${zipcodes.postNum}</a></td>
                                    <td><a href="javascript:select_address('${zipcodes.postNum}','${zipcodes.si} ${zipcodes.gu} ${zipcodes.roadNm} ${zipcodes.bdngNmbr}','${zipcodes.bdngNm}','${zipcodes.dong}', '${zipcodes.si} ${zipcodes.gu} ${zipcodes.dong} ${zipcodes.landNmbr}')">${zipcodes.si} ${zipcodes.gu} ${zipcodes.roadNm} ${zipcodes.bdngNmbr}<BR>${zipcodes.dong} ${zipcodes.bdngNm}</a></td>
                                    <td><a href="javascript:select_address('${zipcodes.postNum}','${zipcodes.si} ${zipcodes.gu} ${zipcodes.roadNm} ${zipcodes.bdngNmbr}','${zipcodes.bdngNm}','${zipcodes.dong}', '${zipcodes.si} ${zipcodes.gu} ${zipcodes.dong} ${zipcodes.landNmbr}')">${zipcodes.si} ${zipcodes.gu} ${zipcodes.dong} ${zipcodes.landNmbr}</a></td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty zipcodes2}"><tr><td colspan="3" class="t_center">선택하신 검색유형의 검색 항목을 입력하시고 검색하세요.</td></tr></c:if>
                            </tbody>
                        </table>
                        </div>
                        <!-- paging -->
                        <div class="paging mgt10"><ui:pagination name="pageHolder" url="?" parameters="dong,dongPrefix,dongSuffix,ssl,road,si_do,si_gu,road_name,bdng_bsc_nmbr,bdng_addt_nmbr,dong_name,land_bsc_nmbr,land_addt_nmbr,bdng_name,pob_name,searchCmd"/></div>
                        <!-- //paging -->
                        <ul class="list_type02 mgt15">
                            <li>도로명 주소가 검색되지 않는 경우는 안전행정부 도로명 주소안내시스템<br />(http://www.juso.go.kr) 에서 확인하시기 바랍니다.</li>
                        </ul>
                    </div>
               </form>
            </div>
        </div>
    </div>
</div>
<div class="pop_close">
    <a href="javascript://" onclick="self.close();">닫기</a>
</div>
</div>
<form name="nextForm">
    <input type="hidden" name="openerfrm" value="orderForm"/>
    <input type="hidden" name="zip1" value="receiptZip1"/>
    <input type="hidden" name="zip2" value="receiptZip2"/>
    <input type="hidden" name="address1" value="receiptAddress1"/>
    <input type="hidden" name="address2" value="receiptAddress2"/>
    <input type="hidden" name="address3" value="receiptAddress3"/>
    <input type="hidden" name="address4" value="receiptAddress4"/>
    <input type="hidden" name="selectZip" value=""/>
    <input type="hidden" name="selectAddress1" value=""/>
    <input type="hidden" name="selectAddress3" value=""/>
    <input type="hidden" name="selectAddress4" value=""/>
    <input type="hidden" name="selectLandAddress" value=""/>
</form>
</body>
</html>