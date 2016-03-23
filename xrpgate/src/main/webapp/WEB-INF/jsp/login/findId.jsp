<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/taglib.jsp" %>

 <div class="con_title">
  <li>
    <img src="../../images/sub/find_id,pw.png" />
  </li>
</div> 
<div class="content">
    <div class="content_in">
        <div class="con_info">
            <div class="find">
                <div class="find_id">
                    <div class="find_id_title">
                        ● 아이디찾기
                    </div>  
                    <div class="find_id_box">
                        <div class="find_id_info">
                            <li class="info_title">이름</li>
                            <li><input type="text" name="mberNm"/></li>
                        </div>
                        <div class="find_id_info" style="margin-bottom:0;">
                            <li class="info_title">휴대폰 번호</li>
                            <li><input type="text" id="phoneHead" style="width:50px;"/></li>
                            <li>-</li>
                            <li><input type="text" id="phoneMiddle" style="width:60px;" /></li>
                            <li>-</li>
                            <li><input type="text" id="phoneTail" style="width:60px;" /></li>
                        </div>
                        <div id="div-similar" class="find_id_info" style="display:none; margin-bottom:0;">
                        	<li class="info_title">아이디</li>
                        	<li id="searchedId"></li>
                        </div>
                    </div>
                    <div class="find_btn_box">
                    	<div class="find_btn">
                            <a href="#" id="btnFindId">
                                찾기
                            </a>        
                        </div>
                                    
                    </div>
                </div>
                
                <div class="find_pw">
                    <div class="find_id_title">
                        ● 임시 비밀번호 발급
                    </div>  
                    <div class="find_id_box">
                        <div class="find_id_info">
                            <li class="info_title">아이디</li>
                            <li><input type="text" name="mberId"/></li>
                        </div>
                        <div class="find_id_info">
                            <li class="info_title">이름</li>
                            <li><input type="text" name="mberNm1"/></li>
                        </div>
                        <div class="find_id_info" style="margin-bottom:0;">
                            <li class="info_title">휴대폰 번호</li>
                            <li><input type="text" id="phoneHead1" style="width:50px;"/></li>
                            <li>-</li>
                            <li><input type="text" id="phoneMiddle1" style="width:60px;" /></li>
                            <li>-</li>
                            <li><input type="text" id="phoneTail1" style="width:60px;" /></li>
                        </div>
                        <div id="div-pass" class="find_id_info" style="display:none; margin-bottom:0;">
                        	<li class="info_title">임시 비밀번호</li>
                        	<li id="searchedPass"></li>
                        </div>
                    </div>
                    <div class="find_btn_box">
                    	<div class="find_btn">
                            <a href="#" id="btnFindPass">
                                찾기
                            </a>        
                        </div>            
                    </div>
                </div>
            </div>
        </div>
    </div>    
</div>

 <script type="text/javaScript" language="javascript">
 $(function(){
	 $("#btnFindId").click(function(e){
		e.preventDefault;
		$("#div-similar").hide();
		var moblphonNo = $('#phoneHead').val()+$('#phoneMiddle').val()+$('#phoneTail').val();
		var url = "${contextPath}/login/findIdByMber.do";
		var mberNm = $("[name=mberNm]").val();
		var param = {
				moblphonNo : moblphonNo
				, mberNm : mberNm
		}
		
		sendPost(url, param, "fn_findMberId");
	 });
	 
	 $("#btnFindPass").click(function(e){
			e.preventDefault;
			$("#div-pass").hide();
			var moblphonNo = $('#phoneHead1').val()+$('#phoneMiddle1').val()+$('#phoneTail1').val();
			var url = "${contextPath}/login/findPassByMber.do";
			var mberNm = $("[name=mberNm1]").val();
			var mberId = $("[name=mberId]").val();
			var param = {
					moblphonNo : moblphonNo
					, mberNm : mberNm
					, mberId : mberId
			}
			
			sendPost(url, param, "fn_findMberPass");
		 });
	
 });
    
    
    function rpad(newValue, len, ch){
    	var str=newValue;
    	if(str == null)
    		str = "";
    	var strlen = str.length;
    	var ret = ""
    	var alen = len - strlen;
    	var astr = "";
    	
    	//부족한 숫자만큼 len 크기로 ch 문자로 채우기
    	for (i=0; i<alen; ++i){
    		astr = astr + ch;
    	}
    	ret = str + astr;
      //뒤에서 채우기
      return ret;
    }
    
    function fn_findMberId(data){
    	if(data.isSuccess){
    		//$("#div-similar").html('');  
        	
        	//$("#div-similar").css("display","block");
        	var $body = $('#div-similar');
        	$body.find("#searchedId").text(data.mberId);
        	$body.show();
        	//$body.html(data.mberId);
    	} else {
    		alert(data.message);
    	} 
    		
    }
    
    function fn_findMberPass(data){
    	if(data.isSuccess){
    		//$("#div-similar").html('');  
        	
        	//$("#div-similar").css("display","block");
        	var $body = $('#div-pass');
        	$body.find("#searchedPass").text(data.tempPass);
        	$body.show();
        	//$body.html(data.mberId);
    	} else {
    		alert(data.message);
    	} 
    		
    }
    
  </script>