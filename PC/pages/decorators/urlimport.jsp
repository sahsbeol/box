<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>HOTTRACKS</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <c:import url="http://musicfront.hottracks.co.kr/import/topHeader" charEncoding="utf8"/>
    <decorator:head/>
</head>
<body>
<div id="wrap">
	<c:import url="http://musicfront.hottracks.co.kr/menu/importGnb" charEncoding="utf8"/>
    <div id="body">
        <div id="contents">
            <decorator:body/>
        </div><!-- end contents -->
    </div>
    <c:import url="http://musicfront.hottracks.co.kr/import/importFooter" charEncoding="utf8"/>
</div>
</body>
</html>