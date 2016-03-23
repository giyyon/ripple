<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="<c:url value='/css/admin.css'/>" rel="stylesheet" />
<style type='text/css'>
	 li.file { 
        list-style:disk inside; 
      vertical-align:middle;
        height:30px;
       }
    li.file input{ 
        margin-bottom:15px;
       }
</style>

<form:form commandName="mberVo"  id="frm">
<div class="chn_pop_box">
 	<div class="pop_title">본인인증 회원확인</div> 
    <div class="pop_table">
    	<table cellpadding="0" cellspacing="0">
        	<tr>
                <td width="80px" class="pop_table_title">이름</td>
                <td width="90px">${mberVo.mberNm }</td>
                <td width="80px" class="pop_table_title">아이디</td>
                <td width="150px">${mberVo.mberId }</td>
                <td width="100px" class="pop_table_title">리플지갑주소</td>
                <td width="150px">${mberVo.rippleTradeEmail }</td>
                <td width="100px" class="pop_table_title">가입날짜</td>
                <td width="100px">${mberVo.registDt } </td>
            </tr>
        </table>
    </div>
    
    <div class="pop_title_2">본인인증 파일</div>
     <div class="pop_table_person">
    	<table cellpadding="0" cellspacing="0">
        	<tr>
                <td width="100px" class="pop_table_title">주민등록증</td>
                <td width="550px">
                	<li>${mberManageVO.atchFileId}
                        <form:hidden path="atchFileId" value="${mberManageVO.atchFileId}"/>
						<input name="file1_text" type="text" value="${mberManageVO.atchFileId}"/>
						<img name="btnFileUpload" src="${contextPath}/images/common/btn_searchfile.png" data_fileMax="5" data_category="mber"  data_type="img" data_fieldId="atchFileId" alt="찾아보기"   />
					</li>
					<li>
						<c:import url="/files/selectFileInfsAdvence.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${mberVo.atchFileId}" />
					 	</c:import>
					</li>
                </td>
                
            </tr>
            <tr>
                <td width="100px" class="pop_table_title">증명사진</td>
                <td width="550px" >
					<li class="file">
                        <form:hidden path="atchFileId1" value="${mberManageVO.atchFileId1}"/>
						<input name="file1_text" type="text" readOnly="true" />
						<img name="btnFileUpload" style="text-align:center;" src="${contextPath}/images/common/btn_searchfile.png" data_fileMax="5" data_category="mber"  data_type="img" data_fieldId="atchFileId1" alt="찾아보기"   />
					</li>
					<li>
						<c:import url="/files/selectFileInfsAdvence.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${mberVo.atchFileId1}" />
					 	</c:import>
					</li>
				</td>
                
            </tr>
            <tr>
                <td width="100px" class="pop_table_title">여권사본</td>
                <td width="550px">
                	<li>
                        <form:hidden path="atchFileId2" value="${mberManageVO.atchFileId2}"/>
						<input name="file1_text" type="text" class="w400"/>
						<img name="btnFileUpload" src="${contextPath}/images/common/btn_searchfile.png" data_fileMax="5" data_category="mber"  data_type="img" data_fieldId="atchFileId2" alt="찾아보기"   />
					</li>
					<li>
						<c:import url="/files/selectFileInfsAdvence.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${mberVo.atchFileId2}" />
					 	</c:import>
					</li>
                </td>
                
            </tr>
            <tr>
                <td width="100px" class="pop_table_title">통장사본</td>
                <td width="550px">
                	<li>
                        <form:hidden path="atchFileId3" value="${mberManageVO.atchFileId3}"/>
						<input name="file1_text" type="text" class="w400"/>
						<img name="btnFileUpload" src="${contextPath}/images/common/btn_searchfile.png" data_fileMax="5" data_category="mber"  data_type="img" data_fieldId="atchFileId3" alt="찾아보기"   />
					</li>
					<li>
						<c:import url="/files/selectFileInfsAdvence.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" value="${mberVo.atchFileId3}" />
					 	</c:import>
					</li>
                </td>
                
            </tr>
        </table>
    </div>
    
    
    <div class="pop_btn">
    	<li><a href="#" name="btnSave"><img src="${contextPath}/images/admin/admin_submit_btn.png" /></a></li>
        <li style="margin-left:20px;" ><a href="#" name="btnCancle"><img src="${contextPath}/images/admin/admin_cancle_btn.png" /></a></li>
    </div>
 </div>
 <input type="hidden" name="mberId" value="${mberVo.mberId }">
</form:form>
 
 <div class="pop_cc" style="position: relative;">
	<div class="pop_cc_in">Copyrightⓒ2015 By XRPGATE. All right reserved.</div>
</div>

<script type="text/javaScript" language="javascript">
	$(function(){
		
		$("[name=btnCancle]").click(function(e){
			window.close();
		});
		
		$("[name=btnSave]").click(function(e){
			e.preventDefault;
			
			var url = "${contextPath}/admin/updateMberAtchFileInfo.do?";
			var atchFileId = $("[name=atchFileId]").val();
			var atchFileId1 = $("[name=atchFileId1]").val();
			var atchFileId2 = $("[name=atchFileId2]").val();
			var atchFileId3 = $("[name=atchFileId3]").val();
			var mberId = $("[name=mberId]").val();
			var param = {
					mberId : mberId
					, atchFileId : atchFileId
					, atchFileId1 : atchFileId1
					, atchFileId2 : atchFileId2
					, atchFileId3 :atchFileId3
			}
			
			sendPost(url, param, "fn_updateMberInfo");
		});
		
		//파일 업로드 처리
		$("img[name=btnFileUpload]").on("click", function(e) {
			var offset = $(this).offset();
    		var fieldId = $(this).attr('data_fieldId');
    		var thisType = $(this).attr('data_type');
    		var category = $(this).attr('data_category');
    		var fileMax = $(this).attr('data_fileMax');
    		
    		
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
			}
			
			window.open(url+ $.param(param), 'mberAtchFile','height=300, width=650, left=300, top=100, resizable=no, scrollbars=yes, toolbar=yes, menubar=no, location=no, directories=no, status=yes');
    		
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
		
		$("[name=btnSave]").trigger("click");
		location.reload();
	}
	
	function fn_updateMberInfo(data){
		if(data.isSuccess){
			alert("수정되었습니다.");
			location.reload();
			//window.open('', '_self').close();
		} else {
			alert("수정되지 않았습니다.");
		}
	}
</script>
