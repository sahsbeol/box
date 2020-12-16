<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="none"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<script type="text/javascript" src="/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/js/json2.js"></script>
<script type="text/javascript" src="/js/form.js"></script>
<script type="text/javascript">

var c = ${cJSON};


function send(){
	var data = $("form[name=testForm]").formData({ debug : true });

	/*
	var data = {
        name1 : $("input[name=name1]").val(), 
        name2 : $("input[name=name2]").val(), 
        name3 : $("input[name=name3]").val(), 
        name4 : $("input[name=name4]").val(), 
        name5 : $("input[name=name5]").val() 
	}
	*/

	$("textarea[name=jsonStr]").val(JSON.stringify(data));
	

    $.ajax({
        async : true, 
        url : "/ht/record/test",
        dataType : "json", 
        type : "post", 
        data : {
    	    prdtName : JSON.stringify(data)
        }, 
        success : function(result, textStatus, XMLHttpRequest){
            if(prepend(result)){
                
            }
        }, 
        error: function(XMLHttpRequest, textStatus, errorThrown){
            alert(errorThrown);
        }
    }); 
	
	
}


$(document).ready(function(){
	//alert(c.page);
});
</script>
</head>
<body>
   ---------------------------------------
   <form name="testForm" action="?" method="post">
        <textarea name="jsonStr" style="width:100%; height:200px;"></textarea><br/>
        
        <input type="text" name="name1" value="바보1" />
        <input type="text" name="name2" value="바보2" />
        <input type="text" name="name3" value="바보3" />
        <input type="text" name="name4" value="바보4" />
        <input type="text" name="name5" value="바보5" />
        
        <input type="button" value="test" onclick="send();"/>
   </form>

</body>
</html>