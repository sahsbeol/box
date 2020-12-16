<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui"%>
<script type="text/javascript">
jQuery(function($){
    $(".theme_lnb_2depth").each(function(){
        $(this).mousemove(function(){ $(this).addClass("active"); })
               .mouseover(function(){ $(this).addClass("active"); })
               .mouseout(function(){ $(this).removeClass("active"); });
    });
});
</script>
<div id="diary_left">
    <c:forEach items="${masterList}" var="l" varStatus="st">
        <p class="theme_banner"><a href="/ht/theme/${l.themeId}"><ui:image src="${l.themeImgUrl}" alt="${l.themeName}"/></a></p>
    </c:forEach>
    <div class="lnb">
        <c:forEach items="${masterListFull}" var="l" varStatus="st">
            <h3><ui:image src="${l.themeImgUrl}" alt="${l.themeName}"/></h3>
            <ul>
                <c:forEach items="${l.childList}" var="l2" varStatus="st2">
                    <li class="theme_lnb_2depth ${st2.last?'last':''}">
                        <a href="/ht/theme/${l2.themeId}">${l2.themeName}</a>
                        <c:if test="${not empty l2.childList}">
                            <div class="lnb_layer">
                                <ul>
                                    <c:forEach items="${l2.childList}" var="l3" varStatus="st3">
                                        <li><a href="/ht/theme/${l3.themeId}">${l3.themeName}</a></li>
                                    </c:forEach>
                                </ul>
                                <span class="arrow"><img src="${imageServer}/images/theme/layer_arrow.gif"/></span>
                            </div>
                        </c:if>
                    </li>
                </c:forEach>
            </ul>
        </c:forEach>
    </div>
    <div class="best_brand">
        <h3><img src="${imageServer}/images/theme/tit_bestbrand.gif" alt="BEST BRAND" /></h3>
        <ul>
            <c:forEach items="${listBrand}" var="l" varStatus="st">
                <li class="${st.last?'last':''}"><ui:banner bnrLinkUrl="${l.bnrLinkUrl}" bannerImageUrl="${l.bnrImageUrl}" bnrTgtGbn="${l.bnrTgtGbn}" bnrSeq="${l.bnrSeq}" newWdwYn="${l.bnrNewWdwYn}" width="180px" height="120px"/></li>
            </c:forEach>
        </ul>
    </div>
</div>