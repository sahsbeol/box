<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>

<html>
<head>
<script type="text/javascript" src="/js/jquery_board.js"></script>
<script type="text/javascript">

jQuery(function($){
	//update article hit
	$("a[href^='#faq']").each(function(){
		var seq =  $(this).siblings("input").val();
		$(this).toggle(function(){
			//setHitVal
			var $hit   = $(this).parent().parent().find("#hit");
            var hitVal = parseInt($hit.text()) + 1;
        	$hit.text(hitVal);
        	
        	//setHit
	    	$.ajax({
				type: "GET"
				,url: "/ht/help/AjaxFFaqSetHit"
				,dataType: "html"
				,data:{seq:seq}
			});  
	    }
	    ,function(){/*untoggle do nothing*/}
	    );
	});
});
</script>	
</head>
<body>
			<div class="page-location">
				<p>현재 페이지 위치</p>
				<ul>
					<li><a href="/ht/help/listNotice?categoryId=00">HOTTRACKS 고객센터</a> <span>&gt;</span></li>
					<li><strong><ui:code codeId="${faqCriteria.categoryCode}" /> </strong></li>
				</ul>
			</div><!-- end page-location -->
			<div class="faq">
				<h3><img src="${imageServer}/images/help/h3_title_${faqCriteria.categoryCode}.gif" /></h3>
				<div class="faq-search">
					<dl>
						<dt class="direct"><img src="${imageServer}/images/help/dt_direct.gif" alt="FAQ바로찾기" /></dt>
						<dd class="direct">
							<form name="form" action="/ht/help/fFaqBestListPage">
							<fieldset>
								<legend>자주묻는 질문 검색</legend>
								<input type="hidden" name="categoryCode" value="${faqCriteria.categoryCode}"/>
								<input type="text" class="textbox" name="title" value="${faqCriteria.title}"/>
								<input type="image" src="${imageServer}/images/common/btn_board_search.gif" alt="검색" class="button""/>
							</fieldset>
							</form>
						</dd>
						
					</dl>
				</div><!-- end faq-search -->
				<p class="heading-comment"><img src="${imageServer}/images/help/h4_title_faq_main.gif" alt="BEST FAQ 고객들께서 가장 많이 궁금 해하시는 사항입니다." /></p>
				<div class="board">
				    
					<table class="list" summary="자주묻는 질문과 답변의 글 번호 질문 구분 재목 조회수 순서로 보여주는 목록" >
						<caption>FAQ 목록</caption>
						<colgroup>
							<col width="5%" />
							<col width="20%" />
							<col width="*" />
							<col width="7%" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col"><img src="${imageServer}/images/common/board_list_number.gif" alt="번호" /></th>
								<th scope="col"><img src="${imageServer}/images/common/board_list_section.gif" alt="구분" /></th>
								<th scope="col"><img src="${imageServer}/images/common/board_list_subject.gif" alt="제목" /></th>
								<th scope="col"><img src="${imageServer}/images/common/board_list_view_count.gif" alt="조회수" /></th>
							</tr>
						</thead>
					<c:choose>
            			<c:when test="${pageHolder.totalRows != 0}">
							<tbody id="tbodyRows">
								<c:forEach items="${faqList}" var="faqDomain" varStatus="status">
		                        <tr>
		                            <td class="number">${pageHolder.startNumber + status.index}</td>
		                            <td class="section"><ui:code codeId="${faqDomain.categoryCode}"/></td>
		                            <td class="subject01">
		                            	<input type="hidden" value="${faqDomain.seq}"/>
		                                 <a href="#faq-list${pageHolder.startNumber + status.index}">
		                                    <c:out value="${faqDomain.title}" escapeXml="true" />
		                                </a>
		                            </td>
		                            <td class="view-count" id="hit">${faqDomain.hits}</td>
		                        </tr>
		                        <tr id="faq-list${pageHolder.startNumber + status.index}">
									<td colspan="4" class="list-content">${faqDomain.cont}</td>
								</tr>
		                        </c:forEach>
							</tbody>
					</table>
						</c:when>
	           	 		<c:otherwise>
	           	 		<tbody> 
	           	 			<tr>
	           	 				<td class="no-answer" colspan="4"><img src="${imageServer}/images/common/no_result.gif" alt="상품이 존재하지 않습니다" /></td>
	           	 			</tr>
	           	 		</tbody>   
	          	 		</table>
						</c:otherwise>
            		</c:choose>
				</div><!-- end board -->
				<div class="pager">
					<ui:pagination  name="pageHolder" url="/ht/help/fFaqListPage" parameters="title, categoryCode" />
				</div><!-- end pager -->
			</div><!-- end faq -->
</body>
</html>