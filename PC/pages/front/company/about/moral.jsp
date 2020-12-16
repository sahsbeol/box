<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<style type="text/css">
.tradeWrap.access_tab .tab li a.tablist02 {  position: absolute;  right: 215px;  top: 0;}
.tradeWrap.access_tab .tab li a.tablist03 {  position: absolute;  right: 111px;  top: 0;}
.table_view3 table {width: 744px;}
.table_view3 table#email_table { margin-top : 15px;}
.table_view3 table#email_table td input { border: 1px solid #cbcbcb;  background : white;}
.table_view3 table#email_table th.blue { background-color : #f8f8f8; color : #3f8abf; border-color : 1px solid #e2e2e2;}
.table_view3 table#email_table tbody{border-top : 1px solid #a4c3e0; border-bottom : 1px solid #a4c3e0; border-left : 1px solid #dddddd;}
em.location strong input#top_title{ border: 0px; position: relative; float: right; margin-left: 4px; font: 11px 굴림,"Gulim", sans-serif; font-weight: bold; width : 55px;}
#cyber_bt{ margin-top: 20px;}
</style>
<script type="text/javascript">
var target='${target}';
function change(num){
    if(num == 1){
        $("#top_title").val("윤리경영");
        $("#top_title").css("width", "55px");
    }else if(num == 2){
        $("#top_title").css("width" , "70px");
        $("#top_title").val("우리의 다짐");
    }else if(num == 3){
        $("#top_title").val("사이버 신문고");
        $("#top_title").css("width" , "83px");
    }
}
jQuery(function($){
    change(target);
    
    $(".target").click(function(){
           var img = $(".target.on").find(".targetImg");
           if(img != undefined)    img.attr("src", img.attr("src").replace("_on.jpg", "_off.jpg"));
           $(".target.on").removeClass("on");
       
           $(this).addClass("on");
           img = $(this).find(".targetImg");
           img.attr("src", img.attr("src").replace("_off.jpg", "_on.jpg"));
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
            /* +"<b>거래처명 : </b>"
            +$('input[name=senderCompany]').val()
             */
             +"<br><b>이름 : </b>"
            +$('input[name=senderName]').val()
            +"<br><b>연락처 : </b>"
            +$('input[name=senderPhoneNo]').val()
            /* +"<br><b>상기 불공정 해당번호 : </b>"
            +$("#member_reg select[name=senderCase]").val()
             */
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
        $('#member_reg input[name=subject]').val("사이버 신문고에서 신고가 접수되었습니다. ");
        
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
            <em class="location"><img src="http://image.hottracks.co.kr/info/icon/icon_home.png"  alt="홈"/> &gt; 회사소개 &gt; 윤리경영 &gt; <strong><input type="text" id="top_title" readOnly value="윤리경영"></strong></em>
            <h2>윤리경영</h2>
        </div>
        <!-- //location -->
        <div class="tradeWrap access_tab">
            <ul class="tab">
                <li class="target <c:if test='${ target eq "1" }'>on</c:if>">
                    <c:choose>
                        <c:when test='${ target eq "1" }'>
	                        <a class="tablist02" href="javascript://" onclick="change(1);" title="윤리 경영"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/company/about/cyber/tab_01_on.jpg" alt="윤리경영" class="targetImg"/></a>
	                    </c:when>
	                    <c:otherwise>
	                       <a class="tablist02" href="javascript://" onclick="change(1);" title="윤리 경영"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/company/about/cyber/tab_01_off.jpg" alt="윤리경영" class="targetImg"/></a>
	                    </c:otherwise>
                    </c:choose>
                    
                    <div class="bx_tab_con" viewList="viewList">
                        <h3><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/company/about/cyber/tit_01_1.jpg" alt="윤리경영" /></h3>
                        <div class="margin_top15">
                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/company/about/cyber/img_01_1.jpg" alt="윤리경영" />
                            <br/>
                        </div>
                        <h3><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/company/about/cyber/tit_01_2.jpg" alt="윤리경영 만화" /></h3>
                        <div class="margin_top15">
                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/company/about/cyber/img_01_2.jpg" alt="윤리경영" />
                            <br/>
                        </div>
                    </div>
                </li>
                
                <li class="target <c:if test='${ target eq "2" }'>on</c:if>">
                    <c:choose>
                        <c:when test="${ target eq '2'}">
                            <a class="tablist03"  href="javascript://"  onclick="change(2);"  title="우리의 다짐"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/company/about/cyber/tab_02_on.jpg" alt="우리의 다짐" class="targetImg"/></a>
                        </c:when>
                        <c:otherwise>
                            <a class="tablist03"  href="javascript://"  onclick="change(2);"  title="우리의 다짐"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/company/about/cyber/tab_02_off.jpg" alt="우리의 다짐" class="targetImg"/></a>
                        </c:otherwise>
                    </c:choose>
                    
                    <div class="bx_tab_con" viewList="viewList">
                    <h3><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/company/about/cyber/tit_02.jpg" alt="윤리경영" /></h3>
                        <div class="margin_top15">
                            <br/>
                            <br/>
                            <img src="http://image.kyobobook.co.kr/newimages/giftshop_new/company/about/cyber/img_02.jpg" alt="우리의 다짐" />
                            <br/>
                        </div>
                    </div>
                </li>
                
                <li class="target <c:if test='${ target eq "3" }'>on</c:if>">
                    <c:choose>
                        <c:when test="${ target eq '3'}">
                            <a class="tablist04" href="javascript://" onclick="change(3);" title="사이버 신문고"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/company/about/cyber/tab_03_on.jpg" alt="사이버 신문고" class="targetImg"/></a>
                        </c:when>
                        <c:otherwise>
                            <a class="tablist04" href="javascript://" onclick="change(3);" title="사이버 신문고"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/company/about/cyber/tab_03_off.jpg" alt="사이버 신문고" class="targetImg"/></a>
                        </c:otherwise>
                    </c:choose>
                    <div class="bx_tab_con" viewList="viewList">
                        <h3><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/company/about/cyber/tit_03.jpg" alt="사이버신문고" /></h3>
                        <br/>
                        <br/>
                        <div class="margin_top15">
                            <img style="margin-left: 11px;" src="http://image.kyobobook.co.kr/newimages/giftshop_new/company/about/cyber/img_03.jpg" alt="사이버신문고 이미지" />
                        </div>
                        <div class="table_view3">
                        <form name="member_reg" id="member_reg" method="post" enctype="multipart/form-data" action="http://ems.hottracks.co.kr/servlet/sendemailu">
                                <input type="hidden" name="body" id="body"/>
                                <input type="hidden" name="from" value=""/>
                                <input type="hidden" name="to" value="pen@hottracks.co.kr"/>
                                <!-- <input type="hidden" name="to" value="donghee@hottracks.co.kr"/> -->
                                <input type="hidden" name="subject" value=""/>
                                <table cellpadding="0"  cellspacing="0" border="0" width="757px" height="75px" style="background-color:#f8f8f8; border:#dadada 1px solid;">
                                <tr>
                                    <td style="padding:15px 20px;">
                                    <p class="list_com02">
                                    <b>개인정보 수집 및 이용에 대한 안내</b><br/><br/>
                               - 개인정보의 수집 및 이용목적 : 문의 내역 접수 확인 및 답변처리 <br/>
                               - 수집하는 개인정보 항목 : 이름, 연락처, 이메일<br/>
                               - 보유 및 이용기간 : 회사내부규정에 따라 1년간 보관 후 파기 <br/>
                                <br/>
                                <input type="checkbox" name="checkboxperson" id="chk_agree1" /> <label for="chk_agree1">위 개인정보 수집, 이용에 동의합니다.</label>
                                <br/>
                                </td>
                                </tr>
                                </table>
                                <table id="email_table" cellpadding="0" cellspacing="0" summary="사이버 신문고 테이블 이름, 연락처, 이메일이 있습니다.">
                                <caption>사이버 신문고 테이블</caption>
                                    <colgroup>
                                        <col width="20%"/>
                                        <col width="*"/>
                                    </colgroup>
                                    <tr>
                                        <th class="blue" scope="row"><label for="id_name">이름</label></th>
                                        <td><input type="text" name="senderName" maxlength="10" id="id_name" class="input_style" style="width:200px;"/></td>
                                    </tr>
                                    <tr>
                                        <th class="blue" scope="row"><label for="phone">연락처</label></th>
                                        <td><input type="text" name="senderPhoneNo" id="phone" maxlength="14" style="ime-mode:disabled;width:130px" class="input_style"/></td>
                                    </tr>
                                    <tr>
                                        <th class="blue" scope="row"><label for="e_mail">이메일</label></th>
                                        <td>
                                            <input type="text" name="email1" id="e_mail" title="이메일주소입력" style="ime-mode:disabled;width:130px;" maxlength="30"  class="input_style"/>@
                                            <input type="text" name="email2" title="이메일직접입력" style="ime-mode:disabled;width:130px;" maxlength="30"  class="input_style"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th class="blue" scope="row"><label for="con">내용</label></th>
                                        <td style="padding-top: 10px; padding-bottom: 10px;">
                                        <textarea style="width:510px;height:150px; margin-bottom : 10px;" cols="1" rows="1" id="con" class="textarea_style" name="senderContents"></textarea>
                                        <br/>
                                        <p style="color: #404040;"><strong>[알림]</strong> 고객님께서 작성해주신 전화번호 또는 이메일로 답변을 드립니다. 실제 연락이 가능한 정보로 작성<br/> 해주세요.</p></td>
                                    </tr>
                                </table>
                                </form>
                                <iframe id="mailSend" name="mailSend" width="0" height="0" title="빈프레임"></iframe>
                                <div class="centerBtnView1">
                                    <a href="javascript:goSubmit();"><img id="cyber_bt" src="http://image.kyobobook.co.kr/newimages/giftshop_new/company/about/cyber/bt.jpg" alt="등록하기"/></a>
                                </div>
                          </div>
                    </div>
                </li>
             </ul>
        </div>
    </div><!-- //contents area -->
</div><!-- //container -->
</body>
</html>