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
			alert(xmlHttpRequest.responseText
					+ '\n' + textStatus + ' errorThrown '+errorThrown);
			//alert("에러가 발생하였습니다. 관리자에게 문의 하세요.");
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

function getParent(win) {
    if (win.location === win.parent.location) {
        return win;
    } else {
        return getParent(win.parent);
    }
}

var dt ,opts,parent,$div,$container ;
var $dialog;
function modalDialog(options) {
    var defaults = {
        iframe: false,
        url: '',
        width: 576,
        height: 670,
        closeCallback: null,
        title: '',
        data: {},
        buttonType: 0
    };

    dt = new Date().getTime();
    opts = $.extend({}, defaults, options);
    opts.data.containerId = 'cntr_' + dt.toString();
    opts.url = opts.url + '?' + $.param(opts.data); //$(opts.data).convertQueryStrings();

    parent = getParent(window);
    $div = parent.$('<div id="parent_' + dt.toString() + '"></div>');
    $container = null;
    if (opts.iframe) {
        $container = $('<iframe  id="cntr_' + dt.toString() + '" class="modalContainer" frameborder="0" width="100%" height="100%" marginheight="0" marginwidth="0" scrolling="no" src=""/>');
    } else {
        $container = $('<div id="cntr_' + dt.toString() + '"  class="modalContainer" style="overflow-x:none; overflow-y:auto;width:100%; padding:0 0 0 0;" />');
    }

    if (opts.buttonType == 0) { // 하단 버튼을 자동으로 생성하지 않는다.
//        $div.append($container).append('<div style="width:100%;text-align:center; padding:10px 0 0 0;"><p name="modalClose" class="btn_close" style="width:86px;display:none;"><span>' + '닫기'+ '</span></p>  <p name="modalApply" style="width:86px;display:none;" class="btn_close" ><span>' + $this.messages.common_modal_apply + '</span></p></div>');
        $div.append($container).append('<div style="width:100%;text-align:center; padding:10px 0 0 0;"><p name="modalClose" class="btn_close" style="width:86px;display:none;"><span>' + '닫기' + '</span></p>  <p name="modalApply" style="width:86px;display:none;" class="btn_close" ><span>' + '닫기' + '</span></p></div>');
    } else if (opts.buttonType == 1) {
        $div.append($container).append('<div style="width:100%;text-align:center; padding:10px 0 0 0;"><p name="modalClose" class="btn_close" style="width:86px;"><span>' + '닫기'+ '</span></p>  <p name="modalApply" style="width:86px;display:none;" class="btn_close" ><span>' + '닫기' + '</span></p></div>');
    } else if (opts.buttonType == 2) {
        $container.css('height', '78%');
        $div.append($container).append('<div style="width:100%;text-align:center; padding:0px 0 0 0;"><p name="modalClose" class="btn_close" style="width:86px;display:none;"><span>' + '닫기'+ '</span></p>	<div class="tm_setBtn"><button name="modalApply" class="tm_btn02 tm_type02 tm_fixWid"><span><span>저장</span></span></button></div></div>');
    } else { // 비동기 방식
        $div.append($container).append('<div style="width:100%;text-align:center; padding:10px 0 0 0;"><p name="modalClose" class="btn_close" style="width:86px;"><span>' + '닫기'+ '</span></p>  <p name="modalApply" style="width:86px;display:none;" class="btn_close" ><span>' + '닫기' + '</span></p><p name="modalAsyncApply" style="width:86px;" class="btn_close" style="display:none" ><span>' + '닫기' + '</span></p></div>');
    }

    $dialog = $div.dialog({
        autoOpen: true,
        title: opts.title,
        resizable: false,
        modal: true,
        show: {
            effect: 'fade',
            duration: 200
        },
        hide: {
            effect: 'fade',
            duration: 200
        },
        width: opts.width,
        height: convertHeightToIntFromPercent(opts.height)
    });
    
    

    $dialog.dialog('open');
    $div.parent('div').addClass('modal');
    if (opts.iframe) {	
        $container.attr('src', opts.url);
    } else {
        $.get(opts.url, function (data) {
            $container.html(data);
        });
    }
    $container.data('options', opts);
    
  //닫기 버튼(우상단X)
    $dialog.prev().find('button').click(function () {
        //closeModal();
    	ufn_closeModal();
    });

    // 하단의 닫기 버튼
    $('p[name=modalClose]', $div[0]).click(function () {
        closeModal();
    });

    // popup 에 <div id="div_result"/>를 생성하여 이 div의 click 이벤트를 등록해 놓으면 해당 버튼을
    // 클릭할때 트리거한다.
    $('p[name=modalAsyncApply]', $div[0]).click(function () {
        $container.contents().find('#div_result').trigger('click', opts);
    });

    // 이 버튼은 iframe에서 현재 modal를 닫기 위한 버튼이다.
    //
    // $('#_HiddenData').val(JSON.stringify(responseText.IsSuccess));
    $('[name=modalApply]', $div[0]).click(function () {
        var data = getSavedData();
        if (data != null || opts.buttonType == 0 || opts.buttonType == 2) {
            $dialog.dialog('close');
            if (opts.closeCallback) {
                opts.closeCallback(data);
            }
        }
        // 모달에서 더이상 사용하지 않는 레이어이다.
        $('.modal').addClass('modal_garbage');

        try {
            $('.modal_garbage').remove();
        } catch (e) {
            console.log(e.message);
        }
    });
    
    function convertHeightToIntFromPercent(percent) {
        if (!Number(percent) && percent.substring(percent.length - 1) == '%') {
            return $('body').height() * 0.01 * parseInt(percent.substring(0, percent.length - 1));
        } else {
            return percent;
        }
    }

    function getSavedData() {
        var f = $container.contents().find('#_HiddenData');
        if (f != null && f.val() != '' && f.length > 0) {
            var data = JSON.parse(f.val());
            if (data != null) {
                return data;
            }
        } else if ($container.data('data') != null) {
            return $container.data('data');
        }
        return null;
    }

    return $dialog;
};

function modalDialogCloseClick(buttonName, containerId) {
    var div = {};
    if (!containerId) {
        alert('containerId를 입력하세요.');
    } else {
        div = $(parent.document).find('#' + containerId).parent()[0];
        $('p[name=' + buttonName + ']', div).trigger('click');
    }
};

function fn_numberRound(num, pointDigit) {
	var digitNumber = Math.pow(10, pointDigit);
	
	return Math.round(num*digitNumber)/digitNumber;
}