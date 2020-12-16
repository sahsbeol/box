<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="popup"/>
<html>
<head>
<title>자주묻는 질문 - NEW ME HOTTRACKS</title>
<style type="text/css">
.faq-line h3 { padding: 0 0 7px 11px;}
.faq-line .faq-list { float: left;margin: 0 0 82px;border-top: 2px solid #4f4f4f;}
.faq-line .faq-list li { floaT: left;padding: 0 15px 0 87px;border-bottom: 1px solid #eaeaea;}
.faq-line .faq-list li dl { float: left;padding: 17px 0 0;}
.faq-line .faq-list li dl dt ,.faq-line .faq-list li dl dd { float: left;}
.faq-line .faq-list li dl dt { width: 25px;}
.faq-line .faq-list li dl dd { width: 662px;}
.faq-line .faq-list li dl dt.question { padding: 0 0 23px;}
.faq-line .faq-list li dl dd.question { padding: 0 0 27px 6px;width: 652px;font-weight: bold;}
.faq-line .faq-list li dl dd.answer { padding: 0 0 10px 10px;width: 652px;text-indent: -10px;line-height: 18px;vertical-align: top;}
.faq-line .faq-list li dl dd.answer ul { margin: -2px 0 0;padding: 0;}
.faq-line .faq-list li dl dd.answer ul li { padding: 0;float: none;border: 0;}
</style>
</head>
<body>
<div style="width:830px;">
    <h1><img src="${imageServer}/images/renewal/common/tit_pop_service05.gif" alt="자주묻는 질문" /></h1>
    <div class="pop_cont">
        <ul class="list_type02">
            <li>고급필기구의 진정한 가치를  말해주는 브랜드 스토리를 모았습니다.</li>
        </ul>
        <div class="search_sort_tab mgt20">
            <ul>
                <li><a href="/ht/brandStory?type=1" style="border-right:none;">브랜드 스토리<span class="arrow"> </span></a></li>
                <li><a href="/ht/fountainPen?type=1" style="border-right:none;">만년필 사용법<span class="arrow"> </span></a></li>
                <li><a href="/ht/carvingService" style="border-right:none;">각인서비스<span class="arrow"> </span></a></li>
                <li><a href="/ht/fountainPenFaq?type=1" class="on">자주묻는 질문<span class="arrow"> </span></a></li>
            </ul>
        </div>
        <div class="tbl_top c_both">
            <div class="f_left">
                <ul class="tab_btn02 sort">
                    <li class="${type eq '1'?'active':''}"><a href="/ht/fountainPenFaq?type=1">A/S가이드</a></li>
                    <li class="${type eq '2'?'active':''}"><a href="/ht/fountainPenFaq?type=2">각인가이드</a></li>
                    <li class="${type eq '3'?'active':''}"><a href="/ht/fountainPenFaq?type=3">포장가이드</a></li>
                    <li class="${type eq '4'?'active':''}"><a href="/ht/fountainPenFaq?type=4">배송가이드</a></li>
                </ul>
            </div>
        </div>
        <div class="faq-line">
            <c:choose>
                <c:when test="${type eq 1}">
                    <h3><img src="${imageServer}/images/service/h3_faq01.gif" alt="A/S 가이드" /></h3>
                    <ul class="faq-list">
                        <li>
                            <dl>
                                <dt class="question"><img src="${imageServer}/images/service/dt_question.gif" alt="question 질문" /></dt>
                                <dd class="question">1년 이내에 구입한 제품을 새 제품으로 교환이 가능한가요?</dd>
                                <dt class="answer"><img src="${imageServer}/images/service/dt_answer.gif" alt="answer 답변" /></dt>
                                <dd class="answer">
                                    <ul>
                                        <li>- 상품의 이상 유무에 따라 다르게 적용 됩니다.</li>
                                        <li>
                                            - 자체적인 불량이 있는 경우에는 구매 후 1년 이내에 무상으로 교체(제품, 부품) 및 수리가 가능하십니다.<br />
                                            그러나 고객님의 부주의로 인한 제품의 문제일 경우에는 비용이 부과됩니다.
                                        </li>
                                    </ul>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt class="question"><img src="${imageServer}/images/service/dt_question.gif" alt="question 질문" /></dt>
                                <dd class="question">제품 A/S 받고자 합니다. 맡기면 A/S 기간이 얼마나 걸리나요?</dd>
                                <dt class="answer"><img src="${imageServer}/images/service/dt_answer.gif" alt="answer 답변" /></dt>
                                <dd class="answer">
                                    <ul>
                                        <li>- 인터넷 교보문고 GIFT에 등기나 택배로 보내시면 15일 이내에 가능합니다.</li>
                                        <li>- 별도의  사유로 인한 A/S 지연 시 통보 드립니다.</li>
                                        <li>- A/S 사항은 매커니즘 이상 및 작동상의 불량으로 인한 경우에 해당되며 흠집이나 도금은 A/S에 해당하지 않습니다.</li>
                                    </ul>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt class="question"><img src="${imageServer}/images/service/dt_question.gif" alt="question 질문" /></dt>
                                <dd class="question">1년 이내에 구입한 제품을 새 제품으로 교환이 가능한가요?</dd>
                                <dt class="answer"><img src="${imageServer}/images/service/dt_answer.gif" alt="answer 답변" /></dt>
                                <dd class="answer">
                                    - 제품 A/S시 비용이 발생하나요?
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt class="question"><img src="${imageServer}/images/service/dt_question.gif" alt="question 질문" /></dt>
                                <dd class="question">제품 A/S를 받았는데도 계속 같은 문제가 발생하면 어떻게 하나요?</dd>
                                <dt class="answer"><img src="${imageServer}/images/service/dt_answer.gif" alt="answer 답변" /></dt>
                                <dd class="answer">
                                    - 구매 후 1년 이내의 제품에 대해서는 같은 문제가 반복적으로 발생할 경우 이상 부위의 부속 혹은 제품을 무상 혹은 유상으로 교환해 드립니다. 
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt class="question"><img src="${imageServer}/images/service/dt_question.gif" alt="question 질문" /></dt>
                                <dd class="question">컨버터도 A/S가 가능한가요?</dd>
                                <dt class="answer"><img src="${imageServer}/images/service/dt_answer.gif" alt="answer 답변" /></dt>
                                <dd class="answer">
                                    -  컨버터는 자체적으로 압축된 상태로서 분리가 되지 않습니다.<br /> 
                                    따라서,컨버터가 고장이 나거나 훼손된 경우 수리는 불가능 합니다.
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt class="question"><img src="${imageServer}/images/service/dt_question.gif" alt="question 질문" /></dt>
                                <dd class="question">캡 부위가 금이 갔어요.A/S가 가능한가요?</dd>
                                <dt class="answer"><img src="${imageServer}/images/service/dt_answer.gif" alt="answer 답변" /></dt>
                                <dd class="answer">
                                    <ul>
                                        <li>
                                            - 캡의 파손으로 인해 꽉 잠기지 않으면 캡 안쪽의 진공상태 유지가 되지 않으므로 잉크 누수나 사용시 잉크가 나오지       않는 현상이 발생 될 수 있기 때문에 교환해 주어야 합니다.
                                        </li>
                                        <li>
                                            - 교체에 따른 비용은 별도 안내 드립니다.
                                        </li>
                                    </ul>
                                </dd>
                            </dl>
                        </li>
                    </ul>
                </c:when>
                <c:when test="${type eq 2}">
                    <h3><img src="${imageServer}/images/service/h3_faq02.gif" alt="각인 가이드" /></h3>
                    <ul class="faq-list">
                        <li>
                            <dl>
                                <dt class="question"><img src="${imageServer}/images/service/dt_question.gif" alt="question 질문" /></dt>
                                <dd class="question">각인 비용은 별도로 추가 되나요?</dd>
                                <dt class="answer"><img src="${imageServer}/images/service/dt_answer.gif" alt="answer 답변" /></dt>
                                <dd class="answer">
                                     - 2 만원 이상 제품 구매 고객에게는 무료 각인 서비스를 실시 하고 있습니다.<br />
                                     단, 각인 사양 및 제품의 재질에 따라 일부 각인 서비스가 지원되지 않는 상품이 있습니다.
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt class="question"><img src="${imageServer}/images/service/dt_question.gif" alt="question 질문" /></dt>
                                <dd class="question">각인의 종류를 알고 싶어요!</dd>
                                <dt class="answer"><img src="${imageServer}/images/service/dt_answer.gif" alt="answer 답변" /></dt>
                                <dd class="answer">
                                    <ul>
                                        <li>- 영문 /  한글 / 한문 총 3가지 언어로 구분되며 서체도 선택하실 수 있습니다.</li>
                                        <li>
                                            - 이니셜 / 풀네임 / 원하는 문구/회사 로고 각인도 가능 합니다.<br /> 
                                              (자세한 서체 이미지는 각인 신청 란에서 확인하시면 됩니다.)
                                        </li>
                                        <li></li>
                                    </ul>
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt class="question"><img src="${imageServer}/images/service/dt_question.gif" alt="question 질문" /></dt>
                                <dd class="question">로고나 이미지 각인의 경우 비용이 발생 하나요?</dd>
                                <dt class="answer"><img src="${imageServer}/images/service/dt_answer.gif" alt="answer 답변" /></dt>
                                <dd class="answer">
                                    - 도안이 필요한 특수 로고나 도안이 필요한 경우에는 별도의 도안비를 받습니다. (별도 결제)                            
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt class="question"><img src="${imageServer}/images/service/dt_question.gif" alt="question 질문" /></dt>
                                <dd class="question">각인한 상품도 교환이나 환불이 되나요?</dd>
                                <dt class="answer"><img src="${imageServer}/images/service/dt_answer.gif" alt="answer 답변" /></dt>
                                <dd class="answer">
                                    - 각인된 상품은 상품의 하자를 제외하고는 교환 및 반품이 불가능 합니다.
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt class="question"><img src="${imageServer}/images/service/dt_question.gif" alt="question 질문" /></dt>
                                <dd class="question">각인 신청은 어디서 하나요?</dd>
                                <dt class="answer"><img src="${imageServer}/images/service/dt_answer.gif" alt="answer 답변" /></dt>
                                <dd class="answer">
                                    - 상품 페이지에서 각인 신청하기를 선택 후 각인 내용 및 각인 서체를 선택, 입력 하시면 됩니다.
                                </dd>
                            </dl>
                        </li>
                    </ul>
                </c:when>
                <c:when test="${type eq 3}">
                    <h3><img src="${imageServer}/images/service/h3_faq03.gif" alt="포장 가이드" /></h3>
                    <ul class="faq-list">
                        <li>
                            <dl>
                                <dt class="question"><img src="${imageServer}/images/service/dt_question.gif" alt="question 질문" /></dt>
                                <dd class="question">포장 신청을 하면 비용이 추가 되나요?</dd>
                                <dt class="answer"><img src="${imageServer}/images/service/dt_answer.gif" alt="answer 답변" /></dt>
                                <dd class="answer">
                                     - 고급필기구는 전상품 무료 포장 서비스를 실시하고 있습니다. (포장 이미지는 시즌에 따라 달라질 수 있습니다.)
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt class="question"><img src="${imageServer}/images/service/dt_question.gif" alt="question 질문" /></dt>
                                <dd class="question">어떻게 포장 신청을 하나요?</dd>
                                <dt class="answer"><img src="${imageServer}/images/service/dt_answer.gif" alt="answer 답변" /></dt>
                                <dd class="answer">
                                    - 상품 주문 시 주문 메시지 란 에  포장신청 기입해 주시면 됩니다.
                                </dd>
                            </dl>
                        </li>
                    </ul>
                </c:when>
                <c:otherwise>
                    <h3><img src="${imageServer}/images/service/h3_faq04.gif" alt="배송 가이드" /></h3>
                    <ul class="faq-list">
                        <li>
                            <dl>
                                <dt class="question"><img src="${imageServer}/images/service/dt_question.gif" alt="question 질문" /></dt>
                                <dd class="question">배송 기간이 얼마나 걸리나요?</dd>
                                <dt class="answer"><img src="${imageServer}/images/service/dt_answer.gif" alt="answer 답변" /></dt>
                                <dd class="answer">
                                     - 오전 12시 이전 결제완료 주문 건 중 일반 택배의 경우 도서산간 지역을 제외하고 결제완료 후 4~5일 이내에 받을 수 있습니다.
                                </dd>
                            </dl>
                        </li>
                        <li>
                            <dl>
                                <dt class="question"><img src="${imageServer}/images/service/dt_question.gif" alt="question 질문" /></dt>
                                <dd class="question">배송이 왜 이렇게 오래 걸리나요?</dd>
                                <dt class="answer"><img src="${imageServer}/images/service/dt_answer.gif" alt="answer 답변" /></dt>
                                <dd class="answer">
                                    - 인터넷 교보문고 GIFT는 고급필기구 상품의 경우 정식 수입원과 직거래를 통해 제품의 신뢰도를 확보하고 있습니다.<br />
                                      이에 수입원 본사와의 재고 이동 시간으로 인해 배송 기일이 깁니다.
                                </dd>
                            </dl>
                        </li>
                    </ul>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>