<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%

%>


<!--<title>파일목록</title> -->


		<c:forEach var="fileVO" items="${fileList}" varStatus="status">
			<div class="calSize"  fileSize='${fileVO.fileMg}'><script>document.write(decodeURIComponent('${fileVO.orignlFileNm}') )</script> &nbsp; 
			<script>document.write('('+BIT.formatFileSize(${fileVO.fileMg})+')')</script> </div>
		</c:forEach>
		<c:if test="${fn:length(fileList) == 0}">
	    </c:if>


<!-- 	<table> -->
<%-- 		<c:forEach var="fileVO" items="${fileList}" varStatus="status"> --%>
<!-- 		<tr> -->
<!-- 			<td>                                                                                                                -->
<%-- 					<div class="calSize"  fileSize='${fileVO.fileMg}'><script>document.write(decodeURIComponent('${fileVO.orignlFileNm}') )</script> &nbsp;  --%>
<!-- 					<script>document.write('('+BIT.formatFileSize(${fileVO.fileMg})+')')</script> </div> -->
<!-- 			</td> -->
<!-- 		</tr> -->
<%-- 		</c:forEach> --%>
<%-- 		<c:if test="${fn:length(fileList) == 0}"> --%>
<!-- 			<tr> -->
<!-- 				<td></td> -->
<!-- 			</tr> -->
<%-- 	    </c:if> --%>
<!-- 	</table> -->
	
<script type="text/javascript">

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