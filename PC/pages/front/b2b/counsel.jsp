<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<html>
<head>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/common.js"></script>  
<script type="text/javascript">
jQuery(function($){
    $("input[id^=mngrTelNum]")
    .keydown(function(e){
        if((e.keyCode > 47 && e.keyCode < 58) || (e.keyCode > 95 && e.keyCode < 106) || e.keyCode == 8 || e.keyCode == 9 || e.keyCode == 37 || e.keyCode == 39 || e.keyCode == 46){
            return true;
        }else{
            return false;
        }
    })
    .keyup(function(e){
        if((e.keyCode > 47 && e.keyCode < 58) || (e.keyCode > 95 && e.keyCode < 106)){
            if($(this).attr("id") == "mngrTelNum1" && $(this).val().length == 3){
                $("#mngrTelNum2").focus();
            }else if ($(this).attr("id") == "mngrTelNum2" && $(this).val().length == 4){
                $("#mngrTelNum3").focus();
            }
        }
    })
    ;
});

function submitCounsel(){
    if($("input[name=compName]").val() == ""){
        alert("회사명을 입력하셔야 합니다.");
        $("input[name=compName]").focus();
        return false;
    }else if($("input[name=mngrName]").val() == ""){
        alert("담당자명을 입력하셔야 합니다.");
        $("input[name=mngrName]").focus();
        return false;
    }else if($("#mngrTelNum1").val() == ""){
        alert("담당자 연락처를 입력하셔야 합니다.");
        $("#mngrTelNum1").focus();
        return false;
    }else if($("#mngrTelNum2").val() == ""){
        alert("담당자 연락처를 입력하셔야 합니다.");
        $("#mngrTelNum2").focus();
        return false;
    }else if($("#mngrTelNum3").val() == ""){
        alert("담당자 연락처를 입력하셔야 합니다.");
        $("#mngrTelNum3").focus();
        return false;
    }else{
        $("input[name=mngrTelNum]").val($("#mngrTelNum1").val() + "-" + $("#mngrTelNum2").val() + "-" + $("#mngrTelNum3").val());
        $("form[name=counselFrm]").ajaxSubmit({
            url: "/ht/b2b/counselSubmit"
            , method : "POST"
            , dataType: "json"
            , success: function(data) {
                alert("상담신청이 정상적으로 접수되었습니다.");
            }
            , error: function() {
                alert("상담신청을 실패했습니다. 잠시 후 다시 시도해 주세요.");
                return false;
            }
        });
    }

}
</script>
</head>
<body>
<div class="b2b_main">
    <span><img src="${imageServer}/images/b2b/sub05_tit_01.jpg"/></span>
    <span><img src="${imageServer}/images/b2b/sub05_img_01.jpg"/></span>
    <div class="form" style="">
        <form name="counselFrm">
            <!-- 장진용 -->
            <input type="hidden" name="cnslNames" value="박주현"/>
            <input type="hidden" name="cnslPoses" value="과장"/>
            <input type="hidden" name="cnslEmails" value="hiddink68@hottracks.co.kr"/>
            <input type="hidden" name="cnslNames" value="강동희"/>
            <input type="hidden" name="cnslPoses" value="과장"/>
            <input type="hidden" name="cnslEmails" value="kangdh70@hottracks.co.kr"/>
            <input type="hidden" name="cnslNames" value="류지영"/>
            <input type="hidden" name="cnslPoses" value="차장"/>
            <input type="hidden" name="cnslEmails" value="chatme@hottracks.co.kr"/>
            <table>
                <colgroup>
                    <col width="100px"/>
                    <col width="250px"/>
                    <col width="*"/>
                </colgroup>
                <tbody>
                    <tr>
                        <th><span>회사명</span></th>
                        <td><input type="text" name="compName" class="input"/></td>
                        <td rowspan="3"><a href="javascript://" onclick="submitCounsel();"><img src="${imageServer}/images/b2b/sub05_img_bt.jpg" alt="상담접수"/></a></td>
                    </tr>
                    <tr>
                        <th><span>담당자명</span></th>
                        <td><input type="text" name="mngrName" class="input"/></td>
                    </tr>
                    <tr>
                        <th><span>연락처</span></th>
                        <td>
                            <input type="hidden" name="mngrTelNum"/>
                            <input type="text" id="mngrTelNum1" size="3" maxlength="3"/>
                            -
                            <input type="text" id="mngrTelNum2" size="4" maxlength="4"/>
                            -
                            <input type="text" id="mngrTelNum3" size="4" maxlength="4"/>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
    </div>
    <div class="table">
        <h4>광화문점</h4>
        <table>
            <caption>광화문점</caption>
            <thead>
                <tr>
                    <th>이름</th>
                    <th>직급</th>
                    <th>전화번호</th>
                    <th>이메일</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>박주현</td>
                    <td>과장</td>
                    <td>02-3700-6662</td>
                    <td>hiddink68@hottracks.co.kr</td>
                </tr>
                <tr>
                    <td>강동희</td>
                    <td>과장</td>
                    <td>02-3700-6662</td>
                    <td>kangdh70@hottracks.co.kr</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="table">
        <h4>강남점</h4>
        <table>
            <caption>강남점</caption>
            <thead>
                <tr>
                    <th>이름</th>
                    <th>직급</th>
                    <th>전화번호</th>
                    <th>이메일</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>류지영</td>
                    <td>차장</td>
                    <td>02-534-9961</td>
                    <td>chatme@hottracks.co.kr</td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>