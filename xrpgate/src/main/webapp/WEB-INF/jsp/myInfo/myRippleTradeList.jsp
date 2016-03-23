<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<div class="con_title">
  <li>
    <img src="/images/sub/mypage_title.png" />
  </li>
</div> 
<div class="content">
    <div class="content_in">
        <div class="con_info">
        	<div class="mypage_table">
                <table class="mylist_table" cellpadding="0" cellspacing="0" border="0">
                    <tr class="my_title">
                        <td class="list_01">신청일시</td>
                        <td class="list_02">구분</td>
                        <td class="list_03">신청금액</td>
                        <td class="list_02">수수료</td>
                        <td class="list_04">My 리플지갑</td>
                        <td class="list_05">상태</td>
                        <td class="list_06">완료일시</td>
                        <td class="list_07">비고</td>
                    </tr>
                    <c:forEach var="result" items="${accountVo}" varStatus="status">
                   	<tr class="my_info">
                        <td class="list_01"><li>${result.requestDt }</li></td>
                        <td class="list_02"><li>${result.tradeType }</li></td>
                        <td class="list_03 numberic"><li>${result.transactionsMoney }</li></td>
                        <td class="list_02"><li>${result.tradeCharge }%</li></td>
                        <td class="list_04 numberic"><li>${result.xrpDeposit }</li></td>
                        <td class="list_05"><li>${result.status }</li></td>
                        <td class="list_06"><li>${result.tradeCompleteDt }</li></td>
                        <td class="list_07"><li>${result.remark }</li></td>
                    </tr>
                    </c:forEach>
                </table>
            </div>
            <div class="mypage_table_info">
                <li>* 고객님께서 신청한 거래내역이 나타나는 표 입니다.</li>
                <li>* 처리과정을 참고하시면서 대기해주세요.</li>
                <li>* 거래에 따라 처리가 지연되거나 취소될 수 있습니다.</li>          
            </div>
        </div>
    </div>    
</div>

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
		
		$(".numberic").each(function(){
			var num = $(this).text();
			var idx = num.indexOf(".");
			var pointer ; 
			if(idx < 0 ){
				pointer = 0;
			} else {
				pointer = num.substr(idx+1, num.length).length;
			}
			
			$(this).text($.number($(this).text(), pointer));	
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
