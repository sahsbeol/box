<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<ui:decorator name="help"/>
<head>
</head>
<body>
<div id="customer">
    <div class="contents"> 
        <p class="customertit12 ir">오프라인 멤버십 혜택</p>
        <div class="sub_stitle_bg02">   
            <p class="ir">
                핫트랙스 오프라인영업점 회원이 되시면,
                총 누적금액에 따라 등급별  할인혜택을  제공합니다.
                전국 15개 영업점에서 특별한 할인혜택을 누려보세요.
            </p>
        </div>
        <div class="order_infor"> 
            <div class="order_infor_title2">
                <div><img src="${imageServer}/images/customer/sinfor_title01_02.gif" alt="오프라인 회원혜택 안내" /></div>
            </div>
            <table class="infor_table01 titlebg_04">
                <colgroup>  
                    <col width="105px" /> 
                    <col width="91px" /> 
                    <col width="195px" /> 
                    <col width="130px" />   
                    <col width="259px" />  
                </colgroup>
                <thead>
                    <tr> 
                        <th><span class="ir">구 분</span></th>  
                        <th><span class="ir">회원종류</span></th>  
                        <th><span class="ir">기 준</span></th>  
                        <th><span class="ir">상세내용</span></th>   
                        <th><span class="ir">기  타</span></th>  
                    </tr>
                </thead>
                <tbody class="htl"> 
                    <tr> 
                        <td rowspan="3">핫트랙스</td>   
                        <td>일반</td> 
                        <td>가입 후 누적금액 20만원 이상</td> 
                        <td>문구, 음반<br />최대5%할인</td>  
                        <td rowspan="3" class="end">※ 할인적용시 일부품목이 제외될 수 있습니다.<br />
                            ※ 회원에 대한 주차혜택은 점별로 상이합니다.<br />
                            ※ 2003.6.1 이전에 가입한 유료회원 별도기준 적용</td>
                    </tr>  
                    <tr>    
                        <td>GOLD</td> 
                        <td>누적금액 1,000만원 이상</td> 
                        <td>문구, 음반<br />최대10%할인</td>  
                    </tr>  
                    <tr>    
                        <td>VIP</td> 
                        <td>누적금액 2,000만원 이상</td>  
                        <td>문구, 음반<br />최대15%할인</td>  
                    </tr>  
                </tbody> 
            </table>   
        </div> 
        <p class="f_bl89 f11" style="margin:10px;">* 누적금액이란 핫트랙스 영업점에서 현재까지 구매하신 금액의 총합계입니다.</p>
        <div class="h30"></div>
        <div class="order_infor h45_bottom"> 
            <div class="order_infor_title2">
                <div><img src="${imageServer}/images/customer/sinfor_title02_02.gif" alt="회원가입방법" /></div> 
            </div>  
            <div class="infor_imgbox"> 
                <ul class="bu_list h15_top">
                    <li class="f11"><span class="f_black_b">온라인에서 가입하시는 경우</span><br />
                    쇼핑몰 상단의 회원가입버튼을 통해 가입하실 수 있습니다.<br />
                    온라인에서 가입하시면 교보문고와 핫트랙스 멤버십에 동시가입되며,<br />
                     영업점에서도 회원제도를 바로 이용하실 수 있습니다.</li>
                </ul>  
                <ul class="bu_list h15_top">
                    <li class="f11"><span class="f_black_b">오프라인 영업점에서 가입하시는 경우</span><br />
                    회원가입신청서를 작성하여 주시면 가입하실 수 있습니다.<br />
                    오프라인에서 가입하시면 교보문고와 핫트랙스 영업점을 동시에 이용하실 수 있으며, <br />
                    온라인몰은 ID가 필요하므로 추가로 가입해 주셔야 합니다.</li>
                </ul> 
            </div>
        </div>
        <div class="order_infor"> 
            <div class="order_infor_title2">
                <div><img src="${imageServer}/images/customer/sinfor_title03_02.gif" alt="멤버십카드는 영업점에서 신청하시면 발급받으실 수 있습니다." /></div> 
            </div>  
            <div class="txtbox">
                <ul class="bu_list h15_top">
                    <li class="bg_none">온라인에서 회원가입 또는 통합신청을 하신 회원께서는 오프라인 영업점에서 간단한 발급절차를 통해 멤버십카드를 발급받으실 수 있습니다. <br />
                    또한 기존의 멤버십카드를 분실하셨다면, 역시  발급절차를 통해 새로 받으실 수 있습니다.</li>
                </ul>
            </div>  
        </div> 
        <div class="h30"></div> 
        <div class="order_infor"> 
            <div class="order_infor_title2">
                <div><img src="${imageServer}/images/customer/sinfor_title04_02.gif" alt="교보문고 북클럽, 핫트랙스 멤버십 카드 통합서비스 안내" /></div> 
            </div>  
            <div class="txtbox">
                <ul class="bu_list h15_top">
                    <li class="bg_none">카드 통합은 한 장의 카드에 양사의 멤버십을 담아 드리는 서비스입니다. <br />
                    또한 2006년 5월 29일 이후부터는 신규회원가입시 양사의 멤버십제도에 동시에 가입됩니다. <br />
                    동시가입 이전가입 고객님께서는 통합신청을 통해 카드를 통합하여 사용하실 수 있습니다.</li>
                </ul>
            </div>  
        </div> 
        <div class="h30"></div>
    </div>
</div>
</body>