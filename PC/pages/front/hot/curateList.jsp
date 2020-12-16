<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none" />
<script type="text/javascript">
<!--
var page = 1;
jQuery(function($){
    $(document).ready(function(){
        loadCurateList();
    });
    
    $(".order-by").click(function(e){
        e.preventDefault();
        var type = $(this).attr("href");
        $(".order-by.active").removeClass("active");
        $(type).addClass("active");
        page = 1;
        $("#curateList").empty();
        loadCurateList();
    });
    
    $(window).scroll(function(){
        // 남은 개수가 0인경우 더이상 호출 하지 않기 위한 용도
        if($("input[name=eof]").val() == "0"){
           if(parseInt($(window).scrollTop() + $(window).height()) >= parseInt($("#footer").offset().top) - 100){
               $("input[name=eof]").val("1");
               page++;
               loadCurateList();
           }
        }
     });
});

function loadCurateList(){
    var type = $(".order-by.active").attr("href");
    //$("#curateLoading").html('<img src="${imageServer}/images/renewal/common/ajax-loader.gif"/>');
    $.ajax({
        type: "GET"
       ,url: "/ht/hot/curateLayer/${clCriteria.eventId}"
       ,data: {orderBy : type.replace("#", ""), page : page}
       ,dataType: "html"
       ,success : function(htmlStr){
           $("#curateLoading").empty();
           $("#curateList").append(htmlStr);
           
           if(page == 1)    $(".curate-item").show();
           else             $(".curate-item").fadeIn(750);
           
           if(!isEmpty($.trim(htmlStr))){
               $("input[name=eof]").val("0");
           }
       }
       ,error: function(data) {
           alert('<fmt:message key="error.common.system"/>');
       }
   });
}

function editCurateFrm(eventId, crtSeq){
    if(preValidation()){
        $("#curateFrm").load("/ht/hot/curateFrm?eventId="+eventId+"&crtSeq="+crtSeq);
    }
}

function toggleCurateComment(seq){
    if($("#btnChildCmnt"+seq).hasClass("active")){
        $('#childComment'+seq).empty();
        $("#btnChildCmnt"+seq).removeClass("active");
    }else{
        // loadCurateComments(seq, "1");
        $('#childComment'+seq).load('/ht/hot/curateList/comments/'+seq);
        $("#btnChildCmnt"+seq).addClass("active");
    }
}

function loadCurateComments(crtSeq, page){
    $('#childComment'+crtSeq).load('/ht/hot/curateList/comments/'+crtSeq+'?page=' + page, function (){
        $("html,body").scrollTop($('#childComment'+crtSeq).offset().top-260);
    });
}

function loadChildComment4Page(page, param){
    params = param.split("&");
    var crtSeq = '';
    for(var i = 0; i<params.length; i++){
        if(params[i].indexOf("crtSeq=") == 0){
            crtSeq = params[i].replace("crtSeq=", "");
        }
    }
    loadCurateComments(crtSeq, page);
}

function likeCurate(crtSeq) {
    var cnt = parseInt($("#crtMst"+crtSeq).find(".btn_like").text().replace(","));
    if (preValidation()) {
        $.ajax({
            type: 'GET'
            ,url: '/ht/hot/curateLike?crtSeq='+crtSeq
            ,dataType: 'json'
            ,success: function(data) {
                if (data.save) {
                    alert('쪼아쪼아~♥');
                    $("#crtMst"+crtSeq).find(".btn_like").html(price_format(cnt+1));
                } else {
                    alert(data.errorMessages);
                }
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function saveCurateComment(crtSeq) {
    var cnt = parseInt($("#btnChildCmnt"+crtSeq).find(".btn_cmnt").text().replace(","));
    if(isEmpty($('form[name=curateCommentFrm'+crtSeq+']').find("[name=cmnt]").val())){
        alert("코멘트 내용을 입력해주세요");
        $('form[name=curateCommentFrm'+crtSeq+']').find("[name=cmnt]").focus();
        return false;
    }
    if (preValidation()) {
        $('form[name=curateCommentFrm'+crtSeq+']').ajaxSubmit({
            url: '/ht/hot/curateList/comments/save'
            ,dataType: 'json'
            ,success: function(data) {
                alert('<fmt:message key="message.save.success"/>');
                $("#btnChildCmnt"+crtSeq).find(".btn_cmnt").html(price_format(cnt+1));
                loadCurateComments(crtSeq, "1");
            }
            ,error: function(data) {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
    return false;
}

function deleteCurateComment(crtCmntSeq, crtSeq) {
    var cnt = parseInt($("#btnChildCmnt"+crtSeq).find(".btn_cmnt").text().replace(","));
    if (preValidation()) {
        if (confirm('삭제하시겠습니까?')) {
            $.ajax({
                type: 'GET'
                ,url: '/ht/hot/curateList/comments/delte'
                ,data: {crtCmntSeq:crtCmntSeq,crtSeq:crtSeq}
                ,dataType: 'json'
                ,success: function(data) {
                    alert('<fmt:message key="message.delete.success"/>');
                    $("#btnChildCmnt"+crtSeq).find(".btn_cmnt").html(price_format(cnt-1));
                    loadCurateComments(crtSeq, "1");
                }
                ,error: function(data) {
                    alert('<fmt:message key="error.common.system"/>');
                }
            });
        }
    }
}
//-->
</script>
<div id="curateArea" class="curate-area">
    <input type="hidden" name="eof" value="1"/>
    <div class="btn_wrap">
        <!-- 
        <a href="javascript://" onclick="editCurateFrm('${clCriteria.eventId}', '')" class="btn_type05 bg_orange">큐레이트 등록</a>
        -->
    </div>
    <p class="btn_order">
        <a href="#regDtmDesc" id="regDtmDesc" class="order-by active">최신순</a>
        <a href="#likeCntDesc" id="likeCntDesc" class="order-by">좋아요순</a>
    </p>
    <ul id="curateList" class="curate-list"></ul>
    <div id="curateLoading" class="t_center"></div>
</div>
<div id="curateFrm"></div>