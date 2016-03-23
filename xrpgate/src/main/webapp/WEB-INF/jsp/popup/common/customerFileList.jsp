<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%

%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>FileDown List</title>
<link href="<c:url value='/css/admin.css'/>" rel="stylesheet" />
</head>
<body></body>
<!--<title>파일목록</title> -->


		<c:forEach var="fileVO" items="${fileList}" varStatus="status">
			<div class="calSize"  fileSize='${fileVO.fileMg}'>
			<!--	<a href="#" name="btnDown"data-atchFileId="${fileVO.atchFileId}" data-fileSn="${fileVO.fileSn}">${fileVO.orignlFileNm}</a>-->
			 <script>document.write(decodeURIComponent('${fileVO.orignlFileNm}') )</script> &nbsp; 
			<script>document.write('('+BIT.formatFileSize(${fileVO.fileMg})+')')</script> 
			
			</div>
		</c:forEach>
		<c:if test="${fn:length(fileList) == 0}">
	    </c:if>
<form id="fileForm" >
<input type="hidden" name="atchFileId" >
<input type="hidden" name="fileSn" >
</form>
	    
<script type="text/javascript">
	
	$("[name=btnDown]").on("click", function(e){
		e.preventDefault;
		
		var atchFileId = $(this).attr('data-atchFileId');
		var fileSn = $(this).attr('data-fileSn');
		
		$("[name=atchFileId]").val(atchFileId);
		$("[name=fileSn]").val(fileSn);
		
		$('#fileForm').attr({'action': '${contextPath}/files/download.do', "method": "get"}); 
		alert($('#fileForm').serialize());
		$("#fileForm").submit(); 
        
	});
	function fn_egov_downFile(atchFileId, fileSn){
// 		window.open("<c:url value='/files/download.do?atchFileId="+atchFileId+"&fileSn="+fileSn+"'/>");
	}
// 	$(document).ready(function(){
// 		$(".calSize").each(function(){
// 			var size = "("+BIT.formatFileSize($(this).attr("fileSize"))+")";
// 			$(this).append(size);
// 		});

// 	});
</script>
