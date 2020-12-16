<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
 <div class="board-detail">
     <table class="list" summary="상품평가 목록" id="reviewList">
         <caption>상품평가 목록</caption>
         <colgroup>
             <col width="5%" />
             <col width="10%" />
             <col width="*" />
             <col width="10%" />
             <col width="10%" />
         </colgroup>
         <thead>
             <tr>
                 <th scope="col"><img src="${imageServer}/images/common/detail_list_number.gif" alt="번호" /></th>
                 <th scope="col"><img src="${imageServer}/images/common/detail_list_satisfaction.gif" alt="만족도" /></th>
                 <th scope="col" colspan="2"><img src="${imageServer}/images/common/detail_list_product_comment.gif" alt="상품평" /></th>
                 <th scope="col"><img src="${imageServer}/images/common/detail_list_writer.gif" alt="작성자" /></th>
                 <th scope="col"><img src="${imageServer}/images/common/detail_list_reporting_date.gif" alt="작성일" /></th>
             </tr>
         </thead>
         <tbody>
       		<c:forEach items="${list}" var="dto" varStatus="status">
              <tr>
                  <td class="number">
                   ${pageHolder.startNumber + status.index}
              	</td>
                  <td class="satisfaction"><img src="${imageServer}/images/common/icon_estimation0${dto.grade}.gif" alt="★☆☆☆☆" /></td>
                  <td class="product-comment">
                  	<a href="#review-content0${status.index + 1}" class="review" name="review">${dto.reviewTitle}</a>
                  </td>
                  
                  <td class="button">
                  </td>
                  <td class="writer"><ui:idAsterisk value="${dto.userId}"/></td>
                  <td class="reporting-date"><fmt:formatDate pattern="yyyy/MM/dd" value="${dto.registDatetime}" /></td>
              </tr>
              <tr id="review-content0${status.index + 1}" >
              	 <td id="review-content0${status.index + 1}" colspan="6" class="content">
              	 	${dto.reviewContents}
				</td>
			 </tr>
             </c:forEach>
         </tbody>
     </table>
 </div><!-- end board-detail -->
 <div class="pager">
 	<ui:paginationScript name="pageHolder" scriptName="loadReviewSubList" parameters="barcode"/>
 </div><!-- end pager -->
<script type="text/javascript">
jQuery(function($) {
	
	$(".review").click(function() {
		$(this).parent().parent().next().children().toggle();
		return false;
	});
		
	
	$("span.product-review").each(function(){
		var $pCommentCount = $(this);
		$pCommentCount.text("(${listSize})");
	});
	$(document).ready(function(){
		$(".content").hide();
    });
});
</script>