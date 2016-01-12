<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<div class="con_title">
	  <li>
      	<img src="/images/sub/deposit-draw_title.png" />
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
                
                <div class="deposit-line"></div>
                
                <div class="deposit">
                	<div class="deposit_title"><img src="/images/sub/deposit_title.png" /></div>
                    <div class="deposit_info">
                    	<li>● 예탁하기 란에 정보 입력 후 확인 버튼을 클릭합니다.</li>
                        <li>● 예탁금 입금시 (ex:태그번호/이름 => 011/홍길동)형식으로 표시합니다.</li>
                        <li>● 태그번호는 "마이페이지>회원정보"에서 확인합니다.</li>
                        <li>● 예탁금계좌 - <b>국민은행 123456-00-12345 엑스알피게이트(주)</b> </li>
                        <li>● 예탁금 입금이 완료되면 회원님의 계정에 자동 반영됩니다.</li>
                        <li>● 예탁금액 및 보내시는 분의 성함이 일치하지 않을경우 예탁금 반영이 지연될 수 있습니다.</li>
                        <li class="deposit_red">★ 예탁 가능한 최소금액은 100,000원 입니다. ★</li>
                    </div>
                    <div class="deposit_table">
                    	<table border="0" cellpadding="0" cellspacing="0">
                        	<tr>
                            	<td class="de_table_title">예탁금 계좌 잔액</td>
                                <td class="de_table_text">${accountVO.deposit }</td>
                            </tr>
                            <tr>
                            	<td class="de_table_title">이름</td>
                                <td class="de_table_text">홍길동</td>
                            </tr>
                            <tr>
                            	<td class="de_table_title">입금신청 예탁금액</td>
                                <td class="de_table_text"><input type="text" name="deposit" />원</td>
                            </tr>
                            <tr>
                            	<td class="de_table_title">수수료</td>
                                <td class="de_table_text"><c:out value="${accountVO.charge == null ? '1.0': accountVO.charge }"/></td>
                            </tr>
                            <tr>
                            	<td class="de_table_title">입금예탁금액(KRW)<br />-수수료 제외금액</td>
                                <td class="de_table_text"><input type="text" name="realDeposit"/>원</td>
                            </tr>
                        </table>
                    </div>
                    <div class="deposit_btn">
                    	<a href="javascript:insertDepositInfo('D')"><img src="/images/btn/deposit_btn.png" /></a>
                    </div>
                </div>
                
                <div class="draw">
                	<div class="draw_title"><img src="/images/sub/draw_title.png" /></div>
                    <div class="draw_info">
                    	<li>● 인출하기 란에 정보 입력 후 확인 버튼을 클릭합니다.</li>
                        <li>● 회원가입 시 입력한 은행, 계좌번호로 출금됩니다.
                        <li>● 계좌를 입력하지 않은 회원께서는 꼭 계좌번호를 입력하셔야 합니다.</li>
                        <li>● 인출하여 지정계좌에 입금이 완료되면 회원님의 계정에 자동 반영됩니다. </li>
                        <li>● 인출금액에 대한 정보가 일치하지 않을 경우 인출금 반영이 지연될 수 있습니다.</li>
                        <li>● 인출시 유의사항<br />
                        	<p> - xrpgate 거래소 홈페이지 인출하기 완료 후</p>
                            <p> - 리플트레이드 접속, xrpgate 거래소로 KRW보내기</p>
                            <p> - KRW를 거래소로 보내지 않으면 인출이 지연될 수 있습니다.</p>
                        </li>
                        <li class="draw_red">★  인출 가능한 최소금액은 30,000원 입니다. ★</li>
                    </div>
                    <div class="draw_table">
                    	<table border="0" cellpadding="0" cellspacing="0">
                        	<tr>
                            	<td class="dr_table_title">인출가능 KRW</td>
                                <td class="dr_table_text">${accountVO.deposit }</td>
                            </tr>
                            <tr>
                            	<td class="dr_table_title">이름</td>
                                <td class="dr_table_text">홍길동</td>
                            </tr>
                            <tr>
                            	<td class="dr_table_title">인출신청 예탁금액</td>
                                <td class="dr_table_text"><input type="text"  name="witdraw"/>원</td>
                            </tr>
                            <tr>
                            	<td class="dr_table_title">수수료</td>
                                <td class="dr_table_text">
                                	<c:out value="${accountVO.charge == null ? '1.0': accountVO.charge }"/>
                                </td>
                            </tr>
                            <tr>
                            	<td class="dr_table_title">인출예탁금액(KRW)<br />-수수료 제외금액</td>
                                <td class="dr_table_text"><input type="text" name="realWitdraw"/>원</td>
                            </tr>
                        </table>
                    </div>
                    <div class="draw_btn"><a href="javascript:insertDepositInfo('W')"><img src="/images/btn/draw_btn.png" /></a></div>
                </div>
                
                <div class="mylist">
                	<div class="mylist_title"><img src="/images/sub/deal_list.png" /></div>
                    <table class="mylist_table" id="accountList" cellpadding="0" cellspacing="0" border="0">
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
                        <c:forEach var="result" items="${listVo}" varStatus="status">
                    	<tr class="my_title data" >
                        	<td class="list_01">${result.requestDt}</td>
                            <td class="list_02">${result.tradeType}</td>
                            <td class="list_03">${result.transactionsMoney}</td>
                            <td class="list_02">${result.tradeCharge}</td>
                            <td class="list_04">${result.fee}</td>
                            <td class="list_05">${result.status}</td>
                            <td class="list_06">${result.tradeCompleteDt}</td>
                            <td class="list_07">${result.remark}</td>
                        </tr>
                    	</c:forEach>
                    </table>
                </div>
            </div>
        </div>    
    </div>
<input type="hidden" name="charge" value="${accountVO.charge == null ? '0.1': accountVO.charge }" />
<script type="text/javaScript" language="javascript">
	$(function(){
		$("input[name=deposit]").change(function(e){
			var charge = $("[name=charge]:hidden").val();
			var deposit = $(this).val();
			
			var realDeposit = (deposit * ((100-charge)/100)).toFixed(4);
			
			$("[name=realDeposit]").val(realDeposit);
			
		});
		
		$("input[name=witdraw]").change(function(e){
			var charge = $("[name=charge]:hidden").val();
			var deposit = $(this).val();
			
			var realDeposit = (deposit * ((100-charge)/100)).toFixed(4);
			
			$("[name=realWitdraw]").val(realDeposit);
			
		});
	});
	
	function insertDepositInfo(tradeType){
		
		var deposit = "";
		if(tradeType == "D"){
			deposit = $("input[name=deposit]").val();
		} else {
			deposit = $("input[name=witdraw]").val();
		}
		
		var transactionCharge = $("[name=charge]:hidden").val();
		var status = "S01"; // 처리중비중 
		var fee = deposit - $("[name=realDeposit]").val();
		
		var url = "${contextPath}/trade/insertTransactionInfo.do";
		var para = {
				tradeType : tradeType
				, transactionsMoney : deposit
				, tradeCharge : transactionCharge
				, status : status
				, fee : fee
		}
		
		sendPost(url, para, "fn_insertTransactionResult");
	}
	
	function fn_insertTransactionResult(data){
		var html="";
		if(data.isSuccess){
			for(var i = 0 ; i < data.listVo.length;i++){
				html += '<tr class="my_title data" >';
				html += 	'<td class="list_01">'+data.listVo[i].requestDt+'</td>';
				html += 	'<td class="list_02">'+data.listVo[i].tradeType+'</td>';
				html += 	'<td class="list_03">'+data.listVo[i].transactionsMoney+'</td>';
				html += 	'<td class="list_02">'+data.listVo[i].tradeCharge+'</td>';
				html += 	'<td class="list_04">'+data.listVo[i].fee+'</td>';
				html += 	'<td class="list_05">'+data.listVo[i].status+'</td>';
				html += 	'<td class="list_06">'+data.listVo[i].tradeCompleteDt+'</td>';
				html += 	'<td class="list_07">'+data.listVo[i].remark+'</td>';
				html += '</tr>';
			}
			$("input[name=deposit]").val('');
			$("input[name=witdraw]").val('');
			$("[name=realDeposit]").val('');
			$("[name=realWitdraw]").val('');
			$("#accountList tr").filter(".data").remove();
			$("#accountList").append(html);
		} else {
			
		}
	}
</script>

