<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="record"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<script type="text/javascript">
    //조회기간 년도 선택시
    function selectedYearStdDt() {
    	var bestRangeType = '${c.bestRangeType}';
    	var recentStdDtYear = '${recentStdDtYear}';
    	var recentStdDtMonth = eval('${recentStdDtMonth}');
    	var recentStdDtDay = eval('${recentStdDtDay}');
    	var recentStdDtWeek = eval('${recentStdDtWeek}');
    	
    	var searchYear = $("select[name='searchYear']").val();
    	
    	if(bestRangeType == 'C1002') {//일간
    		
    		if(recentStdDtYear == searchYear) {
    			$("select[name='searchMonth']").val(recentStdDtMonth);
            	$("select[name='searchDay']").val(recentStdDtDay);
    		}else {
    			$("select[name='searchMonth']").val("1");
            	$("select[name='searchDay']").val("1");
    		}
    	}else if(bestRangeType == 'C1003') {//주간
    		if(recentStdDtYear == searchYear) {
    			$("select[name='searchMonth']").val(recentStdDtMonth);
            	$("select[name='searchWeek']").val(recentStdDtWeek);	
    		}else {
    			$("select[name='searchMonth']").val("1");
            	$("select[name='searchWeek']").val("1");
    		}		
    	}else if(bestRangeType == 'C1004') {//월간
    		if(recentStdDtYear == searchYear) {
    			$("select[name='searchMonth']").val(recentStdDtMonth);
    		}else {
    			$("select[name='searchMonth']").val("1");	
    		}
    		
    	}
    	
    	$("input[name='searchYn']").val("Y");
        $("#searchStdDtForm").submit();
    }
    // 조회기간 월 선택시
    function selectedMonthStdDt() {
    	
    	var bestRangeType = '${c.bestRangeType}';
    	
    	if(bestRangeType == 'C1002') {//일간
    		$("select[name='searchDay']").val("1");
    	}else if(bestRangeType == 'C1003') {//주간
    		$("select[name='searchWeek']").val("1");
    	}
    	
    	$("input[name='searchYn']").val("Y");
    	$("#searchStdDtForm").submit();
    }
    // 조회기간 일 선택시
    function selectedDayStdDt() {
    	
    	$("input[name='searchYn']").val("Y");
    	$("#searchStdDtForm").submit();
    }
    
    // 조회기간 주차 선택시
    function searchWeekStdDt() {
     	
     	$("input[name='searchYn']").val("Y");
    	$("#searchStdDtForm").submit();
    }
    
</script>
</head>
<body>

<!-- 이곳부터 추가해주시면 됩니다 -->
        <div id="container"> 
          
            <!-- music 현재 페이지 위치 소스 입니다 --> 
            <div class="page_music">
                <div class="page-location">
                    <p class="title"><img src="${imageServer}/images/music/title_music_s05.gif" alt="실시간 차트" /></p>
                    <ul>
                        <li><a href="/">홈</a> <span>&gt;</span></li>
                        <li><a href="<ui:recordConstants key="url_record_main" />">음반</a> <span>&gt;</span></li>
                        <li><strong>실시간 차트</strong></li>
                    </ul> 
                </div>
            </div>
            <!-- //music 현재 페이지 위치 소스 입니다 --> 
            
            <!-- snb -->
            <div class="snb_mnew"> 
                <div class="snb_music">
                    <ul class="sub_1df">
                        
                        <li <c:if test="${c.recBestType eq 'C0991'}">class="on"</c:if>><a href="/ht/record/realTimeList/C0991?bestRangeType=C1001&ctgrId=000300">한터</a>
                            <ul class="sub_2df">
                                <%-- <li <c:if test="${c.ctgrId eq '0003'}">class="on"</c:if>><a href="/ht/record/realTimeList/C0991?bestRangeType=C1001&ctgrId=0003">종합</a></li> --%>
                                <li <c:if test="${c.ctgrId eq '000300'}">class="on"</c:if>><a href="/ht/record/realTimeList/C0991?ctgrId=000300&bestRangeType=C1001">가요</a></li>
                                <li <c:if test="${c.ctgrId eq '000301'}">class="on"</c:if>><a href="/ht/record/realTimeList/C0991?ctgrId=000301&bestRangeType=C1001">팝</a></li>
                                <li <c:if test="${c.ctgrId eq '000308'}">class="on"</c:if>><a href="/ht/record/realTimeList/C0991?ctgrId=000308&bestRangeType=C1001">클래식</a></li>
                            </ul>
                        </li>
                        <%-- 
                        <li><a href="/ht/record/realTimeListM/C1142">뮤직뱅크</a></li>
                        <li><a href="/ht/record/realTimeListM/C1143">엠카운트다운</a></li>
                        --%>
                    </ul>
                </div>             
            </div>
            <!-- //snb --> 
                 
            <!-- music -->
            <div id="music">
             
                <div class="contents"> 
                    <p class="category_imgtype02 h10_bottom"><img src="${imageServer}/images/music/img_rlChart01.gif" alt="한터차트 / 판매량 집계시스템에 의하여 생성된 음반차트" /></p>
                    <div class="description_02">
                        <ul>
                            <li>한터차트는 교보핫트랙스(주)와 (주)한터정보시스템과의 데이터제공 계약에 따라 (주)한터정보시스템에서 제공되는 자료로 보여집니다.<br />
                    (실시간 차트는 다소 시간차이가 발생 할 수있습니다.)</li> 
                        </ul>
                    </div>
                    
                    
                    <c:if test="${c.recBestType eq 'C0991'}">
                        <div class="m_tab_r02">
                            <ul>
                                <li><a href="/ht/record/realTimeList/${c.recBestType}?ctgrId=${c.ctgrId}&bestRangeType=C1001" <c:if test="${c.bestRangeType eq 'C1001'}">class="on"</c:if><c:if test="${!(c.bestRangeType eq 'C1001')}">class="off"</c:if>>실시간</a></li>
                                <li><a href="/ht/record/realTimeList/${c.recBestType}?ctgrId=${c.ctgrId}&bestRangeType=C1002" <c:if test="${c.bestRangeType eq 'C1002'}">class="on"</c:if><c:if test="${!(c.bestRangeType eq 'C1002')}">class="off"</c:if>>일간</a></li>
                                <li><a href="/ht/record/realTimeList/${c.recBestType}?ctgrId=${c.ctgrId}&bestRangeType=C1003" <c:if test="${c.bestRangeType eq 'C1003'}">class="on"</c:if><c:if test="${!(c.bestRangeType eq 'C1003')}">class="off"</c:if>>주간</a></li>
                                <li><a href="/ht/record/realTimeList/${c.recBestType}?ctgrId=${c.ctgrId}&bestRangeType=C1004" <c:if test="${c.bestRangeType eq 'C1004'}">class="on"</c:if><c:if test="${!(c.bestRangeType eq 'C1004')}">class="off"</c:if>>월간</a></li>
                                <li class="last"><a href="/ht/record/realTimeList/${c.recBestType}?ctgrId=${c.ctgrId}&bestRangeType=C1005" <c:if test="${c.bestRangeType eq 'C1005'}">class="on"</c:if><c:if test="${!(c.bestRangeType eq 'C1005')}">class="off"</c:if>>년간</a></li> 
                            </ul>
                        </div>
                    </c:if>
                            
                    
                    <!-- 리스트 보기 옵션 --> 
                    <div class="typeC_title">
                        <div class="list_bg">
                            <div class="list_tool_02">
                                <form name="searchStdDtForm" id="searchStdDtForm" action="/ht/record/realTimeList/${c.recBestType}">
                                    <input type="hidden" name="bestRangeType" value="${c.bestRangeType}"/>
                                    <input type="hidden" name="ctgrId" value="${c.ctgrId}"/>
                                    <input type="hidden" name="searchYn" value=""/>
                                    <ul class="select_month">
                                    	
                                        <c:choose>
                                        	<c:when test="${c.bestRangeType eq 'C1002'}"><!-- 일간-->
                                        		<li>
												    <select name="searchYear" onchange="selectedYearStdDt();">
														<c:forEach var="i" begin="${recentMinStdDtYear}" end="${recentStdDtYear}">
														    <option value="${i}" <c:if test="${c.searchYear eq i }">selected</c:if>>${i}년</option>
														</c:forEach>
												    </select>
												</li>
												<li>
												    <select name="searchMonth" onchange="selectedMonthStdDt();">
														<c:if test="${recentStdDtYear eq c.searchYear}">
															<c:forEach var="i" begin="1" end="${recentStdDtMonth}">
															    <option value="${i}" <c:if test="${c.searchMonth eq i }">selected</c:if>>${i}월</option>        
															</c:forEach>
														</c:if>
														<c:if test="${recentStdDtYear ne c.searchYear}">
															<c:forEach var="i" begin="1" end="12">  
															    <option value="${i}" <c:if test="${c.searchMonth eq i }">selected</c:if>>${i}월</option>        
															</c:forEach>
														</c:if>
												    </select>
												</li>
                                        		<c:if test="${c.searchYn eq 'N'}">
                                        			<select name="searchDay" onchange="selectedDayStdDt();">
                                        			<c:forEach var="i" begin="1" end="${recentStdDtDay}"><!-- 마지막 날짜까지 뿌려주기 -->
														<option value="${i}" <c:if test="${c.searchDay eq i }">selected</c:if>>${i}일</option>
													</c:forEach>
													</select>
                                        		</c:if>
                                        		
                                        		<c:if test="${c.searchYn eq 'Y'}"> 
                                        			<c:if test='${(recentStdDtYear eq c.searchYear) && (recentStdDtMonth eq c.searchMonth)}'>
                                        				<select name="searchDay" onchange="selectedDayStdDt();">
														<c:forEach var="i" begin="1" end="${recentStdDtDay}">
															<option value="${i}" <c:if test="${c.searchDay eq i }">selected</c:if>>${i}일</option>
														</c:forEach>	
														</select>
													</c:if>
													
													<c:if test='${((recentStdDtYear eq c.searchYear) && (recentStdDtMonth ne c.searchMonth)) 
																|| ((recentStdDtYear ne c.searchYear) && (recentStdDtMonth eq c.searchMonth))
																|| ((recentStdDtYear ne c.searchYear) && (recentStdDtMonth ne c.searchMonth))}'>
                                        				<select name="searchDay" onchange="selectedDayStdDt();">
														<c:forEach var="i" begin="1" end="${maximumDay}">
															<option value="${i}" <c:if test="${c.searchDay eq i }">selected</c:if>>${i}일</option>
														</c:forEach>	
														</select>
													</c:if>
                                        		</c:if>
											</c:when>
											<c:when test="${c.bestRangeType eq 'C1003'}"><!-- 주간-->
												<li>
												    <select name="searchYear" onchange="selectedYearStdDt();">
														<c:forEach var="i" begin="${recentMinStdDtYear}" end="${recentStdDtYear}">
														    <option value="${i}" <c:if test="${c.searchYear eq i }">selected</c:if>>${i}년</option>
														</c:forEach>
												    </select>
												</li>
												<li>
												    <select name="searchMonth" onchange="selectedMonthStdDt();">
														<c:if test="${recentStdDtYear eq c.searchYear}">
															<c:forEach var="i" begin="1" end="${recentStdDtMonth}">
															    <option value="${i}" <c:if test="${c.searchMonth eq i }">selected</c:if>>${i}월</option>        
															</c:forEach>
														</c:if>
														<c:if test="${recentStdDtYear ne c.searchYear}">
															<c:forEach var="i" begin="1" end="12">  
															    <option value="${i}" <c:if test="${c.searchMonth eq i }">selected</c:if>>${i}월</option>        
															</c:forEach>
														</c:if>
												    </select>
												</li>
												<li>
													<c:if test="${c.searchYn eq 'N'}">
														<select name="searchWeek" onchange="selectedDayStdDt();">
															<c:forEach var="i" begin="1" end="${recentStdDtWeek}">
															    <option value="${i}" <c:if test="${c.searchWeek eq i }">selected</c:if>>${i}주차</option>
															</c:forEach>
													    </select>
													</c:if>
													<c:if test="${c.searchYn eq 'Y'}">
														<c:if test="${(recentStdDtYear eq c.searchYear) && (recentStdDtMonth eq c.searchMonth)}">
															<select name="searchWeek" onchange="searchWeekStdDt();">
																<c:forEach var="i" begin="1" end="${recentStdDtWeek}">
																    <option value="${i}" <c:if test="${c.searchWeek eq i }">selected</c:if>>${i}주차</option>
																</c:forEach>
															</select>
														</c:if> 
														<c:if test='${((recentStdDtYear eq c.searchYear) && (recentStdDtMonth ne c.searchMonth)) 
																	|| ((recentStdDtYear ne c.searchYear) && (recentStdDtMonth eq c.searchMonth))
																	|| ((recentStdDtYear ne c.searchYear) && (recentStdDtMonth ne c.searchMonth))}'>
	                                        				<select name="searchWeek" onchange="searchWeekStdDt();">
																<c:forEach var="i" begin="1" end="${searchMonthWeek}">
																	<option value="${i}" <c:if test="${c.searchWeek eq i }">selected</c:if>>${i}주차</option>
																</c:forEach>	
															</select>
														</c:if>
													</c:if>
												</li>
											</c:when>
											<c:when test="${c.bestRangeType eq 'C1004'}"><!--월간-->
												<li>
													<select name="searchYear" onchange="selectedYearStdDt();">
													
														<c:forEach var="i" begin="${recentMinStdDtYear}" end="${recentStdDtYear}">
														    <option value="${i}" <c:if test="${c.searchYear eq i }">selected</c:if>>${i}년</option>
														</c:forEach>
													</select>
												</li>
												<li>
												    <select name="searchMonth" onchange="selectedMonthStdDt();">
														<c:if test="${recentStdDtYear eq c.searchYear}">
															<c:forEach var="i" begin="1" end="${recentStdDtMonth}">
															    <option value="${i}" <c:if test="${c.searchMonth eq i }">selected</c:if>>${i}월</option>        
															</c:forEach>
														</c:if>
														<c:if test="${recentStdDtYear ne c.searchYear}">
															<c:forEach var="i" begin="1" end="12">  
															    <option value="${i}" <c:if test="${c.searchMonth eq i }">selected</c:if>>${i}월</option>        
															</c:forEach>
														</c:if>
												    </select>
												</li>
											</c:when>
											<c:when test="${c.bestRangeType eq 'C1005'}"><!--년간-->	
												<li>
												    <select name="searchYear" onchange="selectedYearStdDt();">
														<c:forEach var="i" begin="${recentMinStdDtYear}" end="${recentStdDtYear}">
														    <option value="${i}" <c:if test="${c.searchYear eq i }">selected</c:if>>${i}년</option>
														</c:forEach>
												    </select>
												</li>
                                        	</c:when>
                                        	<c:when test="${c.bestRangeType eq 'C1001'}"><!--실시간-->
                                        		<li>매시각 정각 기준으로 집계됩니다.</li>
                                        	</c:when>
                                        </c:choose>
                                    </ul>
                                    <span class="btn">
                                        <a href="javascript:addRecordsCart('chkRecord');"><img src="${imageServer}/images/music/btn_cart.gif" alt="장바구니에 담기" /></a>
                                        <a href="javascript:addMyListRecords('chkRecord');"><img src="${imageServer}/images/music/btn_myList.gif" alt="마이리스트에 담기" /></a>
                                        <a href="/ht/record/realTimeListExcel/${c.recBestType}?<ui:param />"><img src="${imageServer}/images/music/btn_excel.gif" alt="엑셀로 리스트받기" /></a>
                                    </span>
                                </form>
                            </div>
                        </div>         
                    </div>
                    <!-- //리스트 보기 옵션 -->
                     
                    
                    <!-- typeC2_list 베스트 / 20건씩 -->
                    <div class="typeC2_list">  
                        <table>
                            <colgroup> 
                                <col width="50px" />
                                <col width="87px" />
                                <col width="*" />  
                                <col width="125px" />
                            </colgroup> 
                            <tbody> 
                                <c:import url="/pages/front/record/import/recordListFull.jsp" charEncoding="utf-8"/>
                            </tbody>  
                        </table>
                        <div class="list_tool">
                            <span>
                            <a href="javascript:addRecordsCart('chkRecord');"><img src="${imageServer}/images/music/btn_cart.gif" alt="장바구니에 담기" /></a>
                            <a href="javascript:addMyListRecords('chkRecord');"><img src="${imageServer}/images/music/btn_myList.gif" alt="마이리스트에 담기" /></a>
                            <a href="/ht/record/realTimeListExcel/${c.recBestType}?<ui:param />"><img src="${imageServer}/images/music/btn_excel.gif" alt="엑셀로 리스트받기" /></a>
                        </span>
                        </div> 
                    </div> 
                    <!-- //typeC2_list 베스트 --> 
                    
                     
                         
                </div>
                
            </div>
            <!-- //music -->
             
             
        </div>
        <!-- //이곳까지 추가해주시면 됩니다 --> 

</body>
</html>