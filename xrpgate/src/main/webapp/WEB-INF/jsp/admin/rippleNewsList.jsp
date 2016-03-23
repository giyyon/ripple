<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

 <div class="content">
    	<div class="content_in">
        <div class="admin_title"><img src="/images/admin/admin_news_title.png" /></div>
        <div class="write_btn">
        	<a href="#" name="btnRegist" >
        		<img src="/images/admin/admin_write_btn.png" />
        	</a>
        </div>
            <div class="admin_faq">
            	<table cellpadding="0" cellspacing="0">
                	<tr class="admin_table_title">
                    	<td width="80px">번호</td>
                        <td width="800px">내용</td>
                        <td width="150px">관리</td>                    
                    </tr>
                    <c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td>${status.index }</td>
							<td class="table_text"><li><c:out value="${result.nttSj}"/></li></td>
							<td class="admin_btn">
	                        	<li style="margin-left:14px;">
	                        		<a href="#" name="btnModify" data-nttId="${result.nttId}" data-pass="${result.password}">
	                        			<img src="/images/admin/admin_chn_btn.png" />
	                        		</a>
	                        	</li>
	                            <li><a href="#" name="btnDelete" data-nttId="${result.nttId}" data-bbsId="${result.bbsId}">
	                            <img src="/images/admin/admin_del_btn.png" /></a></li>
	                        </td>
							<input type="hidden" name="bbsNm" value="<c:out value='${result.bbsNm}'/>" />
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
	<input type="hidden" name="pageIndex" value="${result.pageIndex}"/>
	<input type="hidden" name="bbsId" value="${result.bbsId}" />
	<input type="hidden" name="nttId"  value="" />
	
</form>

<script type="text/javaScript" language="javascript">
	$(function(){
		
		$("[name=btnDelete]").click(function(e){
			var nttId = $(this).attr("data-nttId");
			var bbsId = $(this).attr("data-bbsId");
			
			$("#subForm input[name=pageIndex]").val($(".selected").val()); 
			$("#subForm input[name=nttId]").val(nttId);
			$("#subForm input[name=bbsId]").val(bbsId);
			$("#subForm").attr({action:"${contextPath}/admin/deleteBoardArticle.do", target:""});
			$("#subForm").submit();
		});
		
		$("[name=btnRegist]").click(function(e){
			e.preventDefault;
			
			$("#subForm input[name=pageIndex]").val('1'); 
			$("#subForm input[name=nttId]").val('0');
			$("#subForm").attr({action:"${contextPath}/admin/rippleNewsCallInsertPage.do", target:""});
			$("#subForm").submit();
			return;
			
			/* var url = "${contextPath}/admin/FAQDetail.do?";
			var bbsId = $("[name=bbsId]").val();
			var param = {
					bbsId : bbsId
			}
			
			window. */open(url+ $.param(param), 'popUpWindow','height=750, width=1000, left=300, top=100, resizable=yes, scrollbars=yes, toolbar=yes, menubar=no, location=no, directories=no, status=yes');
		});
		
		$("[name=btnModify]").click(function(e){
			e.preventDefault;
			
			$("#subForm input[name=pageIndex]").val('1'); 
			$("#subForm input[name=nttId]").val($(this).attr("data-nttId"));
			$("#subForm").attr({action:"${contextPath}/admin/rippleNewsModify.do", target:""});
			$("#subForm").submit();
			return;
			/* var url = "${contextPath}/admin/rippleNewsInqire.do?";
			var nttId = $(this).attr("data-nttId");
			var bbsId = $("[name=bbsId]").val();
			var param = {
					nttId : nttId
			}
			e.preventDefault;
			window.o */pen(url+ $.param(param), 'popUpWindow','height=750, width=1000, left=300, top=100, resizable=yes, scrollbars=yes, toolbar=yes, menubar=no, location=no, directories=no, status=yes');
		});
	});
	
	// 네비게시이션 이동
	function linkPage(pageNo){
		$("#subForm input[name=pageIndex]").val(pageNo); 
		$("#subForm input[name=nttId]").val('0');
		//$('#subForm').attr('action', '${contextPath}/customer/phoneQnAList.do'); 
		$("#subForm").attr({action:"${contextPath}/admin/rippleNewsList.do", target:""});
		$("#subForm").submit();
	}
	
	
	
</script>
