<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/taglib.jsp" %>

<link href="/css/style3.css" rel="stylesheet" type="text/css">

<div id="header3"><img src="/img/title0003.jpg" width="400" height="35" />
</div>
<!-- <input type="text" name="diVal"  value="" size="200"/> -->
<form:form commandName="mberManageVO"  id="form">
	<input type="hidden" id="userSe" name="userSe"  value="GNR"> <!--사용자구분 -->
	<input type="hidden" id="ihidnum" name="ihidnum" > <!--주민번호 -->
	 <input type="hidden" id="moblphonNo"  name="moblphonNo"  > <!--핸드폰번호 -->
	 <input type="hidden" name="req_tx"       value="cert"/>
	<!-- 요청구분 -->
	<input type="hidden" name="cert_method"  value="01"/>
	<!-- 웹사이트아이디 -->
	<input type="hidden" name="web_siteid"   value="J15070800859"/> 
	<!-- 노출 통신사 default 처리시 아래의 주석을 해제하고 사용하십시요 
	     SKT : SKT , KT : KTF , LGU+ : LGT
	<input type="hidden" name="fix_commid"      value="KTF"/>
	-->
	<!-- 사이트코드 -->
	<input type="hidden" name="site_cd"      value="${site_cd}" />
	<!-- Ret_URL : 인증결과 리턴 페이지 ( 가맹점 URL 로 설정해 주셔야 합니다. ) -->
	<input type="hidden" name="Ret_URL"      value="http://221.140.209.100:8091/join/kcpCertProcRes.do" />
	<!-- cert_otp_use 필수 ( 메뉴얼 참고)
	     Y : 실명 확인 + OTP 점유 확인 , N : 실명 확인 only
	-->
	<input type="hidden" name="cert_otp_use" value="Y"/>
	<!-- cert_enc_use 필수 (고정값 : 메뉴얼 참고) -->
	<input type="hidden" name="cert_enc_use" value="Y"/>
	
	<input type="hidden" name="res_cd"       value=""/>
	<input type="hidden" name="res_msg"      value=""/>
	
	<!-- up_hash 검증 을 위한 필드 -->
	<input type="hidden" name="veri_up_hash" value=""/>
	
	<!-- 본인확인 input 비활성화 -->
	<input type="hidden" name="cert_able_yn" value=""/>
	
	<!-- web_siteid 검증 을 위한 필드 -->
	<input type="hidden" name="web_siteid_hashYN" value=""/>
	
	<!-- 가맹점 사용 필드 (인증완료시 리턴)-->
	<input type="hidden" name="param_opt_1"  value=""/> 
	<input type="hidden" name="param_opt_2"  value=""/> 
	<input type="hidden" name="param_opt_3"  value=""/> 
	<input type="hidden" name="ci"  value=""/> 
	<input type="hidden" name="di"  value=""/> 
	<!-- 주문번호 -->
	<input type="hidden" name="ordr_idxx" value="" size="40" />
	<input type="hidden" name="birth_day" value="" size="40" />
	<input type="hidden" name="phone_no" value="" size="40" />
	<div id="section">
		<img src="/img/s3.jpg" width="1000" height="1000" usemap="#join_Map" border="0" />
		<map name="join_Map" id="join_Map">
			<area shape="rect" coords="250,233,360,250"  mean="button_certNo"  onclick="javascript:goKcpStartPage();"/>
<!-- 		  <area shape="rect" coords="661,228,775,256"  mean="button_certNo"  onclick="javascript:goKcpStartPage();"/> -->
		  <area shape="rect" coords="800,904,932,952" mean="button_join"  id="join"  class="handPnt" onclick="javascript:goSave();"/>
<!-- 		  <area shape="rect" coords="3,9,239,90" href="#" />		   -->
		</map> 

		<div id="section1"><p id="">성별</p></div>
		<div id="section2"><p id="">내국인/외국인여부</p></div>
		<div id="section3"><p id="">생년월일</p></div>
		<div id="section4"><p id="">본인확인서비스</p></div>
		<div id="section5"><p id="">휴대폰인증약관동의</p></div>
		<div id="section6"><p id="p2">동의서보기></p></div>
		<div id="section7"><p id="">이름</p></div>
		<div id="section8"><p id="">이메일</p></div>
		<div id="section9"><p id="">아이디</p></div>
		<div id="section10"><p id="">패스워드</p></div>
		<div id="section11"><p id="">패스워드확인</p></div>
		<div id="section12"><p id="">자택전화번호</p></div>
		
		<div id="section13"><p id="">자택주소</p></div>
		<div id="section14"><p id="">리플트레이드주소</p></div>
  		<div id="section15"><p id="">리플트레이드ID</p></div>
  		<div id="section16"><p id="">덤포인트카드번호</p></div>
		
		<div id="section01"><input name="sex_code" type="radio" value="01"  mean=" man"  />
		</div>
		<div id="section02"><input name="sex_code" type="radio" value="02"   mean="woman" />
		</div>
	  
		<div id="section03"><input name="local_code" type="radio" value="01"  mean="local"  />
		</div>
		<div id="section04"><input name="local_code" type="radio" value="02"  mean="foreigner"  />
		</div>
	  
		<div id="section05">
<!-- 		<input name="birthYear" id="birthYear"  type="text"style="width:180px; height:20px;" /> -->
		                             <select  id ='birthYear' name="year" style="width:150px; height:20px;" >
                                    	<option value=''> -  년선택 - </option>
	                                    <c:forEach var="result" items="${year_result}" varStatus="status">
	                                    	<option value='<c:out value="${result.code}"/>' ><c:out value="${result.codeNm}"/></option>
	                                    </c:forEach>
                                    </select>
		</div>
		<div id="section06">
<!-- 		<input name="birthMonth" id="birthMonth" type="text"style="width:75px; height:20px;" /> -->
		                             <select  id ='month_select' name="month" style="width:70px; height:20px;">
                                    	<option value=''> - 월선택 - </option>
	                                    <c:forEach var="result" items="${month_result}" varStatus="status">
	                                    	<option value='<c:out value="${result.code}"/>' ><c:out value="${result.codeNm}"/></option>
	                                    </c:forEach>
                                    </select>
		</div>
		<div id="section07">
<!-- 		<input name="birthDay"  id="birthDay" type="text"style="width:75px; height:20px;" /> -->
									<select  id ='day_select' name="day" style="width:70px; height:20px;">
                                    	<option value=''> - 일선택 - </option>
	                                    <c:forEach var="result" items="${day_result}" varStatus="status">
	                                    	<option value='<c:out value="${result.code}"/>' ><c:out value="${result.codeNm}"/></option>
	                                    </c:forEach>
                                    </select>
		</div>
	  
<!-- 		<div id="section08"> -->
<!-- 		    <select name="commId" id="commId" style="width:60px; height:20px;"> -->
<!-- 		    <option>SKT</option> -->
<!-- 		    <option>KT</option> -->
<!-- 		    <option>LGT</option> -->
<!-- 		    </select> -->
<!-- 		</div> -->
<!-- 		<div id="section09"> -->
<!-- 		    <select name="mbtlnumHead" id="mbtlnumHead" style="width:60px; height:20px;"> -->
<!-- 		    <option>010</option> -->
<!-- 		    <option>011</option> -->
<!-- 		    <option>016</option> -->
<!-- 		    <option>017</option> -->
<!-- 		    <option>018</option> -->
<!-- 		    <option>019</option> -->
<!-- 		  </select> -->
<!-- 		</div> -->
<!-- 		<div id="section010"><input name="mbtlnumMiddle"  id="mbtlnumMiddle" type="text" style="width:100px; height:20px;"" /> -->
<!-- 		</div> -->
<!-- 		<div id="section011"><input name="mbtlnumMTail"  id="mbtlnumTail" type="text" style="width:100px; height:20px;" /> -->
<!-- 		</div> -->
	  
		<div id="section012"><input name="checkAgree" id="checkAgree"  type="checkbox" value=""> </div>
	  
		<div id="section013"><input name="user_name" id="user_name" readOnly="true" style="width:160px; height:20px;" />
		</div>
	  
		<div id="section014">
		<input name="emailHead" id="emailHead" type="text" style="width:160px; height:20px;" />
		</div>
		<div id="section015">
		<input name="emailTail" id="emailTail" type="text" style="width:160px; height:20px;"/>
		</div>
	  
		<div id="section016" >
		<input id="mberId" name="mberId" type="text" style="width:180px; height:20px;" />
			<input type="button" id="chkDupleID" value="ID 중복확인">
			<div id= "resultChkID" style="color: red; font-weight: bold; font-size:14 "></div>
		</div>
		<input type="hidden" id="isDoneIDchk" name="isDoneIDchk"  value='N'>
	  	
	  	
	  
		<div id="section017">
		<input id="password"  name="password" type="password" style="width:180px; height:20px;" />
		 </div>
	  
		<div id="section018">
		<input id="passwordChk" name="passwordChk" type="password" style="width:180px; height:20px;" />
		</div>
	  
	 	<div id="section019">
			<form:select path="areaNo"  style="width:60px; height:20px;">
				<form:option value="02"  label="02"/>
				<form:option value="031" label="031"/>
				<form:option value="032" label="032"/>
				<form:option value="033" label="033"/>
				<form:option value="041" label="041"/>
				<form:option value="042" label="042"/>
				<form:option value="043" label="043"/>
				<form:option value="051" label="051"/>
				<form:option value="052" label="052"/>
				<form:option value="053" label="053"/>
				<form:option value="054" label="054"/>
				<form:option value="055" label="055"/>
				<form:option value="061" label="061"/>
				<form:option value="062" label="062"/>
				<form:option value="063" label="063"/>
				<form:option value="064" label="064"/>
			</form:select>    
		</div>
		<div id="section020"><input name="middleTelno" type="text"   style="width:90px; height:20px;" />	- <input name="endTelno" type="text"  style="width:90px; height:20px;" />
		</div>
	 
		<div id="section021"><input name="adres"   id="adres"  type="text" style="width:450px; height:20px;" /></div>
<!-- 		<div id="section022"><input name="" type="text" style="width:450px; height:20px;" /></div> -->
<!-- 		리플트레이드주소 -->
		<div id="section17"><input name="rippleTradeEmail" id="rippleTradeEmail"  type="text"style="width:200px; height:20px;" /></div>
<!-- 		리플트레이드ID -->			
		<div id="section18"><input name="rippleTradeId" id="rippleTradeId"  type="text"style="width:200px; height:20px;" /></div>
<!-- 		덤포인트카드번호 -->
		<div id="section19"><input name="dumPointCardNo"  id="dumPointCardNo"  type="text"style="width:200px; height:20px;" /></div>


	</div>
	
	<iframe id="iframe_auth"  name="iframe_auth" width="0"  height="0" frameborder="0">
	</iframe>
</form:form>

<script type="text/javaScript" language="javascript">
	$(function(){
		
		$("#chkDupleID").click(function(){
				chkDupleID();
			});
		
		$("#mberId").change(function(){
			$("#isDoneIDchk").val('N');
			$('#resultChkID').html('');
		});
		
		$( "#birthYear,#birthMonth, #birthDay" ) .change(function () {
			$("#ihidnum").val(  $( "#birthYear option:selected" ).val() + $( "#birthMonth option:selected" ).val() + $( "#birthDay option:selected" ).val() );
		});
		
		
		$( "#mbtlnumHead, #mbtlnumMiddle,  #mbtlnumTail" ) .change(function () {
			$("#moblphonNo").val(  $( "#mbtlnumHead" ).val() +'-'+ $( "#mbtlnumMiddle" ).val() +'-'+ $( "#mbtlnumTail" ).val() );
		});
		
	});

  	function chkDupleID(){      	
        if($("#mberId").val() == ''){
        	alert('id를 입력하시기 바랍니다');
        	return false;
        }
    	$("#resultChkID").html('');  
    	$("#resultChkID").css("display","block");
    	var $body = $('#resultChkID');
		
    	var formData = $("form").serialize ();
        $.ajax({
            url: "${contextPath}/join/chkDuplicationGnrId.do",
            type: "post",
            dataType:"json",
			data: "mberId="+ $("#mberId").val(),   //             data: { "name" : $("#name").val(),  "email" : $("#email").val(), "mbTlNum" : $("#mbTlNum").val() },
            success: function (data, status) {

            	if(data.IsSucceed){
            		//중복 없음
            		html = data.Message;     
            		$body.append(html); 
            		$("#isDoneIDchk").val('Y');
            	}else {
            		//중복 있음
            		html = data.Message;      
            		$body.append(html); 
            		$("#isDoneIDchk").val('N');
            	}          	

            },
            error: function (request, status, error) {
            	alert('에러발생');
            	
            }
        });
    }	
  	
  	// 휴대폰 인증을 받은  고유di 키로 중복 가입여부 확인.
  	function fn_getDiByUserId(diVal){
  		var result;
  		$.ajax({
            url: "${contextPath}/join/chkDuplicationDi.do",
            type: "post",
            dataType:"json",
			data: "di="+ diVal,   //             data: { "name" : $("#name").val(),  "email" : $("#email").val(), "mbTlNum" : $("#mbTlNum").val() },
			async: false,
            success: function (data, status) {

            	if(data.IsSucceed){
            		result = "go";
            	}else {
            		//중복 있음
            		html = data.Message;      
            		alert(html + "\n"
            				+ "로그인 페이지로 이동합니다. 해당 아이디로 로그인 하기 바랍니다");
            		location.href = "${contextPath}/login/loginUsr.do";
            	}          	

            },
            error: function (request, status, error) {
            	alert('에러발생');
            	
            }
  		});
  		return result;
  	}
  	
	function goSave(){
		var diVal = $("[name=di]").val();
		var rtn ;
		if(diVal.length > 0) {
			rtn = fn_getDiByUserId(encodeURIComponent(diVal) );
			
		} else {
			alert("먼저 휴대폰 인증을 받으세요.");			
		}
		if(!rtn) {
			
			return;
		}
		var  result = isOkAllproperty() ;
		
		if(result == 'OK'){
			$("form").attr({action:"${contextPath}/join/gnrMberInsertMain.do", target:""});
			$("form").submit();
		}else{
			alert(result);
		}
	}
	
	function isOkAllproperty(){
		var result = '';
		if(!chkDupleIDFalg())
			return '아이디 중복 확인 바랍니다.'; 
		if(!chkPassword())
			return '비밀번호 확인 바랍니다.'; 
		
		return 'OK';
	}
	
 	function chkDupleIDFalg(){  
 		if($("#isDoneIDchk").val() != 'Y')
 			return false;		
		else
 			return true;
 	}
 	
 	function chkPassword(){
 		if( $("#password").val() == null  ||  $("#password").val() == ''  ||  $("#password").val()  != $("#passwordChk").val()) {
 				return false;	
 		}else{
 			return true;
 		}
 	}
 	
 	function goKcpStartPage(){

 		$("form").attr({"action": "${contextPath}/join/kcpCertStart.do" , "target":"iframe_auth" });
 		$("form").submit();

 		return;
 	}
	
 	// 결제창 종료후 인증데이터 리턴 받아서 setting input tag value 
    function fn_mappingAuthData(map){

		var keys = map.keys();
		var rtn = "데이타 들어오기 시작합니다.";
		for(var i = 0 ; i < keys.length ; i++){   
			//rtn += "" + keys[i] + " == " +  map.get(keys[i]);
			
			var $inputObj = $("[name="+keys[i]+"]");
			if($inputObj.length > 0) {
				$inputObj.val(map.get(keys[i]));
			}
		}
		//리턴받은 데이터가 input에 들어갔는지 확인.
// 		fn_showInputdata();
    }
 	 
 	function fn_showInputdata(){
 		$("[name=diVal]").val($("[name=di]").val());
 		return;
 		
 		var showVal = "";
 		$("input:hidden").each(function(index){
 			showVal += $(this).attr("name") +"  ==  " +$(this).val();
 		});
 		
 		alert(showVal);
 	}

	</script>

        