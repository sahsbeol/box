<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<script></script>


<script>
var isMobile = {
        Android: function () {
                 return navigator.userAgent.match(/Android/i) == null ? false : true;
        },
        BlackBerry: function () {
                 return navigator.userAgent.match(/BlackBerry/i) == null ? false : true;
        },
        IOS: function () {
                 return navigator.userAgent.match(/iPhone|iPad|iPod/i) == null ? false : true;
        },
        Opera: function () {
                 return navigator.userAgent.match(/Opera Mini/i) == null ? false : true;
        },
        Windows: function () {
                 return navigator.userAgent.match(/IEMobile/i) == null ? false : true;
        },
        any: function () {
                 return (isMobile.Android() || isMobile.BlackBerry() || isMobile.IOS() || isMobile.Opera() || isMobile.Windows());
        }
};
if(isMobile.any()){
    if(isMobile.Android()){
    	location.href='intent://m.hottracks.co.kr/m/mypage/main#Intent;scheme=http;package=kr.co.hottracks.m.and;end';
    }else if(isMobile.IOS()){
		location.href='hottracks://m.hottracks.co.kr/m/mypage/main';
		
/*     	setTimeout(function() {
    		window.open('http://m.hottracks.co.kr/m/hot/eventDetail?eventId=38190', '_blank') }, 5000); */
		
    }else if(isMobile.BlackBerry()){
        
    }else if(isMobile.Opera()){
        
    }else if(isMobile.Windows()){
        
    }
}
</script>