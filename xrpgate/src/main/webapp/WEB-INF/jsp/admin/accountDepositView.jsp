<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<div class="content">
   	<div class="content_in">
		<div class="de_box">
            <div class="admin_title"><img src="${contextPath}/images/admin/admin_deposit_title.png" /></div>
                <div class="admin_deposit">
                    <table cellpadding="0" cellspacing="0">
                        <tr class="admin_table_title">
                            <td width="60px">번호</td>
                            <td width="100px">신청날짜</td>
                            <td width="100px">신청자</td>
                            <td width="250px">리플지갑주소</td>
                            <td width="180px">금액</td>  
                            <td width="190px">관리</td> 
                            <td width="130px">처리현황</td>                 
                        </tr>
                        <c:forEach var="data" items="${resultList }" varStatus="status">
                         <tr>
                         	<td>${status.index }</td>
                         	<td>${data.requestDt }</td>
                         	<td class="table_text">${data.requestId }</td>
                         	<td>${data.rippleTradeEmail }</td>
                         	<td class="numberic">${data.transactionsMoney }</td>
                         	<td class="admin_btn">
                         		<li>
                                <a href="#" name="btnModify" data-tradeId="${data.tradeId }" >
                                    <img src="${contextPath}/images/admin/admin_chn_btn.png" />
                                </a>
                                </li>
                                <li>
	                                <a href="#" name="btnDelete" data-tradeId="${data.tradeId }">
	                                	<img src="${contextPath}/images/admin/admin_del_btn.png" />
	                                </a>
                                </li>
                            </td>
                            <td class="deposit_text">${data.status }</td>
                        </c:forEach>
                    </table>
                </div>
                <div class="paging">
                <ul class="page">
                    <ul class="page">
	                <ui:pagination paginationInfo="${paginationInfo}" type="supportImage" jsFunction="linkPage" />
	                </ul>
                </ul>
            </div>
            </div>
     </div>
</div>

<form id="subForm"  method="post" >
	<input type="hidden" name="pageIndex" value=""/>
	<input type="hidden" name="tradeType" value="${accountDeatailVo.tradeType }"/>
</form>
<script type="text/javaScript" language="javascript">
	$(function(){
		
		$("[name=btnModify]").click(function(e){
			e.preventDefault;
			
			var url = "${contextPath}/admin/callModifyAccountView.do?";
			var tradeId = $(this).attr("data-tradeId");
			var tradeType = $(this).attr("data-tradeType");
			var param = {
					tradeId : tradeId
					, tradeType : tradeType
			}
			
			window.open(url+ $.param(param), 'popUpWindow','height=390, width=1000, left=300, top=100, resizable=yes, scrollbars=yes, toolbar=yes, menubar=no, location=no, directories=no, status=yes');			
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
		
		$("[name=btnDelete]").click(function(e){
			e.preventDefault;
			var url = "${contextPath}/admin/deleteTransactionInfo.do?";
			var tradeId = $(this).attr("data-tradeId");
			
			var param = {
					tradeId : tradeId
			}
			
			sendPost(url, param, "fn_deleteTransactionInfo");
		});
	});
	
	function linkPage(pageNo){
		$("#subForm input[name=pageIndex]").val(pageNo); 
		//$('#subForm').attr('action', '${contextPath}/customer/phoneQnAList.do'); 
		$("#subForm").attr({action:"${contextPath}/admin/accountList.do", target:""});
		$("#subForm").submit();
	}
	
	function fn_deleteTransactionInfo(data){
		if(data.isSuccess){
			alert("삭제되었습니다.");
			location.href = "${contextPath}/admin/accountList.do?tradeType=D";
		} else {
			alert("삭제되지 않았습니다.");
		}
	}
</script>
