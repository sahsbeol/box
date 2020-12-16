<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>
<c:if test="${not empty listGnb01 && param.ssl ne 'Y'}">
<c:forEach items="${listGnb01}" var="l" end="0">
    <div class="gnb-wide-bnr" style="height:100px;">
        <p class="img">
            <ui:banner clazz="PC_TOP" bnrLinkUrl="${l.bnrLnkUrl}" bannerImageUrl="${l.bnrImgUrl}" bnrTgtGbn="L" bnrSeq="${l.bnrSeq}" newWdwYn="${l.bnrNewWinYn}"/>
        </p>
        <a href="javascript://" class="close"">닫기</a>
    </div>
</c:forEach>
</c:if>
<!-- Top_util -->
<div id="top_util">
    <div class="inner">
        <!-- 로그인 정보 -->
        <ul class="top_info">
            <!-- 로그인안된경우 -->
            <li class="gnbLogoutStat" style="display:none;">
                <c:choose>
                    <c:when test="${not empty loginOrderNum}"><a href="${defaultHost}/ht/user/logout"><span>로그아웃</span></a></c:when>
                    <c:otherwise>
                        <a href="javascript://" onclick="login()"><span>로그인</span></a>
                        /
                        <a href="javascript://" onclick="goMemJoin()" style="margin-left:3px;"><span>회원가입</span></a>
                    </c:otherwise>
                </c:choose>
            </li>
            <!-- 로그인안된경우 -->
            <!-- 로그인된경우 -->
            <li class="gnbLoginStat" style="display:none;"><a href="javascript://" onclick="goModifyMemInfo()"><span class="c_orange">${loginUser.name}</span>(<ui:userGrade gradeId="${loginUser.gradeId}"/>) 님</a></li>
            <!-- 로그인된경우 -->
            <li class="gnbMypageBtn">
                <a href="${defaultHost}/ht/mypage/mypageMain" class="bold"><span class="arrow">마이룸</span></a>
                <div class="inner">
                    <p><a href="${defaultHost}/ht/mypage/mypageMain"><span class="arrow">마이룸</span></a></p>
                    <ul>
                        <li><a href="${defaultHost}/ht/mypage/listWishProduct">좋아요♥</a></li>
                        <li><a href="${defaultHost}/ht/mypage/orderDelivery" class="c_orange">주문/배송</a></li>
                        <li><a href="${defaultHost}/ht/mypage/orderChange">취소/변경</a></li>
                        <li><a href="${defaultHost}/ht/mypage/listSosCounsel">SOS상담</a></li>
                        <li><a href="javascript://" onclick="goModifyMemInfo()">개인정보수정</a></li>
                        <li><a href="${defaultHost}/ht/user/logout">로그아웃</a></li>
                    </ul>
                </div>
            </li>
            <li><a href="${defaultHost}/ht/order/cart"><span>장바구니 <strong class="point01 cartCount">(0)</strong></span></a></li>
            <li><a href="${defaultHost}/ht/help/helpMain"><span>고객센터</span></a></li>
            <li><a href="${defaultHost}/company/main/" class="PC_OFFLINE"><span>영업점</span></a></li>
            <li><a href="${defaultHost}/company/story/sign" class="PC_SIGN"><span>사인회</span></a></li>
            <li><a href="http://info.hottracks.co.kr/company/recruit/notice" target="_blank"><span>채용정보</span></a></li>
        </ul>
        <!-- //로그인 정보 -->
    </div>
</div>
<!-- //Top_util -->

<!-- Header -->
<div id="haeder_wrap" class="${param.gnbType}"><!-- 상단광고영역 있을 시 class main 추가 -->
    <div class="inner">
        <h1 class="logo"><a href="${defaultHost}/ht/welcomeMain" class="PC_TOP_HOT"><span>NEW ME HOTTRACKS</span></a></h1>
        
        <!-- top_search -->
        <div class="top_search">
            <ul class="search_link">
                <li class="c1"><a href="${defaultHost}/ht/welcome/hotEventMain" id="PC_TOP_1"><span>EVENT</span></a></li>
                <li class="c3"><a href="${defaultHost}/ht/welcome/hotAwardPage?dispMstrId=CATE_GFT_SALE" id="PC_TOP_3"><span>SALE</span></a></li>
                <li class="c4"><a href="${defaultHost}/ht/welcome/hotAwardPage?dispMstrId=CATE_GFT_BEST" id="PC_TOP_4"><span>BEST</span></a></li>
                <li class="c5"><a href="${defaultHost}/ht/welcome/hotAwardRecentPage" id="PC_TOP_5"><span>NEW</span></a></li>
                <li class="c6"><a href="${defaultHost}/ht/biz/eventDetail?eventId=47389" id="PC_TOP_6"><span>SOHOT</span></a></li>
                 
            </ul>
            <div class="search_box">
                <c:if test="${not empty listTrendKeyword}">
                    <c:if test="${listTrendKeyword[0].prevRank eq 1}"><c:set var="krywordsUrl" value="/e/${listTrendKeyword[0].requested}"/></c:if>
                    <c:if test="${listTrendKeyword[0].prevRank eq 2}"><c:set var="krywordsUrl" value="/p/${listTrendKeyword[0].requested}"/></c:if>
                    <c:if test="${listTrendKeyword[0].prevRank eq 3}"><c:set var="krywordsUrl" value="/b/${listTrendKeyword[0].requested}"/></c:if>
                    <c:set var="keywords" value="${listTrendKeyword[0].keyword}"/>
                </c:if>
                <form name="gnbSearchForm" action="/ht/search/searchMain" method="post" onsubmit="return false;">
                    <input type="hidden" name="viewType"/>
                    <input type="hidden" name="searchMenu"/>
                    <input type="hidden" name="exLink" value="${krywordsUrl}"/>
                    <input type="hidden" name="exTxt" value="${keywords}"/>
                    <div id="gnbSearchMenu" class="search_menu">
                        <ul>
                            <li><a href="#" onclick="clickGnbSrchMenu('GIFT');return false;" title="검색조건을 기프트으로 선택">기프트</a></li>
                            <li><a href="#" onclick="clickGnbSrchMenu('RECORD');return false;" title="검색조건을 음반/영상으로 선택">음반/영상</a></li>
                        </ul>
                    </div>
                    <input type="text" name="searchTerm" value="${keywords}" class="search_keyword" title="검색어 키워드" autocomplete="off" style="ime-mode:active;" />
                    <a href="#" class="search_btn" onclick="gnbSrchFrm();return false;"><span>검색</span></a>
                </form>
            </div>
        </div>
        <!-- //top_search -->
        
        <c:if test="${param.ssl ne 'Y'}">
            <!-- Ad_pot -->
            <c:forEach items="${listGnb02}" var="l" end="0">
                <div class="ad_pot">
                    <ui:banner bnrLinkUrl="${l.bnrLnkUrl}" bannerImageUrl="${l.bnrImgUrl}" bnrTgtGbn="L" bnrSeq="${l.bnrSeq}" newWdwYn="${l.bnrNewWinYn}" alt="${l.bnrImgAlt}" clazz="PC_TOP_IMG"/>
                </div>
            </c:forEach>
            <!-- //Ad_pot -->
        </c:if>
    </div>
</div>
<!--//Header -->

<div id="haeder_sub_wrap">
    <div class="inner">
        <ul class="header_banner">
            <c:forEach items="${listGnb03}" var="l" varStatus="st">
                <li><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank" </c:if> id="PC_GBN_${st.count }" >${l.bnrTitle}</a></li>
            </c:forEach>
        </ul>
        <div class="keyword_area">
            <p id="keywordTxt" style="height: 17px;overflow:hidden;"></p>
            <div class="keyword_list">
                <p>인기 검색어 TOP 10</p>
                <ul>
                    <c:forEach items="${listBestKeyword}" var="l" varStatus="st">
                        <li<c:if test="${st.last}"> class="last on"</c:if>><a href="#"><span class="best">${st.count}</span>
                        	<span class="keyword">
                        		${l.keyword}
                        		<%-- <c:choose>
		                        	<c:when test="${l.prevRank == 0}">
		                        		new
		                        	</c:when>
		                        	<c:otherwise>
		                        		${l.prevRank - l.ranking}
		                        	</c:otherwise>
		                        </c:choose> --%>
                        	</span></a><em class="best_arrow<c:if test="${l.prevRank > l.ranking || l.prevRank eq 0}"> up</c:if><c:if test="${l.prevRank < l.ranking && l.prevRank ne 0}"> down</c:if>"><span>ARROW</span></em></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Gnb -->
<div id="gnb">
    <ul class="depth01"><!-- 활성화 메뉴에 클래스 on 추가 -->
        <li><a href="#catelist01" onclick="location.href='${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000020'" class="PC_CATE_1"><span class="PC_CATE_1">디자인문구</span></a></li>
        <li><a href="#catelist02" onclick="location.href='${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000022'" class="PC_CATE_5"><span class="PC_CATE_5">디지털</span></a></li>
        <li><a href="#catelist03" onclick="location.href='${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000007'" class="PC_CATE_2"><span class="PC_CATE_2">고급필기구</span></a></li>
        <%-- <li><a href="#catelist16" onclick="location.href='${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000018'" class="PC_CATE_3"><span class="PC_CATE_3">화방</span></a></li> --%>
        <li><a href="#catelist04" onclick="location.href='${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000021'" class="PC_CATE_4"><span class="PC_CATE_4">오피스</span></a></li>
        <li><a href="#catelist05" onclick="location.href='${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000025'" class="PC_CATE_8"><span class="PC_CATE_8">리빙/생활가전</span></a></li>
        <li><a href="#catelist06" onclick="location.href='${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000026'" class="PC_CATE_9"><span class="PC_CATE_9">키친/푸드</span></a></li>
        <li><a href="#catelist07" onclick="location.href='${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000024'" class="PC_CATE_7"><span class="PC_CATE_7">가구/수납</span></a></li>
        <li><a href="#catelist08" onclick="location.href='${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000028'" class="PC_CATE_11"><span class="PC_CATE_11">패션잡화</span></a></li>
        <li><a href="#catelist09" onclick="location.href='${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000006'" class="PC_CATE_12"><span class="PC_CATE_12">뷰티/헬스</span></a></li>
        <li><a href="#catelist10" onclick="location.href='${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000027'" class="PC_CATE_10"><span class="PC_CATE_10">여행/자동차</span></a></li>
        <li><a href="#catelist11" onclick="location.href='${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000023'" class="PC_CATE_6"><span class="PC_CATE_6">취미/펫</span></a></li>
        <li><a href="#catelist12" onclick="location.href='${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000029'" class="PC_CATE_13"><span class="PC_CATE_13">유아동</span></a></li>
        <li><a href="#catelist13" onclick="location.href='${defaultHost}/ht/recordMain'" class="PC_CATE_14"><span class="PC_CATE_14">CD</span></a></li>
        <li><a href="#catelist14" onclick="location.href='${defaultHost}/ht/dvdMain'" class="PC_CATE_15"><span class="PC_CATE_15">DVD</span></a></li>
    </ul>
    <!-- 디자인문구 -->
    <div id="catelist01" class="depth02">
    <div class="inner">
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002003"><span>필기구</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200301"><span>볼펜</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200305"><span>색연필</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200303"><span>중성펜/젤펜</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200304"><span>샤프/홀더</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200302"><span>수성펜</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200312"><span>유성펜</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200306"><span>형광펜</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200300"><span>연필</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200307"><span>멀티펜</span></a></dd>
                <!-- dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200309"><span>리필심</span></a></dd -->
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002000"><span>다이어리 / 스케줄러</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200011"><span>날짜형 다이어리</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200000"><span>만년 다이어리</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200002"><span>위클리 스케줄러</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200003"><span>먼슬리 스케줄러</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200009"><span>스터디플래너</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200014"><span>프로젝트 플래너</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200013"><span>캐쉬북</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200008"><span>커버/액세서리</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002006"><span>필통 / 파우치</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200600"><span>패브릭필통</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200601"><span>가죽/합성피혁 필통</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200602"><span>철제필통</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200604"><span>플라스틱 필통</span></a></dd>
            </dl>
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002004"><span>비즈니스플래너 / 노트</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200400"><span>몰스킨</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200401"><span>프랭클린플래너</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200402"><span>오롬시스템</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200403"><span>미도리</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000201800"><span>스케치/드로잉</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=000020180003"><span>멀티라이너</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=000020180006"><span>색연필</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=000020180005"><span>파스텔/오일파슬텔</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=000020180004"><span>스케치북/드로잉북</span></a></dd>
            </dl>
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000201801"><span>수채화</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=000020180102"><span>고체형 수채물감</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=000020180103"><span>수채화붓</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=000020180104"><span>보조용품</span></a></dd>
                <!-- dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000200905"><span>포토박스</span></a></dd -->
                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000020"><span class="c_orange">카테고리 더보기 +</span></a></dt>
            </dl>
        </div>
        <div class="depth_banner">
            <dl>
                <c:forEach items="${listGnb000020}" var="l" end="0">
                    <dt><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span>${l.bnrTitle}</span></a></dt>
                    <dd><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}" ssl="${param.ssl}"/></span></a></dd>
                </c:forEach>
            </dl>
        </div>
    </div>
    </div>
    <!-- // 디자인문구 -->
    <!-- 고급필기구 -->
    <div id="catelist03" class="depth02">
    <div class="inner">
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00000720"><span>만년필</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000072014"><span>입문용 만년필</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000072015"><span>스테디셀러 만년필</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000072017"><span>선물용 만년필(10만원 이하)</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000072016"><span>선물용 만년필 (10만원 이상)</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000072000"><span>몽블랑</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000072003"><span>라미</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000072001"><span>피카</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000072005"><span>파버카스텔</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000072010"><span>세일러</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000072008"><span>카웨코</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00000719"><span>볼펜</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000071912"><span>스테디셀러 볼펜</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000071919"><span>선물용 볼펜 (10만원 이하)</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000071920"><span>선물용 볼펜 (10만원 이상)</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000071900"><span>몽블랑</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000071903"><span>라미</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000071901"><span>파카</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000071905"><span>파버카스텔</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000071908"><span>크로스</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000071907"><span>쉐퍼</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000071906"><span>카웨코</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00000703"><span>만년필전용노트</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000070301"><span>라이프</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000070305"><span>츠바메노트</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000070300"><span>로이텀</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000070302"><span>미도리</span></a></dd>
            </dl>
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00000706"><span>펜파우치</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000070600"><span>1구 파우치</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000070601"><span>2~3구 파우치</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000070602"><span>가죽필통</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000070604"><span>패브릭필통</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00000722"><span>캘리그래피</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000072205"><span>캘리그래피 세트</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000072206"><span>캘리그래피 만년필</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000072200"><span>캘리그래피 펜촉</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000072201"><span>캘리그래피 펜대</span></a></dd>
            </dl>
            <dl>
                <dt><a href="#"><span>관련카테고리</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00000702"><span>잉크/카트리지/컨버터</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00000700"><span>연필/샤프</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00000704"><span>만년필 액세서리</span></a></dd>
                <!-- dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000070200"><span>브랜드별 병잉크</span></a></dd -->
                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000007"><span class="c_orange">카테고리 더보기 +</span></a></dt>
            </dl>
        </div>
        <div class="depth_banner">
            <dl>
                <c:forEach items="${listGnb000007}" var="l" end="0">
                    <dt><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span>${l.bnrTitle}</span></a></dt>
                    <dd><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}" ssl="${param.ssl}"/></span></a></dd>
                </c:forEach>
            </dl>
        </div>
    </div>
    </div>
    <!-- // 고급필기구 -->
    <!-- 화방 -->
    <%-- <div id="catelist16" class="depth02">
    <div class="inner">
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00001817"><span>스케치/드로잉</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181700"><span>미술연필</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181710"><span>홀더/샤프</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181701"><span>색연필</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181702"><span>멀티라이너</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181703"><span>지우개</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181709"><span>연필깎이</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181707"><span>스케치북/드로잉북</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181704"><span>보조용품</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181705"><span>파스텔/오일파스텔</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181706"><span>콘테/목탄</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00001818"><span>수채화</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181800"><span>수채화물감(국산)</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181801"><span>수채화물감(수입)</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181802"><span>고체형 수채물감</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181803"><span>수채화붓</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181804"><span>보조용품</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181805"><span>물통/팔레트</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181806"><span>스케치북/수채화지</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00001823"><span>아크릴</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000182300"><span>아크릴물감(국산)</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000182301"><span>아크릴물감(수입)</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000182304"><span>아크릴붓</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000182306"><span>캔버스/아크릴전용지</span></a></dd>
            </dl>
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00001815"><span>유화</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181500"><span>유화물감(국산)</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181501"><span>유화물감(수입)</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181502"><span>유화붓/나이프</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000181505"><span>캔버스</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00001820"><span>서예용품</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000182000"><span>먹/벼루</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000182001"><span>화선지/작품지</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000182003"><span>서예붓/학생용</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000182004"><span>서예붓/전문가용</span></a></dd>
            </dl>
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00001822"><span>미술보조용품</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000182200"><span>이젤</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000182202"><span>화판</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000182203"><span>아트백/포트폴리오</span></a></dd>
                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000018"><span class="c_orange">카테고리 더보기 +</span></a></dt>
            </dl>
        </div>
        <div class="depth_banner">
            <dl>
                <c:forEach items="${listGnb000018}" var="l" end="0">
                    <dt><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span>${l.bnrTitle}</span></a></dt>
                    <dd><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}" ssl="${param.ssl}"/></span></a></dd>
                </c:forEach>
            </dl>
        </div>
    </div>
    </div> --%>
    <!-- // 화방 -->
    <!-- 오피스 -->
    <div id="catelist04" class="depth02">
    <div class="inner">
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002100"><span>DESK 용품 / 정리.보관</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210001"><span>스톱워치</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002110"><span>데스트매트</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210002"><span>데스크 정리용품</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210004"><span>케이블 정리용품</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210011"><span>데스크용 책꽂이</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210007"><span>메모판/모니터 메모보드</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002102"><span>사무용품</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210200"><span>3M</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210202"><span>스테플러</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210206"><span>수정테이프/수정액</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210207"><span>클립/집게/핀</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210208"><span>테이프/테이프디스펜서</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210204"><span>칼/가위/커터</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210205"><span>풀/접착제</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210215"><span>자/줄자</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000211202"><span>명함첩</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210216"><span>POP/아크릴케이스</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002101"><span>파일/바인더</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210100"><span>클리어화일</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210101"><span>바인더</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210114"><span>클립파일</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210102"><span>클립보드</span></a></dd>
            </dl>
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002105"><span>독서용품</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210500"><span>독서대</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210504"><span>북라이트</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210502"><span>북마크/책갈피</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210507"><span>발받침대</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002103"><span>잉크/토너</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210300"><span>잉크 카트리지</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210301"><span>토너 카트리지</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210302"><span>재생잉크/토너</span></a></dd>
            </dl>
            <dl>
                <dt><a href="#"><span>관련카테고리</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002104"><span>복사용지/지류</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002113"><span>라벨 전용지</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002106"><span>프린터/사무기기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000210602"><span>세단기</span></a></dd>
                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000021"><span class="c_orange">카테고리 더보기 +</span></a></dt>
            </dl>
        </div>
        <div class="depth_banner">
            <dl>
                <c:forEach items="${listGnb000021}" var="l" end="0">
                    <dt><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span>${l.bnrTitle}</span></a></dt>
                    <dd><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}" ssl="${param.ssl}"/></span></a></dd>
                </c:forEach>
            </dl>
        </div>
    </div>
    </div>
    <!-- // 오피스 -->
    <!-- 디지털 -->
    <div id="catelist02" class="depth02">
    <div class="inner">
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002200"><span>애플케이스/ 필름</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220018"><span>아이폰XR</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220019"><span>아이폰XS</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220020"><span>아이폰XS MAX</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220017"><span>아이폰X</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220015"><span>아이폰8</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220016"><span>아이폰8+</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220013"><span>아이폰7</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220014"><span>아이폰7+</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220007"><span>아이폰6/6S</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002201"><span>갤럭시케이스/ 필름</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220126"><span>갤럭시S10</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220127"><span>갤럭시S10+</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220125"><span>갤럭시 노트9</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220123"><span>갤럭시S9</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220124"><span>갤럭시S9+</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220121"><span>갤럭시S8/S8+</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220122"><span>갤럭시 노트8</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220118"><span>갤럭시S7</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220119"><span>갤럭시S7 엣지</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002203"><span>스마트폰/태블릿주변기기</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220300"><span>애플전용ACC</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220320"><span>짐벌</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220318"><span>무선충전기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220301"><span>보조배터리</span></a></dd>
            </dl>
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002212"><span>블루투스/이어폰/헤드폰</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000221202"><span>블루투스 스피커</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000221201"><span>블루투스 이어폰</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000221207"><span>밀형 헤드폰</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000221209"><span>커널형 이어폰</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002211"><span>USB 소형가전/ 계절상품</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000221100"><span>USB 선풍기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000221101"><span>USB 공기청정기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000221104"><span>USB 가습기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000221103"><span>기타</span></a></dd>
            </dl>
            <dl>
                <dt><a href="#"><span>관련카테고리</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000220817"><span>게임기/타이틀</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002205"><span>노트북가방/ 파우치</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002204"><span>웨어러블/디지털기기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002208"><span>PC/노트북 주변기기</span></a></dd>
                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000022"><span class="c_orange">카테고리 더보기 +</span></a></dt>
            </dl>
        </div>
        <div class="depth_banner">
            <dl>
                <c:forEach items="${listGnb000022}" var="l" end="0">
                    <dt><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span>${l.bnrTitle}</span></a></dt>
                    <dd><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}" ssl="${param.ssl}"/></span></a></dd>
                </c:forEach>
            </dl>
        </div>
    </div>
    </div>
    <!-- // 디지털 -->
    <!-- 취미펫 -->
    <div id="catelist11" class="depth02">
    <div class="inner">
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002319"><span>조립/퍼즐</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000231902"><span>레고</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000231903"><span>나노블럭</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000231906"><span>우드조립</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000231901"><span>3D입체퍼즐</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000231907"><span>3D입체조립</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000231912"><span>크래프트/공예</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000231900"><span>페이퍼토이/종이접기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000231905"><span>직소/판퍼즐</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000231909"><span>캐스트퍼즐</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000231911"><span>프라모델</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002320"><span>R/C토이</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000232004"><span>R/C 드론/쿼드콥터</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000232006"><span>R/C 헬기/비행기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000232003"><span>R/C 카</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000232005"><span>R/C 로봇/장비</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000232000"><span>R/C 블루투스/와이파이</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000232001"><span>R/C 트럭/중장비</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000232007"><span>R/C 탱크/궤도차량</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000232002"><span>R/C 요트/보트</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002327"><span>DIY 취미</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000232700"><span>패브릭 DIY</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000232701"><span>패션잡화 DIY</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000232702"><span>리빙 DIY</span></a></dd>
            </dl>
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002326"><span>아트/컬러링</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000232600"><span>컬러링</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000232601"><span>명화그리기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000232602"><span>피포페인팅</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000232603"><span>스크래치</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000232604"><span>취미미술</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002301"><span>PET 용품</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000230100"><span>외출용품</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000230101"><span>목욕용품</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000230102"><span>배변용품</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000230103"><span>훈련용품</span></a></dd>
            </dl>
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002302"><span>PET 하우스</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000230202"><span>하우스</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000230205"><span>방석/쿠션</span></a></dd> 
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000230210"><span>매트</span></a></dd>
                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000023"><span class="c_orange">카테고리 더보기 +</span></a></dt>
            </dl>
        </div>
        <div class="depth_banner">
            <dl>
                <c:forEach items="${listGnb000023}" var="l" end="0">
                    <dt><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span>${l.bnrTitle}</span></a></dt>
                    <dd><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}" ssl="${param.ssl}"/></span></a></dd>
                </c:forEach>
            </dl>
        </div>
    </div>
    </div>
    <!-- //취미펫-->
    <!-- 가구/수납 -->
    <div id="catelist07" class="depth02">
    <div class="inner">
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002406"><span>수납/정리</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240604"><span>아이템수납</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240616"><span>바구니/박스</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240600"><span>리빙박스</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240614"><span>CD/DVD꽂이</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240615"><span>화장품 정리/보관</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240612"><span>옷장정리</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240611"><span>이불 수납</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240607"><span>키친수납</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240608"><span>키즈 수납</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240609"><span>기타 수납</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002400"><span>홈오피스 가구</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240000"><span>책장</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240001"><span>책상</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240006"><span>책상세트</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240008"><span>독서실책상</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240002"><span>컴퓨터책상</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240003"><span>쥬니어책상</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240007"><span>책상악세사리</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240005"><span>오피스 서랍장</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240004"><span>오피스 의자</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240009"><span>캐비닛</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002405"><span>옷장/행거</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240500"><span>옷장</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240502"><span>파티션</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240503"><span>행거</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240504"><span>드레스룸</span></a></dd>
            </dl>
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002410"><span>테이블</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000241001"><span>미니/노트북테이블</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000241002"><span>거실테이블</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000241003"><span>좌식테이블</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000241004"><span>사이드테이블/협탁</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002408"><span>서랍장/수납장</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240800"><span>벽선반</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240801"><span>선반장</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240802"><span>서랍장</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000240803"><span>다용도서랍장</span></a></dd>
            </dl>
            <dl>
                <dt><a href="#"><span>관련카테고리</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002407"><span>화장대</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002404"><span>침대</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002409"><span>식탁</span></a></dd>
                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000024"><span class="c_orange">카테고리 더보기 +</span></a></dt>
            </dl>
        </div>
        <div class="depth_banner">
            <dl>
                <c:forEach items="${listGnb000024}" var="l" end="0">
                    <dt><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span>${l.bnrTitle}</span></a></dt>
                    <dd><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}" ssl="${param.ssl}"/></span></a></dd>
                </c:forEach>
            </dl>
        </div>
    </div>
    </div>
    <!-- // 가구 -->
    <!-- 리빙/생활가전 -->
    <div id="catelist05" class="depth02">
    <div class="inner">
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002501"><span>데코/소품</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250100"><span>시계</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250101"><span>조화/가드닝</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250102"><span>액자/홈갤러리</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250103"><span>캔들</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250104"><span>디퓨져/홈퍼퓸</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250105"><span>장식소품</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250106"><span>생활소품</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250107"><span>월데코스티커</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250111"><span>아이템정리</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002500"><span>조명</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250000"><span>테이블조명</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250001"><span>워크램프/스탠드조명</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250002"><span>집게등</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250003"><span>플로어조명</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250004"><span>팬던트조명</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250005"><span>천장조명</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250006"><span>레일조명</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250008"><span>벽등/벽조명</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250010"><span>이니셜/메세지조명</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250011"><span>유니크/무드등</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002509"><span>생활가전</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250900"><span>공기청정기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250901"><span>청소기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250902"><span>다리미</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250903"><span>기타가전</span></a></dd>
            </dl>
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002508"><span>주방가전</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250800"><span>믹서기/블렌더</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250801"><span>전기주전자</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250802"><span>커피메이커</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000250803"><span>토스터/오븐</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002510"><span>시즌가전</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000251000"><span>선풍기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000251001"><span>써큘레이터</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000251002"><span>제습기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000251100"><span>가습기</span></a></dd>
            </dl>
            <dl>
                <dt><a href="#"><span>관련카테고리</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002505"><span>패브릭</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002502"><span>침구</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002504"><span>플라워/가든</span></a></dd>
                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000025"><span class="c_orange">카테고리 더보기 +</span></a></dt>
            </dl>
        </div>
        <div class="depth_banner">
            <dl>
                <c:forEach items="${listGnb000025}" var="l" end="0">
                    <dt><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span>${l.bnrTitle}</span></a></dt>
                    <dd><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}" ssl="${param.ssl}"/></span></a></dd>
                </c:forEach>
            </dl>
        </div>
    </div>
    </div>
    <!-- // 리빙생활가전 -->
    <!-- 키친/푸드 -->
    <div id="catelist06" class="depth02">
    <div class="inner">
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002601"><span>컵/커피잔/티팟</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260100"><span>텀블러 스테인리스 </span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260101"><span>텀블러 플라스틱</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260102"><span>보틀</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260103"><span>보온보냉병</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260104"><span>머그/컵/물병</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260105"><span>유리컵</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260106"><span>맥주컵/소주잔</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260107"><span>술잔/주병</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260109"><span>무지머그</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260108"><span>아티스트머그</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002600"><span>식기/홈세트</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260000"><span>집시/찬기(단품)</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260001"><span>접시/찬기(2P이상)</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260002"><span>공기/대접</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260003"><span>면기/그라탕기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260004"><span>샐러드볼/다용도볼</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260005"><span>종지/소스볼</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260006"><span>반상기/홈세트</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260007"><span>식판/나눔접시</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260008"><span>수저/포크/나이프</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260009"><span>커트러리세트</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002603"><span>보관/밀폐용기</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260300"><span>수저통</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260301"><span>찬통(도자기/유리용기)</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260302"><span>찬통(플라스틱/기타재질)</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260303"><span>양념통/오일병</span></a></dd>
            </dl>
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002604"><span>조리도구</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260400"><span>도마</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260401"><span>키친툴세트</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260402"><span>칼/가위/칼갈이</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260403"><span>주걱/뒤집개/국자</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002609"><span>푸드</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260900"><span>냉장/냉동조리식품</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260906"><span>초콜릿</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260902"><span>간식/음료</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000260903"><span>견과류/건어물/과일칩</span></a></dd>
            </dl>
            <dl>
                <dt><a href="#"><span>관련카테고리</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002612"><span>초콜릿/홈베이킹 DIY</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002607"><span>주방 정리</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002608"><span>주방 패브릭</span></a></dd>
                <!-- dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002612"><span>홈베이킹/DIY</span></a></dd -->
                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000026"><span class="c_orange">카테고리 더보기 +</span></a></dt>
            </dl>
        </div>
        <div class="depth_banner">
            <dl>
                <c:forEach items="${listGnb000026}" var="l" end="0">
                    <dt><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span>${l.bnrTitle}</span></a></dt>
                    <dd><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}" ssl="${param.ssl}"/></span></a></dd>
                </c:forEach>
            </dl>
        </div>
    </div>
    </div>
    <!-- // 키친/푸드 -->
    <!-- 여행/자동차 -->
    <div id="catelist10" class="depth02">
    <div class="inner">
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002712"><span>캐리어/여행백</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000271200"><span>기내형</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000271201"><span>중형</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000271202"><span>대형</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000271203"><span>뷰티케이스</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000271204"><span>보스턴백/토트백</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000271205"><span>보조백/크로스백</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000271206"><span>배낭</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002704"><span>자동차용품</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000270400"><span>주차번호판</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000270401"><span>방향제/공기청정기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000270402"><span>자동차키홀더</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000270410"><span>자동차데코스티커</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000270407"><span>카테리어</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000270406"><span>수납/정리</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000270403"><span>핸들/스틱커버</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000270405"><span>룸미러</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000270404"><span>자동차시트/쿠션/매트</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000270411"><span>데코/도어가드</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002701"><span>여행수납</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000270106"><span>수납용품세트</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000270107"><span>의류정리팩</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000270108"><span>트래블파우치</span></a></dd>
            </dl>
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002713"><span>여행소품/편의용품</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000271300"><span>지도</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000271301"><span>여권커버</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000271303"><span>캐리어커버/스티커</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000271304"><span>네임택</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002714"><span>아웃도어</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000271405"><span>핫팩/쿨팩</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000271400"><span>배낭/힙색</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000271401"><span>모자/잡화</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000271403"><span>모기퇴치기</span></a></dd>
            </dl>
            <dl>
                <dt><a href="#"><span>관련카테고리</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002702"><span>캠핑</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002707"><span>자전거</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002715"><span>레저/스포츠</span></a></dd>
                <!-- dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002716"><span>서핑/수영</span></a></dd -->
                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000027"><span class="c_orange">카테고리 더보기 +</span></a></dt>
            </dl>
        </div>
        <div class="depth_banner">
            <dl>
                <c:forEach items="${listGnb000027}" var="l" end="0">
                    <dt><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span>${l.bnrTitle}</span></a></dt>
                    <dd><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}" ssl="${param.ssl}"/></span></a></dd>
                </c:forEach>
            </dl>
        </div>
    </div>
    </div>
    <!-- // 여행/자동차 -->
    <!-- 패션잡화 -->
    <div id="catelist08" class="depth02">
    <div class="inner">
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002801"><span>가방</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000280100"><span>백팩</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000280104"><span>에코백</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000280102"><span>숄더백</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000280101"><span>크로스백</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000280103"><span>토트백</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000280108"><span>브리프케이스</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000280111"><span>웨이스트백&힙색</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002815"><span>여성 패션소품</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000281500"><span>아이웨어</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=000028150500"><span>뱃지/키링</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000281502"><span>손수건</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000281504"><span>헤어악세서리</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000281503"><span>패션가발</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000281505"><span>기타패션소품</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002805"><span>우산/양산</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000280507"><span>양산</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000280500"><span>자동장우산</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000280501"><span>자동3단우산</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000280504"><span>수동3단우산</span></a></dd>
            </dl>
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002812"><span>지갑/파우치</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000281200"><span>파우치</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000281201"><span>지갑</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="#"><span>관련카테고리</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002817"><span>양말</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002803"><span>주얼리</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002813"><span>손목시계</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002814"><span>목도리/장갑</span></a></dd>
                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000028"><span class="c_orange">카테고리 더보기 +</span></a></dt>
            </dl>
        </div>
        <div class="depth_banner">
            <dl>
                <c:forEach items="${listGnb000028}" var="l" end="0">
                    <dt><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span>${l.bnrTitle}</span></a></dt>
                    <dd><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}" ssl="${param.ssl}"/></span></a></dd>
                </c:forEach>
            </dl>
        </div>
    </div>
    </div>
    <!-- // 패션잡화 -->
    <!-- 뷰티헬스 -->
    <div id="catelist09" class="depth02">
    <div class="inner">
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00000611"><span>스킨케어</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061100"><span>스킨·토너/미스트</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061106"><span>미스트/마스크</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061101"><span>세럼/에센스</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061102"><span>크림/오일</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061104"><span>선케어</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061103"><span>링클/아이케어</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061105"><span>스킨케어세트</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00000613"><span>다이어트/헬스</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061307"><span>황사마스크</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061309"><span>안마기/릴렉스용품</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061300"><span>체중계</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061308"><span>요가매트/용품</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061303"><span>여성용품/청결제</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061302"><span>운동기구/소품</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00000617"><span>뷰티기기/소품</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061700"><span>진동/미용기기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061701"><span>헤어기기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061707"><span>바디케어 도구</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061706"><span>메이크업 도구</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061702"><span>화장솜/기름종이</span></a></dd>
            </dl>
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00000616"><span>클렌저/비누</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061603"><span>클렌저/비누</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061601"><span>클렌징 로션/오일</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061604"><span>핸드워시/풋워시</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000061607"><span>비누</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="#"><span>관련카테고리</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00000620"><span>네일/디자인타투</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00000615"><span>향수</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00000619"><span>메이크업</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00000618"><span>남성뷰티</span></a></dd>
                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000006"><span class="c_orange">카테고리 더보기 +</span></a></dt>
            </dl>
        </div>
        <div class="depth_banner">
            <dl>
                <c:forEach items="${listGnb000006}" var="l" end="0">
                    <dt><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span>${l.bnrTitle}</span></a></dt>
                    <dd><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}" ssl="${param.ssl}"/></span></a></dd>
                </c:forEach>
            </dl>
        </div>
    </div>
    </div>
    <!-- // 뷰티헬스 -->
    <!-- 유아동 -->
    <div id="catelist12" class="depth02">
    <div class="inner">
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002900"><span>패션잡화</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290000"><span>신발</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290001"><span>가방/미아방지가방</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290002"><span>모자</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290015"><span>시계</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290010"><span>우산</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290008"><span>지갑/파우치</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290014"><span>선글라스/안경</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290012"><span>헤어핀/헤어방울</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290013"><span>헤어밴드</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290011"><span>주얼리</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002903"><span>키즈의류</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290300"><span>티셔츠/셔츠</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290301"><span>원피스</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290302"><span>스커트</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290303"><span>자켓/점퍼/망토</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290304"><span>가디건/베스트</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290305"><span>바지/레깅스</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290306"><span>상하복세트</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290307"><span>내의/실내복</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290309"><span>우비</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290310"><span>전통의상/코스튬</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002902"><span>레저용품/의류</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290202"><span>아동용자전거/킥보드</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290200"><span>아동용인라인</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290201"><span>아동용헬멧</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290203"><span>키즈레저잡화</span></a></dd>
            </dl>
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002904"><span>베이비의류</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290400"><span>내의/실내복</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290408"><span>배변훈련팬티</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290411"><span>배냇저고리</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002905"><span>가구/침구/인테리어</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290500"><span>놀이매트</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290501"><span>플레이텐트</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290502"><span>아동침대</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000290508"><span>아동침구</span></a></dd>
            </dl>
            <dl>
                <dt><a href="#"><span>관련 카테고리</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002906"><span>완구/교구</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002910"><span>화장품</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002907"><span>외출/이동용품</span></a></dd>
                <!-- dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00002908"><span>수유/이유용품</span></a></dd -->
                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000029"><span class="c_orange">카테고리 더보기 +</span></a></dt>
            </dl>
        </div>
        <div class="depth_banner">
            <dl>
                <c:forEach items="${listGnb000029}" var="l" end="0">
                    <dt><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span>${l.bnrTitle}</span></a></dt>
                    <dd><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}" ssl="${param.ssl}"/></span></a></dd>
                </c:forEach>
            </dl>
        </div>
    </div>
    </div>
    <!-- // 베이비/키즈 -->
    <!-- Pet -->
    <div id="catelist11" class="depth02">
    <div class="inner">
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00003000"><span>디자이너패션/액세서리</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300005"><span>자켓/베스트</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300000"><span>티셔츠</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300001"><span>원피스</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300002"><span>올인원</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300003"><span>신발/양말</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300004"><span>패션소품</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00003001"><span>가구/하우스</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300100"><span>캣타워/스크래쳐</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300101"><span>침대</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300102"><span>스텝퍼</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300103"><span>기타가구</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300104"><span>텐트</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300105"><span>하우스</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300106"><span>방석/쿠션/베개</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00003002"><span>식기/물병</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300200"><span>자동급식기/사료통</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300201"><span>친환경식기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300202"><span>도자기식기</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300204"><span>플라스틱식기</span></a></dd>
            </dl>
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00003003"><span>패션/액세서리</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300300"><span>자켓</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300301"><span>티셔츠</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300302"><span>원피스</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300303"><span>올인원</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00003004"><span>외출/훈련용품</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300400"><span>유모차</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300401"><span>이동장/캐리어</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300402"><span>인식표</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=0000300403"><span>리드줄</span></a></dd>
            </dl>
            <dl>
                <dt><a href="#"><span>관련 카테고리</span></a></dt>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00003005"><span>미용/의약부외품</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00003006"><span>위생/배변</span></a></dd>
                <dd><a href="${defaultHost}/ht/gift/giftCategorySub?ctgrId=00003007"><span>사료/간식</span></a></dd>
                <dt><a href="${defaultHost}/ht/gift/giftCategoryMain?ctgrId=000030"><span class="c_orange">카테고리 더보기 +</span></a></dt>
            </dl>
        </div>
        <div class="depth_banner">
            <dl>
                <c:forEach items="${listGnb000030}" var="l" end="0">
                    <dt><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span>${l.bnrTitle}</span></a></dt>
                    <dd><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}" ssl="${param.ssl}"/></span></a></dd>
                </c:forEach>
            </dl>
        </div>
    </div>
    </div>
    <!-- // Pet -->
    <!-- CD -->
    <div id="catelist13" class="depth02">
    <div class="inner">
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/record/category/000300"><span>가요</span></a></dt>
                <dd><a href="${defaultHost}/ht/record/category/00030000"><span>가요</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00030001"><span>랩/힙합</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00030002"><span>락</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00030003"><span>재즈/뉴에이지/일렉트로닉 </span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00030004"><span>OST/뮤지컬</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00030005"><span>화보집/MD상품 </span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00030006"><span>성인가요</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/000310"><span>유아/아동</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/000311"><span>종교음악</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/record/category/000301"><span>팝</span></a></dt>
                <dd><a href="${defaultHost}/ht/record/category/00030100"><span>POP</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/000302"><span>ROCK</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00030300"><span>JAZZ</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/000304"><span>J-POP</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/000305"><span>OST/MUSICAL</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/000306"><span>NEW AGE</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/000307"><span>WORLD MUSIC</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/record/category/000308"><span>클래식</span></a></dt>
                <dd><a href="${defaultHost}/ht/record/category/00030800"><span>교향곡</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00030801"><span>협주곡</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00030802"><span>관현악</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00030803"><span>실내악</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00030804"><span>독주</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00030805"><span>오페라</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00030806"><span>성악</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00030810"><span>명상음악</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00030811"><span>모음집</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/000309"><span>국악</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="#"><span>바로가기</span></a></dt>
                <dd><a href="${defaultHost}/ht/recordMain"><span>음반 전체보기</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/reserve/0003"><span>예약 음반</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/newRecord/0003"><span>새로나온 음반</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/bestList/0003?bestRangeType=C1002"><span>베스트 음반</span></a></dd>
                <dd><a href="${defaultHost}/ht/welcome/hotEventMain?ctgrId=0003"><span>음반 이벤트</span></a></dd>
            </dl>
            <dl>
                <dt><a href="#"><span>전문관</span></a></dt>
                <dd><a href="${defaultHost}/ht/record/box"><span>BOX SET</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/audio"><span>AUDIO PHILE</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/lp"><span>LP SHOP</span></a></dd>
            </dl>
        </div>
        <div class="depth_banner">
            <dl>
                <c:forEach items="${listGnb0003}" var="l" end="0">
                    <dt><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span>${l.bnrTitle}</span></a></dt>
                    <dd><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}" ssl="${param.ssl}"/></span></a></dd>
                </c:forEach>
            </dl>
        </div>
    </div>
    </div>
    <!-- // CD -->
    <!-- DVD -->
    <div id="catelist14" class="depth02">
    <div class="inner">
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/dvdMain"><span>블루레이</span></a></dt>
                <dd><a href="${defaultHost}/ht/record/category/00040000"><span>드라마/로맨스</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00040001"><span>애니메이션</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00040002"><span>TV시리즈</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00040003"><span>SF/판타지</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00040004"><span>액션/모험</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00040005"><span>공포/스릴러</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00040006"><span>코메디</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00040007"><span>뮤지컬영화</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00040008"><span>다큐멘터리</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00040009"><span>MUSIC BLU-RAY</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/dvdMain"><span>블루레이</span></a></dt>
                <dd><a href="${defaultHost}/ht/record/category/000400"><span>BLU-RAY 전체보기</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/reserve/000400"><span>예약 BLU-RAY</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/newRecord/000400"><span>새로나온 BLU-RAY</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/bestList/000400?bestRangeType=C1003"><span>베스트 BLU-RAY</span></a></dd>
                <dd><a href="${defaultHost}/ht/welcome/hotEventMain?ctgrId=0004"><span>BLU-RAY 이벤트</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/dvdMain"><span>DVD</span></a></dt>
                <dd><a href="${defaultHost}/ht/record/category/00040100"><span>드라마/로맨스</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00040101"><span>애니메이션</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00040102"><span>TV시리즈</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00040103"><span>SF/판타지</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00040104"><span>액션/모험</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00040105"><span>공포/스릴러</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00040106"><span>코메디</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00040107"><span>뮤지컬영화</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00040109"><span>다큐멘터리</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/category/00040108"><span>MUSIC DVD</span></a></dd>
            </dl>
        </div>
        <div class="depth_section">
            <dl>
                <dt><a href="${defaultHost}/ht/dvdMain"><span>DVD</span></a></dt>
                <dd><a href="${defaultHost}/ht/record/category/000401"><span>DVD 전체보기</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/reserve/000401"><span>예약 DVD</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/newRecord/000401"><span>새로나온 DVD</span></a></dd>
                <dd><a href="${defaultHost}/ht/record/bestList/000401?bestRangeType=C1003"><span>베스트 DVD</span></a></dd>
                <dd><a href="${defaultHost}/ht/welcome/hotEventMain?ctgrId=0004"><span>DVD 이벤트</span></a></dd>
            </dl>
        </div>
        <div class="depth_banner">
            <dl>
                <c:forEach items="${listGnb0004}" var="l" end="0">
                    <dt><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span>${l.bnrTitle}</span></a></dt>
                    <dd><a href="${l.bnrLnkUrl}"<c:if test="${l.bnrNewWinYn eq 'Y'}"> target="_blank"</c:if>><span><ui:image src="${l.bnrImgUrl}" alt="${l.bnrImgAlt}" width="${l.bnrWidth}" height="${l.bnrHeight}" ssl="${param.ssl}"/></span></a></dd>
                </c:forEach>
            </dl>
        </div>
    </div>
    </div>
    <!-- // DVD -->
</div>
<!-- //Gnb -->
<script type="text/javascript">
jQuery(function($){
    rollingKeywords();
    setInterval(function(){rollingKeywords();}, 4000);
    
    $(".keyword_list li a").click(function(e){
        e.preventDefault();
        var frm = document.gnbSearchForm;
        if(frm){
            frm.searchTerm.value = $(this).find(".keyword").text().replace(/^\s\s*/, '').replace(/\s\s*$/, '');
            for(var key in cond_gnb_srch) {
                if(frm[key]){
                    frm[key].value = cond_gnb_srch[key];
                }
            }
            
            frm.submit();
        }
    });
});

function rollingKeywords(){
    var onItem = $(".keyword_list li.on");
    if(onItem.hasClass("last")){
        $(".keyword_area").find("li:first").addClass("on");
        $("#keywordTxt").html($(".keyword_area").find("li:first").html());
    }else{
        onItem.next().addClass("on");
        $("#keywordTxt").html(onItem.next().html());
    }
    onItem.removeClass("on");
}
</script>
