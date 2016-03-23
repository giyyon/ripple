<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<%@ include file="../tiles/total/middleTop.jsp" %>

<style type="text/css">
.mylist_title img:hover {
    cursor: pointer;
}
.mask{width:100%; height:100%; position:fixed; left:0; top:0; z-index:10; background:#000; opacity:.5; filter:alpha(opacity=50);}

#modalLayer{display:none; position:relative;}
#modalLayer .modalContent{width:340px; height:100px; padding:20px; border:1px solid #ccc; position:fixed; left:50%; top:50%; z-index:11; background:#fff;}
#modalLayer .modalContent button{position:absolute; right:0; top:0; cursor:pointer;}
</style>

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
                        <li class="wallet_no numberic">${accountVO.xrpDeposit }</li>
                        <input type="hidden" name="currentXrp" value="${accountVO.xrpDeposit }"/>
                    </div>
                    
                    <div class="wallet_line">
                    	<li class="wallet_title"><img src="/images/sub/unit_krw.png" /></li>
                        <li class="wallet_no numberic">${accountVO.deposit }</li>
                        <input type="hidden" name="currentDeposit" value="${accountVO.deposit }"/>
                    </div>
                    
                </div>
                
                <div class="wallet_box" style="margin-right:0px;">
                	<li class="wallet_box_title"><img src="/images/sub/asset.png" /></li>
                	<div class="wallet_line">
                    	<li class="wallet_title"><img src="/images/sub/unit_krw.png" /></li>
                        <li class="wallet_no numberic" id="totDeposit"></li>
                    </div>
                </div>
                
                <div class="deposit-line"></div>
                
                <div class="deposit">
                	<div class="deposit_title"><img src="/images/sub/deposit_title.png" /></div>
                    <div class="deposit_info">
                    	<li>● 예탁하기 란에 정보 입력 후 확인 버튼을 클릭합니다.</li>
                        <li>● 예탁금 입금시 (ex:태그번호/이름 => 011/홍길동)형식으로 표시합니다.</li>
                        <li>● 태그번호는 "마이페이지>회원정보"에서 확인합니다.</li>
                        <li>● 예탁금계좌 - <b>${adminAccountVo.bankNm } ${adminAccountVo.account} 비즈월드트레이딩</b> </li>
                        <li>● 예탁금 입금이 완료되면 회원님의 계정에 자동 반영됩니다.</li>
                        <li>● 예탁금액 및 보내시는 분의 성함이 일치하지 않을경우 예탁금 반영이 지연될 수 있습니다.</li>
                        <li class="deposit_red">★ 예탁 가능한 최소금액은 100,000원 입니다. ★</li>
                    </div>
                    <div class="deposit_table">
                    	<table border="0" cellpadding="0" cellspacing="0">
                        	<tr>
                            	<td class="de_table_title">예탁금 계좌 잔액</td>
                                <td class="de_table_text numberic">${accountVO.deposit }</td>
                            </tr>
                            <tr>
                            	<td class="de_table_title">이름</td>
                                <td class="de_table_text">${user.name }</td>
                            </tr>
                            <tr>
                            	<td class="de_table_title">입금신청 예탁금액</td>
                                <td class="de_table_text"><input type="text" class="numberic" name="deposit" />원</td>
                            </tr>
                            <tr>
                            	<td class="de_table_title">수수료</td>
                                <td class="de_table_text">
                                	0%
                                	<!-- 20160202 수수료 0%로 변경 요청 -->
                                	<!--<c:out value="${accountVO.charge == null ? '1.0': accountVO.charge }"/> -->
                                </td>
                            </tr>
                            <input type="hidden" name="realDeposit"/>
                            <!-- 20160202 수수료 0%로 변경 요청으로 아래 필드 일단 삭제 -->
                            <!-- 
                            <tr>
                            	<td class="de_table_title">입금예탁금액(KRW)<br />-수수료 제외금액</td>
                                <td class="de_table_text"><input type="text" class="numberic" name="realDeposit"/>원</td>
                            </tr>
                             -->
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
                        	<p> - XRP GATE 거래소 홈페이지 인출하기 완료 후 고객님이 설정해 놓은</p>
                            <p> &nbsp;&nbsp; 개인 계좌를 확인해주세요.</p>
                            <p> - 본인인증이 완료된 고객에 한해서 인출거래가 승인됩니다.</p>
                            <p> &nbsp;&nbsp;(가입시 이름과 통장명의 일치, 여권이나 주민등록증 사본 제출필요)</p>
                        </li>
                        <li class="draw_red">★  인출 가능한 최소금액은 30,000원 입니다. ★</li>
                    </div>
                    <div class="draw_table">
                    	<table border="0" cellpadding="0" cellspacing="0">
                        	<tr>
                            	<td class="dr_table_title">인출가능 KRW</td>
                                <td class="dr_table_text numberic" >${accountVO.deposit }</td>
                            </tr>
                            <tr>
                            	<td class="dr_table_title">이름</td>
                                <td class="dr_table_text">${user.name }</td>
                            </tr>
                            <tr>
                            	<td class="dr_table_title">인출신청 예탁금액</td>
                                <td class="dr_table_text">
                                	<input type="text" class="numberic" name="witdraw"/>원
                                </td>
                            </tr>
                            <tr>
                            	<td class="dr_table_title">수수료</td>
                                <td class="dr_table_text">
                                	0%
                                </td>
                            </tr>
                            <input type="hidden" name="realWitdraw"/>
                             <!-- 20160202 수수료 0%로 변경 요청으로 아래 필드 일단 삭제 -->
                            <!--
                            <tr>
                            	<td class="dr_table_title">인출예탁금액(KRW)<br />-수수료 제외금액</td>
                                <td class="dr_table_text">원</td>
                            </tr>
                            -->
                        </table>
                    </div>
                    <div class="draw_btn">
                    	<a href="javascript:insertDepositInfo('W')">
                    	<img src="/images/btn/draw_btn.png" />
                    	</a>
                    </div>
                </div>
                
                <div class="mylist">
                	<div class="mylist_title">
                		<img src="/images/sub/godeal_btn.png" name="btnGoTrade"/>
                		<p style="float:right;margin-top:30px;height:18px;color:red"> 새로고침(F5)를 눌러 상태변경과정을 확인하실 수 있습니다.
                		</p>
                	</div>
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
                    	<tr class="my_info data" >
                        	<td class="list_01">${result.requestDt}</td>
                            <td class="list_02">${result.tradeType}</td>
                            <td class="list_03 numberic">${result.transactionsMoney}</td>
                            <td class="list_02 numberic" >${result.tradeCharge}</td>
                            <td class="list_04 numberic">${result.fee}</td>
                            <c:set var="status" value="${result.status}"></c:set>
                            <td class="list_05">${result.statusNm}</td>
                            <td class="list_06">${result.tradeCompleteDt}</td>
                            <td class="list_07">
                            	<c:if test="${status != 'S03'}">
                            	<a href="#" name="btnDelete" data-tradeId="${result.tradeId}">
                            		<img src="/images/btn/info_cancle.png"  width="100px" style="margin-top:3px;"/>
                            	</a>
                            	</c:if>
                            </td>
                        </tr>
                    	</c:forEach>
                    </table>
                    <div class="depositdrawinfo">
                    	<li>★ 예탁 및 인출 신청 후 처리완료까지 최대 30분 소요됩니다.</li>
                        <li>★ 예탁 및 인출 신청 가능시간은 평일 오전 09:00 - 오후05:00 까지 입니다.</li>
                    </div>
                </div>
            </div>
        </div>    
    </div>
<!-- 20160202 수수료 0%로 변경 요청 -->
<!-- <input type="hidden" name="charge" value="${accountVO.charge == null ? '0.1': accountVO.charge }" /> -->
<input type="hidden" name="charge" value="0" />
<input type="hidden" name="marketPrice" value="${xrpPrice.marketPrice }"/>
<input type="hidden" name="mberGrade" value="${user.mberGrade }"/>

<div id="modalLayer">
  <div class="modalContent draw_info">
  	<li>
  		본인인증 2단계를 실시하여 주시기 바랍니다.
  	</li>
  	<li>
  		- 주민등록 또는 여권, 개인통장사본을 등록후 
  	</li>
  	<li>
  		(홈페이지- 마이페이지-내정보 또는 Fax 전송)
  	</li>
  	<li>
  		관리자와 통화하시기 바랍니다.
  	</li>
    <button type="button">닫기</button>
  </div>
</div>

<script type="text/javaScript" language="javascript">
	$(function(){
		//총자산 = krw + (xrp자산 * 현재시세)
		var marketPrice = parseFloat($("[name=marketPrice]").val());
		var xrpDeposit = parseFloat($("[name=currentXrp]").val());
		var deposit = parseFloat($("[name=currentDeposit]").val());
		
		$("#totDeposit").text( fn_numberRound(deposit + (marketPrice*xrpDeposit),4) );
		
		$("input[name=deposit]").keyup(function(e){
			var charge = $("[name=charge]:hidden").val();
			var deposit = $(this).val();
			
			var realDeposit = fn_numberRound(deposit - (deposit * charge),4);
			
			$("[name=realDeposit]").val(realDeposit);
			
		});
		
		$("input[name=witdraw]").keyup(function(e){
			var charge = $("[name=charge]:hidden").val();
			var deposit = $(this).val();
			if(parseFloat($("[name=currentDeposit]").val()) < parseFloat(deposit)){
				alert("계좌 소지금보다 인출요청 금액이 많습니다.");
				$(this).val(0);
				return;
			}
			var realDeposit = fn_numberRound(deposit - (deposit * charge),4);
			
			$("[name=realWitdraw]").val(realDeposit);
			
		});
		
		$("[name=btnGoTrade]").click(function(e){
			location.href = "${contextPath}/trade/callXrpTrade.do";
		});
		
		$(document).on("click","[name=btnDelete]",function(e){
			e.preventDefault();
			
			var url = "${contextPath}/trade/deleteTransactionInfo.do";
			var tradeId = $(this).attr("data-tradeId");
			var param = {
					tradeId : tradeId
			}
			
			sendPost(url, param, "fn_deleteTransaction");
		});
		
		// 고객 요청 입력란 소수점 표현 안되게
		//$('input.numberic').number( true , fn_getDisit($("[name=currentDeposit]").val()));
		$('input.numberic').number( true);
		
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
		
		
		$(".modalContent > button").click(function(){
			$("#modalLayer").fadeOut("slow");
			$(".modalLink").focus();
		  	location.href = "${contextPath}/myInfo/memberChk.do";
		});		
	});
	
	function fn_openModalLayer(){
		var modalLayer = $("#modalLayer");
		var modalLink = $(".modalLink");
		var modalCont = $(".modalContent");
		var marginLeft = modalCont.outerWidth()/2;
		var marginTop = modalCont.outerHeight()/2;  
		  
		modalLayer.fadeIn("slow");
		modalCont.css({"margin-top" : -marginTop, "margin-left" : -marginLeft});
	    $(this).blur();
	    $(".modalContent > p").focus(); 
	    //return false;
	}
	
	function insertDepositInfo(tradeType){
		
		var deposit = "";
		var realDeposit = "";
		if(tradeType == "D"){
			deposit = $("input[name=deposit]").val();
			realDeposit = $("[name=realDeposit]").val()
		} else {
			// 인출 신청시 회원등급이 'VVIP'가 아닌경우 인증을 위한 회원관리 페이지로 이동한다.
			var mberGrade = $("[name=mberGrade]").val();
			if(mberGrade != "VVIP"){
				fn_openModalLayer();
				//location.href = "${contextPath}/myInfo/memberChk.do";
				return ;
			}
			deposit = $("input[name=witdraw]").val();
			realDeposit = $("[name=realWitdraw]").val()
		}
		
		var transactionCharge = $("[name=charge]:hidden").val();
		var status = "S01"; // 처리중비중 
		var fee = deposit - realDeposit;
		
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
			fn_makeTransactionInfo(data.listVo);
			/* for(var i = 0 ; i < data.listVo.length;i++){
				html += '<tr class="my_title data" >';
				html += 	'<td class="list_01">'+data.listVo[i].requestDt+'</td>';
				html += 	'<td class="list_02">'+data.listVo[i].tradeType+'</td>';
				html += 	'<td class="list_03">'+data.listVo[i].transactionsMoney+'</td>';
				html += 	'<td class="list_02">'+data.listVo[i].tradeCharge+'</td>';
				html += 	'<td class="list_04">'+data.listVo[i].fee+'</td>';
				html += 	'<td class="list_05">'+data.listVo[i].status+'</td>';
				html += 	'<td class="list_06">'+data.listVo[i].tradeCompleteDt+'</td>';
				html += 	'<td class="list_07">';
				if(data.listVo[i].status != 'S03'){
					html +=			'<a href="#">';
					html +=			'<img src="/images/btn/info_cancle.png" name="btnDelete" data-tradeId="'+data.listVo[i].tradeId+'" width="100px" style="margin-top:3px;"/>';
					html +=			'</a></td>';
				}
				html += '</tr>';
			} */
			alert("요청 거래가 등록되었습니다.");
		} else {
			
		}
	}
	
	function fn_deleteTransaction(data){
		if(data.isSuccess){
			alert("취소되었습니다.");
			//location.reload();
			fn_makeTransactionInfo(data.listVo);
		} else {
			alert("관리자에게 문의하여 주십시오.");
		}
	}
	
	function fn_makeTransactionInfo(data){
		var html="";
		
		for(var i = 0 ; i < data.length;i++){
			html += '<tr class="my_info data" >';
			html += 	'<td class="list_01">'+data[i].requestDt+'</td>';
			html += 	'<td class="list_02">'+data[i].tradeType+'</td>';
			html += 	'<td class="list_03 numberic">'+data[i].transactionsMoney+'</td>';
			html += 	'<td class="list_02 numberic">'+data[i].tradeCharge+'</td>';
			html += 	'<td class="list_04 numberic">'+data[i].fee+'</td>';
			html += 	'<td class="list_05">'+data[i].status+'</td>';
			html += 	'<td class="list_06">'+data[i].tradeCompleteDt+'</td>';
			html += 	'<td class="list_07">';
			if(data[i].status != 'S03'){
				html +=			'<a href="#" name="btnDelete" data-tradeId="'+data[i].tradeId+'">';
				html +=			'<img src="/images/btn/info_cancle.png"  width="100px" style="margin-top:3px;"/>';
				html +=			'</a></td>';
			}
			html += '</tr>';
		}
		$("input[name=deposit]").val('');
		$("input[name=witdraw]").val('');
		$("[name=realDeposit]").val('');
		$("[name=realWitdraw]").val('');
		$("#accountList tr").filter(".data").remove();
		$("#accountList").append(html);
		
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
	}
	
	function fn_getDisit(number) {
		var num = number;
		var idx = num.indexOf(".");
		var pointer ; 
		if(idx < 0 ){
			pointer = 0;
		} else {
			pointer = num.substr(idx+1, num.length).length;
		}
		return pointer;
	}
</script>

