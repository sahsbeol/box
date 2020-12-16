<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://hottracks.co.kr/taglib/ui" %>
<ui:decorator name="none"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
수정 폼
<!-- 수정폼에서는 아래와 같이 수정할 내용을 파라미터로 전달 -->
<p/>
<form name="editorForm" action="/admin/editor/testUpdate" method="post">
<c:import url="/hottracks/editor/editor?name=editorForm&editorContent=${editorContent}&width=800" />
</form>


<div>
<p/>
        <a href="#" onclick="save();" title="등록">등록</a>
        <a href="#" onclick="" title="취소">취소</a>
</div>




</body>
</html>