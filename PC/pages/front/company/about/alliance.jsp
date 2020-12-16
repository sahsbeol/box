<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
</head>
<body>
<div id="container">
<p class="cont_topBg_recruit"><img src="http://image.hottracks.co.kr/info/company/bg_snb_company.png" alt="반갑습니다. 일상을 즐거움으로 채워가는 핫트랙스입니다."/></p>
<c:import url="./layerLnb.jsp"/>
<!-- contents area -->
<div id="contents_area">
    <!-- location -->
    <div id="location">
        <em class="location"><img src="http://image.hottracks.co.kr/info/icon/icon_home.png"  alt="홈"/> &gt; 회사소개 &gt; <strong>제휴안내</strong></em>
        <h2>제휴안내</h2>
    </div>
    <!-- //location -->
    <div class="coopWrap">
        <ul class="coopList">
            <li>
                <p><a href="mailto:kyobo@hottracks.co.kr"><img src="http://image.hottracks.co.kr/info/company/bg_import.png" alt="입점안내:핫트랙스는 새로운 상품 및 브랜드를 환영합니다. 입점을 원하시면 상담해 주시기 바랍니다." /></a></p>
                <p class="txt">
                온라인 : <a title="입점안내 핫트랙스에 메일 보내기" href="mailto:vm0421@hottracks.co.kr">vm0421@hottracks.co.kr</a><br/><br/>
                오프라인 : <a title="입점안내 핫트랙스에 메일 보내기" href="mailto:kyobosale@hottracks.co.kr">kyobosale@hottracks.co.kr</a>
                </p>
            </li>
            <li class="borL">
                <p><a href="mailto:info@hottracks.co.kr"><img src="http://image.hottracks.co.kr/info/company/bg_cooperate.png" alt="제휴안내:핫트랙스와 프로모션 및 이벤트 제휴를 원하시면 이메일로 문의해 주시기 바랍니다." /></a></p>    
                <p class="txt">
                온라인 : <a title="제휴안내 핫트랙스에 메일 보내기" href="mailto:mdyjy@hottracks.co.krc">mdyjy@hottracks.co.kr</a><br/><br/>
                오프라인 : <a title="제휴안내 핫트랙스에 메일 보내기" href="mailto:info@hottracks.co.kr">info@hottracks.co.kr</a>
                </p>
            </li>
        </ul>
    </div>
</div><!-- //contents area -->
</div><!-- //container -->
</body>
</html>