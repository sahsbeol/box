<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="none" />
<body>
<script type="text/javascript">
isLogin = ${isLogin};
$(document).ready(function(){
    $('#btnReply').click(function(e){
        e.preventDefault();
        if (!isLogin) {
            needLogin();
            return false;
        }
        if ($('textarea[name=contents]').val() == '') {
            alert('댓글을 입력하세요.');
            return false;
        }
        
        var strLength = lengthMsg();
        if (strLength > 200) {
            alert('200byte까지 입력 가능합니다.');
            return false;
        }
        
        if (confirm('등록 하시겠습니까?')) {
            $('#frmReply').ajaxSubmit({
                url: '/company/store/replyIns'
                ,dataType: 'json'
                ,success: function(data) {
                    alert('<fmt:message key="message.save.success"/>'); 
                    goCommentList("1", "&boardseq=${c.boardseq }");
                }
                ,error: function(data) {
                    alert('<fmt:message key="error.common.system"/>');
                }
            });
        }
        return true;
    });
    
    $('textarea[name=contents]').keydown(function(e){
        if (e.which == 13) {
            return false;
        }
    });
    
    $('textarea[name=contents]').keyup(function(e){
        if (e.which != 8) {
            var strLength = lengthMsg();
            $('#strLength').html(strLength);
            if (strLength > 200) {
                alert('200byte까지 입력 가능합니다.');
                return false;
            }
        } else {
            var strLength = lengthMsg();
            $('#strLength').html(strLength);
        }
    });
    
    $.each($('a[delList|="delList"]'), function(index) {
        $(this).click(function(){
            if (confirm('삭제 하시겠습니까?')) {
                var value = $(this).attr('commentseq');
                $('#frmReply').ajaxSubmit({
                    url: '/company/store/replyDel'
                    ,data: {commentseq:value}
                    ,dataType: 'json'
                    ,success: function(data) {
                        alert('<fmt:message key="message.delete.success"/>'); 
                        goCommentList("1", "&boardseq=${c.boardseq }");
                    }
                    ,error: function(data) {
                        alert('<fmt:message key="error.common.system"/>');
                    }
                });
                return true;
            }
        });
    });
});

function lengthMsg() { 
    var ls_str = $('textarea[name=contents]').val(); // 이벤트가 일어난 컨트롤의 value 값 
    var li_str_len = ls_str.length; // 전체길이 

    // 변수초기화  
    var i = 0;     // for문에 사용 
    var li_byte = 0;  // 한글일경우는 2 그밗에는 1을 더함 
    var li_len = 0;  // substring하기 위해서 사용 
    var ls_one_char = ""; // 한글자씩 검사한다 
    var ls_str2 = ""; // 글자수를 초과하면 제한할수 글자전까지만 보여준다. 

    for(i=0; i< li_str_len; i++) { 
        // 한글자추출 
        ls_one_char = ls_str.charAt(i); 
     
        // 한글이면 2를 더한다. 
        if (escape(ls_one_char).length > 4) { 
            li_byte += 2; 
        }else{   // 그밗의 경우는 1을 더한다. 
            li_byte++; 
        } 
        
        li_len = i + 1; 
    } 
    
    return li_byte;
} 
</script>
<h3><img src="http://image.hottracks.co.kr/info/text/text_shop_event_05.png" alt="참여하기" />&nbsp;<c:choose><c:when test="${isLogin}"><a href="/company/logout" id="logout">[로그아웃]</a></c:when><c:otherwise><a href="javascript://" onclick="login()" id="login">[로그인]</a></c:otherwise></c:choose></h3>
<div class="reply">
    <p class="alim">* 본인이 작성한 글만 보실 수 있습니다.</p>
    <ul class="replyView">
        <c:if test="${empty comments}"><li></li></c:if>
        <c:forEach items="${comments}" var="item" varStatus="status">
            <li>
                <strong>${item.registerid }</strong>
                <span><c:out value="${item.contents }" escapeXml="true"/><c:if test="${loginUser.id == item.registerid }"><a href="#none" title="삭제" delList="delList" commentseq="${item.commentseq }"><img src="http://image.hottracks.co.kr/info/icon/ico_del.png" alt="삭제" /></a></c:if></span>
                <em><fmt:formatDate value="${item.registerdate }" pattern="yyyy/MM/dd"/></em>
            </li>
        </c:forEach>
    </ul>
    
    <!-- paging -->
    <c:if test="${not empty comments}">
        <div class="paging">
            <ui:paginationScript name="pageHolder" scriptName="goCommentList" parameters="boardseq"/>
        </div>
    </c:if>
    <!-- //paging -->   
    
    <form method="post" action="/company/store/replyIns" onsubmit="return true" name="frmReply" id="frmReply">
        <input type="hidden" name="boardseq" value="${c.boardseq}" />
        <!-- 댓글작성 -->
        <div class="contReplyWrite">
            <textarea<c:if test="${isLogin}"> style="background:none;"</c:if> onfocus="this.style.backgroundImage='none'" rows="" cols="" name="contents" id="replyText"></textarea>
            <div class="write">
                <a title="쓰기" href="#none"><img alt="댓글쓰기" src="http://image.hottracks.co.kr/info/btn/btn_write_reply.png" id="btnReply"/></a>
                <p>(<span id="strLength">0</span>/200byte)</p>
            </div>  
        </div>
    </form>
    <!-- //댓글작성 -->
</div><!-- //reply -->
</body>
</html>