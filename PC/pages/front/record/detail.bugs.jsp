<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://hottracks.co.kr/taglib/ui" prefix="ui" %>
<%@taglib uri="http://hottracks.co.kr/taglib/hfn" prefix="hfn" %>
<ui:decorator name="${decorator}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<script type="text/javascript" src="/js/list.js"></script>
<script type="text/javascript">

// 전역변수 처리
var sellPrdtBcode = "${p.sellPrdtBcode}";
var rcrdCd = "${p.rcrdCd}";
var isLogin = ${isLogin};
var hasOption = ${hasOption};


// 상단 navi 토글 처리
function showNavi(cateId){
    if($(".navi_" + cateId).size() > 0){
        $(".navi_" + cateId).show();
    }
}

function hideNavi(cateId){
    if($(".navi_" + cateId).size() > 0){
        $(".navi_" + cateId).hide();
    }
}

// 특정레이어 토글 처리
function toggleLayer(target){
	$("#" + target).toggle();
}


// 전체 선택 처리
function chkAll(chk){
	$(".listDsc" + chk.value).attr("checked", chk.checked);	
}

//전곡 듣기 처리
function playAll(){
    $("input[name=chkTrkId]").attr("checked", true);
    musicPlayer.base.openPlayer('chkTrkId');
}



// 바로구매 처리
function detailBuy(){
	var prdtCount = $("input[name=prdtCount]").val();

	if(!hasOption){
	    addRecordBuy(sellPrdtBcode, prdtCount);
	}else{
		var optnNameList = [];
		var optnValueList = [];

		$("select[name=prdtOption]").each(function(idx){
			optnNameList.push($(this).find("option").get(0).value);

			if(this.selectedIndex > 0){
			    optnValueList.push($(this).find("option:selected").val());
			}
		});

		if(optnValueList.length != optnNameList.length){ alert("옵션을 선택해 주십시오"); return; }

		addRecordBuy(sellPrdtBcode, prdtCount, optnNameList.join("|"), optnValueList.join("|"));
	}
}


// 장바구니 처리 
function detailCart(){
    var prdtCount = $("input[name=prdtCount]").val();

    if(!hasOption){
    	addRecordCart(sellPrdtBcode, prdtCount);
    }else{
        var optnNameList = [];
        var optnValueList = [];

        $("select[name=prdtOption]").each(function(idx){
            optnNameList.push($(this).find("option").get(0).value);

            if(this.selectedIndex > 0){
                optnValueList.push($(this).find("option:selected").val());
            }
        });

        if(optnValueList.length != optnNameList.length){ alert("옵션을 선택해 주십시오"); return; }

        addRecordCart(sellPrdtBcode, prdtCount, optnNameList.join("|"), optnValueList.join("|"));
    }
}


// 음반 담기 처리
function detailMyListRecord(){
    <c:if test="${p.sellPrdtGbn eq 'R'}">addMyListRecord(rcrdCd);</c:if>
    <c:if test="${p.sellPrdtGbn eq 'D'}">addMyListDvd(rcrdCd);</c:if>
}


// 음원 전체 담기 처리
function detailMyListTrack(){
	var trkIdList = [];
	$("input[name=trkIdList]").each(function(idx){ trkIdList.push(this.value); });
	addMyListTrack(trkIdList.join(","));
}



// 리뷰 삭제하기
function reviewRemove(seq){
    if(isLogin){
        $.ajax({
            async : true, 
            url : "/ht/record/reviewRemove",
            dataType : "json", 
            type : "post", 
            data : {
        	    RcrdReviewSeq : seq 
            }, 
            success : function(result, textStatus, XMLHttpRequest){
                if(result.errorMessages.length > 0){
                    alert(result.errorMessages[0]);
                }else{
                    alert("삭제되었습니다.");
                    $("#member_review").listGoPage(1);
                }
            }, 
            error: function(request, textStatus, errorThrown){
                alert(request.status + " => " + request.statusText);
            }
        });
    }else{
        alert("로그인후 이용이 가능합니다.");        
    }
}




// 리뷰 저장하기
function reviewSave(){
	if(isLogin){
	    var grade = $("input[name=practicality]:checked").val();
        var review = $.trim($("textarea[name=review]").val());

        if(!grade){ alert("평점을 선택해 주십시오"); return; }
        if(review == ""){ alert("내용을 등록해 주십시오"); return; }

        $.ajax({
            async : true, 
            url : "/ht/record/reviewSave",
            dataType : "json", 
            type : "post", 
            data : {
                rcrdCd : "${p.rcrdCd}", 
                review : review, 
                grade : grade
            }, 
            success : function(result, textStatus, XMLHttpRequest){
                if(result.errorMessages.length > 0){
                    alert(result.errorMessages[0]);
                }else{
                    alert("등록되었습니다.");
                    $("textarea[name=review]").val("");
                    $("#member_review").listGoPage(1);
                }
            }, 
            error: function(XMLHttpRequest, textStatus, errorThrown){
                alert(request.status + " => " + request.statusText);
            }
        });
	}else{
        alert("로그인후 등록이 가능합니다.");        
	}
}


// 리뷰 목록 생성후 콜백 함수
function reviewCallBack(target){
	var options = target.data("listOption");

	
	
	// 리뷰 전체 개수 처리
	$(".member_review_count").html("(" + options.totalCount + ")");

	// 마지막 항목 점선 제거 처리
	$($(".review_list").find("li").get($(".review_list").find("li").size() - 1)).addClass("end");

	<c:if test="${isLogin}">
        var user_num = "${loginUser.num}";
	
		// 삭제 버튼 컨트롤
		$(".review_list").find("li").each(function(idx){
			if($(this).find("input[name=userNum]").val() == user_num){
				$(this).find(".btnRemove").show();
			}else{
				$(this).find(".btnRemove").hide();
			}
		});
	</c:if>
}




// QNA 목록 생성후 콜백 함수
function qnaCallBack(target){
    var options = target.data("listOption");

    
    
    // 전체 개수 처리
    $(".product_qna_count").html("(" + options.totalCount + ")");


    // 답변준비중 처리
    $(".question-answer").each(function(idx){
        if($.trim($(this).html()) == ""){ $(this).html("답변준비중입니다."); }
    });


    
    <c:if test="${isLogin}">
        var user_num = "${loginUser.num}";
    
        // 삭제 버튼 컨트롤
        $(".qa_list").find("tr").each(function(idx){
            if($(this).find("input[name=userNum]").val() == user_num){
                $(this).find(".btnUpdate").show();
                $(this).find(".btnRemove").show();
            }
        });
    </c:if>
}


// 리뷰 입력 바이트 체크
function reviewCheckByte(event){
	var review = $("textarea[name=review]").val();
	if(byteCheck(review) >= 200 && event.keyCode != 8 && event.keyCode != 9){ event.returnValue = false; }
}

// 리뷰 입력 바이트 표현
function reviewDispByte(event){
    var review = $("textarea[name=review]").val();
    $(".reviewCheckByteResult").html(byteCheck(review));
}


// Q&A 입력 창 활성화
function qnaWriteOpen(){
	<c:if test="${isLogin}">
	   window.open("/ht/product/questionPopup4write?barcode=${p.sellPrdtBcode}", "", "width=500, height=600, scrollbars=no");
	</c:if>	
}

// Q&A 수정 창 활성화
function qnaUpdateOpen(seq){
	<c:if test="${isLogin}">
	   window.open("/ht/product/questionPopup4Modify?seq=" + seq, "", "width=500, height=600, scrollbars=no");
	</c:if>
}


// Q&A 상세보기
function qnaView(seq){
	$(".qa_list_body_" + seq).toggle();
}


// Q&A 삭제요청
function qnaRemove(seq){
	<c:if test="${isLogin}">
	   if(confirm("삭제하시겠습니까?")){
		    $.ajax({
		        async : true, 
		        url : "/ht/product/deleteArticle",
		        dataType : "json", 
		        type : "post", 
		        data : {
		            seq : seq, 
		            barcode : "00" 
		        }, 
		        success : function(result, textStatus, XMLHttpRequest){
		            if(result.errorMessages.length > 0){
		                alert(result.errorMessages[0]);
		            }else{
		                alert("삭제되었습니다.");
		                $("#product_qna").listGoPage(1);
		            }
		        }, 
		        error: function(XMLHttpRequest, textStatus, errorThrown){
		            alert(request.status + " => " + request.statusText);
		        }
		    });
	   }
	</c:if>
}



// Q&A 입력 및 수정 콜백 처리
function loadQuestionSubList(){
	$("#product_qna").listGoPage(1);
}


//상세 펼쳐보기 처리
function infoViewControl(){
    if($(".album_information_content").hasClass("full")){
        $(".album_information_content").css("height", "200px");
        $(".album_information_content").removeClass("full");
        $(".open_button_area").find("img").attr("src", "<c:if test="${decorator eq 'record'}">${imageServer}/images/music/btn_album_open.gif</c:if><c:if test="${decorator eq 'dvd'}">${imageServer}/images/dvd/btn_open_area.gif</c:if>");
    }else{
        $(".album_information_content").css("height", null);
        $(".album_information_content").addClass("full");
        $(".open_button_area").find("img").attr("src", "<c:if test="${decorator eq 'record'}">${imageServer}/images/music/btn_album_close.gif</c:if><c:if test="${decorator eq 'dvd'}">${imageServer}/images/dvd/btn_close_area.gif</c:if>");
    }
}



$(document).ready(function(){
	// 리뷰 목록 구성하기
    $("#member_review").list({
        callBack : reviewCallBack, 
        service : "/ht/record/review",
        listClass : "review_list",
        pageClass : "review_page",   
        param : {
            rcrdCd : "${p.rcrdCd}"
        }
    });

    // QA 목록 구성하기
    $("#product_qna").list({
        callBack : qnaCallBack, 
        service : "/ht/record/qa",
        listClass : "qa_list",
        pageClass : "qa_page",   
        param : {
            rcrdCd : "${p.rcrdCd}"
        }
    });    

    // 음반정보 펼치기 디스플레이 컨트롤
    if($(".album_information_content_real").height() < 200){
        $(".album_information_content").css("height", null);
        $(".album_information_content").css("padding-bottom", "20px");
        $(".album_information_content").addClass("full");
        $(".open_button_area").hide();
    }
});
</script>
</head>
<body>






                                    


        <div id="contents">
            <div class="path_${baseClass}_detail">
                <p class="hide">현재 페이지 위치</p>

				<ul>
				    <c:forEach items="${cateList}" var="l" varStatus="s">
				        <c:if test="${s.index eq 0}">
				            <li>
				                <c:if test="${fn:startsWith(l.cateId, '0003')}"><a href="<ui:recordConstants key="url_record_main" />"><strong>${l.cateName}</strong></a></c:if>
				                <c:if test="${fn:startsWith(l.cateId, '0004')}"><a href="<ui:recordConstants key="url_dvd_main" />"><strong>${l.cateName}</strong></a></c:if>
				                <span>&gt;</span>
				            </li>
				        </c:if>
				        <c:if test="${s.index ne 0}">
				            <li class="sub" onmousemove="showNavi('${l.parentCateId}')" onmouseout="hideNavi('${l.parentCateId}')">
				                <a>${l.cateName}</a>
				                <c:if test="${!s.last}"><span>&gt;</span></c:if>
				                
				                <c:if test="${not empty cateMap[l.parentCateId]}">
				                    <ul class="navi_${l.parentCateId}">
				                         <c:forEach items="${cateMap[l.parentCateId]}" var="ls" varStatus="ss">
				                             <li><a href="/ht/record/category/${ls.cateId}">${ls.cateName}</a></li>
				                         </c:forEach>
				                    </ul>
				                </c:if>
				            </li>
				        </c:if>
				    </c:forEach>
				</ul>                


            </div>
            <!-- product-detail -->
            <div class="${baseClass}-detail"> 
                <!-- 상품 정보-->
                <div class="detail-content">
                    <!--앨범사진-->
                    <div class="${baseClass}-image">
                        <c:if test="${p.hasPosterCase}">
                            <p class="icon_p"><img src="${imageServer}/images/music/icon_poster.png" class="iepngfix" alt="포스터 증정" /></p>
                        </c:if>
                        <p class="photo">
                            <ui:image rcrdCd="${p.rcrdCd}" prdtGbn="${p.sellPrdtGbn}" width="400" alt="${p.rcrdName}" clazz="photo" rcrdImgType="large" ratingCode="${p.ratingCode}" />
                        </p>
                        <c:if test="${listTrack.hasTrackId}">
	                        <ul>
	                            <li><a href="/ht/help/buyMusicProduct"><img src="${imageServer}/images/music/button_soundTicket.gif" alt="음원상품권" /></a></li>
	                            <li><a href="javascript:playAll();"><img src="${imageServer}/images/music/button_allPlay.gif" alt="전곡듣기" /></a></li>
	                            <li><a href="javascript:alert('다운로드 연결 필요');"><img src="${imageServer}/images/music/button_download.gif" alt="다운로드" /></a></li>
	                            <li><a href="javascript:detailMyListTrack();"><img src="${imageServer}/images/music/button_cartPut.gif" alt="담기" /></a></li>
	                        </ul>
                        </c:if>
                    </div>
                    <!--//앨범사진--> 
                    <!--앨범정보-->
                    <div class="${baseClass}-basic-info">
                        <c:if test="${not empty eventImageList}">
		                    <div class="icon_sale">
		                        <p><img src="${imageServer}/images/music/btn_toptail_event.gif"  alt="이벤트" /></p>
		                    </div>
	                    </c:if>

                        <p class="subject">
                            <c:if test="${p.sellPrdtGbn eq 'R'}">${p.artiName} - </c:if>
                            ${p.commTitle}
                        </p>
                        
                        
                        <p class="subject-sub">
                            <c:if test="${not empty p.rcrdSubComments}">
                                ${p.rcrdSubComments}
                                <br/>
                            </c:if>
                            
                            <c:if test="${p.haveFreeGiftHaveYn eq 'Y'}">
                                <img src="${imageServer}/images/music/icon_gift.gif" alt="사은품" />
                            </c:if>
                        </p>

                        <c:if test="${p.sellPrdtGbn eq 'R'}">
	                        <c:if test="${not empty p.artiName}">
		                        <dl class="label00">
		                            <dt class="artist first">아티스트 :</dt>
		                            <dd class="artist"><strong><a href="javascript:alert('검색결과');">${p.artiName}</a></strong></dd>
		                        </dl>                        
	                        </c:if>
	
	                        <dl class="label01">
	                            <c:if test="${not empty p.makerName}">
	                                <dt class="production clear first">제작사 :</dt>
	                                <dd class="production"><a href="javascript:alert('검색결과');">${p.makerName}</a></dd>
	                            </c:if>
	
	                            <c:if test="${not empty p.labelName}">
	                                <dt class="production">레이블 :</dt>
	                                <dd class="production"><a href="javascript:alert('검색결과');">${p.labelName}</a></dd>
	                            </c:if>
	
	                            <c:if test="${not empty p.rlseDt}">
	                                <dt class="release">출시일 :</dt>
	                                <dd class="release"><ui:mask pattern="####년##월##일">${p.rlseDt}</ui:mask></dd>
	                            </c:if>
	                        </dl>
	                    </c:if>
	                    
	                    <c:if test="${p.sellPrdtGbn eq 'D'}">
	                        <c:if test="${not empty p.director or not empty p.actor}">
		                        <dl class="label00">
		                            <c:if test="${not empty p.director}">
			                            <dt class="production first">감독 :</dt>
			                            <dd class="production">${p.director}</dd>
			                        </c:if>
			                        <c:if test="${not empty p.actor}">
			                            <dt class="production">출연자 :</dt>
			                            <dd class="production">${p.actor}</dd>
			                        </c:if>
		                        </dl>   
		                    </c:if>
		                    
	                        <dl class="label00">
	                            <c:if test="${not empty p.makerName}">
		                            <dt class="production clear first">제작사 :</dt>
		                            <dd class="production">${p.makerName}</dd>
	                            </c:if>
	                            <c:if test="${not empty p.labelName}">
		                            <dt class="production">레이블 :</dt>
		                            <dd class="production">${p.labelName}</dd>
		                        </c:if> 
	                        </dl> 
	                        <c:if test="${not empty p.rlseDt}">
		                        <dl class="label01">     
		                            <dt class="release clear first">출시일 :</dt>
		                            <dd class="release"><ui:mask pattern="####년##월##일">${p.rlseDt}</ui:mask></dd>
		                        </dl>	                 
		                    </c:if>   
	                    </c:if>

                        
                        <dl class="price">
                            <c:if test="${p.prdtSellPrice ne p.priceReal}">
	                            <dt class="sale-price"><img src="${imageServer}/images/music/text_sale_price.gif" alt="판매가격" /></dt>
	                            <dd class="sale-price"><fmt:formatNumber value="${p.prdtSellPrice}" pattern=",###" />원</dd>
	                            <dt class="discount-price"><img src="${imageServer}/images/music/text_discount_price.gif" alt="할인가격" /></dt>
	                            <dd class="discount-price">
	                               <strong><span><fmt:formatNumber value="${p.priceReal}" pattern=",###" /></span> 원</strong>
	                               <span>(${hfn:rate(p.prdtSellPrice, p.priceReal)}%↓ <fmt:formatNumber value="${p.priceReal - p.prdtSellPrice}" pattern=",###" />원)</span>
	                            </dd>
	                        </c:if>

                            <c:if test="${p.prdtSellPrice eq p.priceReal}">
                                <dt class="sale-price"><img src="${imageServer}/images/music/text_sale_price.gif" alt="판매가격" /></dt>
                                <dd class="sale-price"><fmt:formatNumber value="${p.prdtSellPrice}" pattern=",###" />원</dd>
                            </c:if>
                            
                            <c:if test="${p.prdtSavedRate > 0}">
	                            <dt class="mileage"><img src="${imageServer}/images/music/text_mileage.gif" alt="마일리지" /></dt>
	                            <dd class="mileage">
	                               <strong><span><fmt:formatNumber value="${p.priceReal * p.prdtSavedRate / 100}" pattern=",###" /></span> 원</strong> 
	                               <span>(${p.prdtSavedRate}%적립)</span> <img src="${imageServer}/images/music/icon_mileage.gif" alt="적립금" />
	                               <span class="nr"><img src="${imageServer}/images/music/btn_question.gif" alt="?" /></span>
	                            </dd>
	                        </c:if>
                        </dl>
                        <dl class="delivery">
                            <dt class="product-code"><img src="${imageServer}/images/music/text_product_code.gif" alt="상품코드" /></dt>
                            <dd class="product-code">${p.sellPrdtBcode} (음반코드 : ${p.rcrdCd})</dd>
                            <dt class="delivery-info"><img src="${imageServer}/images/music/text_delivery_info.gif" alt="배송비안내" /></dt>
                            <dd class="delivery-info">
                                2,000 원
                                (20,000 이상 구매시 무료) <br/>
                                
                                <img src="${imageServer}/images/common/icon_delivery05.gif" alt="핫트랙스배송" />
                                <c:if test="${p.freeDlvyYn eq 'Y'}">
                                    <img src="${imageServer}/images/common/icon_delivery01.gif" alt="무료배송" />
                                </c:if>
                                
                                <c:if test="${p.impYn eq 'Y'}">
                                   <img src="${imageServer}/images/music/icon_import.gif" alt="수입" />
                                </c:if>
                            </dd>
                        </dl>
                        
                        <c:if test="${p.rcrdStat eq '9' or p.sellPrdtGbn eq 'R'}">
	                        <dl class="reservation">
	                            <c:if test="${p.rcrdStat eq '9'}">
		                            <!-- 예약상품일 경우 -->
		                            <dt class="delivery-date"><img src="${imageServer}/images/music/text_reservation.gif" alt="예약상품" /></dt>
		                            <dd class="delivery-date">
		                               ${p.rcrdRlseInfo}
		                            </dd>
		                        </c:if>
	
	                            <c:if test="${p.sellPrdtGbn eq 'R'}">
		                            <dt class="hottracks"><img src="${imageServer}/images/music/text_hottracks.gif" alt="HOTTARACKS" /></dt>
		                            <dd class="hottracks"> <strong>음반 판매자료는 한터차트와 음반 산업협회 판매량 집계에 반영됩니다.</strong> </dd>
	                            </c:if>
	                        </dl>
                        </c:if>
                        <dl class="option">
                            <c:if test="${hasOption}">
	                            <dt class="quantity"><img src="${imageServer}/images/music/text_option.gif" alt="옵션" /></dt>
	                            <dd class="quantity">
	                               <c:forEach items="${optionList}" var="l" varStatus="s">
	                                   <select name="prdtOption">
	                                       <option value="${l.optnName}">${l.optnName} 을(를) 선택해주십시오.</option>
	                                       <c:forEach items="${l.optnDescList}" var="desc">
	                                           <option value="${desc}">${desc}</option>
	                                       </c:forEach>
	                                   </select>
	                               </c:forEach>
	                            </dd>
	                        </c:if>
                            <dt class="quantity"><img src="${imageServer}/images/music/text_quantity.gif" alt="수량" /></dt>
                            <dd class="quantity">
                                <input type="text" value="1" name="prdtCount" maxlength="2" class="inputNumberText" style='ime-mode:disabled'/> 개 
                            </dd>
                        </dl>
                        <div class="detail-scrap">
                            <h3 class="hide"><img src="${imageServer}/images/product/h3_detail_scrap.gif" alt="스크랩" /></h3>
                            <p class="info hide"><img src="${imageServer}/images/product/info_detail_scrap.gif" alt="이 상품 정보를 다른 친구들과 공유하세요!" /></p>
                            <ul>
                                <li><a href="javascript:goPostTwitter();"><img src="${imageServer}/images/product/btn_twitter_send.gif" alt="트위터로 보내기" /></a></li>
                                <li><a href="javascript:goPostFaceBook();"><img src="${imageServer}/images/product/btn_facebook_send.gif" alt="페이스북으로 보내기" /></a></li>
                            </ul>
                        </div>
                        <!-- end detail-scrap --> 
                    </div>
                    <!--//앨범정보--> 
                    <!--분야별 베스트-->
                    <div class="${baseClass}-best-part">
                        <c:if test="${not empty bestRecordList}">
	                        <h3><img src="${imageServer}/images/music/h3_side_best.gif" alt="분야베스트" /><!-- <span><ui:category id="${p.ctgrId}" full="false" /></span> --></h3>
	                        <ul 
	                           <c:if test="${p.sellPrdtGbn eq 'R'}">class="side_album_list"</c:if>
	                           <c:if test="${p.sellPrdtGbn eq 'D'}">class="side_product_list"</c:if>
	                        >
	                            <c:forEach items="${bestRecordList}" var="l" varStatus="s">
		                            <li <c:if test="${s.last}">class="end"</c:if>>
		                                <p class="pic">
		                                   <a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${thumWidth}" alt="${l.rcrdName}" ratingCode="${l.ratingCode}" /></a>
		                                </p>
		                                <p class="chart"><img src="${imageServer}/images/${baseClass}/best_no${l.rank}.gif" alt="${l.rank}" /></p>
		                                <p class="artist"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut limit="10" tail="">${l.artiName}</ui:cut></a></p>
		                                <p class="album_label"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut limit="10" tail="">${l.commTitle}</ui:cut></a></p>
		                            </li>
		                        </c:forEach>
	                        </ul>
	                    </c:if>
                    </div>
                    <!--//분야별 베스트--> 
                    
                    <!--구매하기 안내-->
                    <div class="music-bye-info">
                        <c:if test="${not empty p.rcrdMdMemoReal}">
                            <div class="product-bye-tip">${p.rcrdMdMemoReal}</div>
                        </c:if>
                        <div class="product-bye-button">
                            <c:if test="${p.saleYn eq 'Y'}">
	                            <a href="javascript:detailBuy();"><img id="onClickBuyNow" src="${imageServer}/images/product/btn_buy_now.gif" alt="바로구매" /></a>
	                            <a href="javascript:detailCart();"><img id="onClickAddCart" src="${imageServer}/images/product/btn_cart_in.gif" alt="장바구니 담기" /></a>
                            </c:if>
                            
                            <c:if test="${p.outOfStockMailYn eq 'Y'}">
                                <a href="javascript:addRecordStockedInfoRequest('${p.rcrdCd}');"><img src="${imageServer}/images/music/btn_add_b02.gif" alt="알림예약 신청하기" /></a>
                            </c:if>
                            
                            <a href="javascript:detailMyListRecord();"><img src="${imageServer}/images/music/btn_list_put.gif" alt="리스트 담기" /></a>
                        </div>
                    </div>
                    <!--//구매하기 안내--> 
                </div>
                <!-- //상품 정보--> 
                <!-- 상품 상세내역 -->
                <div class="detail_menu_content">
				    <!-- detail_info_box -->
				    <div id="detail_info_box">
	                    <!--album_info-->
	                    <div id="album_info">
	                        <ul class="detail_menu">
	                            <li class="on first">
                                    <c:if test="${p.sellPrdtGbn eq 'R'}">
                                        <a href="#album_info"><img src="${imageServer}/images/music/detail_tab_01.gif" alt="음반정보" /></a>
                                    </c:if>
                                    <c:if test="${p.sellPrdtGbn eq 'D'}">
                                        <a href="#album_info"><img src="${imageServer}/images/music/detail_tab_01_2.gif" alt="상품정보" /></a>
                                    </c:if>
	                            </li>
	                            <li><a href="#member_review"><img src="${imageServer}/images/music/detail_tab_02.gif" alt="회원리뷰" /><span class="member_review member_review_count"></span></a></li>
	                            <li><a href="#product_qna"><img src="${imageServer}/images/music/detail_tab_03.gif" alt="상품Q&amp;A" /><span class="product_qna product_qna_count"></span></a></li>
	                            <li><a href="#delivery_exchange"><img src="${imageServer}/images/music/detail_tab_04.gif" alt="배송/교환/환불" /></a></li>
	                        </ul>
	                        
	                        
                            <!--album_event-->
                            <div class="album_event">
                                <c:if test="${not empty eventImageList}">
                                    <h3><img src="${imageServer}/images/music/h3_event.gif"alt="EVENT" /></h3>
                                </c:if>
                                
                                <c:forEach items="${eventImageList}" var="l" varStatus="s">
                                    <div class="album_event_banner">
                                        <a href="/ht/hot/eventDetail?eventId=${l.eventId}"><ui:image src="${l.imageUrl}" width="750" height="90" /></a>
                                    </div>
                                </c:forEach>
                            </div>
                            <!--//album_event--> 
	                        
	                        
	                        <!-- track_list -->
	                        <div class="track_list">
	                            <c:forEach items="${listTrack.cdNoList}" var="cdNo" varStatus="status">
	                                <h3><img src="${imageServer}/images/music/h3_track_list.gif" alt="Track List" /></h3>
	                                <div class="track_tool">
	                                   <span>DISC ${cdNo}</span>
	                                   <c:if test="${listTrack.cdNoMapHasTrack[cdNo]}">
		                                   <a href="javascript:musicPlayer.base.openPlayer('chkTrkId');"><img src="${imageServer}/images/music/btn_all_put02.gif" alt="선택듣기" /></a>
		                                   <a href="javascript:musicDownloader.base.openDownloader('chkTrkId');"><img src="${imageServer}/images/music/btn_all_down02.gif" alt="선택다운" /></a>
		                               </c:if>
	                                </div>
	                                
	                                <table class="track_list" summary="트랙목록/듣기/가사/다운/담기">
	                                    <colgroup>
	                                        <c:if test="${listTrack.cdNoMapHasTrack[cdNo]}">
		                                      <col width="5%" />
		                                    </c:if>
		                                    <col width="5%" />
		                                    <col width="*" />
		                                    <col width="20%" />
		                                    <col width="6%" />
		                                    <!--
		                                    <col width="6%" />
		                                    <col width="6%" />
		                                    <col width="6%" />
		                                    -->
	                                    </colgroup>
	                                    <thead>
	                                        <tr>
	                                            <c:if test="${listTrack.cdNoMapHasTrack[cdNo]}">
		                                            <th scope="col" class="check">
		                                               <input type="checkbox" name="checkbox" onclick="chkAll(this)" value="${cdNo}" />
		                                            </th>
	                                            </c:if>
	                                            <th scope="col" class="number">No.</th>
	                                            <th scope="col" class="title">곡명</th>
	                                            <th scope="col" class="artist">아티스트</th>
	                                            <th scope="col">듣기</th>
	                                            <!--
	                                            <th scope="col">가사</th>
	                                            <th scope="col">다운</th>
	                                            <th scope="col">담기</th>
	                                            -->
	                                        </tr>
	                                    </thead>
	                                    <tbody>
	                                       <c:forEach items="${listTrack.cdNoMapList[cdNo]}" var="l" varStatus="s">
	                                            <tr <c:if test="${s.last}">class="end"</c:if>>
	                                               <c:if test="${listTrack.cdNoMapHasTrack[cdNo]}">
		                                                <th scope="row" class="check">
	                                                       <c:if test="${not empty l.trkId}">
	                                                           <input type="checkbox" name="chkTrkId" class="listDsc listDsc${cdNo}" value="${l.trkId}" />
	                                                           
	                                                           <!-- 전체 담기 처리용 -->
	                                                           <input type="hidden" name="trkIdList" value="${l.trkId}" />
	                                                           
	                                                           <!-- 플레이어 처리용 -->
		                                                       <input type="hidden" name="trkId_${l.trkId}" value="${l.trkId}" />
		                                                       <input type="hidden" name="trkName_${l.trkId}" value="${l.trkName}" />
		                                                       <input type="hidden" name="artiName_${l.trkId}" value="${l.artiName}" />
		                                                       <input type="hidden" name="albumTitle_${l.trkId}" value="${p.rcrdName}" />                                                           
	                                                       </c:if>
		                                                </th>
	                                                </c:if>
	                                                <td>${l.trkNo}</td>
	                                                <td class="title">${l.trkName}</td>
	                                                <td><strong>${l.artiName}</strong></td>
	                                                <td>
                                                       <c:if test="${not empty l.trkId}">
                                                           <a href="javascript:musicPlayer.base.openPlayer(${l.trkId});"><img src="${imageServer}/images/sound/btn_listen.png" class="iepngfix" alt="듣기" /></a>
                                                       </c:if>
                                                       <c:if test="${empty l.trkId}">
                                                           <c:if test="${l.audioYn eq 'Y'}">
                                                               <a href="javascript:musicPlayer.base.openPlayerHot(${l.rcrdCd},${l.cdNo},${l.trkNo});"><img src="${imageServer}/images/sound/btn_listen.png" class="iepngfix" alt="듣기" /></a>
                                                           </c:if>
                                                           <c:if test="${l.audioYn ne 'Y'}">
                                                               <img src="${imageServer}/images/sound/btn_listen_off.png" class="iepngfix" alt="듣기" />
                                                           </c:if>
                                                       </c:if>
	                                                </td>
	                                                <!--
	                                                <td>
	                                                   <c:if test="${not empty l.trkId}">
	                                                       <a href="javascript:viewLyrics(${l.trkId});"><img src="${imageServer}/images/sound/btn_viewlyrics.png" class="iepngfix" alt="가사" /></a>
	                                                   </c:if>
	                                                   <c:if test="${empty l.trkId}">
	                                                       <img src="${imageServer}/images/sound/btn_viewlyrics_off.png" class="iepngfix" alt="가사" />
	                                                   </c:if>
	                                                </td>
	                                                <td>
                                                       <c:if test="${not empty l.trkId}">
                                                           <a href="javascript:musicDownloader.base.openDownloader(${l.trkId});"><img src="${imageServer}/images/sound/btn_down.png" class="iepngfix" alt="다운" /></a>
                                                       </c:if>
                                                       <c:if test="${empty l.trkId}">
                                                           <img src="${imageServer}/images/sound/btn_down_off.png" class="iepngfix" alt="다운" />
                                                       </c:if>
	                                                </td>
	                                                <td>
	                                                   <c:if test="${not empty l.trkId}">
	                                                       <a href="javascript:addMyListTrack(${l.trkId});"><img src="${imageServer}/images/sound/btn_putlist.png" class="iepngfix" alt="담기" /></a>
	                                                   </c:if>
                                                       <c:if test="${empty l.trkId}">
                                                           <img src="${imageServer}/images/sound/btn_putlist_off.png" class="iepngfix" alt="담기" />
                                                       </c:if>
	                                                </td>
	                                                -->
	                                            </tr>
	                                       </c:forEach>
	                                    </tbody>
	                                </table>
	                            </c:forEach>
	
	                            <c:if test="${!p.hasPosterCase}">
	                                <div class="album_massage">
	                                    <p><em>포스터는 포스터 케이스에 담아 발송해 드립니다.</em></p>
	                                    <p>(앨범을 2장 이상 구매 시 포스터는 구매 수량과 동일하게 증정되며, 포스터 케이스는 주문 건당 1개만 증정됩니다.)</p>
	                                    <p>※ 단 해외 주문 건은 포스터가 발송 되지 않습니다.</p>
	                                </div>
	                            </c:if>

                                <c:if test="${decorator eq 'dvd'}">
		                            <div class="product_add">
		                                <h3><img src="${imageServer}/images/dvd/h3_product_add.gif" /></h3>
		                                <p class="actor">출연자 : ${p.actor}</p>
		                                <p>
		                                                                      감독 : ${p.director}  │  
		                                                                      언어 : ${p.language}  │  
		                                                                      자막 : ${p.caption}
		                                   <br />
		                                                                      화면 : ${p.screen}  │  
		                                                                      음향 : ${p.sound}
		                                   <br />
		                                                                      상영시간 :  ${p.screenHour}  │  
		                                                                      디스크 수 : ${p.cdCount}  │  
		                                                                      지역코드 : ${p.localCode}  │  
		                                                                      등급 : <ui:code codeId="${p.ratingCode}" /> 
                                        </p>
		                            </div>
                                </c:if>


                                <div class="album_event_option">
                                    <dl class="etc_seperate">
                                        <c:if test="${not empty p.mediaName}">
                                            <dt class="first">미디어</dt>
                                            <dd>: ${p.mediaName}</dd>
                                            <dd>
                                               <a href="javascript:toggleLayer('media_code_info');"><img src="${imageServer}/images/music/btn_question.gif" alt="?" width="13" height="13" /></a>
                                            </dd>
                                        </c:if>
                                        <dt>수입구분</dt>
                                        <dd>:
                                            <c:if test="${p.impYn eq 'Y'}">수입</c:if>
                                            <c:if test="${p.impYn eq 'N'}">라이센스</c:if> 
                                        </dd>
                                        <dt>디스크 수</dt>
                                        <dd>: ${p.cdCount}Disk</dd>
                                        
                                        <c:if test="${p.hasInterestArtist}">
                                            <dt class="favor">관심 아티스트 등록하기 <a href="javascript:toggleLayer('favor_artist_put');"><img src="${imageServer}/images/music/btn_question.gif" width="13" height="13" alt="?" /></a></dt>
                                            <dd class="favor"><a href="javascript:addInterestArtist('${p.artiCd}');"><img src="${imageServer}/images/music/btn_apply.gif" width="70" height="22" alt="신청" /></a></dd>
                                        </c:if>
                                    </dl>
                                    
                                    <!--media_code_info popup-->
                                    <div id="media_code_info" style="display:none;">
                                        <div class="help_box">
                                            <h4>미디어 코드 안내
                                                <p class="close"><a href="javascript:toggleLayer('media_code_info');"><img src="${imageServer}/images/music/help_close.gif" alt="닫기" /></a></p>
                                            </h4>
                                            <dl>
                                                <dt>SACD</dt>
                                                <dd>본 음반은 Super Audio CD Players에서만 재생 가능합니다.</dd>
                                                <dt>SACD Hybrid</dt>
                                                <dd>본 음반은 일반 CD Players, Super Audio CD Players 모두 재생가능합니다.</dd>
                                                <dt>DVD Audio</dt>
                                                <dd>이것은 오직 DVD 플레이어에서만 재생 가능한 고음질 5.1채널<br />
                                                    CD로서 영상은 포함되어 있지 않으니 유념하시기 바랍니다.</dd>
                                            </dl>
                                        </div>
                                    </div>
                                    <!--//media_code_info popup--> 
                                    <!--favor_artist_put popup-->
                                    <div id="favor_artist_put" style="display:none;">
                                        <div class="help_box">
                                            <h4>관심아티스트 등록하기
                                                <p class="close"><a href="javascript:toggleLayer('favor_artist_put');"><img src="${imageServer}/images/music/help_close.gif" alt="닫기" /></a></p>
                                            </h4>
                                            <ul>
                                                <li>관심아티스트의 새소식 알림 신청이 가능합니다.</li>
                                                <li>
                                                                                            관심아티스트 새소식 알림 신청은 해당 아티스트의 신작이 발매될 때<br />
                                                                                            해당소식을 이메일 또는 SMS을 발송해드리는 서비스입니다.
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <!--//favor_artist_put popup-->                                 
                                </div>	                            
	                            
	                        </div>
	                        <!-- //track_list --> 

	                        <!--album_information-->
	                        <div class="album_information">
	                            <h3>
	                               <c:if test="${p.sellPrdtGbn eq 'R'}">
	                                   <img src="${imageServer}/images/music/h3_album_info.gif" alt="음반정보" />
	                               </c:if>
	                               <c:if test="${p.sellPrdtGbn eq 'D'}">
	                                   <img src="${imageServer}/images/dvd/h3_product_info.gif" alt="상품정보" />
	                               </c:if>
	                            </h3>
	                            <div class="album_information_content" style="height:200px; overflow-y:hidden;">
	                                <div class="album_information_content_real"><ui:br>${p.description}</ui:br></div>
	                            </div>
	                            <div class="open_button_area">
	                               <a href="javascript:infoViewControl();">
	                                   <c:if test="${p.sellPrdtGbn eq 'R'}">
	                                       <img src="${imageServer}/images/music/btn_album_open.gif" />
	                                   </c:if>
	                                   <c:if test="${p.sellPrdtGbn eq 'D'}">
	                                       <img src="${imageServer}/images/dvd/btn_open_area.gif" />
	                                   </c:if>
	                               
	                                   
	                               </a><!-- 접기 btn_album_close.gif-->
	                            </div>
	                        </div>
	                        <!--//album_information--> 
	                        
	                        
	                    </div>
	                    <!--//album_info--> 
	                    
	                    
	                    
	                    <!--member_review-->
	                    <div id="member_review">
	                        <ul class="detail_menu">
	                            <li>
                                    <c:if test="${p.sellPrdtGbn eq 'R'}">
                                        <a href="#album_info"><img src="${imageServer}/images/music/detail_tab_01.gif" alt="음반정보" /></a>
                                    </c:if>
                                    <c:if test="${p.sellPrdtGbn eq 'D'}">
                                        <a href="#album_info"><img src="${imageServer}/images/music/detail_tab_01_2.gif" alt="상품정보" /></a>
                                    </c:if>
	                            </li>
	                            <li class="on"><a href="#member_review"><img src="${imageServer}/images/music/detail_tab_02.gif" alt="회원리뷰" /><span class="member_review member_review_count"></span></a></li>
	                            <li><a href="#product_qna"><img src="${imageServer}/images/music/detail_tab_03.gif" alt="상품Q&amp;A" /><span class="product_qna product_qna_count"></span></a></li>
	                            <li><a href="#delivery_exchange"><img src="${imageServer}/images/music/detail_tab_04.gif" alt="배송/교환/환불" /></a></li>
	                        </ul>
	                        <div class="member_review">
	                            <h3><img src="${imageServer}/images/music/h3_simple_review.gif" alt="간단리뷰" /> <span><strong class="member_review_count"></strong></span></h3>
	                            <ul class="review_list">
	                                <li>
	                                    <p class="name">
	                                        <input type="hidden" name="userNum" value="$[userNum]" />
	                                        $[userName]
	                                    </p>
	                                    <p class="comment">
	                                        $[review]
	                                    </p>
	                                    <p class="btn">
	                                       <span class="btnRemove" style="display:none;"><a href="javascript:reviewRemove($[rcrdReviewSeq]);"><img alt="삭제" src="${imageServer}/images/product/btn_delete.gif" /></a></span>
	                                    </p>
	                                    <p class="star"><img src="${imageServer}/images/music/star_$[grade].gif" /></p>
	                                    <p class="date">$[regstDt]</p>
	                                </li>
	                            </ul>
	                            <div class="review_page" style="text-align:center; padding:15px 0 30px 0;"></div>
	                            <div class="review_write">
	                                <h4><span><img src="${imageServer}/images/music/h4_point.gif" alt="평점주기" /></span> <!--<a href="#"><img src="${imageServer}/images/music/btn_point_ar.gif" alt="평점주기" /></a>--> 
	                                </h4> 
	                                <p class="customer_re"> 
	                                    <label for="customer-satisfaction1-5"><img src="${imageServer}/images/music/icon_star05.gif" alt="★★★★★" /></label>
	                                    <input type="radio" id="customer-satisfaction1-5" name="practicality" value="5"/>
	                                    <label for="customer-satisfaction1-4"><img src="${imageServer}/images/music/icon_star04.gif" alt="★★★★" /></label>
	                                    <input type="radio" id="customer-satisfaction1-4" name="practicality" value="4"/>
	                                    <label for="customer-satisfaction1-3"><img src="${imageServer}/images/music/icon_star03.gif" alt="★★★" /></label>
	                                    <input type="radio" id="customer-satisfaction1-3" name="practicality" value="3"/>
	                                    <label for="customer-satisfaction1-2"><img src="${imageServer}/images/music/icon_star02.gif" alt="★★" /></label>
	                                    <input type="radio" id="customer-satisfaction1-2" name="practicality" value="2"/>
	                                    <label for="customer-satisfaction1-1"><img src="${imageServer}/images/music/icon_star01.gif" alt="★" /></label>
	                                    <input type="radio" id="customer-satisfaction1-1" name="practicality" value="1"/>
	                                </p>  
	                                <div class="">
	                                    <p class="review_text">
	                                        <textarea name="review" cols="" rows="5" onkeydown="reviewCheckByte(event)" onkeyup="reviewDispByte(event)"></textarea>
	                                    </p>
	                                    <p class="review_button">
	                                        <input name="" type="image" src="${imageServer}/images/music/btn_review_write.gif" onclick="reviewSave()" />
	                                    </p>
	                                </div>
	                                <p class="review_massage">현재 <strong class="reviewCheckByteResult">0</strong> / 200 bytes (최대 한글 100자, 영문 200자)</p>
	                            </div>
	                        </div>
	                        <!-- end member_review --> 
	                    </div>
	                    <!-- //member_review-->
	                    
	                    
	                    <!-- product_qna -->
	                    <div id="product_qna">
	                        <ul class="detail_menu">
	                            <li>
                                    <c:if test="${p.sellPrdtGbn eq 'R'}">
                                        <a href="#album_info"><img src="${imageServer}/images/music/detail_tab_01.gif" alt="음반정보" /></a>
                                    </c:if>
                                    <c:if test="${p.sellPrdtGbn eq 'D'}">
                                        <a href="#album_info"><img src="${imageServer}/images/music/detail_tab_01_2.gif" alt="상품정보" /></a>
                                    </c:if>
	                            </li>
	                            <li><a href="#member_review"><img src="${imageServer}/images/music/detail_tab_02.gif" alt="회원리뷰" /><span class="member_review member_review_count"></span></a></li>
	                            <li class="on"><a href="#product_qna"><img src="${imageServer}/images/music/detail_tab_03.gif" alt="상품Q&amp;A" /><span class="product_qna product_qna_count"></span></a></li>
	                            <li><a href="#delivery_exchange"><img src="${imageServer}/images/music/detail_tab_04.gif" alt="배송/교환/환불" /></a></li>
	                        </ul>
	                        <div class="product_qna_content">
	                            <p class="info"><img src="${imageServer}/images/music/product_qna_info.gif" alt="고객님의 문의에 최대한 빠른 답변을 해드리겠습니다." /></p>
	                            <p class="func">
	                                <c:if test="${isLogin}">
	                                   <button onclick="qnaWriteOpen()"><img src="${imageServer}/images/main/btn_product_qna.gif"  /></button>
	                                </c:if>
	                            </p>
	                            <table class="product_qna_list" summary="상품QnA목록/구분,제목,작성자,작성일">
	                                <colgroup>
	                                <col width="15%" />
	                                <col width="*" />
	                                <col width="15%" />
	                                <col width="15%" />
	                                </colgroup>
	                                <thead>
	                                    <tr>
	                                        <th scope="col" class="first"><img src="${imageServer}/images/music/qna_th_sprt.gif" alt="구분" /></th>
	                                        <th scope="col"><img src="${imageServer}/images/music/qna_th_title.gif" alt="제목" /></th>
	                                        <th scope="col"></th>
	                                        <th scope="col"><img src="${imageServer}/images/music/qna_th_name.gif" alt="작성자" /></th>
	                                        <th scope="col" class="end"><img src="${imageServer}/images/music/qna_th_date.gif" alt="작성일" /></th>
	                                    </tr>
	                                </thead>
	                                <tbody class="qa_list">
	                                    <tr class="qa_list_title qa_list_title_$[prdtQnaSeq]">
	                                        <td>$[procStatGbnName]</td>
	                                        <td class="title">
	                                           <a href="javascript:qnaView('$[prdtQnaSeq]');">$[prdtQnaTitle]</a>
	                                           <input type="hidden" name="userNum" value="$[askRegstUserNum]" />
	                                        </td>
	                                        <td>
	                                            <a href="javascript:qnaUpdateOpen($[prdtQnaSeq]);" class="btnUpdate" style="display:none;"><img alt="수정" src="${imageServer}/images/product/btn_modify.gif" /></a>
	                                            <a href="javascript:qnaRemove($[prdtQnaSeq]);" class="btnRemove" style="display:none;"><img alt="삭제" src="${imageServer}/images/product/btn_delete.gif" /></a>
	                                        </td>                                           
	                                        <td>$[userIdBlock]</td>
	                                        <td>$[askRegstDt]</td>
	                                    </tr>
	                                    <tr class="qa_list_body qa_list_body_$[prdtQnaSeq]" style="display:none;">
	                                        <td class="detail-content" colspan="5" style="display:table-cell;">
	                                            <p class="question-content">$[prdtAskContBr]</p>
	                                            <p class="answer question-answer">$[prdtAswrContBr]</p>
	                                        </td>
	                                    </tr>                                       
	                                </tbody>
	                            </table>
	                            <div class="pager qa_page"></div>
	                        </div>
	                    </div>
	                    <!-- //product_qna --> 
	                    <!--delivery_exchange-->
	                    <div id="delivery_exchange">
	                        <ul class="detail_menu">
	                            <li>
                                    <c:if test="${p.sellPrdtGbn eq 'R'}">
                                        <a href="#album_info"><img src="${imageServer}/images/music/detail_tab_01.gif" alt="음반정보" /></a>
                                    </c:if>
                                    <c:if test="${p.sellPrdtGbn eq 'D'}">
                                        <a href="#album_info"><img src="${imageServer}/images/music/detail_tab_01_2.gif" alt="상품정보" /></a>
                                    </c:if>
	                            </li>
	                            <li><a href="#member_review"><img src="${imageServer}/images/music/detail_tab_02.gif" alt="회원리뷰" /><span class="member_review member_review_count"></span></a></li>
	                            <li><a href="#product_qna"><img src="${imageServer}/images/music/detail_tab_03.gif" alt="상품Q&amp;A" /><span class="product_qna product_qna_count"></span></a></li>
	                            <li class="on"><a href="#delivery_exchange"><img src="${imageServer}/images/music/detail_tab_04.gif" alt="배송/교환/환불" /></a></li>
	                        </ul>
	                        <div class="delivery_exchange_content">
	                            <h4>반품안내</h4>
	                            <p>본 상품을 변심 반품 또는 단순 사이즈 및 색상 교환 시에는 반품비 및 재배송비는 고객님께서 부담하셔야 합니다.</p>
	                            <p>반품 회수 서비스가 가능하며 택배기사님 방문시 반품비 2,500원을 전달해 주시고 교환에 의한 재배송 상품은 착불로 배송됩니다.</p>
	                            <h4>교환  및 반품이 가능한 경우</h4>
	                            <p>1. 주문 상품 수령 후 사용하지 않으신 경우에 한하여, 상품을 받거나 공급이 개시된 날로부터 7일 이내 교환 및 반품이 가능합니다.</p>
	                            <p>2. 주문 시 안내 받은 상품의 광고사항과 다른 상품이 배송 된 경우 수령일로부터 3개월 이내, 알 수 있었던 날부터 30일 이내 교환 및 반품이 가능합니다. </p>
	                            <p>3. 그 외 전자상거래등에서의 소비자보호에관한법률에 규정되어 있는 소비자 청약철회 가능범위에 해당하는 경우 교환 및 반품이 가능합니다. </p>
	                            <h4>교환 및 반품이 불가능한 경우</h4>
	                            <p>1. 고객님의 책임 있는 사유로 상품이 멸실 또는 훼손된 경우 (단, 상품의 내용확인을 위한 포장훼손 등은 제외</p>
	                            <p>2. 고객님의 사용 또는 일부 소비에 의하여 상품의 가치가 현저히 감소한 경우 (예: 화장품, 식품 등)</p>
	                            <p></p>
	                        </div>
	                        <!-- end delivery_exchange_content --> 
	                    </div>
	                    <!-- //delivery_exchange-->   				    
				    </div>
				    <!-- detail_info_box -->
                 
                 
                    
                    
                    
                    
	                <!-- 우측 앨범 정보 -->
	                <div class="product_detail_aside">
	                    <c:if test="${not empty todaySaleList}">
	                        <div class="${baseClass}-today">
	                            <h3><img src="${imageServer}/images/dvd/h3_today.gif" /></h3>
	                            <ul 
	                               <c:if test="${p.sellPrdtGbn eq 'R'}">class="side_album_list"</c:if>
	                               <c:if test="${p.sellPrdtGbn eq 'D'}">class="side_product_list"</c:if>
	                            >
	                                <c:forEach items="${todaySaleList}" var="l" varStatus="s">
	                                    <li <c:if test="${s.last}">class="end"</c:if>>
	                                        <p class="pic">
	                                            <a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${thumWidth}" alt="${l.rcrdName}" ratingCode="${l.ratingCode}" /></a>
	                                        </p>
	                                        <p class="album_label">
	                                            <a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut limit="15">${l.commTitle}</ui:cut></a>
	                                        </p> 
	                                        <p class="f_red_b"><span class="bold"><fmt:formatNumber value="${l.priceReal}" pattern=",###" />원</span></p>
	                                        <p>
	                                            <span class="f_orange">
			                                       <c:if test="${l.prdtSellPrice ne l.priceReal or l.prdtSavedRate > 0}"> 
		                                               [
		                                                  <c:if test="${l.prdtSellPrice ne l.priceReal}">
		                                                      ${hfn:rate(l.prdtSellPrice, l.priceReal)}%↓
		                                                  </c:if>
		                                                  <c:if test="${l.prdtSavedRate > 0}">
		                                                      ${l.prdtSavedRate}%P
		                                                  </c:if>
		                                               ]
			                                       </c:if>
	                                            </span>
	                                        </p> 
	                                    </li>
	                                </c:forEach>
	                            </ul>
	                        </div>
                        </c:if>
	                
	                
	                    <ul class="promotion_banner">
                            <c:if test="${not empty bannerList and fn:length(bannerList) > 0}">
                                <li><ui:banner bnrLinkUrl="${bannerList[0].bnrLinkUrl}" bannerImageUrl="${bannerList[0].bannerImageUrl}" bnrTgtGbn="${bannerList[0].bnrTgtGbn}" bnrSeq="${bannerList[0].bnrSeq}" newWdwYn="${bannerList[0].newWdwYn}" /></li>
                            </c:if>
                            <c:if test="${not empty bannerList and fn:length(bannerList) > 1}">
                                <li><ui:banner bnrLinkUrl="${bannerList[1].bnrLinkUrl}" bannerImageUrl="${bannerList[1].bannerImageUrl}" bnrTgtGbn="${bannerList[1].bnrTgtGbn}" bnrSeq="${bannerList[1].bnrSeq}" newWdwYn="${bannerList[1].newWdwYn}" /></li>
                            </c:if>
	                    </ul>
	                    
	                    
	                    <c:if test="${not empty artiRecordList}">
	                       <div class="${baseClass}-other-album">
		                        <h3><img src="${imageServer}/images/music/h3_other_album.gif" alt="이 아티스트의 다른음반" /><span><a href="/ht/track/artistDetail?code=${p.artiCd}"><img src="${imageServer}/images/music/btn_more_aside.gif"  alt="더보기" /></a></span></h3>
		                        <ul class="side_album_list">
		                            <c:forEach items="${artiRecordList}" var="l" varStatus="s">
		                                <li <c:if test="${s.last}">class="end"</c:if>>
		                                    <p class="pic">
		                                       <a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="50" alt="${l.rcrdName}" ratingCode="${l.ratingCode}" /></a>
		                                    </p>
		                                    <p class="artist"><a href="/ht/record/detail/${l.sellPrdtBcode}">${l.artiName}</a></p>
		                                    <p class="album_label"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut limit="10" tail="">${l.commTitle}</ui:cut></a></p>
		                                </li>
		                            </c:forEach>	                        
		                        </ul>
    	                    </div>
                        </c:if>
	                    <!-- end product-other-album -->
	                    <c:if test="${not empty newRecordList}">
		                    <div
                               <c:if test="${p.sellPrdtGbn eq 'R'}">class="music-new-album"</c:if>
                               <c:if test="${p.sellPrdtGbn eq 'D'}">class="dvd-new-album"</c:if>		                    
		                    >
		                        <h3>
                                    <c:if test="${p.sellPrdtGbn eq 'R'}">
                                        <img src="${imageServer}/images/music/h3_new_album.gif" alt="이 분야의 새앨범" />
                                    </c:if>
                                    <c:if test="${p.sellPrdtGbn eq 'D'}">
                                        <img src="${imageServer}/images/dvd/h3_new_product.gif" alt="이 분야의 새상품" />
                                    </c:if>
		                        </h3>
		                        <ul
 	                                <c:if test="${p.sellPrdtGbn eq 'R'}">class="side_album_list"</c:if>
 	                                <c:if test="${p.sellPrdtGbn eq 'D'}">class="side_product_side"</c:if>                            
		                        >
	                                <c:forEach items="${newRecordList}" var="l" varStatus="s">
	                                    <li <c:if test="${s.last}">class="end"</c:if>>
	                                        <p class="pic">
	                                           <a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${thumWidth}" alt="${l.rcrdName}" ratingCode="${l.ratingCode}" /></a>
	                                        </p>
	                                        <p class="artist"><a href="/ht/record/detail/${l.sellPrdtBcode}">${l.artiName}</a></p>
	                                        <p class="album_label"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut limit="10" tail="">${l.commTitle}</ui:cut></a></p>
	                                    </li>
	                                </c:forEach>
	                            </ul>
		                    </div>
		                </c:if>
	                    <!-- end product-new-album -->


                        <c:if test="${not empty reserveList}">
	                        <div class="dvd-new-album">
	                            <h3><img src="${imageServer}/images/dvd/h3_new_product02.gif" alt="발매 예정 상품" /></h3>
	                            <ul class="side_product_side">
                                    <c:forEach items="${reserveList}" var="l" varStatus="s">
                                        <li <c:if test="${s.last}">class="end"</c:if>>
                                            <p class="pic">
                                               <a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:image rcrdCd="${l.rcrdCd}" prdtGbn="${l.sellPrdtGbn}" width="${thumWidth}" alt="${l.rcrdName}" ratingCode="${l.ratingCode}" /></a>
                                            </p>
                                            <p class="artist"></p>
                                            <p class="album_label"><a href="/ht/record/detail/${l.sellPrdtBcode}"><ui:cut limit="20" tail="">${l.commTitle}</ui:cut></a></p>
                                        </li>
                                    </c:forEach>
	                            </ul>
	                        </div> 
                        </c:if>

	                </div>
	                <!-- //우측 앨범 정보 -->                     
                     
                    
                </div>
                <!-- //상품 상세내역 --> 

            </div>
            <!-- end product-detail --> 
        </div>
 

</body>
</html>