<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<ui:decorator name="popup"/>
<html>
<head>
<title>INDEX로 찾기</title>
<script type="text/javascript" src="/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript">

function fillValue(objValue) {
	
	var objName = $("input:radio[name='index_finder']:checked").val();

    var data = {
    	objName : objName, 
    	objValue : objValue 
    };

    try{
    	parent.opener.fillValue(data);
    	self.close();
    }catch(e){
    	alert(e.message);
    }
}

function searchIndex(searchTerm) {
	
	var searchMenu = $("input:radio[name='index_finder']:checked").val();
	
	$("input[name='searchTerm']").val(searchTerm);
	$("input[name='subMenu']").val("INDEX_"+searchMenu.toUpperCase());
	$("form").submit();
}

$(document).ready(function(){
	
	$("input:radio[name='index_finder']").click(function() {
		var searchMenu = $(this).val();
		$("input[name='searchTerm']").val("A");
		$("input[name='subMenu']").val("INDEX_"+searchMenu.toUpperCase());
		$("form").submit();
	});
	
});
</script>
</head>
<body>
<div style="width:660px;">
<h1><img src="${imageServer}/images/renewal/common/tit_pop_index.gif" alt="INDEX로 찾기"/></h1>
<div class="pop_cont">
    <form name="form" method="post" action="/ht/search/searchPopupIndex/RcAll">
        <input type="hidden" name="searchTerm" value=" "/>
        <input type="hidden" name="searchMenu" value=""/>
        <input type="hidden" name="subMenu" value=""/>
        <input type="hidden" name="menuGroup" value="" />
        <input type="hidden" name="pageNo" value="1"/>
    </form> 
    
    <div class="search_index">
        <div class="rdarea">
            <input type="radio" id="index1" name="index_finder" value="arti_name" <c:if test="${fn:toLowerCase(fn:substring(criteria.subMenu, 6, fn:length(criteria.subMenu) ) ) eq 'arti_name'}">checked</c:if> /><label for="index1">가수명</label>
            <input type="radio" id="index2" name="index_finder" value="label_name" <c:if test="${fn:toLowerCase(fn:substring(criteria.subMenu, 6, fn:length(criteria.subMenu) ) ) eq 'label_name'}">checked</c:if> /><label for="index2">레이블</label>  
        </div>
        <ul class="alphabet_list">
            <li class="a"><a href="javascript:searchIndex('A')">A</a></li>
            <li class="b"><a href="javascript:searchIndex('B')">B</a></li>
            <li class="c"><a href="javascript:searchIndex('C')">C</a></li>
            <li class="d"><a href="javascript:searchIndex('D')">D</a></li>
            <li class="e"><a href="javascript:searchIndex('E')">E</a></li>
            <li class="f"><a href="javascript:searchIndex('F')">F</a></li>
            <li class="g"><a href="javascript:searchIndex('G')">G</a></li>
            <li class="h"><a href="javascript:searchIndex('H')">H</a></li>
            <li class="i"><a href="javascript:searchIndex('I')">I</a></li>
            <li class="j"><a href="javascript:searchIndex('J')">J</a></li>
            <li class="k"><a href="javascript:searchIndex('K')">K</a></li>
            <li class="l"><a href="javascript:searchIndex('L')">L</a></li>
            <li class="m"><a href="javascript:searchIndex('M')">M</a></li>
            <li class="n"><a href="javascript:searchIndex('N')">N</a></li>
            <li class="o"><a href="javascript:searchIndex('O')">O</a></li>
            <li class="p"><a href="javascript:searchIndex('P')">P</a></li>
            <li class="q"><a href="javascript:searchIndex('Q')">Q</a></li>
            <li class="r"><a href="javascript:searchIndex('R')">R</a></li>
            <li class="s"><a href="javascript:searchIndex('S')">S</a></li>
            <li class="t"><a href="javascript:searchIndex('T')">T</a></li>
            <li class="u"><a href="javascript:searchIndex('U')">U</a></li>
            <li class="v"><a href="javascript:searchIndex('V')">V</a></li>
            <li class="w"><a href="javascript:searchIndex('W')">W</a></li>
            <li class="x"><a href="javascript:searchIndex('X')">X</a></li>
            <li class="y"><a href="javascript:searchIndex('Y')">Y</a></li>
            <li class="z ma_none"><a href="javascript:searchIndex('Z')">Z</a></li>
        </ul> 
        <div class="alphabet_view">
            <div class="alpha">${criteria.searchTerm}</div>
            <div class="list">
                <c:set var="retName" value="${fn:toLowerCase(fn:substring(criteria.subMenu, 6, fn:length(criteria.subMenu))) }"/>
                <c:forEach items="${listProduct}" varStatus="s1" step="10">
                    <ul>
                        <c:forEach items="${listProduct}" var="keyword" varStatus="st" begin="${s1.index}" end="${s1.index+9}">
                            <li class="txt_line1"><a href="javascript:fillValue('${keyword}')" title="${keyword}">${keyword}</a></li>  
                        </c:forEach>
                    </ul>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="btn_area t_center mgt10">
        <a href="javascript://" onclick="self.close()" class="btn_type01" style="width:50px; height:22px;"><strong>닫기</strong></a>
    </div>
</div>
</body>
</html>
