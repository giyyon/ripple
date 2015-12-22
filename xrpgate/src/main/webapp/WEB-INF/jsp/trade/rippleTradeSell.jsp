<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<link href="/css/style10_1.css" rel="stylesheet" type="text/css">

<!--타이틀시작-->
<div id="header3"><img src="/img/title0012.jpg" width="400" height="35" />
</div>
<!--타이틀끝-->

<!--섹션시작-->
<div id="section"> 
	<form:form commandName="boardVO"  id="form">
		<div id="aside"><img src="/img/s8_0004.jpg" width="790" height="1008" border="0"  usemap="#Map_ripple" />
			<map name="Map_ripple" id="Map_ripple">
			  <area shape="rect" coords="628,567,759,616"   id="button_Trade" />
			</map>
		<div id="section09">
			<form:select path="moblphonNoHead" style="width:60px; height:20px;" disabled="true">
				<form:option value='010' label="010" />
			    <form:option value='011' label="011" />
			    <form:option value='016' label="016" />
			    <form:option value='017' label="017" />
			    <form:option value='018' label="018" />
			    <form:option value='019' label="019" />
			</form:select>
		</div>
		<div id="section010"><input readonly="readonly" name="moblphonNoMiddle"  id="mbtlnumMiddle"  value="${boardVO.moblphonNoMiddle}" type="text" style="width:100px; height:20px;"" /></div>
		<div id="section011"><input readonly="readonly" name="moblphonNoTail"  id="mbtlnumTail" value="${boardVO.moblphonNoTail}"  type="text" style="width:100px; height:20px;" /></div>
		<div id="section015"><input readonly="readonly" name="ntcrNm" id="ntcrNm"  value="<c:out value="${boardVO.ntcrNm}"/>"  type="text"style="width: 130px; height: 20px;" /></div>
		  <div id="section020">
		    <input name="requestSellQty" id="requestSellQty"  type="text"style="width: 150px; height: 20px;" />
		  </div>
		</div>
		</form:form>
	<!--우측메뉴 시작-->
	<%@ include file="../include/rightMenu.jsp" %>

</div>

<script type="text/javaScript" language="javascript">
	$(function(){
		$("form").attr({action:"${contextPath}/trade/insertRippleTradeSell.do", target:""});
		
		$( "#moblphonNoHead, #moblphonNoMiddle,  #moblphonNoTail" ) .change(function () {
			$("#moblphonNo").val(  $( "#moblphonNoHead" ).val() +'-'+ $( "#moblphonNoMiddle" ).val() +'-'+ $( "#moblphonNoTail" ).val() );
		});
		
		$("#button_Trade").bind("click", function(){
			if($("#requestSellQty").val() == ""){
				alert("판매할 수량을 등록하세요");
			}else{
				$("#form").submit();
			}				
		});
	});
</script>

