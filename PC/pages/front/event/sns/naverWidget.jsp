<script type="text/javascript">
/*<![CDATA[*/
WZDAPI.Data.getXml(
		'http://www.hottracks.co.kr/pages/xml/widget/today.xml'
		, function(xml){
			html = '';
			html += '<strong>[핫트랙스]오늘만특가</strong><br>';
			html += '<strong>' + xml.getElementsByTagName('today')[0].childNodes[0].nodeValue + '</strong><br>';
			html += '<a href="http://www.hottracks.co.kr/ht/hot/eventTodays" target="_hottracks"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/' + xml.getElementsByTagName('imageUrl')[0].childnodes[0].nodeValue + '" width="130" border="0"/></a>';
			html += '<br/>';
			html += '<strong>' + xml.getElementsByTagName('productName')[0].childnodes[0].nodeValue + '</strong>';
			html += '<br/>';
			html += '<font style="text-decoration:line-through">정가 ' + xml.getElementsByTagName('sellPrice')[0].childnodes[0].nodeValue + '원</font>';
			html += '<br/>';
			html += '<font style="color:red;">할인가 ' + xml.getElementsByTagName('orgDiscountPrice')[0].childnodes[0].nodeValue + "원</font>";
			widget.body.innerHTML = html;
	    }
	    , function(){
	        widget.body.innerHTML = '오늘의 특가 상품 정보를 읽어오는데 실패하였습니다.';
	    }
);
/*]]>*/
</script>