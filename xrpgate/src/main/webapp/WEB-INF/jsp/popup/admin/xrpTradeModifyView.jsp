<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/taglib.jsp" %>
<link href="<c:url value='/css/admin.css'/>" rel="stylesheet" />

 <div class="chn_pop_box">
 	<div class="pop_title">
 	<c:choose>
 	<c:when test="${tradeType == 'B' }">
 	매수단가 입력
 	</c:when>
 	<c:when test="${tradeType == 'S' }">
 	매도단가 입력
 	</c:when>
 	<c:otherwise>
 	현재시세 입력
 	</c:otherwise>
 	</c:choose>
 	
 	</div> 
    <div class="pop_table">
    	<table cellpadding="0" cellspacing="0">
        	<tr>
            	<td width="100px" class="pop_table_title">날짜</td>
                <td width="200px"><input type="text" name="requestDt" value="${tradeVo.requestDt }" style="width:120px"/></td>
                <td width="100px" class="pop_table_title">시간</td>
                <td width="200px"><input type="text" name="requestTime" value="${tradeVo.requestTime }" style="width:120px"></td>
                <td width="100px" class="pop_table_title">관리자</td>
                <td width="200px"><input type="text" name="mberNm" value="${tradeVo.mberNm }" readOnly="true" style="width:120px"/></td>
            </tr>
            <tr>
            	<td width="100px" class="pop_table_title">시세(KRW)</td>
                <td width="200px">
                	<input type="text" class="numberic4" name="requestMoney" value="${tradeVo.requestMoney }" style="width:120px"/>
                </td>
            	<td width="100px" class="pop_table_title">수량(XRP)</td>
                <td width="200px">
                	<c:if test="${tradeType != 'C' }">
                	<input type="text" class="numberic" name="requestQty" value="${tradeVo.requestQty }" style="width:120px"/>
                	</c:if>
                	
                </td>
                <td width="100px" class="pop_table_title">누적(XRP)</td>
                <td width="200px">
                	<c:if test="${tradeType != 'C' }">
                	<input type="text" class="numberic" name="accumulateQty" value="${totalSum }" readOnly="true" style="width:120px"/>
                	</c:if>
                </td>
            </tr>
        </table>
    </div>
    <div>
    	<p>
    		※ 날짜 형식 : 20160215, 시간 형식 : 0900 형태로 입력하시기 바랍니다.
    	</p>
    </div>
    <div class="pop_btn">
    	<li><a href="#" name="btnSave"><img src="${contextPath}/images/admin/admin_submit_btn.png" /></a></li>
        <li style="margin-left:20px;"><a href="#" name="btnCancle"><img src="${contextPath}/images/admin/admin_cancle_btn.png" /></a></li>
    </div>
 </div>

 <input type="hidden" name="tradeId" value="${tradeVo.tradeId }"/>
 <input type="hidden" name="tradeType" value="${tradeType }"/>
 <input type="hidden" name="totalSum" value="${totalSum }"/>
 
 <div class="pop_cc">
	<div class="pop_cc_in">Copyrightⓒ2015 By XRPGATE. All right reserved.</div>
</div>

<script type="text/javaScript" language="javascript">
	$(function(){
		
		$("[name=btnCancle]").click(function(e){
			window.close();
		});
		
		$("[name=requestQty]").change(function(){
			var requestQty = parseFloat($(this).val());
			var totalSum = parseFloat($("[name=totalSum]").val());
			$("[name=accumulateQty]").val(requestQty+totalSum);
		});
		
		$("[name=btnSave]").click(function(e){
			e.preventDefault;
			var tradeId = $("[name=tradeId]").val();
			var url = "";
			if(tradeId == null || tradeId ==""){
				url ="${contextPath}/admin/insertXrpTrade.do?";
				tradeId = 0;
			} else {
				url ="${contextPath}/admin/modifyXrpTrade.do?";
			}

			var tradeType = $("[name=tradeType]").val();
			var requestDt = $("[name=requestDt]").val().replace(/\-/g, "");
			var requestMoney = $("[name=requestMoney]").val();
			var requestTime = $("[name=requestTime]").val().replace(":", "");
			var requestQty = $("[name=requestQty]").val();
			
			if(requestQty == "" || requestQty ==null){
				requestQty = 0;
			}
			
			var param = {
					tradeId : tradeId
					, tradeType : tradeType
					, requestDt : requestDt
					, requestMoney : requestMoney
					, requestQty : requestQty
					, requestTime :requestTime
			}
			
			sendPost(url, param, "fn_updateXrpTrade");
		});
		
		$('input.numberic').number( true );
		
		//$('input.numberic4').number( true, 4 );
		
		/* $('input.numberic4').keyup(function(e){
			str = String($(this).val());;
		    $(this).val(comma(uncomma(str)));
		}); */
		
		
		
		
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
	
	function comma(str) {
	    str = String(str);
	    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	
	function uncomma(str) {
	    str = String(str);
	    return str.replace(/[^\d]+/g, '');
	}
</script>
