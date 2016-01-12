$(document).on("click", ".btn_toggle", function(){
  $("#search_area").toggle(function(){
    if($(".btn_toggle").val() == "Close Search Area"){
      $(".btn_toggle").val("Open  Search Area");
    }else{
      $(".btn_toggle").val("Close Search Area");
    }
    
  });
});

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
			//alert(xmlHttpRequest.responseText);
			alert("에러가 발생하였습니다. 관리자에게 문의 하세요.");
		}
	});
}

//전자우편 주소 체크 
function email_chk(mail){

	if(mail.lengh == 0) {
		//alert("0");
		return false;
	}
	var email = mail.split('@');
	if(email.length != 2)	{
		//alert("1");
		return false;
	}
	
	var id = escape(email[0]).replace(/-/gi, "");
	var domain = escape(email[1]).replace(/-/gi, "");
	
	if(id.match(/^(\w+)$/ig) == null && id.match(/^(\w+)[.](\w+)$/ig) == null && id.match(/^(\w+)[.](\w+)[.](\w+)$/ig) == null){
		//alert("2");
		return false;
	} else {
		if(password_chk(id.replace(/./gi, "").replace(/-/gi, ""))){
			//alert("3");
			return false;
		}
	}
	
	if(domain.match(/^(\w+)[.](\w+)$/ig) == null && domain.match(/^(\w+)[.](\w+)[.](\w+)$/ig) == null){
		//alert("4");
		return false;
	} else {
		if(password_chk(domain.replace(/./gi, "").replace(/-/gi, ""))){
			//alert("5");
			return false;
		}
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