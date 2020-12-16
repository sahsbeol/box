<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:forEach begin="1" end="${steps}" varStatus="status">
    <ui:select clazz="select" name="${inputName}" key="categoryStep${status.count}" keyvalue="selCateIdStep${status.count}" onchange="categorySelectLoad(this.value, '${maxLength}', '${divId}', '${inputName}');" title="${status.count}번째 카테고리"></ui:select>
</c:forEach>
