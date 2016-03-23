<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link href="<c:url value='/css/admin.css'/>" rel="stylesheet" />

<script src="<c:url value='/js/file/jquery.ui.widget.js'/>"></script>

<script src="<c:url value='/js/file/jquery.fileupload-ui.js'/>"></script>
<script src="<c:url value='/js/file/jquery.fileupload-process.js'/>"></script>
<script src="<c:url value='/js/file/jquery.fileupload-image.js'/>"></script>
<script src="<c:url value='/js/file/jquery.fileupload-validate.js'/>"></script>
<!--  
<script src="<c:url value='/js/file/jquery.fileupload.js'/>"></script>
<script src="<c:url value='/js/file/jquery.iframe-transport.js'/>"></script>
<script src="<c:url value='/js/file/jquery.postmessage-transport.js'/>"></script>
<script src="<c:url value='/js/file/jquery.xdr-transport.js'/>"></script>
-->


<style type="text/css">
.right {width:100%; height:100px; padding:0; margin:0; top:650px; }

</style>
<script>
//esc 키로 모달 창을 닫는 경우 modal dialog가 정상적으로 해제 처리 되지 않아 다시 여는 경우 화면이 깨지는 현상 발생. esc키 입력을 ufn_closeModal() 수행으로 연결
var KEYCODE_ESC = 27;
$(document).ready(function(){
	$(document).keyup(function(e) {
		  if (e.keyCode == KEYCODE_ESC){
			  e.preventDefault();
			  ufn_closeModal();
		  }
	});
});

</script>
<div>
	<div class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-draggable modal" role="dialog"
	style="height: auto; width: 630px; top: 0px; left: 0px; display: block; border:0px ;" aria-describedby="atchFile" aria-labelledby="ui-id-1">
		<div id="cntr_atchFileId" class="modalContainer" style="overflow-x:none; overflow-y:auto;width:100%; padding:0 0 0 0;">
		<form id="fileupload" method="post" action="<c:url value='/files/upload.do' />" enctype="multipart/form-data">
			<!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
			<div class="fileupload-buttonbar">
			<c:if test="${fileMode == 'U' }">
			<div class="fileupload-buttons">
				<!-- The fileinput-button span is used to style the file input field as button -->
				<span class="fileinput-button"> <span>파일추가...</span> <input type="file" name="files[]" multiple="multiple" />
				</span>
				<button type="submit" class="start">일괄올리기</button>
				<button type="reset" class="cancel">취소 </button>
				<button type="button" class="delete">일괄삭제</button>
<!-- 				<button type="button" class="download">전체 다운로드</button> -->
				<input type="checkbox" class="toggle" />
				<!-- The global file processing state -->
				<span class="fileupload-process"></span>
			</div>
			</c:if>
				
				<!-- The global progress state -->
				<div class="fileupload-progress fade" style="display: none">
					<!-- The global progress bar -->
					<div class="progress" role="progressbar" aria-valuemin="0" aria-valuemax="100"></div>
					<!-- The extended global progress state -->
					<div class="progress-extended">&nbsp;</div>
				</div>
			</div>
			<!-- The table listing the files available for upload/download -->
			<!-- form 내부에 있어야 함. -->
			<div class="scroll_auto margin_t5" style="height: 200px;">
				<table role="presentation" style="width: 99%;"   class="my_modalTable  table-striped" >
					<colgroup>
						<col width="35%">
						<col width="15%">
						<col width="20%">
						<col width="30%">
					</colgroup>
					<tbody class="files" style="vertical-align:middle;" ></tbody>
				</table>
			</div>
			<!-- // 1/24 수정 -->
			<input type="hidden" name="atchFileId"> 
		</form>
		 
	</div>
	</div>
	<div align="right" style="position: absolute; left: 560px; top: 230px;">
	<button id="btnClose"  class="start ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="btton" aria-disabled="false" >
				<span class="ui-button-icon-primary ui-icon ui-icon-circle-arrow-e"></span><span class="ui-button-text">닫 기</span>
			</button>
	</div>
</div>
<input type="hidden" name="isUpdate" value="${isUpdate}">

<!-- The template to display files available for upload -->
<script id="template-upload" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload fade">
        <td>
            <span class="preview"></span>
        </td>
        <td>
            <p class="name">{%=file.name%}</p>
            <strong class="error text-danger"></strong>
        </td>
        <td>
            <p class="size">Processing...</p>
            <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="progress-bar progress-bar-success" style="width:0%;"></div></div>
        </td>
        <td>
            {% if (!i && !o.options.autoUpload) { %}
                <button class="btn btn-primary start" disabled>
                    <i class="glyphicon glyphicon-upload"></i>
                    <span>올리기</span>
                </button>
            {% } %}
            {% if (!i) { %}
                <button class="btn btn-warning cancel">
                    <i class="glyphicon glyphicon-ban-circle"></i>
                    <span>중단</span>
                </button>
            {% } %}
        </td>
    </tr>
{% } %}
</script>
<!-- The template to display files available for download -->
<script id="template-download" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-download fade">
        <td>
            <span class="preview">
                {% if (file.thumbnailUrl) { %}
                    <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" data-gallery><img src="{%=file.thumbnailUrl%}"></a>
                {% } %}
            </span>
        </td>
        <td>
            <p class="name">
                {% if (file.url) { %}
                    <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" {%=file.thumbnailUrl?'data-gallery':''%}>{%=file.name%}</a>
                {% } else { %}
                    <span>{%=file.name%}</span>
                {% } %}
            </p>
            {% if (file.error) { %}
                <div><span class="label label-danger">Error</span> {%=file.error%}</div>
            {% } %}
        </td>
        <td>
            <span class="size">{%=o.formatFileSize(file.size)%}</span>
        </td>
        <td>
			{% if (file.isUpdate) { %}
            {% if (file.deleteUrl) { %}
                <button class="btn btn-danger delete" data-type="{%=file.deleteType%}" data-url="{%=file.deleteUrl%}"{% if (file.deleteWithCredentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>
                    <i class="glyphicon glyphicon-trash"></i>
                    <span>삭제</span>
                </button>
                <input type="checkbox" name="delete" value="1" class="toggle">
            {% } else { %}
                <button class="btn btn-warning cancel">
                    <i class="glyphicon glyphicon-ban-circle"></i>
                    <span>Cancel</span>
                </button>
            {% } %}
			{% } %}
        </td>
	
    </tr>
{% } %}
</script>

<script>
var fileOptions;
var isUpdate = "${isUpdate}";
$(function () {
	//debugger;
	$('body').css('height', '350px');
	var atchFileId = "${fileVo.atchFileId}";
	var size = "${fileVo.size}";
	var category = "${fileVo.category}";
	var contentType = "${fileVo.contentType}";
	var fieldId = "${fileVo.fieldId}";
	var filesInfo = [];
	$('#fileupload').fileupload({
		
	    url: '/files/upload.do?Category='+ category+ '&AtchFileId=' + atchFileId,
	    maxFileSize : 10000000,
		maxNumberOfFiles : parseInt(size),
		//acceptFileTypes : contentType == null ? new RegExp('') : new RegExp('(.|)(' + unescape('jpg|jpeg|png|bmp|gif') + ')$'),
	    getFilesFromResponse : function(responseText) {
			if (responseText.result) {
				responseText = responseText.result;
			}
			if (responseText.IsSucceed) {

				var files = new Array();
				for (var i = 0; i < responseText.Data.length; i++) {
					var item = responseText.Data[i];
					var file = {
						fileRef : item,
						fileId : item.fileId,
//							name : 'aa',
//							name : unescape(item.orignlFileNm),
						name : decodeURIComponent(item.orignlFileNm),
						url : '<c:url value="/files/download.do?" />' + $.param(item),//$(item).convertQueryStrings(),
						size : parseInt(item.fileMg),
						deleteType : 'post',
						deleteUrl : '<c:url value="/files/remove.do?" />' + $.param(item),//$(item).convertQueryStrings()
					}
					if (contentType == "img") {
						file.thumbnailUrl =  '<c:url value="/files/imageSrc.do?path=" />'+ category  +'/thumnails&physical='  + item.streFileNm;
					}
					files.push(file);
				}
				return files;
			} else {
				return [];
			}
		},
		started : function(e, data) {
			isModified = true;
		},
		destroyed : function(e, data) {
			isModified = true;

			if (data.result) {
				data = data.result;
			}
			if (data.Data == null) {
				return;
			}
			var files = $(this).closest('.modalContainer').data('data');
			var newFiles = [];
			for (var i = 0; i < files.length; i++) {
				if (files[i].streFileNm != data.Data.streFileNm) {
					newFiles.push(files[i]);
				}
			}
			//setFileIds(newFiles);
			$(this).closest('.modalContainer').data('data', newFiles);
		},
		completed : function(e, data) {
			//debugger;
			if (data.result) {
				data = data.result;
			}
						
			for (var i = 0; i < data.Data.length; i++) {
				filesInfo.push(data.Data[i]);
			}

		}
	});

    if (atchFileId != null && atchFileId != '' && atchFileId != 'undefined') {
		getFileList(atchFileId);
	};
	
	function  getFileList(fileIds){
		$('#fileupload').addClass('fileupload-processing');
		$.ajax({
			url : '<c:url value="/files/getFiles.do?fileIds=" />' + fileIds + '&isUpdate=' +$('[name=isUpdate]').val(),
			dataType : 'json',
			context : $('#fileupload')[0],
			error:function(request,status,error){
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    }
		}).always(function() {
			$(this).removeClass('fileupload-processing');
		}).done(function(responseText) {
			$(this).fileupload('option', 'done').call(this, $.Event('done'), responseText);
		});
	}

	$("#btnClose").click(function(e){
		e.preventDefault;
		
		for(var i = 0; i < filesInfo.length ; i++){
			if(filesInfo[i].realName == "" || filesInfo[i].realName == null && filesInfo[i].orignlFileNm != ""){
				filesInfo[i].realName = filesInfo[i].orignlFileNm;
			}
		}
		
		if(isUpdate == "true"){
			opener.dataApply(filesInfo, fieldId);
		}
		
		window.open('', '_self').close();
	});

});
	


</script>


