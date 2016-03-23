<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/taglib.jsp" %>



<div class="content">
    	<div class="content_in">
        <div class="admin_title"><img src="${contextPath}/images/admin/admin_present_title.png" /></div>
        <p class="admin_enter_btn">
        	<a href="#" name="btnModify" data-tradeId="" data-tradeType="C">
	        	<img src="${contextPath}/images/admin/admin_enter_btn.png" />
            </a>
        </p>
            <div class="admin_deal">
            	<table cellpadding="0" cellspacing="0">
                	<tr class="admin_table_title">
                    	<td width="110px">날짜</td>
                        <td width="100px">시간</td>
                        <td width="130px">관리자</td>
                        <td width="170px">시세</td>
                        <td width="170px">수량(XRP)</td>
                        <td width="170px">누적(XRP)</td><!--누적 리플량은 입력한 수량을 계산하여 자동으로 입력되었으면 합니다-->
                        <td width="150px">관리</td>                   
                    </tr>
                    <c:forEach var="data" items="${resultList }" varStatus="status">
                         <tr>
                         	<td>${data.requestDt }</td>
                         	<td>${data.requestTime }</td>
                         	<td>${data.mberNm }</td>
                         	<td class="numberic">${data.requestMoney }</td>
                         	<td class="numberic">${data.requestQty }</td>
                         	<td class="numberic">${data.accumulateQty }</td>
                         	<td class="admin_btn">
                         		<li style="margin-left:14px;">
                         			<a href="#" name="btnModify" data-tradeId="${data.tradeId }" data-tradeType="${data.tradeType }">
                         				<img src="${contextPath}/images/admin/admin_chn_btn.png" />
                         			</a>
                         		</li>
                                <li>
	                                <a href="#" name="btnDelete" data-tradeId="${data.tradeId }">
	                                	<img src="${contextPath}/images/admin/admin_del_btn.png" />
	                                </a>
                                </li>
                            </td>
                        </c:forEach>
                </table>
            </div>
            <div class="paging">
                <ul class="page">
                <ui:pagination paginationInfo="${paginationInfo}" type="supportImage" jsFunction="linkPage" />
                </ul>
            </div>
        </div>    
    </div>


<form id="subForm"  method="post" >
	<input type="hidden" name="pageIndex" value=""/>
	<input type="hidden" name="tradeType" value="${tradeDetailVo.tradeType }"/>
</form>
<script type="text/javaScript" language="javascript">
	$(function(){
		
		$("[name=btnModify]").click(function(e){
			e.preventDefault;
			
			var url = "${contextPath}/admin/callXrpTradeView.do?";
			var tradeId = $(this).attr("data-tradeId");
			var tradeType = $(this).attr("data-tradeType");
			
			if(tradeId == null || tradeId ==""){
				tradeId = 0;
			}
			var param = {
					tradeId : tradeId
					, tradeType : tradeType
			}
			
			window.open(url+ $.param(param), 'popUpWindow','height=350, width=1000, left=300, top=100, resizable=yes, scrollbars=yes, toolbar=yes, menubar=no, location=no, directories=no, status=yes');			
		});
		
		$("[name=btnDelete]").click(function(e){
			e.preventDefault;
			var url = "${contextPath}/admin/deleteXrpTrade.do?";
			var tradeId = $(this).attr("data-tradeId");
			
			var param = {
					tradeId : tradeId
			}
			
			sendPost(url, param, "fn_deleteXrpTrade");
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
	});
	
	function linkPage(pageNo){
		$("#subForm input[name=pageIndex]").val(pageNo); 
		$("#subForm").attr({action:"${contextPath}/admin/xrpgateTradeList.do", target:""});
		$("#subForm").submit();
	}
	
	function fn_deleteXrpTrade(data){
		if(data.isSuccess){
			alert("삭제되었습니다.");
			location.href = "${contextPath}/admin/xrpgateTradeList.do?tradeType=C";
		} else {
			alert("삭제되지 않았습니다.");
		}
	}
</script>
