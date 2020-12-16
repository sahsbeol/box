<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<ui:decorator name="popup"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<script type="text/javascript" src="/js/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/common.js"></script>  
<script type="text/javascript" charset="utf-8">
function uploadSuccess(data) {
    if (data.save) { 
        try {
            var id = $('input[name="id"]').val();
            parent.opener.setUploadImage(data.uploadPath, id);
            window.close();
        } catch (e) {
        }
    } else {
        alert(data.errorMessage);
    }
}
jQuery(function($) {
    $('#uploadButton').click(function() {
        var f = $('input[name="uploadImage"]').val();
        if (isEmpty(f)) {
            alert('파일을 선택하세요');
        } else {
            $('form[name="uploadImageForm"]').ajaxSubmit({
                url: '/ht/uploadImage'
               ,dataType: 'json'
               ,success: uploadSuccess
               ,error: function(data) {
                   alert('<fmt:message key="error.common.system"/>');
               }
            });
        }
    });

    $("#cancelButton").click(function() {
        self.close();
    });
});
</script>
</head>
<body>
<input type="hidden" name="id" value="${param.id}"/>
<div id="popup">
    <div class="pop-head" >
        <h1><img src="${imageServer}/images/popup/h1_logo.gif" alt="Hottracks" /></h1>
        <h2><img src="${imageServer}/images/popup/h2_popup_image.gif" alt="이미지 등록" /></h2>
    </div><!-- end pop-head -->
    <div class="pop-body">
        <div class="popup-image-register">
        <form name="uploadImageForm" method="post" enctype="multipart/form-data">
            <input type="hidden" name="uploadPath" value=""/>
            <p class="image-register-info">※ 이미지 파일은 jpg, gif만 등록 가능합니다.</p>
            <div class="attached-file">
                <span><img src="${imageServer}/images/popup/text_attached_file.gif" alt="첨부파일" /></span>
                <input type="file" name="uploadImage"/>
            </div><!-- end attached-file -->
            <div class="button">
                <a href="#"><img src="${imageServer}/images/popup/btn_resiter.gif" alt="등록" id="uploadButton" /></a>
                <a href="#"><img src="${imageServer}/images/popup/btn_cancel.gif" alt="취소" id="cancelButton"/></a>
            </div><!-- end button -->
        </form>
        </div><!-- end popup-image-register -->
    </div><!-- end pop-body -->
    <div class="popup-foot">
        <button type="button" onclick="self.close()"><img src="${imageServer}/images/popup/btn_close.gif" alt="닫기" /></button>
    </div><!-- end close-popup -->
</div><!-- end popup -->
</body>
</html>