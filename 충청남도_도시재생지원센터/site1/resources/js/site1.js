$(function(){
	tab.init();
	allcheckbox.init();
	allcheckbox.active();
});


var tab = {

	init:function(){

		$('.tab_list').on('click', 'li', function(){			
			
			var $tab = $(this);
			var i = $tab.index();
			var $contents =	$tab.closest('.tab_wrap');
			var $Layers = $contents.find('.tab_layer');

			// 누르면 실행
			if(!$tab.hasClass('is_active')){

				$tab.siblings().removeClass('is_active');
				$tab.addClass('is_active');
				$Layers.removeClass('is_active');
		    	$($Layers[i]).addClass('is_active');				
			}	
		});
	}
}

var allcheckbox = {

	init:function(){

		// input id값 설정 안함 	
		var chkCommons = $('.chk_common');

		chkCommons.each(function(i){

			var chkCommon = $(chkCommons[i]);

				chkInput = chkCommon.find('input');
				chkLabel = chkInput.siblings('label');

				chkIndex = chkInput.attr('id','checkbox'+ i);
				chklabelIndex = chkLabel.attr('for','checkbox'+ i);			

		});	
		
	},

	active :function(){
		// not label but inputbox 
		$all = $('.all input');
		$all.on('click', function(){
			if($all.prop("checked")){
				$('input').prop("checked",true);
			}else{
				$('input').prop("checked",false);
			}
		});
	}
}