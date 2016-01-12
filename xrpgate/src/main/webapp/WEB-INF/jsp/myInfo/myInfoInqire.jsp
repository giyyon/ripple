<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<div class="con_title">
  <li>
    <img src="/images/sub/meminfo_title.png" />
  </li>
</div> 

<form:form commandName="mberManageVO"  id="form" method="POST">
<div class="content">
    <div class="content_in">
        <div class="con_info">
			<div class="tab_btn">
            	<ul class="tabs">
                    <li><a href="#tab1">회원정보 변경</a></li>
                    <li><a href="#tab2">비밀번호 변경</a></li>
                </ul>
                <div class="tab_container">
                    <div id="tab1" class="tab_content">
                        <h2>필수항목은 ★로 표시되어 있습니다.</h2>
                       
                        <div class="tab1_con">
                        	<table cellpadding="0" cellspacing="0" border="0">
                            	<tr>
                                	<Td class="tab_important">★</Td>
                                	<td class="tab1_table_title">리플지갑주소</td>
                                    <td class="tab1_table_info">
                                    	<li><input type="text" name="rippleTradeEmail" value="${mberManageVO.rippleTradeEmail}"/></li>
                                        <li><a href="#"><img src="/images/btn/rippleadd_chk.png" /></a></li>
                                        <li>리플 주소를 입력해 주세요. (ex > rPxU6acYni7FcXzPCMeaPSwKcuS1GTtNVN )</li>
                                    </td>
                                </tr>
                                <tr>
                                	<Td class="tab_important">★</Td>
                                	<td class="tab1_table_title">회원등급</td>
                                    <td class="tab1_table_info">
                                    	<li>Gold
                                    		<c:out value="${mberManageVO.rippleTradeEmail}"/>
                                    	</li>
                                        <li class="table_gray">| Silver,Bronze :  본인인증이 확인되지 않은 고객  /  Gold : 본인인증이 확인된 고객</li>
                                    </td>
                                </tr>
                                <tr>
                                	<Td class="tab_important">★</Td>
                                	<td class="tab1_table_title">태그</td>
                                    <td class="tab1_table_info">
                                    	<li>570</li>
                                    </td>
                                </tr>
                                <tr>
                                	<Td class="tab_important">★</Td>
                                	<td class="tab1_table_title">이메일</td>
                                    <td class="tab1_table_info">
                                    	<c:set var="mailIdx" value="${fn:indexOf(mberManageVO.mberEmailAdres, '@')}"/>
                                    	<c:set var="mailLength" value="${fn:length(mberManageVO.mberEmailAdres)}" />
                                    	<li>
                                    		<input type="text" id="emailHead"  name="emailHead" value="${fn:substring(mberManageVO.mberEmailAdres,0,mailIdx)}"/> @ 
                                    		<input type="text" id="emailTail" name="emailTail" value="${fn:substring(mberManageVO.mberEmailAdres,mailIdx+1,mailLength)}"/>
                                    	</li>
                                        <li>
                                        	<select name="emailTail2">
			                                	<option value="">-직접입력-</option>
			                                    <option value="naver.com">naver.com</option>
			                                    <option value="hanmail.net">hanmail.net</option>
			                                </select>                                        
                                        </li>
                                        <li>정확한 이메일주소를 입력해 주세요.</li>
                                    </td>
                                </tr>
                                <tr>
                                	<Td class="tab_important">★</Td>
                                	<td class="tab1_table_title">성명</td>
                                    <td class="tab1_table_info">
                                    	<li><input type="text" value="${mberManageVO.mberNm}"/></li>
                                    </td>
                                </tr>
                                <tr>
                                	<Td class="tab_important">★</Td>
                                	<td class="tab1_table_title">국가명</td>
                                    <td class="tab1_table_info">
                                    	<li>
                                        	<form:select path="state" style="width:150px; height:20px;">
												<form:option value="ko"  label="대한민국"/>
											</form:select>                                         
                                        </li>
                                    </td>
                                </tr>
                                <tr>
                                	<Td class="tab_important"></Td>
                                	<td class="tab1_table_title">주소</td>
                                    <td class="tab1_table_info">
                                    	<li><input type="text" name="zip" value="${mberManageVO.zip}" style="width:60px;"/></li>
                                    	<li><img src="/images/btn/post_number.png"  style="margin-top:13px;"/></li>
                                        <li>나머지 주소</li> 
                                        <li><input type="text" name="adres" value="${mberManageVO.adres}"/></li>
                                        <li><input type="text" name="detailAdres" value="${mberManageVO.detailAdres}"/></li>
                                    </td>
                                </tr>
                                <tr>
                                	<Td class="tab_important">★</Td>
                                	<td class="tab1_table_title">생년월일</td>
                                    <td class="tab1_table_info">
                                    	<select  id ='birthYear' name="year" value="${fn:substring(mberManageVO.ihidnum,0,3)}" style="width:150px; height:20px;" >
	                                    	<option value=''> -  년선택 - </option>
		                                    <c:forEach var="result" items="${year_result}" varStatus="status">
		                                    	<option value='<c:out value="${result.code}"/>' ><c:out value="${result.codeNm}"/></option>
		                                    </c:forEach>
	                                    </select>
	                                    <select  id ='month_select' name="month" value="${fn:substring(mberManageVO.ihidnum,4,5)}" style="width:70px; height:20px;">
											<option value=''> - 월선택 - </option>
											<c:forEach var="result" items="${month_result}" varStatus="status">
												<option value='<c:out value="${result.code}"/>' ><c:out value="${result.codeNm}"/></option>
											</c:forEach>
										</select>  
										<select  id ='day_select' name="day" value="${fn:substring(mberManageVO.ihidnum,6,7)}" style="width:70px; height:20px;">
											<option value=''> - 일선택 - </option>
											<c:forEach var="result" items="${day_result}" varStatus="status">
												<option value='<c:out value="${result.code}"/>' ><c:out value="${result.codeNm}"/></option>
											</c:forEach>
										</select>
                                    </td>
                                </tr>
                                <tr>
                                	<Td class="tab_important">★</Td>
                                	<td class="tab1_table_title">성별</td>
                                    <td class="tab1_table_info">
                                    	<li><input type="radio" value="01" name="sexdstnCode" style="float:left;margin-top:17px;margin-right:5px;"/> 남</li>
                                        <li><input type="radio" value="02" name="sexdstnCode" style="float:left;margin-top:17px;margin-right:5px;"/> 여</li>
                                    </td>
                                </tr>
                                <tr>
                                	<Td class="tab_important">★</Td>
                                	<td class="tab1_table_title">계좌번호</td>
                                    <td class="tab1_table_info">
                                    	<li>
                                        	<form:select path="bankId" value="${mberManageVO.bankId}" >
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
                                        <li><input type="text" name="account" value="${mberManageVO.account}"/></li>
                                        <li>'-'제외하고 입력해주세요 / 이름과 계좌의 명의가 같아야 합니다.</li>
                                    </td>
                                </tr>
                                <tr>
                                	<Td class="tab_important"></Td>
                                	<td class="tab1_table_title">파일첨부</td>
                                    <td class="tab1_table_info">
                                    	<li>
			                            	<form:hidden path="atchFileId" value="${mberManageVO.atchFileId}"/>
											<input name="file1_text" type="text" class="w400"/>
											<img name="btnFileUpload" src="${contextPath}/img/btn_find.png" data_fileMax="1" data_category="news"  data_type="file"  alt="찾아보기"   />
										</li>
                                        <li>본인인증이 어려우신 분이나 외국인은 신분증 및 본인을 증명할 수 있는 증명서를 스캔하여 첨부하거나 FAX로 보내주세요.</li>
                                    </td>
                                </tr>
                                <tr>
                                	<Td class="tab_important">★</Td>
                                	<td class="tab1_table_title">휴대폰번호</td>
                                    <td class="tab1_table_info">
                                    	<li>
                                        	<form:select path="commId" value="${mberManageVO.commId}">
                                        		<form:option value="SKT" label="SKT"/>
                                        		<form:option value="LGU+" label="LG U+"/>
                                        		<form:option value="KTF" label="KT"/>
			                                </form:select>                                        
                                        </li>
                                    	<li>
                                    		<select id="mbtlnumHead" value="${fn:substring(mberManageVO.moblphonNo,0,3)}">
                                        		<option value="010" label="010"/>
                                        		<option value="011" label="011"/>
                                        		<option value="016" label="016"/>
                                        		<option value="017" label="017"/>
                                        		<option value="018" label="018"/>
                                        		<option value="019" label="019"/>
			                                </select>
                                        </li>
                                        <li>
                                        	<c:set var="hpMIdx" value="${fn:indexOf(mberManageVO.moblphonNo, '-')}"/>
                                        	<c:set var="hpStr" value="${fn:substring(mberManageVO.moblphonNo,hpMIdx+1,13)}"/>
                                    		<c:set var="hpLIdx" value="${fn:indexOf(hpStr, '-')}" />
                                        	<input type="text" id="mbtlnumMiddle" name="mbtlnumMiddle" value="${fn:substring(mberManageVO.moblphonNo,hpMIdx+1,8)}" style="width:80px;"/> - 
                                        	<input type="text" id="mbtlnumMTail" name="mbtlnumMTail" value="${fn:substring(mberManageVO.moblphonNo,hpMIdx+hpLIdx+2,13)}" style="width:80px;"/>
                                        </li>
                                    </td>
                                </tr>
                                <tr>
                                	<Td class="tab_important"></Td>
                                	<td class="tab1_table_title">전화번호</td>
                                    <td class="tab1_table_info">
                                    	<li>
                                        	<form:select path="areaNo" value="${mberManageVO.areaNo}" style="width:60px; height:20px;">
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
                                        	<input type="text" name="middleTelno" value="${mberManageVO.middleTelno}" maxlength="4"style="width:80px;"/> - 
                                        	<input type="text" name="endTelno" value="${mberManageVO.endTelno}" maxlength="4" style="width:80px;"/>
                                        </li>
                                    </td>
                                </tr>
                            </table>
                            <div class="info_text">
                            	<li> - 해당 아이디로 등록된 컨텐츠 내용은 연관된 관련데이터(답변/댓글) 등에 의해 삭제되지 않습니다.</li>
                                <li> - 회원탈퇴 완료 이후 해당 아이디에 대한 개인정보는 보관되지 않으며, 복구가 불가합니다.</li>
                                <li> - 본인에 의한 실수로 신청되거나, 타인의 도용을 방지하고자 관리자가 승인 후 바로 삭제하며, 접수 후 15일 이전까지 취소가 가능합니다.</li>
                                <li> - 탈퇴접수가 완료된 후 홈페이지 관리자에게 연락주시면 즉시 회원탈퇴가 가능합니다.</li>
                            
                            </div>
                        </div>
                        <div class="info_btn">
	                    	<li><a href="#"><img name="btnUpdate" src="/images/btn/info_change.png" /></a></li>
                            <li><a href="#"><img name="btnCancle" src="/images/btn/info_cancle.png" /></a></li>
	                    </div>
                    </div>
                    <div id="tab2" class="tab_content">
                    	<h2>보안을 위해 아래 안내문을 읽어보신 후 설정해 주십시오.</h2>                       
                        <div class="tab2_con">
                        	<div class="pw_info">
	                            <li>★ 영문/숫자 4자 ~ 16자로 설정 가능합니다.</li>
                                <li>★ 전화번호, 생년월일 등 개인정보와 관련된 숫자로 설정하면 보안에 취약합니다.</li>
                                <li>★ 연속된 숫자 또는 타인이 알아내기 쉬운 비밀번호로 설정하면 보안에 취약합니다.</li>
                            </div>
                            <div class="now_pw">
                            	<li>현재 비밀번호</li>
                                <li><input type="password" name="oldPassword"/></li>
                            </div>
                            <div class="tab_line"></div>
                            <div class="chn_pw_box">
                                <div class="chn_pw">
                                    <li class="pw_title">비밀번호 변경</li>
                                    <li><input type="password" name="password"/></li>
                                </div>
                                <div class="chn_pw">
                                    <li class="pw_title">비밀번호 재확인</li>
                                    <li>
                                    	<input type="password" id="passwordChk" name="passwordChk"/>
                                    	&nbsp;
                                    	&nbsp;
                                    	<div name="passValid" style="display: none;color: red;position: absolute;" >비밀번호가 일치하지 않습니다.</div>
                                    </li>
                                </div>
                            </div>
                            <div class="info_text">
                            	<li> - 해당 아이디로 등록된 컨텐츠 내용은 연관된 관련데이터(답변/댓글) 등에 의해 삭제되지 않습니다.</li>
                                <li> - 회원탈퇴 완료 이후 해당 아이디에 대한 개인정보는 보관되지 않으며, 복구가 불가합니다.</li>
                                <li> - 본인에 의한 실수로 신청되거나, 타인의 도용을 방지하고자 관리자가 승인 후 바로 삭제하며, 접수 후 15일 이전까지 취소가 가능합니다.</li>
                                <li> - 탈퇴접수가 완료된 후 홈페이지 관리자에게 연락주시면 즉시 회원탈퇴가 가능합니다.</li>
                            
                            </div>
                            <div class="pw_btn">
                                <li><a href="#"><img name="btnChangePass" src="/images/btn/info_change.png" /></a></li>
                                <li><a href="#"><img src="/images/btn/info_cancle.png" /></a></li>
		                    </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>    
</div>    
	<input type="hidden" id="ihidnum" name="ihidnum" value="${mberManageVO.ihidnum}"> <!--주민번호 -->
	<input type="hidden" id="moblphonNo"  name="moblphonNo" value="${mberManageVO.moblphonNo}"  > <!--핸드폰번호 -->
	<input type="hidden" id="mberEmailAdres"  name="mberEmailAdres" value="${mberManageVO.mberEmailAdres}" > <!--이메일주소 -->
</form:form>
  <script type="text/javaScript" language="javascript"> 
  
  $(function(){
	  // 생년월일 설정
	  var birth= "${mberManageVO.ihidnum}";
	  var birthYear = birth.substring(0,4);
	  var birthMonth = birth.substring(4,6);
	  var birthDay = birth.substring(6,8);
	  
	  $( "#birthYear").val(birthYear);
	  $( "#month_select").val(birthMonth);
	  $( "#day_select").val(birthDay);
	  
	  var emailTail = $("[name=emailTail]").val();
	  
	  var $email = $("[name=emailTail2] option");
	  $email.each(function(e){
		  if($(this).val() == emailTail) {
			  $("[name=emailTail2]").val(emailTail);
		  } else {
			  $("[name=emailTail2] option:eq(0)").attr("selected", "selected");
		  }
	  });
	
		// 생년월일을 하나의 변수로 전달.
		$( "#birthYear,#month_select, #day_select" ) .change(function () {
			$("#ihidnum").val(  $( "#birthYear option:selected" ).val() + $( "#month_select option:selected" ).val() + $( "#day_select option:selected" ).val() );
		});
		
		// 핸드폰 번호 
		$( "#mbtlnumHead, #mbtlnumMiddle,  #mbtlnumMTail" ) .change(function () {
			$("#moblphonNo").val(  $( "#mbtlnumHead" ).val() +'-'+ $( "#mbtlnumMiddle" ).val() +'-'+ $( "#mbtlnumMTail" ).val() );
			alert($("#moblphonNo").val());
		});
		
		$( "#emailHead, [name='emailTail'], [name='emailTail2']").change(function(){
			
			var $emailAddr =  $("input[name='emailTail']");
			
			if($(this).val() == "" ||  $(this).val() == null) {
				$emailAddr.prop("readOnly", false);
			} else { 
				$emailAddr.prop("readOnly", true);
				$emailAddr.val($(this).val());
			}
			
			$("#mberEmailAdres").val( $("#emailHead").val() + '@' + $emailAddr.val());
			
		});
		
	  $(".topnav").hover(function() {                    //마우스를 topnav에 오버시
		   $(this).parent().find(".subnav").slideDown('normal').show();                   //subnav가 내려옴.
		   $(this).parent().hover(function() {  
		   }, function(){  
		    $(this).parent().find(".subnav").slideUp('fast');                 //subnav에서 마우스 벗어났을 시 원위치시킴  
		   });  
		  });  
	  
	//Default Action
		$(".tab_content").hide(); //Hide all content
		$("ul.tabs li:first").addClass("active").show(); //Activate first tab
		$(".tab_content:first").show(); //Show first tab content
		
		//On Click Event
		$("ul.tabs li").click(function() {
			$("ul.tabs li").removeClass("active"); //Remove any "active" class
			$(this).addClass("active"); //Add "active" class to selected tab
			$(".tab_content").hide(); //Hide all tab content
			var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content
			$(activeTab).fadeIn(); //Fade in the active content
			return false;
		});
		
		//파일 업로드 처리
		$("img[name=btnFileUpload]").on("click", function(e) {
			
			var offset = $(this).offset();
			var currPlace = $('body').scrollTop();
			var thisType = $(this).attr('data_type');
			var category = $(this).attr('data_category');
			var fileMax = $(this).attr('data_fileMax');
			
			var $imgId = $(this).parent().find(':hidden');
			var $fileNmme = $(this).parent('').find('[name=file1_text]');
			var $imgDiv = $(this).closest('dl').find('dt');
			
			var params = fn_dataParamSetting(category, fileMax, thisType, $imgId.val());
			e.preventDefault();
					
			var options = {
				url : '<c:url value="/files/uploadPage.do" />',
				width : 650,
				height : 350,
				closeCallback : closeCallback,
				title : '[파일 올리기]',
				data : params,
				buttonType : 0
			};
			var $dialog = BIT.modalDialog(options);
			
			function closeCallback(returnValue) {
				if (returnValue != null && returnValue.length > 0) {
					var files = returnValue;
					var fileIds = '';
					var fileNames = '';
					//단일 이미지 처리시에만 적용 올려진 썸네일 이미지를 리턴받아 화면상에 이미지 영역에 뿌려줌
					var imgUrl = "";
					
					for (var i = 0; i < files.length; i++) {
						if (fileIds) {
							fileIds = files[i].atchFileId;
							fileNames += ',' + files[i].orignlFileNm;
						} else {
							fileIds = files[i].atchFileId;
							fileNames = files[i].orignlFileNm;
							imgUrl =   '<c:url value="/files/imageSrc.do?path=" />'+files[i].category  +'/thumnails&physical=' + files[i].streFileNm;    
	// 						imgUrl =  '<c:url value="/webAttach/thumnails/" />' + files[i].streFileNm;
						}
					}
					var options = {"background":"url("+imgUrl+")", 'background-repeat' : 'no-repeat', 'background-position':'center'};
					$imgId.val(fileIds);
					$fileNmme.val(fileNames);
					if(thisType == 'img'){
						$imgDiv.css(options);
					}
					
				} else {
					$imgId.val('');
					$fileNmme.val('');
					if(thisType == 'img'){
						$imgDiv.css('background', 'url(/img/noimg.png)');
					}
					
				}
			}
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
		
		$("img[name=btnUpdate]").on("click", function(e) {
			e.preventDefault();
			$("#form").attr({action:"${contextPath}/myInfo/updateGnrMyInfo.do"});
			$("#form").submit();
		});
		
		$("#passwordChk").focusout(function(){
			var newPass = $("[name=password]").val();
			var chkPass = $("#passwordChk").val();
			if(newPass  != chkPass){
				$("[name=passValid]").show();
				return false;
			} else {
				$("[name=passValid]").hide();
			}
		});
		
		$("img[name=btnChangePass]").on("click", function(e) {
			e.preventDefault();
			
			// 비밀번호 null 여부 체크
			if(!chkPassword()) {
				
				return;
			}
			// 비밀번호 일치여부 체크
			if(!$("#passwordChk").trigger("focusout")){
				return;
			}
			
			$.ajax({
	            url: "${contextPath}/myInfo/jsonGnrPasswordChange.do",
	            type: "post",
	            dataType:"json",
				data: { "oldPassword" : $("[name=oldPassword]").val()
						,  "password" : $("[name=password]").val()
					},
	            success: function (data, status) {

	            	if(data.IsSucceed){
	            		alert(data.Message);
	            		location.href = "/";
	            	}else {
	            		//중복 있음
	            		alert(data.Message);
	            	}          	

	            },
	            error: function (request, status, error) {
	            	alert('에러발생');
	            	
	            }
	        });
		});
  });
   
		
	function chkPassword(){
 		if( $("[name=password]").val() == null  ||  $("[name=password]").val() == '' ) {
 				return false;	
 		}else{
 			return true;
 		}
 	}
	
	function replaceModalwindow(offset, currPlace) {
		$('.ui-dialog').css('top', offset.top +'px');
		$( 'html, body' ).animate( { scrollTop : currPlace }, 0);
	}

	function fn_dataParamSetting(category, fileMax, type, filesIds){
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
				FileIds : filesIds
			}
		
		return params;
	}
	
   	function doSync(){
//		 goJsonSave();
 //  		goPost('01');
	}
   	
  </script> 

