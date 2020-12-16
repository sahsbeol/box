<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>

                    <ul>
                <c:forEach items="${relationBrandList}" var="relationBrand" varStatus="status">
                        <li>
                            <p class="brand"><a href="/ht/hot/brandDetail?brandId=${relationBrand.brandId}">${relationBrand.brandName}</a></p>
                        </li>
                </c:forEach>
                    </ul>
                    <p class="more">
                    <c:choose>
                        <c:when test="${isGift}"><a href="/ht/hot/brandMain"></c:when>
                        <c:otherwise><a href="/ht/office/officeBrandSearchPage"></c:otherwise>
                    </c:choose>
                        <img src="${imageServer}/images/gift/btn_more.gif" alt="더보기" />
                    </a></p>