<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="popup"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">

<head>
<title>Captcha Demo</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript">
jQuery(function($) {
	function ajaxSuccessHandler(result){
		var isSuccess = result.isSuccess;
		if(isSuccess){
			alert("동일한 문자열");
		}else{
			alert("틀린 문자열");
			location.reload();
		}
	}

	function ajaxErrorHandler(){
		alert("시스템에러");
	}

	
	function testStrHandler(){
		var testStr = $("input").val();
		var option = {
			type : 'POST'
			, dataType : 'json'
			, data : {testStr:testStr}
			, url : '/ht/mypage/checkWord'
			, success : ajaxSuccessHandler
			, error : ajaxErrorHandler
		};
		
		$.ajax(option);
		
	}
	function addEvent(){
		$("button").bind("click", testStrHandler);
	}

	addEvent();
});
</script>
</head>
<body> 
	<form>
		<table>
			<tr>
			    <td colspan="2">
			    	<img id="captchaImage" src="/ht/mypage/captchaImage" />
			    </td>
			</tr>
			<tr>
				<td>
				    확인 코드를 적어주세요
				</td>
			</tr>
			<tr>
				<td>
					<input type="text" name="testStr"/>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="button">테스트</button>
				</td>
			</tr>
			<tr>
				<div>변경가능</div><div><span class="Apple-tab-span" style="white-space:pre">	</span>글자</div><div><span class="Apple-tab-span" style="white-space:pre">		</span>색상</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>색상 &nbsp;RGB</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>투명도 A</div><div><span class="Apple-tab-span" style="white-space:pre">		</span>폰트</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>종류 Arial|Monospaced|Serif|SansSerif</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>사이즈 PLAIN|BOLD|ITALIC</div><div><span class="Apple-tab-span" style="white-space:pre">		</span>사이즈</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>최소크기</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>최대크기</div><div><span class="Apple-tab-span" style="white-space:pre">	</span>배경화면</div><div><span class="Apple-tab-span" style="white-space:pre">		</span>색상</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>색상 RGB</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>투명도 A</div><div><span class="Apple-tab-span" style="white-space:pre">		</span>배경크기</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>WIDTH</div><div><span class="Apple-tab-span" style="white-space:pre">			</span>HEIGHT</div><div><span class="Apple-tab-span" style="white-space:pre">	</span>문자열길이</div><div><span class="Apple-tab-span" style="white-space:pre">		</span>최소 문자열 길이</div><div><span class="Apple-tab-span" style="white-space:pre">		</span>최대 문자열 길이</div><div><br></div>
			</tr>
		</table>
	</form>

</body>
</html>