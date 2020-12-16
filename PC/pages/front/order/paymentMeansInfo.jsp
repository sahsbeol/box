<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="none"/>

<div class="paymentArea list01" style="display:block; width:930px; height:365px;">
    <div class="ch_txtbox">
        <p class="title">신용카드 행사안내</p>
        <div id="card_box" class="container_box">  
            <ul class="card_box"> 
                <li onmouseover="card_Open(1)"><p class="card01 ir">국민카드</p></li>
                <li onmouseover="card_Open(2)"><p class="card02 ir">신한카드</p></li>
                <li onmouseover="card_Open(3)"><p class="card03 ir">씨티카드</p></li>
                <li onmouseover="card_Open(4)"><p class="card04 ir">삼성카드</p></li>
                <li onmouseover="card_Open(5)"><p class="card05 ir">롯데카드</p></li>
                <li onmouseover="card_Open(6)"><p class="card06 ir">외환카드</p></li>
                <li onmouseover="card_Open(7)"><p class="card07 ir">현대카드</p></li>
                <li onmouseover="card_Open(8)"><p class="card08 ir">BC카드</p></li>
                <li onmouseover="card_Open(9)"><p class="card09 ir">기타</p></li> 
            </ul>  
            <div id="card_box01" class="txt_box_on">
                <p><span class="f_red_b">국민카드</span></p>
                <p> - 무이자 할부 준비 중</p>
            </div>
            <div id="card_box06" class="txt_box_off">
                <p><span class="f_red_b">외환카드</span></p>
                <p> - 무이자 할부 준비 중</p> 
            </div>
            <div id="card_box03" class="txt_box_off">
                <p><span class="f_red_b">씨티카드</span></p>
                <p> - 5만원 이상 구매시 2~3개월 무이자 할부</p> 
            </div>
            <div id="card_box04" class="txt_box_off">
                <p><span class="f_red_b">삼성카드</span></p> 
                <p> - 무이자 할부 준비 중</p> 
            </div>
            <div id="card_box05" class="txt_box_off">
                <p><span class="f_red_b">교보 롯데카드</span></p>
                <p> - 30만원이상 | 10%할인 월 1만원한도</p>
                <p> - 60만원이상 | 25%할인 월 2만원한도</p>
                <p>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="http://www.lottecard.co.kr/app/view/if/gate.jsp?b_id=11129_11195_11443&vt_cd_knd_c=P02528-A02528" target="_lotte1"><img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/common/images/help/cardInfo/btn_01.gif" alt="일반신청" /></a>
                    <a href="http://www.lottecard.co.kr/app/view/if/gate.jsp?b_id=11130_11196_11444&vt_cd_knd_c=P02529-A02529" target="_lotte2"><img src="https://simage.kyobobook.co.kr/newimages/giftshop_new/common/images/help/cardInfo/btn_02.gif" alt="바로DC신청" /></a>
                </p>
            </div>
            <div id="card_box07" class="txt_box_off">
                <p><span class="f_red_b">현대카드</span></p> 
                <p> - 무이자 할부 준비 중</p> 
            </div>
            <div id="card_box02" class="txt_box_off">
                <p><span class="f_red_b">신한카드</span></p> 
                <p> - 무이자 할부 준비 중</p>
            </div>
            <div id="card_box08" class="txt_box_off">
                <p><span class="f_red_b">BC카드</span></p>
                <p> - 무이자 할부 준비 중</p> 
            </div>
            <div id="card_box09" class="txt_box_off">
                <p><span class="f_red_b">기타</span></p>  
            </div>
            <p>기타 문의나 더 자세한 내용이 알고 싶으시면 고객센터 &gt; 주문 FAQ를 이용해 주시기 바랍니다. <span class="newbtn_038"><button type="button" class="ir" onclick="goOrderFaq();">주문 FAQ 바로보기</button></span></p> 
        </div> 
    </div>  
</div>
<!-- //여기까지 -->
<div class="paymentArea list02" style="display:none;">
    <div class="ch_txtbox">
        <p class="title">실시간 계좌이체안내</p>
        <div class="container_box">
            <span class="f_red_b">이용가능은행</span><br />  
            경남, 광주, 국민, 기업, 농협, 대구, 부산, 산업, 새마을금고, 수협, 신한, 신협, 외환, 우리, 우체국,<br />
            전북, 제주, 하나, 한국씨티, SC제일, 동양증권, 신한금융투자, 삼성증권, 미래에셋증권, 한국투자증권, 한화증권<br />
            <br />
            
            에스크로 시행령에 따라 고객님의 결제대금을 보호받으실 수 있습니다.<br /> 
            '실시간 계좌이체'를 통해 결제하시면 ''LG U+'를 통해 결제대금을 보호 받으실 수 있습니다. <br /> 
            결제금액 5만원 이상 에스크로 서비스 선택시 적용됩니다. <br /><br /> 
            <span class="newbtn_036"><button type="button" class="ir" onclick="goValidEscrow('${lgdMid}');">서비스 가입 사실확인</button></span>
            
            <p class="h30"></p>                                             
            기타 문의나 더 자세한 내용이 알고 싶으시면 고객센터 &gt; 주문 FAQ를 이용해 주시기 바랍니다. <span class="newbtn_038"><button type="button" class="ir" onclick="goOrderFaq();">주문 FAQ 바로보기</button></span><br /> 
        </div> 
    </div>
</div>
<div class="paymentArea list03" style="display:none;"> 
    <div class="ch_txtbox">
        <p class="title">휴대폰 결제안내</p>
        <div class="container_box"> 
            - 교보핫트랙스에서 휴대폰으로 결제 가능한 최대 금액은 월 30만원 이지만 개인별 한도금액은 통신사 및 개인 설정에 따라 다를 수 있습니다.<br />
            - 휴대폰으로 결제하신 금액은 익월 휴대폰 요금에 함께 청구됩니다.<br />
            - 휴대폰 소액결제로 구매하실 경우 세금계산서 및 현금영수증이 발급되지 않습니다.<br />
            - 휴대폰 소액결제로 결제하신 상품을 취소할 경우 결제하신 당월말까지 가능합니다.<br />
            - 휴대폰 결제로 별도의 수수료 부과는 없습니다.<br /><br />
        </div> 
    </div>  
</div>
<div class="paymentArea list04" style="display:none;"> 
    <div class="ch_txtbox">
        <p class="title">상품권 결제안내</p>
        <div class="container_box"> 
            ▶ 사용가능 상품권 : 컬쳐랜드 문화상품권 (로그인 방식) 

            <p class="h30"></p>                                             
            기타 문의나 더 자세한 내용이 알고 싶으시면 고객센터 &gt; 주문 FAQ를 이용해 주시기 바랍니다. <span class="newbtn_038"><button type="button" class="ir" onclick="goOrderFaq();">주문 FAQ 바로보기</button></span><br /> 
        </div> 
    </div>  
</div>
<div class="paymentArea list05" style="display:none;">
    <div class="ch_txtbox">
        <p class="title">무통장 입금안내 </p>
        <div class="container_box">
                                                1) 가상계좌는 일회성 계좌이므로 재사용시(다시 그 계좌로 입금하시는 경우) 타인의 계좌로 입금될 가능성이 있습니다.<br /> 
                                                 이 경우는 고객의 책임이므로 사용에 주의하시기 바랍니다.<br/>
                                                2) 가상계좌의 경우 CD 기에서 현금입금 하실 수 없습니다. 
                                                CD 기에서 이체는 가능합니다
                                                <p class="h30"></p>
        </div> 
    </div>
</div>