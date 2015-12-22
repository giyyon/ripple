<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<link href="/css/style12.css" rel="stylesheet" type="text/css">

<!--타이틀시작-->
<div id="header3"><img src="/img/title0007.jpg" width="400" height="35" />
<!-- </div> -->
<!--타이틀끝-->

<!--섹션시작-->
<div id="section"> 
	<!--본문시작-->
            <!-- 목록리스트 -->
            <div class="list_box">
            	<div class="list_head">
					<span class="Hnum">번호</span>
					<span class="Hnum">분류</span>
					<span class="Hdate">등록일</span>
					<span class="Hpicinf">회원명</span>
					<span class="Hsub">요청내용 (금액/수량)</span>
					<span class="Hhit">처리현황</span>					
	             </div>
		<form id="subForm" method="post"  action="${contextPath}/customer/noticeInqire.do" >
			<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
		</form>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<div class="bbs_lst" name="bbs_lst">
				<span class="num"><c:out value="${result.tradeId}"/></span>
				<span class="num"><c:out value="${result.tradeTypeNm}"/></span>
				<span class="date"><c:out value="${result.requestDt}"/></span>
				<span class="picinf"><c:out value="${result.mberNm}"/></span>
				<span class="bbs_sub"><fmt:formatNumber type="number" value="${result.requestBuyMoneyOrSellQty}"/></span>
				<span class="num handPnt" onclick="layer_open('layer2',  ${status.index}); return false;"><c:out value="${result.status}"/></span>
				
				<input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>"/>
				<input type="hidden" name="searchWrd"value="<c:out value='${searchVO.searchWrd}'/>"/>
				<input type="hidden" name="tradeId" value="<c:out value='${result.tradeId}'/>" />
				<input type="hidden" name="tradeType" value="<c:out value='${result.tradeType}'/>" />
				<input type="hidden" name="tradeTypeNm" value="<c:out value='${result.tradeTypeNm}'/>" />
				<input type="hidden" name="requestBuyMoneyOrSellQty"  value='<fmt:formatNumber type="number" value="${result.requestBuyMoneyOrSellQty}"/>' />
				
				<input type="hidden" name="resultUnitPrice" value="<fmt:formatNumber type="number" value="${result.resultUnitPrice}"/>" />
				<input type="hidden" name="resultQty" value="<fmt:formatNumber type="number" value="${result.resultQty}"/>" />
				<input type="hidden" name="fee" value="<fmt:formatNumber type="number" value="${result.fee}"/>" />
				<input type="hidden" name="resultTotMoney" value="<fmt:formatNumber type="number" value="${result.resultTotMoney}"/>" />
				
				<input type="hidden" name="requestDt" value="<c:out value='${result.requestDt}'/>" />
				<input type="hidden" name="mberNm" value="<c:out value='${result.mberNm}'/>" />
				<input type="hidden" name="moblphonNo" value='<c:out value="${result.moblphonNo}" />'>
				<input type="hidden" name="updateDt" value="<c:out value='${result.updateDt}'/>" />
				<input type="hidden" name="updateErId" value="<c:out value='${result.updateErId}'/>" />
				<input type="hidden" name="status" value="<c:out value='${result.status}'/>" />
				<input type="hidden" name="rippleTradeId" value="<c:out value='${result.rippleTradeId}'/>" />
				<input type="hidden" name="rippleTradeEmail" value="<c:out value='${result.rippleTradeEmail}'/>" />
				<input type="hidden" name="dumPointCardNo" value="<c:out value='${result.dumPointCardNo}'/>" />
			</div>
		</c:forEach>

			<!--//팝업 레이어 -->
			<div class="pop-layer-cover">
				<div class="bg"></div>
				<div id="layer2" class="pop-layer">
					<div class="pop-container">
						<div class="pop-conts">
							<!--//content -->
							<p class="ctxt mb20"><strong><span>처리 결과 조회</span></strong><br>
							</p>
							<div class="layerContent">
								<form name = "popupForm" >
									<input type="hidden"  name="tradeId">
									<input type="hidden" name="isUpdated" value="N"/>
									
									<div class="bview_box">
										<ul>
											<li class="full"><strong><span>내용</span></strong><span id="targetSubjectText"></span></li>
				                            <li class="full"><strong><span>등록자(연락처)</span></strong><span id="targetErText"></span></li>
				                            <li class="full"><strong><span>등록일</span></strong><span id="targetDateText"></span></li>
				                            <li class="full"><strong><span>리플트레이드id</span></strong><span id="targetRippleTradeId"></span></li>
				                            <li class="full"><strong><span>리플트레이드주소</span></strong><span id="targetRippleTradeEmail"></span></li>
				                            <li class="full"><strong><span>덤포인트카드번호</span></strong><span id="targetDumPointCardNo"></span></li>
				                        </ul>
				                    </div>
				                    
				                    <div class="bview_box">
										<ul>
											<li class="full"><strong><span>처리자</span></strong><span id="targetLastErText"></span></li>
				                            <li class="full"><strong><span>처리일</span></strong><span id="targetLastDateText"></span></li>
											<div id ="statusYes">
												<li class="full"><strong><span>리플 처리 기준금액 (A)</span></strong><div id="targetResultUnitPrice" name="targetResultUnitPrice"></div></li>
												<li class="full"><strong><span>리플 처리 매매수량  (B)</span></strong><div id="targetResultQty" name="targetResultQty"></div></li>
												<li class="full"><strong><span>수수료 (C)</span></strong><div id="targetFee" name="targetFee"></div></li>
												<li class="full"><strong><span>총합계 (A*B+C)</span></strong><div id="targetResultTotMoney" name="targetResultTotMoney" ></div></li>
											</div>

				                        </ul>
				                    </div>
								</form>
							</div>
							<div class="layerContent_result">
							</div>
							<div class="btn-r">
								<div  class="cbtn">Close</div>
							</div>
							<!--//content -->
						</div>
					</div>
				</div>
			</div>
			<!--//팝업 레이어 -->			
			<!--pageing -->                    
			 <div class="paginate_complex">
			<ui:pagination paginationInfo="${paginationInfo}" type="supportImage" jsFunction="linkPage" />
			</div>
			<!--//pageing -->
		</div>		
            <!-- //목록리스트 -->
	
	<!--본문 끝-->

	<!--우측메뉴 시작-->
	<%@ include file="../include/rightMenu.jsp" %></div>

<script type="text/javaScript" language="javascript">
	$(function(){
		
		$("subForm").attr({action:"${contextPath}/customer/insertPhoneCouncelArticle.do", target:""});
		
		$( "#resultUnitPrice, #resultQty,  #fee" ) .change(function () {
			var a = parseInt($( "#resultUnitPrice" ).val());
			var b = parseInt($( "#resultQty" ).val());
			var c = parseInt($( "#fee" ).val());
			$("#resultTotMoney").val(a*b+c);
		}).focus(function(){
			
		});
		
	});
	
	// 네비게시이션 이동
	function linkPage(pageNo){
		$("#subForm input[name=pageIndex]").val(pageNo); 
		$('#subForm').attr('action', '${contextPath}/customer/phoneQnAList.do'); 
		$("#subForm").submit();
	}
</script>

<script type="text/javascript">
	function layer_open(el, seq){

		$(".layerContent_result").hide();
		$(".layerContent").show();
		
		var temp = $('#' + el);
		var bg = temp.prev().hasClass('bg');	//dimmed 레이어를 감지하기 위한 boolean 변수

		if(bg){
			$('.pop-layer-cover').fadeIn();	//'bg' 클래스가 존재하면 레이어가 나타나고 배경은 dimmed 된다. 
		}else{
			temp.fadeIn();
		}

		// 화면의 중앙에 레이어를 띄운다.
		if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
		else temp.css('top', '0px');
		if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
		else temp.css('left', '0px');
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////

		var tradeId =  $("div[name=bbs_lst]:eq("+seq+") input[name=tradeId]").val();;
		var tradeTypeNm =  $("div[name=bbs_lst]:eq("+seq+") input[name=tradeTypeNm]").val();;
		var requestBuyMoneyOrSellQty =  $("div[name=bbs_lst]:eq("+seq+") input[name=requestBuyMoneyOrSellQty]").val();;
		var mberNm =  $("div[name=bbs_lst]:eq("+seq+") input[name=mberNm]").val();
		var moblphonNo = $("div[name=bbs_lst]:eq("+seq+") input[name=moblphonNo]").val();
		var requestDt = $("div[name=bbs_lst]:eq("+seq+") input[name=requestDt]").val();
		
		var resultUnitPrice = $("div[name=bbs_lst]:eq("+seq+") input[name=resultUnitPrice]").val();
		var resultQty = $("div[name=bbs_lst]:eq("+seq+") input[name=resultQty]").val();
		var fee = $("div[name=bbs_lst]:eq("+seq+") input[name=fee]").val();
		var resultTotMoney = $("div[name=bbs_lst]:eq("+seq+") input[name=resultTotMoney]").val();
		
		var updateDt = $("div[name=bbs_lst]:eq("+seq+") input[name=updateDt]").val();
		var updateErId = $("div[name=bbs_lst]:eq("+seq+") input[name=updateErId]").val();
		var status = $("div[name=bbs_lst]:eq("+seq+") input[name=status]").val();
		var rippleTradeId = $("div[name=bbs_lst]:eq("+seq+") input[name=rippleTradeId]").val();
		var rippleTradeEmail =  $("div[name=bbs_lst]:eq("+seq+") input[name=rippleTradeEmail]").val();;
		var dumPointCardNo =  $("div[name=bbs_lst]:eq("+seq+") input[name=dumPointCardNo]").val();;
		
		$("#targetSubjectText").html("["+tradeTypeNm+" 요청] "+requestBuyMoneyOrSellQty);
		$("#targetErText").html(mberNm+ ' ( '+moblphonNo+' ) ');
		$("#targetDateText").html(requestDt);

		$("#targetLastErText").html(updateErId);
		$("#targetLastDateText").html(updateDt);
		
		$("#targetResultUnitPrice").html(resultUnitPrice);
		$("#targetResultQty").html(resultQty);
		$("#targetFee").html(fee);
		$("#targetResultTotMoney").html(resultTotMoney);		
		
		$("#targetRippleTradeId").html(rippleTradeId);		
		$("#targetRippleTradeEmail").html(rippleTradeEmail);		
		$("#targetDumPointCardNo").html(dumPointCardNo);		
		

		
		$("form[name=popupForm] input[name=tradeId]").val(tradeId);
//////////////////////////////////////////////////////////////////////////////////////////////////



			
		temp.find('div.cbtn').click(function(e){
			if(bg){
				$('.pop-layer-cover').fadeOut(); //'bg' 클래스가 존재하면 레이어를 사라지게 한다. 
			}else{
				temp.fadeOut();
			}
			e.preventDefault();
			if($("form[name=popupForm] input[name=isUpdated]").val() =='Y'){
				location.reload();	
			};			
		});
		
		//배경을 클릭하면 레이어를 사라지게 하는 이벤트 핸들러
		$('.pop-layer-cover .bg').click(function(e){	
			$('.pop-layer-cover').fadeOut();
			e.preventDefault();
		});
	}
</script>
