<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<style>
.loginWrap .bnr_login {display:table;width:100%;height: auto;background: #f4f2f5;margin-top:33px;}
.loginWrap .bnr_login a {display: table-cell;vertical-align: middle;width:100%;height:auto;text-align: center;font-size:1.667em;color:#dbdbdb;}
.loginWrap .bnr_login a img {width:100%;height:auto;max-height: inherit;}
</style>
<c:if test="${not empty loginBnrList}">
<a href="${loginBnrList.bnrLinkUrl}" target="_parent">
	<div class="img_wrap">
		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${loginBnrList.imageUrlMo}" onerror="this.src='http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif';">
	</div>
</a>
</c:if>