<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <c:import url="/pages/decorators/title.jsp"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <!--[if IE 6]>
        <link rel="stylesheet" type="text/css" href="/css/ie6.css" />
    <![endif]-->
    <script type="text/javascript" src="/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="/js/jquery.tools.min.js"></script>
    <script type="text/javascript" src="/js/jquery.timers-1.2.js"></script>
    <script type="text/javascript" src="/js/jquery_common.js"></script>
    <script type="text/javascript" src="/scripts/common"></script>
    <script type="text/javascript" src="/js/jquery.cookie.js"></script>
    <script type="text/javascript" src="/scripts/gnb"></script>
    
    <link rel="stylesheet" type="text/css" href="/css/re_main.css" />
    <link rel="stylesheet" type="text/css" href="/css/contents.css" />
    <decorator:head/>
    <style type="text/css">
        #contents {
            float: none;
            margin: 0 auto;
            width: 1030px;
        }
    </style>
</head>
<body>
	<div id="wrap">
        <c:import url="/menu/mainGnb"/>
		<decorator:body/>
		<c:import url="/menu/footer" />
	</div>
</body>
</html>