<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<style type="text/css">
.option_box_white {background: white; padding: 10px 0 0; margin: 0;}
.option_box_white p { display: flex; }
.option_box_white p span a { border: 1px solid #ddd; border-radius: 5px; text-align: center; height: 34px; display: block; margin: 2px; line-height: 34px;}
.option_box_white p span a.active {border: 1px solid #fe5f01; background : #fe5f01; color: #fff;}
</style>
<script type="text/javascript">
jQuery(function($){
    $("#wrap").removeClass("mini");
    $("#locStory").addClass("active");
    
    $(window).scroll(function(){  
        if  ($(window).scrollTop() == $(document).height() - $(window).height()){  
            loadEvent();
        }
    });
    
    loadEvent();
    
    $('#subTitle').html('보이는이야기');
});

var page;
var listEvent;
function loadEvent(){
    if(page)   page++;
    else       page = 1;
    /*
    if(history.pushState){
        var state = { page: page };
        var title = "보이는이야기 - NEW ME HOTTRACKS";
        var url = location.href.split("#")[0];
        history.pushState(state, title, url);
    }
    */
    if($("[name=eof]").val() == "0"){
        $("input[name=eof]").val("1");
        
        $.ajax({
            type: "GET"
            ,url: "/m/hot/storyMore"
            ,data: {page:page}
            ,dataType: "json"
            ,success: function(data) {
                if(data && data.list && data.list.length > 0){
                    listEvent = data.list;
                    
                    _createEventList();
                    
                    $("input[name=eof]").val("0");
                }
            }
            ,error: function() {
                alert('<fmt:message key="error.common.system"/>');
            }
        });
    }
}

function _createEventList(){
    var obj = document.getElementById("lyEventList");
    // while(obj.firstChild)    obj.removeChild(obj.firstChild);
    
    if(listEvent && listEvent.length > 0){
        for(var i = 0; i < listEvent.length; i++){
            obj.appendChild(_createEventThumb("li", listEvent[i], "/m/hot/story?eventId="+listEvent[i].eventId));
        }
    }
}

function _createEventThumb(tagName, event, linkUrl){
    var obj = document.createElement(tagName);
    
    var anchor = document.createElement("a");
    anchor.href = linkUrl;
    anchor.classList.add("full");
    anchor.classList.add("js-pjax");
    
    var p1 = document.createElement("p");
    p1.classList.add("pic_full");
    var img = document.createElement("img");
    img.src = "http://image.kyobobook.co.kr/newimages/giftshop_new/work/" + event.imageUrl;
    p1.appendChild(img);
    anchor.appendChild(p1);
    obj.appendChild(anchor);
    
    var p2 = document.createElement("p");
    p2.classList.add("tit");
    p2.classList.add("t_l");
    var strong = document.createElement("strong");
    strong.appendChild(document.createTextNode(event.eventTitle));
    p2.appendChild(strong);
    anchor.appendChild(p2);
    obj.appendChild(anchor);
    
    if(event.eventDtlCont){
        var p3 = document.createElement("p");
        p3.classList.add("txt");
        p3.classList.add("t_l");
        p3.appendChild(document.createTextNode(event.eventDtlCont));
        anchor.appendChild(p3);
    }
    
    obj.appendChild(anchor);
    
    return obj;
}
</script>
</head>
<body>
<input type="hidden" name="eof" value="0"/>
<!-- prod -->
<div class="banner_basic02" id="pjax-container">
    <ul id="lyEventList">
        <c:forEach items="${list}" var="l" varStatus="st">
            <li>
                <a href="/m/biz/eventDetail?eventId=${l.eventId}" class="full js-pjax" title="${l.eventTitle}">
                    <p class="pic_full"><ui:image src="${l.imageUrl}" alt="${l.eventTitle}" /></p>
                    <p class="tit t_l"><strong>${fn:escapeXml(l.eventTitle)}</strong></p>
                    <p class="txt t_l">${fn:escapeXml(l.eventDtlCont)}</p>
                </a>
            </li>
        </c:forEach>
    </ul>
</div>
<!-- //prod -->
</body>
</html>