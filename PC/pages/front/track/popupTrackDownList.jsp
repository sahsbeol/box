<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>음악다운로드</title>
<link rel="stylesheet" type="text/css" href="/css/contents.css"/>  
<script type="text/javascript" src="/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/common"></script>
<script type="text/javascript" charset="utf-8">
self.resizeTo(710,710);
var oldList;
$(document).ready(function(){
    
    var html = '<tr>';
    html += '<td>1</td>';
    html += '<td class="left">처음처럼 / 서태지</td>';
    html += '<td>남은곡 사용</td>';
    html += '<td><button type="button"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/order/btn_delete.gif" alt="삭제" /></button></td>';
    html += '</tr>';
    
    //var html = '<input type="hidden" value="' + nameValue + '"  name="optnNameList">';
    //html += '<input type="hidden" value="' + keyValue + '"  name="optnValueList">';
    //html += '<input type="hidden" value="true"  name="optnPrdtYn">';

  
    $('div#downList').append(html);

  
 
})
</script>
</head>
<body>
<div id="popup">
    <div class="pop-head" >
        <h1><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/popup/h1_logo.gif" alt="Hottracks" /></h1>
        <h2><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/popup/h2_popup_musicDown.gif" alt="음악다운로드" /></h2>
    </div>
    <div class="pop_body">
        <div class="abs_area" style="height:200px;">
       
            <table class="order_table01">
                <colgroup>
                <col width="5%" /> 
                <col width="*" />
                <col width="15%" />
                <col width="5%" />
                </colgroup>
                <thead>
                    <tr>
                        <th>NO</th> 
                        <th>곡명/아티스트</th>
                        <th>결제</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody>
  
                    <tr>
                       <td>1</td> 
                       <td class="left">처음처럼 / 서태지</td>
                       <td>남은곡 사용</td>
                       <td><button type="button"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/order/btn_delete.gif" alt="삭제" /></button></td>
                   </tr>

                </tbody>
            </table>
        </div>
        <div class="pop_box_gray right"> 다운로드 할 곡 수 : 총 <strong>8</strong> 곡 </div>
        <div class="popbbox3"> <span>보유한 남은곡 40곡 (이용권 1개)</span>
            <button type="button"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/order/btn_bye.gif" alt="구매" /></button>
        </div>
        <div class="pop_box_gray">
            <p class="summary">총구매할 곡 : <strong>8</strong> 곡</p>
            <p class="another_use"><span>남은 곡 사용</span>
                <input name="" type="text" class="count" value="8" />
                곡</p>
            <p class="add_pay"><span>추가결재금액(VAT별도)</span>
                <input type="text" class="count" value="0" />
                원</p>
        </div>
        <ul class="popup_massage clear">
            <li>곡 구매시 보유한 남은곡 순서로 자동 사용(차감)됩니다.</li>
            <li>이미 구매하신 곡은 구매곡으로 표시되면 구매시 제외됩니다.</li>
            <li>선택하신 곡 중에 기획사의 요청으로 구매가 불가능한 곡은 MP3구입내역에 노출되지 않으니 확인 후 구매해주세요.</li>
            <li><a href="#">다운로드 매니저 설치 오류시 안내</a></li>
        </ul>
        <div class="popup_foot_btn h30_top">
            <button type="button"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/order/btn_next.gif" alt="다음" /></button>
        </div>
    </div>
    <div class="h20"></div>
</div>
</body>
</html>



