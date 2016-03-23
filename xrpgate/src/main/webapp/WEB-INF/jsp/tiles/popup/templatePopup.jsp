<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>  
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>XRP GATE_Admin</title>
<%@ include file="../../include/taglib.jsp" %>
<%@ include file="../../include/cssJsImport.jsp" %>
</head>
<body>
  <!-- tiles:insertAttribute name="menu" /-->
  <tiles:insertAttribute name="body" />
</body>
<script type="text/javascript">
$(function(){
	
	
	$(".numberic").each(function(){
		var num = $(this).text();
		var idx = num.indexOf(".");
		var pointer ; 
		if(idx < 0 ){
			pointer = 0;
		} else {
			pointer = num.substr(idx+1, num.length).length;
		}
		
		$(this).text($.number($(this).text(), pointer));	
	});
});
</script>
</html>