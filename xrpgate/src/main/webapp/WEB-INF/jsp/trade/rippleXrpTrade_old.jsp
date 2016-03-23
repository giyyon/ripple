<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<%@ include file="../tiles/total/middleTop.jsp" %>

<div class="con_title">
	  <li>
      	<img src="/images/sub/deal_title.png" />
      </li>
  </div> 
<div class="content">
    	<div class="content_in">
            <div class="con_info">
            	<div class="wallet_box">
                	<li class="wallet_box_title"><img src="/images/sub/mywallet.png" /></li>
                	<div class="wallet_line">
                    	<li class="wallet_title"><img src="/images/sub/unit_xrp.png" /></li>
                        <li class="wallet_no">${accountVO.xrpDeposit }</li>
                    </div>
                    
                    <div class="wallet_line">
                    	<li class="wallet_title"><img src="/images/sub/unit_krw.png" /></li>
                        <li class="wallet_no">${accountVO.deposit }</li>
                    </div>
                    
                    <div class="wallet_line">
                    	<li class="wallet_title"><img src="/images/sub/unit_usd.png" /></li>
                        <li class="wallet_no">0</li>
                    </div>
                </div>
                
                <div class="wallet_box" style="margin-right:0px;">
                	<li class="wallet_box_title"><img src="/images/sub/asset.png" /></li>
                	<div class="wallet_line">
                    	<li class="wallet_title"><img src="/images/sub/unit_krw.png" /></li>
                        <li class="wallet_no">${accountVO.deposit }</li>
                    </div>
                </div>
                <div class="simeple_wrap">
                    <p class="simple_title">간편거래</p>
                    <div class="simple_deal">
                        <li class="simple_info">마켓주문으로 리플 구매<p class="simple_gray"> - 현재 시세로 간편 구매 주문을 합니다. 주문은 즉시 체결됩니다.</p></li>
                        <div class="simple_volume">
                            <p class="volume_title">구매수량</p>
                            <li><input type="text" /></li>
                            <li>
                                <select>
                                    <option>게이트웨이 선택</option>
                                    <option>XRP - Ripples</option>
                                    <option>KRW - South Korean Won</option>
                                </select>
                            </li>
                            <li class="add_gateway"><a href="#">게이트웨이 추가</a></li>
                        </div>
                        
                        <div class="simple_sell">
                            <p class="sell_title">매도</p>
                            <div class="sell_box">
                                <li class="sell_1">20.0000</li>
                                <li class="sell_2">XRP</li>
                                <li class="sell_3">(0.2000XRP / 원)</li>
                            </div>
                            <a href="#"><div class="sell_btn">SELL XRP</div></a>
                        </div>
                    </div>
                </div>
                
                <div class="high_wrap">
                    <p class="high_title">고급거래</p>
                    <div class="high_deal">
                    	<div class="gateway_chk">
                        	<li>
                                <select>
                                    <option>거래소 선택</option>
                                    <option>XRP/USD.SnapSwap</option>
                                    <option>XRP/USD.Bitstamp</option>
                                    <option>XRP/JPY.TokyoJPY</option>
                                    <option>BTC.Bitstamp/XRP</option>
                                    <option>BTC.SnapSwap/XRP</option>
                                </select>
                            </li>
                            <li class="gateway_btn"><a href="#">Flip</a></li>
                            <li class="gateway_btn"><a href="#">Add pair</a></li>
                            <li class="gateway_btn"><a href="#">Edit Pairs</a></li>
                        </div>
						<div class="gray_number">
                        	<div class="number_box">
                            	<li>매수 =&nbsp;</li>
                                <li> 0.0042790</li>
                            </div>
                            
                            <div class="number_box">
                            	<li> 호가 =&nbsp;</li>
                                <li> 0.0043961</li>
                            </div>
                            
                            <div class="number_box">
                            	<li>펼치기 =&nbsp;</li>
                                <li> 0.0000997</li>
                            </div>
                            
                            <div class="number_box">
                            	<li>종가 =&nbsp;</li>
                                <li> 0.0045494</li>
                            </div>
                        </div>
                        <div class="deal_blue_line"></div>
                        <div class="buy_xrp">
                        	<div class="buy_xrp_title">XRP 구매</div>
                        	
                        	<div class="sell_xrp_box">
	                            <li class="sell_xrp_box_title">Amount To Buy</li>
                            	<li><input type="text" name="buyRequestQty"/></li>
                                <li class="unit">XRP</li>
                            </div>
                            
                            <div class="sell_xrp_box">
	                            <li class="sell_xrp_box_title">각각의 금액</li>
                            	<li><input type="text" name="buyRquesetMoney"/></li>
                                <li class="unit">KRW</li>
                            </div>
                            
                            <div class="sell_xrp_box">
	                            <li class="sell_xrp_box_title">주문가(최대)</li>
                            	<li><input type="text" readonly="true" name="buyTotMoney"/></li>
                                <li class="unit">KRW</li>
                            </div>
                            <div class="sell_xrp_btn">
	                            <a href="javascript:insertTradeInfo('B')">매수 XRP</a>
                            </div>
                        </div>
                        
                        <div class="sell_xrp">
                        	<div class="sell_xrp_title">XRP 판매</div>
                            
                            <div class="sell_xrp_box">
	                            <li class="sell_xrp_box_title">Amount To Sell</li>
                            	<li><input type="text" name="sellRequestQty"/></li>
                                <li class="unit">XRP</li>
                            </div>
                            
                            <div class="sell_xrp_box">
	                            <li class="sell_xrp_box_title">각각의 금액</li>
                            	<li><input type="text" name="sellRquesetMoney"/></li>
                                <li class="unit">KRW</li>
                            </div>
                            
                            <div class="sell_xrp_box">
	                            <li class="sell_xrp_box_title">주문가(최대)</li>
                            	<li><input type="text" readonly="true" name="sellTotMoney"/></li>
                                <li class="unit">KRW</li>
                            </div>
                            <div class="sell_xrp_btn">
	                            <a href="javascript:insertTradeInfo('S')">매도 XRP</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="myorder">
                	<div class="myorder_title"><img src="/images/sub/my_deal.png" /></div>
                    <div class="myorder_table">
                    	<table cellpadding="0" cellspacing="0" border="0" id="tradeList">
                        	<tr class="table_title">
                        		<td></td>
                            	<td>QTY</td>
                                <td>BASE</td>
                                <td>COUNTER</td>
                                <td>LIMIT PRICE</td>
                                <td>동작</td>
                            </tr>
                            <c:forEach var="result" items="${tradeList}" varStatus="status">
	                    	<tr class="table_text data" >
	                    		<td class="list_01">${result.tradeType}</td>
	                        	<td class="list_01">${result.requestQty}</td>
	                            <td class="list_02">${result.productType}</td>
	                            <td class="list_03">${result.paymentCurrency}</td>
	                            <td class="list_02">${result.requestMoney}</td>
	                            <td class="list_04">${result.status}</td>
	                        </tr>
	                    	</c:forEach>
                        </table>
                    </div>                
                </div>
                
                <div class="order_book">
                	<div class="order_book_title"><img src="/images/sub/orderbook.png" /></div>
                	<div class="order_table_title">매수</div>
                    <div class="order_book_table">
                    	<table cellpadding="0" cellspacing="0" border="0"> 
                        	<tr class="order_book_table_title">
                            	<td>총 XRP</td>
                                <td>규모 XRP</td>
                                <td>매수가 KRW</td>
                            </tr>
                            <c:forEach var="result" items="${sellTrade}" varStatus="status">
	                    	<tr class="order_book_table_text" >
	                    		<td>
	                            	<li>
	                        			<p class="order_big">${fn:substring(result.rowSum,0,fn:indexOf(result.rowSum, '.'))}</p>
	                        			<p class="order_small">${fn:substring(result.rowSum,fn:indexOf(result.rowSum, '.'),999)}</p>
	                        		</li>
								</td>
	                    		<td><li>${result.requestQty}</li></td>
	                        	<td>
	                        		<li>
	                        			<p class="order_big">${fn:substring(result.requestMoney,0,fn:indexOf(result.requestMoney, '.'))}</p>
	                        			<p class="order_small">${fn:substring(result.requestMoney,fn:indexOf(result.requestMoney, '.'),999)}</p>
	                        		</li>
	                        	</td>
	                            
	                        </tr>
	                    	</c:forEach>
                        </table>                    
                    </div>
                </div>
                
                <div class="order_book" style="margin-left:120px;">
                	<div class="order_book_title"><img src="/images/sub/orderbook.png" /></div>
                	<div class="order_table_title">호가</div>
                    <div class="order_book_table">
                    	<table cellpadding="0" cellspacing="0" border="0"> 
                        	<tr class="order_book_table_title">
                            	<td>매도가 KRW</td>
                                <td>규모 XRP</td>
                                <td>총 XRP</td>
                            </tr>
                            <c:forEach var="result" items="${sellTrade}" varStatus="status">
	                    	<tr class="order_book_table_text" >
	                    		<td>
	                        		<li>
	                        			<p class="order_big">${fn:substring(result.requestMoney,0,fn:indexOf(result.requestMoney, '.'))}</p>
	                        			<p class="order_small">${fn:substring(result.requestMoney,fn:indexOf(result.requestMoney, '.'),999)}</p>
	                        		</li>
	                        	</td>
	                    		<td><li>${result.requestQty}</li></td>
	                            <td>
	                            	<li>
	                        			<p class="order_big">${fn:substring(result.rowSum,0,fn:indexOf(result.rowSum, '.'))}</p>
	                        			<p class="order_small">${fn:substring(result.rowSum,fn:indexOf(result.rowSum, '.'),999)}</p>
	                        		</li>
								</td>
	                        </tr>
	                    	</c:forEach>
                        </table>                    
                    </div>
                </div>
            </div>
        </div>    
    </div>
<input type="hidden" name="charge" value="${accountVO.charge == null ? '0.1': accountVO.charge }" />
<script type="text/javaScript" language="javascript">
	$(function(){
		$("[name=sellRequestQty], [name=sellRquesetMoney]").change(function(e){
			var sellRequestQty = $("[name=sellRequestQty]").val();
			var sellRequestMoney = $("[name=sellRquesetMoney]").val();
			if(sellRequestQty == null || sellRequestQty ==""){
				return;
			}  
			if(sellRequestMoney == null || sellRequestMoney ==""){
				return;
			} 
			var sellTotalMoney = fn_numberRound(sellRequestQty*sellRequestMoney,4);
			
			$("[name=sellTotMoney]").val(sellTotalMoney);
			
		});
		
		$("[name=buyRequestQty], [name=buyRquesetMoney]").change(function(e){
			var sellRequestQty = $("[name=buyRequestQty]").val();
			var sellRequestMoney = $("[name=buyRquesetMoney]").val();
			if(sellRequestQty == null || sellRequestQty ==""){
				return;
			}  
			if(sellRequestMoney == null || sellRequestMoney ==""){
				return;
			} 
			var sellTotalMoney = fn_numberRound(sellRequestQty*sellRequestMoney,4);
			
			$("[name=buyTotMoney]").val(sellTotalMoney);
			
		});
	});
	
	function insertTradeInfo(tradeType){
		
		var requestMoney = "";
		var requestQty = "";
		if(tradeType == "B"){
			requestQty = $("input[name=buyRequestQty]").val();
			requestMoney = $("input[name=buyRquesetMoney]").val();
		} else {
			requestQty = $("input[name=sellRequestQty]").val();
			requestMoney = $("input[name=sellRquesetMoney]").val();
		}
		
		var status = "S01"; // 처리중비중 
		
		
		var url = "${contextPath}/trade/insertXrpTrade.do";
		var para = {
				tradeType : tradeType
				, requestQty : requestQty
				, requestMoney : requestMoney
				, status : status
				, productType : "XRP"
				, paymentCurrency : "KRW"
		}
		
		sendPost(url, para, "fn_insertTradeResult");
	}
	
	function fn_insertTradeResult(data){
		var html="";
		
		if(data.isSuccess){
			for(var i = 0 ; i < data.tradeList.length;i++){
				html += '<tr class="table_text data" >';
				html += 	'<td class="list_01">'+ ( data.tradeList[i].tradeType )+'</td>';
				html += 	'<td class="list_02">'+ data.tradeList[i].requestQty +'</td>';
				html += 	'<td class="list_03">'+ data.tradeList[i].productType +'</td>';
				html += 	'<td class="list_04">'+data.tradeList[i].paymentCurrency+'</td>';
				html += 	'<td class="list_05">'+data.tradeList[i].requestMoney+'</td>';
				html += 	'<td class="list_05">'+data.tradeList[i].status+'</td>';
				html += '</tr>';
			}
			$("input[name=buyRequestQty]").val('');
			$("input[name=sellRequestQty]").val('');
			$("[name=buyRquesetMoney]").val('');
			$("[name=sellRquesetMoney]").val('');
			$("[name=buyTotMoney]").val('');
			$("[name=sellTotMoney]").val('');
			
			$("#tradeList tr").filter(".data").remove();
			$("#tradeList").append(html);
			
			alert(data.message);
		} else {
			
		}
	}
</script>

