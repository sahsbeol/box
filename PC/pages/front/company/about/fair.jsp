<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<script type="text/javascript">
jQuery(function($){
    $(".target").click(function(){
        var img = $(".target.on").find(".targetImg");
        if(img != undefined)    img.attr("src", img.attr("src").replace("_on.png", ".png"));
        $(".target.on").removeClass("on");
        
        $(this).addClass("on");
        img = $(this).find(".targetImg");
        img.attr("src", img.attr("src").replace(".png", "_on.png"));
    });
});

function goSubmit() {
    var forms = document.member_reg;
    if(confirm('등록하시겠습니까?')){
        if(!forms.chk_agree1.checked ){
            alert("개인정보 수집, 이용에 동의하셔야 서비스가 가능합니다.");
            return;
        }
        
        if ( $('#member_reg input[name=senderCompany]').val() == "" ){
            alert("고객님의 거래처명을  입력해 주세요.");
            $('#member_reg input[name=senderCompany]').select().select();
            return;
        }
        
        if ( $('#member_reg input[name=senderName]').val() == "" ){
            alert("고객님의 이름을 입력해 주세요.");
            $('#member_reg input[name=senderName]').select().select();
            return;
        }
        
        if ( $("#member_reg input[name=senderPhoneNo]").val() == "") {
            alert("연락처를 입력해 주세요.");
            $('#member_reg input[name=senderPhoneNo]').select().select();
            return;
        }
        
        if ( $("#member_reg input[name=email1]").val() == ""){
            alert("email을 입력해 주세요");
            $('#member_reg input[name=email1]').select().select();
            return;
        }
        
        if ( $("#member_reg input[name=email2]").val() == ""){
            alert("email의 '@' 뒤에 주소를 입력해 주세요.");
            $('#member_reg input[name=email2]').select().select();
            return;
        }
        
        if ( $("#member_reg select[name=senderCase]").val() == "0"){
            alert("상기 불공정 해당번호를선택해 주세요");
            $('#member_reg select[name=senderCase]').select().select();
            return;
        }    
        
        if ( $("#member_reg textarea[name=senderContents]").val() == ""){
            alert("내용을 입력해 주세요");
            $('#member_reg textarea[name=senderContents]').select().select();
            return;
        }
        
        if ( $("#member_reg input[name=email1]").val() != "" && $("#member_reg input[name=email2]").val() != ""){
            $("#member_reg input[name=from]").val($("input[name=email1]").val() + "@" + $("input[name=email2]").val());
        }
        
        var mailContents = 
            "<html xmlns=\"http://www.w3.org/1999/xhtml\">"
            +"<head>"
            +"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />"
            +"<meta name=\"description\" content=\"\" />"
            +"<meta name=\"keywords\" content=\"\" />"
            +"<title>핫트랙스</title>"
            +"</head>"
            +"<body>"
            +"<div style=\"width:764px; height:auto; background:#fff url('http://image.hottracks.co.kr/info/mail/top_bg.png') repeat-x left top; \">"
            +"<div style=\"clear:both; height:88px; width:100%; display:inline-block;\">"
            +"<h1 style=\"padding:23px 0 0 38px;float:left; margin:0;\"><a href=\"#none\" title=\"New ME HOTTRACKS\">"
            +"<img src=\"http://image.hottracks.co.kr/info/mail/logo.png\" alt=\"New ME HOTTRACKS\" style=\"border:0;\"/></a></h1>"
            +"<p style=\"float:right; margin:0; padding:65px 37px 0 0; \"><img src=\"http://image.hottracks.co.kr/info/mail/txt_mail.png\" alt=\"E-MAIL SERVICE\" /></p>"
            +"</div>"
            +"<div style=\"clear:both; height:auto; background:#fff url('http://image.hottracks.co.kr/info/mail/bg_contents.png') repeat-y left top;\">"        
            +"<p style=\"padding:73px 78px; line-height:25px; margin:0; font-family:'돋움', 'Dotum', '굴림', Gulim, Arial, sans-serif; color:#444; font-size:12px;\">"
            +"<b>거래처명 : </b>"
            +$('input[name=senderCompany]').val()
            +"<br><b>이름 : </b>"
            +$('input[name=senderName]').val()
            +"<br><b>연락처 : </b>"
            +$('input[name=senderPhoneNo]').val()
            +"<br><b>상기 불공정 해당번호 : </b>"
            +$("#member_reg select[name=senderCase]").val()
            +"<br><b>내용<br><textarea  cols=\"1\" rows=\"1\" style=\"width:624px; height:150px;\"> "
            +$("#member_reg textarea[name=senderContents]").val()
            +"</textarea></b><br>"
            +"</p>"
            +"</div>"
            +"<div style=\"clear:both; width:100%; height:auto; text-align:center;\">"
            +"<img src=\"http://image.hottracks.co.kr/info/mail/copy.png\" alt=\"Copyright ⓒ Kyobo Hottracks. All right reserved.\" /></div>"
            +"</div>"
            +"</body>"
            +"</html>";
        //alert(mailContents);
        $('#member_reg input[name=body]').val(mailContents);
        $('#member_reg input[name=subject]').val("공정거래지킴이에서 신고가 접수되었습니다. ["+$('#member_reg input[name=senderCompany]').val()+"]");
        
        forms.target = 'mailSend';
        forms.submit();
        
        alert('등록되었습니다.');
        //init();
    }
}
</script>
</head>
<body>
<div id="container">
<p class="cont_topBg_recruit"><img src="http://image.hottracks.co.kr/info/company/bg_snb_company.png" alt="반갑습니다. 일상을 즐거움으로 채워가는 핫트랙스입니다."/></p>
<c:import url="./layerLnb.jsp"/>
<!-- contents area -->
<div id="contents_area">
        <!-- location -->
        <div id="location">
            <em class="location"><img src="http://image.hottracks.co.kr/info/icon/icon_home.png"  alt="홈"/> &gt; 회사소개 &gt; <strong>공정거래자율준수</strong></em>
            <h2>공정거래자율준수</h2>
        </div>
        <!-- //location -->
        <div class="tradeWrap access_tab">
            
            <ul class="tab">
                <li class="target on">
                    <a class="tablist01" href="#none" title="공정거래 지킴이"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/tab_guard_on.png" alt="공정거래 지킴이" class="targetImg"/></a>
                    <div class="bx_tab_con" viewList="viewList">
                        <h3><img src="http://image.hottracks.co.kr/info/company/txt_guard.png" alt="공정거래 지킴이" /></h3>
                        <div class="margin_top15">
                            <br/>
                            <p class="txt">
                            공정거래 지킴이는 투명하고 공정한 유통거래질서 확립을 위하여 마련한 협력업체와의 소통 공간입니다. 
                            당사와 거래시 아래의 공정거래 위반 소지가 있는 내용을 알려 주시면 적극 반영해 개선토록 하겠습니다. 작은 소리 하나가 큰 것을 지킬 수 있습니다.
                            </p>
                            <br/>
                            <p style="margin:15px;">
                                <img src="http://image.hottracks.co.kr/info/company/txt_guard_contents.gif" alt="대규모유통업법 주요 내용 하단에 자세한 내용이 있습니다." />
                                <div class="hide_text">
                                    <ul>
                                        <li>1. 계약 체결 즉시 서면(전자 등) 교부를 하지않은 경우</li>
                                        <li>2. 사전 서면약정 없이 판촉비용을 부담시키거나 판촉사원을 부당하게 파견 요구</li>
                                        <li>3. 정당한 사유없이 납품대금을 감액하거나 판매대금을 지연지급</li>
                                        <li>4. 대규모유통업자의 상품이나 상품권 등의 구입을 강요</li>
                                        <li>5. 자기 또는 제3자를 위해 금전, 물품, 용역 등 경제적 이익제공 요구</li>
                                        <li>6. 거래중단 및 변경시 납품업자 등이 지출한 해당 매장 설비비용 보상</li>
                                        <li>7. 정당한 사유없이 매입한 상품을 반품하거나 수령을 지연, 거부</li>
                                        <li>8. 계약기간 중에 계약조건을 부당하게 변경 요구</li>
                                        <li>9. 납품업자의 중요한 매출정보를 이용한 경여 간선행위</li>
                                    </ul>
                                </div>
                            </p>
                            <br/>
                            <form name="member_reg" id="member_reg" method="post" enctype="multipart/form-data" action="http://ems.hottracks.co.kr/servlet/sendemailu">
                                <input type="hidden" name="body" id="body"/>
                                <input type="hidden" name="from" value=""/>
                                <!-- <input type="hidden" name="to" value="pen@hottracks.co.kr"/> -->
                                <input type="hidden" name="to" value="donghee@hottracks.co.kr"/>
                                <input type="hidden" name="subject" value=""/>
                                <table cellpadding="0"  cellspacing="0" border="0" width="757px" height="75px" style="background-color:#f8f8f8; border:#dadada 1px solid;">
                                <tr><td style="padding:15px 20px;"><p class="list_com02">
                                <b>개인정보 수집 및 이용에 대한 안내</b><br/>
                                 <br/>
                               - 개인정보의 수집 및 이용목적 : 문의 내역 접수 확인 및 답변처리 <br/>
                               - 수집하는 개인정보 항목 : 이름, 연락처, 이메일<br/>
                               - 보유 및 이용기간 : 회사내부규정에 따라 1년간 보관 후 파기 <br/>
                               <br/>
                                <input type="checkbox" name="checkboxperson" id="chk_agree1" /> <label for="chk_agree1">위 개인정보 수집, 이용에 동의합니다.</label>
                                 <br/></td></tr></table>
                                </p>
                                <div class="table_view3" style="margin-top:10px;">
                                <table summary="공정거래 지킴이 신고 테이블 거래처명, 이름, 연락처, 이메일, 상기 불공정 해당번호 항목이 있습니다.">
                                <caption>공정거래 지킴이 신고 테이블</caption>
                                    <colgroup>
                                        <col width="20%"/>
                                        <col width="*"/>
                                    </colgroup>
                                    <tr>
                                        <th class="red" scope="row"><label for="senderCompany">거래처명</label></th>
                                        <td><input type="text" name="senderCompany" id="senderCompany" maxlength="30" class="input_style" style="width:300px;"/></td>
                                    </tr>
                                    <tr>
                                        <th class="red" scope="row"><label for="id_name">이름</label></th>
                                        <td><input type="text" name="senderName" maxlength="10" id="id_name" class="input_style" style="width:130px;"/></td>
                                    </tr>
                                    <tr>
                                        <th class="red" scope="row"><label for="phone">연락처</label></th>
                                        <td><input type="text" name="senderPhoneNo" id="phone" maxlength="14" style="ime-mode:disabled;width:130px" class="input_style"/></td>
                                    </tr>
                                    <tr>
                                        <th class="red" scope="row"><label for="e_mail">이메일</label></th>
                                        <td>
                                            <input type="text" name="email1" id="e_mail" title="이메일주소입력" style="ime-mode:disabled;width:130px;" maxlength="30"  class="input_style"/>&nbsp;&nbsp;@
                                            <input type="text" name="email2" title="이메일직접입력" style="ime-mode:disabled;width:130px;" maxlength="30"  class="input_style"/>
                                        </td>
                                    </tr>
                                    <tr>
                                    <th class="red" scope="row"><label for="sender_num">상기 불공정 해당번호</label></th>
                                        <td>
                                            <select name="senderCase" class="input_style" id="sender_num" style="width:520px;">
                                                <option value="0" selected>선택하세요.</option>
                                                <option value="1.계약 체결 즉시 서면(전자 등) 교부를 하지 않은 경우">1.계약 체결 즉시 서면(전자 등) 교부를 하지 않은 경우</option>
                                                <option value="2.사전 서면약정 없이 판촉비용을 부담시키거나 판촉사원을 부당하게 파견 요구">2.사전 서면약정 없이 판촉비용을 부담시키거나 판촉사원을 부당하게 파견 요구</option>
                                                <option value="3.정당한 사유없이 납품대금을 감액하거나 판매대금을 지연지급">3.정당한 사유없이 납품대금을 감액하거나 판매대금을 지연지급</option>
                                                <option value="4.대규모유통업자의 상품이나 상품권 등의 구입을 강요">4.대규모유통업자의 상품이나 상품권 등의 구입을 강요</option>
                                                <option value="5.자기 또는 제3자를 위해 금전,물품,용역 등 경제적 이익제공 요구">5.자기 또는 제3자를 위해 금전,물품,용역 등 경제적 이익제공 요구</option>
                                                <option value="6.거래중단 및 변경시 납품업자 등이 지출한 해당 매장 설비비용 보상">6.거래중단 및 변경시 납품업자 등이 지출한 해당 매장 설비비용 보상</option>
                                                <option value="7.정당한 사유없이 매입한 상품을 반품하거나 수령을 지연, 거부">7.정당한 사유없이 매입한 상품을 반품하거나 수령을 지연, 거부</option>
                                                <option value="8.계약기간 중에 계약조건을 부당하게 변경 요구">8.계약기간 중에 계약조건을 부당하게 변경 요구</option>
                                                <option value="9.납품업자의 중요한 매출정보를 이용한 경영 간섭행위">9.납품업자의 중요한 매출정보를 이용한 경영 간섭행위</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="red" scope="row"><label for="con">내용</label></th>
                                        <td><textarea style="width:510px;height:150px;" cols="1" rows="1" id="con" class="textarea_style" name="senderContents"></textarea></td>
                                    </tr>
                                </table>
                                </div>
                            </form>
                            <iframe id="mailSend" name="mailSend" width="0" height="0" title="빈프레임"></iframe>
                        </div>
                        <div class="centerBtnView1">
                            <div class="reinfo" style="text-align:left;">
                                ※ 신고자의 비밀보장을 원칙으로 운영하고 있으며 접수된 내용은 비공개 방식으로 처리됩니다.<br />
                                ※ 상기 9개 항목을 제외한 사항에 대해서는 답변을 하지 않습니다.<br />                
                                ※ 주소 : 경기도 파주시 회동길 78 (출판단지내) 교보핫트랙스 공정거래자율준수 담당(경영성과관리팀)
                            </div>
                        </div>    
                        <div class="centerBtnView1">
                        <a href="javascript:goSubmit();"><img src="http://image.kyobobook.co.kr/ink/images/company/btn_confirm1.gif" alt="등록하기"/></a>
                        </div>
                    </div>
                </li>
                <li class="target">
                    <a class="tablist02" href="#none" title="대표이사선포문"><img src="http://image.hottracks.co.kr/info/company/tab_ceo.png" alt="대표이사선포문" class="targetImg"/></a>
                    <div class="bx_tab_con" viewList="viewList">
                        <h3><img src="http://image.hottracks.co.kr/info/company/txt_ceo.png" alt="대표이사 선포문" /></h3>    
                        <div class="titleArea">
                            <p class="img"><img src="http://image.hottracks.co.kr/info/company/txt_hello.png" alt="교보 핫트랙스 가족 여러분, 안녕하십니까?" /></p>
                            <p class="txt">먼저 교보핫트랙스를 통해 더 나은 세상을 만들고자 애쓰는 여러분의<br />
                            열정에 감사의 말씀을 드립니다.<br /> 
                            교보핫트랙스는 세상에 희망을 주는 기업이 되기 위해 노력하고<br />
                            있습니다. 우리는 이제 좋은 기업을 넘어 위대한 기업으로<br /> 
                            한 단계 더 나아가기 위해 이 자리에 모였습니다. 오늘 우리는 공정한<br />
                            경쟁과 시장질서를 충실히 준수할 것을 대내외에 선포하고자 합니다. 
                            </p>
                        </div>
                        <p class="txt">기업간의 자유롭고 공정한 경쟁은 자본주의 경제의 기본적인 시장질서 입니다. 불확실한 경영환경에 대응하고 미래성장을 위한 역량을 구축하여 위대한 기업으로 발전하기 위해서는 투명하고 공정하게 업무가 수행되어야 합니다. 시장질서를 준수하지 않고 성장한 회사는 지속적인 성장과 발전을 할 수 없으며, 끝내는 고객과 시장들로부터 외면당해 사라질 수밖에 없습니다.</p>
                        <p class="txt">교보핫트랙스는 지난 2007년 7월에 비전을 선포하면서 '정직과 성실'을 핵심가치의 한 축으로 설정하여, 올바른 직무윤리 정립과 경기에서의 페어플레이정신을 강조하였습니다. 또한 공정거래법규에 대한 조직원들의 이해를 높이고, 공정하고 투명한<br />경쟁문화를 정착시키기 위해 임사원을 대상으로 공정거래관련 기본교육을 이미 실시한 바 있습니다. 
                        </p>
                        <p class="txt">오늘 이 자리에서 공정거래관련 법규를 자율적으로 준수하고, 공정하고 투명한 경영을 실천함에 대해 다음의 실천의지를<br />대내외에 선언합니다.</p>
                        <ol class="fairMore">
                            <li><img src="http://image.hottracks.co.kr/info/company/txt_fair11.png" alt="하나, 우리는 공정하고 자유로운 경쟁이 회사와 사회를 발전시킨다는 데 인식을 같이하고 이를 실천하기 위하여 노력한다." /></li>
                            <li><img src="http://image.hottracks.co.kr/info/company/txt_fair12.png" alt="하나, 우리는 시장경쟁질서를 존중하고, 공정한 경쟁을 통한 건전한 발전에 앞장선다." /></li>
                            <li><img src="http://image.hottracks.co.kr/info/company/txt_fair13.png" alt="하나, 우리는 공정거래관련 법규를 자율적으로 준수하고 부당한 공동행위와 불공정거래행위를 하지 아니한다." /></li>
                            <li><img src="http://image.hottracks.co.kr/info/company/txt_fair14.png" alt="하나, 우리는 불공정한 약관을 사용하거나, 허위·과장된 광고나 표시를 하지 아니한다." /></li>
                        </ol>
                        <p class="txt">본 선언은 업무추진에 있어 모든 조직원들이 엄격히 준수해야 하는 규범이 되고, 앞으로 교보핫트랙스가 지향해야 하는 기본<br />업무지침이 되어, 공정하고 자유로운 경쟁을 통해 위대한 기업으로 도약하는 계기가 되어야 할 것입니다. 공정거래관련 법규의<br />위반은 고객, 주주, 거래사 등 다른 선량한 이해관계자들에게 심각한 피해를 끼칠 수 있고, 법규를 위반한 임사원들은 형사고발을<br />당할 수 있으며, 회사는 임사원들의 위반행위로 인해 막대한 과징금을 부과받을 수 있습니다. 또한 당국의 조사로 인한<br />업무지연과 시간 손실은 물론, 시장에서 부도덕한 기업으로 인지되어<br />기업이미지에 치명적인 손실을 가져오게 되어 궁극적으로는 기업의 존립마저 위협받을 수 있습니다.</p>
                        <p class="txt">교보핫트랙스 가족 여러분께서는 향후 업무를 수행하는데 있어서 이와 같은 사실을 항상 염두에 두시고 공정거래 준수를<br />최우선으로 고려하여 불공정거래행위로 인해 고객과 회사에 불이익이 발생하지 않도록 주의를 기울여 주시기 바랍니다.</p>
                        <p class="txt">교보핫트랙스는 좋은 기업을 넘어 위대한 기업의 길을 가고 있습니다. 이 길을 감에 있어 우리는 투명하고 공정한 방법으로 갈<br />것입니다. 투명하고 공정한 방법은 기본에 충실하고 관련 법규를 준수하며, 신용과 의리를 지키는 것임을 명심하시기 바랍니다.</p>
                        <p class="txt">오늘 '공정거래자율준수 선포'를 통해 모든 임직원들은 공정거래관련 법규를 철저히 준수하고, 불공정 행위를 근절하여, 보다 더<br />공정하고 투명한 기업문화가 정착될 수 있도록 임직원 여러분의 지속적이고 철저한 실천을 당부하는 바입니다.</p>
                        <p class="txt">감사합니다.</p>
                        <p class="sign"><img src="http://image.hottracks.co.kr/info/company/txt_ceoSign.png" alt="2008년 10월 8일 교보핫트랙스 | 대표이사 김성룡" /></p>
                    </div>
                </li>
                <li class="target">
                    <a class="tablist03" href="#none" title="전직원선서"><img src="http://image.hottracks.co.kr/info/company/tab_oath.png" alt="전직원선서" class="targetImg"/></a>
                    <div class="bx_tab_con" viewList="viewList">
                        <h3><img src="http://image.hottracks.co.kr/info/company/txt_oath2.png" alt="전직원 선서" /></h3>    
                        <div class="titleArea2">
                            <p class="img"><img src="http://image.hottracks.co.kr/info/company/txt_oath.png" alt="공정거래자율준수서약서" /></p>
                            <p class="txt">나는 공정거래 관련 법규를 충분히 이해하고, 이를 잘 준수할 것이며,<br />투명하고 공정한 업무수행이 회사의 지속적인 발전과 경쟁력 강화를<br />위한 핵심임을 깊이 인식하고 다음 사항을 성실하게 이행할 것을<br />서약합니다.</p>
                        </div>
                        <ol class="fairMore">
                            <li><img src="http://image.hottracks.co.kr/info/company/txt_fair21.png" alt="하나, 우리는 공정하고 자유로운 경쟁이 회사와 사회를 발전시킨다는 데 인식을 같이하고 이를 실천하기 위하여 노력한다." /></li>
                            <li><img src="http://image.hottracks.co.kr/info/company/txt_fair22.png" alt="하나, 우리는 시장경쟁질서를 존중하고, 공정한 경쟁을 통한 건전한 발전에 앞장선다." /></li>
                            <li><img src="http://image.hottracks.co.kr/info/company/txt_fair23.png" alt="하나, 우리는 공정거래관련 법규를 자율적으로 준수하고 부당한 공동행위와 불공정거래행위를 하지 아니한다." /></li>
                        </ol>
                    </div>
                </li>
                <li class="target">
                    <a class="tablist04" href="#none" title="자율준수관리자인사말"><img src="http://image.hottracks.co.kr/info/company/tab_manager.png" alt="자율준수관리자인사말" class="targetImg"/></a>
                    <div class="bx_tab_con" viewList="viewList">
                        <h3><img src="http://image.hottracks.co.kr/info/company/txt_manager.png" alt="자율준수관리자인사말" /></h3>    
                        <p class="img"><img src="http://image.hottracks.co.kr/info/company/txt_hello2.png" alt="안녕하십니까?" /></p>
                        <p class="txt">2017년 1월 19일자로 교보핫트랙스 공정거래자율준수관리자로 임명된 <strong>김재식</strong>입니다.</p>
                        <p class="txt">저는 교보핫트랙스 공정거래자율준수관리자로서 회사의 공정거래 실천의지가 모든 조직원에게 정확히 전파되고, 공정거래<br />자율준수 문화가 사내에 잘 정착될 수 있도록 자율준수프로그램을 운영하겠습니다. </p>
                        <p class="txt">또한 임직원 각자가 공정거래자율준수의 주체라고 생각하기 때문에 업무 중에 공정거래관련 법규들을 위반한 사항은 없는지<br />지속적으로 모니터링 하여 우리회사의 공정거래자율준수문화가 조기에 정착되도록 하겠습니다.<br />이를 위하여 다음과 같이실천하도록 하겠습니다.</p>
                        <ol class="fairMore">
                            <li><img src="http://image.hottracks.co.kr/info/company/txt_fair31.png" alt="첫째 시장질서를 존중하고, 법과 상도를 벗어난 부정한 방법으로 이득을 취하지 않겠습니다." /></li>
                            <li><img src="http://image.hottracks.co.kr/info/company/txt_fair32.png" alt="둘째, 회사내 공정거래관련 규정과 조지긍ㄹ 정비하고 확고한 제도로 자리잡을 수 있도록 하겠습니다." /></li>
                            <li><img src="http://image.hottracks.co.kr/info/company/txt_fair33.png" alt="셋째, 지속적인 모니터링을 통해서 위법행위가 발생치 않도록 사전에방에 최선을 다하겠습니다." /></li>
                            <li><img src="http://image.hottracks.co.kr/info/company/txt_fair34.png" alt="넷째, 공정거래관련 정보를 쉽게 공유할 수 있도록 다양한 채널을 활용하겠습니다." /></li>
                            <li><img src="http://image.hottracks.co.kr/info/company/txt_fair35.png" alt="다섯째, 정기적으로 담당자 교육을 실시하겠습니다." /></li>
                        </ol>
                        <p class="txt">투명하고 공정한 경쟁만이 기업의 발전을 지속시키는 길임을 명심하고, 공정거래자율준수관리자로서 맡은 바 소임을 완수하기<br />위해 최선을 다하겠습니다</p>
                        <p class="txt">2017년 1월 19일<br />교보핫트랙스 공정거래자율준수 관리자<br />마케팅지원실장 <strong>김재식</strong></p>
                    </div>
                </li>
            </ul>
        </div>
    </div><!-- //contents area -->
</div><!-- //container -->
</body>
</html>