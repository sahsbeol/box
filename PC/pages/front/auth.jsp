<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>
인증페이지<br/>
returnUrl=[${auth.returnUrl}]<br/>
skey=[${auth.skey}]<br/>
<br>
<br>
<pre>
${auth}
</pre>
