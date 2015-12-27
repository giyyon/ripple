<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>


	<!--본문시작-->
<form id="loginForm" action ="<c:url value='/login/actionLogin.do'/>" method="post">
	<input name="userSe" type="hidden" value="GNR">
	<div class="con_title">
	  <li>
	    <img src="/images/sub/login_title.png" />
	  </li>
	</div> 
	<div class="content">
	    <div class="content_in">
	        <div class="con_info">
				<div class="login_box">
	            	<div class="loginbox_in">
	                	<div class="id">
	                    	<li class="login_title">아이디</li>
	                        <li><input type="text" name=id id="id"/></li>
	                    </div>
	                    <div class="pw">
	                    	<li class="login_title">비밀번호</li>
	                        <li><input type="password" name="password" id="password"/></li>
	                    </div>
	                    <div class="log_btn">
	                    	<a href="#" id="btnLogin"><img src="/images/btn/login_btn_big.png" /></a>
	                    </div>
	                </div>
	             	<div class="find_idpw">
	                    <li><a href="javascript:goSave();">회원가입</a></li>
	                    <li> | </li>
	                    <li><a href="javascript:goSave();">아이디/비밀번호 찾기</a></li>
	                </div>
	            </div>
	        </div>
	    </div>    
	</div>
</form>
<!--본문 끝-->

	


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
		
		$('#btnLogin').on("click",function(){
			if($("#loginForm #id").val() == ""){
				 alert("아이디를 입력하세요");
			}else if($("#loginForm #password").val() == ""){				
				alert("비밀번호를 입력하세요");
			} else{
				$("#loginForm").submit();
			}
		})
		
		
		function loginGo(){
			if($("#loginForm #id").val() == ""){
				 alert("아이디를 입력하세요");
			}else if($("#loginForm #password").val() == ""){				
				alert("비밀번호를 입력하세요");
			} else{
				$("#loginForm").submit();
			}
		}
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
