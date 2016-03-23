<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>



<div class="content">
   	<div class="content_in">
           <div class="admin_main_con">
			<img src="${contextPath}/images/admin/admin_main.png" />
           </div>
           <div class="admin_title"><img src="${contextPath}/images/admin/admin_xrp_title.png" /></div>
           
           <div class="account_chn" style="margin-top:0px; margin-bottom:30px">
               <div class="account_chn_in">
               	<table cellpadding="0" cellspacing="0" border="0">
                   	<thead>
                       	<td>XRPGATE 계좌번호</td>
                           <td>XRPGATE 계정주소</td>
                           <td style="border-right:0;">설정</td>                        
                       </thead>
                       <tbody>
                       	<td>${accountVo.bankNm } ${accountVo.account }</td>
                           <td>${accountVo.rippleTrade}</td>
                           <td style="border-right:0;">
							<a href="#" name="btnModify">
								<img src="${contextPath}/images/admin/admin_chn_btn.png" />
							</a>                          
                           </td>                        
                       </tbody>
                   </table>
               </div>
           </div>
       </div>    
   </div>

   
<script type="text/javaScript" language="javascript">
	$(function(){
		$("[name=btnModify]").click(function(e){
			e.preventDefault;
			var url = "${contextPath}/admin/callAccountInsertPage.do?";
			window.open(url, 'popUpWindow','height=250, width=1000, left=300, top=100, resizable=yes, scrollbars=yes, toolbar=yes, menubar=no, location=no, directories=no, status=yes');
		});
	});

</script>