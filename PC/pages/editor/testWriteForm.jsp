<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://hottracks.co.kr/taglib/ui"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/scripts/editor/css/editor.css" type="text/css" charset="utf-8" />
<link rel="stylesheet" href="/scripts/editor/css/contents4view.css" type="text/css" charset="utf-8" />
<script src="/scripts/editor/js/editor.js" type="text/javascript" charset="utf-8"></script>
<script src="/scripts/editor/js/editorSave.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
<!--
    function save() {

        if(Editor.save()) {
            document.forms["editorForm"].submit();
        }

    }
//-->
</script>
</head>
<body>
<div id="contents">
<div id="contents-area">
<h3>코드관리</h3>

등록 폼
<p />
<form name="editorForm" action="/admin/editor/testWrite" method="post">
<c:import url="/admin/editor/editor?name=editorForm&width=800" />
</form>

<div>
<p /><a href="#" onclick="save();" title="등록">등록</a> <a href="#"
    onclick="" title="취소">취소</a></p>
</div>
</div>



</div>
</body>
</html>