<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>  
<html lang="ko">

	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />   
	    <meta charset="utf-8" />
	    <meta http-equiv="Content-Type" content="IE=Edge,chrome=1" />
	    <title>XRP GATE</title>
	</head>
	<body>
		<tiles:insertAttribute name="import" />
		<tiles:insertAttribute name="header" />
		<tiles:insertAttribute name="body" />
		<tiles:insertAttribute name="footer" />
	</body>
<script type="text/javascript">
$(function(){
	
	
	$(".numberic").each(function(){
		var num ; 
		if($(this).prop("tagName") == "INPUT"){
			num = $(this).val();
		}else {
			num = $(this).text();
		}
		
		var idx = num.indexOf(".");
		var pointer ; 
		if(idx < 0 ){
			pointer = 0;
		} else {
			pointer = num.substr(idx+1, num.length).length;
		}
		
		if($(this).prop("tagName") == "INPUT"){
			$(this).val($.number($(this).val(), pointer));
		}else {
			$(this).text($.number($(this).text(), pointer));
		}	
	});
});
</script>
</html>