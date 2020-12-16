<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="popup" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<!-- saved from url=(0035)http://www.hottracks.co.kr/pop.html -->
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
 
<STYLE> 
.style1 {FONT-SIZE: 12px; COLOR: #FFFFFF; LINE-HEIGHT: 14pt; FONT-FAMILY: "돋움", "verdana",; }
</STYLE>
<SCRIPT language=javascript> 
/* 쿠키 설정 */
function setCookie(name, value, expiredays){ 
    // setCookie("CookieName"+GOOD.NOTICEBBS_SEQ, "no" , 1);   // 부모창에서 지정한 쿠키네임과 일치 해야 합니다.
    var todayDate = new Date(); 
    todayDate.setDate( todayDate.getDate() + expiredays ); 
    document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}
 
function controlCookie(){
	setCookie("hottracks${detail.boardseq }", "yes", 1);
	window.close();
}
//-->
 
$(document).ready(function(){
	$('input[name=checkbox]').click(function(){
		 controlCookie();
	});
});
</SCRIPT>
</HEAD>
<BODY>
	<TABLE cellSpacing="0" cellPadding="0" border="0">
		<TBODY>
			<TR>
				<TD align="center" width="500" height="400">
					<a href="${detail.linkurl}" target="_blank"><img src="http://info.hottracks.co.kr/${detail.imgurl }" width="500px" height="400px"/></a>
				</TD>
			</TR>
			<TR>
				<TD align="right" bgColor="#999999" height="24">
					<FONT class="style1">오늘은 이창을 열지 않음</FONT> 
					<input type="checkbox" name="checkbox" />
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</BODY>
</HTML>


