<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="layer"/>
<html>
<head>
<style type="text/css">
#zipcodeList li:first-child { margin-top:0; }
#zipcodeList li.moreBtn { display:block;text-align:right; }
</style>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
var page = 1;
var searchMode = 'G';
jQuery(function($){
    $("form").submit(function(e){
        e.preventDefault();
        fnSearch();
    });
});

function fnPage(){
    $("#zipcodeList").find(".moreBtn").remove();
    page++;
    fnLoadZipcode();
}

function fnLoadZipcode(){
    var searchFrm = $("form[name=zipcodeFrm1]");
    if(searchMode == "G"){
        if (isEmpty(searchFrm.find("input[name=dong]").val())) {
            alert("검색하실 동/읍/면을 선택해 주세요.");
            searchFrm.find("input[name=dong]").focus();
            return;
        }
    }else {
        searchFrm = $("form[name=zipcodeFrm2]");
        if (isEmpty(searchFrm.find("select[name=si_do]").val())) {
            alert("검색하실 시/도를 선택해 주세요.");
            searchFrm.find("select[name=si_do]").focus();
            return;
        }
        
        if (isEmpty(searchFrm.find("select[name=si_gu]").val()) && searchFrm.find("select[name=si_do]").val() != "세종특별자치시") {
            alert("검색하실 시/군/구를 선택해 주세요.");
            searchFrm.find("select[name=si_gu]").focus();
            return;
        }
        
        if (searchFrm.find("input[name=road_name]").val().length < 2) {
            alert("검색하실 도로명을 두 글자 이상 입력해 주세요.");
            searchFrm.find("input[name=road_name]").focus();
            return;
        } 
    }
    searchFrm.find("input[name=page]").val(page);
    searchFrm.ajaxSubmit({
         type: "POST"
        ,url: "/m/layerZipcodeList"
        ,dataType: "html"
        ,success : function(html){
            $("#zipcodeList").html(html);
        }
    });
}

function zipPage(page){
    if(searchMode == "G"){
        searchFrm = $("form[name=zipcodeFrm1]");
    }else{
        searchFrm = $("form[name=zipcodeFrm2]");
    }
    searchFrm.find("input[name=page]").val(page);
    searchFrm.ajaxSubmit({
         type: "POST"
        ,url: "/m/layerZipcodeList"
        ,dataType: "html"
        ,success : function(html){
            $("#zipcodeList").html(html);
        }
    });
}

function fnSearch(){
    $("#zipcodeList").empty();
    page = 1;
    fnLoadZipcode();
}

function select_address(zip1, address1, address3, address4, landAddress){
    if(zip1 == ""){
        alert("주소를 선택하세요");
        return;
    }
    
    callbackZipcode(zip1, address1 + ' ' + address3 + ' ' + address4); 
    // self.close();
}

function changeMode(mod){
    searchMode = mod;
    $(".modeType").removeClass("active");
    if(mod == "R"){
        $(".modeType").first().addClass("active");
        $("form[name=zipcodeFrm1]").hide();
        $("form[name=zipcodeFrm2]").show();
    }else{
        $(".modeType").last().addClass("active");
        $("form[name=zipcodeFrm2]").hide();
        $("form[name=zipcodeFrm1]").show();
    }
    $("#zipcodeList").empty();
    return false;
}

function loadSigu(sido){
    $.ajax({
        type: "POST"
       ,url: "/m/ajaxSidoList"
       ,data: {si_do : sido}
       ,dataType: "json"
       ,success : function(data){
           $("#si_gu").empty();
           $("#si_gu").append("<option value=''>시/군/구 선택</option>");
           for(var i = 0;i < data.sido.length; i++){
               $("#si_gu").append("<option value='"+data.sido[i]+"'>"+data.sido[i]+"</option>");
           }
           $("#si_gu").find("option[value='']").attr("selected", true);
       }
       ,error: function(data) {
           alert('<fmt:message key="error.common.system"/>');
       }
   });
}
</script>
</head>
<body>
<input type="hidden" name="eof" value="1"/>
<input type="hidden" name="searchMode" value="G"/>
<!-- tit_section -->
<div id="ly_header">
    <h1>우편번호찾기</h1>
</div>
<!-- //tit_section -->
<!-- content -->
<div id="ly_content">
    <div class="tog_area box_flex">
        <a href="javascript:changeMode('R')" class="modeType btn tog_btn">도로명주소</a>
        <a href="javascript:changeMode('G')" class="modeType btn tog_btn active">지번주소</a>
    </div>
    
    <div class="roundbox mt20">
        <form name="zipcodeFrm2" action="/m/zipcode" method="post" style="display:none;">
            <input type="hidden" name="searchGbn" value="R"/>
            <input type="hidden" name="page" value="1"/>
            <fieldset>
                <ul class="br_list">
                    <li class="br_none">
                        <p class="">
                            ※검색방법 : 시/도 및 시/군/구 선택 후 도로명(~로,~길)과 건물번호 입력 <br/>예) 문발로 249 → 경기도 + 파주시 + 문발로 (도로명) + 249 (건물번호1) 입력 후 검색<br/>
                            ※도로명 주소가 검색되지 않는 경우는 도로명주소안내시스템 (<a href="http://www.juso.go.kr" target="_blank">http://www.juso.go.kr</a>)에서 확인하시기 바랍니다.
                        </p>
                    </li>
                    <li class="br_none mt5 box_flex">
                        <select class="select" id="si_do" name="si_do" onchange="loadSigu(this.value)">
                            <option value="">시/도 선택</option>
                            <option value="강원도">강원도</option>
                            <option value="경기도">경기도</option>
                            <option value="경상남도">경상남도</option>
                            <option value="경상북도">경상북도</option>
                            <option value="광주광역시">광주광역시</option>
                            <option value="대구광역시">대구광역시</option>
                            <option value="대전광역시">대전광역시</option>
                            <option value="부산광역시">부산광역시</option>
                            <option value="서울특별시">서울특별시</option>
                            <option value="세종특별자치시">세종특별자치시</option>
                            <option value="울산광역시">울산광역시</option>
                            <option value="인천광역시">인천광역시</option>
                            <option value="전라남도">전라남도</option>
                            <option value="전라북도">전라북도</option>
                            <option value="제주특별자치도">제주특별자치도</option>
                            <option value="충청남도">충청남도</option>
                            <option value="충청북도">충청북도</option>
                        </select>
                    </li>
                    <li class="br_none mt5 box_flex">
                        <select class="select" id="si_gu" name="si_gu" title="시/군/구 선택">
                            <option value="">시/군/구 선택</option>
                        </select>
                    </li>
                    <li class="br_none mt5">
                        <div class="input_box"><input type="text" name="road_name" class="input" title="도로명 입력" placeHolder="도로명" /></div>
                    </li>
                    <li class="br_none mt5">
                        <div class="input_box">
                            <input type="text" name="bdng_bsc_nmbr" class="input" title="건물번호1 입력" placeHolder="건물번호1" />
                            <input type="text" name="bdng_addt_nmbr" class="input" title="건물번호2 입력" placeHolder="건물번호2" />
                        </div>
                    </li>
                </ul>
            </fieldset>
        </form>
        <form name="zipcodeFrm1" action="/m/zipcode" method="post">
            <input type="hidden" name="searchGbn" value="G"/>
            <input type="hidden" name="page" value="1"/>
            <fieldset>
                <ul class="br_list">
                    <li class="br_none">
                        <p class="">※검색방법 : 동,읍,면 이름 일부 입력<br/>예) 문발동, 종로1가, 우포읍, 외서면</p>
                    </li>
                    <li class="br_none mt5">
                        <div class="input_box"><input type="text" name="dong" value="${c.dong}" class="input" title="동/읍/면 이름 입력" placeHolder="동/읍/면" /></div>
                    </li>
                </ul>
            </fieldset>
        </form>
        <div class="btn_area box_flex mt10">
            <a href="javascript:fnSearch();" class="btn btn_orange">검색</a>
        </div>
        <div id="zipcodeList"></div>
    </div>
    
    <a href="javascript:closeZipcode();" class="btn_cls">닫기</a>
</div>
<!-- //content -->
</body>
</html>