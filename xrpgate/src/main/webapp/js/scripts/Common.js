


var COM = {};
function CommonClass() {
    var $this = this;
    this.setStartMessage = function (type) {
        if (type == 1) {
            $('#FooterMessage').text(BIT.messages.pre_save);
        } else {
            $('#FooterMessage').text(BIT.messages.pre_search);
        }
    };
    this.setEndMessage = function (type) {
        if (type == 1) {
            $('#FooterMessage').text(BIT.messages.com_save);
        } else {
            $('#FooterMessage').text(BIT.messages.com_search);
        }
    };

    /*
    select 에 기관 목록을 바인딩합니다.
    */
    this.bindSelectHospital = function ($selector, useAll, isViewDeletedData, currentValue, useAllMessage, isViewAdmin) {
        BIT.callSjax('/Services/Common/GetHospital.aspx', 'POST', {}, function (response) {
            var data = response.Data;
            if (useAll) {
                $selector.append('<option value="">' + (useAllMessage == null ? BIT.messages.select_message : useAllMessage) + '</option>');
            }
            for (var i = 0; i < data.length; i++) {
                if (!isViewDeletedData) {
                    if (data[i].IsDeleted == 'True') {
                        continue;
                    }
                }
                if (!isViewAdmin) {
                    if (data[i].Code == 'ADMIN') {
                        continue;
                    }
                }
                if (currentValue != null && currentValue == data[i].HPid) {
                    $selector.append('<option value="' + data[i].HPid + '" selected="selected">' + data[i].Name + '</option>');
                } else {
                    $selector.append('<option value="' + data[i].HPid + '">' + data[i].Name + '</option>');
                }
            }
        });
    };

    /*
    select 에 memberGroup 에 속한 기관 목록을 바인딩합니다.
    */
    this.bindSelectHospitalMemberGroup = function (memberId, $selector, useAll, isViewDeletedData, currentValue) {
        BIT.callSjax('/Services/Common/GetHospitalMemberGroup.aspx', 'POST', {
            MemberId: memberId
        }, function (response) {
            var data = response.Data;
            if (useAll) {
                $selector.append('<option value="">' + BIT.messages.select_message + '</option>');
            }
            for (var i = 0; i < data.length; i++) {
                if (isViewDeletedData == false) {
                    if (data[i].IsDeleted == 'True') {
                        continue;
                    }
                }
                if (currentValue != null && currentValue == data[i].HPid) {
                    $selector.append('<option value="' + data[i].HPid + '" selected="selected">' + data[i].Name + '</option>');
                } else {
                    $selector.append('<option value="' + data[i].HPid + '">' + data[i].Name + '</option>');
                }
            }
        });
    };

    /*
    select 에 전체 역할을 바인딩합니다.
    */
    this.bindSelectRole = function ($selector, useAll, currentValue, viewAdmin) {
        BIT.callSjax('/Services/Common/GetRoles.aspx', 'POST', {}, function (response) {
            var data = response.Data;
            if (useAll) {
                $selector.append('<option value="">' + BIT.messages.select_message + '</option>');
            }
            for (var i = 0; i < data.length; i++) {
                if (!viewAdmin) {
                    if (data[i].Name == 'Admin') {
                        continue;
                    }
                }
                if (currentValue != null && currentValue == data[i].RoleId) {
                    $selector.append('<option value="' + data[i].RoleId + '" selected="selected">' + data[i].Description + '</option>');

                } else {
                    $selector.append('<option value="' + data[i].RoleId + '">' + data[i].Description + '</option>');
                }
            }
        });
    };

    /*
    select 에 사용여부를 바인딩합니다.
    */
    this.bindSelectUse = function ($selector, useAll, currentValue) {
        if (useAll) {
            $selector.append('<option value="">' + BIT.messages.select_message + '</option>');
        }
        if (currentValue != null) {
            if (currentValue == 'True') {
                $selector.append('<option value="True" selected="selected">' + BIT.messages.select_use + '</option>');
                $selector.append('<option value="False">' + BIT.messages.select_notuse + '</option>');
            } else {
                $selector.append('<option value="True">' + BIT.messages.select_use + '</option>');
                $selector.append('<option value="False" selected="selected">' + BIT.messages.select_notuse + '</option>');
            }

        } else {
            $selector.append('<option value="True">' + BIT.messages.select_use + '</option>');
            $selector.append('<option value="False">' + BIT.messages.select_notuse + '</option>');
        }
    };

    /*
   select 에 삭제여부를 바인딩합니다.
   */
    this.bindSelectDelete = function ($selector, useAll, currentValue) {
        if (useAll) {
            $selector.append('<option value="">' + BIT.messages.select_message + '</option>');
        }
        if (currentValue != null) {
            if (currentValue == 'True') {
                $selector.append('<option value="True" selected="selected">' + BIT.messages.select_use + '</option>');
                $selector.append('<option value="False">' + BIT.messages.select_notuse + '</option>');
            } else {
                $selector.append('<option value="True">' + BIT.messages.select_use + '</option>');
                $selector.append('<option value="False" selected="selected">' + BIT.messages.select_notuse + '</option>');
            }

        } else {
            $selector.append('<option value="False">' + BIT.messages.select_use + '</option>');
            $selector.append('<option value="True">' + BIT.messages.select_notuse + '</option>');
        }
    };

    /*
    select 에 진료과목을 바인딩합니다.
    */
    this.bindSelectDepartment = function ($selector, useAll, containsDeletedData, currentValue, useAllMessage) {
        BIT.callSjax('/Services/Common/GetDepartment.aspx', 'POST', {}, function (response) {
            var data = response.Data;
            $selector.empty();
            if (useAll) {
                $selector.append('<option value="">' + (useAllMessage == null ? BIT.messages.select_message : useAllMessage) + '</option>');
            }
            for (var i = 0; i < data.length; i++) {
                if (containsDeletedData != null && !containsDeletedData) {
                    if (data[i].IsDeleted == 'True') {
                        continue;
                    }
                }
                if (currentValue != null && currentValue == data[i].DepartmentId) {
                    $selector.append('<option value="' + data[i].DepartmentId + '" selected="selected">' + data[i].Name + '</option>');

                } else {
                    $selector.append('<option value="' + data[i].DepartmentId + '">' + data[i].Name + '</option>');
                }
            }
        });
    };

    /*
   select 에 진료과목을 바인딩합니다.
   */
    this.bindSelectDepartmentInHospital = function ($selector, useAll, containsDeletedData, hospital, currentValue, useAllMessage) {
        BIT.callSjax('/Services/Common/GetDepartmentInHospital.aspx', 'POST', { hospitalId: hospital }, function (response) {
            var data = response.Data;
            $selector.empty();
            if (useAll) {
                $selector.append('<option value="">' + (useAllMessage == null ? BIT.messages.select_message : useAllMessage) + '</option>');
            }
            for (var i = 0; i < data.length; i++) {
                if (containsDeletedData != null && !containsDeletedData) {
                    if (data[i].IsDeleted == 'True') {
                        continue;
                    }
                }
                if (currentValue != null && currentValue == data[i].DepartmentId) {
                    $selector.append('<option value="' + data[i].DepartmentId + '" selected="selected">' + data[i].Name + '</option>');

                } else {
                    $selector.append('<option value="' + data[i].DepartmentId + '">' + data[i].Name + '</option>');
                }
            }
        });
    };

    /*
    select 에 코드목록을 바인딩합니다.
    */
    this.bindSelectCode = function (categoryName, $selector, useAll, currentValue, useAllMessage) {
        BIT.callSjax('/Services/Common/GetCodes.aspx', 'POST', { CategoryName: categoryName }, function (response) {
            var data = response.Data;
            if (useAll) {
                $selector.append('<option value="">' + (useAllMessage == null ? BIT.messages.select_message : useAllMessage) + '</option>');
            }
            for (var i = 0; i < data.length; i++) {
                if (currentValue != null && currentValue == data[i].CodeId) {
                    $selector.append('<option value="' + data[i].ItemCode + '" selected="selected">' + data[i].ItemName + '</option>');

                } else {
                    $selector.append('<option value="' + data[i].ItemCode + '">' + data[i].ItemName + '</option>');
                }
            }
        });
    };

    /*
    select 에 GroupParent 목록을 바인딩합니다.
    */
    this.bindSelectGroupParent = function ($selector, useAll, currentValue, useAllMessage) {
        BIT.callSjax('/Services/Common/GetGroupParent.aspx', 'POST', {}, function (response) {
            var data = response.Data;
            $selector.find('option').remove();
            if (useAll) {
                $selector.append('<option value="">' + (useAllMessage == null ? BIT.messages.select_message : useAllMessage) + '</option>');
            }
            for (var i = 0; i < data.length; i++) {
                if (currentValue != null && currentValue == data[i].GroupParentId) {
                    $selector.append('<option value="' + data[i].GroupParentId + '" selected="selected">' + data[i].GroupParentName + '</option>');
                } else {
                    $selector.append('<option value="' + data[i].GroupParentId + '">' + data[i].GroupParentName + '</option>');
                }
            }
        });
    };

    /*
    코드테이블을 가져온다.
    */
    this.getCodeList = function (categoryName, callback) {
        BIT.callSjax('/Services/Common/GetCodes.aspx', 'POST', { CategoryName: categoryName }, function (response) {
            if (callback != null) {
                callback(response.Data);
            }
        });
    };

    /*
    해당 의료 기관의 해당 부서의 의료인들..
    */
    this.getDoctorMemberInDepartInHospital = function (departId, hospitalId, callback) {
        BIT.callSjax('/Services/Common/GetDoctorMemberInDepartInHospital.aspx', 'POST', {
            DepartId: departId,
            HospitalId: hospitalId
        }, function (response) {
            if (callback != null) {
                callback(response.Data);
            }
        });
    };

    /*
    해당 의료기관에 등록된 의료인
    */
    this.getUserMemberInHospital = function (hospitalId, callback) {
        BIT.callSjax('/Services/Common/GetUserMemberInHospital.aspx', 'POST', {
            HospitalId: hospitalId
        }, function (response) {
            if (callback != null) {
                callback(response.Data);
            }
        });
    };

    /*
    환자 검색 팝업을 띄운다.
    */
    this.openPatientSearchPopup = function (selectCallback) {
        var options = {
            url: '/Common/PatientSearchPopup.aspx',
            width: 630,
            height: 460,
            closeCallback: closeCallback,
            title: BIT.messages.common_search_title,
            data: {
            },
            buttonType: 1
        };
        var $dialog = BIT.modalDialog(options);
        function closeCallback(returnValue) {
            if (returnValue != null) {
                selectCallback(returnValue);
            }
        }
    };

    /*
    같은 권역에 특정 부서에 있는 모든 의료인들
    */
    this.bindSelectMemberInAllDepart = function (departId, $selector, useAll, currentValue, useAllMessage) {
        BIT.callSjax('/Services/Common/GetMemberListInDepart.aspx', 'POST', {
            DepartId: departId
        }, function (response) {
            var data = response.Data;
            $selector.empty();
            if (useAll) {
                $selector.append('<option value="">' + (useAllMessage == null ? BIT.messages.select_message : useAllMessage) + '</option>');
            }
            for (var i = 0; i < data.length; i++) {
                if (currentValue != null && currentValue == data[i].MemberId) {
                    $selector.append('<option value="' + data[i].MemberId + '" selected="selected">' + data[i].Name + '</option>');
                } else {
                    $selector.append('<option value="' + data[i].MemberId + '">' + data[i].Name + '</option>');
                }
            }
        });
    };

    /*
    해당 병원의 부서에 속하는 모든 의사 역할의 의료인들
    */
    this.bindSelectDoctorMemberInDepartInHospital = function (departId, hospitalId, $selector, useAll, currentValue, useAllMessage) {
        BIT.callSjax('/Services/Common/GetDoctorMemberInDepartInHospital.aspx', 'POST', {
            DepartId: departId,
            HospitalId: hospitalId
        }, function (response) {
            var data = response.Data;
            $selector.empty();
            if (useAll) {
                $selector.append('<option value="">' + (useAllMessage == null ? BIT.messages.select_message : useAllMessage) + '</option>');
            }
            for (var i = 0; i < data.length; i++) {
                if (currentValue != null && currentValue == data[i].MemberId) {
                    $selector.append('<option value="' + data[i].MemberId + '" selected="selected">' + data[i].Name + '</option>');
                } else {
                    $selector.append('<option value="' + data[i].MemberId + '">' + data[i].Name + '</option>');
                }
            }
        });
    };

    /*
    메인 메뉴에서 페이지가 아닌 팝업 메뉴 클릭
    */
    this.openMainMenuPopup = function (url, title, width, heidht, data, needItemShow, buttonType) {

        if (buttonType == null) {
            buttonType = 1;
        }

        var options = {
            url: url,
            width: width,
            height: heidht,
            title: title,
            data: data,
            buttonType: buttonType,
            needItemShow: needItemShow
        };
        var $dialog = BIT.modalDialog(options);
        return false;
    };
    
    /*
	 * 업로드된 파일 목록을 보기 위한 팝업을 띄움
	 */
	this.openFileListPopup = function(categoryName, fileIds) {
		var options = {
			url : '/files/listPage.do',
			width : 500,
			height : 350,
			title : '[파일 내려받기]',            //BIT.messages.common_file_title,
			data : {
				Category : categoryName,
				FileIds : fileIds
			},
			buttonType : 0
		};
		BIT.modalDialog(options);
	};
    
};
this.COM = new CommonClass();

var selectDay = null;
var selectGridRow = null;

$(function () {

    /*
    탭의 헤더의 ul 태그에는 tabHeader 클래스를 선언
    탭의 헤더의 a 태그의 href 에는 tabcontent의 아이디를 정의, 탭 인덱스는 숫자 2자리 예) #tab_leftTop01
    탭의 컨텐트의 컨테이너의 id 에는 위에 선언된 값의 번호를 뺀 값을 입력 예)id ="tab_leftTop"
    탭의 컨텐트의 id 에는 위에 선언된 값을 입력 예)id ="tab_leftTop01"
    탭의 컨텐트의 class 에는 tab_content 추가
    */
    $('ul.tabHeader li a').click(function () {
        $(this).parent().siblings().removeClass('selected');
        $(this).parent().addClass('selected');
        var id = $(this).attr('href').substring(1);
        var container = id.substring(0, $(this).attr('href').length - 3);
        $('#' + container).find('.tab_content[id^=' + container + ']').each(function () {
            $(this).hide();
        });
        $('#' + id).show();
        return false;
    });

    $('.ico_cal').click(function () {
        $(this).next().datepicker('show');
    });
    if ($.datepicker) {
        $('.input_cal').datepicker({
            onSelect: function (text, obj) {
                if (selectDay != null) {
                    selectDay(text, obj);
                }
            },
            beforeShow: function () {
                showPrevNextYearButton($(this));
            },
            onChangeMonthYear: function () {
                showPrevNextYearButton($(this));
            }
        });
    }

    function showPrevNextYearButton($input) {
        setTimeout(function () {
            var header = $input.datepicker('widget').find('.ui-datepicker-header');
            var $prevButton = $('<a title="' + BIT.messages.datepicker_prev_year + '" class="ui-datepicker-prevYear ui-corner-all" ><span>' + BIT.messages.datepicker_prev_year + '</span></a>');
            header.find('a.ui-datepicker-prev').before($prevButton);
            $prevButton.unbind("click").bind("click", function () {
                $.datepicker._adjustDate($input, -1, 'Y');
            });

            var $nextButton = $('<a title="' + BIT.messages.datepicker_next_year + '" class="ui-datepicker-nextYear ui-corner-all" ><span>' + BIT.messages.datepicker_next_year + '</span></a>');
            header.find('a.ui-datepicker-next').after($nextButton);
            $nextButton.unbind("click").bind("click", function () {
                $.datepicker._adjustDate($input, +1, 'Y');
            });
        }, 1);
    };

    $('li.modalType a').click(function (e) {
        var url = $(this).attr('href');
        if (url.toLowerCase() == '/prescription/history') {
            COM.openMainMenuPopup(url, $(this).text(), 640, 570, {}, null, 0);
        } else if (url.toLowerCase() == '/infomation/icd') {
            COM.openMainMenuPopup(url, $(this).text(), 630, 490, {}, null, 0);
        } else if (url.toLowerCase() == '/record') {
            COM.openMainMenuPopup(url, $(this).text(), 920, 560, {}, null, 0);
        } else if (url.toLowerCase() == '/infomation/history') {
            COM.openMainMenuPopup(url, $(this).text(), 920, 560, {}, null, 0);
        } else if (url.toLowerCase() == '/infomation/monthlycondition') {
            COM.openMainMenuPopup(url, $(this).text(), 920, 570, {}, null, 0);
        } else if (url.toLowerCase() == '/infomation/drugstatistics') {
            COM.openMainMenuPopup(url, $(this).text(), 920, 570, {}, null, 0);
        } else if (url.toLowerCase() == '/administration/receiptpay') {
            COM.openMainMenuPopup(url, $(this).text(), 920, 640);
        } else if (url.toLowerCase() == '/inspection/requestteleradiology') {
            COM.openMainMenuPopup(url, $(this).text(), 920, 600, {}, null, 0);
        } else if (url.toLowerCase() == '/inspection/resultteleradiology') {
            COM.openMainMenuPopup(url, $(this).text(), 920, 580, {}, null, 0);
        } else if (url.toLowerCase() == '/inspection/personalresult') {
            COM.openMainMenuPopup(url, $(this).text(), 920, 480, {}, null, 0);
        } else if (url.toLowerCase() == '/patient/acute') {
            COM.openMainMenuPopup(url, $(this).text(), 920, 480, {}, null, 0);
        } else if (url.toLowerCase() == '/infomation/monthlyvitalsign') {
            COM.openMainMenuPopup(url, $(this).text(), 920, 560, {}, null, 0);
        } else if (url.toLowerCase() == '/help/manual') {
            COM.openMainMenuPopup(url, $(this).text(), 420, 655, {}, null, 0);
        } else if (url.toLowerCase() == '/inspection/patienttest') {
            COM.openMainMenuPopup(url, $(this).text(), 920, 480, {}, null, 0);
        }

        e.preventDefault();
    });

    $(':text[readonly]').addClass('txt_readonly');

    //MAP 사용 함수
    Map = function(){
   	 this.map = new Object();
  	};   
  	Map.prototype = {   
  	    put : function(key, value){   
  	        this.map[key] = value;
  	    },   
  	    get : function(key){   
  	        return this.map[key];
  	    },
  	    containsKey : function(key){    
  	     return key in this.map;
  	    },
  	    containsValue : function(value){    
  	     for(var prop in this.map){
  	      if(this.map[prop] == value) return true;
  	     }
  	     return false;
  	    },
  	    isEmpty : function(key){    
  	     return (this.size() == 0);
  	    },
  	    clear : function(){   
  	     for(var prop in this.map){
  	      delete this.map[prop];
  	     }
  	    },
  	    remove : function(key){    
  	     delete this.map[key];
  	    },
  	    keys : function(){   
  	        var keys = new Array();   
  	        for(var prop in this.map){   
  	            keys.push(prop);
  	        }   
  	        return keys;
  	    },
  	    values : function(){   
  	     var values = new Array();   
  	        for(var prop in this.map){   
  	         values.push(this.map[prop]);
  	        }   
  	        return values;
  	    },
  	    size : function(){
  	      var count = 0;
  	      for (var prop in this.map) {
  	        count++;
  	      }
  	      return count;
  	    }
  	};
});