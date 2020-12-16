<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="detail"/>
<html>
<head>

<script type="text/javascript" src="/js/jquery.form.js" charset="utf-8"></script>
<script type="text/javascript">
function useApply() {
    $("#loginForm").ajaxSubmit({
        type : "POST"
        , url : "/ht/temp/mile?cmd=useApply&amt=" + $("input[name=use]").val()
        , async : false
        , success : function(result){
            alert("사용되었습니다.");
        }
        ,error: function(xhr, status, error) {
            alert("오류입니다.");
        }
    });
}

function useCancleApply() {
    $("#loginForm").ajaxSubmit({
        type : "POST"
        , url : "/ht/temp/mile?cmd=useCancleApply&amt=" + $("input[name=useCancle]").val()
        , async : false
        , success : function(result){
            alert("사용취소되었습니다.");
        }
        ,error: function(xhr, status, error) {
            alert("오류입니다.");
        }
    });
}

function saveApply() {
    $("#loginForm").ajaxSubmit({
        type : "POST"
        , url : "/ht/temp/mile?cmd=saveApply&amt=" + $("input[name=save]").val()
        , async : false
        , success : function(result){
            alert("적립되었습니다.");
        }
        ,error: function(xhr, status, error) {
            alert("오류입니다.");
        }
    });
}

function saveCancleApply() {
    $("#loginForm").ajaxSubmit({
        type : "POST"
        , url : "/ht/temp/mile?cmd=saveCancleApply&amt=" + $("input[name=saveCancle]").val()
        , async : false
        , success : function(result){
            alert("적립취소되었습니다.");
        }
        ,error: function(xhr, status, error) {
            alert("오류입니다.");
        }
    });
}
</script>
</head>
<body>
<div>
    <ui:errorMessage message="${flash.message}"/><br/>
    <form method="post" id = "loginForm" action="/ht/temp/login">
        로그인아이디<input type="text" name="id" value=""><br/>
        비번 <input type="password" name="password" value=""><br/>
        <input type="submit" value="로그인"><br/>
        <a href="/ht/temp/logout">[로그아웃]</a>
    <table border=1>
        <tr>
            <td>통합마일리지:${totMileAmt}</td>
            <td></td>
        </tr>
        <tr>
            <td>사용<input type="text" name="use" value=""></td>
            <td><a href="javascript:useApply();">적용</a></td>
        </tr>
        <tr>
            <td>사용취소<input type="text" name="useCancle" value=""></td>
            <td><a href="javascript:useCancleApply();">적용</a></td>
        </tr>
        <tr>
            <td>적립<input type="text" name="save" value=""></td>
            <td><a href="javascript:saveApply();">적용</a></td>
        </tr>
        <tr>
            <td>적립취소<input type="text" name="saveCancle" value=""></td>
            <td><a href="javascript:saveCancleApply();">적용</a></td>
        </tr>
    </table>
    </form>
    <pre>
        <c:if test="${isLogin}">
            LoginUser] ${loginUser}
        </c:if>
    </pre>
</div>
</body>
</html>