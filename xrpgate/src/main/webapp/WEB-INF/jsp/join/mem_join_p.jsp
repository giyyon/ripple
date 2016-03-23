<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/taglib.jsp" %>



<div class="con_title">
  <li>
    <img src="/images/sub/mem_join_title.png" />
  </li>
</div> 

<form:form commandName="mberManageVO"  id="form" method="POST">
<div class="content">
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
                            <li><input type="text" name="rippleTradeEmail" /></li>
                            <!-- <li><a href="#"><img src="/images/btn/rippleadd_chk.png" /></a></li> -->
                            <li>리플 주소를 입력해 주세요. (ex > rPxU6acYni7FcXzPCMeaPSwKcuS1GTtNVN )</li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important">★</Td>
                        <td class="join_table_title">회원등급</td>
                        <td class="join_table_info">
                            <li></li>
                            <li class="table_gray">| Silver, Gold :  본인인증이 확인되지 않은 고객  /  VVIP : 본인인증이 확인된 고객</li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important">★</Td>
                        <td class="join_table_title">태그</td>
                        <td class="join_table_info">
                            <li>
                            	<!-- <input type="text" name="tabVal" /> -->
                            </li>
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
                            <li>비밀번호 입력시 영문/숫자 8자 ~ 16자로 설정, 숫자 1자 이상은 필수 입력 사항입니다.</li>
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
								<input type="text" name="emailHead" id="emailHead" required /> @ 
								<input type="text" name="emailTail" id="emailTail" required />
							</li>
                            <li>
                                <select name="emailTail2">
                                	<option value="">-직접입력-</option>
                                    <option value="gmail.com">gmail.com</option>
                                    <option value="hanmail.net">hanmail.net</option>
                                    <option value="naver.com">naver.com</option>
                                    <option value="nate.com">nate.com</option>
                                    <option value="korea.com">korea.com</option>
                                    <option value="yahoo.com">yahoo.com</option>
                                    <option value="hotmail.com">hotmail.com</option>
                                    <option value="chol.com">chol.com</option>
                                    <option value="netian.com">netian.com</option>
                                    <option value="dreamwiz.com">dreamwiz.com</option>
                                    <option value="outlook.com">outlook.com</option>
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
                    <c:if test="${mberVo.userTy == 'USR02' }">
                    <tr>
                        <Td class="join_important">★</Td>
                        <td class="join_table_title">사업자등록번호</td>
                        <td class="join_table_info">
                            <li><input type="text" name="bizNo"/></li>
                        </td>
                    </tr>
                    </c:if>
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
                            <li><input type="text" name="zip" style="width:50px;"/></li>  
                            <li><img src="/images/btn/post_number.png" id="btnPostSearch" style="margin-top:13px;"/></li> 	                        	    		<li>나머지 주소</li> 
                            <li><input type="text" name="adres" style="width:240px;"/></li>
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
                            <li><input type="radio" value="01" name="sex_code" checked="true" style="float:left;margin-top:17px;margin-right:5px;"/> 남</li>
                            <li><input type="radio" value="02" name="sex_code" style="float:left;margin-top:17px;margin-right:5px;"/> 여</li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important">★</Td>
                        <td class="join_table_title">계좌번호</td>
                        <td class="join_table_info">
                            <li>
								<form:select path="bankId"  >
									<c:forEach var="result" items="${bank_result}" varStatus="status">
		                        	<form:option value="${result.code}"  label='${result.codeNm}'/>
		                        	</c:forEach>
								</form:select> 
                            </li>
                            <li><input type="text" name="account"/></li>
                            <li>'-'제외하고 입력해주세요 / 이름과 계좌의 명의가 같아야 합니다.</li>
                        </td>
                    </tr>
                    
                    <tr>
                        <Td class="join_important">★</Td>
                        <td class="join_table_title">휴대폰번호</td>
                        <td class="join_table_info">
                            <li>
                                <select name="commId" id="commId">
                                    <option value="SKT">SKT</option>
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
								<input type="text" name="mbtlnumMiddle"  maxlength="4" id="mbtlnumMiddle" style="width:80px;"/> - 
								<input type="text" name="mbtlnumMTail"  maxlength="4" id="mbtlnumTail" style="width:80px;"/></li>
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
								<input type="text" name="middleTelno" maxlength="4"  style="width:80px;"/> - 
								<input type="text" name="endTelno" maxlength="4"  style="width:80px;"/>
							</li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important"></Td>
                        <td class="join_table_title">파일첨부 주민등록증</td>
                        <td class="join_table_info">
                            <li>
                            	<form:hidden path="atchFileId" />
								<input name="file1_text" type="text" class="w400"/>
								<img name="btnFileUpload" src="${contextPath}/images/common/btn_searchfile.png" data_fileMax="5" data_category="news"  data_type="img" data_fieldId="atchFileId" alt="찾아보기"   />
							</li>
                            <li>본인인증이 어려우신 분이나 외국인은 신분증 및 본인을 증명할 수 있는 증명서를 스캔하여 첨부하거나 FAX로 보내주세요.</li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important"></Td>
                        <td class="join_table_title">파일첨부 증명사진</td>
                        <td class="join_table_info">
                            <li>
                            	<form:hidden path="atchFileId1" />
								<input name="file1_text" type="text" class="w400"/>
								<img name="btnFileUpload" src="${contextPath}/images/common/btn_searchfile.png" data_fileMax="5" data_category="news"  data_type="img" data_fieldId="atchFileId1" alt="찾아보기"   />
							</li>
                            <li>본인인증이 어려우신 분이나 외국인은 신분증 및 본인을 증명할 수 있는 증명서를 스캔하여 첨부하거나 FAX로 보내주세요.</li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important"></Td>
                        <td class="join_table_title">파일첨부 여권사본</td>
                        <td class="join_table_info">
                            <li>
                            	<form:hidden path="atchFileId2" />
								<input name="file1_text" type="text" class="w400"/>
								<img name="btnFileUpload" src="${contextPath}/images/common/btn_searchfile.png" data_fileMax="5" data_category="news"  data_type="img" data_fieldId="atchFileId2" alt="찾아보기"   />
							</li>
                            <li>본인인증이 어려우신 분이나 외국인은 신분증 및 본인을 증명할 수 있는 증명서를 스캔하여 첨부하거나 FAX로 보내주세요.</li>
                        </td>
                    </tr>
                    <tr>
                        <Td class="join_important"></Td>
                        <td class="join_table_title">파일첨부 통장사본</td>
                        <td class="join_table_info">
                            <li>
                            	<form:hidden path="atchFileId3" />
								<input name="file1_text" type="text" class="w400"/>
								<img name="btnFileUpload" src="${contextPath}/images/common/btn_searchfile.png" data_fileMax="5" data_category="news"  data_type="img" data_fieldId="atchFileId3" alt="찾아보기"   />
							</li>
                            <li>본인인증이 어려우신 분이나 외국인은 신분증 및 본인을 증명할 수 있는 증명서를 스캔하여 첨부하거나 FAX로 보내주세요.</li>
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
	 <input type="hidden" id="mberEmailAdres"  name="mberEmailAdres"  > <!--이메일주소 -->
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
	<!-- 사용자 유형 -->
	<form:hidden path="userTy"/>
	
	
</div>
</form:form>

<iframe id="iframe_auth"  name="iframe_auth" width="0"  height="100" frameborder="0">
</iframe>
	
<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script type="text/javaScript" language="javascript">
	$(function(){
		$("#btnPostSearch").click(function(e){
			e.preventDefault;
			execDaumPostcode();
		});
		
		$("#chkDupleID").click(function(){
				chkDupleID();
			});
		
		$("#mberId").change(function(){
			$("#isDoneIDchk").val('N');
			$('#resultChkID').html('');
		});
		
		//생년월일
		$( "#birthYear,#month_select, #day_select" ) .change(function () {
			$("#ihidnum").val(  $( "#birthYear option:selected" ).val() + $( "#month_select option:selected" ).val() + $( "#day_select option:selected" ).val() );
		});
		
		// 핸드폰 번호 
		$( "#mbtlnumHead, #mbtlnumMiddle,  #mbtlnumTail" ) .change(function () {
			$("#moblphonNo").val(  $( "#mbtlnumHead" ).val() + $( "#mbtlnumMiddle" ).val() + $( "#mbtlnumTail" ).val() );
		});
		
		$( "[name=emailTail2]").change(function(){
			
			var $emailAddr =  $("input[name=emailTail]");
			
			if($(this).val() == "" ||  $(this).val() == null) {
				$emailAddr.prop("readOnly", false);
			} else { 
				$emailAddr.prop("readOnly", true);
				$emailAddr.val($(this).val());
			}
			
			$("#mberEmailAdres").val( $("#emailHead").val() + '@' + $emailAddr.val());
			
		});
		
		$( "#emailHead ,[name=emailTail]").change(function(){
			
			var $emailAddr =  $("input[name=emailTail]");
			$("#mberEmailAdres").val( $("#emailHead").val() + '@' + $emailAddr.val());
		});
		
		
		$("img[name=btnFileUpload]").on("click", function(e) {
			var offset = $(this).offset();
    		var fieldId = $(this).attr('data_fieldId');
    		var thisType = $(this).attr('data_type');
    		var category = $(this).attr('data_category');
    		var fileMax = $(this).attr('data_fileMax');
    		var fileMode = "U";
    		
    		var $imgId = $(this).parent().find(':hidden');
    		
    		e.preventDefault();
    				
    		var url = "${contextPath}/files/uploadPage.do?";
			var atchFileId = $(this).parent().find(':hidden').val();
			var param = {
					atchFileId : atchFileId
					, contentType : thisType
					, category : category
					, size : fileMax
					, fieldId : fieldId
					, fileMode : fileMode
			}
			
			window.open(url+ $.param(param), 'popUpWindow','height=300, width=650, left=300, top=100, resizable=no, scrollbars=yes, toolbar=yes, menubar=no, location=no, directories=no, status=yes');
    		
		});

		$('[name=btnFileDownload]').click(function(e) {
			e.preventDefault();
			var category = $(this).attr('data_category');
			var $imgId = $(this).parent().find(':hidden');
			COM.openFileListPopup(category, $imgId.val());
		});
	
		$('[name=btnImgDelete]').click(function(e){
			$(this).parent().find(':hidden').val('');
			$(this).parent('').find('[name=file1_text]').val('');
		});
		
		$('[name=btnFileDelete]').click(function(e){
			var $imgId = $(this).parent().find(':hidden');
			var $fileNmme = $(this).parent('').find('[name=file1_text]');
			var $imgDiv = $(this).closest('dl').find('dt');
			
			$imgId.val('');
			$fileNmme.val('')
			var basicImg = '<c:url value="/webAttach/thumnails/" />'
			$imgDiv.css
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
		
		/* var diVal = $("[name=di]").val();
		var rtn ;
		if(diVal.length > 0) {
			rtn = fn_getDiByUserId(encodeURIComponent(diVal) );
			
		} else {
			alert("먼저 휴대폰 인증을 받으세요.");			
		}
		if(!rtn) {
			
			return;
		} */
		
		var  result = isOkAllproperty() ;
		if(result){
			
			$("#form").attr({action:"${contextPath}/join/gnrMberInsertMain.do"});
			$("#form").attr({target:"_self"});
			$("#form").submit();
		}
	}
	
	function isOkAllproperty(){
		var result = '';
		var rippleWallet = $("[name=rippleTradeEmail]").val();
		var account = $("[name=account]").val();
		var userNmae = $("[name=user_name]").val();
		
		if(!chkDupleIDFalg()){
			alert('아이디 중복 확인 바랍니다.');
			return false; 
		}
			
		if(!isValidFormPassword($("#password").val(), $("#passwordChk").val())){
			return false;
		}
		
		if(!isValidEmail($("#mberEmailAdres").val())){
			return false;
		}
		
		if(rippleWallet == '' || rippleWallet== null){
			alert('리플 지갑 주소를 입력하여 주십시오.');
			return false;
		}
		
		if(account == '' || account== null){
			alert('계좌 번호를 입력하여 주십시오.');
			return false;
		}
		return true;
	}
	
	
	
	
	
 	function chkDupleIDFalg(){  
 		if($("#isDoneIDchk").val() != 'Y')
 			return false;		
		else
 			return true;
 	}
 	
 	function goKcpStartPage(){
		$("#user_name").val('');
 		$("#form").attr({"action": "${contextPath}/join/kcpCertStart.do" , "target":"iframe_auth" });
 		$("#form").submit();

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
			// 생년월일
			if(keys[i] == "birth_day"){
				var year = map.get(keys[i]).substring(0,4);
				var month = map.get(keys[i]).substring(4,6);
				var day = map.get(keys[i]).substring(6,8);
				
				$("[name=year]").val(year);
				$("[name=month]").val(month);
				$("[name=day]").val(day);
			}
			//핸드폰
			if(keys[i] == "phone_no"){
				var firstNo = map.get(keys[i]).substring(0,3);
				var middleNo = map.get(keys[i]).substring(3,7);
				var lastNo = map.get(keys[i]).substring(7,11);
				
				$("[name=mbtlnumHead]").val(firstNo);
				$("[name=mbtlnumMiddle]").val(middleNo);
				$("[name=mbtlnumMTail]").val(lastNo);
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
 	
 	function replaceModalwindow(offset, currPlace) {
		$('.ui-dialog').css('top', offset.top +'px');
		$( 'html, body' ).animate( { scrollTop : currPlace }, 0);
	}

	function fn_dataParamSetting(category, fileMax, type, filesIds, containerId){
		var fileExtn = '';
		
		if(type == "img"){
			fileExtn = 'jpg|jpeg|png|bmp|gif';
		} else {
			fileExtn = '';
		}
		
		var params = {
				Category : category,
				Accept : fileExtn,
				Max : Number(fileMax),
				Type : type,
				FileIds : filesIds,
				containerId : containerId
			}
		
		return params;
	}
	
   	function doSync(){

	}
   	
   	

    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $("[name=zip]").val( data.zonecode); //5자리 새우편번호 사용
                $("[name=adres]").val(fullAddr);
                //$("[name=detailAdres]").val();
                //document.getElementById('sample2_postcode').value = data.zonecode; 
                //document.getElementById('sample2_address').value = fullAddr;
                //document.getElementById('sample2_addressEnglish').value = data.addressEnglish;

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%'
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 460; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
    
    function dataApply(returnValue, fieldId) {
		
		if (returnValue != null ) {
			var $fieldId = $('#'+ fieldId+'');
			var files = returnValue;
			var fileNmme = "";
			var $fileNmme = $fieldId.parent().find('[name=file1_text]');
			
			if(files.length == 0){
				$fileNmme.val('');
				return;
			}
			$fieldId.val(files[0].atchFileId);
			for(var i = 0; i < files.length; i++){
				if(fileNmme == ""){
					fileNmme += files[i].realName;
				} else {
					fileNmme += ","+files[i].realName;
				}
			}
			$fileNmme.val(fileNmme);
		} else {
			$imgId.val('');
			$fileNmme.val('');
		}
	}
    
    function convertHeightToIntFromPercent(percent) {
        if (!Number(percent) && percent.substring(percent.length - 1) == '%') {
            return $('body').height() * 0.01 * parseInt(percent.substring(0, percent.length - 1));
        } else {
            return percent;
        }
    }
	</script>

        