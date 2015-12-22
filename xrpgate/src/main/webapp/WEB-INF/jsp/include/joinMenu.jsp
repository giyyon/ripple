<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/taglib.jsp" %>

   
            		<div id="menuNaviJoin">
	            		<div class="con_tit">회원정보 <span>Membership</span>
	                    	<span class="ex">고객님의 소중한 정보를 관리합니다.</span>
	                    </div>
	                    
	                    <ul class="tap4_wrp mt10">
	                    	<li><a href="javascript:goJoin()"  id='join'>회원가입</a></li>
	                        <li><a href="javascript:goFindId()" id='idFind'>아이디 찾기</a></li>
	                        <li><a href="javascript:goFindPassword()" id='passwordFind'>비밀번호 찾기</a></li>
	                        <li><a href="javascript:goMyInfo()" id='myInfo'>내정보 바로가기</a></li>
	                    </ul>
	                </div>
                   
                    <div id="menuNaviLogin">
                       	<div class="con_tit">회원정보관리 <span>Membership</span>
	                    	<span class="ex">고객님의 소중한 정보를 관리합니다.</span>
	                    </div>
	
	                    <ul class="tap3_wrp mt10">
	                    	<li><a href="javascript:goMyInfo()" id="mainInfo">기본정보/비밀번호 관리</a></li>
	                        <li><a href="javascript:goMyInfoSub()" id="subInfo">부가정보 관리</a></li>
	                        <li><a href="javascript:gowithdraw()" id="secsn">회원탈퇴</a></li>
	                    </ul>
                    </div>

    <script type="text/javascript" charset="utf-8">
    	$(function (){
    		$('menuNaviJoin a, menuNaviLogin a').removeClass('select');
//     		$('#menuNaviJoin, #menuNaviLogin').css("display","none");
        	
    		var $path = $(location).attr('pathname');
    		
    		var isMyInfo = $path.indexOf("/myInfo/");
    		if(isMyInfo != -1){
    			//내정보 메뉴
    			$('#menuNaviLogin').css("display","block");
            		
	           	 if($path == '/myInfo/myInfoView.do')
		         		$('#mainInfo').addClass('select');
		         	else if($path == '/myInfo/myInfoSubView.do')
		         		$('#subInfo').addClass('select');
		         	else if($path == '/myInfo/myInfoSecsnView.do')
		         		$('#secsn').addClass('select');
	           	 
    		}else{
    			//그외 메뉴(회원가입/아디/비번찾기)
    			$('#menuNaviJoin').css("display","block");
	           	 if($path == '/login/findId.do')
	         		$('#idFind').addClass('select');
	         	else if($path == '/login/findPassword.do')
	         		$('#passwordFind').addClass('select');
	         	else if($path == '/myInfo/myInfoView.do')
	         		$('#myInfo').addClass('select');
	         	else
	          		$('#join').addClass('select');
    		}

//         	    console.log("href: "+$(location).attr('href'));
//         	    console.log("protocol: "+$(location).attr('protocol'));
//         	    console.log("host: "+$(location).attr('host'));
//         	    console.log("pathname: "+$(location).attr('pathname'));
//         	    console.log("search: "+$(location).attr('search'));       		
    	});
    		
    	
    	function goJoin(){
    		window.location = "${contextPath}/join/UserSeChoose.do";
    	}
    	
    	function goFindId(){
    		window.location = "${contextPath}/login/findId.do";
    	}
    	function goFindPassword(){
    		window.location = "${contextPath}/login/findPassword.do";
    	}
    	function goMyInfo(){
    		window.location = "${contextPath}/myInfo/myInfoView.do";
    	}
    	
    	function goMyInfoSub(){
    		window.location = "${contextPath}/myInfo/myInfoSubView.do";
    	}
    	function gowithdraw(){
    		if (confirm("확인을 누르면 회원 탈퇴 처리됩니다.정말 회원 탈퇴하시겠습니까?") == true){ 
    			   //확인
    			    window.location = "${contextPath}/myInfo/updateWithdraw.do";
    			}else{   
    				//취소
    			    return;
    			}
    		
    	}
    	
    	
    </script>