
$(document).on("click", ".btn_reset", function() {

  var $searcDiv = $(".search_table");
  $searcDiv.find("input").val("");
  $searcDiv.find("select").val("");
  $searcDiv.find(":checkbox").val("");

  // $("form")[0].reset();
});

$(document).on("click", ".datepicker", function() {
  $(this).datepicker('show');
});

$(document).on("click", ".btn_date", function() {
  $(this).prev().find(".datepicker").datepicker('show');
});



// post 동기화 로딩 이미지 추가
function sendPost(url, para, callbackFuncName) {
	$.ajax({
		type : 'post',
		url : url,
		dataType : 'json',
		data : para,
		async : false,
		//beforeSend : $.blockUI(),
		success : function(data) {
			if (callbackFuncName != "" && callbackFuncName != undefined) {
				window[callbackFuncName].call(this, data);
			}
			//$.unblockUI();
		},
		error : function(xmlHttpRequest, textStatus, errorThrown) {
			// debugger;
			//$.unblockUI();
			alert(xmlHttpRequest.responseText
					+ '\n' + textStatus + ' errorThrown '+errorThrown);
			//alert("에러가 발생하였습니다. 관리자에게 문의 하세요.");
		}
	});
}

//전자우편 주소 체크 
function isValidEmail(email){

	var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;   
	
	if(email == '' || email == null){
		alert("이메일을 입력하여 주십시오.");
		return false;
	}
	if(regex.test(email) === false) {  
	    alert("잘못된 이메일 형식입니다.");  
	    return false;  
	}
	return true;
}

//=== 영문, 숫자 혼용 확인
//혼용이면 true, 아니면 false
function password_chk(pwd){
	var chk_num = pwd.search(/[0-9]/g);
	var chk_eng = pwd.search(/[a-z]/ig);
	if(chk_num < 0 || chk_eng < 0) {
		return false;
	}
	return true;
}

function num_chk(str) {
  for( var i = 0; i <= str.length -1 ; i++ ) {
    if(str.charAt(i) >= '0' && str.charAt(i) <= '9'){}
    else {
    return false;
    }
  }
  return true;
}

//패스워드 체크 영문대문자 숫자 최소 하나 포함
function isValidFormPassword(pw, chkPw) {
	 //var check = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{6,16}$/;
	
		if( pw == null  ||  pw == '' ) {
			alert("비밀번호를 입력하여 주십시오.");
				return false;	
		}
		
		if( pw  != chkPw){
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		
	 var check = /^(?=.*[a-z])(?=.*[0-9]).{8,16}$/i;
	 
	 if (!check.test(pw))     {
	        alert("비밀번호는 영문/숫자 8자 ~ 16자로 입력해주세요.");
	        return false;
	    }
	         
	 if (pw.length < 8 || pw.length > 16) {
	  alert("비밀번호는 8 ~ 16 자리로 입력해주세요.");
	  return false;
	 }
	 
	    return true;
	}

function fn_numberRound(num, pointDigit) {
	var digitNumber = Math.pow(10, pointDigit);
	
	return Math.round(num*digitNumber)/digitNumber;
}
