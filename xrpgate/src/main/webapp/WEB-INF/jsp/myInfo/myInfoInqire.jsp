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
                                        <!-- <li><a href="#"><img src="/images/btn/rippleadd_chk.png" /></a></li> -->
                                        <li>리플 주소를 입력해 주세요. (ex > rPxU6acYni7FcXzPCMeaPSwKcuS1GTtNVN )</li>
                                    </td>
                                </tr>
                                <tr>
                                	<Td class="tab_important">★</Td>
                                	<td class="tab1_table_title">회원등급</td>
                                    <td class="tab1_table_info">
                                    	<li>
                                    		<c:out value="${mberManageVO.memberGrade}"/>
                                    		<form:hidden path="memberGrade"/>
                                    	</li>
                                        <li class="table_gray">| Silver,Gold :  본인인증이 확인되지 않은 고객  /  VVIP : 본인인증이 확인된 고객</li>
                                    </td>
                                </tr>
                                <tr>
                                	<Td class="tab_important">★</Td>
                                	<td class="tab1_table_title">태그</td>
                                    <td class="tab1_table_info">
                                    	<li>${mberManageVO.tagVal}</li>
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
			                                    <option value="gmail.com">gmail.com</option>
			                                    <option value="hanmail.net">hanmail.net</option>
			                                    <option value="naver.com">naver.com</option>
			                                    <option value="nate.com">nate.com</option>
			                                    <option value="empal.com">empal.com</option>
			                                    <option value="korea.com">korea.com</option>
			                                    <option value="yahoo.com">yahoo.com</option>
			                                    <option value="hotmail.com">hotmail.com</option>
			                                    <option value="chol.com">chol.com</option>
			                                    <option value="netian.com">netian.com</option>
			                                    <option value="dreamwiz.com">dreamwiz.com</option>
			                                    <option value="outlook.com">outlook.com</option>
			                                </select>                                        
                                        </li>
                                        <li>정확한 이메일주소를 입력해 주세요.</li>
                                    </td>
                                </tr>
                                <tr>
                                	<Td class="tab_important">★</Td>
                                	<td class="tab1_table_title">성명</td>
                                    <td class="tab1_table_info">
                                    	<li><input type="text" name="mberNm" value="${mberManageVO.mberNm}"/></li>
                                    </td>
                                </tr>
                                <c:if test="${mberManageVO.userTy == 'USR02' }">
			                    <tr>
			                        <Td class="join_important">★</Td>
			                        <td class="join_table_title">사업자등록번호</td>
			                        <td class="join_table_info">
			                            <li><input type="text" name="bizNo" value="${mberManageVO.bizNo}"/></li>
			                        </td>
			                    </tr>
			                    </c:if>
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
                                    	<li><img src="/images/btn/post_number.png" id="btnPostSearch" style="margin-top:13px;"/></li>
                                        <li>나머지 주소</li> 
                                        <li><input type="text" name="adres" style="width:240px;" value="${mberManageVO.adres}"/></li>
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
                                    	<li><input type="radio" value="01" name="sexdstnCode"  style="float:left;margin-top:17px;margin-right:5px;"/> 남</li>
                                        <li><input type="radio" value="02" name="sexdstnCode"  style="float:left;margin-top:17px;margin-right:5px;"/> 여</li>
                                    </td>
                                </tr>
                                <tr>
                                	<Td class="tab_important">★</Td>
                                	<td class="tab1_table_title">계좌번호</td>
                                    <td class="tab1_table_info">
                                    	<li>
                                        	<form:select path="bankId" value="${mberManageVO.bankId}" >
												<c:forEach var="result" items="${bank_result}" varStatus="status">
					                        	<form:option value="${result.code}"  label='${result.codeNm}'/>
					                        	</c:forEach>
											</form:select>                                       
                                        </li>
                                        <li><input type="text" name="account" value="${mberManageVO.account}"/></li>
                                        <li>'-'제외하고 입력해주세요 / 이름과 계좌의 명의가 같아야 합니다.</li>
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
                                        <!-- 휴대폰 인증을 통해서 넘어온 폰번호는 '-' 가 없이 넘어옴.
                                        	<c:set var="hpMIdx" value="${fn:indexOf(mberManageVO.moblphonNo, '-')}"/>
                                        	<c:set var="hpStr" value="${fn:substring(mberManageVO.moblphonNo,hpMIdx+1,13)}"/>
                                    		<c:set var="hpLIdx" value="${fn:indexOf(hpStr, '-')}" />
                                    		 -->
                                        	<input type="text" id="mbtlnumMiddle" name="mbtlnumMiddle" maxlength="4" value="${fn:substring(mberManageVO.moblphonNo,3,7)}" style="width:80px;"/> - 
                                        	<input type="text" id="mbtlnumMTail" name="mbtlnumMTail" maxlength="4" value="${fn:substring(mberManageVO.moblphonNo,7,13)}" style="width:80px;"/>
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
                                <tr>
                        <Td class="join_important"></Td>
                        <td class="join_table_title">파일첨부 주민등록증</td>
                        <td class="join_table_info">
                            <li>
                            	<form:hidden path="atchFileId" value="${mberManageVO.atchFileId}"/>
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
                            	<form:hidden path="atchFileId1" value="${mberManageVO.atchFileId1}"/>
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
                            	<form:hidden path="atchFileId2" value="${mberManageVO.atchFileId2}"/>
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
                            	<form:hidden path="atchFileId3" value="${mberManageVO.atchFileId3}"/>
								<input name="file1_text" type="text" class="w400"/>
								<img name="btnFileUpload" src="${contextPath}/images/common/btn_searchfile.png" data_fileMax="5" data_category="news"  data_type="img" data_fieldId="atchFileId3" alt="찾아보기"   />
							</li>
                            <li>본인인증이 어려우신 분이나 외국인은 신분증 및 본인을 증명할 수 있는 증명서를 스캔하여 첨부하거나 FAX로 보내주세요.</li>
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
	                    	<li><a href="#" name="btnUpdate"><img src="/images/btn/info_change.png" /></a></li>
                            <li><a href="#" name="btnCancle"><img src="/images/btn/info_cancle.png" /></a></li>
	                    </div>
                    </div>
                    <div id="tab2" class="tab_content">
                    	<h2>보안을 위해 아래 안내문을 읽어보신 후 설정해 주십시오.</h2>                       
                        <div class="tab2_con">
                        	<div class="pw_info">
	                            <li>★ 영문/숫자 8자 ~ 16자로 설정 가능합니다.</li>
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
                                <li><a href="#" name="btnChangePass"><img src="/images/btn/info_change.png" /></a></li>
                                <li><a href="#" name="btnCancle"><img src="/images/btn/info_cancle.png" /></a></li>
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

<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
  <script type="text/javaScript" language="javascript"> 
  
  $(function(){
	  // 생년월일 설정
	  var birth= "${mberManageVO.ihidnum}";
	  var birthYear = birth.substring(0,4);
	  var birthMonth = birth.substring(4,6);
	  var birthDay = birth.substring(6,8);
	  var mbtlnumHead = "${fn:substring(mberManageVO.moblphonNo,0,3)}";
	  $( "#mbtlnumHead").val(mbtlnumHead);
	  var sexCode = "${mberManageVO.sexdstnCode}";
	  
	  
	  $('[name=sexdstnCode][value='+sexCode+']').prop('checked', true);
	  
	  $( "#birthYear").val(birthYear);
	  $( "#month_select").val(birthMonth);
	  $( "#day_select").val(birthDay);
	  
	  var emailTail = $("[name=emailTail]").val();
	  
	  var $email = $("[name=emailTail2] option");
	  $email.each(function(i){
		  if($(this).val() == emailTail) {
			  $("[name=emailTail2]").val(emailTail);
			  //$("[name=emailTail2] option").eq(i).attr("selected", "selected");
			  return false;
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
			$("#moblphonNo").val(  $( "#mbtlnumHead" ).val() + $( "#mbtlnumMiddle" ).val() + $( "#mbtlnumMTail" ).val() );
			
		});
		
		$( "#emailHead, [name='emailTail2']").change(function(){
			
			var $emailAddr =  $("input[name='emailTail']");
			
			if($(this).val() == "" ||  $(this).val() == null) {
				$emailAddr.prop("readOnly", false);
			} else { 
				//$emailAddr.prop("readOnly", true);
				$emailAddr.val($(this).val());
			}
			
			$("#mberEmailAdres").val( $("#emailHead").val() + '@' + $emailAddr.val());
			
		});
		
		$( "[name=emailTail]").change(function(){
			
			var $emailAddr =  $("input[name=emailTail]");
			$( "[name=emailTail2]").val('');
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
		
		
		$("[name=btnUpdate]").on("click", function(e) {
			e.preventDefault();
			
			var rippleWallet = $("[name=rippleTradeEmail]").val();
			var account = $("[name=account]").val();
			var userNmae = $("[name=mberNm]").val();
			if(rippleWallet == '' || rippleWallet== null){
				alert('리플 지갑 주소를 입력하여 주십시오.');
				return false;
			}
			
			if(account == '' || account== null){
				alert('계좌 번호를 입력하여 주십시오.');
				return false;
			}
			
			if(userNmae == '' || userNmae== null){
				alert('성명을 입력하여 주십시오.');
				return false;
			}
			
			$("#form").attr({action:"${contextPath}/myInfo/updateGnrMyInfo.do"});
			$("#form").submit();
		});
		
		$("[name=btnCancle]").click(function(e){
			e.preventDefault;
			
			location.href = "/";
		});
		
		
		$("[name=btnChangePass]").on("click", function(e) {
			e.preventDefault();
			
			if(!isValidFormPassword($("[name=password]").val(), $("#passwordChk").val())){
				return false;
			}
			// 비밀번호 일치여부 체크
			/* if(!$("#passwordChk").trigger("focusout")){
				return;
			} */
			
			
			
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
		
		$("#btnPostSearch").click(function(e){
			e.preventDefault;
			execDaumPostcode();
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
   	
  </script> 

