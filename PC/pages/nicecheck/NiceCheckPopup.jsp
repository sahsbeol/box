<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="nice.nuguya.oivs.jsp" %>

<%
	//========================================================================================
	//=====	▣ 키스트링 80자리 세팅 ▣
	//========================================================================================
	String athKeyStr = "nU19dVp2yUuwLaSZViD0QwI6VSFrKYH1UV8MuOwG6T1wULb1t5hQcKr1kXODhRJQ7x0JUEeCFqYkIs5A";

	OivsObject oivsObject = new OivsObject(athKeyStr);

	String strRecvData 	= request.getParameter( "SendInfo" );

	boolean blProc = oivsObject.resolveClientData( strRecvData );
	
	// 해킹방지를 위해 세션에 저장된 값과 비교 .. 
	String ssOrderNo = session.getAttribute("niceOrderNo") == null ? "" : (String) session.getAttribute("niceOrderNo");
	if(!ssOrderNo.equals(oivsObject.ordNo)){
			out.println("세션정보가 존재하지 않습니다.");
	}
	session.setAttribute("niceOrderNo" , "");

//!!!!!!!!!!!!!!!!!주의!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 
//당사에서 전달하여 복호화된 정보를 
//SSL이나 데이터 보안모듈이 적용되어 있지 않은 환경에서 
//페이지간 전달하는 것은 보안에 심각한 문제를 야기할 수 있습니다. 

//보안 환경이 갖추어지지 않은 업체에서는, 필요한 값을 
//세션 저장등의 다른 수단을 이용하여 사용해 주시기 바랍니다. 
//위 사항을 준수하지 않아서 발생하는 보안사고에 대해서는 
//당사에서 책임을 지지 않사오니, 주의를 기울여 주시기 바랍니다. 

%>

<script language="javascript">
parent.opener.document.location.href="/ht/help/createCounselForm";
self.close();
</script>
 <!--
oivsObject.retCd:<%=oivsObject.retCd%><BR/>
oivsObject.retDtlCd:<%=oivsObject.retDtlCd%><BR/>

<LINK href="./nice.nuguya.oivs.css" type=text/css rel=stylesheet>

   <table width="100%" cellpadding="3" cellspacing="1" bgcolor="#999900">
	<tr><td class="td_left">회원사 아이디</td>
		<td class="td_content"><%=oivsObject.niceId%></td>
	</tr>
	<tr><td class="td_left">주문번호</td>
		<td class="td_content"><%=oivsObject.ordNo + "("+ ssOrderNo +")"%></td>
	</tr>
	<tr><td class="td_left">거래번호</td>
		<td class="td_content"><%=oivsObject.trNo%></td>
	</tr>
	<tr><td class="td_left">응답코드</td>
		<td class="td_content"><%=oivsObject.retCd%></td>
	</tr>
	<tr><td class="td_left">응답상세코드</td>
		<td class="td_content"><%=oivsObject.retDtlCd%></td>
	</tr>
	<tr><td class="td_left">응답메시지</td>
		<td class="td_content"><%=oivsObject.message%></td>
	</tr>
	<tr><td class="td_left">아이핀번호</td>
		<td class="td_content"><%=oivsObject.paKey%></td>
	</tr>
	<tr><td class="td_left">한국신용정보 등록성명</td>
		<td class="td_content"><%=oivsObject.niceNm%></td>
	</tr>
	<tr><td class="td_left">생년월일</td>
		<td class="td_content"><%=oivsObject.birthday%></td>
	</tr>
	<tr><td class="td_left">성별</td>
		<td class="td_content"><%=oivsObject.sex%>(1: 남, 2: 여)</td>
	</tr>
	<tr><td class="td_left">내외국인구분</td>
		<td class="td_content"><%=oivsObject.foreigner%>(1: 내국인, 2: 외국인)</td>
	</tr>
	<tr><td class="td_left" colspan="2">중복가입확인정보</td></tr>
	<tr>
		<td class="td_content" colspan="2"><font style="font-size:10px"><%=oivsObject.dupeInfo%></font> <BR>※ 아이핀번호는 동일인에게 여러 개 부여될 수 있으니 회원정보의 PK는 중복가입확인정보를 이용하여 주시기 바랍니다.</td>
	</tr>
	<tr><td class="td_left" colspan="2">CI정보</td></tr>
	<tr>
		<td class="td_content" colspan="2" style="word-break:break-all;"><font style="font-size:10px"><%=oivsObject.coInfo%></font> </td>
	</tr>
</table> -->

