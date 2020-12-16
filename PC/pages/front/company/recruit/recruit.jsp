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
<p class="cont_topBg_recruit"><img src="/images/company/layout/bg_snb_recruit.png" alt="아름다운핫트랙스 이야기를 함께 만들어갈 인재를 환영합니다."/></p>
<c:import url="./layerLnb.jsp"/>
<!-- contents area -->
<div id="contents_area">
    <!-- location -->
    <div id="location">
        <h2><img src="/images/company/text/txt_recruit.png" alt="모집공고" /></h2>
        <em class="location"><img src="/images/company/icon/icon_home.png"  alt="홈"/> &gt; 인재채용 &gt; 채용정보 &gt; <strong>모집공고</strong></em>
    </div>
    <!-- //location -->  
    <p class="recruit_text">
        <img src="/images/company/text/text_re_02.png" alt="지원하고자 하는 모집공고의 [온라인 입사지원] 버튼을 클릭하신 뒤 입사지원양식을 공란 없이 작성하신 뒤 입사지원하기를 선택하셔야 입사지원이 가능합니다. 모든 입사지원은 당사 양식 및 홈페이지를 통해서만 지원이 가능합니다. (단, 허위사실 기재가 확인될 시에는 입사가 취소됨을 알려드립니다.) 입사지원 시 입력된 개인정보로 합격여부를 확인하실 수 있습니다."/>
        <a href="#none"><img src="/images/company/btn/btn_re.png" alt="상시채용" id="recruit"/></a>
    </p>
    <div class="ListViewWrap">
        <table summary="모집공고 번호,직종,근무지,모집기간,모집인원,양식 및 지원 항목이 있습니다.">
            <caption>모집공고 게시판</caption>
            <colgroup>
                <col width="53px"/>
                <col width="*"/>
                <col width="103px"/>
                <col width="156px"/>
                <col width="83px"/>
                <col width="113px"/>
            </colgroup>
            <thead>
                <tr>
                    <th scope="col" class="first">번호</th>
                    <th scope="col">직종</th>
                    <th scope="col">근무지</th>
                    <th scope="col">모집기간</th>
                    <th>모집인원</th>
                    <th>양식 및 지원</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty recruits}">
                    <tr>
                        <td colspan="6">
                            <b class="re_not_to">진행중인 모집공고가 없습니다.</b>
                            <span>목록 상단의 "상시채용"을 통해 온라인 입사지원을 하시면 업무내용 및 지원자격 확인 후,</span><br/>
                            <span>해당부문 소요 발생 시 우선적으로 검토하여 연락 드립니다.</span>
                        </td>
                    </tr>
                </c:if>
                <c:forEach items="${recruits}" var="recruit" varStatus="status">
                    <tr>
                        <td>${pageHolder.lastIndexNumber - status.count +1}</td>
                        <td class="Tleft"><a href="#none" list="list" recruitSeq="${recruit.recruitSeq}">${recruit.title}</a></td>
                        <td>${recruit.deptName }</td>
                        <td>
                            ${fn:substring(recruit.startDate, 0,4)}/${fn:substring(recruit.startDate, 4,6)}/${fn:substring(recruit.startDate, 6,8)} ~ 
                            ${fn:substring(recruit.endDate, 0,4)}/${fn:substring(recruit.endDate, 4,6)}/${fn:substring(recruit.endDate, 6,8)}
                         </td>
                         <td>${recruit.volume}</td>
                         <td>
                            <c:if test="${nowDate >= recruit.startDate && nowDate <= recruit.endDate}">
                                <a href="#none"><img src="/images/btn/btn_online_re.png" alt="온라인입사지원" apply="apply" recruitSeq="${recruit.recruitSeq}" deptName="${recruit.deptName}"/></a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <!-- paging -->
        <div class="paging"><ui:pagination name="pageHolder" url="/company/recruit/recruit" parameters="dpCd,stus"/></div>
        <!-- //paging -->
    </div>
    <p class="mail_send">
        <em><img src="/images/company/text/text_re_01.png" alt="채용문의"/></em>
        <span class="underline"><a href="mailto:hupsu@hottracks.co.kr" >hupsu@hottracks.co.kr</a></span>
    </p>
</div><!-- //contents area -->
</div><!-- //container -->
</body>
</html>