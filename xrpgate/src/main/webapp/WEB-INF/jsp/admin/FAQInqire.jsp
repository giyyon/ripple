<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<form:form commandName="result"  id="frm">
<!-- <input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" /> -->
<input type="hidden" name="nttId"  value="<c:out value="${result.nttId}"/>" />
<input type="hidden" name="pageIndex" value="<c:out value='${result.pageIndex}'/>"/>
<input name="searchCnd" type="hidden" value="<c:out value='${result.searchCnd}'/>"/>
<input name="searchWrd" type="hidden" value="<c:out value='${result.searchWrd}'/>"/>
<div class="chn_pop_box">
 	<div class="pop_title">게시글 작성 및 수정</div> 
    <div class="pop_table">
    	<table cellpadding="0" cellspacing="0">
        	<tr>
            	<td width="200px" class="pop_table_title">작성자</td>
                <td width="250px">${result.ntcrNm}"</td>
                <td width="200px" class="pop_table_title">비밀번호</td>
                <td width="250px"></td>
            </tr>
            <tr>
            	<td class="pop_table_title">제목</td>
                <td colspan="3">
                	${result.nttSj}
                </td>
            </tr>
            <tr>
            	<td class="pop_table_title">카테고리</td>
                <td>
                	<form:select path="bbsId" style="width:100px; ">
						<form:option value="BBSMSTR_000000000001"  label="FAQ"/>
						<form:option value="BBSMSTR_000000000003"  label="리플소식"/>
						<form:option value="BBSMSTR_000000000004"  label="공지사항"/>
						<form:option value="BBSMSTR_000000000005"  label="자료실"/>
					</form:select>
                </td>
                <td class="pop_table_title">조회수</td>
                <td>${result.inqireCo}</td>
            </tr>
        </table>
    </div>
    <div class="pop_write">
    	<form:textarea path="nttCn"  htmlEscape="false" ></form:textarea>
                                    <script>
                                    CKEDITOR.replace(
                                 	'nttCn',
                                 	{
                                 		contenteditable:"false",
                                 		filebrowserImageUploadUrl : '/files/ckEditor/insertImage.do',
                                 		width : '100%', //넓이값
                                 		height : '200'      //높이값
                                 	}
                                    );
                                    </script>
    </div>
    <div class="pop_btn">
    	<li><a href="#" name="btnSave"><img src="${contextPath}/images/admin/admin_submit_btn.png" /></a></li>
        <li style="margin-left:20px;"><a href="#" name="btnCancel"><img src="${contextPath}/images/admin/admin_cancle_btn.png" /></a></li>
    </div>
 </div>
</form:form>
  <script> 

  $(document).ready(function(){
		
		$('[name=btnCancel]').click(function(e) {
			$('#frm').attr('action', '${contextPath}/admin/FAQList.do'); 
		    $("#frm").submit();
		});
		
		$('[name=btnSave]').click(function(e) {
			$('#frm').attr('action', '${contextPath}/admin/insertFAQArticle.do'); 
			$("#frm").submit(); 
		});
		
		$('[name=btnFileDownload]').click(function(e) {
			e.preventDefault();
			var category = $(this).attr('data_category');
			var $imgId = $(this).parent().find(':hidden');
			COM.openFileListPopup(category, $imgId.val());
		});
  });
	
	
  </script> 

