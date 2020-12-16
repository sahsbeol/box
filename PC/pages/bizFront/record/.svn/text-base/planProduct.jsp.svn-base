<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="${decorator}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<script type="text/javascript">




$(document).ready(function(){
});
</script>
</head>
<body>


        <!-- 이곳부터 추가해주시면 됩니다 -->
        <div id="container"> 
          
            <!-- music 현재 페이지 위치 소스 입니다 --> 
            <div class="page_${baseClass}">
                <div class="page-location">
                    <p class="title">
                        <c:if test="${decorator eq 'record'}"><img src="${imageServer}/images/music/title_music_s06.gif" alt="기획상품" /></c:if>
                        <c:if test="${decorator eq 'dvd'}"><img src="${imageServer}/images/dvd/title_dvd_s05.gif" alt="기획상품" /></c:if>
                    </p>
                    <ul>
                        <li><a href="/">홈</a> <span>&gt;</span></li>
                        
                        <c:if test="${fn:contains('C0971,C0973', planDispCode)}">
                            <li><a href="<ui:recordConstants key="url_record_main" />">음반</a> <span>&gt;</span></li>
                            <li><a href="/ht/record/planProduct/C0971">기획상품</a> <span>&gt;</span></li> 
                            <li>
                                <strong>
                                    <c:if test="${planDispCode eq 'C0971'}">단독판매상품</c:if>
                                    <c:if test="${planDispCode eq 'C0973'}">재발매상품</c:if>
                                </strong>
                            </li>
                        </c:if>
                        
                        <c:if test="${fn:contains('C0972,C0976', planDispCode)}">
                            <li><a href="<ui:recordConstants key="url_dvd_main" />">BLU-RAY / DVD</a> <span>&gt;</span></li>
                            <li><a href="/ht/record/planProduct/C0972">기획상품</a> <span>&gt;</span></li> 
                            <li>
                                <strong>
                                    <c:if test="${planDispCode eq 'C0972'}">단독판매상품</c:if>
                                    <c:if test="${planDispCode eq 'C0976'}">초특가상품</c:if>
                                </strong>
                            </li>
                        </c:if>
                    </ul> 
                </div>
            </div>
            <!-- //music 현재 페이지 위치 소스 입니다 -->
             
            <!-- snb -->
            <div class="snb_mnew"> 
                <div class="snb_${baseClass}">
                    <ul>
                        <c:if test="${decorator eq 'record'}">
                            <li <c:if test="${planDispCode eq 'C0971'}">class="on"</c:if>><a href="./C0971">단독판매상품</a></li>
                            <li <c:if test="${planDispCode eq 'C0973'}">class="on"</c:if>><a href="./C0973">재발매상품</a></li> 
                        </c:if>
                        <c:if test="${decorator eq 'dvd'}">
                            <li <c:if test="${planDispCode eq 'C0972'}">class="on"</c:if>><a href="./C0972">단독판매상품</a></li>
                            <li <c:if test="${planDispCode eq 'C0976'}">class="on"</c:if>><a href="./C0976">초특가상품</a></li> 
                        </c:if>
                    </ul>
                </div>                  
            </div>
            <!-- //snb --> 
            
            <!-- music -->
            <div id="${baseClass}">
             
                <div class="contents"> 
                
                    <c:if test="${fn:contains('C0971,C0972', planDispCode)}">
	                    <div class="description_01">
	                        <ul> 
	                            <li>오직 핫트랙스에서만 만나 보실 수 있는 상품입니다.</li> 
	                        </ul>
	                    </div>  
                    </c:if>
              
                    <div class="stitle">
                        <h3>
                            <c:if test="${planDispCode eq 'C0971'}">단독판매상품</c:if>
                            <c:if test="${planDispCode eq 'C0972'}">단독판매상품</c:if>
                            <c:if test="${planDispCode eq 'C0973'}">재발매상품</c:if>
                            <c:if test="${planDispCode eq 'C0976'}">초특가상품</c:if>
                        </h3>
                    </div>
                    
                    <!-- 리스트 보기 옵션 --> 
                    <div class="typeC_title">
                        <div class="list_tool">  
                            <span class="btn">
                                <a href="javascript:addRecordsCart('chkRecord');"><img src="${imageServer}/images/music/btn_cart.gif" alt="장바구니에 담기" /></a>
                            </span>
                        </div>
                    </div>  
                    <!-- //리스트 보기 옵션 --> 
                     
                    <!-- typeB3_list 12건씩 -->
                    <div
                        <c:if test="${planDispCode eq 'C0971' || planDispCode eq 'C0973'}">class="typeB3_list"</c:if>
                        <c:if test="${planDispCode eq 'C0972'}">class="typeB7_list"</c:if>
                        <c:if test="${planDispCode eq 'C0976'}">class="typeC_list"</c:if> 
                    >
                        <c:if test="${planDispCode eq 'C0971' || planDispCode eq 'C0973'}">
                            <c:import url="/pages/front/record/import/recordListThum3.jsp" charEncoding="utf-8"/>
                        </c:if>
                        <c:if test="${planDispCode eq 'C0972'}">
                            <c:import url="/pages/front/record/import/recordListThum3Dvd.jsp" charEncoding="utf-8"/>
                        </c:if>
                        <c:if test="${planDispCode eq 'C0976'}">
                            <c:import url="/pages/front/record/import/recordListFull.jsp" charEncoding="utf-8"/>
                        </c:if>
                        
                        <div class="pager">
                            <ui:pagination name="pageHolder" url="?" parameters="userName,userId,beginOrderDate,endOrderDate,orderNum,userGradeId,musicShopUserGradeId"/>
                        </div>  
                    </div>
                    <!-- //typeB3_list --> 
                      
                </div>
                
            </div>
            <!-- //music -->
             
        </div>
        <!-- //이곳까지 추가해주시면 됩니다 --> 
 

</body>
</html>