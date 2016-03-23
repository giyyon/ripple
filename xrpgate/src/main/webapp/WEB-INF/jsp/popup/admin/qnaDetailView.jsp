<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/taglib.jsp" %>
<link href="<c:url value='/css/admin.css'/>" rel="stylesheet" />
<form:form commandName="result"  id="frm">
<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
<input type="hidden" name="nttId"  value="<c:out value="${result.nttId}"/>" />
<div class="chn_pop_box">
 	<div class="pop_title">게시글 작성 및 수정</div> 
    <div class="pop_table">
    	<table cellpadding="0" cellspacing="0">
        	<tr>
            	<td width="200px" class="pop_table_title">작성자</td>
                <td width="250px"><input type="text" value="<c:out value="${result.frstRegisterNm}" />"style="width:200px"/></td>
                <td width="200px" class="pop_table_title">비밀번호</td>
                <td width="250px"><input type="text" style="width:200px"/></td>
            </tr>
            <tr>
            	<td class="pop_table_title">제목</td>
                <td colspan="3"><form:input path="nttSj"  style="width:670px"/></td>
            </tr>
            <tr>
            	<td class="pop_table_title">카테고리</td>
                <td>
                	<form:select path="bbsId" style="width:100px; ">
						<form:option value="BBSMSTR_000000000001"  label="FAQ"/>
						<form:option value="BBSMSTR_000000000003"  label="리플소식"/>
						<form:option value="BBSMSTR_000000000004"  label="공지사항"/>
						<form:option value="BBSMSTR_000000000001"  label="자료실"/>
					</form:select>
                </td>
                <td class="pop_table_title">조회수</td>
                <td><input type="text" style="width:200px"/></td>
            </tr>
        </table>
    </div>
    <div class="pop_write">
    	<textarea path="nttCn"  htmlEscape="false" style="width:935px;height:400px;margin-top:20px;resize:none;">
    	</textarea>
         <!--텍스트 박스가 들어가는 위치에 에디터 삽입 부탁드립니다.-->
         <script>
          CKEDITOR.replace(
	       	'nttCn',
	       	{
	       		contenteditable:"false",
	       		filebrowserImageUploadUrl : '/files/ckEditor/insertImage.do',
	       		width : '100%', //넓이값
	       		height : '390'      //높이값
	       	}
	          );
          </script>
    </div>
    <div class="pop_btn">
    	<li><a href="#" name="btnSave"><img src="${contextPath}/images/admin/admin_submit_btn.png" /></a></li>
        <li style="margin-left:20px;"><a href="#"><img src="${contextPath}/images/admin/admin_cancle_btn.png" /></a></li>
    </div>
 </div>
</form:form>
 <div class="pop_cc">
	<div class="pop_cc_in">Copyrightⓒ2015 By XRPGATE. All right reserved.</div>
</div>  


<script> 
$(function(){
	$('[name=btnFileDownload]').click(function(e) {
		e.preventDefault();
		var category = $(this).attr('data_category');
		var $imgId = $(this).parent().find(':hidden');
		COM.openFileListPopup(category, $imgId.val());
	});
	
	$('[name=btnFileDownload]').click(function(e) {
		
	});
});
   function linkListPage(){
	   $('#frm').attr('action', '${contextPath}/customer/phoneQnAList.do'); 
	   $("#frm").submit();
   }
	
	
	
	function goPost(){
		   $('#frm').attr('action', '${contextPath}/admin/insertRippleNewsArticle.do'); 
		   $("#frm").submit();  
		}
</script> 

