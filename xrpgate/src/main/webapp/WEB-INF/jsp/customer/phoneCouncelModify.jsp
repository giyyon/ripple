<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<link href="/css/style10.css" rel="stylesheet" type="text/css">

<!--타이틀시작-->
<div id="header3"><img src="/img/title0013.jpg" width="400" height="35" />
</div>
<!--타이틀끝-->

<!--섹션시작-->
<div id="section"> 

	<!--본문시작-->
	<form:form commandName="boardVO"  id="form">
		<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
		<input type="hidden" name="nttId"  value="<c:out value="${boardVO.nttId}"/>" />
		<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
		<input name="searchCnd" type="hidden" value="<c:out value='${searchVO.searchCnd}'/>"/>
		<input name="searchWrd" type="hidden" value="<c:out value='${searchVO.searchWrd}'/>"/>
		<input type="hidden" name="ntcrId"  value="<c:out value="${boardVO.ntcrId}"/>" /> <!--작성자id -->
		<input type="hidden" id="moblphonNo"  name="moblphonNo"  value="<c:out value="${boardVO.moblphonNo}"/>" > <!--핸드폰번호 -->
		
	<div id="aside">
		<img src="/img/s8_0005.jpg" usemap="QnA_Map"  width="790" height="1041" border="0" />
		<map name="QnA_Map" id="QnA_Map">
		    <area shape="rect" coords="627,575,758,624" id="button_QnA" />
		</map>
		<div id="section09">
			<form:select path="moblphonNoHead" style="width:60px; height:20px;">
				<form:option value='010' label="010" />
			    <form:option value='011' label="011" />
			    <form:option value='016' label="016" />
			    <form:option value='017' label="017" />
			    <form:option value='018' label="018" />
			    <form:option value='019' label="019" />
			</form:select>
		</div>
		<div id="section010"><input name="moblphonNoMiddle"  id="mbtlnumMiddle"  value="${boardVO.moblphonNoMiddle}" type="text" style="width:100px; height:20px;"" /></div>
		<div id="section011"><input name="moblphonNoTail"  id="mbtlnumTail" value="${boardVO.moblphonNoTail}"  type="text" style="width:100px; height:20px;" /></div>
		<div id="section015"><input name="ntcrNm" id="ntcrNm"  value="<c:out value="${boardVO.ntcrNm}"/>"  type="text"style="width: 130px; height: 20px;" /></div>
		<div id="section020">
           <form:textarea path="nttCn"  htmlEscape="false" ></form:textarea>
           <script>
           CKEDITOR.replace(
        	'nttCn',
        	{
        		contenteditable:"false",
        		filebrowserImageUploadUrl : '/files/ckEditor/insertImage.do',
        		width : '730', //넓이값
        		height : '100'      //높이값
        	}
           );
           </script>
<!-- 		<input name="" type="text"style="width: 730px; height: 250px;" /> -->
		</div>
	</div>
	</form:form>
	<!--본문 끝-->

	<!--우측메뉴 시작-->
	<%@ include file="../include/rightMenu.jsp" %>
</div>

<script type="text/javaScript" language="javascript">
	$(function(){
		$("form").attr({action:"${contextPath}/customer/insertPhoneCouncelArticle.do", target:""});
		
		$( "#moblphonNoHead, #moblphonNoMiddle,  #moblphonNoTail" ) .change(function () {
			$("#moblphonNo").val(  $( "#moblphonNoHead" ).val() +'-'+ $( "#moblphonNoMiddle" ).val() +'-'+ $( "#moblphonNoTail" ).val() );
		});
		
		$("#button_QnA").bind("click", function(){
				$("#form").submit();
		});
	});
</script>
