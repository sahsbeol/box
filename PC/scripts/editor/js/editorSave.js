/*-------- 글 등록할 때 필요한 함수들 시작 ----------*/
    var _formName_ = "";
    var _ajaxSubmitYn_ = true;
    
    function saveEditor(formName, ajaxSubmitYn) {
        _formName_ = formName;
        _ajaxSubmitYn_ = ajaxSubmitYn;
        
        if (ajaxSubmitYn && document.forms[formName].elements["tx_content"] != undefined) {
            document.forms[formName].removeChild(document.forms[formName].elements["tx_content"]);
        }
        Editor.save(); /* 이 함수를 호출하여 글을 등록하면 된다. */
    }

    /**
     * Editor.save()를 호출한 경우 데이터가 유효한지 검사하기 위해 부르는 콜백함수로 
     * 상황에 맞게 수정하여 사용한다.
     * 모든 데이터가 유효할 경우에 true를 리턴한다. 
     * @function
     * @param {Object} editor - 에디터에서 넘겨주는 editor 객체
     * @returns {Boolean} 모든 데이터가 유효할 경우에 true
     */
    function validForm(editor) {
        /* 본문 내용이 입력되었는지 검사하는 부분 */
        //var _validator = new Trex.Validator();
        //var _content = editor.getContent();
        //if (!_validator.exists(_content)) {
            //alert('에디터 내용을 입력하세요');
            //return false;
        //}

        return true;
    }

    /**
     * Editor.save()를 호출한 경우 데이터가 유효하면
     * Form Summit을 위해 필드를 생성, 변경하기 위해 부르는 콜백함수로 
     * 상황에 맞게 수정하여 사용한다.
     * 정상적인 경우에 true를 리턴한다. 
     * @function
     * @param {Object} editor - 에디터에서 넘겨주는 editor 객체
     * @returns {Boolean} 정상적인 경우에 true
     */
    function setForm(editor) {
        var _formGen = editor.getForm();

        var _content = editor.getContent();

        _formGen.createField(tx.textarea( {
            /* 본문 내용을 필드를 생성하여 값을 할당하는 부분 */
            'name' : "tx_content",
            'style' : {
                'display' : "none"
            }
        }, _content));

        /* 아래의 코드는 첨부된 데이터를 필드를 생성하여 값을 할당하는 부분으로 상황에 맞게 수정하여 사용한다.
         첨부된 데이터 중에 주어진 종류(image,file..)에 해당하는 것만 배열로 넘겨준다. */
        //var _attachments = editor.getAttachments('image');
        //for ( var i = 0, len = _attachments.length; i < len; i++) {
            /* existStage는 현재 본문에 존재하는지 여부 */
            //if (_attachments[i].existStage) {
                /* data는 팝업에서 execAttach 등을 통해 넘긴 데이터 */
                //alert(_attachments[i].data);
                //_formGen.createField(tx.input( {
                    //'type' : "hidden",
                    //'name' : 'tx_attach_image',
                    //'value' : _attachments[i].data.imageurl
                /* 예에서는 이미지경로만 받아서 사용 */
                //}));
            //}
        //}
        
        if (_ajaxSubmitYn_) { // ajaxSubmit을 사용하는 경우에는 submit 안되게 처리
            return false;
        } else { // 일반 form submit 이면 여기서(에디터에서) submit 실행됨
            return true;
        }
    }
    /*-------- 글 등록할 때 필요한 함수들 끝 ----------*/