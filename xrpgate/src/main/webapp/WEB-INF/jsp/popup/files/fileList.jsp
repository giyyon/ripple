<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style type="text/css">
.my_modalTable {padding:2px; border-collapse:separate; }
.my_modalTable td {vertical-align: middle;}
.table-striped>tbody>tr:nth-child(odd)>td,
.table-striped>tbody>tr:nth-child(odd)>th{background-color:#f4f4f4}
</style>
<div>
	<form id="fileupload">
		<div class="fileupload-buttonbar">
			<div class="fileupload-buttons">
				<button class="download ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false" type="button">
<!-- 					<span class="ui-button-icon-primary ui-icon ui-icon-arrowreturnthick-1-s"></span> <span class="ui-button-text">전체 다운로드</span> -->
				</button>
			</div>
		</div>
		<!-- The table listing the files available for upload/download -->
		<!-- 1/24 수정 -->
		<div class="margin_t5" style="height: 200px; overflow: auto;">
			<table role="presentation" style="width: 99%;" class="my_modalTable  table-striped" >
				<colgroup>
					<col width="55%">
					<col width="15%">
					<col width="30%">
				</colgroup>
				<tbody class="files"></tbody>
			</table>
		</div>
		<div align="right" >
			<button id="btnClose"  class="start ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="btton" aria-disabled="false" >
				<span class="ui-button-icon-primary ui-icon ui-icon-circle-arrow-e"></span><span class="ui-button-text">닫 기</span>
			</button>
		</div>
		<!-- // 1/24 수정 -->
	</form>
	<script type="text/javascript">
		var fileOptions = $('#fileupload').closest('div[id^=cntr]').data('options');

		fileIds = unescape(fileOptions.data.FileIds);
		if (fileIds != null && fileIds != '') {
			BIT.callAjax('<c:url value="/files/getFiles.do" />', 'GET', {
				fileIds : fileIds
			}, function(responseText) {
				var $body = $('.files');
				var files = responseText.Data;
				var html = '';
				for (var i = 0; i < files.length; i++) {
					var $tr = $('<tr></tr>');
					html = '   <td>';
					html += '       <p class="name">';
					html += '       ☞<a href="<c:url value="/files/download.do?" />' + $(files[i]).convertQueryStrings() + '" title="' + files[i].orignlFileNm + '" class="fileDownload" download="' + files[i].orignlFileNm + '" data-gallery>' + decodeURIComponent(files[i].orignlFileNm) + '</a>';
					html += '       </p>';
					html += '   </td>';
					html += '   <td>';
					if (files[i].hasThumnail || files[i].hasThumnail == 'true') {
						html += '       <span class="preview">';
						html += '        <span style="cursor:pointer"><img src="<c:url value="/uploadFiles/thumnails/"/>' + files[i].virtualName + '"></span>';
						html += '       </span>';
					}
					html += '   </td>';
					html += '   <td>';
					html += '       <span class="size">' + BIT.formatFileSize(files[i].fileMg) + '</span>';
					html += '   </td>';
					$tr.append(html);
					$tr.data('file', files[i]);
					$body.append($tr);
				}
			});
		};

		$(".files").on("click", '.preview span', function(e) {
			var file = $(this).closest('tr').data('file');
			BIT.showImage("<c:url value='/uploadFiles/' />" + file.category + "/" + file.virtualName, file.width, file.height);
		});

		$('.download').click(function() {
			$('.fileDownload').multiDownload();
		});

		$('#btnClose').click(function() {
			ufn_closeModal();
		});		
		
		$('#div_close').click(function() {
			$.cookie('fileIds', '');
		});
		
		function ufn_closeModal(){
			BIT.modalDialogCloseClick('modalApply', fileOptions.data.containerId);
			//첨부파일을 파일 DB에서 삭제 및 등록 이후 원 데이터 테이블의 fileID에 해당하는 컬럼도 갱신, 동기화 위한 메소드 호출. parent.doFinish()는 해당 화면에서 구현한다.	
		}
	</script>
</div>
