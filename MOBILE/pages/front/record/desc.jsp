<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<c:if test="${param.sngl eq 'Y'}">
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=2.0">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:300,400,700&display=swap&subset=korean">
</head>
<body>
</c:if>
<style>
body {margin:0px; padding:0px;}
.product-detail {display:block;width:100%;overflow:hidden;font-family:'Noto Sans KR', AppleGothic, sans-serif;}
.product-detail .header {position: fixed;left: 0;top: 0;width: 100%;background: #fff;z-index: 900;text-align: center;display:none;height: 60px;border-bottom: 1px solid #dbdbdb;padding: 10px 0;box-sizing: border-box;}
.product-detail.more .header { display:block; } 
.product-detail .header h2 {padding: 10px 0;margin: 0 auto;line-height:1.4rem;font-size: 20px;font-weight: 700;color: #000;vertical-align: middle;letter-spacing: -0.1px;} 
.product-detail .header .btn_cls {
    position: absolute;
    right: 15px;
    top: 15px;
    width: 34px;
    height: 34px;
    overflow: hidden;
    text-indent: -9999px;
    font-size: 0;
    background: url('https://simage.kyobobook.co.kr/newimages/giftshop_new/resources/img/common/btn_close_layer.png') 50% 50% no-repeat;
    background-size: 15px;
}
.product-detail.active { height:auto; }
.product-detail img { max-width:100%; }
.product-detail table { max-width:100%; }

li { display:list-item; text-align:-webkit-match-parent; list-style: none;}
.tooltip_wrap {display:inline;position:relative;}
.tooltip {display:inline-block;width:14px;height:14px;background:#888;font-weight:bold;text-align:center;color:#fff;line-height:14px;}
.layer_pop_wrap {display:none;position:absolute;top:22px;left:-143px;z-index:10;}
.layer_pop_container {position:relative;border:1px solid #b6b6b6;background:#fff;}
.layer_pop_container h1 {height:32px;padding:0 0 0 15px;background:#4f4f4f;font-size:12px;color:#fff;line-height:32px;}
.layer_pop_container .layer_pop_cont {padding: 15px;}
.layer_pop_container .cls_btn {position:absolute;top:0;right:0;}
.layer_pop_cont ul li {padding-left:0;background:none;line-height:18px;}
.tit_tahoma { margin: 14px 0 18px; font-size: 18px;color:#363636; }

.detail-title { line-height:50px;font-size:20px;text-align:center;background-color:#ff6000;color:#FFF;position:fixed;top:0;width:100%; }
.detail-title .close-btn { float:right;margin-right:10px; }
.detail-title .close-btn a { color:#FFF; }
.product-detail.more .detail-cont {margin-top:60px; padding:10px; font-size:14px;}
.detail-cont {padding:20px;}
.detail-cont .album_option {margin-top:30px;padding:9px 15px;border:1px solid #d6d6d6;background:#f9f9f9;color:#252525;}
.detail-cont .album_option > ul { }
.detail-cont .album_option > ul > li {*zoom:1;float:left;padding-left:5px;line-height:20px;background:url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/ico_dot03.gif) no-repeat 0 9px;margin-left:10px;}
/*
.detail-cont .album_option > ul > li .line {margin:0 16px 0 14px;color:#d6d6d6;}
 */
.detail-cont .album_option > ul:after {content:"";display:block;clear:both;}
.detail-cont .album_option .layer_pop_wrap {top:20px;left:-70px;}
.detail-cont .album_option .layer_pop_cont ul li {margin-bottom:7px;padding-left:7px;background:url(http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/renewal/common/ico_dot02.gif) no-repeat 0px 7px;color:#252525;}
.detail-cont .album_info {margin-top:30px;}
.detail-cont .album_info h3 {margin-bottom:20px;font-size:14px;color:#363636;}
.detail-cont .album_info h4 {font-weight:normal;font-size:11px;color:#8e8e8e;line-height:18px;}
.detail-cont .album_info p {margin-top:17px;font-size:11px;color:#8e8e8e;line-height:18px;}
.detail-cont .album_info .p_add_info {padding-top:13px;border-top:1px solid #eaeaea;color:#8e8e8e;}
.detail-cont .album_info .p_add_info li {line-height:24px;}
.detail-cont .album_info .p_add_info li .line {margin:0 10px 0 6px;}
</style>
<!-- content -->
<div class="product-detail<c:if test="${param.sngl eq 'Y'}"> more</c:if>">
<div class="header">
    <h2>상품 상세보기</h2>
    <a class="btn_cls" onclick="history.back(); return false;">닫기</a>
</div>
<div class="detail-cont">
    <c:if test="${not empty listTrack && not empty listTrack.cdNoList}">
        <h3 class="tit_tahoma">Track List</h3>
        <c:forEach items="${listTrack.cdNoList}" var="cdNo" varStatus="status">
            <p style="margin-bottom:10px;">
                <strong style="font-size:14px;">[DISC ${cdNo}]</strong><br/>
                <c:forEach items="${listTrack.cdNoMapList[cdNo]}" var="l" varStatus="s">
                    <strong>${l.trkNo} |</strong> ${l.trkName} <c:if test="${not empty l.artiName}">(${l.artiName})</c:if><br/>
                </c:forEach>
            </p>
        </c:forEach>
    </c:if>
    <div class="mgt50">
        <c:if test="${not empty posterCaseCnt && posterCaseCnt > 0}">
            <strong>포스터는 포스터 지관통에 담아 발송해 드립니다.</strong>
            <p>(앨범을 2장 이상 구매 시 포스터는 구매 수량과 동일하게 증정되며, 포스터 지관통은 주문 건당 1개만 증정됩니다.)<br />단 해외 주문 건은 포스터가 발송 되지 않습니다</p>
        </c:if>
        <c:if test="${not empty rlseDtNextDay and p.rcrdStat eq '9'}">
            <strong style="color:#1591D2;">본 상품은 <ui:mask pattern="####년##월##일">${rlseDtNextDay}</ui:mask> 발송 예정인 예약판매 ${p.sellPrdtGbn eq 'R'?'음반':'상품'} 입니다.</strong>
            <p>예약 상품의 경우 발매일은 제작사의 사정에 따라 연기 될 수도 있으며, 예약 상품과 같이 주문하시는 상품은 예약상품 발매 후 같이 발송 됩니다. 먼저 출시된 다른 상품을 먼저 받아보시려면 예약 상품과 별도의 주문을 하셔야 합니다</p>
        </c:if>
    </div>
    <c:if test="${fn:startsWith(p.ctgrId, '0004')}">
        <div class="album_info">
            <h3>상품 추가 정보</h3>
            <h4><c:if test="${not empty p.actor}">출연자 : ${p.actor}</c:if></h4>
            <p>
                <c:if test="${not empty p.drctr}">감독 : ${p.drctr} |</c:if>
                <c:if test="${not empty p.lang}">언어 : ${p.lang} |</c:if>
                <c:if test="${not empty p.captn}">자막 : ${p.captn} |</c:if>
                <br />
                <c:if test="${not empty p.scr}">화면 : ${p.scr} |</c:if>
                <c:if test="${not empty p.sound}">음향 : ${p.sound}</c:if>
                <br />
                <c:if test="${not empty p.scrHour}">상영시간 :  ${p.scrHour} |</c:if>
                <c:if test="${not empty p.cdCount}">디스크 수 : ${p.cdCount} |</c:if>
                <c:if test="${not empty p.localCode && fn:startsWith(p.ctgrId, '000401')}">지역코드 : ${p.localCode} |</c:if>
                <c:if test="${not empty p.rcrdYear}">제작년도 : ${p.rcrdYear} |</c:if>
                <c:if test="${not empty p.rtngCode}">등급 :
                    <c:if test="${p.rtngCode eq 'C0841'}">전체이용가</c:if>
                    <c:if test="${p.rtngCode eq 'C0842'}">12세이용가</c:if>
                    <c:if test="${p.rtngCode eq 'C0843'}">15세이용가</c:if>
                    <c:if test="${p.rtngCode eq 'C0844'}">18세이용가</c:if>
                    <c:if test="${p.rtngCode eq 'C0845'}">연소자이용불가</c:if>
                </c:if>
            </p>
        </div>
    </c:if>
    <div class="album_option">
        <ul>
            <c:if test="${not empty p.mediaName}">
                <li>
                    <strong>미디어</strong> : ${p.mediaName}
                    <div class="tooltip_wrap">
                        <a href="javascript:toggleLayer('#tooltip3');" class="tooltip">?</a>
                        <div id="tooltip3" class="layer_pop_wrap">
                            <div class="layer_pop_container" style="width:360px;height:385px;">
                                <h1>미디어 코드 안내</h1>
                                <div class="layer_pop_cont">
                                    <ul class="list_type02">
                                        <li>
                                            <strong>SACD</strong><br />
                                            본 음반은 Super Audio CD Players에서만 재생 가능합니다.
                                        </li>
                                        <li>
                                            <strong>SACD Hybrid</strong><br />
                                            본 음반은 일반 CD Players, Super Audio CD Players 모두 재생가능합니다.
                                        </li>
                                        <li>
                                            <strong>DVD Audio</strong><br />
                                            이것은 오직 DVD 플레이어에서만 재생 가능한 고음질 5.1채널 CD로서 영상은 포함되어 있지 않으니 유념하시기 바랍니다.
                                        </li>
                                        <li>
                                            <strong>Blu-Ray</strong><br />
                                            화질, 음향이 DVD보다 진화된 차세대 영상미디어 입니다.<br />
                                            Blu-Ray는 Blu-Ray 전용플레이어서만 플레이가 되며, DVD 플레이어에서는 재생이 되지 않습니다.
                                        </li>
                                        <li>
                                            <strong>Blu-Ray Audio</strong><br />
                                            영상이 없는 '듣는 블루레이'입니다.<br />
                                            Blu-Ray Audio는 Blu-Ray 전용 플레이어에서만 플레이가 되며, CD플레이어, DVD플레이어 등에서는 재생이 되지 않습니다.
                                        </li>
                                    </ul>
                                </div>
                                <a href="javascript:toggleLayer('#tooltip3');" class="cls_btn" title="레이어팝업 닫기"><img src="${imageServer}/images/renewal/common/btn_cls.gif" alt="닫기" /></a>
                            </div>
                        </div>
                    </div>
                </li>
            </c:if>
            <li><strong>수입구분</strong> : ${p.impYn?'수입':'라이센스'}</li>
            <li><strong>디스크 수</strong> : ${p.cdCount} DISC</li>
            <c:if test="${cateList[1].cateId eq '000308' && not empty p.rcrdYear}">
                <li><strong>녹음연도</strong> : ${p.rcrdYear} DISC</li>
            </c:if>
            <c:if test="${fn:startsWith(p.ctgrId, '000401')}">
                <li>
                    <strong>지역코드</strong>
                    <div class="tooltip_wrap">
                        <a href="javascript:toggleLayer('#tooltip4');" class="tooltip">?</a>
                        <div id="tooltip4" class="layer_pop_wrap">
                            <div class="layer_pop_container" style="width:260px;height:255px;">
                                <h1>지역 코드 안내</h1>
                                <div class="layer_pop_cont">
                                    <ul class="list_type02">
                                        <li><strong>0</strong> 지역에 상관없이 재생가능</li>
                                        <li><strong>1</strong> 미국을 포함한 북미 지역</li>
                                        <li><strong>2</strong> 일본 및 유럽</li>
                                        <li><strong>3</strong> 우리 나라를 포함한 동남아 지역</li>
                                        <li><strong>4</strong> 오스트레일리아, 뉴질랜드, 남아메리카</li>
                                        <li><strong>5</strong> 러시아, 아프리카</li>
                                        <li><strong>6</strong> 중국</li>
                                        <li><strong>7</strong> 국가간을 여행하는 비행기나 선박 내</li>
                                    </ul>
                                </div>
                                <a href="javascript:toggleLayer('#tooltip4');" class="cls_btn" title="레이어팝업 닫기"><img src="${imageServer}/images/renewal/common/btn_cls.gif" alt="닫기" /></a>
                            </div>
                        </div>
                    </div>
                </li>
            </c:if>
            <li>
                <strong>제조국</strong> : 
                <c:choose>
                    <c:when test="${empty p.productionNation or p.productionNation eq '999'}">상품내 표기</c:when>
                    <c:when test="${p.productionNation eq '001'}">한국</c:when>
                    <c:when test="${p.productionNation eq '002'}">미국</c:when>
                    <c:when test="${p.productionNation eq '003'}">영국</c:when>
                    <c:when test="${p.productionNation eq '004'}">일본</c:when>
                    <c:when test="${p.productionNation eq '005'}">EU</c:when>
                    <c:when test="${p.productionNation eq '006'}">아시아</c:when>
                    <c:otherwise>상품내 표기</c:otherwise>
                </c:choose>
            </li>
        </ul>
    </div>
    <div class="album_info mgb55">
        <h3>${p.sellPrdtGbn eq 'R'?'음반':'상품'}정보</h3>
        <c:if test="${not empty p.moviePath}"><p>${p.moviePath}</p></c:if>
        <c:if test="${not empty p.subDescription }">
            <p>${hfn:lineToBr(p.subDescription)}</p>
        </c:if>
        <p>${hfn:lineToBr(p.description)}</p>
    </div>
</div>
</div>
<c:if test="${param.sngl eq 'Y'}">
</body>
</html>
</c:if>