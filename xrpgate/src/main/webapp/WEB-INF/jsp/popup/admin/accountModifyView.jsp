<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/taglib.jsp" %>
<link href="<c:url value='/css/admin.css'/>" rel="stylesheet" />

 <div class="chn_pop_box">
 	<div class="pop_title">처리현황 수정</div> 
 	<form:form commandName="accountVo"  id="form" method="POST">
 	<div class="pop_table">
    	<table cellpadding="0" cellspacing="0">
        	<tr>
            	<td width="100px" class="pop_table_title">이름</td>
                <td width="200px">${accountVo.mberNm } (${accountVo.requestId })</td>
                <td width="100px" class="pop_table_title">신청날짜</td>
                <td width="200px">${accountVo.requestDt }</td>
                <td width="100px" class="pop_table_title">리플지갑주소</td>
                <td width="250px">${accountVo.rippleTradeEmail }</td>
            </tr>
            <tr>
            	<td width="100px" class="pop_table_title">금액</td>
                <td width="200px">
                	<input type="text" class="numberic" name="transactionsMoney" value="${accountVo.transactionsMoney }"> 원
                </td>
                <td width="100px" class="pop_table_title">처리현황</td>
                <td width="250px"  colspan="3">
                	<form:select path="status" style="width:200px;">
                		<form:option value="S01"  label="처리준비중"/>
                		<form:option value="S02"  label="처리중"/>
                		<form:option value="S03"  label="처리완료"/>
                    </form:select>
                </td>
            </tr>
        </table>
    </div>
 	</form:form>
    

    <div class="pop_btn">
    	<li>
    		<a href="#" name="btnModify"><img src="${contextPath}/images/admin/admin_submit_btn.png" /></a>
    	</li>
        <li style="margin-left:20px;">
        	<a href="#" name="btnCancle"><img src="${contextPath}/images/admin/admin_cancle_btn.png" /></a>
        </li>
    </div>
 </div>

 <input type="hidden" name="tradeId" value="${accountVo.tradeId }"/>
 <input type="hidden" name="tradeType" value="${accountVo.tradeType }"/>
 <input type="hidden" name="fee" value="${accountVo.fee }"/>
 <input type="hidden" name="mberId" value="${accountVo.requestId }"/>
 <input type="hidden" id="tradeStatus" value="${accountVo.status }"/>
 
 <div class="pop_cc">
	<div class="pop_cc_in">Copyrightⓒ2015 By XRPGATE. All right reserved.</div>
</div>

<script type="text/javaScript" language="javascript">

	$(function(){
		
		
		$("[name=btnModify]").click(function(e){
			e.preventDefault;
			var status = $("#tradeStatus").val();
			if(status == "S03"){
				alert("완료처리된 요청입니다.");
				return;
			}
			var url = "${contextPath}/admin/ModifyMberAccount.do?";
			var tradeId = $("[name=tradeId]").val();
			var tradeType = $("[name=tradeType]").val();
			var fee = $("[name=fee]").val();
			var transactionsMoney = $("[name=transactionsMoney]").val();
			var status = $("[name=status]").val();
			var mberId = $("[name=mberId]").val();
			var param = {
					tradeId : tradeId
					, tradeType : tradeType
					, fee : fee
					, transactionsMoney : transactionsMoney
					, status :status
					, mberId : mberId
			}
			
			sendPost(url, param, "fn_updateMberAccount");
		});
		
		$("[name=btnCancle]").click(function(e){
			e.preventDefault;
			
			window.open('', '_self').close();
		});
		
		$('input.numberic').number( true, fn_getDisit($(this)) );
				
	});
	
	function fn_updateMberAccount(data){
		if(data.isSuccess){
			alert("수정되었습니다.");
			opener.location.reload();
			window.open('', '_self').close();
		} else {
			alert("수정되지 않았습니다.");
		}
	}
	
	function fn_getDisit($this) {
		
		var num = $this.val();
		
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
