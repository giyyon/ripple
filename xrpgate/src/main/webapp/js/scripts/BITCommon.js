/*
의존성..
json2.js
jquery.ui.js(dialog 기능 )
BITCommon.css
 */
var BIT = {};
(function ($) {
    $.extend({
        // queryString을 키값쌍인 hash로 변환합니다.
        getUrlVars: function () {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                var hasKey = false;
                for (var j = 0; j < vars.length; j++) {
                    if (vars[j] == hash[0]) {
                        hasKey = true;
                        break;
                    }
                }
                if (!hasKey) {
                    vars.push(hash[0]);
                    vars[hash[0]] = hash[1];
                } else {
                    var arr = [];
                    var k;
                    if (typeof (vars[hash[0]]) == 'string') {
                        arr.push(vars[hash[0]]);
                    } else {
                        for (k = 0; k < vars[hash[0]].length; k++) {
                            arr.push(vars[hash[0]][k]);
                        }
                    }
                    vars[hash[0]] = [];
                    for (k = 0; k < arr.length; k++) {
                        vars[hash[0]].push(arr[k]);
                    }
                    var hasData = false;
                    for (k = 0; k < vars[hash[0]].length; k++) {
                        if (vars[hash[0]][k] == hash[1]) {
                            hasData = true;
                            break;
                        }
                    }
                    if (!hasData) {
                        vars[hash[0]].push(hash[1]);
                    }
                }
            }
            return vars;
        },

        // queryString에서 키값으로 값을 찾습니다.
        getUrlVar: function (name) {
            return $.getUrlVars()[name];
        }
    });

    $.extend($.fn, {
        // object를 queryString으로 변환합니다.
        // { name :'christina' } => name=christina
        convertQueryStrings: function () {
            var queryString = '';
            $.each($(this)[0], function (name, value) {
                // queryString += name + "=" + $.trim(escape(value)) + "&";
                // SpringMVC 에서 escape 를 하게 되면 한글 data 에 대해서 Controller 에서 받지
                // 못한다.
                queryString += name + "=" + $.trim(value) + "&";
            });
            return queryString.substring(queryString - 1);
        }
    });
}(jQuery));

//날짜에 주어진 일자를 더합니다.
Date.prototype.addDay = function (val) {
    var date = this;
    var newDate = new Date(date);
    newDate.setDate(newDate.getDate() + val);
    return new Date(newDate);
};

//날짜에 주어진 주를 더합니다.
Date.prototype.addWeek = function (val) {
    var date = this;
    var newDate = new Date(date);
    newDate.setDate(newDate.getDate() + val * 7);
    return new Date(newDate);
};

//날짜에 주어진 개월을 더합니다.
Date.prototype.addMonth = function (val) {
    var date = this;
    var newDate = new Date(date);
    newDate.setMonth(newDate.getMonth() + val);
    return new Date(newDate);
};

//날짜에 주어진 년을 더합니다.
Date.prototype.addYear = function (val) {
    var date = this;
    var newDate = new Date(date);
    newDate.setFullYear(newDate.getFullYear() + val);
    return new Date(newDate);
};

//queryString을 json 형식의 object로 변환합니다.
String.prototype.queryStringToJSON = function () {
    href = this;
    qStr = href.replace(/(.*?\?)/, '');
    qArr = qStr.split('&');
    stack = {};
    for (var i in qArr) {
        var a = qArr[i].split('=');
        var name = a[0], value = $.isNumeric(a[1]) ? parseFloat(a[1]) : (a[1] == null ? '' : a[1]);
        if (name.match(/(.*?)\[(.*?)]/)) {
            name = RegExp.$1;
            name2 = RegExp.$2;
            if (name2) {
                if (!(name in stack)) {
                    stack[name] = {};
                }
                stack[name][name2] = value;
            } else {
                if (!(name in stack)) {
                    stack[name] = [];
                }
                stack[name].push(value);
            }
        } else {
            stack[name] = value;
        }
    }
    return stack;
};

function BitCommonClass() {
    var $this = this;

    function getParent(win) {
        if (win.location === win.parent.location) {
            return win;
        } else {
            return getParent(win.parent);
        }
    }

    function preProccessSubmit(responseText, $form) {
        if (typeof (responseText) == 'string') {
            try {
                responseText = JSON.parse(responseText);
            } catch (e) {
                BIT.modal('시스템에 오류가 발생하였습니다.', '오류');
            }
        }
        if (typeof (responseText.IsSucceed) == 'string') {
            if (responseText.IsSucceed.toLowerCase() == 'true') {
                responseText.IsSucceed = true;
            } else {
                responseText.IsSucceed = false;
            }
        }
        if (responseText.Title == null || responseText.Title == '') {
            if (responseText.IsSucceed) {
                responseText.Title = BIT.messages.common_info_title;
            } else {
                responseText.Title = BIT.messages.common_error_title;
            }
        } else if (responseText.Title == 'Validator-Error') {
            // validator 오류
            var errorList = responseText.Data;
            if (errorList != null) {
                for (var i = 0; i < errorList.length; i++) {
                    try {
                        var $element = $('input[name=' + errorList[i].Name + '], select[name=' + errorList[i].Name + '], textarea[name=' + errorList[i].Name + ']');
                        if ($form != null) {
                            $element = $form.find($element);
                        }
                        if ($element.length > 0) {
                            $this.showTooltip($element, errorList[i].Message, $element.data('validator-direction'));
                        } else {
                            alert(errorList[i].Name + '요소를 찾을 수 없습니다.');
                        }
                    } catch (e) {
                    }
                }
            }
            return;
        }
        if (responseText.DoubleSubmitData != null) {
            $.each(responseText.DoubleSubmitData, function (name, value) {
                $form.find(':hidden[name=' + name + ']').val(value);
            });
            if (!responseText.IsSucceed) {
                BIT.modal('정상적이지 않은 요청입니다.', responseText.Title);
                return;
            }
        }
        if (responseText.RedirectUrl && responseText.Message) {
            BIT.modal(responseText.Message, responseText.Title, function () {
                getParent(window).location.href = responseText.RedirectUrl;
            });
        } else if (responseText.Message) {
            BIT.modal(responseText.Message, responseText.Title);
        } else if (responseText.RedirectUrl) {
            getParent(window).location.href = responseText.RedirectUrl;
        } else {
            if (responseText.Data != null) {
                var str = JSON.stringify(responseText.Data);
                responseText.Data = JSON.parse(str.replace(/\\n/g, "\\n").replace(/\\'/g, "\\'").replace(/\\"/g, '\\"').replace(/\\&/g, "\\&").replace(/\\r/g, "\\r").replace(/\\t/g, "\\t").replace(/\\b/g, "\\b").replace(/\\f/g, "\\f"));
            }
        }
    }

    function getOffsetSum(elem) {
        var top = 0, left = 0;
        while (elem) {
            top = top + parseInt(elem.offsetTop);
            left = left + parseInt(elem.offsetLeft);
            elem = elem.offsetParent;
        }

        return {
            top: top,
            left: left
        };
    }

    function getOffsetRect(elem) {
        var box = elem.getBoundingClientRect();
        var body = document.body;
        var docElem = document.documentElement;
        var scrollTop = window.pageYOffset || docElem.scrollTop || body.scrollTop;
        var scrollLeft = window.pageXOffset || docElem.scrollLeft || body.scrollLeft;
        var clientTop = docElem.clientTop || body.clientTop || 0;
        var clientLeft = docElem.clientLeft || body.clientLeft || 0;
        var top = box.top + scrollTop - clientTop;
        var left = box.left + scrollLeft - clientLeft;
        return {
            top: Math.round(top),
            left: Math.round(left)
        };
    }

    // validator.js의 함수 재정의
    $.validator.format = function (source, params) {
        if (arguments.length === 1) {
            return function () {
                var args = $.makeArray(arguments);
                args.unshift(source);
                return $.validator.format.apply(this, args);
            };
        }
        if (arguments.length > 2 && params.constructor !== Array) {
            params = $.makeArray(arguments).slice(1);
        }
        if (params.constructor !== Array) {
            params = [params];
        }
        $.each(params, function (i, n) {
            source = source.replace(new RegExp("\\{" + i + "\\}", "g"), function () {
                // 수정 사항
                if (typeof (n) == 'string') {
                    if (n.substring(0, 1) == '#') {
                        n = $.trim($(n).val());
                    }
                }
                return n;
            });
        });
        return source;
    };

    // required 기능 추가
    $.validator.addMethod("customrequired", function (value, element, param) {
        var obj = param;
        if (obj.Message != null && obj.Message != '') {
            $.validator.messages["customrequired"] = obj.Message;
        }
        return $.trim(value) != '';
    });

    // afterToday 기능 추가
    // 지정된 날짜가 금일 이후인지 체크하는 유효성 검사기입니다.
    $.validator.addMethod("aftertoday", function (value, element, param) {
        if ($.trim(value) == '') {
            return true;
        }
        var obj = param;
        if (obj.Message != null && obj.Message != '') {
            $.validator.messages["aftertoday"] = obj.Message;
        }
        var startDate = new Date();
        var endDate = BIT.convertToDate($.trim(value));
        if (endDate == null) {
            return true;
        }
        if (obj.IsAllowedToday) {
            return startDate <= endDate;
        } else {
            return startDate < endDate;
        }
    });

    // 문자와 숫자로만 이루어 졌는지 체크하는 유효성 검사기입니다.
    $.validator.addMethod("alphanumeric", function (value, element, param) {
        if ($.trim(value) == '') {
            return true;
        }
        var obj = param;
        if (obj.Message != null && obj.Message != '') {
            $.validator.messages["alphanumeric"] = obj.Message;
        }

        if (!obj.IsAllowedFirstDigit && /^\d+$/.test(value)) {
            return false;
        }
        if (obj.MinRequiredAlphaCharacters > 0 || obj.MinRequiredNumericCharacters > 0) {
            var digitCount = 0;
            var alphaCount = 0;
            for (var i = 0; i < value.length; i++) {
                if (value.charCodeAt(i) >= 48 && value.charCodeAt(i) <= 57) {
                    digitCount++;
                } else if ((value.charCodeAt(i) >= 65 && value.charCodeAt(i) <= 90) || (value.charCodeAt(i) >= 97 && value.charCodeAt(i) <= 122)) {
                    alphaCount++;
                }
            }

            if (digitCount < obj.MinRequiredNumericCharacters || alphaCount < obj.MinRequiredAlphaCharacters) {
                return false;
            }
        }
        return true;
    });

    // 데이터의 형식 검증
    $.validator.addMethod("datatype", function (value, element, param) {
        if ($.trim(value) == '') {
            return true;
        }
        var obj = param;
        if (obj.Message != null && obj.Message != '') {
            $.validator.messages["datatype"] = obj.Message;
        }

        if (obj.DataType == 'Number') {
            return /^-?(?:\d+|\d{1,3}(?:,\d{3})+)?(?:\.\d+)?$/.test($.trim(value));
        } else if (obj.DataType == 'Digits') {
            return /^\d+$/.test($.trim(value));
            // } else if (obj.DataType == 'Integer') {
            // return /^-?(\d+|\d{1,3}(?:,\d{3})+)?(?:\.\d+)?$/.test($.trim(value));
        } else if (obj.DataType == 'Date10') {
            var date = BIT.convertToDate($.trim(value));
            return date != null;
        } else if (obj.DataType == 'Email') {
            return /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/i.test($.trim(value));
        } else if (obj.DataType == 'TelNumber1') {
            return /^(0\d{1,2}-|)\d{3,4}-\d{4}$/.test($.trim(value));
        } else if (obj.DataType == 'Jumin') {
            if ((($.trim(value).length == 13) && /^\d{13}[0-9]*$/.test($.trim(value))) || (($.trim(value).length == 14) && value.substring(6, 7) == "-")) {
                // 14자리일 경우 inputvalue를 13자리 형식으로 변경
                if (($.trim(value).length == 14)) {
                    var valueSplit = value.split('-');

                    if (valueSplit[0].length == 6 && valueSplit[1].length == 7) {
                        value = valueSplit[0] + valueSplit[1];
                    } else {
                        return false;
                    }
                }
                var firstYear = "19";
                if (($.trim(value).substring(6, 7) == "3") || ($.trim(value).substring(6, 71) == "4") || ($.trim(value).substring(6, 7) == "7") || ($.trim(value).substring(6, 7) == "8")) { // 2000년대생
                    firstYear = "20";
                } else if (($.trim(value).substring(6, 7) == "0") || ($.trim(value).substring(6, 7) == "9")) { // 1800년대생
                    firstYear = "18";
                }
                // 숫자여부 체크
                if (/^\d{13}[0-9]*$/.test($.trim(value))) {
                    // date형식 체크
                    var dateType = firstYear + $.trim(value).substring(0, 6);
                    var date = BIT.convertToDate(dateType);
                    if (date != null) {
                        var count = 2;
                        var sum = 0;
                        var compareNum = 0;

                        for (var i = 0; i < $.trim(value).length - 1; i++) {
                            sum += $.trim(value).substring(i, i + 1) * count;
                            count++;
                            if (count > 9) {
                                count = 2;
                            }
                        }
                        compareNum = 11 - (sum % 11);
                        if (compareNum >= 10) {
                            compareNum = compareNum % 10;
                        }
                        // 오류검증코드와 비교
                        if (compareNum == parseInt($.trim(value).substring(12, 13))) {
                            return true;
                        }
                    }
                }
            }
            return false;
        }
    });

    // datecompare 기능 추가
    $.validator.addMethod("datecompare", function (value, element, param) {
        var obj = param;
        var $form = $(element).closest('form');
        var $startDate = $form.find('[name=' + obj.StartPropertyName + ']');
        var $endDate = $form.find('[name=' + obj.EndPropertyName + ']');

        if ($.trim($startDate.val()) == '' || $.trim($endDate.val()) == '') {
            return true;
        }
        if (obj.Message != null && obj.Message != '') {
            $.validator.messages["datecompare"] = obj.Message;
        }
        var startDate = BIT.convertToDate($.trim($startDate.val()));
        var endDate = BIT.convertToDate($.trim($endDate.val()));
        if (startDate == null || endDate == null) {
            return true;
        }
        if (obj.IsAllowedEqual) {
            if (endDate >= startDate) {
                return true;
            } else {
                return false;
            }
        } else {
            if (endDate > startDate) {
                return true;
            } else {
                return false;
            }
        }
    });

    // restrictdate
    $.validator.addMethod("restrictdate", function (value, element, param) {
        var obj = param;
        var $form = $(element).closest('form');
        var $startDate = $form.find('[name=' + obj.StartDatePropertyName + ']');
        var $endDate = $form.find('[name=' + obj.EndDatePropertyName + ']');

        if ($.trim($startDate.val()) == '' || $.trim($endDate.val()) == '') {
            return true;
        }
        if (obj.Message != null && obj.Message != '') {
            $.validator.messages["restrictdate"] = obj.Message;
        }
        var startDate = BIT.convertToDate($.trim($startDate.val()));
        var endDate = BIT.convertToDate($.trim($endDate.val()));
        if (startDate == null || endDate == null) {
            return true;
        }

        switch (obj.RestrictionType) {
            case 'Day': {
                endDate = startDate.addDay(obj.Number);
                break;
            }
            case 'Week': {
                endDate = startDate.addWeek(obj.Number);
                break;
            }
            case 'Month': {
                endDate = startDate.addMonth(obj.Number);
                break;
            }
            case 'Year': {
                endDate = startDate.addYear(obj.Number);
                break;
            }
        }

        if (obj.IsAllowedToday) {
            if (startDate >= endDate) {
                return true;
            } else {
                return false;
            }
        } else {
            if (startDate > endDate) {
                return true;
            } else {
                return false;
            }
        }
    });

    // custommaxlength 기능 추가
    $.validator.addMethod("custommaxlength", function (value, element, param) {
        if ($.trim(value) == '') {
            return true;
        }
        var obj = param;
        if (obj.Message != null && obj.Message != '') {
            $.validator.messages["custommaxlength"] = obj.Message;
        }

        return $.trim(value).length <= obj.Max;
    });

    // customminlength 기능 추가
    $.validator.addMethod("customminlength", function (value, element, param) {
        if ($.trim(value) == '') {
            return true;
        }
        var obj = param;
        if (obj.Message != null && obj.Message != '') {
            $.validator.messages["customminlength"] = obj.Message;
        }

        return $.trim(value).length >= obj.Min;
    });

    // customrangelength 기능 추가
    $.validator.addMethod("customrangelength", function (value, element, param) {
        if ($.trim(value) == '') {
            return true;
        }
        var obj = param;
        if (obj.Message != null && obj.Message != '') {
            $.validator.messages["customrangelength"] = obj.Message;
        }

        return $.trim(value).length >= obj.Min && $.trim(value).length <= obj.Max;
    });

    // maxnumberic 기능 추가
    $.validator.addMethod("maxnumberic", function (value, element, param) {
        if ($.trim(value) == '') {
            return true;
        }
        var obj = param;
        if (obj.Message != null && obj.Message != '') {
            $.validator.messages["maxnumberic"] = obj.Message;
        }

        return $.trim(value) <= obj.Max;
    });

    // minnumberic 기능 추가
    $.validator.addMethod("minnumberic", function (value, element, param) {
        if ($.trim(value) == '') {
            return true;
        }
        var obj = param;
        if (obj.Message != null && obj.Message != '') {
            $.validator.messages["minnumberic"] = obj.Message;
        }

        return $.trim(value) >= obj.Min;
    });

    // rangenumberic 기능 추가
    $.validator.addMethod("rangenumberic", function (value, element, param) {
        if ($.trim(value) == '') {
            return true;
        }
        var obj = param;
        if (obj.Message != null && obj.Message != '') {
            $.validator.messages["rangenumberic"] = obj.Message;
        }

        return $.trim(value) >= obj.Min && $.trim(value) <= obj.Max;
    });

    // stringcompare 기능 추가
    $.validator.addMethod("stringcompare", function (value, element, param) {
        var obj = param;
        var $form = $(element).closest('form');
        var $firstString = $form.find('[name=' + obj.FirstPropertyName + ']');
        var $secondString = $form.find('[name=' + obj.SecondPropertyName + ']');

        if ($.trim($firstString.val()) == '' || $.trim($secondString.val()) == '') {
            return true;
        }
        if (obj.Message != null && obj.Message != '') {
            $.validator.messages["stringcompare"] = obj.Message;
        }

        return $.trim($secondString.val()) == $.trim($firstString.val());

    });

    /*
	 * 현재 클라이언트에서 element의 offset 값을 찾는다.
	 */
    this.getOffset = function (element) {
        if (element.getBoundingClientRect) {
            return getOffsetRect(element);
        } else {
            return getOffsetSum(element);
        }
    };

    // 사용법 : <input id="userId" name="userId" type="text"
    // validate="required:true;dateISO:true;direction:top;" />
    // validate 어트리뷰트에 세미콜론(;)을 구분자로 하여 문자열로 입력함,
    // 배열의 경우range:[1,5] 처럼..입력함
    // script 내에서 BIT.validate($('form'), function(response){}); 호출함
    // 주의 : required attribute가 없는데 계속 유효성 체크를 할 경우
    // jquery.validate.js 의 attributeRules 함수(851행 쯤..)에서
    // $element[0].getAttribute(method); 를 $element.attr(method); 로 변경
    this.validate = function ($form, callbackSuccess, callbackFailure, callbackUploadProgress) {
        $form.validate({
            highlight: function (error, element) {
                if (typeof (element) == 'string') {
                    // validate.js에서 defaultShowErrors() 함수의
                    // this.settings.highlight.call(this, error, error.element,
                    // this.settings.errorClass, this.settings.validClass); 처럼
                    // 변경하여야 함.
                    throw 'validate.js 가 재정의 되지 않았습니다.';
                }
                if ($(element).data('validator-tooltip') != null) {
                    $this.showTooltip($(element), error.message, $(element).data('validator-direction'));
                }
            },
            unhighlight: function (element) {
                $(element).removeClass("validator_error");
                if ($(element).data('validator-tooltip') != null) {
                    $(element).data('validator-tooltip').hide();
                }
            },
            submitHandler: function (form) {
                $(form).ajaxSubmit({
                    dataType: 'json',
                    type: 'post',
                    success: function (response, statusText, xhr) {
                        preProccessSubmit(response, $(form));
                        if (callbackSuccess != null) {
                            callbackSuccess(response, status, xhr);
                        }
                    },
                    uploadProgress: function (event, position, total, percentComplete) {
                        if (callbackUploadProgress != null) {
                            callbackUploadProgress(event, position, total, percentComplete);
                        }
                    },
                    beforeSubmit: function (arr) {
                        for (var i = 0; i < arr.length; i++) {
                            if (arr[i].type == 'file')
                                continue;
                            arr[i].value = $.trim(arr[i].value);
                        }
                    },
                    error: function (xhr, status, errorThrown) {
                        if (callbackFailure != null) {
                            callbackFailure(xhr, status, errorThrown);
                        } else {
                            alert('server error.');
                        }
                    }
                });
                return false;
            },
            invalidHandler: function (form, validator) {
                var error = validator.numberOfInvalids();
                if (error) {
                    for (var i = 0; i < error; i++) {
                        var $el = $(validator.errorList[i].element);
                        var msg = validator.errorList[i].message;
                        if ($el.data('validator-direction') != null) {
                            $this.showTooltip($el, msg, $el.data('validator-direction'));
                        } else {
                            $this.showTooltip($el, msg, 'bottom');
                        }
                    }
                }
                return false;
            }
        });

        var $elements = $form.find("input, select, textarea").not(":submit, :reset, :image, [disabled]");
        $elements.each(function () {
            var str = $(this).attr('data-validate');
            try {
                if (str != null && str.length > 0) {
                    var rules = str.split(';');
                    for (var i = 0; i < rules.length; i++) {
                        var name = $.trim(rules[i].split(':')[0]);
                        var value = rules[i].substring(rules[i].split(':')[0].length + 1); // 2014-12-04 변경
                        var args = {};
                        if (name == 'direction') { // 툴팁의 방향 top or bottom
                            $(this).data('validator-direction', value);
                            continue;
                        } else if (name == '') {
                            continue;
                        }
                        if (value == 'true') {
                            value = true;
                        } else if (value == 'false') {
                            value = false;
                        } else if (value.substring(0, 1) == '[') { // 배열
                            value = JSON.parse(value);
                        } else if (value.substring(0, 1) == '{') { // Object
                            // '를 "로 변경한다.
                            value = JSON.parse(value.replace(/\'/g, '"'));
                        }
                        args[name] = value;
                        $(this).rules('add', args);
                    }
                }
            } catch (e) {
                alert(e.message);
            }
        });
    };

    // tooltip
    // 사용법 : BIT.showTooltip($el, msg, 'bottom');
    this.showTooltip = function ($element, message, direction) {
        var offset = $this.getOffset($element[0]);
        console.log('top : ' + offset.top + ', left : ' + offset.left);
        var $tooltip = {};
        if ($element.data('validator-tooltip') == null) {
            if (direction == 'top') {
                $tooltip = $('<div class="validator_t_wrap"><div class="validator_tooltips"><div class="validator_tt_ttbl"><table class="validator_tt_tbl" style="border-collapse:collapse;border:none"><tr><td class="validator_tt_tl"></td><td colspan="2" class="validator_tt_ct"></td><td class="validator_tt_tr"></td></tr><tr><td class="validator_tt_ml"></td><td class="validator_tt_mc"><!-- 내용 --><div class="validator_tt_cnt">' + message + '</div></td><td class="validator_tt_mc"><!-- 닫기 버튼 --><div class="validator_tt_btn"><span class="validator_btn_ttclose"><span>close</span></span></div></td><td class="validator_tt_mr"></td></tr><tr><td class="validator_tt_bl"></td><td colspan="2" class="validator_tt_cb"></td><td class="validator_tt_br"></td></tr></table></div><div class="validator_tt_btm"></div></div></div>');
                $tooltip.css('left', offset.left + 10);
                $tooltip.css('top', offset.top - 40 + 5);
                $(document.body).append($tooltip);
            } else {
                $tooltip = $('<div class="validator_t_wrap"><div class="validator_tooltips_b"><div class="validator_tt_top"></div><div class="validator_tt_btbl"><table class="validator_tt_tbl" style="border-collapse:collapse;border:none"><tr><td class="validator_tt_tl"></td><td colspan="2" class="validator_tt_ct"></td><td class="validator_tt_tr"></td></tr><tr><td class="validator_tt_ml"></td><td class="validator_tt_mc"><!-- 내용 --><div class="validator_tt_cnt">' + message + '</div></td><td class="validator_tt_mc"><!-- 닫기 버튼 --><div class="validator_tt_btn"><span class="validator_btn_ttclose"><span>close</span></span></div></td><td class="validator_tt_mr"></td></tr><tr><td class="validator_tt_bl"></td><td colspan="2" class="validator_tt_cb"></td><td class="validator_tt_br"></td></tr></table></div></div></div>');
                $tooltip.css('left', offset.left + 10);
                $tooltip.css('top', offset.top + $element.height() - 5);
                $(document.body).append($tooltip);
            }
            $tooltip.data('message', message);
            $element.data('validator-tooltip', $tooltip);
            $('.validator_btn_ttclose', $tooltip).on('click', function () {
                $tooltip.hide();
            });
        } else {
            $tooltip = $element.data('validator-tooltip');
            if ($element.data('validator-tooltip').data('message') == message) {
                $element.data('validator-tooltip').show();
            } else {
                $element.data('validator-tooltip').remove();
                $element.data('validator-tooltip', null);
                $this.showTooltip($element, message, direction);
            }
        }
        return $tooltip;
    };

    // ajax 호출 함수
    // 사용법 : callAjax('Services/GetFirstAddress.aspx', 'POST', {}, function
    // (responseText) { do something..});
    this.callAjax = function (url, type, data, callbackSuccess, callbackFailure) {
        $.ajax({
            url: url,
            type: type,
            data: data,
            dataType: 'json',
            success: function (response, status, xhr) {
                preProccessSubmit(response);
                if (callbackSuccess != null) {
                    callbackSuccess(response, status, xhr);
                }
            },
            error: function (xhr, status, errorThrown) {
                if (callbackFailure != null) {
                    callbackFailure(xhr, status, errorThrown);
                } else {
                    alert('server error.');
                }
            }
        });
    };

    // 동기 호출 함수
    // 사용법 : callSjax('Services/GetFirstAddress.aspx', 'POST', {}, function
    // (responseText) { do something..});
    this.callSjax = function (url, type, data, callbackSuccess, callbackFailure) {
        $.ajax({
            url: url,
            type: type,
            data: data,
            async: false,
            dataType: 'json',
            success: function (response, status, xhr) {
                preProccessSubmit(response);
                if (callbackSuccess != null) {
                    callbackSuccess(response, status, xhr);
                }
            },
            error: function (xhr, status, errorThrown) {
                if (callbackFailure != null) {
                    callbackFailure(xhr, status, errorThrown);
                } else {
                    alert('server error.');
                }
            }
        });
    };

    this.submit = function ($form, callbackSuccess, callbackUploadProgress, callbackFailure) {
        $form.ajaxSubmit({
            dataType: 'json',
            success: function (response, statusText, xhr) {
                preProccessSubmit(response, $form);
                if (callbackSuccess != null) {
                    callbackSuccess(response, status, xhr);
                }
            },
            beforeSubmit: function (arr, $form, options) {
                for (var i = 0; i < arr.length; i++) {
                    if (arr[i].type == 'file')
                        continue;
                    arr[i].value = $.trim(arr[i].value);
                }
            },
            uploadProgress: function (event, position, total, percentComplete) {
                if (callbackUploadProgress != null) {
                    callbackUploadProgress(event, position, total, percentComplete);
                }
            },
            error: function (xhr, status, errorThrown) {
                if (callbackFailure != null) {
                    callbackFailure(xhr, status, errorThrown);
                } else {
                    alert('server error.');
                }
            }
        });
        return false;
    };

    /*
	 * BITCommon.js 가 아닌 외부의 submit으로 json 결과를 받은 후 preProccessSubmit 함수를 태우고자 할경우에만 쓴다.
	 */
    this.afterSubmitProccess = function (responseText, $form) {
        preProccessSubmit(responseText, $form);
    };

    /*
	 * 모달 다이얼로그
	 */
    this.modal = function (text, title, callbackClose) {
        var parent = getParent(window);
        var $div = parent.$('<div></div>');
        var $dialog = $div.html('<SPAN class=field-validation-error >' + text + '</span>');
        $dialog.dialog({
            autoOpen: true,
            title: title,
            resizable: false,
            modal: true,
            close: function (event, ui) {
                if (callbackClose != null) {
                    callbackClose(event, ui);
                }
            },
            buttons: {
                "Ok": function () {
                    $dialog.dialog("close");
                }
            }
        });
        $dialog.dialog('open');
        $div.parent().addClass('modal');
        return $dialog;
    };

    /*
	 * 컨펌 다이얼로그
	 */
    this.confirmUI = function (text, title, callbackOkClose, callbackCancelClose) {
        var parent = getParent(window);
        var $div = parent.$('<div></div>');
        var $dialog = $div.html('<SPAN class=field-validation-error >' + text + '</span>').dialog({
            autoOpen: true,
            title: title,
            resizable: false,
            modal: true,
            buttons: {
                "Ok": function () {
                    parent.$(this).dialog("close");
                    if (callbackOkClose != null) {
                        callbackOkClose();
                    }
                },
                "Cancel": function () {
                    parent.$(this).dialog("close");
                    if (callbackCancelClose != null) {
                        callbackCancelClose();
                    }
                }
            }
        });
        $dialog.dialog('open');
        $div.parent().addClass('modal');
    };

    this.messages = {};

    /*
	 * {0}{1} 형식의 포맷화된 문자열을 값을 채워 반환합니다.
	 */
    this.getMessage = function (text, params) {
        var theregex = /\$?\{(\d+)\}/g;
        text = $.format(text.replace(theregex, "{$1}"), params);
        return text;
    };

    // list 데이터를 그리드 형태로 바인딩합니다
    this.bindListData = function (listData, options) {
        var defaults = {
            prefix: '',
            $parent: '',
            $templete: null, // 필수 입력 사항입니다. 일반적인 table의 경우 tbody내부의 tr 한개...
            $container: null            // 필수 입력 사항입니다. 일반적인 table의 경우 tbody
        };
        var opts = $.extend({}, defaults, options);
        if (opts.$templete == null || opts.$templete.length == 0) {
            alert('템플릿의 기준이 될 selector를 입력 하십시오.');
            return false;
        }
        if (opts.$container == null || opts.$container.length == 0) {
            alert('데이터를 바인딩 할 container selector를 입력 하십시오.');
            return false;
        }

        var $item = $(opts.$templete[0].outerHTML); // 기준 템플릿을 하나 복사한다.
        opts.$container.empty();

        for (var i = 0; i < listData.length; i++) {
            BIT.bindObjectData(listData[i], {
                prefix: opts.prefix,
                $parent: $item
            });
            opts.$container.append($item[0].outerHTML);
        }
    };

    /*
	 * object 형식의 데이터를 html 컨트롤에 바인딩합니다. 특정 요소의 자식컨트롤에 바인딩 하기 위해서는 $parent 에 값을 넣으세요
	 */
    this.bindObjectData = function (data, options) {
        var defaults = {
            prefix: '',
            $parent: ''
        };
        var opts = $.extend({}, defaults, options);
        $.each(data, function (index, value) {
            var $obj = null;
            if (opts.$parent == '') {
                $obj = $('[name=' + (opts.prefix != '' ? opts.prefix + '_' : '') + index + ']');
            } else {
                $obj = opts.$parent.find('[name=' + (opts.prefix != '' ? opts.prefix + '_' : '') + index + ']');
            }
            if ($obj.length == 0) {
                if (opts.$parent == '') {
                    $obj = $('#' + (opts.prefix != '' ? opts.prefix + '_' : '') + index);
                } else {
                    $obj = opts.$parent.find('#' + (opts.prefix != '' ? opts.prefix + '_' : '') + index);
                }
            }
            if ($obj.length > 0) {
                if ($obj.is(':radio')) {
                    $obj.each(function () {
                        if ($(this).val() == value) {
                            $(this)[0].checked = true;
                        }
                    });
                } else if ($obj.is(':checkbox')) {
                    if ($obj.length) {
                        if (value.toLowerCase() == 'true') {
                            $obj[0].checked = true;
                        } else {
                            $obj[0].checked = false;
                        }
                    } else {
                    }
                } else if ($obj.is('input, select, textarea')) {
                    $obj.val(value);
                } else if ($obj.is('img')) {
                    $obj.attr('src', '/uploadFiles' + value);
                } else if ($obj.is('span')) {
                    $obj.html(BIT.changeBr(value));
                } else if ($obj.is('td')) {
                    $obj.html(BIT.changeBr(value));
                }
            }
        });
    };

    /*
	 * 문자열을 Date 형식으로 바꿉니다. 입력 매개변수의 포맷은 yyyyMMdd 또는 yyyy-MM-dd 또는 yyyy-MM-dd HH:mm:ss
	 */
    this.convertToDate = function (data) {
        var date = null;
        var y = null;
        var m = null;
        var d = null;
        ;
        var arrDate;
        if (typeof (data) == 'string') {
            try {
                if (data.length == 8) {
                    y = data.substring(0, 4);
                    m = parseInt(data.substring(4, 6)) - 1;
                    d = data.substring(6);
                    date = new Date(y, m, d);
                }
                if (data.length == 10) {
                    if (data.indexOf('-') > 0) {
                        arrDate = data.split('-');
                        y = arrDate[0];
                        m = parseInt(arrDate[1]) - 1;
                        d = arrDate[2];
                    } else if (data.indexOf('/') > 0) {
                        arrDate = data.split('/');
                        y = arrDate[2];
                        m = parseInt(arrDate[0]) - 1;
                        d = arrDate[1];
                    } else {
                        return null;
                    }
                    date = new Date(y, m, d);
                } else if (data.length == 19) {
                    arrDate = data.split('-');
                    var arrTime = arrDate[2].substring(3).split(':');
                    date = new Date(arrDate[0], arrDate[1] - 1, arrDate[2].substring(0, 2), arrTime[0], arrTime[1], arrTime[2]);
                }
                if (y == date.getFullYear() && m == date.getMonth() && d == date.getDate()) {
                    return date;
                }
            } catch (e) {
                return null;
            }
        }
        return null;
    };

    /*
	 * c#의 날자 형식을 Date 형식으로 바꿉니다. 입력 매개변수의 포맷은 /Date(1323010800000)/
	 */
    this.convertDateFromCSharpDate = function (data) {
        if (data.length != 21) {
            throw 'Invalid data';
        }
        return new Date(parseInt(data.substring(6, data.length - 2)));
    };

    // 1. 팝업에서.. body를 <div id="divContainer" style="width: 100%; overflow:hidden; padding: 0px 0px 15px 0px;">로 감싼후 
    //  $('#'+$.getUrlVar('containerId') ).height($('#divContainer').height()); 
    //  그리고 모달의 데이터를 부모 윈도우로 넘기기 위한 <input type="hidden" id="_HiddenData" /> 생성 
    // 2. 모달 호출 
    //$('#btn').click(function () {
    //    var options = {
    //        url: '/test.aspx',
    //        width: 455,
    //        height: 240,
    //        closeCallback: closeCallback,
    //        title: '비고',
    //        data: {},
    //        buttonType: 3
    //    };
    //    var $dialog = BIT.modalDialog(options);
    //    function closeCallback(returnValue) {
    //        if (returnValue != null) {
    //            callback(returnValue);
    //        }
    //    }
    //});
    //iframe에서 데이터는 queryString으로 받는다. 
    //3. 모달에서 데이터를 메인으로 전달 하기 위해서는 $('#_HiddenData').val(JSON.stringify(object)); 
    //후 4번 처럼 프로그램적으로 모달을 닫는다. 
    //4. 프로그램적으로 모달을 닫기 위해서는 BIT.modalDialogCloseClick('modalClose'); 함수를 호출한다.
    //
    //Iframe 설정이 options 에서 false 인 경우에는 한페이지에 랜더되므로 2번을 제외한 모든 설정은 무시한다.
    // 모달에서 부모페이지에서 넘김 값에 접근하는 방법은 
    // var fileOptions = $('#fileupload').closest('div[id^=cntr]').data('options');
    // 모달에서 부모페이지로 데이터를 전달 하는 방법은..
    // $(this).closest('.modalContainer').data('data', newFiles);

    this.modalDialog = function (options) {
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

        var dt = new Date().getTime();
        var opts = $.extend({}, defaults, options);
        opts.data.containerId = 'cntr_' + dt.toString();
        opts.url = opts.url + '?' + $(opts.data).convertQueryStrings();

        var parent = getParent(window);
        var $div = parent.$('<div id="parent_' + dt.toString() + '"></div>');
        var $container = null;
        if (opts.iframe) {
            $container = $('<iframe  id="cntr_' + dt.toString() + '" class="modalContainer" frameborder="0" width="100%" height="100%" marginheight="0" marginwidth="0" scrolling="no" src=""/>');
        } else {
            $container = $('<div id="cntr_' + dt.toString() + '"  class="modalContainer" style="overflow-x:none; overflow-y:auto;width:100%; padding:0 0 0 0;" />');
        }

        if (opts.buttonType == 0) { // 하단 버튼을 자동으로 생성하지 않는다.
//            $div.append($container).append('<div style="width:100%;text-align:center; padding:10px 0 0 0;"><p name="modalClose" class="btn_close" style="width:86px;display:none;"><span>' + $this.messages.common_modal_close + '</span></p>  <p name="modalApply" style="width:86px;display:none;" class="btn_close" ><span>' + $this.messages.common_modal_apply + '</span></p></div>');
            $div.append($container).append('<div style="width:100%;text-align:center; padding:10px 0 0 0;"><p name="modalClose" class="btn_close" style="width:86px;display:none;"><span>' + $this.messages.common_modal_close + '</span></p>  <p name="modalApply" style="width:86px;display:none;" class="btn_close" ><span>' + $this.messages.common_modal_apply + '</span></p></div>');
        } else if (opts.buttonType == 1) {
            $div.append($container).append('<div style="width:100%;text-align:center; padding:10px 0 0 0;"><p name="modalClose" class="btn_close" style="width:86px;"><span>' + $this.messages.common_modal_close + '</span></p>  <p name="modalApply" style="width:86px;display:none;" class="btn_close" ><span>' + $this.messages.common_modal_apply + '</span></p></div>');
        } else if (opts.buttonType == 2) {
            $container.css('height', '78%');
            $div.append($container).append('<div style="width:100%;text-align:center; padding:0px 0 0 0;"><p name="modalClose" class="btn_close" style="width:86px;display:none;"><span>' + $this.messages.common_modal_close + '</span></p>	<div class="tm_setBtn"><button name="modalApply" class="tm_btn02 tm_type02 tm_fixWid"><span><span>저장</span></span></button></div></div>');
        } else { // 비동기 방식
            $div.append($container).append('<div style="width:100%;text-align:center; padding:10px 0 0 0;"><p name="modalClose" class="btn_close" style="width:86px;"><span>' + $this.messages.common_modal_close + '</span></p>  <p name="modalApply" style="width:86px;display:none;" class="btn_close" ><span>' + $this.messages.common_modal_apply + '</span></p><p name="modalAsyncApply" style="width:86px;" class="btn_close" style="display:none" ><span>' + $this.messages.common_modal_apply + '</span></p></div>');
        }

        function convertHeightToIntFromPercent(percent) {
            if (!Number(percent) && percent.substring(percent.length - 1) == '%') {
                return $('body').height() * 0.01 * parseInt(percent.substring(0, percent.length - 1));
            } else {
                return percent;
            }
        }

        var $dialog = $div.dialog({
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

        function closeModal() {
            $dialog.dialog('close');

            // $iframe.contents().find('#div_close').trigger('click', opts);

            // 모달에서 더이상 사용하지 않는 레이어이다.
            // iframe에서 호출 할 경우에는 이게 아닌걸 찾아야 한다.
            $('.modal').addClass('modal_garbage');

            try {
                $('.modal_garbage').remove();
            } catch (e) {
                console.log(e.message);
            }
        }

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

        // 닫기 버튼(우상단X)
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
        return $dialog;
    };

    /*
	 * 모달을 닫기 위해서는 이 함수를 호출 한다. buttonName의 경우 modalClose, modalApply, modalAsyncApply(buttonType이 3일경우) 셋중에 하나여야 한다. iframe을 사용하지 않는 다면 containerId 값은 필수이다.
	 */
    this.modalDialogCloseClick = function (buttonName, containerId) {
        var div = {};
        if ($.getUrlVar('containerId') != '' && $.getUrlVar('containerId') != null) {
            containerId = $.getUrlVar('containerId');
            div = $(parent.document).find('#' + containerId).parent()[0];
            $('p[name=' + buttonName + ']', $div).trigger('click');
        } else {
            if (!containerId) {
                alert('containerId를 입력하세요.');
            } else {
                div = $(parent.document).find('#' + containerId).parent()[0];
                $('p[name=' + buttonName + ']', div).trigger('click');
            }
        }
    };

    /*
	 * 파일 사이즈 변경
	 */
    this.formatFileSize = function (bytes) {
        if (typeof bytes !== 'number') {
            try {
                bytes = parseInt(bytes);
            } catch (e) {
                return '';
            }
        }
        if (bytes >= 1000000000) {
            return (bytes / 1000000000).toFixed(2) + ' GB';
        }
        if (bytes >= 1000000) {
            return (bytes / 1000000).toFixed(2) + ' MB';
        }
        return (bytes / 1000).toFixed(2) + ' KB';
    };

    this.changeBr = function (str) {
        if (str == null || str == '')
            return '';
        return str.replace(/\n/g, "<br/>");
    };

    /*
	 * 이미지 뷰어 jquery.blockUI.js jquery.imageView.js 필요 http://4coder.info/en/
	 */
    this.showImage = function (imageFilePath, imageWidth, imageHeight) {
        var $div = $('<div style="display:none"></div>');
        var image = new Image();
        var isLoaded = false;

        $(image).load(function () {
            if (isLoaded)
                return;
            isLoaded = true;

            var $img = $(image);

            $div.empty().append($img);
            var parent = getParent(window);

            var parentWidth = parent.document.documentElement.clientWidth || parent.document.body.clientWidth;
            var parentHeight = parent.document.documentElement.clientHeight || parent.document.body.clientHeight;

            var widthRatio = 100;
            var heightRatio = 100;

            if (imageWidth < parentWidth - 200) {
                // widthRatio = file.Width / parentWidth * 100;
            } else {
                widthRatio = (parentWidth - 200) / imageWidth * 100;
            }
            if (imageHeight < parentHeight - 100) {
                // heightRatio = file.Height / parentHeight *
                // 100;
            } else {
                heightRatio = (parentHeight - 100) / imageHeight * 100;
            }

            var ratio = Math.min(widthRatio, heightRatio);
            var imgWidth = parseInt(imageWidth * ratio * 0.01);
            var imgHeight = parseInt(imageHeight * ratio * 0.01);
            $img.attr('width', imgWidth);
            $img.attr('height', imgHeight);

            $div.imageView({
                width: imgWidth,
                height: imgHeight,
                useSource: true,
                fullWidth: imageWidth,
                fullHeight: imageHeight
            });

            window.parent.$.blockUI({
                message: $div,
                css: {
                    width: imgWidth + 'px',
                    height: imgHeight + 'px',
                    top: ((parentHeight - imgHeight) / 2) + 'px',
                    left: ((parentWidth - imgWidth) / 2) + 'px'
                },
                onOverlayClick: parent.$.unblockUI
            });
        }).error(function () {
            BIT.modal('Not found image file!', BIT.messages.common_info_title);
        }).attr('src', imageFilePath + "?" + new Date().getTime());
    };

    /*
	 * 언어별 Today
	 */
    this.getTodayDate = function () {
        if (!BIT.messages.common_language || BIT.messages.common_language == 'ko') {
            return $.format.date(new Date(), 'yyyy-MM-dd');
        } else {
            return $.format.date(new Date(), 'MM/dd/yyyy');
        }
    };

    // 주어진 url 에서 주어진 매개변수가 있으면 value를 교체하고 없으면 추가한다.
    this.convertParameter = function (url, param, value) {
        if ($.trim(url) == '') {
            return '';
        }
        var onlyUrl = '';
        var arr1 = url.split('?');
        var queryString = '';
        if (arr1.length = 2) {
            onlyUrl = arr1[0] + '?';
            queryString = arr1[1];
        } else {
            queryString = url;
        }
        var arr = queryString.split('&');
        var obj = {};
        var contains = false;
        for (var i = 0; i < arr.length; i++) {
            var kvArray = arr[i].split('=');
            if (kvArray[0] == param) {
                obj[kvArray[0]] = value;
                contains = true;
            } else {
                obj[kvArray[0]] = kvArray[1];
            }
        }
        if (!contains) {
            obj[param] = value;
        }

        return onlyUrl + $(obj).convertQueryStrings();
    };

    /*
	 * 동적으로 function을 호출 합니다.
	 */
    this.callFunction = function (functionName, param1, param2, param3, param4, param5, param6, param7, param8) {
        var func = window[functionName];
        if (func != null) {
            func.call(this, param1, param2, param3, param4, param5, param6, param7, param8);
        }
    };
};

this.BIT = new BitCommonClass();

// 숫자 및 (-) 만 입력 가능
function onlyInt(event) {
    if (event.keyCode && ((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode != 45))) {
        event.preventDefault();
    }
}

// 숫자만 입력 가능
function onlyUint(event) {
    if (event.keyCode && (event.keyCode < 48 || event.keyCode > 57)) {
        event.preventDefault();
    }
}

// 점도 입력가능
function onlyFloat(event) {
    if (event.keyCode && ((event.keyCode < 48 || event.keyCode > 57) && (event.keyCode != 45 && event.keyCode != 46))) {
        event.preventDefault();
    }
}

// 영문소문자와 숫자만 가능
function onlyEngNumber(event) {
    if (!(event.keyCode && ((event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 65 && event.keyCode <= 90) || (event.keyCode >= 97 && event.keyCode <= 122)))) {
        event.preventDefault();
    }
}

$(function () {
    $.ajaxSetup({
        cache: false
    });

    $('.float').css('ime-mode', 'disabled');
    $('.float').on('keypress', function (event) {
        onlyFloat(event);
    });

    // 숫자만 입력 가능하다..
    $('.uint').css('ime-mode', 'disabled');
    $('.uint').on('keypress', function (event) {
        onlyUint(event);
    });

    $('.int').css('ime-mode', 'disabled');
    $('.int').on('keypress', function (event) {
        onlyInt(event);
    });

    // 영문 및 숫자만 입력 가능하다..
    $('.engnum').css('ime-mode', 'disabled');
    $('.engnum').on('keypress', function (event) {
        onlyEngNumber(event);
    });
});