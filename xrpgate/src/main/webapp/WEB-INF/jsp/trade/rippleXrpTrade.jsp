<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<%@ include file="../tiles/total/middleTop.jsp" %>

<style>

.simple_deal_standard li.numberic {
    width:130px;
    line-height: 33px;
}
.simple_deal_standard li.unit {
    color: #666;
    float: left;
    margin-right: 1px;
    font-size: 25px;
    line-height: 33px;
    width:69px;
}
</style>
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
                        <li class="wallet_no numberic">${accountVO.xrpDeposit }</li>
                        <input type="hidden" name="currentXrp" value="${accountVO.xrpDeposit }"/>
                    </div>
                    
                    <div class="wallet_line">
                    	<li class="wallet_title"><img src="/images/sub/unit_krw.png" /></li>
                        <li class="wallet_no numberic">${accountVO.deposit }</li>
                        <input type="hidden" name="currentDeposit" value="${accountVO.deposit }"/>
                    </div>
                    <!-- 
                    <div class="wallet_line">
                    	<li class="wallet_title"><img src="/images/sub/unit_usd.png" /></li>
                        <li class="wallet_no">0</li>
                    </div>
                     -->
                </div>
                
                <div class="wallet_box" style="margin-right:0px;">
                	<li class="wallet_box_title"><img src="/images/sub/asset.png" /></li>
                	<div class="wallet_line">
                    	<li class="wallet_title"><img src="/images/sub/unit_krw.png" /></li>
                        <li class="wallet_no numberic" id="totDeposit"></li>
                    </div>
                </div>
                
                <!-- 디자인 수정 시작 -->
                <div class="simeple_wrap">
                    <p class="simple_title">간편거래</p>
                    <div class="simple_deal">
                    	<div class="simple_info_box">
                        	<li class="simple_info">마켓주문으로 리플 구매&판매<p class="simple_gray"> - 현재 시세로 간편 구매 및 판매 주문을 합니다. 주문은 즉시 체결됩니다.</p>
                            </li>
                            
                            <li class="simple_info" style="color:red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            	인출은
                            	<p class="simple_gray" style="color:red"> 예탁/인출 메뉴에서 등록하시기 바랍니다.</p>
                            </li>
                        </div>
                        
                        <div class="simple_volume" style="margin-left:20px;">
                        	<div class="buy_xrp_title">XRP 구매</div>
                            
                            <div class="sell_xrp_box">
	                            <li class="sell_xrp_box_title">XRP GATE 통장 계좌번호</li>
                            	<li class="xrpgate_bank">${adminAccountVo.bankNm } 은행</li>
                                <li class="xrpgate_bank_no">${adminAccountVo.account}</li>
                            </div>
                            
                            <div class="sell_xrp_box">
	                            <li class="sell_xrp_box_title">구매금액</li>
                            	<li><input type="text" class="numberic" readonly="true" name="buyMoney"/></li>
                                <li class="unit">KRW</li>
                            </div>
                            
                            <div class="sell_xrp_box">
	                            <li class="sell_xrp_box_title">예상코인갯수</li>
                            	<li class="simple_number numberic" id="expectXrp"></li>
                                <li class="unit">XRP</li>
                            </div>
                                                        
                            <div class="sell_xrp_box">
	                            <li class="sell_xrp_box_title">매수가</li>
                            	<li class="simple_number numberic">${xrpPrice.purchasePrice }</li>
                            	<input type="hidden" name="purchasePrice" value="${xrpPrice.purchasePrice }"/>
                                <li class="unit">KRW</li>
                            </div>
                            <div class="sell_xrp_btn">
	                            <a href="javascript:insertSimppleTradeInfo('B')">매수 XRP</a>
                            </div>
                        </div>
                        
                        <div class="simple_deal_standard">
                        	<li class="stand_title">현재가격</li>
                            <li class="numberic">${xrpPrice.marketPrice }</li>
                            <li class="unit">KRW</li>
                            <input type="hidden" name="marketPrice" value="${xrpPrice.marketPrice }"/>
                        </div>
                        
                        <div class="simple_volume">
                        	<div class="buy_xrp_title">XRP 판매</div>
                            
                            <div class="sell_xrp_box">
	                            <li class="sell_xrp_box_title">XRP GATE 계정주소</li>
                                <li class="xrpgate_bank_no">${adminAccountVo.rippleTrade}</li>
                            </div>
                            
                            <div class="sell_xrp_box">
	                            <li class="sell_xrp_box_title">판매수량</li>
                            	<li><input type="text" class="numberic" name="sellQty"/></li>
                                <li class="unit">XRP</li>
                            </div>
                            
                            <div class="sell_xrp_box">
	                            <li class="sell_xrp_box_title">예상금액</li>
                            	<li class="simple_number numberic" id="expectMoney"></li>
                                <li class="unit">KRW</li>
                            </div>
                                                        
                            <div class="sell_xrp_box">
	                            <li class="sell_xrp_box_title">매도가</li>
                            	<li class="simple_number numberic">${xrpPrice.SellPrice }</li>
								<input type="hidden" name="SellPrice" value="${xrpPrice.SellPrice }"/>
                                <li class="unit">KRW</li>
                            </div>
                            <div class="sell_xrp_btn">
	                            <a href="javascript:insertSimppleTradeInfo('S')">매도 XRP</a>
                            </div>
                        </div>
                        <!--div class="simple_volume">
                            <p class="volume_title">구매수량</p>
                            <li><input type="text" /></li>
                            <!--li>
                                <select>
                                    <option>게이트웨이 선택</option>
                                    <option>XRP - Ripples</option>
                                    <option>KRW - South Korean Won</option>
                                </select>
                            </li>
                            <li class="add_gateway"><a href="#">게이트웨이 추가</a></li>
                             <div class="simple_sell">
                                <p class="sell_title">매수단가</p>  <!--Admin단에서 매수,매도 단가를 정하면 홈페이지에 나올 수 있게 연동부탁드립니다.-->
                                <!--div class="sell_box">
                                    <li class="sell_1">20.0000</li>
                                    <li class="sell_2">XRP</li>
                                    <li class="sell_3">(0.2000XRP / 원)</li>
                                </div>
                                <a href="#"><div class="sell_btn">BUY XRP</div></a>
                            </div>                            
                        </div>
                        
                        <div class="simple_volume" style="border-right:0px;">
                            <p class="volume_title">판매수량</p>
                            <li><input type="text" /></li>
                            <!--li>
                                <select>
                                    <option>게이트웨이 선택</option>
                                    <option>XRP - Ripples</option>
                                    <option>KRW - South Korean Won</option>
                                </select>
                            </li>
                            <li class="add_gateway"><a href="#">게이트웨이 추가</a></li-->
                             <!--div class="simple_sell">
                                <p class="sell_title">매도단가</p>
                                <div class="sell_box">
                                    <li class="sell_1">20.0000</li>
                                    <li class="sell_2">XRP</li>
                                    <li class="sell_3">(0.2000XRP / 원)</li>
                                </div>
                                <a href="#"><div class="sell_btn">SELL XRP</div></a>
                            </div-->                            
                        </div>              
                    </div>
                </div>
                <!-- 고급거래는 필요시 다시 열 영역입니다.
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
                 -->
                <!-- 디자인 수정 완료 -->
                <div class="myorder">
                	<div class="myorder_title">
                	<img src="/images/sub/my_deal.png" />
                	</div>
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
	                        	<td class="list_01 numberic">${result.requestQty}</td>
	                            <td class="list_02">${result.productType}</td>
	                            <td class="list_03">${result.paymentCurrency}</td>
	                            <td class="list_02 numberic">${result.requestMoney}</td>
	                            <td class="list_04">${result.status}</td>
	                        </tr>
	                    	</c:forEach>
                        </table>
                    </div>                
                </div>
                
                <div class="order_book">
                	<div class="order_book_title">
                	<img src="/images/sub/orderbook.png" />
                	
                	</div>
                	<div class="order_table_title">매수</div>
                    <div class="order_book_table">
                    	<table cellpadding="0" cellspacing="0" border="0"> 
                        	<tr class="order_book_table_title">
                            	<td>총 XRP</td>
                                <td>규모 XRP</td>
                                <td>매수가 KRW</td>
                            </tr>
                            <c:forEach var="result" items="${buyTrade}" varStatus="status">
	                    	<tr class="order_book_table_text" >
	                    		<td>
	                            	<li>
	                        			<p class="order_big numberic">${fn:substring(result.rowSum,0,fn:indexOf(result.rowSum, '.'))}</p>
	                        			<p class="order_small">${fn:substring(result.rowSum,fn:indexOf(result.rowSum, '.'),999)}</p>
	                        		</li>
								</td>
	                    		<td><li class="numberic">${result.requestQty}</li></td>
	                        	<td>
	                        		<li>
	                        			<p class="order_big numberic">${fn:substring(result.requestMoney,0,fn:indexOf(result.requestMoney, '.'))}</p>
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
                	<div class="order_table_title">매도</div>
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
	                        			<p class="order_big numberic">${fn:substring(result.requestMoney,0,fn:indexOf(result.requestMoney, '.'))}</p>
	                        			<p class="order_small">${fn:substring(result.requestMoney,fn:indexOf(result.requestMoney, '.'),999)}</p>
	                        		</li>
	                        	</td>
	                    		<td><li class="numberic">${result.requestQty}</li></td>
	                            <td>
	                            	<li>
	                        			<p class="order_big numberic">${fn:substring(result.rowSum,0,fn:indexOf(result.rowSum, '.'))}</p>
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
<input type="hidden" name="expectRequestMoney" />
<input type="hidden" name="expectRequestQty" />
<input type="hidden" name="chkStatus" value="${chkStatus }">
<script type="text/javaScript" language="javascript">
	$(function(){
		var marketPrice = parseFloat($("[name=marketPrice]").val());
		var xrpDeposit = parseFloat($("[name=currentXrp]").val());
		var deposit = parseFloat($("[name=currentDeposit]").val());
		
		fn_setBuyTrade();
		
		$("#totDeposit").text( fn_numberRound(deposit + (marketPrice*xrpDeposit), 4)  );
		
		$("[name=sellRequestQty], [name=sellRquesetMoney]").change(function(e){
			var sellRequestQty = $("[name=sellRequestQty]").val();
			var sellRequestMoney = $("[name=sellRquesetMoney]").val();
			if(sellRequestQty == null || sellRequestQty ==""){
				return;
			}  
			if(sellRequestMoney == null || sellRequestMoney ==""){
				return;
			} 
			var sellTotalMoney = fn_numberRound(sellRequestQty*sellRequestMoney, 4);
			
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
			var sellTotalMoney = fn_numberRound(sellRequestQty*sellRequestMoney, 4);
			
			$("[name=buyTotMoney]").val(sellTotalMoney);
			
		});
		
		// 20160213 리플 지갑에 있는 금액 전부 xrp 구매에 사용됨. 
		/* $("[name=buyMoney]").on("keypress", function(e){
			return buyTradeChg();
		}); */
		
		 $("[name=sellQty]").on("keyup", function(e){
			sellTradeChg();
		});
		 
		$('[name=sellQty]').number( true );
		
		/* $(".numberic").each(function(){
			var num = fn_numberRound($(this).text(), 4);
			var idx = num.indexOf(".");
			var pointer ; 
			if(idx < 0 ){
				pointer = 0;
			} else {
				pointer = num.substr(idx+1, num.length).length;
			} 
			
			$(this).text(num);
		});*/
		
		
	});
	
	function insertSimppleTradeInfo(tradeType){
			
		var requestMoney = "";
		var requestQty = "";
		var resultTotMoney ;
		if(tradeType == "B"){
			//buyTradeChg();
			// 최근 매수주문중 거래완료가 안된 주문이 있다면 추가 주문이 안됨.
			var chkStatus = $("[name=chkStatus]").val();
			if(chkStatus == "false"){
				alert("매수 주문이 진행중입니다.");
				return;
			}
			requestQty = $("[name=expectRequestQty]").val();
			requestMoney = parseFloat($("[name=purchasePrice]").val()); 
			resultTotMoney = parseFloat($("[name=currentDeposit]").val());
			if(requestMoney == 0){
				alert("금액을 확인하여 주십시오.");
				return;
			}
		} else {
			 /* if(!sellTradeChg()){
				return ;
			}; */ 
			requestQty = parseInt($("[name=sellQty]").val());
			
			if(requestQty == 0 ){
				alert("수량을 확인하여 주십시오.");
				return;
			}
			requestMoney = parseFloat($("[name=SellPrice]").val());
			resultTotMoney = parseFloat($("[name=expectRequestMoney]").val());
		}
		
		var status = "S01"; // 처리준비중 
		
		var url = "${contextPath}/trade/insertXrpTrade.do";
		var para = {
				tradeType : tradeType
				, requestQty : requestQty
				, requestMoney : requestMoney
				, resultTotMoney : resultTotMoney
				, status : status
				, productType : "XRP"
				, paymentCurrency : "KRW"
		}
		
		sendPost(url, para, "fn_insertTradeResult");
	}
	
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
				html += 	'<td class="list_02 numberic">'+ data.tradeList[i].requestQty +'</td>';
				html += 	'<td class="list_03">'+ data.tradeList[i].productType +'</td>';
				html += 	'<td class="list_04">'+data.tradeList[i].paymentCurrency+'</td>';
				html += 	'<td class="list_05 numberic">'+data.tradeList[i].requestMoney+'</td>';
				html += 	'<td class="list_05">'+data.tradeList[i].status+'</td>';
				html += '</tr>';
			}
			// 고급 거래 필드 초기화
			$("input[name=buyRequestQty]").val('');
			$("input[name=sellRequestQty]").val('');
			$("[name=buyRquesetMoney]").val('');
			$("[name=sellRquesetMoney]").val('');
			$("[name=buyTotMoney]").val('');
			$("[name=sellTotMoney]").val('');
			
			//간편 거래 초기화.
			$("[name=buyMoney]").val('');
			$("[name=sellQty]").val('');
			
			// 거래 리스트 다시 그림.
			$("#tradeList tr").filter(".data").remove();
			$("#tradeList").append(html);
			
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
			
			alert(data.message);
			
			location.reload();
		} else {
			alert("등록에 실패하였습니다.");
		}
	}
	
	// 20160213 리플 지갑에 있는 금액 전부 xrp 구매에 사용됨. 
	function buyTradeChg() {
		var buyMoney = parseFloat($("[name=buyMoney]").val());
		var currentDeposit = parseFloat($("[name=currentDeposit]").val());
		var purchasePrice = parseFloat($("[name=purchasePrice]").val());
		
		if( buyMoney > currentDeposit){
			alert("보유하신 KRW금액을 초과하셧습니다.");
			return false;
		}
		
		var buyPrice = fn_numberRound(buyMoney / purchasePrice, 4);
		$("#expectXrp").html(buyPrice);
		$("[name=expectRequestQty]").val(buyPrice);
		
		return true;
	}
	
	function sellTradeChg() {
		var sellQty = parseFloat($("[name=sellQty]").val());
		var currentXrp = parseFloat($("[name=currentXrp]").val());
		var SellPrice = parseFloat($("[name=SellPrice]").val());
		
		 /* if( sellQty > currentXrp){
			alert("보유하신 xrp수량을 초과하셧습니다.");
			$("[name=sellQty]").val(0);
			return false;
		}  */
		

		$("#expectMoney").html(fn_numberRound(sellQty * SellPrice, 4));
		$("[name=expectRequestMoney]").val(sellQty * SellPrice);
		
		return true;
	}
	
	function fn_setBuyTrade() {
		
		var currentDeposit = parseFloat($("[name=currentDeposit]").val());
		var purchasePrice = parseFloat($("[name=purchasePrice]").val());
		$("[name=buyMoney]").val(fn_numberRound($("[name=currentDeposit]").val(),4));
		var buyPrice = fn_numberRound(currentDeposit / purchasePrice, 4);
		$("#expectXrp").html(buyPrice);
		$("[name=expectRequestQty]").val(buyPrice);
		
		return true;
	}
	
</script>

