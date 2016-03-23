<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<iframe width="100%" height="475" src="${contextPath}/admin/accountList.do?tradeType=D">
        
            </iframe>
            <iframe  width="100%" height="475" src="${contextPath}/admin/accountList.do?tradeType=W">
            
            </iframe>
        </div> 
<script type="text/javaScript" language="javascript">
	$(function(){
		
		$("[name=btnModify]").click(function(e){
			e.preventDefault;
			
			var url = "${contextPath}/admin/callModifyMber.do?";
			var mberId = $(this).attr("data-mberId");
			var uniqId = $(this).attr("data-uniqId");
			var param = {
					mberId : mberId
					, uniqId : uniqId
			}
			
			window.open(url+ $.param(param), 'popUpWindow','height=390, width=1000, left=300, top=100, resizable=yes, scrollbars=yes, toolbar=yes, menubar=no, location=no, directories=no, status=yes');			
		});
		
	});
</script>
