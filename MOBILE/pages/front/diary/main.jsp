<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn"%>
<ui:decorator name="diary" />
<html>
<head>
<c:set value="222" var="temp" />
<link rel="stylesheet" type="text/css" href="/css/hdiary.css?${temp }">
<title>다이어리 메인 - NEW ME HOTTRACKS</title>
<script type="text/javascript">

	jQuery(function($) {
		$(document).ready(function() {
			
			today = new Date();
		    todayNew = new Date();
		    Timer();
		    timer = setInterval(Timer, 1000);
			
		    new Swiper('.diary_wrap .visual .swiper-container', {
		        speed: 1000,
		        loop: true,
		        autoplay: 3000,
		        autoplayDisableOnInteraction: false,
		        scrollbar: '.swiper-scrollbar'
		        })
		    new Swiper('.diary_wrap .bestevent_a .swiper-container', {
		        speed: 1000,
		        loop: true,
		        autoplay: 3000,
		        autoplayDisableOnInteraction: false,
		        scrollbar: '.swiper-scrollbar'
		        })
		      var f = (function(){
		          var startPos = window.scrollY;
		          function hamsoo(e){
		              var endPos = window.scrollY;
		              if(startPos < endPos && startPos > 10){
		                  $('#app_bar.confirm').addClass('active');
		              } else{
		                $('#app_bar.confirm').removeClass('active');
		              } startPos = endPos;
		          } return hamsoo;
		      })();
		      window.addEventListener('scroll', f);
			  $(window).scroll(function(){
		          var sct =$(window).scrollTop()
		          var winY = sct + $(window).height()
		          var sectionSpot = []
		          var slideSpot = $('.diary_wrap .visual').offset().top

		          if(sct >= slideSpot){
		              $('.diary_wrap .spot-wrap').addClass('active')
		          } else if( sct < slideSpot ){
		              $('.diary_wrap .spot-wrap').removeClass('active')
		          }
		          if(winY >= $('#footer').offset().top && !$('.diaryevent_a').is('active')){
		              $('.diaryevent_a').addClass('active')
		          } else if(winY < $('#footer').offset().top && $('.diaryevent_a').is('active')){
		              $('.diaryevent_a').removeClass('active')
		          }
		          //   2020.09.22 김지우 커밋 끝

		          $('.tit_today_box').each(function(i,e){
		                sectionSpot.push($(e).offset().top)
		                if(winY > sectionSpot[i] && !$(e).is('.on')){
		                    $(e).addClass('on')
		                } else if(winY < sectionSpot[i] && $(e).is('.on')){
		                    $(e).removeClass('on')
		                }
		            }) 
				  if(sct >= 50){
					  $('.float-wrap').addClass('active')
					  if($('.float-wrap').is('active')){
						  setTimeout(() => {
							$('.float-wrap').removeClass('active')
						  }, 2500);
					  }
				  } else if(sct < 50) $('.float-wrap').removeClass('active')
		      })
		      $('.diary_wrap .diary-title span:nth-child(3), .diary_wrap .spot-wrap span:nth-child(1)').click(function(){
		        var recoTop = $('.today_box').offset().top - 50
		        $('html,body').animate({scrollTop: recoTop},700)
		      })
		      $('.diary_wrap .diary-title span:nth-child(4), .diary_wrap .spot-wrap span:nth-child(2)').click(function(){
		        var filterTop = $('.diarycloud_a').offset().top - 50
		        $('html,body').animate({scrollTop: filterTop},700)
		      })
		      $('.today_box .btn_more_a').click(function(){
		          var realtimeTop = $('.today_box').offset().top - 50
		            if(!$(this).is('.active')){
		                $(this).addClass('active')
		                $('.today_box li:nth-child(n+11)').slideDown()
		            } else if($(this).is('.active')){
		                $(this).removeClass('active')
		                $('.today_box li:nth-child(n+11)').slideUp()
		            }
		            $('html,body').animate({scrollTop: realtimeTop},700)
		        })
		      $('.diarycloud .btn_more_a').click(function(){
		        var filterTop = $('.diarycloud_a').offset().top - 50
		            if(!$(this).is('.active')){
		                $(this).addClass('active')
		                $('#diaryCloudList li:nth-child(n+9)').slideDown()
		                $('#diaryCloudList li:nth-child(n+35)').remove()
		            } else if($(this).is('.active')){
		                $(this).removeClass('active')
		                $('#diaryCloudList li:nth-child(n+9)').slideUp()
		                $('#diaryCloudList li:nth-child(n+35)').remove()
		            }
		            $('html,body').animate({scrollTop: filterTop},700)
		        })
		      //   2020.09.16 김지우 커밋 끝
			
			$("#2017DIARY").addClass("active");

			$('#recobellMenu li').click(function() {
				$('#recobellMenu li').removeClass("on");
				$(this).addClass("on");
				$('#recobellMore').find("a").removeClass("off");
				$('#recobell_recType').val($(this).attr("recType"));
				$fn.getRecobellList();
				$('#recobellMore').removeClass('active');
			});
			$('#recobellMore').click(function() {
				$('#recobellList li').show();
				$('#recobellBrandList li').show();
				$('#recobellMore').find("a").addClass("off");
			});
// 			$('#diaryMore').click(function() {
// 				$('#diary_curPage').val(Number($('#diary_curPage').val()) + 1);
// 				$fn.getDiaryListMore();
// 			});
			$('#eventMore').click(function() {
				$('#event_curPage').val(Number($('#event_curPage').val()) + 1);
				$fn.getEventList();
			});
			$('#diaryCategory_top li').click(function() {
				$('#diaryCategory_top li').removeClass("on");
				$('#diaryCategory li').removeClass("on");
				$(this).addClass("on");
				$('#diary_ctgrNum').val($(this).attr("ctgrNum"));
				$('#diary_curPage').val("1");

				$fn.getDiaryList();
				$('#diaryMore').removeClass("active");
			});
			$('#diaryCategory li').click(function() {
				$('#diaryCategory_top li').removeClass("on");
				$('#diaryCategory li').removeClass("on");
				$(this).addClass("on");
				$('#diary_ctgrNum').val($(this).attr("ctgrNum"));
				$('#diary_curPage').val("1");

				$fn.getDiaryList();
				$('#diaryMore').removeClass("active");
			});
			$('#diarySort li').click(function() {
				$('#diarySort li').removeClass("on");
				$(this).addClass("on");
				$('#diary_sortNum').val($(this).attr("sortNum"));
				$('#diary_curPage').val("1");

				$fn.getDiaryList();
				$('#diaryMore').removeClass("active");
			});

			$(document).on("click", "#recobellBrandList li dl", function() {
				$('#recobellBrandList li dl').removeClass("on");
				$('#recobellMore').find("a").removeClass("off");
				$('#recobell_brandId').val($(this).attr("brandId"));

				$fn.getRecobellList();
			});

			$fn.init();
		});

		$fn = {
			init : function() {
				$fn.setRecobellBrand();
				$fn.getRecobellList();
				$fn.getDiaryList();
				$fn.getEventList();
			},
			setRecobellBrand : function() {
				var brandList = [ {
					brandName : "건망증",
					brandId : "10014"
				}, {
					brandName : "공장",
					brandId : "10793"
				}, {
					brandName : "대쉬앤도트",
					brandId : "10856"
				}, {
					brandName : "데일리라이크",
					brandId : "91615"
				}, {
					brandName : "라이브워크",
					brandId : "10019"
				}, {
					brandName : "루카랩",
					brandId : "24663"
				}, {
					brandName : "리훈",
					brandId : "21916"
				}, {
					brandName : "모노폴리",
					brandId : "10001"
				}, {
					brandName : "모닝글로리",
					brandId : "22055"
				}, {
					brandName : "모트모트",
					brandId : "27946"
				}, {
					brandName : "미도리",
					brandId : "10545"
				}, {
					brandName : "바이.풀디자인",
					brandId : "10003"
				}, {
					brandName : "비온뒤",
					brandId : "91711"
				}, {
					brandName : "세컨드맨션",
					brandId : "15193"
				}, {
					brandName : "아르디움",
					brandId : "12446"
				}, {
					brandName : "아이씨엘",
					brandId : "24180"
				}, {
					brandName : "아이코닉",
					brandId : "10002"
				}, {
					brandName : "워너디스",
					brandId : "14172"
				}, {
					brandName : "이든디자인",
					brandId : "10018"
				}, {
					brandName : "인디고",
					brandId : "10623"
				}, {
					brandName : "인바이트엘",
					brandId : "10575"
				}, {
					brandName : "칠삼이일 디자인",
					brandId : "91870"
				}, {
					brandName : "투영디자인",
					brandId : "10573"
				}, {
					brandName : "퍼니디",
					brandId : "21501"
				}, {
					brandName : "페이퍼리안",
					brandId : "24577"
				}, {
					brandName : "플라잉 웨일즈",
					brandId : "24807"
				}, {
					brandName : "플레플레",
					brandId : "10755"
				}, {
					brandName : "플레픽",
					brandId : "91853"
				}, {
					brandName : "핑크풋",
					brandId : "25831"
				} ];

				shuffle(brandList);

				brand = '<li>';
				for ( var i = 0; i < 5; i++) {
					if (i == 0)
						$('#recobell_brandId').val(brandList[i].brandId);

					brand += '<dl brandId="'+brandList[i].brandId+'" '+brandList[i].brandId+'><a href="#" onclick="javacript:event.preventDefault();">'
							+ brandList[i].brandName + '</a></dl>';
				}
				brand += '</li>';
			},
			getRecobellList : function() {
				$
						.ajax({
							url : "/m/diary/getRecobellList",
							data : $fn.setRecobellParams(),
							type : "POST",
							dataType : "json",
							success : function(data) {
								var append = "";
								var rcCode = "";
								var recType = $('#recobell_recType').val();
								var brandId = $('#recobell_brandId').val();

								$('#recobellList').empty();
								$('#recobellBrandList').empty();

								switch (recType) {
								case 'p001':
									rcCode = "?foo=bar&rccode=mo_d_person";
									break;
								case 'b004':
									rcCode = "?foo=bar&rccode=mo_d_brand";
									break;
								case 'm002':
									rcCode = "?foo=bar&rccode=mo_d_click";
									break;
								case 'm012':
									rcCode = "?foo=bar&rccode=mo_d_cart";
									break;
								}

								if (data) {
									if (!isEmpty(data)) {
										var target;
										var list = data.recobellList;
										var basicLength = 10;
										var totalLength = 18;

										if (recType == 'b004') {
											append += brand;
											basicLength = basicLength - 1;
											totalLength = totalLength - 1;
											target = $('#recobellBrandList');
											$('#recobellList').hide();
										} else {
											target = $('#recobellList');
											$('#recobellList').show();
										}

										for ( var i = 0; i < (list.length < totalLength ? list.length
												: totalLength); i++) {
											if (i < basicLength) {
												append += '	<li>';
											} else {
												append += '	<li style="display:none;">';
											}
// 											if (recType != "p001") {
// 												if (i < 3) {
// 													append += '		<span class="ic_tagnum">'
// 															+ (i + 1)
// 															+ '</span>';
// 												} else {
// 													append += '		<span class="ic_tagnum gray">'
// 															+ (i + 1)
// 															+ '</span>';
// 												}
// 											}
											append += '		<span class="img">';
											if (list[i].sellPrdtGbn == 'R'
													|| list[i].sellPrdtGbn == 'D') {
												append += '			<a href="/p/'+list[i].sellPrdtBcode+rcCode+'"><img src="http://image.kyobobook.co.kr/newimages/music/midi/'
														+ list[i].rcrdCd
																.substring(1, 5)
																.split("")
																.reverse()
																.join("")
														+ '/'
														+ list[i].rcrdCd
														+ '.jpg" alt="'
														+ list[i].prdtName
														+ '" class="photo" width="200" height="200" ></a>';
											} else {
												append += '			<a href="/p/'+list[i].sellPrdtBcode+rcCode+'"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';"></a>';
											}
											append += '		</span>';
											append += '		<a href="/p/'+list[i].sellPrdtBcode+rcCode+'">';
											append += '		<span class="make txt_line1">'
													+ list[i].brandEngName
													+ '</span>';
											append += '			<span class="name">'
													+ list[i].prdtName
													+ '</span>';
											append += '				<span class="price">';
											append += '					<span class="sale">'
													+ price_format(list[i].lastCpnPrice)
													+ '</span>';
											if (list[i].lastDcRate != 0) {
												append += '					<span class="pc">'
														+ list[i].lastDcRate
														+ '%</span>';
											}
											append += '			</span>';
											append += '			<span class="icon">  ';
											if (list[i].reviewCount != 0 || list[i].wishPrdtCnt != 0){
// 											if (list[i].reviewCount != 0) {
												append += '		    <span class="ico_review">'
														+ list[i].reviewCount
														+ '</span>';
// 											}
// 											if (list[i].reviewCount != 0) {
												append += '		    <span class="ico_like on">'
														+ list[i].wishPrdtCnt
														+ '</span>';
// 											}
											}
											append += '			</span>';
											append += '		</a>';
											append += '	</li>';
										}

										target.html(append);
										//recobellMore.hide();
										if (recType == 'b004') {
											$(
													'#recobellBrandList li dl[brandid='
															+ brandId + ']')
													.addClass('on');
										}
									}
								}
							},
							error : function(request, status, error) {
								if (request.status != 0) {
									alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
								}
							}
						});
			},
			setRecobellParams : function() {
				var params = {};
				var recType = $('#recobell_recType').val();
				var brandId = $('#recobell_brandId').val();

				params.recType = recType;
				if (recType = "b004") {
					params.brandId = brandId;
				}

				return params;
			},
			getDiaryList : function() {
				$("#loadingBar").show();
				$
						.ajax({
							url : "/m/diary/getDiaryList",
							data : $fn.setDiaryListParams(),
							type : "POST",
							dataType : "json",
							success : function(data) {
								var append_top = "";
								var append = "";

								$('#diaryCloudList_top').empty();
								$('#diaryCloudList').empty();

								if (data) {
									if (!isEmpty(data)) {
										var list = data.diaryList;

										for ( var i in list) {
											if (list[i].dispSeq == 1) {
												append_top += '	<li>';
												append_top += '		<span class="ic_tagnum">'
// 														+ list[i].dispSeq
														+ '</span>';
												append_top += '		<span class="img">';
												append_top += '			<a href="/p/'+list[i].sellPrdtBcode+'"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';"></a>';
												append_top += '			<span class="make txt_rotate">'
														+ list[i].brandEngName
														+ '</span>';
												append_top += '		</span>';
												append_top += '		<a class="wd100" href="/p/'+list[i].sellPrdtBcode+'">';
												append_top += '			<span class="name">'
														+ list[i].prdtName
														+ '</span>';
												append_top += '			<span class="price">';
												append_top += '				<span class="sale">'
														+ price_format(list[i].lastCpnPrice)
														+ '</span>';
												if (list[i].lastDcRate != 0) {
													append_top += '				<span class="pc">'
															+ list[i].lastDcRate
															+ '%</span>';
												}
												append_top += '			</span>';
												append_top += '			<span class="icon">  ';
												if (list[i].reviewCount != 0 || list[i].wishPrdtCnt != 0){
// 												if (list[i].reviewCount != 0) {
												append_top += '		    <div class="icon_line"><span class="ico_review">'
														+ list[i].reviewCount
														+ '</span></div>';
// 												}
// 												if (list[i].wishPrdtCnt != 0) {
												append_top += '		    <div class="icon_line no_line"><span class="ico_like on">'
														+ list[i].wishPrdtCnt
														+ '</span></div>';
// 												}
												}
												append_top += '			</span>';
												append_top += '		</a>';
												append_top += '	</li>';
											} else {
												append += '	<li>';
												if (list[i].dispSeq <= 3) {
													append += '		<span class="ic_tagnum">'
															+ list[i].dispSeq
															+ '</span>';
												} else {
													append += '		<span class="ic_tagnum gray">'
															+ list[i].dispSeq
															+ '</span>';
												}
												append += '		<span class="img">';
												append += '			<a href="/p/'+list[i].sellPrdtBcode+'"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';"></a>';
												append += '		</span>';
												append += '		<a href="/p/'+list[i].sellPrdtBcode+'">';
												append += '		<span class="make txt_line1">'
														+ list[i].brandEngName
														+ '</span>';
												append += '			<span class="name">'
														+ list[i].prdtName
														+ '</span>';
												append += '				<span class="price">';
												append += '					<span class="sale">'
														+ price_format(list[i].lastCpnPrice)
														+ '</span>';
												if (list[i].lastDcRate != 0) {
													append += '					<span class="pc">'
															+ list[i].lastDcRate
															+ '%</span>';
												}
												append += '			</span>';
												append += '			<span class="icon">  ';
												if (list[i].reviewCount != 0 || list[i].wishPrdtCnt != 0){
// 												if (list[i].reviewCount != 0) {
													append += '		    <span class="ico_review">'
															+ list[i].reviewCount
															+ '</span>';
// 												}
// 												if (list[i].reviewCount != 0) {
													append += '		    <span class="ico_like on">'
															+ list[i].wishPrdtCnt
															+ '</span>';
// 												}
												}
												append += '			</span>';
												append += '		</a>';
												append += '	</li>';
											}
										}

										$('#diaryCloudList_top').html(
												append_top);
										$('#diaryCloudList').html(append);
										
										if (list.length < 10) {
											$('#diaryMore').show();
										}

									}
								}
							},
							error : function(request, status, error) {
								if (request.status != 0) {
									alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
								}
							},
							complete : function() {
								$("#loadingBar").hide();
								
							}
						});
			},
			getDiaryListMore : function() {
				$("#loadingBar").show();
				$
						.ajax({
							url : "/m/diary/getDiaryListMore",
							data : $fn.setDiaryListParams(),
							type : "POST",
							dataType : "json",
							success : function(data) {
								var append = "";

								if (data) {
									if (!isEmpty(data)) {
										var list = data.diaryList;

										for ( var i in list) {
											append += '	<li>';
											if (list[i].dispSeq <= 3) {
												append += '		<span class="ic_tagnum">'
														+ list[i].dispSeq
														+ '</span>';
											} else {
												append += '		<span class="ic_tagnum gray">'
														+ list[i].dispSeq
														+ '</span>';
											}
											append += '		<span class="img">';
											append += '			<a href="/p/'+list[i].sellPrdtBcode+'"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/goods/400/'+list[i].productImageUrl+'" alt="'+list[i].prdtName+'" class="photo" width="200" height="200" onerror="this.src=\'http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/no_image2.gif\';"></a>';
											append += '		</span>';
											append += '		<a href="/p/'+list[i].sellPrdtBcode+'">';
											append += '		<span class="make txt_line1">'
													+ list[i].brandEngName
													+ '</span>';
											append += '			<span class="name">'
													+ list[i].prdtName
													+ '</span>';
											append += '				<span class="price">';
											append += '					<span class="sale">'
													+ price_format(list[i].lastCpnPrice)
													+ '</span>';
											if (list[i].lastDcRate != 0) {
												append += '					<span class="pc">'
														+ list[i].lastDcRate
														+ '%</span>';
											}
											append += '			</span>';
											append += '			<span class="icon">  ';
											if (list[i].reviewCount != 0 || list[i].wishPrdtCnt != 0){
// 											if (list[i].reviewCount != 0) {
												append += '		    <span class="ico_review">'
														+ list[i].reviewCount
														+ '</span>';
// 											}
// 											if (list[i].wishPrdtCnt != 0) {
												append += '		    <span class="ico_like on">'
														+ list[i].wishPrdtCnt
														+ '</span>';
// 											}
											}
											append += '			</span>';
											append += '		</a>';
											append += '	</li>';
										}

										$('#diaryCloudList').append(append);

// 										if (list.length < 36 && list.length > 8) {
// 											$('#diaryMore').hide();
// 										}
									}
								}
							},
							error : function(request, status, error) {
								if (request.status != 0) {
									alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
								}
							},
							complete : function() {
								$("#loadingBar").hide();
							}
						});
			},
			setDiaryListParams : function() {
				var params = {};

				var ctgrNum = $('#diary_ctgrNum').val();
				var sortNum = $('#diary_sortNum').val();
				var curPage = $('#diary_curPage').val();

				//카테고리 분류
				switch (ctgrNum) {
				case '1':
					//심플
// 					params.ctgrNum = '000020001100,000020000000,000020001102,000020000004,00000725,00002004';
					params.ctgrNum = '000020001100,000020000000,000020040005,000020041200';
					break;
				case '2':
					//일러스트
// 					params.ctgrNum = '000020001101,000020000003';
					params.ctgrNum = '000020001101,000020000003';
					break;
				case '3':
					//날짜형
// 					params.ctgrNum = '000020001100,000020001101,000020001102,000020001103,0000200010,000020040005,0000072500,0000072501,0000072502';
					params.ctgrNum = '000020040005,000020041200,000020001100,000020001101,000020001102,000020001105';
					break;
				case '4':
					//만년형
// 					params.ctgrNum = '000020000000,000020000004,000020000003,000020040001,000020040002,000020040006';
					params.ctgrNum = '000020000000,000020000004,000020000003,000020000006';
					break;
				case '5':
					//6공
// 					params.ctgrNum = '000020000006,000020001105,0000200007';
					params.ctgrNum = '000020001105,000020000006,000020040201,000020040202';
					break;
				case '6':
					//스케줄러
// 					params.ctgrNum = '0000200010,0000200002,0000200003';
					params.ctgrNum = '0000200010,0000200002,0000200003';
					break;
				case '7':
					//캘린더
// 					params.ctgrNum = '0000201100,0000201101,0000201102,0000201103,0000201104,0000201105,0000201106,0000201107,0000201108,0000201109,0000201110';
					params.ctgrNum = '0000201110,0000201100,0000201101';
					break;
				default:
					//전체
					params.ctgrNum = '000020001100,000020000000,000020040005,000020041200,000020001101,000020000003,000020040005,000020041200,000020001100,000020001101,000020001102,000020001105,000020000000,000020000004,000020000003,000020000006,000020001105,000020000006,000020040201,000020040202,0000200010,0000200002,0000200003,0000201110,0000201100,0000201101';
					break;
				}

				//정렬
				params.sortNum = sortNum;
				params.curPage = curPage;

				return params;
			},
			getEventList : function() {
				$
						.ajax({
							url : "/m/diary/getEventList",
							data : {
								page : $('#event_curPage').val()
							},
							type : "POST",
							dataType : "json",
							success : function(data) {
								var append = "";

								if (data) {
									if (!isEmpty(data)) {
										var list = data.eventList;

										for ( var i in list) {
											append += '<li> ';
											append += '	<a href="/e/'+list[i].eventId+'"> ';
											append += '	<div class="img-wrap">';
											append += '		<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/'+list[i].imageUrl+'" alt="일상의 시그니처가 되다." onerror="this.src=\'http://image.kyobobook.co.kr/images/no_image.gif\';">';
											append += '	</div> ';
											append += '	<div class="text-wrap"> '
											if (!isEmpty(list[i].dispDscntRate)) {
											append += ' <em class="discount">'
													+ list[i].dispDscntRate
													+ '%'
											append += '	</em>';
											}
											append += '  	<strong class="item-title">'
													+ list[i].eventTitle
													+ '</strong> ';
											append += '  	<p class="description">'
													+ list[i].eventDtlCont
													+ '</p> ';
											if (list[i].eventRangeInfo != null) {
												append += '	<span class="during-date">'
														+ list[i].eventRangeInfo
														+ '</span> ';
											} else if (list[i].eventEndDt == '99991231'
													|| list[i].eventEndDt == '99999999') {
												append += '	<span class="during-date">'
														+ _formatDateByString(
																list[i].eventStartDt,
																"yyyy.MM.dd")
														+ ' ~ </span> ';
											} else {
												append += '	<span class="during-date">'
														+ _formatDateByString(
																list[i].eventStartDt,
																"yyyy.MM.dd")
														+ ' ~ '
														+ _formatDateByString(
																list[i].eventEndDt,
																"yyyy.MM.dd")
														+ '</span> ';
											}
											append += '	</div> ';
											append += '	</a> ';
											append += '</li>';
										}

										$('#diaryEventList').append(append);

// 										if (list.length < 4) {
// 											$('#eventMore').hide();
// 										}
									}
								}
							},
							error : function(request, status, error) {
								if (request.status != 0) {
									alert('서비스 수행도중 오류가 발생하였습니다. 잠시후 다시 이용해주세요.\n(※ 지속적으로 오류가 나는 경우 고객센터에 문의바랍니다.)');
								}
							}
						});
			}
		};

		function shuffle(a) {
			var j, x, i;
			for (i = a.length; i; i -= 1) {
				j = Math.floor(Math.random() * i);
				x = a[i - 1];
				a[i - 1] = a[j];
				a[j] = x;
			}
		}
		
		var timer;
		var today;
		var todayNew;
		function setDate(){
		    var date = todayNew.getDate();
		    var month = todayNew.getMonth()+1;
		    var newDate = month +""+ date;
		    return newDate;
		}

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
		    $("#timeHour").text(lpad(H, 2, '0'));
		    $("#timeMin").text(lpad(M, 2, '0'));
		    $("#timeSec").text(lpad(S, 2, '0'));
		}

		// 메인 슬라이드
		var mySwiper = new Swiper(".swipe-main .swiper-container", {
			pagination : '.swipe-main div.pagination',
			loop : true,
			grabCursor : true,
			paginationClickable : true,
			/* centeredSlides: true, */
			autoplay : 3000,
			autoplayDisableOnInteraction : false
		});

		// 이벤트 슬라이드
		var mySwiper = new Swiper(".event-swipe-main .event-swiper-container",
				{
					pagination : '.event-swipe-main div.pagination',
					loop : true,
					grabCursor : true,
					paginationClickable : true,
					/* centeredSlides: true, */
					autoplay : 3000,
					autoplayDisableOnInteraction : false
				});
		
	});
</script>
<style>
.diary_wrap {
	margin-top: 50px;
}
</style>
</head>
<body>
	<input type="hidden" id="diary_ctgrNum" value="0">
	<input type="hidden" id="diary_sortNum" value="0">
	<input type="hidden" id="diary_curPage" value="1">
	<input type="hidden" id="recobell_recType" value="p001">
	<input type="hidden" id="recobell_brandId" value="">
	<input type="hidden" id="event_curPage" value="1">

	<div class="diary_wrap">
		<!-- 	<div class="tit_img"><img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/m/tit_img.png"/></div> -->
		<div class="spot-wrap">
	        <span><img src="../../images/biz/diary/ic-realtime.png">실시간 추천</span>
	        <span><img src="../../images/biz/diary/ic-filter.png">다이어리 필터</span>
    	</div>
		<div class="diary-title">
			<p>매일매일나의이야기</p>
			<h2>2021 DIARY</h2>
			<span><img src="/images/biz/diary/ic-realtime.png">실시간 추천</span> 
			<span><img src="/images/biz/diary/ic-filter.png">다이어리 필터</span>
		</div>
		<!-- 메인 슬라이드 -->
		<div class="visual swipe-main">
			<div class="swiper-container">
				<ul class="swiper-wrapper">
					<c:forEach items="${list1St}" var="l" varStatus="st" end="7">
						<li class="swiper-slide "><a href="${l.bnrLnkUrl}"> <img
								src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.bnrImgUrl}"
								alt="${l.bnrImgAlt}" />
								<div class="div_bnr">
									<div class="bnrTitle">
										${l.bnrTitle }<span class="bnrSubTitle">${l.bnrImgAlt }</span>
									</div>
								</div>
								<div class="bnrImgAlt">${l.bnrSubTitle }</div> </a></li>
					</c:forEach>
				</ul>
				<div class="swiper-scrollbar"></div>
			</div>
			<!-- 	    <div class="pagination"></div> -->
		</div>
		<!-- 오늘만 1+1증정 -->
		<c:if test="${not empty hotdeal}">
		<div class="plus-stuff" onclick="location.href='/e/${hotdeal.eventId}'">
			<div class="plus-title">
				<strong>오늘만 1+1증정</strong>
			</div>
			<div class="img-wrap">
				<ui:image src="${hotdeal.productImageUrl}" server="product" alt="${hotdeal.prdtName}"/>
			</div>
			<div class="time-count-wrap">
<!-- 			<strong class="font_t time" id="txtOddTime"></strong> -->
				<div>
					<b class="font_t time" id="timeHour"></b><strong>HOUR</strong>
				</div>
				<div>
					<b class="font_t time" id="timeMin"></b><strong>MIN</strong>
				</div>
				<div>
					<b class="font_t time" id="timeSec"></b><strong>SEC</strong>
				</div>
			</div>
			<div class="free-ship">
				<c:if test = "${hotdeal.freeDlvyYn eq 'Y'}">
					<img src="/images/biz/diary/ic-freeship.png"><b>무료배송</b>
				</c:if>
			</div>
			<div class="plus-text">
				<p class="plus-title">${hotdeal.prdtName}</p>
				
<%-- 				<c:if test="${not empty hotdeal.prdtDscntRate and hotdeal.prdtDscntRate ne '0'}"> --%>
					<c:if test="${hotdeal.prdtDscntRate ne '0'}">
					<b class="discount-pay"><fmt:formatNumber type="number" value="${hotdeal.prdtSellPrice}"/></b>
					</c:if>
					<b class="sale-pay"><fmt:formatNumber type="number" value="${hotdeal.lastCpnPrice}"/></b>
<%-- 							<em class="discount"><fmt:formatNumber type="number" value="${hotdeal.prdtSellPrice}"/></em> --%>
<%-- 							<fmt:formatNumber type="number" value="${hotdeal.lastCpnPrice}"/>			 --%>
<%-- 				</c:if> --%>
<%-- 						<fmt:formatNumber type="number" value="${price}"/> --%>
			</div>
		</div>
		</c:if>

		<!-- 선착순 사은품 -->
		<div class="cgift">
		    <div class="gift-title">
		        <strong>GIFT EVENT</strong>
		    </div>
			<a href="/e/70114">
		    	<img src="/images/biz/diary/m_사은품배너_수정1.jpg"/>
		    </a>
		</div>

		<!-- 오늘의 추천 -->
		<div class="today_box clear">
			<div class="tit_today_box">
		        <span class="txtline_name">실시간 추천</span>
		        <p>당신만을 위한</p>
		    </div>
			<ul class="today_a" id="recobellMenu">
				<li class="ic_today on" recType="p001"><img />
					<p>
						맞춤추천순
					</p></li>
<!-- 				<li class="ic_bbest" recType="b004"><img /> -->
<!-- 					<p> -->
<!-- 						인기브랜드<br />베스트 -->
<!-- 					</p></li> -->
				<li class="ic_cbest" recType="m002"><img />
					<p>
						인기순
					</p></li>
				<li class="ic_cartbest" recType="m012"><img />
					<p>
						장바구니인기
					</p></li>
			</ul>

			<div class="prod_list_normal clear">
				<!-- 이건 어때요 -->
				<div class="pannel1">
					<ul class="tlist_a" id="recobellList">
					</ul>
				</div>
				<!-- / 이건 어때요 -->

				<!-- 인기브랜드 베스트 -->
				<div class="pannel2">
					<ul class="tlist_a" id="recobellBrandList">
					</ul>
				</div>
				<!-- / 인기브랜드 베스트 -->

				<div class="btn_more_a" id="recobellMore">
					<a href="#" onclick="javacript:event.preventDefault();">
<!-- 					<img class="btn_more" -->
<!-- 						src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/m/btn_more.png" /> -->
					</a>
				</div>
			</div>
		</div>

		<!-- 많이 보고 있는 이벤트  -->
		<div class="bestevent_a">
			<div class="bestevent">
				<div class="tit_today_box">
		            <span class="txtline_name">많이 보고 있는 이벤트</span>
		            <p>인기 급상승</p>
		        </div>
		        <c:if test="${not empty listBestEvent}">
			    <div class="swiper-container">
            		<ul class="swiper-wrapper">    
			        	<c:forEach items="${listBestEvent}" var="l" varStatus="st" end="10">
							<li class="swiper-slide "> 
								<a href="/e/${l.eventId}">
									<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.imageUrl}" alt="${l.eventTitle}" />
									<div class="div_bnr">
											<div class="bnrTitle">
											<c:choose>
											<c:when test="${fn:length(l.eventTitle) > 18}">
												${fn:substring(l.eventTitle,0,18)}..
											</c:when>
											<c:otherwise>
												${l.eventTitle}
											</c:otherwise>
										</c:choose>
											</div>
									</div> 
									<div class="bnrImgAlt">${l.eventDtlCont} 
										<c:if test="${not empty l.dispDscntRate}">
										<span class="bnrSubTitle">~${l.dispDscntRate}%</span>
										</c:if>
									</div>
								</a>
							</li>
						</c:forEach>
					</ul>
			        <div class="swiper-scrollbar"></div>
			        
			        
					<!-- 이벤트 슬라이드 -->
<!-- 					<div class="visual event-swipe-main"> -->
<!-- 						<div class="event-swiper-container"> -->
<!-- 							<ul class="swiper-wrapper"> -->
<%-- 								<c:forEach items="${listBestEvent}" var="l" varStatus="st" --%>
<!-- 									end="10"> -->
<%-- 									<li class="swiper-slide "><a href="/e/${l.eventId}"> --%>
<!-- 											<img -->
<%-- 											src="http://image.kyobobook.co.kr/newimages/giftshop_new/work/${l.imageUrl}" --%>
<%-- 											alt="${l.eventTitle}" /> --%>
<!-- 											<div class="div_bnr"> -->
<%-- 												<div class="bnrTitle">${l.eventTitle }</div> --%>
<%-- 												<div class="bnrImgAlt">${l.eventDtlCont }</div> --%>
<!-- 											</div> </a></li> -->
<%-- 								</c:forEach> --%>
<!-- 							</ul> -->
<!-- 						</div> -->
<!-- 						<div class="pagination"></div> -->
<!-- 					</div> -->


				</div>
				</c:if>
			</div>
		</div>

		<!-- 다이어리 클라우드 -->
		<div class="diarycloud_a">
			<div class="diarycloud">
				<div class="tit_today_box">
		            <span class="txtline_name">다이어리 필터</span>
		            <p>내가 찾던 다이어리</p>
		        </div>
				<!-- 전체보기 고정  -->
				<ul class="diarycloud_tab fix" id="diaryCategory_top">
					<li class="diaryc00 btn on" ctgrNum="0">
					<a href="#" onclick="javacript:event.preventDefault();"> 
<!-- 					<img src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/btn_diaryc00.png" /> -->
							<span>ALL</span>
							<p>전체</p> 
					</a>
					</li>
				</ul>
				<div class="diarycloud_tab_a">
					<ul class="diarycloud_tab" id="diaryCategory">
						<li class="diaryc01 btn" ctgrNum="1">
							<a href="#" onclick="javacript:event.preventDefault();">
								<img src="/images/biz/diary/filter-img1.png"/>
								<p>심플</p>
							</a>
						</li>
						<li class="diaryc02 btn" ctgrNum="2">
							<a href="#" onclick="javacript:event.preventDefault();">
								<img src="/images/biz/diary/filter-img2.png"/>
								<p>일러스트</p>
							</a>
						</li>
						<li class="diaryc03 btn" ctgrNum="3">
							<a href="#" onclick="javacript:event.preventDefault();">
								<img src="/images/biz/diary/filter-img3.png"/>
								<p>날짜형</p>
							</a>
						</li>
						<li class="diaryc04 btn" ctgrNum="4">
							<a href="#" onclick="javacript:event.preventDefault();">
								<img src="/images/biz/diary/filter-img4.png"/>
								<p>만년형</p>
							</a>
						</li>
						<li class="diaryc05 btn" ctgrNum="5">
							<a href="#" onclick="javacript:event.preventDefault();">
								<img src="/images/biz/diary/filter-img5.png"/>
								<p>6공</p>
							</a>
						</li>
						<li class="diaryc06 btn" ctgrNum="6">
							<a href="#" onclick="javacript:event.preventDefault();">
								<img src="/images/biz/diary/filter-img6.png"/>
								<p>스케줄러</p>
							</a>
						</li>
						<li class="diaryc07 btn" ctgrNum="7">
							<a href="#" onclick="javacript:event.preventDefault();">
								<img src="/images/biz/diary/filter-img7.png"/>
								<p>캘린더</p>
							</a>
						</li>
					</ul>
				</div>

				<ul class="snb_a clear" id="diarySort">
					<li class="btn on" sortNum="0"><a href="#"
						onclick="javacript:event.preventDefault();">
							<p>베스트순</p> </a></li>
					<li class="btn" sortNum="1"><a href="#"
						onclick="javacript:event.preventDefault();">
							<p>최신순</p> </a></li>
					<li class="btn" sortNum="2"><a href="#"
						onclick="javacript:event.preventDefault();">
							<p>높은할인율순</p> </a></li>
					<li class="btn" sortNum="3"><a href="#"
						onclick="javacript:event.preventDefault();">
							<p>후기순</p> </a></li>
				</ul>

				<div class="prod_list_normal clear">
					<!-- 베스트순 -->
					<div class="pannel1">
						<div class="top1_a">
							<!-- top1 -->
							<ul class="tlist_a top1" id="diaryCloudList_top">
							</ul>
							<!-- / top1 -->
						</div>

						<!-- 리스트 반복 -->
						<ul class="tlist_a" id="diaryCloudList">
						</ul>
					</div>
					<!-- / 베스트순 -->
					<div class="btn_more_a" id="diaryMore">
						<a href="#" onclick="javacript:event.preventDefault();">
<!-- 						<img class="btn_more" -->
<!-- 							src="http://image.kyobobook.co.kr/newimages/giftshop_new/common/images/diary/2019/m/btn_more.png" /> -->
						</a>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 스티커 배너 영역 -->
		<div class="sticker-banner-wrap">
		    <a href="http://m.hottracks.co.kr/m/biz/sticker/stickerMain">
		        <img src="/images/biz/diary/m_스티커배너영역_750_580.jpg">
		        <button type="button" class="see-more-btn"></button>
		    </a>
		</div>

		<!-- 다꾸존 -->
		<div class="diarydeco_a clear">
			<div class="tit_today_box">
		        <span class="txtline_name">다꾸X다꾸</span>
		        <p>다꾸세상으로</p>
		    </div>
			<div class="diarydeco">
				<div class="decolist_p">
					<div class="deco_p01">			
		                <a class="btn_deco1" href="/m/gift/category/00002003">
		                    <img class="deco-bg" src="/images/biz/diary/dakku-pen-bg.png">
		                    <img class="deco-item" src="/images/biz/diary/dakku-pen.png">
		                    <button type="button" class="see-more-btn"></button>
		                </a>
            		</div>
		            <div class="deco_p02">			
		                <a class="btn_deco2" href="/m/gift/category/0000200505">
		                    <img class="deco-bg" src="/images/biz/diary/dakku-memo1.png">
		                    <img class="deco-item" src="/images/biz/diary/dakku-memo.png">
		                    <img class="deco-bg2" src="/images/biz/diary/dakku-memo2.png">
		                    <button type="button" class="see-more-btn"></button>
		                </a>
		            </div>
		            <div class="deco_p03">			
		                <a class="btn_deco3" href="/m/gift/category/00002006">
		                    <img class="deco-bg" src="/images/biz/diary/dakku-case1.png">
		                    <img class="deco-item" src="/images/biz/diary/dakku-case.png">
		                    <img class="deco-bg2" src="/images/biz/diary/dakku-case2.png">
		                    <button type="button" class="see-more-btn"></button>
		                </a>
		            </div>
		            <div class="deco_p04">			
		                <a class="btn_deco4" href="/m/gift/category/00002013">
		                    <img class="deco-bg" src="/images/biz/diary/dakku-tape1.png">
		                    <img class="deco-item" src="/images/biz/diary/dakku-tape.png">
		                    <button type="button" class="see-more-btn"></button>
		                </a>
		            </div>
				</div>
			</div>
		</div>

		<!-- 이벤트 리스트 -->
		<div class="diaryevent_a clear">
			<div class="tit_today_box">
		        <span class="txtline_name">Diary Event</span>
		        <p>혜택을 누리자</p>
		    </div>
			<div class="diaryevent">
				<div class="event_list_a">
					<div class="event_list">
					  <ul class="list"  id="diaryEventList">
					  </ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>