<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/taglib.jsp" %>
<link href="<c:url value='/css/admin.css'/>" rel="stylesheet" />

 <div class="chn_pop_box">
 	<div class="pop_title">처리현황 수정</div> 
 	<form:form commandName="accountVo"  id="form" method="POST">
 	<div class="pop_table">
    	<table cellpadding="0" cellspacing="0">
    		<tr>
            	<td width="120px" class="pop_table_title">계좌번호</td>
                <td width="330px">
                    <form:select path="bankId" style="width:80px;margin-right:15px;line-height:22px;;float:left;">
						<c:forEach var="result" items="${bank_result}" varStatus="status">
                        	<form:option value="${result.code}"  label='${result.codeNm}'/>
                       	</c:forEach>
					</form:select> 
                    <input type="text" name="account" value="${accountVo.account }" style="width:180px;float:left;"/>
                </td>
                <td width="120px" class="pop_table_title">계정주소</td>
                <td width="320px"><input type="text" name="rippleTrade" value="${accountVo.rippleTrade}" style="width:250px;float:left;" /></td>
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

 <div class="pop_cc">
	<div class="pop_cc_in">Copyrightⓒ2015 By XRPGATE. All right reserved.</div>
</div>

<script type="text/javaScript" language="javascript">
	$(function(){
		
		$("[name=btnModify]").click(function(e){
			e.preventDefault;
			
			var url = "${contextPath}/admin/insertRippleAccount.do?";
			var bankId = $("[name=bankId]").val();
			var bankNm = $("[name=bankId] option:selected").text();
			var account = $("[name=account]").val();
			var rippleTrade = $("[name=rippleTrade]").val();
			var param = {
					bankId : bankId
					, bankNm : bankNm
					, account : account
					, rippleTrade : rippleTrade
			}
			
			sendPost(url, param, "fn_updateAdminAccount");
		});
		
		$("[name=btnCancle]").click(function(e){
			e.preventDefault;
			
			window.open('', '_self').close();
		});
		
	});
	
	function fn_updateAdminAccount(data){
		if(data.isSuccess){
			alert("수정되었습니다.");
			opener.location.reload();
			window.open('', '_self').close();
		} else {
			alert("수정되지 않았습니다.");
		}
	}
	
</script>
