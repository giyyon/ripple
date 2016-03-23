<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<%@ include file="../tiles/total/middleTop.jsp" %>

<div class="con_title">
	  <li>
      	<img src="/images/sub/proxy_title.png" />
      </li>
  </div> 
<div class="content">
    	<div class="content_in">
            <div class="con_info">
            	<div class="proxy_info">
                	<li>
                    	리플트레이드(Ripple Trade)를 통하여 리플을 거래하기 어려운 분을 위하여 쉽게 리플을 구매할 수 있는 방식입니다.
                    </li>
                    <li class="proxy_red">
                    	★ 최소 구매가능 리플수량 : 10,000(XRP)부터 / 매도량에 따라 구매가 지연 될 수 있습니다.
                    </li>
                </div> 
                <div class="proxy_table">         
                	<table cellpadding="0" cellspacing="0" border="0">
                    	<tr class="p_table_title">
                        	<td width="369px">항목</td>
                            <td width="830px">내용</td>
                        </tr>
                        <tr class="p_table_text">
                        	<td>XRPGate 예탁계좌</td>
                            <td class="p_table_text_in"><li>${adminAccountVo.bankNm } ${adminAccountVo.account}, 엑스알피트레이드</li></td>
                        </tr>
                        <tr class="p_table_text">
                        	<td>리플지갑 주소(Ripple Wallet)</td>
                            <td class="p_table_text_in"><li>${adminAccountVo.rippleTrade}</li></td>
                        </tr>
                        <tr class="p_table_text">
                        	<td>구매대행 리플 수량(XRP) - 최소 10,000(XRP)</td>
                            <td class="p_table_text_input">
                            	<li><input type="text" name="buyRequestQty"/></li>
                                <li>XRP</li>
                                <li><a href="#"><img src="/images/btn/circle_ok_btn.png" /></a></li>
                            </td>
                        </tr>
                        <tr class="p_table_text">
                        	<td>1리플당(1xrp당) 구매금액</td>
                            <td class="p_table_text_input">
                            	<li><input type="text" name="buyRquesetMoney"/></li>
                                <li>원</li>
                            </td>
                        </tr>
                        <tr class="p_table_text">
                        	<td>총 구매신청 금액</td>
                            <td class="p_table_text_input">
                            	<li><input type="text" readonly="true" name="buyTotMoney"/></li>
                                <li>원</li>
                            </td>
                        </tr>
                        <tr class="p_table_text">
                        	<td>구매대행 수수료 (5%)</td>
                            <td class="p_table_text_input">
                            	<li><input type="text" readonly="true" name="fee"/></li>
                                <li>XRP</li>
                            </td>
                        </tr>
                        <tr class="p_table_text">
                        	<td>총 구매가능 리플량(XRP)</td>
                            <td class="p_table_text_input">
                            	<li><input type="text" readonly="true" name="purchasableXrpQty"/></li>
                                <li>XRP</li>
                            </td>
                        </tr>
                    </table>
                    <div class="proxy_btn">
                    	<a href="javascript:insertTradeInfo('P')"><img src="/images/btn/proxy_btn.png" /></a>
                    </div>
                </div>
            </div>
        </div>    
    </div>
    
<script type="text/javaScript" language="javascript">
	$(function(){
		
		$("[name=buyRequestQty], [name=buyRquesetMoney]").change(function(e){
			var buyRequestQty = $("[name=buyRequestQty]").val();
			var buyRequestMoney = $("[name=buyRquesetMoney]").val();
			
			if(buyRequestQty == null || buyRequestQty ==""){
				return;
			}  else {
				if(buyRequestQty < 10000){
					alert("최소 구매 단위는 10000입니다.");
				}
			}
			if(buyRequestMoney == null || buyRequestMoney ==""){
				return;
			} 
			var sellTotalMoney = fn_numberRound(buyRequestQty*buyRequestMoney,4);
			var fee = fn_numberRound(sellTotalMoney*0.05,4);
			
			$("[name=buyTotMoney]").val(sellTotalMoney);
			$("[name=fee]").val(fee);
			
		});
	});
	
	function insertTradeInfo(tradeType){
		
		var requestMoney = "";
		var requestQty = "";
		var fee ="";
		
		requestQty = $("input[name=buyRequestQty]").val();
		requestMoney = $("input[name=buyRquesetMoney]").val();
		
		var status = "S01"; // 처리중비중 
		var fee = $("[name=fee]").val();
		
		var url = "${contextPath}/trade/insertXrpTrade.do";
		var para = {
				tradeType : tradeType
				, requestQty : requestQty
				, requestMoney : requestMoney
				, status : status
				, productType : "XRP"
				, paymentCurrency : "KRW"
				, fee : fee
		}
		
		sendPost(url, para, "fn_insertTradeResult");
	}
	
	function fn_insertTradeResult(data){
		var html="";
		
		if(data.isSuccess){
			alert(data.message);
			$("input[name=buyRequestQty]").val('');
			$("[name=buyRquesetMoney]").val('');
			$("[name=buyTotMoney]").val('');
			$("[name=fee]").val('');
		} else {
			
		}
	}
</script>

