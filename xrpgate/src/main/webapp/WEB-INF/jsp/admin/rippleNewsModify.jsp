<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<form:form commandName="result"  id="frm">
<!-- <input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" /> -->
<input type="hidden" name="nttId"  value="<c:out value="${result.nttId}"/>" />
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
<input name="searchCnd" type="hidden" value="<c:out value='${searchVO.searchCnd}'/>"/>
<input name="searchWrd" type="hidden" value="<c:out value='${searchVO.searchWrd}'/>"/>
<div class="chn_pop_box">
 	<div class="pop_title">게시글 작성 및 수정</div> 
    <div class="pop_table">
    	<table cellpadding="0" cellspacing="0">
        	<tr>
            	<td width="200px" class="pop_table_title">작성자</td>
                <td width="250px"><input type="text" value="<c:out value="${result.ntcrNm}" />"style="width:200px"/></td>
                <td width="200px" class="pop_table_title">비밀번호</td>
                <td width="250px"><input type="text" name="password"style="width:200px" value="${result.password}"/></td>
            </tr>
            <tr>
            	<td class="pop_table_title">제목</td>
                <td colspan="3">
                	<form:input path="nttSj"  style="width:670px"/>
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
            <tr>
            	<td class="pop_table_title">파일첨부</td>
                <td colspan="3">
                	<form:hidden path="atchFileId" />
					<input name="file1_text" type="text" />
					<img name="btnFileUpload" src="${contextPath}/images/common/btn_searchfile.png" data_fileMax="5" data_category="news"  data_type="img" data_fieldId="atchFileId" alt="찾아보기"   />
                </td>
            </tr>
			<c:if test='${not empty result.atchFileId}'>
			<tr>
				<td class="pop_table_title">첨부파일 목록</td>
	            <td colspan="3">
					<!-- <img name="btnFileDownload" src="${contextPath}/img/btn_down2.png"    data_type="file"   alt="다운로드"> --> 
					<br>
					<c:import url="/files/selectFileInfsAdvence.do" charEncoding="utf-8">
					<c:param name="param_atchFileId" value="${result.atchFileId}" />
					</c:import>	
				</td> 
			</tr>
			</c:if>
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
                                 		height : '400'      //높이값
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
 			$('#frm').attr('action', '${contextPath}/admin/rippleNewsList.do'); 
 		   $("#frm").submit();
 		});
 		$('[name=btnSave]').click(function(e) {
			$('#frm').attr('action', '${contextPath}/admin/insertRippleNewsArticle.do'); 
			$("#frm").submit(); 
 		});
 		
 		$('[name=btnFileDownload]').click(function(e) {
			e.preventDefault();
			var category = $(this).attr('data_category');
			var $imgId = $(this).parent().find(':hidden');
			COM.openFileListPopup(category, $imgId.val());
		});
 		
 		$("img[name=btnFileUpload]").on("click", function(e) {
			var offset = $(this).offset();
    		var fieldId = $(this).attr('data_fieldId');
    		var thisType = $(this).attr('data_type');
    		var category = $(this).attr('data_category');
    		var fileMax = $(this).attr('data_fileMax');
    		var fileMode = "U";
    		
    		var $imgId = $(this).parent().find(':hidden');
    		
    		e.preventDefault();
    				
    		var url = "${contextPath}/files/uploadPage.do?";
			var atchFileId = $(this).parent().find(':hidden').val();
			var param = {
					atchFileId : atchFileId
					, contentType : thisType
					, category : category
					, size : fileMax
					, fieldId : fieldId
					, fileMode : fileMode
			}
			
			window.open(url+ $.param(param), 'popUpWindow','height=300, width=650, left=300, top=100, resizable=no, scrollbars=yes, toolbar=yes, menubar=no, location=no, directories=no, status=yes');
    		
		});
	

	});

	function dataApply(returnValue, fieldId) {
			
			if (returnValue != null ) {
				var $fieldId = $('#'+ fieldId+'');
				var files = returnValue;
				var fileNmme = "";
				var $fileNmme = $fieldId.parent().find('[name=file1_text]');
				
				if(files.length == 0){
					$fileNmme.val('');
					return;
				}
				$fieldId.val(files[0].atchFileId);
				for(var i = 0; i < files.length; i++){
					if(fileNmme == ""){
						fileNmme += files[i].realName;
					} else {
						fileNmme += ","+files[i].realName;
					}
				}
				$fileNmme.val(fileNmme);
			} else {
				$imgId.val('');
				$fileNmme.val('');
			}
			
			//location.reload();
		}

  </script>
    

