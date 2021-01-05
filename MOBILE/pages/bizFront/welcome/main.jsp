<%@ page contentType="text/html;charset=utf-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<!-- 태그 라이브러리 -->
	<%@ include file="/pages/decorators/biz/tagHeader.jsp" %>
	<ui:decorator name="bizWelcome"/>

	<script>
	window.onpageshow = "";
	window.onpagehide="";
		/* gnbMunguGift(문구기프트), gnbRecord(음반), gnbAgit(아지트), gnblife(개인의취향) */
		var urlGnbType = "${gnbType}" != "" ? "${gnbType}" : "gnbMunguGift";
		var agitTypeCd = "${agitTypeCd}" != "" ? "${agitTypeCd}" : "";
		
		var timer;
		var today;
		var todayNew;
		function setDate(){
		    var date = todayNew.getDate();
		    var month = todayNew.getMonth()+1;
		    var newDate = month +""+ date;
		    return newDate;
		}
		
		$(document).ready(function(){		
			sideMenu(); //side menu
			topMenu(); //main tob menu
			
			//url gnbType 탭 활성화(디폴트 문구기프트)
			main.load(urlGnbType);
			
			 /* timer start */
	        today = new Date();
	        todayNew = new Date();
	        Timer();
	        timer = setInterval(Timer, 1000);
			
			$(".ly-main-banner").each(function(){
	             var id = $(this).attr("id").replace("#", "");
	             if(getCookie(id) != ("Y"+setDate())){
	                $(this).show();
	             }
	        });
		});

		var main = {
			 nowTab : ''					/* 활성화 탭	 		*/
			,topMenuSwiper : null			/* 탭메뉴 스와이퍼 		*/			
			,mainBannerSwiper00 : null		/* 컨텐츠영역 스와이퍼 	*/
			,load : function(gnbType){ 		/* 지정 컨텐츠 활성화 	*/
				//선택되어있는 탭이 아닐경우
				if(main.nowTab != gnbType){
					//처음 로드한다면
					var $obj = $("#tabSwiper ." + gnbType);

					if($obj.children().length == 0){
						if($("[name=eof]").val() == "0"){
					        $("#loading").show();
					        $("input[name=eof]").val("1");
					        
					        var url = $("#" + gnbType).attr("data");
					        if(agitTypeCd != ""){
					        	url += "?agitTypeCd=" + agitTypeCd;
					        }
					        
					        $.ajax({
					            type: "GET"
					           ,async:false
					           ,url: url
					           ,dataType: "html"
					           ,success : function(htmlStr){
					        		$obj.append(htmlStr);
					     			$("input[name=eof]").val("0");
					     			
					              	//메인탭스와이퍼 재설정
					              	main.swiperRest();
					              	//탭 클래스 셋팅
					              	main.init(gnbType);
					           }
					           ,error: function(data) {
					               alert('<fmt:message key="error.common.system"/>');
					               $("#loading").hide();
					           }
					       });
					    }
					}else{
						main.init(gnbType);
					}
				}
			}
			,init : function(gnbType){	/* 화면 설정 초기화	*/
				//화면 상단으로 이동
				moveTop();

				//헤더 클래스 초기화
				$("#header").removeClass();
				//바디 클래스 초기화
				$("body").removeClass();
				
				//탭 메뉴 클래스 제거
				$(".top_menu li").removeClass("active");
				//선택된 탭 메뉴 클래스 추가
				$("#"+ gnbType).addClass("active");
		        
				// 아지트에서만 보이는 탑메뉴
		        if(gnbType == 'gnbAgit') {
		        	$('#agit_navi').css('display','block');
		        	if(agitTypeCd != ""){
		        		$('#agit_navi a[data-type='+agitTypeCd+']').parent().addClass("active");
		        	}
		        } else {
		        	$('#agit_navi').css('display','none');
		        }
				
				//푸터 이미지 초기화
				$("#footer .inner .cont a").empty();
				
				//음반메인일떄
				if (gnbType == "gnbRecord") {
					var body = document.body;
					body.classList.add("bg_record");
					
					//푸터이미지 흰색
				    $("#footer .inner .cont a").append('<img src="/images/biz/common/img_award_wh.png" alt="소셜아이어워드 2019">');
				}else{
					//푸터이미지 검은색
				    $("#footer .inner .cont a").append('<img src="/images/biz/common/img_award.png" alt="소셜아이어워드 2019">');
				}
				
				main.nowTab = gnbType;
				
				//선택된 메뉴로 스와이퍼 이등
				main.mainBannerSwiper00.slideTo($(".top_menu li.active").index());
			}
			,swiperRest : function(){
				//스와이퍼가 셋팅되어 있다면
              	if(main.mainBannerSwiper00 != null) {
              		setTimeout(function(){
              			//스와이퍼 재설정
                  		main.mainBannerSwiper00.onResize();
              		}, 500);	
		       	}else{
		       		//스와이퍼 초기화(새로운 페이지 로드시 높이 설정을 다시하기 위해)
			       	main.mainBannerSwiper00 = new Swiper('.content_new.main #content > .swiper-container', {
						slidesPerView: 'auto',
						touchRatio: 0,
						autoHeight: true,
						onSlideChangeStart: function(){
							if($("[name=eof]").val() == "0"){
								$('.top_menu li').eq(main.mainBannerSwiper00.activeIndex).addClass('active').siblings().removeClass('active');
								main.load($('.top_menu li.active').attr("id"));
							}
				        }
				    });
		       		
			       	setTimeout(function(){
              			//스와이퍼 재설정
                  		main.mainBannerSwiper00.onResize();
              		}, 500);	
		       	}  	
			}
		};	

		function Timer(){
		    var now = new Date();
		    var end = new Date();
		    end.setHours(23);
		    end.setMinutes(59);
		    end.setSeconds(59);
		    
		    var H = end.getHours() - now.getHours();
		    var M = end.getMinutes() - now.getMinutes();
		    var S = end.getSeconds() - now.getSeconds();
		    
		    if((now.getDate() - today.getDate()) > 0){
		        //alert("현재 시각 정시 기준으로\n원데이 특가가 업데이트 되었습니다.");
		        location.replace("/m/welcomeMain?"+H+M+S);
		    }
		    $("#txtOddTime").text(lpad(H, 2, '0') + ":" + lpad(M, 2, '0') + ":" + lpad(S, 2, '0'));
		}
	</script>	
</head>

<body>
	<%-- <c:if test="${empty todayBnr || todayBnr eq 'N'}"> --%>
	    <c:forEach items="${listBnrPop}" var="l" varStatus="st">
	        <c:if test="${st.first}">
	            <div id="layerBanner${l.bnrSeq}" class="ly-main-banner" style="display:none;position:fixed;left:0;top:0;width:100%;height:100%;background:url('/images/season01/bg_layer02.png');z-index:999;display:none;">
	                <div style="display: block;margin:20px auto;max-width:290px;position: relative;top:50%;margin-top:-150px;">
	                    <c:choose>
	                        <c:when test="${l.bnrLnkUrl eq '~'}"><ui:image src="${l.bnrImgUrl}" style="width:100%;"/></c:when>
	                        <c:otherwise>
	                            <a href="#" onclick="location.href='${l.bnrLnkUrl}';return false;" style="position:relative;font-size:15px;font-weight:bold;"><ui:image src="${l.bnrImgUrl}" style="width:100%;"/></a>
	                        </c:otherwise>
	                    </c:choose>
	                    <a href="#" onclick="Fn_closeLayer('#layerBanner${l.bnrSeq}', 'Y', setDate());return false;" style="display:block;color:#fff;text-decoration:underline;margin-top:10px;text-align:center;">오늘 하루 그만보기</a>
	                    <a href="#" onclick="Fn_closeLayer('#layerBanner${l.bnrSeq}', 'N', setDate());return false;" style="position: absolute;top: -25px;right: 0;display: block;width: 20px;height: 20px;background: url(/images/season01/btn_close01.png) 50% 50% no-repeat;text-indent: -999px;overflow: hidden;background-size: 31px 31px;">닫기</a>
	                </div>
	            </div>
	        </c:if>
	    </c:forEach>
	<%-- </c:if> --%>

	<input type="hidden" name="eof" value="0"/>
	
	<!-- content -->
	<div id="content">
		<div id="tabSwiper" class="swiper-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide gnbMunguGift">					
					<!-- 문구기프트 -->
				</div>
				<div class="swiper-slide gnbRecord">
					<!-- 음반 -->
				</div>
				<div class="swiper-slide gnbAgit">					
					<!-- 라이프 -->
				</div>
				<div class="swiper-slide gnblife">					
					<!-- 개인의 취향 -->
				</div>				
			</div>
		</div>
	</div>
	<!--// content -->
</body>
</html>