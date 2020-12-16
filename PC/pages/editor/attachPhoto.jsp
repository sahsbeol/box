<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="ui" uri="http://hottracks.co.kr/taglib/ui" %>
<ui:decorator name="none"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>이미지 첨부</title> 
<link rel="stylesheet" href="/scripts/editor/css/popup.css" type="text/css"  charset="utf-8"/>
<script src="/scripts/editor/js/popup.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="/scripts/jquery/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/scripts/jquery/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/loadingBar.js"></script>
<script type="text/javascript">
    function done() {
        var extension = getFileExtension($("#attachImage").val());
        
        $("form[name='uploadImageForm']").ajaxSubmit({
            url: "/editor/uploadImage"
            , dataType: "json"
            , success: function(data) {
                if (data.save) {
                    setData(data.imageUrl, data.fileName, data.fileSize, data.originalUrl, data.thumbUrl);
                } else {
                    alert(data.errorMessages);
                    return false;
                }
            }
            , error: function() {
                alert("사진 업로드를 실패했습니다. 잠시 후 다시 시도해 주세요.");
                return false;
            }
        });
    }

    function setData(imageUrl, fileName, fileSize, originalUrl, thumbUrl) {
        if (typeof(execAttach) == 'undefined') { //Virtual Function
            return;
        }
        var _mockdata = {
            'imageurl': imageUrl
            , 'filename': fileName
            , 'filesize': fileSize
            , 'imagealign': 'C'
            , 'originalurl': originalUrl
            , 'thumburl': thumbUrl
        };
        execAttach(_mockdata);
        closeWindow();
    }

    function initUploader(){
        var _opener = PopupUtil.getOpener();
        if (!_opener) {
            alert('잘못된 경로로 접근하셨습니다.');
            return;
        }
        
        var _attacher = getAttacher('image', _opener);
        registerAction(_attacher);
    }

    function getFileExtension( filePath ) { //파일의 확장자를 가져옴
        var lastIndex = -1;
        var extension = "";

        lastIndex = filePath.lastIndexOf(".");
        if (lastIndex != -1) {
            extension = filePath.substring(lastIndex + 1, filePath.length);
        }
        
        return extension.toLowerCase();
    }

jQuery(function($) {
   $('li#registImage').click(done);

   $('li#closeWindow').click(closeWindow);
});
</script>
</head>
<body onload="initUploader();">
    <div class="wrapper">
        <div class="header">
            <h1>사진 첨부</h1>
        </div>  
        <div class="body">
            <dl class="alert">
                <dt>사진 첨부 확인</dt>
                <dd>
                    등록을 누르시면 사진첨부 됩니다.<br /> 
                </dd>
            </dl>
        </div>
        <div>
            <form name="uploadImageForm" method="post" action="" enctype="multipart/form-data">
                <input type="file" id="attachImage" name="attachImage"/>
            </form>
            <br>
        </div>
        <div class="footer">
            <p><a href="#" onclick="closeWindow();" title="닫기" class="close">닫기</a></p>
            <ul>
                <li class="submit" id="registImage"><a href="javascript://" title="등록" class="btnlink">등록</a> </li>
                <li class="cancel" id="closeWindow"><a href="javascript://" title="취소" class="btnlink"></a></li>
            </ul>
        </div>
    </div>
</body>
</html>