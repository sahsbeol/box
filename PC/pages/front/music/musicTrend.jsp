<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<ui:decorator name="${decorator}"/>

<head>
<title>핫트랙스 뮤직샵</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="/css/contents.css"/>  
<script type="text/javascript">
var imageServerUri = "<ui:variable key='image.server.host,image.upload.uri' prepare='http://' postfix='/'/>";
</script>
</head>

<body>
<div id="wrap">
	<div id="body"> 

		<!-- 이곳부터 추가해주시면 됩니다 -->
		<div id="container"> 
		  
			<!-- music 현재 페이지 위치 소스 입니다 --> 
			<div class="page_${baseClass}">
				<div class="page-location">
					<p class="title"><img src="${imageServer}/images/${baseClass}/title_${baseClass}_<c:if test="${baseClass eq 'music'}">s09</c:if><c:if test="${baseClass eq 'sound'}">s05</c:if>.gif" alt="뮤직공감" /></p>
					<ul>
						<li><a href="/ht/welcomeMain">홈</a> <span>&gt;</span></li>
						<li><a href="/ht/${decorator}Main"><c:if test="${baseClass eq 'music'}">음반</c:if><c:if test="${baseClass eq 'sound'}">음원</c:if></a> <span>&gt;</span></li>
						<li><a href="/ht/music/${decorator}Trend">음악공감</a> <span>&gt;</span></li>
                        <li><strong><ui:code codeId="${musicTrendCriteria.trendTypeCode}"/></strong></li>
					</ul> 
				</div>
			</div>
			<!-- //music 현재 페이지 위치 소스 입니다 --> 
            
			<!-- snb -->
			<div class="snb_mnew"> 
				<div class="snb_${baseClass}">
					<ul>
                        <li><a href="/company/story/sign">사인회 &amp; 팬미팅</a></li>
                        <c:forEach items="${codes}" var="l" varStatus="s">
                            <li <c:if test="${musicTrendCriteria.trendTypeCode eq l.code}">class="on"</c:if>>
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
					
					<div class="stitle"><h3><ui:code codeId="${musicTrendCriteria.trendTypeCode}"/></h3></div>
					
					<div class="description_01">
						<ul>
						    <c:forEach items="${codes}" var="l" varStatus="s">
						        <c:if test="${l.code eq musicTrendCriteria.trendTypeCode}"><li>${l.codeDescription}</li></c:if>
						    </c:forEach>
						</ul>
					</div>	
			 			 
					<!-- typeD_list_r --> 
					<div class="typeD_list_<c:if test="${baseClass eq 'sound'}">g</c:if><c:if test="${baseClass eq 'music'}">r</c:if>">  
						<div class="typeA_title">   
							<em>
								<form name="form" id="form" action="/ht/music/${decorator}Trend" method="post">
									<input type="hidden" name="trendTypeCode" value="${musicTrendCriteria.trendTypeCode}" />
									<fieldset>
										<legend>공지사항 검색</legend> 
										<select title="검색옵션" name="keyField">
											<!-- <option value="all" <c:if test="${empty musicTrendCriteria.keyField }">selected</c:if>>전체</option> -->
											<option value="all" <c:if test="${musicTrendCriteria.keyField eq 'all' or empty musicTrendCriteria.keyField}">selected</c:if>>전체</option>
											<option value="title" <c:if test="${musicTrendCriteria.keyField eq 'title'}">selected</c:if>>제목</option>
											<option value="albumName" <c:if test="${musicTrendCriteria.keyField eq 'albumName'}">selected</c:if>>음반명</option>
											<option value="musicName" <c:if test="${musicTrendCriteria.keyField eq 'musicName'}">selected</c:if>>곡명</option>
										</select>	 
										<input type="text" name="keyWord" class="textbox" value="${musicTrendCriteria.keyWord }" />
										<input type="image" class="button" alt="검색" src="${imageServer}/images/customer/btn_sh.gif" name="searchBtn"/>
									</fieldset>
								</form> 
							</em>
						</div> 
						<table> 
							<colgroup>
								<col width="" />
							</colgroup>
							<tbody> 
								<c:set var="isDisplayChkek" value="true"/>							
								<c:forEach var="l" items="${musicTrendList }" varStatus="status" >
									<tr>
						                <c:choose>
						                    <c:when test="${isDisplayChkek == true}"> 
						        				<td class="one"> 
						                    </c:when>
						                    <c:otherwise>
						                    	<td>
						                    </c:otherwise>
						                </c:choose>
										<c:set var="isDisplayChkek" value="false"/>
											<ul>
												<li class="product"><a href="/ht/music/${decorator}TrendDetail?trendSeq=${l.trendSeq }&trendType=${l.trendType}&page=${musicTrendCriteria.page}"><ui:image src="${imageServerUri}${l.image}" id="image" width="50" height="50" alt="${l.image }"/></a></li>
												<li class="infor">
													<p class="album_title"><a href="/ht/music/${decorator}TrendDetail?trendSeq=${l.trendSeq }&trendType=${l.trendType}&page=${musicTrendCriteria.page}">${l.title }</a></p>
													<p class="album_artist">${l.summary }</p> 
													<p class="track">등록일 : <fmt:formatDate value="${l.regstDtm }" pattern="yyyy.MM.dd HH:mm:ss"/> <span class="seperate">|</span> 조회 : ${l.viewCnt}건 <span class="seperate">|</span> <em>댓글 : ${l.commentsCnt }</em></p>
												</li>
											</ul> 
										</td> 
									</tr>   
								</c:forEach>
								<c:if test="${empty musicTrendList}">
									<tr><td class="no">상품이 없습니다.</td></tr>
								</c:if>
							</tbody>  
						</table>
						<div class="pager">
							<ui:pagination name="pageHolder" url="/ht/music/${decorator}Trend" parameters="trendTypeCode,page,keyField,keyWord"/>
						</div>  
					</div> 
					<!-- //typeD_list_r --> 
				
				</div>
				
			</div>
			<!-- //music -->
			  
		</div>
		<!-- //이곳까지 추가해주시면 됩니다 --> 
		 
	</div>
</div>
</body>
