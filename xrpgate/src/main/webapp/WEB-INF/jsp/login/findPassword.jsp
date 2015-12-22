<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/taglib.jsp" %>

        <div class="svisual" style="background-color:#41372e;background-image:url('${contextPath}/img/Visual01.jpg'); background-position:center">
        </div><!--//svisual -->
        
        <div class="tit_wrap">
        	<div class="title area_ct">
            	<img src="${contextPath}/img/tit_customer.png" alt="고객센터"><span>Customer</span>
            	<div class="depth"><a href="#"><img src="${contextPath}/img/ico_home.png" alt="home아이콘"></a><img src="${contextPath}/img/space.png" alt=""><a href="#">고객센터</a><img src="${contextPath}/img/space.png" alt=""><a href="#">공지사항</a></div>
            </div>
        </div>
     	<div id="sub_container">
        	<div id="content-group">
        		<div id="lnb-group">
            		<ul id="lnb">
                	<li><a href="/customer/noticeList.do" >공지사항</a></li>
					<li><a href="#">뉴스레터</a></li>
					<li><a href="#">문의∙제안∙신고</a></li>
                    <li><a href="#">온라인도움말</a></li>
					<li><a href="/customer/terms.do">서비스정책</a></li>
					<li><a href="/myInfo/myInfoView.do" class="select">회원정보</a></li>
                	</ul>
                    
					<%@ include file="../include/linkMenu.jsp" %>
            	</div>
            	<!--//lnb-group -->
               
            
            	<div id="contents" class="bg_cs">
<!--                 	<div class="top"><a href="#"></a></div> -->
<!--             		<div class="con_tit">회원정보 <span>Membership</span> -->
<!--                     	<span class="ex">고객님의 소중한 정보를 관리합니다.</span> -->
<!--                     </div> -->
                    
<!--                     <ul class="tap4_wrp mt10"> -->
<!--                     	<li><a href="#" class="select">회원가입</a></li> -->
<!--                         <li><a href="#">아이디 찾기</a></li> -->
<!--                         <li><a href="#">비밀번호 찾기</a></li> -->
<!--                         <li><a href="#">내정보 바로가기</a></li> -->
<!--                     </ul> -->
						<%@ include file="../include/joinMenu.jsp" %>
						
                    <div class="view_info mtf5 mb5">
                        <div class="ico_box_w">
                            <ul class="ico_box2">
                            <li class="print"><a href="#" title="프린트">프린트</a></li>
                            <li class="url"><a href="#" title="url">url</a></li>
                            <li class="claim"><a href="#" title="신고하기">신고하기</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="mem_info fll txt12 mt5">
                    	<ul>
                            <li>아이핀(i-PIN)으로 등록한 회원은 “아이핀(i-PIN)” 클릭시 비밀번호를 찾을 수 있습니다.</li>
                            <li>아이핀정보가 없을 경우, 개인회원은 성명∙이메일주소∙휴대폰번호, 기업∙단체회원은 대표자명∙사업자등록번호∙대표이메일주소를 입력한후 이메일확인버튼을 클릭하여 주시기 바랍니다. </li>
                            <li>비밀번호는 회원정보에 입력된 이메일주소로 자동 발송됩니다.</li>
                        </ul>
                    </div>
                    
                    <div class="find_wrap mt40 mb35 fl100">
                    	 <form:form commandName="mberManageVO"  id="form">
                    	<div class="box fll">
                        	<p class="fw_b fcBlt">개인회원</p>
                            <ul class="pw_put fl100">
                            	<li><strong>아이디</strong><span class="con"><input id="gnrId"  name="gnrId"  type="text" class="w200"></span> </li>
                            	<li><strong>성명(실명)</strong><span class="con"><input name="grnName" id="grnName" type="text" class="w200"></span> </li>
                                <li><strong>휴대폰</strong>
                                	<span class="con">
                                    <select name="phoneHead"  id="phoneHead" >
                                        <option value='010'>010</option>
                                    </select>
                                    &nbsp;<em>-</em>&nbsp;<input name="phoneMiddle" id="phoneMiddle"  type="text" class="w40">&nbsp;<em>-</em>&nbsp;<input name="phoneTail" id="phoneTail"  type="text" class="w40">
                                    </span> 
                                </li>
                                <li class="end"><strong>이메일 </strong>
                                	<span class="con">
                                    <input name="gnrEmailHead" id="gnrEmailHead" type="text" class="w80"><em>@</em><input name="gnrEmailTail" id="gnrEmailTail" type="text" class="w100">
                                    <form:select path="mberEmailAdres" id="mberEmailAdresList" title="이메일">
				                        <form:option value="" label="--선택하세요--"/>
				                        <form:options items="${email_result}" itemValue="codeNm" itemLabel="codeNm"/>
				                    </form:select>
                                    </span>
                                </li>
                            </ul>
                            <div class="fl100 mt35">
                                <div class="mem_btn">
                                    <div class="btn_nxt"><a href="javascript:;" id="verifyGnrEmailFirst" >이메일 확인</a></div><div class="btn_ipin"><a href="#">아이핀확인 </a></div>
                                </div>
                        	</div>
                        </div><!--//개인회원 -->
                        <div class="box2">
                        <p class="fw_b fcBlt">기관∙기업회원</p>
                            <ul class="pw_put fl100">
                            	<li><strong>아이디</strong><span class="con"><input id="entId"  name="entId"  type="text" class="w200"></span> </li>
                            	<li><strong>대표자명</strong><span class="con"><input name="entName" id="entName" type="text" class="w200"></span> </li>
                                <li><strong>사업자등록번호</strong>
                                	<span class="con">
                                    <input name="bizrno1" id="bizrno1"  type="text" class="w60">&nbsp;<em>-</em>&nbsp;<input name="bizrno2" id="bizrno2"  type="text" class="w60">&nbsp;<em>-</em>&nbsp;<input name="bizrno3" id="bizrno3"  type="text" class="w60"> 
                                    </span> 
                                </li>
                                <li class="end"><strong>대표이메일 </strong>
                                	<span class="con">
                                    <input name="entEmailHead" id="entEmailHead" type="text" class="w80"><em>@</em><input name="entEmailTail" id="entEmailTail" type="text" class="w100">
                                     <form:select path="mberEmailAdres" id="entMberEmailAdresList" title="이메일">
				                        <form:option value="" label="--선택하세요--"/>
				                        <form:options items="${email_result}" itemValue="codeNm" itemLabel="codeNm"/>
				                    </form:select>
                                    </span>
                                </li>
                            </ul>
                            <div class="fl100 mt35">
                                <div class="mem_btn">
                                    <div class="btn_nxt"><a href="javascript:;" id="verifyEntEmailFirst" >이메일 확인</a></div><div class="btn_ipin"><a href="#">아이핀확인 </a></div>
                                </div>
                        	</div>
                        </div><!--//기업회원 -->
                    </div>
                    
                    <input type="hidden" name="id" id="id" value="">
                    <input type="hidden" name="name" id="name" value="">
                    <input type="hidden" name="mbTlNum" id="mbTlNum" value="">
                    <input type="hidden" name="bizrno" id="bizrno" value="">
                    <input type="hidden" name="email" id="email" value="">
                    <input type="hidden" name="userSe"   id="userSe" value='${loginVO.userSe}'>
                    </form:form>      
                            
                    <!--팝업창 -->
                    <div class="pop_mem fl100" id="div-similar">
	                 </div>                        
                    <!--//팝업창 -->  
                                      
            	</div>
            	<!--//contents -->
        	</div>
        	<!--//content-group -->
		</div><!--//sub_container -->
    
 <script type="text/javaScript" language="javascript">
    $("#div-similar").css("display","none");
    
    $("#verifyGnrEmailFirst").attr({onclick:"javascript:requestVerifyNumber('GNR')"});
    $("#verifyEntEmailFirst").attr({onclick:"javascript:requestVerifyNumber('ENT')"})

    
    $('#verifyIPinFirst').bind("click", function(){
    	$('#verifyIPinFirst a').text('눌렀음');
	});
    
	//이메일 도메인 선택
	$( "#mberEmailAdresList" ).change(function () {
	    																					$("#gnrEmailTail").val(  $( "#mberEmailAdresList option:selected" ).val());  
	                                                                                       });
	//이메일 도메인 선택
	$( "#entMberEmailAdresList" ).change(function () {
	    																					$("#entEmailTail").val(  $( "#entMberEmailAdresList option:selected" ).val());  
	                                                                                       });
	
    
    function requestVerifyNumber(userSe){   
    	if(userSe == 'GNR'){
    		$('#id').val($('#gnrId').val());
    		$('#name').val($('#grnName').val());
    		$('#mbTlNum').val($('#phoneHead').val()+$('#phoneMiddle').val()+$('#phoneTail').val());
    		$('#email').val($('#gnrEmailHead').val()+"@"+$('#gnrEmailTail').val());
    	}else{
    		$('#id').val($('#entId').val());
    		$('#name').val($('#entName').val());
    		$('#bizrno').val( $('#bizrno1').val() + $('#bizrno2').val()+ $('#bizrno3').val());
    		$('#email').val($('#entEmailHead').val()+"@"+$('#entEmailTail').val());
    	}
    	$('#userSe').val(userSe);
              
    	$("#div-similar").html('');  
    	
    	$("#div-similar").css("display","block");
    	var $body = $('#div-similar');
    	var html = '';
// 		var html = '<p>메일 발송 작업 중입니다. 결과 응답때까지 잠시만 기다리세요.</p>';
		$body.append(html); 
		
    	var formData = $("form").serialize ();
        $.ajax({
            url: "${contextPath}/login/jsonFindPassword.do",
            type: "post",
            dataType:"json",
			data: formData,   //             data: { "name" : $("#name").val(),  "email" : $("#email").val(), "mbTlNum" : $("#mbTlNum").val() },
            success: function (data, status) {
            	$body.html('');
            	if(data.IsSucceed){
            		//일치하는 유저 검색
					var list = data.Message;	
       				html = '<p>개인정보보호를 위해 회원정보에 등록된 이메일로 임시비밀번호를 발송하여 드렸습니다. </p>';
       				$body.append(html);           
  					var $div = $('<div class="intxt"></div>');       
  					var subhtml = data.Message+'<br>';
  					subhtml += '비밀번호는 단방향 암호화로 인해 복호화가 불가능합니다. 이메일로 발송된 임시비밀번호는 반드시 내정보에서 변경하시기 바랍니다.';
  					$div.html(subhtml);     
  					$body.append($div); 	
            	}else {
            		//검색 조건 없는 경우
    				html = '<dl>';
    				html += '<dt><img src="${contextPath}/img/ico_question.png" alt=""></dt>';
    				html += '<dd>회원님께서 입력하신 정보와 일치하는 아이디가 없습니다.<br>';
    				html += '정확한 정보를 확인 후 다시 입력 부탁드립니다.<br>';
    				html += '아이디를 찾기가 어려울 경우, 서비스 도움말을 이용하시기 바랍니다. <br>';
    				html += '<span class="txt11">';
    				html += '<a href="#">-서비스도움말 바로가기</a>  <a href="${contextPath}/join/UserSeChoose.do">-회원가입 바로가기</a></span>';
    				html += '</dd>';
    				html += '</dl>';
    				
    				$body.append(html); 
            	}          	
            	$("#div-similar").css("display","block");
            	
            },
            error: function (request, status, error) {
            	alert('에러발생');
            	
            }
        });
    }
    
  </script>