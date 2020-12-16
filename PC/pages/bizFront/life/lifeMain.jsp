<%@page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<!-- 태그 라이브러리 -->
<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
<ui:decorator name="htNoQuick"/>
<html>
<%
 response.setHeader("Cache-Control","no-store");
%>
<head>
<script type="text/javascript">
$(document).ready(function(){
	$("#gnbLifeMain").addClass("on");
	$("#content").attr("class", "prdouct");
	gnb();//gnb
	nav();//nav
	lifeSlider();//slide
	lifeLikeInit();//like	
	if($('.header_wrap').length >0){
		bodyScroll();//body scroll
	}	

	// 정렬순서 변경
	$('#productOrderBy').change(function(){
		getLifeMain();
	});
	
	// 해시태그 클릭시
	$('[name=hashTag] > li').click(function(){
		if($(this).hasClass("active")){
			$(this).removeClass("active");
		}else{
			$(this).siblings().removeClass("active");
			$(this).addClass("active");	
		}
		
		getLifeMain();
	});
	
	// 나의 공감 클릭 시
	$('.btn_sympathy').click(function(){		
	    <c:if test='${!isLogin}'>
        	needLogin();
    	</c:if>
    	<c:if test='${isLogin}'>
	    	$(this).toggleClass('active');
			getLifeMain();
    	</c:if>		
	});
});

function getLifeMain(){
	var url = '';
	
	var productOrderBy = $('#productOrderBy').val();
	var hashCode = $('[name=hashTag] > .active').attr("code");
	
	url = '?productOrderBy='+productOrderBy;
	
	if(!isEmpty(hashCode)){
		url += '&hashTag='+hashCode;
	}
	
	location.href=url;
}

function lifeLikeInit(){
	
	var d = new Date();
    var url = "/images/biz/sub/heart_on.gif?a="+d.getTime();
    
    $(".heart.on").css({"background":""});	   
    $(".heart.on").css({background:"url("+url+") 50% 0% no-repeat",backgroundSize: 39});
}
</script>
</head>
<body>
	<div class="life_wrapper">
		<div class="box_life">
			<div class="tit_life">
				<h2>이럴 때,</h2>
				<div class="date_a">우리의 느슨한 연대</div>
				<div class="life_filter">
					<ul class='clear' name="hashTag">
						<c:forEach items="${hashList}" var="l">	
							<li code="${l.code}" <c:if test="${l.code eq c.hashTag}">class="active"</c:if>><a href="#" onclick="javacript:event.preventDefault();">${fn:replace(l.codeName, ' ', '<br>')}</a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		<div class="life_inner">
			<div class="pd_filter">
                <p class="pd_total"><em class="font_t"><fmt:formatNumber value="${listCount}" pattern="#,###" /></em>개</p>
                <div class="form_select">
                    <select id="productOrderBy">
                        <option value="R" <c:if test="${c.productOrderBy eq 'R'}">selected="selected"</c:if>>최근등록순</option>
                        <option value="P" <c:if test="${c.productOrderBy eq 'P'}">selected="selected"</c:if>>인기순</option>
                        <option value="RD" <c:if test="${c.productOrderBy eq 'RD'}">selected="selected"</c:if>>랜덤순</option>
                    </select>
                </div>
            </div>
			<div class="life_zone">			
				<c:if test="${not empty lifeList}">
					<c:forEach items="${lifeList}" var="l" varStatus="st1">							
						<c:choose>
						  	<c:when test='${not empty l.lifeMainParam.imgUrl}'>
								<c:if test='${fn:length(l.lifeSubParam) > 1}'><c:set var="mainClass" value="set03"></c:set></c:if>
								<c:if test='${fn:length(l.lifeSubParam) < 2}'><c:set var="mainClass" value="set01"></c:set></c:if>
							</c:when>
							<c:otherwise>
								<c:if test='${fn:length(l.lifeSubParam) > 1}'><c:set var="mainClass" value="set02"></c:set></c:if>
								<c:if test='${fn:length(l.lifeSubParam) < 2}'><c:set var="mainClass" value="set04"></c:set></c:if>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test='${not empty l.lifeMainParam.imgUrl}'>
								<c:if test='${fn:length(l.lifeSubParam) < 2}'>
									<c:set var="subClass" value="one"></c:set>
								</c:if>
							</c:when>
							<c:otherwise>
								<c:set var="subClass" value=""></c:set>
							</c:otherwise>
						</c:choose>										
						<div class="${mainClass}">
							<div class="sum_life">
								<c:if test="${not empty l.lifeMainParam.imgUrl}">
									<div class="img_life">
										<c:choose>
											<c:when test="${fn:length(l.lifeSubParam) > 1}">
												<c:forEach items="${l.lifeSubParam}" var="n" varStatus="i">
													<c:if test="${i.first}"><a href="/p/${n.sellPrdtBcode}?foo=bar&rccode=pc_life"><ui:image src="${l.lifeMainParam.imgUrl}" alt="${l.lifeMainParam.imgAlt}" /></a></c:if>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<ui:image src="${l.lifeMainParam.imgUrl}" alt="${l.lifeMainParam.imgAlt}" />
											</c:otherwise>
										</c:choose>
									</div>
								</c:if>									
								<div class="txt_life">
									<c:choose>
										<c:when test="${fn:length(l.lifeSubParam) > 1}">
											<c:forEach items="${l.lifeSubParam}" var="n" varStatus="i">
												<c:if test="${i.first}"><a href="/p/${n.sellPrdtBcode}?foo=bar&rccode=pc_life"></c:if>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<a href="#n">
										</c:otherwise>
									</c:choose>
									
										<h2>${l.lifeMainParam.mainText}</h2>
										<p>${l.lifeMainParam.subText}</p>
									</a>
									<c:if test="${not empty l.lifeHashParam}">
										<p class="htag">
											<c:forEach items="${l.lifeHashParam}" var="n">
												<a href="/ht/biz/life/lifeMain?hashTag=${n.code}" code="${n.code}">#${n.codeName}</a>
											</c:forEach>
										</p>
									</c:if>
									<div class="like_heart clear">									
<%-- 										<c:set var="wishCnt" value="${l.lifeMainParam.wishCnt}"/> --%>
<%-- 										<c:if test="${l.lifeMainParam.wishCnt > 999}"><c:set var="wishCnt" value="999+"/></c:if>																		 --%>
<%-- 										<span class="heart <c:if test="${l.lifeMainParam.userWishYn eq 'Y'}"> on</c:if>" code="${l.lifeMainParam.svcSeq}">${wishCnt}</span><!-- 활성화시 on : class 추가 --> --%>
<%-- 										<a href="javascript:" onclick="addBizWishLife(this);return false;" class='btn_life' svcSeq="${l.lifeMainParam.svcSeq}"></a> --%>
									</div>
								</div>								
								<c:choose>
									<c:when test="${fn:length(l.lifeSubParam) > 1}">
										<div class="life_slider">
											<ul class='clear'>
												<c:forEach items="${l.lifeSubParam}" var="m" varStatus="st2">
													<li>
														<a href="/p/${m.sellPrdtBcode}?foo=bar&rccode=pc_life">
															<ui:image src="${m.imgUrl}" />
															<div class="desc_life">
																<h2>${m.title}</h2>
<%-- 																<h3>${m.prvdTitle}</h3> --%>
																<p>${m.prdtName}</p>
															</div>
														</a>
													</li>													
													<c:if test="${fn:length(l.lifeSubParam) > 2 && st2.last}">
														<li>
														</li>
													</c:if>																																							
												</c:forEach>
											</ul>
<!-- 											<div class="custom-pager"><strong></strong><span></span></div> -->
										</div>																			
									</c:when>
									<c:otherwise>
										<c:forEach items="${l.lifeSubParam}" var="n" varStatus="st3">											
											<div class="side_wrap ${subClass}">
												<a href="/p/${n.sellPrdtBcode}">
													<ui:image src="${n.imgUrl}" />
													<h2>${n.title}</h2>
<%-- 												<h3>${m.prvdTitle}</h3> --%>
													<p>${m.prdtName}</p>
												</a>	
											</div>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</div>
						</div>										
					</c:forEach>				
				</c:if>			
			</div>
			<div class="pagination_v2"><ui:bizPagination name="pageHolder" url="/ht/biz/life/lifeMain?" parameters="productOrderBy,hashTag"/></div>
		</div>
	</div>
</body>
</html>