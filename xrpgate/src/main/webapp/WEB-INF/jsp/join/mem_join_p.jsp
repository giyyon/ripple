<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/taglib.jsp" %>

<div class="con_title">
  <li>
    <img src="/images/sub/mem_join_title.png" />
  </li>
</div> 
<div class="content">
	<form:form commandName="mberManageVO"  id="form">
    <div class="content_in">
        <div class="con_info">
        	<div class="join_turn">
            	<img src="/images/sub/mem_join03.png" />            
            </div>
            <div class="join_con">
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <Td class="join_important">★</Td>
                        <td class="join_table_title">리플지갑주소</td>
                        <td class="join_table_info">
                            <li><input type="text" /></li>
                            <li><a href="#"><img src="/images/btn/rippleadd_chk.png" /></a></li>
                            <li>리플 주소를 입력해 주세요. (ex > rPxU6acYni7FcXzPCMeaPSwKcuS1GTtNVN )</li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important">★</Td>
                        <td class="join_table_title">회원등급</td>
                        <td class="join_table_info">
                            <li></li>
                            <li class="table_gray">| Silver,Bronze :  본인인증이 확인되지 않은 고객  /  Gold : 본인인증이 확인된 고객</li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important">★</Td>
                        <td class="join_table_title">태그</td>
                        <td class="join_table_info">
                            <li></li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important">★</Td>
                        <td class="join_table_title">아이디</td>
                        <td class="join_table_info">
                            <li>
								<input type="text" id="mberId" name="mberId"/>
							</li>
							<li>
								<input type="button" id="chkDupleID" value="ID 중복확인">
								<div id= "resultChkID" style="color: red; font-weight: bold; font-size:14 "></div>
								<input type="hidden" id="isDoneIDchk" name="isDoneIDchk"  value='N'>
							</li>
                            <li>거래를 위한 거래소 아이디를 생성합니다. 리플트레이드 아이디와 별도의 아이디 입니다.</li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important">★</Td>
                        <td class="join_table_title">비밀번호</td>
                        <td class="join_table_info">
                            <li>
								<input type="password" id="password"  name="password"/>
							</li>
                            <li>비밀번호 입력시 8자 이상, 대문자 1자 이상은 필수 입력 사항입니다.</li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important">★</Td>
                        <td class="join_table_title">비밀번호 확인</td>
                        <td class="join_table_info">
                            <li>
								<input type="password" id="passwordChk" name="passwordChk"/>
							</li>
                            <li>설정한 비밀번호를 다시한번 재입력 해주세요.</li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important">★</Td>
                        <td class="join_table_title">이메일</td>
                        <td class="join_table_info">
                            <li>
								<input type="text" name="emailHead" id="emailHead"/> @ 
								<input type="text" name="emailTail" id="emailTail"/>
							</li>
                            <li>
                                <select name="emailTail2">
                                    <option>naver.com</option>
                                    <option>hanmail.net</option>
                                </select>                                        
                            </li>
                            <li>거래를 위한 거래소 아이디를 생성합니다. 리플트레이드 아이디와 별도의 아이디 입니다.</li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important">★</Td>
                        <td class="join_table_title">성명</td>
                        <td class="join_table_info">
                            <li><input type="text" name="user_name" id="user_name"/></li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important">★</Td>
                        <td class="join_table_title">국가명</td>
                        <td class="join_table_info">
                            <li>
                                <select name="state">
                                    <option value="ko">대한민국</option>
                                </select>                                        
                            </li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important"></Td>
                        <td class="join_table_title">주소</td>
                        <td class="join_table_info">
                            <li><input type="text" name="zip" style="width:60px;"/></li>  
                            <li><img src="/images/btn/post_number.png"  style="margin-top:13px;"/></li> 	                        	    		<li>나머지 주소</li> 
                            <li><input type="text" name="adres"/></li>
                            <li><input type="text" name="detailAdres"/></li>                                  
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important">★</Td>
                        <td class="join_table_title">생년월일</td>
                        <td class="join_table_info">
                            <li>
                                <select  id ='birthYear' name="year" style="width:150px; height:20px;" >
                                    	<option value=''> -  년선택 - </option>
	                                    <c:forEach var="result" items="${year_result}" varStatus="status">
	                                    	<option value='<c:out value="${result.code}"/>' ><c:out value="${result.codeNm}"/></option>
	                                    </c:forEach>
                                    </select>                                        
                            </li>
                            <li>
								<select  id ='month_select' name="month" style="width:70px; height:20px;">
									<option value=''> - 월선택 - </option>
									<c:forEach var="result" items="${month_result}" varStatus="status">
										<option value='<c:out value="${result.code}"/>' ><c:out value="${result.codeNm}"/></option>
									</c:forEach>
								</select>
							</li>
							<li>
								<select  id ='day_select' name="day" style="width:70px; height:20px;">
									<option value=''> - 일선택 - </option>
									<c:forEach var="result" items="${day_result}" varStatus="status">
										<option value='<c:out value="${result.code}"/>' ><c:out value="${result.codeNm}"/></option>
									</c:forEach>
								</select>
							</li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important">★</Td>
                        <td class="join_table_title">성별</td>
                        <td class="join_table_info">
                            <li><input type="radio" value="01" name="sex_code" style="float:left;margin-top:17px;margin-right:5px;"/> 남</li>
                            <li><input type="radio" value="02" name="sex_code" style="float:left;margin-top:17px;margin-right:5px;"/> 여</li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important">★</Td>
                        <td class="join_table_title">계좌번호</td>
                        <td class="join_table_info">
                            <li>
								<form:select path="bankId"  >
									<form:option value="02"  label="국민"/>
									<form:option value="031" label="농협"/>
									<form:option value="032" label="신한"/>
									<form:option value="033" label="기업"/>
									<form:option value="041" label="하나"/>
									<form:option value="042" label="광주"/>
									<form:option value="043" label="부산"/>
									<form:option value="051" label="새마을금고"/>
								</form:select> 
                            </li>
                            <li><input type="text" name="account"/></li>
                            <li>'-'제외하고 입력해주세요 / 이름과 계좌의 명의가 같아야 합니다.</li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important"></Td>
                        <td class="join_table_title">파일첨부</td>
                        <td class="join_table_info">
                            <li><input type="file" style="margin-top:13px;"/></li>
                            <li>본인인증이 어려우신 분이나 외국인은 신분증 및 본인을 증명할 수 있는 증명서를 스캔하여 첨부하거나 FAX로 보내주세요.</li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important">★</Td>
                        <td class="join_table_title">휴대폰번호</td>
                        <td class="join_table_info">
                            <li>
                                <select name="commId" id="commId">
                                    <option value="SKT">STK</option>
                                    <option value="LGU+">LG U+</option>
                                    <option value="KTF">KT</option>
                                </select>                                        
                            </li>
                            <li>
                                <select name="mbtlnumHead" id="mbtlnumHead">
                                    <option>010</option>
                                    <option>011</option>
                                    <option>016</option>
                                    <option>017</option>
                                    <option>018</option>
                                    <option>019</option>
                                    <option>070</option>
                                    <option>080</option>
                                </select>                                        
                            </li>
                            <li>
								<input type="text" name="mbtlnumMiddle"  id="mbtlnumMiddle" style="width:80px;"/> - 
								<input type="text" name="mbtlnumMTail"  id="mbtlnumTail" style="width:80px;"/></li>
                            <li class="phone_confirm" id ="certPage" ><a href="javascript:goKcpStartPage();">인증하기</a></li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important"></Td>
                        <td class="join_table_title">전화번호</td>
                        <td class="join_table_info">
                            <li>
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
                            </li>
                            <li>
								<input type="text" name="middleTelno" readOnly="true" style="width:80px;"/> - 
								<input type="text" name="endTelno" readOnly="true" style="width:80px;"/>
							</li>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="join_btn">
            	<a href="javascript:goSave();">
                	<img src="/images/btn/mem_join_btn.png" />
                </a>
            </div>
        </div>
    </div>
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
	<iframe id="iframe_auth"  name="iframe_auth" width="0"  height="0" frameborder="0">
	</iframe>
	</form:form>
</div>

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

        