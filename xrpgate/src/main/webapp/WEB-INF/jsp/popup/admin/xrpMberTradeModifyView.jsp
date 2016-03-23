<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/taglib.jsp" %>
<link href="<c:url value='/css/admin.css'/>" rel="stylesheet" />

 <div class="chn_pop_box">
 	<div class="pop_title">
 	
 	<c:choose>
 	<c:when test="${tradeVo.tradeType == 'B' }">
 	매수단가 입력
 	</c:when>
 	<c:when test="${tradeVo.tradeType == 'S' }">
 	매도단가 입력
 	</c:when>
 	<c:otherwise>
 	매수단가 입력
 	</c:otherwise>
 	</c:choose>
 	</div> 
    <div class="pop_table">
    	<form:form commandName="tradeVo" id="form">
    	<table cellpadding="0" cellspacing="0">
        	<tr>
            	<td width="100px" class="pop_table_title">날짜</td>
                <td width="200px">${tradeVo.requestDt }</td>
                <td width="100px" class="pop_table_title">시간</td>
                <td width="200px">${tradeVo.requestTime }</td>
                <td width="100px" class="pop_table_title">구매자</td>
                <td width="180px">${tradeVo.requestId }</td>
                <td width="130px" class="pop_table_title">처리현황</td>
                <td width="150px">
                	<form:select path="status" value="${tradeVo.status}" style="width:140px;">
                		<form:option value="S01"  label="처리준비중"/>
                		<form:option value="S02"  label="처리중"/>
                		<form:option value="S03"  label="처리완료"/>
                		<form:option value="S04"  label="처리보류"/>
                    </form:select>
                </td>
            </tr>
            <tr>
            	<td width="100px" class="pop_table_title">XRP 수량</td>
                <td class="numberic" width="200px">${tradeVo.requestQty }</td>
                <td width="100px" class="pop_table_title">리플주소</td>
                <td width="${tradeVo.tradeType  == 'B' ? '450px':'200px' }" colspan="${tradeVo.tradeType  == 'B' ? '3':'1' }">${tradeVo.rippleTradeEmail }</td>
                <c:if test="${tradeVo.tradeType  == 'S'}">
                <td width="100px" class="pop_table_title">계좌번호 </td>
                <td width="180px">${tradeVo.bankNm } ${tradeVo.account }</td>
                </c:if>
            	<td width="130px" class="pop_table_title">${tradeVo.tradeType  == 'B' ? '총매수금액(KRW)':'총매도금액(KRW)' }</td>
                <td class="numberic" width="150px">${tradeVo.requestMoney }</td>
            </tr>
        </table> 
        </form:form>
    </div>
    <div class="pop_btn">
    	<li><a href="#" name="btnSave"><img src="${contextPath}/images/admin/admin_submit_btn.png" /></a></li>
        <li style="margin-left:20px;"><a href="#" name="btnCancle"><img src="${contextPath}/images/admin/admin_cancle_btn.png" /></a></li>
    </div>
 </div>

 <input type="hidden" name="tradeId" value="${tradeVo.tradeId }"/>
 <input type="hidden" name="tradeType" value="${tradeVo.tradeType }"/>
 <input type="hidden" name="totalSum" value="${totalSum }"/>
 <input type="hidden" name="requestId" value="${tradeVo.requestId }"/>
 <input type="hidden" name="requestQty" value="${tradeVo.requestQty }"/>
 <input type="hidden" name="requestMoney" value="${tradeVo.requestMoney }"/>
 <input type="hidden" name="resultTotMoney" value="${tradeVo.resultTotMoney }"/>
 
 <div class="pop_cc">
	<div class="pop_cc_in">Copyrightⓒ2015 By XRPGATE. All right reserved.</div>
</div>

<script type="text/javaScript" language="javascript">
	$(function(){
		
		$("[name=btnCancle]").click(function(e){
			window.close();
		});
		
		$("[name=btnSave]").click(function(e){
			e.preventDefault;
			var tradeId = $("[name=tradeId]").val();
			var url ="${contextPath}/admin/updateMberXrpTrade.do?";

			var status = $("[name=status]").val();
			var requestMoney = $("[name=requestMoney]").val();
			var requestQty = $("[name=requestQty]").val();
			var requestId = $("[name=requestId]").val();
			var tradeType = $("[name=tradeType]").val();
			var resultTotMoney = $("[name=resultTotMoney]").val();
			if(requestQty == "" || requestQty ==null){
				requestQty = 0;
			}
			
			var param = {
					tradeId : tradeId
					, tradeType : tradeType
					, requestMoney : requestMoney
					, requestQty : requestQty
					, requestId : requestId
					, status : status
					, resultTotMoney : resultTotMoney
			}
			
			sendPost(url, param, "fn_updateXrpTrade");
		});
		
		
	});
	
	function fn_updateXrpTrade(data){
		if(data.isSuccess){
			alert("수정되었습니다.");
			opener.location.reload();
			window.close();
		} else {
			alert("수정되지 않았습니다.");
		}
	}
</script>
