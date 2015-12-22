<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<link href="/css/style2.css" rel="stylesheet" type="text/css">

<!--타이틀시작-->
<!-- <div id="header"><img src="/img/title0001.jpg" width="400" height="35" /> -->
<!-- </div> -->
<!--타이틀끝-->

<!--섹션시작-->
<div id="section"> 

	<!--본문시작-->
	<form id="loginForm" action ="<c:url value='/login/actionLogin.do'/>" method="post">
	<input name="userSe" type="hidden" value="GNR">
	<div id="section00"><img src="/img/s1.jpg" width="790" height="250" border="0" usemap="#login_Map" border="0" />
	  <map name="login_Map" id="login_Map">
	    <area shape="rect" coords="651,94,713,158"  id="button_login"/>
	  </map>
	<div id="section01">
	    <label for="textfield""></label>
	    <input type="text" name=id id="id"  style="width:220px; height:30px;" />
	</div>
	<div id="section02">
	    <label for="textfield2"></label>
	    <input type="password" name="password" id="password" style="width:220px; height:30px;" />
	</div>
	</div>
	</form>
	<!--본문 끝-->

	<!--우측메뉴 시작-->
	<div id="rightmenu">
	    <div id="rightmenu01"><img src="/img/m60010.jpg" width="95" height="120" usemap="#Map4" border="0" />
	      <map name="Map4" id="Map4">
	        <area shape="rect" coords="7,8,86,116" href="#" />
	      </map>
	    </div>
	    <div id="rightmenu02"><img src="/img/m60011.jpg" width="95" height="120" usemap="#Map5" border="0" />
	      <map name="Map5" id="Map5">
	        <area shape="rect" coords="8,13,88,116" href="#" />
	      </map>
	    </div>
	    <div id="rightmenu03"><img src="/img/m60012.jpg" width="95" height="120" usemap="#Map6" border="0" />
	      <map name="Map6" id="Map6">
	        <area shape="rect" coords="9,11,85,115" href="#" />
	      </map>
	    </div>
	</div>

</div>

<script type="text/javaScript" language="javascript">
	$(function(){
		$("#loginForm").attr({action:"${contextPath}/login/actionLogin.do", target:""});
// 		$("#loginForm input[name=userSe]").val("GNR");
		
		$('#password').keypress(function(e){
			if(e.which == 13){
				$("#loginForm").submit();
				return false;
			}
		});
		
		$("#button_login").bind("click", function(){
			if($("#loginForm #id").val() == ""){
				 alert("아이디를 입력하세요");
			}else if($("#loginForm #password").val() == ""){				
				alert("비밀번호를 입력하세요");
			} else{
				$("#loginForm").submit();
			}
		});
	});
	
	function join() {
    	$("#loginForm").attr({action:"${contextPath}/join/UserSeChoose.do", target:""});		
    	$("#loginForm").submit();
	}
	
	function findId() {
		$("#loginForm").attr({action:"${contextPath}/login/findId.do", target:""});
		$("#loginForm").submit();
	}
	function findPassword() {
		$("#loginForm").attr({action:"${contextPath}/login/findPassword.do", target:""});
		$("#loginForm").submit();
	}
	 
</script>
