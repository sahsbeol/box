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
	
	
	//hide all tab and show one tab which equal categoryCode
	var	categoryCode= "${faqCriteria.categoryCode}";
	var	cutedCategoryCode = categoryCode.substr(0,4);
	
	function changeCode2Id(categoryCode){
		var divId;
		switch(cutedCategoryCode){
			case 'C039' :
				divId = 'divOrder';
				break;
			case 'C040' :
				divId = 'divUser';
				break;
			case 'C041' :
				divId = 'divEtc';
				break;
		}
		return divId;
	};
	
	function hideAllTab(){
		$("div[id^='div']").each(function(){
			var $div = $(this);
			$div.hide();
		});
	}
	
	function showTab(){
		var selectedTabName = changeCode2Id(cutedCategoryCode);
		$('#'+selectedTabName).show();
	}
	
	function changeImageUrlOnOff(){
		$(".section-menu img").each(function(){
			var $img = $(this);
			var imageUrlVal = $(this).attr("src");
			var isSelected = (imageUrlVal.indexOf(categoryCode,0) != -1);
			if(isSelected){
				imageUrlVal = imageUrlVal.replace("off","on");
				$img.attr("src", imageUrlVal);
			}
		});
	}
	
	$(document).ready(function(){
		hideAllTab();
		showTab();
		changeImageUrlOnOff();
	});
	                        
});
</script>	
</head>
<body>
			<div class="page-location">
				<p>현재 페이지 위치</p>
				<ul>
					<li><a href="/ht/help/listNotice?categoryId=00">HOTTRACKS 고객센터</a> <span>&gt;</span></li>
					<c:if test="${empty faqCriteria.categoryCode}">
					    <li>FAQ</li>
					</c:if>
                    <c:if test="${faqCriteria.categoryCode eq 'C0391' || faqCriteria.categoryCode eq 'C0392' || faqCriteria.categoryCode eq 'C0393' || faqCriteria.categoryCode eq 'C0394'}">
                        <li><a href="/ht/help/fFaqBestListPage?categoryCode=P0039"><ui:code codeId="P0039"/></a> <span>&gt;</span></li>
                    </c:if>
                    <c:if test="${faqCriteria.categoryCode eq 'C0401' || faqCriteria.categoryCode eq 'C0402' || faqCriteria.categoryCode eq 'C0403' || faqCriteria.categoryCode eq 'C0404'}">
                        <li><a href="/ht/help/fFaqBestListPage?categoryCode=P0040"><ui:code codeId="P0040"/></a> <span>&gt;</span></li>
                    </c:if>
                    <c:if test="${faqCriteria.categoryCode eq 'C0411' || faqCriteria.categoryCode eq 'C0412' || faqCriteria.categoryCode eq 'C0413'}">
                        <li><a href="/ht/help/fFaqBestListPage?categoryCode=P0041"><ui:code codeId="P0041"/></a> <span>&gt;</span></li>
                    </c:if>
                    <li><strong><ui:code codeId="${faqCriteria.categoryCode}"/></strong></li>
				</ul>
			</div><!-- end page-location -->
			<div class="faq">
			    
				<h3>
				    <c:if test="${!empty faqCriteria.categoryCode}"><img src="${imageServer}/images/help/h3_title${faqCriteria.categoryCode}.gif" alt="주문관련 FAQ 바로찾기" /></c:if>
				    <c:if test="${empty faqCriteria.categoryCode}"><img src="${imageServer}/images/help/faq_default_title.gif" /></c:if>
				</h3>
				<div class="faq-search">
					<dl>
						<dt class="direct"><img src="${imageServer}/images/help/dt_direct.gif" alt="FAQ바로찾기" /></dt>
						<dd class="direct">
							<form name="form" action="/ht/help/fFaqListPage" method="get">
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
				<div class="section-menu">
					<div id="divOrder">
						<ul>
							<li>
								<a href="/ht/help/fFaqListPage?categoryCode=C0391">
									<img src="${imageServer}/images/help/tabC0391_off.gif" alt="주문결제" />
								</a>
							</li>
							<li>
								<a href="/ht/help/fFaqListPage?categoryCode=C0392">
									<img src="${imageServer}/images/help/tabC0392_off.gif" alt="배송" />
								</a>
							</li>
							<li>
								<a href="/ht/help/fFaqListPage?categoryCode=C0393">
									<img src="${imageServer}/images/help/tabC0393_off.gif" alt="반품/교환/환불" />
								</a>
							</li>
							<li>
								<a href="/ht/help/fFaqListPage?categoryCode=C0394">
									<img src="${imageServer}/images/help/tabC0394_off.gif" alt="세금계산서 / 증빙" />
								</a>
							</li>
						</ul>
					</div>
					<div id="divUser">
						<ul>
							<li>
								<a href="/ht/help/fFaqListPage?categoryCode=C0401">
									<img src="${imageServer}/images/help/tabC0401_off.gif" alt="회원정보" />
								</a>
							</li>
							<li>
								<a href="/ht/help/fFaqListPage?categoryCode=C0402">
									<img src="${imageServer}/images/help/tabC0402_off.gif" alt="마일리지/쿠폰" />
								</a>
							</li>
							<li>
								<a href="/ht/help/fFaqListPage?categoryCode=C0403">
									<img src="${imageServer}/images/help/tabC0403_off.gif" alt="상품문의" />
								</a>
							</li>
							<li>
								<a href="/ht/help/fFaqListPage?categoryCode=C0404">
									<img src="${imageServer}/images/help/tabC0404_off.gif" alt="이벤트" />
								</a>
							</li>
						</ul>
					</div>
					<div id="divEtc">
						<ul>
							<li>
								<a href="/ht/help/fFaqListPage?categoryCode=C0411">
									<img src="${imageServer}/images/help/tabC0411_off.gif" alt="영업점" />
								</a>
							</li>
							<li>
								<a href="/ht/help/fFaqListPage?categoryCode=C0412">
									<img src="${imageServer}/images/help/tabC0412_off.gif" alt="사이트이용/장애" />
								</a>
							</li>
							<li>
								<a href="/ht/help/fFaqListPage?categoryCode=C0413">
									<img src="${imageServer}/images/help/tabC0413_off.gif" alt="기타" />
								</a>
							</li>
						</ul>
					</div>
				</div><!-- end section-menu -->
				
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
	                                    ${faqDomain.title}
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