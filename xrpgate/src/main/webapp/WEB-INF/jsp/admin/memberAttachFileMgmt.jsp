<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

 <div class="content">
    	<div class="content_in">
        <div class="admin_title"><img src="${contextPath}/images/admin/admin_mem_title.png" /></div>
            <div class="admin_mem">
            	<table cellpadding="0" cellspacing="0">
                	<tr class="admin_table_title">
                    	<td width="30px">번호</td>
                        <td width="100px">이름</td>
                        <td width="120px">아이디</td>
                        <td width="120px">휴대폰번호</td>
                        <td width="230px">지갑주소</td>
                        <td width="70px">회원등급</td>
                        <td width="180px">계좌번호</td>
                        <td width="100px">국가</td> 
                        <td width="180px">관리</td>                    
                    </tr>
                    <c:forEach var="data" items="${mberList }" varStatus="status">
                    <tr>
                    	<td>
                    	<c:out value="${status.index }"></c:out>
                    	</td>
                    	<td><c:out value="${data.userNm }"></c:out>
                    	</td>
                    	<td><c:out value="${data.userId }"></c:out>
                    	</td>
                    	<td><c:out value="${data.moblphonNo }"></c:out>
                    	</td>
                    	<td><c:out value="${data.rippleTradeEmail }"></c:out>
                    	</td>
                    	<td><c:out value="${data.memberGrade }"></c:out>
                    	</td>
                    	<td><c:out value="${data.bankNm }"></c:out> / <c:out value="${data.account }"></c:out>
                    	</td>
                    	<td><c:out value="${data.state }"></c:out>
                    	</td>
                    	<td class="admin_btn">
                        	<li style="margin-left:14px;">
	                        	<a name="btnModify" href="#" data-mberId="${data.userId }" data-uniqId="${data.uniqId }">
	                        	<img src="${contextPath}/images/admin/admin_ok_btn.png" />
	                        	</a>
                        	</li>
                            <li><a name="btnDelete" href="#" data-mberId="${data.userId }" data-uniqId="${data.uniqId }">
                            	<img src="${contextPath}/images/admin/admin_del_btn.png" /></a>
                            </li>
                        </td>
                    </tr>
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
	<input type="hidden" name="pageIndex" value="${result.pageIndex}"/>
	
</form>
<script type="text/javaScript" language="javascript">
	$(function(){
		
		$("[name=btnModify]").click(function(e){
			e.preventDefault;
			
			var url = "${contextPath}/admin/callMberAtchFileView.do?";
			var mberId = $(this).attr("data-mberId");
			var uniqId = $(this).attr("data-uniqId");
			var param = {
					mberId : mberId
					, uniqId : uniqId
			}
			
			window.open(url+ $.param(param), 'popUpWindow','height=650, width=1000, left=300, top=100, resizable=yes, scrollbars=yes, toolbar=yes, menubar=no, location=no, directories=no, status=yes');			
		});
		
		$("[name=btnDelete]").click(function(e){
			
			var url = "${contextPath}/admin/deleteGnrMberInfo.do?";
			var mberId = $(this).attr("data-mberId");
			var uniqId = $(this).attr("data-uniqId");
			var param = {
					mberId : mberId
					, uniqId : uniqId
			}
			
			sendPost(url, param, "fn_deleteMberInfo");
		});
		
		
	});
	
	// 네비게시이션 이동
	function linkPage(pageNo){
		$("#subForm input[name=pageIndex]").val(pageNo); 
		$("#subForm").attr({action:"${contextPath}/admin/memberAttachFileMgmt.do", target:""});
		$("#subForm").submit();
	}
	
	function fn_deleteMberInfo(data){
		if(data.isSuccess){
			alert("삭제되었습니다.");
			window.location.reload();
		} else {
			alert("삭제되지 않았습니다.");
		}
	}
</script>
