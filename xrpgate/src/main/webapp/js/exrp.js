var asksVolume = 0,bidsVolume = 0,spreadVolume = 0;
var asksHigh = 0,bidsHigh = 0, spreadHigh =0;
/**
 * 회원가입관련
 */
var _register_ripple_address = "";
var _register_ripple_address_check = false;
var _register_id_check = false;
var _register_password_check = false;
var _register_email_check = false;
var _register_phone_check = false;
var _register_certification = false;
var _register_accessterms = false;

var exrp = {
	
	getTimeAdd:function(dnum){
		var txOffSet = 0;
	    var now = new Date();
	    var tz = now.getTime() + (now.getTimezoneOffset() * 60000) + (txOffSet * 3600000);
	    now.setTime(tz);
	    var time = exrp.leadingZeros(now.getHours(), 2) + ':' +  exrp.leadingZeros(now.getMinutes(), 2) ;
	    var arr_time = time.split(/[^0-9]/); 
	    var Qdate = new Date(now.getYear()+"-"+now.getMonth()+"-"+now.getDate()+" "+arr_time[0]+":"+arr_time[1]);
	    var Adate = Qdate.getTime() + 60 * 60 * dnum *1000;
	    Qdate.setTime(Adate);
	    var s =  exrp.leadingZeros(now.getFullYear(), 4) + '-' +
        			exrp.leadingZeros(now.getMonth() + 1, 2) + '-' +
        			exrp.leadingZeros(now.getDate(), 2)+ ' ' +
        			(parseInt(Qdate.getHours()+100,10)+"").substring(1,3)+ ":" +
        			(parseInt(Qdate.getMinutes()+100,10)+"").substring(1,3)+ ":" +
      	          	exrp.leadingZeros(now.getSeconds(), 2);
	    return  s;
	}
	,getWorldDate:function (txOffSet, dayDiff) {
	      var now = new Date();
	      var tz = now.getTime() + (now.getTimezoneOffset() * 60000) + (txOffSet * 3600000);
	      now.setTime(tz);
	      now.setDate(now.getDate() + dayDiff);

	      var s =
	          exrp.leadingZeros(now.getFullYear(), 4) + '-' +
	          exrp.leadingZeros(now.getMonth()+1, 2) + '-' +
	          exrp.leadingZeros(now.getDate(), 2)+ ' ' +

	          exrp.leadingZeros(now.getHours(), 2) + ':' +
	          exrp.leadingZeros(now.getMinutes(), 2) + ':' +
	          exrp.leadingZeros(now.getSeconds(), 2);
/*alert(s)*/
	      return s;
	},
	KoreaTimeFromWorldTime:function (dtTime) {
        var now = new Date(dtTime);
        var tz = now.getTime() + (now.getTimezoneOffset() * 60000) + (9 * 3600000);
        now.setTime(tz);

        var s =
        exrp.leadingZeros(now.getMonth() + 1, 2) + '-' +
        exrp.leadingZeros(now.getDate(), 2) + ' ' +
        exrp.leadingZeros(now.getHours(), 2) + ':00';

        return s;
    },
    KoreaTimeFromWorldTime2: function (dtTime, option) {
        var now = new Date(dtTime);
        var tz = now.getTime() + (now.getTimezoneOffset() * 60000) + (9 * 3600000);
        now.setTime(tz);
		var s = '';
		if(option == '1') {
			 s =
				 exrp.leadingZeros(now.getMonth() + 1, 2) + '-' +
				 exrp.leadingZeros(now.getDate(), 2) + '-' +
				 exrp.leadingZeros(now.getHours(), 2) + ' ' +		

				 exrp.leadingZeros(now.getHours(), 2) + ':' +
				 exrp.leadingZeros(now.getMinutes(), 2) + ':' +
				 exrp.leadingZeros(now.getSeconds(), 2);
		}else{
			s= exrp.leadingZeros(now.getHours(), 2) + ':' +
			exrp.leadingZeros(now.getMinutes(), 2) + ':' +
			exrp.leadingZeros(now.getSeconds(), 2);
		}
        return s;
    },
    leadingZeros:function (n, digits) {
        var zero = '';
        n = n.toString();

        if (n.length < digits) {
            for (var i = 0; i < digits - n.length; i++)
                zero += '0';
        }
        return zero + n;
    },
    r8: function r8(n,digits){
    	var tt = Math.floor(n*100)/100;

    	return tt;
    },
    r8round: function(n, pos) {
    	var digits = Math.pow(10, pos);

    	var sign = 1;
    	if (n < 0) {
    		sign = -1;
    	}

    	// 음수이면 양수처리후 반올림 한 후 다시 음수처리
    	n = n * sign;
    	var num = Math.round(n * digits) / digits;
    	num = num * sign;

    	return num.toFixed(pos);
    },
    
    GetRippleChartData:function() {
    	
        var address = "https://api.ripplecharts.com/api/offers_exercised";

        var dtNow = exrp.getWorldDate(0, 0);
        var dtNowDiff5 = exrp.getWorldDate(0, -5);
        var dtNowDiff1 = exrp.getWorldDate(0, -1);
        var dtNowDiff2 = exrp.getWorldDate(0, -2);
    
        var gapClose = 0;
        var send_opts = { //JSON Format 생성
            base: { currency: "XRP" },
            counter: { currency: "KRW", issuer: "rPxU6acYni7FcXzPCMeaPSwKcuS2GTtNVN" },
            startTime: dtNowDiff1,//"2015-02-16",
            endTime: dtNow,//"2015-02-17",
            descending:true,
            timeIncrement: "hour",
            timeMultiple: 1,
            format: "json"
        };

        var request_register = $.ajax({
            type: "POST",
            url: address, 
            data: JSON.stringify(send_opts),
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        });

        request_register.success(function (done) {      //등록성공
            var _offersData = JSON.stringify(done);
            var receiveData = JSON.parse(_offersData);

            var len = receiveData["results"].length;
			var high = 0 , low = 10;
			var current = 0;
			var count = 0;
			var close = 0;
			var baseVolume = 0;
			var counterVolume=0;
		//document.write(	_offersData );
           
			//if(len > 0){	
			for(var i = 0 ; i < len; i++){
            	//gapClose = exrp.r8(receiveData["results"][i].close,2);
           // alert('current:' + current)
            	//현재가 
            	//current = parseFloat(receiveData["results"][len-1].close).toFixed(4);
            	//$("#closeVolume").html(current);
            	//$("#currentVolume").html(current);
            	
            	//최고가 
            	if(receiveData["results"][i].high != undefined){
            		if(high < receiveData["results"][i].high)
                       	high = receiveData["results"][i].high;
            	}
            	           	
            	//최저가
            	if(receiveData["results"][i].low != undefined){
            		if(low > receiveData["results"][i].low)
                       	low = receiveData["results"][i].low;
            	}else{
            		low = 0;
            	}
            
            	//거래량            	
            	if(receiveData["results"][i].baseVolume != undefined)
            		count += parseFloat(receiveData["results"][i].count);           	
            	
            	
            	//총거래량 XRP            	
            	if(receiveData["results"][i].baseVolume != undefined)
            		//alert(receiveData["results"][i].baseVolume)
            		baseVolume += receiveData["results"][i].baseVolume;
             
				
				//총거래량 ripple
				if(receiveData["results"][i].counterVolume != undefined){
					//alert(receiveData["results"][i].counterVolume)
					counterVolume += receiveData["results"][i].counterVolume;
				}
           }

			$("#highVolume").html(parseFloat(high).toFixed(4));//최고가
			
			if($("#highVolume2") != undefined)
				$("#highVolume2").html(parseFloat(high).toFixed(4));
			if(low == 10000) low = 0;
			$("#lowVolume").html(parseFloat(low).toFixed(4)); //최저가
			if($("#lowVolume2") != undefined){
				$("#lowVolume2").html(parseFloat(low).toFixed(4));
				//alert("lowVolume2:"+ $("#lowVolume2").html())
			}
			//$("#current").html(exrp.commify(count)); //거래량

			baseVolume = exrp.commify(parseFloat(baseVolume).toFixed(4));
			$("#baseVolume").html(baseVolume); //총거래량
			//alert("total base:" + baseVolume)
			counterVolume = exrp.commify(parseFloat(counterVolume).toFixed(4));
			$("#counterVolume").html(counterVolume); //총거래량 ripple
			$("#current").html(baseVolume); //총거래량 ripple
			if($("#currentVolume2") != undefined)
				$("#currentVolume2").html(baseVolume)
			//alert("couter base:" + counterVolume)
			//Data Input START
			if($("#HIGH_VOLUME") != undefined)
				$("#HIGH_VOLUME").val(parseFloat(high).toFixed(4));
			if($("#LOW_VOLUME") != undefined)
				$("#LOW_VOLUME").val(parseFloat(low).toFixed(4));			
			if($("#BASE_VOLUME") != undefined)
				$("#BASE_VOLUME").val(baseVolume);
			if($("#COUNTER_VOLUME") != undefined)
				$("#COUNTER_VOLUME").val(counterVolume);
			if($("#CURRENT") != undefined)
				$("#CURRENT").val(baseVolume);
        });

        request_register.error(function (done) {              //등록실패 JSon Format error, -1, false 리턴  
            //alert("Data Failed");
        });
        
        var send_opts = { //JSON Format 생성
                base: { currency: "XRP" },
                counter: { currency: "KRW", issuer: "rPxU6acYni7FcXzPCMeaPSwKcuS2GTtNVN" },
                startTime: dtNowDiff2,  //"2015-02-16",
                endTime: dtNowDiff1,    //"2015-02-17",
                timeIncrement: "day",
                format: "json"
            };

            var request_register2 = $.ajax({
                type: "POST",
                url: address, 
                data: JSON.stringify(send_opts),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            });
            
            request_register2.success(function (done) {      //등록성공
                var _offersData = JSON.stringify(done);
                var receiveData = JSON.parse(_offersData);

                var len = receiveData["results"].length;
    			///alert(_offersData);
                for (var i = 0; i < len; i++) {
    				
                    //result_data.startTime.push(receiveData["results"][i].startTime);
                   // result_data.close.push(receiveData["results"][i].close);
                   // result_data.baseVolume.push(receiveData["results"][i].baseVolume);
    				//alert($("#currentVolume").html());
                	gapClose = $("#closeVolume").html() - exrp.r8(receiveData["results"][i].close,2);
                	
                	$("#gapCloseVolume").html(exrp.r8round(gapClose,2));
                	$("#gapClosePercent").html(exrp.r8round(gapClose*10,2));
                	
                	//Data Input
                	if($("#GAP_CLOSE_VOLUME") != undefined)
        				$("#GAP_CLOSE_VOLUME").val(exrp.r8round(gapClose,2));
                	if($("#GAP_CLOSE_PERCENT") != undefined)
        				$("#GAP_CLOSE_PERCENT").val(exrp.r8round(gapClose*10,2));
                }
                
                //Data Insert
                var form = $("#RippleCurrentForm");
                $(form).attr({method:"post",action:"/exrp/home/setRippleChartData.do"});
				common.ajaxSubmit({form:form,paramType:"text",action:function(data){
					try{data = jQuery.parseJSON(data);}catch (e) {data = 0;}
					var cnt = parseInt(data);
					
					/* if(cnt > 0){
						alert('성공');
					}else{						
						alert('실패');
					}*/
				}});
            });

            request_register2.error(function (done) {              //등록실패 JSon Format error, -1, false 리턴  
               // alert("Data Failed");
            });
    },

    GetRippleChartSubData:function() {
    	
        var address = "https://api.ripplecharts.com/api/offers_exercised";

        var dtNow = exrp.getWorldDate(0, 0);
        var dtNowDiff5 = exrp.getWorldDate(0, -5);
        var dtNowDiff1 = exrp.getWorldDate(0, -1);
		var dtNowDiff2 = exrp.getWorldDate(0, -2);
		var gapClose = 0;
        var send_opts = { //JSON Format 생성
            base: { currency: "XRP" },
            counter: { currency: "KRW", issuer: "rPxU6acYni7FcXzPCMeaPSwKcuS2GTtNVN" },
            startTime: dtNowDiff1,  //"2015-02-16",
            endTime: dtNow,    //"2015-02-17",
			descending:true,
			limit: 5,
            timeIncrement: "day",
            format: "json"
        };

        var request_register = $.ajax({
            type: "POST",
            url: address, 
            data: JSON.stringify(send_opts),
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        });

        request_register.success(function (done) {      //등록성공
            var _offersData = JSON.stringify(done);
            var receiveData = JSON.parse(_offersData);

            var len = receiveData["results"].length;
			var high = 0 , low = 10000;
			var current = 0;
			var count = 0;
			var close = 0;
			var baseVolume = 0;
			var counterVolume=0;
		//document.write(	_offersData );
           
			//if(len > 0){	
			for(var i = 0 ; i < len; i++){
            	//gapClose = exrp.r8(receiveData["results"][i].close,2);
           // alert('current:' + current)
            	//현재가 
            	//current = parseFloat(receiveData["results"][len-1].close).toFixed(4);
            	//$("#closeVolume").html(current);
            	//$("#currentVolume").html(current);
            	
            	//최고가 
            	if(receiveData["results"][i].high != undefined){
            		if(high < receiveData["results"][i].high)
                       	high = receiveData["results"][i].high;
            	}
            	           	
            	//최저가
            	if(receiveData["results"][i].low != undefined){
            		if(low > receiveData["results"][i].low)
                       	low = receiveData["results"][i].low;
            	}
            
            	//거래량            	
            	if(receiveData["results"][i].baseVolume != undefined)
            		count += parseFloat(receiveData["results"][i].count);           	
            	
            	
            	//총거래량 XRP            	
            	if(receiveData["results"][i].baseVolume != undefined)
            		//alert(receiveData["results"][i].baseVolume)
            		baseVolume += receiveData["results"][i].baseVolume;
             
				
				//총거래량 ripple
				if(receiveData["results"][i].counterVolume != undefined){
					//alert(receiveData["results"][i].counterVolume)
					counterVolume += receiveData["results"][i].counterVolume;
				}
           }
			$("#highVolume2").html(parseFloat(high).toFixed(4));//최저가
			$("#lowVolume2").html(parseFloat(low).toFixed(4)); //최고가
			//$("#current").html(exrp.commify(count)); //거래량

			baseVolume = exrp.commify(parseFloat(baseVolume).toFixed(4));
			$("#baseVolume2").html(baseVolume); //총거래량
			//alert("total base:" + baseVolume)
			counterVolume = exrp.commify(parseFloat(counterVolume).toFixed(4));
			$("#counterVolume2").html(counterVolume); //총거래량 ripple
			$("#current2").html(baseVolume); //총거래량 ripple

        });

        request_register.error(function (done) {              //등록실패 JSon Format error, -1, false 리턴  
            //alert("Data Failed");
        });
        
        var send_opts = { //JSON Format 생성
                base: { currency: "XRP" },
                counter: { currency: "KRW", issuer: "rPxU6acYni7FcXzPCMeaPSwKcuS2GTtNVN" },
                startTime: dtNowDiff2,  //"2015-02-16",
                endTime: dtNowDiff1,    //"2015-02-17",
                timeIncrement: "day",
                format: "json"
            };

            var request_register2 = $.ajax({
                type: "POST",
                url: address, 
                data: JSON.stringify(send_opts),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            });
            
            request_register2.success(function (done) {      //등록성공
                var _offersData = JSON.stringify(done);
                var receiveData = JSON.parse(_offersData);

                var len = receiveData["results"].length;
    			///alert(_offersData);
                for (var i = 0; i < len; i++) {
    				
                    //result_data.startTime.push(receiveData["results"][i].startTime);
                   // result_data.close.push(receiveData["results"][i].close);
                   // result_data.baseVolume.push(receiveData["results"][i].baseVolume);
    				//alert($("#currentVolume").html());
                	gapClose = $("#closeVolume").html() - exrp.r8(receiveData["results"][i].close,2);
                	
                	$("#gapCloseVolume").html(exrp.r8round(gapClose,2));
                	$("#gapClosePercent").html(exrp.r8round(gapClose*10,2));
                }
            });

            request_register2.error(function (done) {              //등록실패 JSon Format error, -1, false 리턴  
                //alert("Data Failed");
            });
    },
    commaNum:function(num) {  
    	 
        if (num < 0) { 
            num *= -1; 
            var minus = true
        } else { 
            var minus = false
        }
     
        var dotPos = (num+"").split(".") 
        var dotU = dotPos[0] 
        var dotD = dotPos[1] 
        var commaFlag = dotU.length%3 
     
        if(commaFlag) { 
            var out = dotU.substring(0, commaFlag)  
            if (dotU.length > 3) out += ","
        } 
        else var out = ""
     
        for (var i=commaFlag; i < dotU.length; i+=3) { 
            out += dotU.substring(i, i+3)  
            if( i < dotU.length-3) out += ","
        } 
     
        if(minus) out = "-" + out 
     
        if(dotD) {
            return out + "." + dotD 
        } else {
            return out  
        }
    },
    GetRippleCurrentData:function() {
    	//최근거래내역
    	var address = "https://api.ripplecharts.com/api/offersExercised";

        var dtNow = exrp.getWorldDate(0, 0);
        var dtNowDiff5 = exrp.getWorldDate(0, -1); //뉴욕시각
        
        var send_opts = { //JSON Format 생성
                base: { currency: "XRP" },
                counter: { currency: "KRW", issuer: "rPxU6acYni7FcXzPCMeaPSwKcuS2GTtNVN" },		                                     
                startTime: dtNow,  
    			endTime: dtNowDiff5,
                descending:true,
    			limit:5,
    			reduce:false
            };

            var request_register = $.ajax({
                type: "POST",
                url: address, 
                data: JSON.stringify(send_opts),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            });

            request_register.success(function (done) {      //등록성공
                var _offersData = JSON.stringify(done);
                var receiveData = JSON.parse(_offersData);

    			var len = receiveData.length;
    			var baseVolume = "";
    			var html = "";
    			html = "<caption>최근 거래 기록 (5건) </caption>";
    			html += "<thead>";
    			html += "<tr>";
    			html += "<th>체결시각</th><th>거래량</th><th>체결가</th>";
    			html += "</tr>";
    			html += "</thead>";
    			html += " <tbody>";
    				
                for (var i = 1; i < len; i++) {
    				var data  = receiveData[i];
    				
    				var dataString = data.toString().split(",");
    				if(i == 1) {
						var current = parseFloat(dataString[1]).toFixed(4);
						//$("#current").html(exrp.commify(current));
						$("#closeVolume").html(parseFloat(current)); //현재가
						if($("#closeVolume2") != undefined)
							$("#closeVolume2").html(parseFloat(current));
						$("#currentVolume").html(exrp.commify(current));
						
						if($("#CLOSE_VOLUME") != undefined)
							$("#CLOSE_VOLUME").val(parseFloat(current));
						if($("#CURRENT_VOLUME") != undefined)
							$("#CURRENT_VOLUME").val(exrp.commify(current));
						
    					//alert('dataString[2]'+ dataString[1])
    					baseVolume = parseFloat(dataString[1]).toFixed(2);
    				}
    				
    				if(i < 6){
	    				html += " <tr> ";
	    				html += " <td> " + exrp.KoreaTimeFromWorldTime2(dataString[0],0) +"</td>";
	    				html += " <td style='text-align:right;'> " + exrp.commify(parseFloat(dataString[2]).toFixed(0))+"</td>";
	    				html += " <td> " + parseFloat(dataString[1]).toFixed(2) ;
	    				
	    				if(i > 1 ){
	    					//alert(baseVolume +":" + parseFloat(dataString[1]).toFixed(2));
		    				if(parseFloat(baseVolume).toFixed(2) > parseFloat(dataString[1]).toFixed(2))
		    					html += " <img src='images/down.png'/>";
		    				else 
		    					html += " <img src='images/up.png'/>";
	    				}
	    				html +="</td>";   				
	    				html += " </tr> ";
    				}
                }
                html += " </tbody>";
                
                if($("#lastDiv"))
                	$("#lastDiv").html(html);
                
    			//Data Insert
 
                var form = $("#RippleCurrentForm");
                
                if($("#ASKS_VOLUME").val() == "")
                	$("#ASKS_VOLUME").val($("#asksVolume").html());
                if($("#BIDS_VOLUME").val() == "")
                	$("#BIDS_VOLUME").val($("#bidsVolume").html());
                if($("#SPREAD_VOLUME").val() == "")
                	$("#SPREAD_VOLUME").val($("#spreadVolume").html());
                $(form).attr({method:"post",action:"/exrp/home/setRippleCurrentData.do"});
				common.ajaxSubmit({form:form,paramType:"text",action:function(data){
					try{data = jQuery.parseJSON(data);}catch (e) {data = 0;}
					var cnt = parseInt(data);
					
					/* if(cnt > 0){
						alert('setRippleCurrentData: 성공');
					}else{						
						alert('setRippleCurrentData : 실패');
					}*/
				}});
            });

            request_register.error(function (done) {              //등록실패 JSon Format error, -1, false 리턴  
                //alert("Data Failed");
               // stopRotation();
            });
    },
    GetRippleCurrentMyData:function() {
    	//최근거래내역
    	var address = "https://api.ripplecharts.com/api/offersExercised";

        var dtNow = exrp.getWorldDate(0, 0);
        var dtNowDiff1 = exrp.getWorldDate(0, -1); //뉴욕시각
        
        var send_opts = { //JSON Format 생성
                base: { currency: "XRP" },
                counter: { currency: "KRW", issuer: "rPxU6acYni7FcXzPCMeaPSwKcuS2GTtNVN" },		                                     
                startTime: dtNow,  
    			endTime: dtNowDiff1,
                descending:true,
    			limit:10,
    			reduce:false
            };

            var request_register = $.ajax({
                type: "POST",
                url: address, 
                data: JSON.stringify(send_opts),
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            });

            request_register.success(function (done) {      //등록성공
            	
                var _offersData = JSON.stringify(done);
                var receiveData = JSON.parse(_offersData);

    			var len = receiveData.length;
    			var baseVolume = "";
    			var html = "";
    			html = "<caption>최근 거래 기록 (5건) </caption>";
    			html += "<thead>";
    			html += "<tr>";
    			html += "<th scope=\"col\">체결시각</th><th scope=\"col\">거래량</th><th scope='col'>체결가</th>";
    			html += "</tr>";
    			html += "</thead>";
    			html += " <tbody>";
    				
                for (var i = 1; i < len; i++) {
    				var data  = receiveData[i];
    				
    				var dataString = data.toString().split(",");
    				if(i == 1) {
						var current = parseFloat(dataString[1]).toFixed(4);
	
						//$("#current").html(exrp.commify(current));
						$("#closeVolume").html(current); //최근거래내역
						$("#currentVolume").html(exrp.commify(current));


    					//alert('dataString[2]'+ dataString[1])
    					baseVolume = parseFloat(dataString[1]).toFixed(4);
    				}
    				html += " <tr> ";
    				html += " <td> " + exrp.KoreaTimeFromWorldTime2(dataString[0],0) +"</td>";
    				html += " <td style='text-center:right;'> " + exrp.commify(parseFloat(dataString[2]).toFixed(0))+"</td>";
    				html += " <td> " + parseFloat(dataString[1]).toFixed(2) ;
    				
    				if(i > 1 ){
    					//alert(baseVolume +":" + parseFloat(dataString[1]).toFixed(2));
	    				if(parseFloat(baseVolume).toFixed(2) > parseFloat(dataString[1]).toFixed(2))
	    					html += " <img src='images/down.png'/>";
	    				else 
	    					html += " <img src='images/up.png'/>";
    				}
    				html +="</td>";   				
    				html += " </tr> ";
                }
                html += " </tbody>";
              
                $("#lastMyDiv").html(html);
    			
            });

            request_register.error(function (done) {              //등록실패 JSon Format error, -1, false 리턴  
                //alert("Data Failed");
               // stopRotation();
            });
    },
    commify: function (n) {
  	  var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
  	  n += '';                          // 숫자를 문자열로 변환

  	  while (reg.test(n))
  		n = n.replace(reg, '$1' + ',' + '$2');

  	  return n;
  	},
    uncommify: function (n) {
  	  return n.replace(/,/g,'');
  	},

  	asks : function (option, gubun) {
  			var config = {
  			      socket: "wss://s1.ripple.com:51233/",
  			      base: {currency: "KRW", issuer:"rPxU6acYni7FcXzPCMeaPSwKcuS2GTtNVN"},
  			      counter: {currency: "XRP"},
  			      base2: {currency: "XRP"},
  			      counter2: {currency: "KRW", issuer:"rPxU6acYni7FcXzPCMeaPSwKcuS2GTtNVN"}
  			  };
  			
  				var websocket = new WebSocket(config.socket);
  				websocket.onopen = function(evt) {
  					if(option == 1){ //asks
  						
  						websocket.send(exrp.createSubscriptionMessage(option, config.base2, config.counter2));
  					}else{ //bids
  						
  						websocket.send(exrp.createSubscriptionMessage(option, config.base, config.counter));
  					}
  				};

  				websocket.onclose = function(evt) {
  			        // silent close
  			    };
  			    websocket.onmessage = function(evt) {
  			        var data = JSON.stringify(evt.data);
  			        var _offersData = JSON.parse(data);
  			        var receiveData = JSON.parse(evt.data);
  					//document.write(_offersData+ "<br>");
  					//document.write(JSON.stringify(receiveData.status) + "<br>");
  					//document.write(JSON.stringify(receiveData) + "<br>");		
  					//document.write(JSON.stringify(receiveData.result.offers) + "<br>");
  			        var offers = "";
  					var status = JSON.parse(JSON.stringify(receiveData.status));
//  					if(receiveData.result.offers != null)
  					if(offers != null)
  						offers = JSON.parse(JSON.stringify(receiveData.result.offers));
  					var sum = 0;
  					var asks_funded= 0;
  					var bids_funded = 0;
  					var html = "";
  					var cnt = 0;
  					var bidsVolume =0;
  					var asksVolume =0;
  					var isFirst = true;
  					if(option == 1){
  
	  					html += "<caption>매도</caption>";
	  					html += "<thead>";
	  					html += "<tr>";
	  					html += "<th>수량(XRP)</th>";
	  					html += "<th>가격(KRW)</th>";
	  					html += "<th>누적(XRP)</th>";
	  					html += "</tr>";
	  					html += "</thead>";
	  					html += "<tbody>";
	  				
	  					if(status == "success"){
	  						for(var i = 0; i < 10; i++){
	  							
	  							sum += parseFloat(exrp.r2(offers[i].TakerGets,1));
	  							html += " <tr>";
	  							
	  							
	  							if(offers[i].taker_gets_funded == undefined || offers[i].taker_gets_funded == 0)
	  								asks_funded = offers[i].TakerGets;
	  							else
	  								asks_funded = offers[i].taker_gets_funded;

	  							
	  							if(i < 5){
		  							html += "<td style='text-align:right;'>" + exrp.commify(exrp.r2(asks_funded,3)) +"</td>";
		  							html += "<td>" + exrp.commify(exrp.r1(offers[i].quality  ,2)) +"</td>";	  							
		  							html += "<td>" + exrp.commify(sum) +"</td>";
		  			                html += " </tr>";
	  							}
						
	  			                //매도호가
	  			                if(i == 0 ){
	  			              // alert(bidsVolume + "--"+ offers[i].quality)
	  			               // if(bidsVolume < offers[i].quality){
	  			                	bidsVolume = offers[i].quality;
	  			                }
	  			                	
	  			                	
	  			                	//alert('bidsVolume:' + bidsVolume)
	  			               // }
	  							
	  						}
	  					  bidsHigh = exrp.r1(bidsVolume,2);
	  					  $("#bidsVolume").html(exrp.commify(exrp.r1(bidsVolume,2)));
	  					  
	  					  if($("#BIDS_VOLUME") != undefined){
	  						$("#BIDS_VOLUME").val(exrp.commify(exrp.r1(bidsVolume,2)));
	  						//alert('bids_vol:'+ $("#BIDS_VOLUME").val());
	  					  }
	  					  //매도호가
	  					  if($("#bidsVolume2") != undefined)
	  						$("#bidsVolume2").html(exrp.commify(exrp.r1(bidsVolume,2)));
	  					  
	  					  html +="</tbody>";
	  					} 		
	  					if(gubun == 'M'){
	  						$("#asksDiv").html(html);
	  					}
  					}else {
  						var isAsks = false;
  						html = "<caption>매수</caption>";
	  					html += "<thead>";
	  					html += "<tr>";
	  					html += "<th>누적(XRP)</th>";
	  					html += "<th>가격(KRW)</th>";
	  					html += "<th>수량(XRP)</th>";
	  					html += "</tr>";
	  					html += "</thead>";
	  					html += "<tbody>";
	  					if(status == "success"){
	  						for(var i = 0; i < 10; i++){
	  							
	  							//option 1: asks
	  							//document.write(r1(offers[i].quality  ,4));
	  							//document.write(r2(offers[i].TakerGets,4));
	  							//document.write("<br>");
	  							
	  							if(offers[i].TakerPays == 0) continue;
	  							else {	  								
	  								cnt += 1;
	  							}
	  							
	  							if(offers[i].taker_pays_funded == undefined || offers[i].taker_pays_funded == 0)
	  								pays_funded = offers[i].TakerPays;
	  							else
	  								pays_funded = offers[i].taker_pays_funded;
	  							
	  							
	  							sum += parseFloat(exrp.r2(pays_funded,0));						
	  							
	  							var xrp = parseFloat(offers[i].TakerGets.value) / parseFloat(pays_funded);
	  							/*if(isFirst){
	  								asksVolume = exrp.r1(xrp,3);  			                		
  			                		$("#asksVolume").html(exrp.commify(asksVolume));
  			                	 	spread = bidsVolume - asksVolume;
  			                		$("#spreadVolume").html(parseFloat(spread).toFixed(4));
  			                		isFirst = false;
  								}*/
	  							if(!isAsks){ //매수호가
	  							//if(asksVolume < exrp.r1(xrp,3)){
	  								asksVolume = exrp.r1(xrp,3);
	  								isAsks = true;
	  			                }
	  							
	  							if(i < 5){
		  							html += " <tr>";
		  							html += "<td>" + exrp.commify(sum.toFixed(1)) +"</td>";
		  							html += "<td>" + parseFloat(exrp.r1(xrp,3)) +"</td>";	
		  							
		  							html += "<td style='text-align:right;'>" + exrp.commify(exrp.r2(pays_funded,1)) +"</td>";
		  							
		  			                html += " </tr>";
	  							}
	  						}
	  					 asksHigh = asksVolume;	 
	  					 $("#asksVolume").html(exrp.commify(asksVolume));
	  					 
	  					 if($("#ASKS_VOLUME") != undefined){
		  						$("#ASKS_VOLUME").val(exrp.commify(asksVolume));
		  						//alert('ASKS_VOLUME:'+ $("#ASKS_VOLUME").val());
	  					 }
	  					//매수호가
	  					  if($("#asksVolume2") != undefined)
	  						$("#asksVolume2").html(exrp.commify(asksVolume));
	  					  
	  					  html +="</tbody>";
	  					} 		
	  					if(gubun == 'M'){
	  						$("#bidsDiv").html(html);
	  					}
	  					//alert(bidsHigh + "-" + asksHigh)
	  					spreadHigh = bidsHigh - asksHigh;
	  					$("#spreadVolume").html(exrp.commify(parseFloat(spreadHigh).toFixed(4)));
	  					
	  					if($("#SPREAD_VOLUME") != undefined)
	  						$("#SPREAD_VOLUME").val(exrp.commify(parseFloat(spreadHigh).toFixed(4)));
	  					
	  				//Data Insert
	  					 
	  	                var form = $("#RippleCurrentForm");
	  	                
	  	                if($("#ASKS_VOLUME").val() == "")
	  	                	$("#ASKS_VOLUME").val($("#asksVolume").html());
	  	                if($("#BIDS_VOLUME").val() == "")
	  	                	$("#BIDS_VOLUME").val($("#bidsVolume").html());
	  	                if($("#SPREAD_VOLUME").val() == "")
	  	                	$("#SPREAD_VOLUME").val($("#spreadVolume").html());
	  	                $(form).attr({method:"post",action:"/exrp/home/setRippleAsksData.do"});
	  					common.ajaxSubmit({form:form,paramType:"text",action:function(data){
	  						try{data = jQuery.parseJSON(data);}catch (e) {data = 0;}
	  						var cnt = parseInt(data);
	  						
	  						/* if(cnt > 0){
	  							alert('setRippleCurrentData: 성공');
	  						}else{						
	  							alert('setRippleCurrentData : 실패');
	  						}*/
	  					}});
	  	           
  					}
  			    };
  			    websocket.onerror = function(evt) {
  			        // handle error
  			    };
  	},
  	myasks : function (option, gubun) {
			var config = {
			      socket: "wss://s1.ripple.com:51233/",
			      base: {currency: "KRW", issuer:"rPxU6acYni7FcXzPCMeaPSwKcuS2GTtNVN"},
			      counter: {currency: "XRP"},
			      base2: {currency: "XRP"},
			      counter2: {currency: "KRW", issuer:"rPxU6acYni7FcXzPCMeaPSwKcuS2GTtNVN"}
			  };
			
				var websocket = new WebSocket(config.socket);
				websocket.onopen = function(evt) {
					if(option == 1){ //asks
						
						websocket.send(exrp.createSubscriptionMessage(option, config.base2, config.counter2));
					}else{ //bids
						
						websocket.send(exrp.createSubscriptionMessage(option, config.base, config.counter));
					}
				};

				websocket.onclose = function(evt) {
			        // silent close
			    };
			    websocket.onmessage = function(evt) {
			        var data = JSON.stringify(evt.data);
			        var _offersData = JSON.parse(data);
			        var receiveData = JSON.parse(evt.data);
					//document.write(_offersData+ "<br>");
					//document.write(JSON.stringify(receiveData.status) + "<br>");
					//document.write(JSON.stringify(receiveData) + "<br>");		
					//document.write(JSON.stringify(receiveData.result.offers) + "<br>");
			        var offers = "";
					var status = JSON.parse(JSON.stringify(receiveData.status));
					if(receiveData.result.offers != null)
						offers = JSON.parse(JSON.stringify(receiveData.result.offers));
					var sum = 0;
					var asks_funded= 0;
					var bids_funded = 0;
					var html = "";
					var cnt = 0;
					
					var isFirst = true;
					if(option == 1){

  					html += "<caption>매도</caption>";
  					html += "<thead>";
  					html += "<tr>";
  					html += "<th>수량(XRP)</th>";
  					html += "<th>가격(KRW)</th>";
  					html += "<th>누적(XRP)</th>";
  					html += "</tr>";
  					html += "</thead>";
  					html += "<tbody>";
  					if(status == "success"){
  						for(var i = 0; i < 5; i++){
  							
  							sum += parseFloat(exrp.r2(offers[i].TakerGets,1));
  							html += " <tr>";
  							
  							
  							if(offers[i].taker_gets_funded == undefined || offers[i].taker_gets_funded == 0)
  								asks_funded = offers[i].TakerGets;
  							else
  								asks_funded = offers[i].taker_gets_funded;
  							
  							html += "<td style='text-align:right;'>" + exrp.commify(exrp.r2(asks_funded,3)) +"</td>";
  							html += "<td>" + exrp.commify(exrp.r1(offers[i].quality  ,2)) +"</td>";
  							
  							html += "<td>" + exrp.commify(sum) +"</td>";
  			                html += " </tr>";
  							
  			                //매도호가
  			                if(i == 0 ){
  			                	bidsVolume = exrp.r1(offers[i].quality  ,2);
  			                	$("#bidsVolume2").html(exrp.commify(bidsVolume));
  			                	$("#currentVolume2").html($("#baseVolume").html());
  			                	//alert('bidsVolume:' + bidsVolume)
  			                }
  							
  						}
  					  html +="</tbody>";
  					} 		
  					if(gubun == 'M'){
  						$("#asksDiv").html(html);
  					}
					}else {
						html = "<caption>매수</caption>";
  					html += "<thead>";
  					html += "<tr>";
  					html += "<th>누적(XRP)</th>";
  					html += "<th>가격(KRW)</th>";
  					html += "<th>수량(XRP)</th>";
  					html += "</tr>";
  					html += "</thead>";
  					html += "<tbody>";
  					if(status == "success"){
  						for(var i = 0; i < 10; i++){
  							
  							//option 1: asks
  							//document.write(r1(offers[i].quality  ,4));
  							//document.write(r2(offers[i].TakerGets,4));
  							//document.write("<br>");
  							
  							if(offers[i].TakerPays == 0) continue;
  							else {
  								
  								cnt += 1;
  							}
  							
  							if(offers[i].taker_pays_funded == undefined || offers[i].taker_pays_funded == 0)
  								pays_funded = offers[i].TakerPays;
  							else
  								pays_funded = offers[i].taker_pays_funded;
  							
  							
  							sum += parseFloat(exrp.r2(pays_funded,0));						
  							
  							var xrp = parseFloat(offers[i].TakerGets.value) / parseFloat(pays_funded);
  							if(isFirst){
									
  								asksVolume = exrp.r1(xrp,3);
			                		
			                		$("#asksVolume2").html(exrp.commify(asksVolume));
			                	
			                		spread = bidsVolume - asksVolume;
			                	
			                		$("#spreadVolume").html(parseFloat(spread).toFixed(4));
			                		isFirst = false;
								}
  							
  							html += " <tr>";
  							html += "<td>" + exrp.commify(sum.toFixed(1)) +"</td>";
  							html += "<td>" + parseFloat(exrp.r1(xrp,3)) +"</td>";	
  							
  							html += "<td style='text-align:right;'>" + exrp.commify(exrp.r2(pays_funded,1)) +"</td>";
  							
  			                html += " </tr>";
  			                
  			               
  			                
  			                if(cnt == 5) break;
  							
  						}
  						 
							
  					  html +="</tbody>";
  					} 		
  					if(gubun == 'M'){
  						$("#bidsDiv").html(html);
  					}
					}
			    };
			    websocket.onerror = function(evt) {
			        // handle error
			    };
	},
  	createSubscriptionMessage: function (id, base, counter) {
  		

	        return JSON.stringify({
	            command: "subscribe", books: [{
	              snapshot: true,
	              taker_gets: base,
	              taker_pays: counter,
	            }]
	          });
  		
    },
    r1: function(val, offset){
		return parseFloat(val * 1000000).toFixed(offset);
	},
	r2: function(val, offset){
		return parseFloat(val / 1000000).toFixed(offset);
	},
	getMUserRippleAddressChk:function(r_addr){//리플어드레스 중복체크	
		
			var form = document.memberJoinForm != null?document.memberJoinForm:document.memberInfoForm;
		
			try{			
				$(form).attr({method:"post",action:"/exrp/user/getMUserRippleAddressChk.do?r_addr="+r_addr});
				common.ajaxSubmit({form:form,paramType:"text",action:function(data){
					try{data = jQuery.parseJSON(data);}catch (e) {data = 0;}
					var cnt = parseInt(data);
					if(cnt > 0){
						$("#registration-ripple-address-confirm").css("color", "red");
				        $("#registration-ripple-address-confirm").text("중복되는 리플주소가 있습니다.");
				        _register_ripple_address_check = false;
					}else{
						$("#registration-ripple-address-confirm").css("color", "black");
				        $("#registration-ripple-address-confirm").text("유효한 리플주소 입니다.");
				        _register_ripple_address_check = true;
				        
					}
				}});
				return true;			
			}catch (e) {
				return false;
			}
			return false;

	},
	/* 본인인증 */
	OpenCertification : function() {
        //exrp.StartNiceInfo(exrp.StartNiceInfoResult());
		alert('서비스 준비중입니다.');
    },
    StartNiceInfoResult:function(result) {

        var length = result.length;
        
        if (length > 3) {
            $("#EncodeData").attr("value", result);

            window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
            document.form_chk.target = 'popupChk';
            document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
            document.form_chk.submit();
        }
        else {
            alert("ErrorCode : " + result + " ( 나이스정보 오류, 다시 시도해주세요. )");
        }
    },
    ReciveCertification: function (index, name, phone, birth) {
       //parent.ReciveResult(index, name, phone, birth);
    	alert(name)
    },
    
    CheckUserID:function() { //user id 체크
        _register_id_check = false;
        $('#user_id_check').html("");
    },
    CheckPassword: function () { //check password 
        _register_password_check = false;
        $("#mboPassword2").val("");
        $("#registration-password-re-check").css("display", "none");

        var password_length = $("#mboPassword1").val().length;

        if (password_length == 0) {
            $("#registration-password-check").css("display", "none");
        }
        else if (password_length < 6) {
            $("#registration-password-check").css("display", "block");
            $("#registration-password-check").css("color", "red");
            $("#registration-password-check").text("사용불가능");
        }
        else if (password_length >= 6) {
            var id = $("#mboIdCHK").val();
            var password = $("#mboPassword1").val();

            if (id == password) {
                $("#registration-password-check").css("display", "block");
                $("#registration-password-check").css("color", "red");
                $("#registration-password-check").text("아이디와 비밀번호가 동일합니다.");
            } else {
                
                var count = 0;
                var regexp = /[A-Z]/;
                for (var i = 0; i < $("#mboPassword1").val().length; i++) {
                    if (regexp.test($("#mboPassword1").val().charAt(i)) == true) {
                        count++;
                    }
                }
              
                if (count == 0) {
                    $("#registration-password-check").css("display", "block");
                    $("#registration-password-check").css("color", "red");
                    $("#registration-password-check").text("* 대문자를 하나이상 입력하셔야 합니다.");
                    return;
                }

                $("#registration-password-check").css("display", "block");
                $("#registration-password-check").css("color", "blue");
                $("#registration-password-check").text("사용가능");
            }
        }
    },
    ComparePassword : function () {    
        _register_password_check = false;

        var password = $("#mboPassword1").val();
        var password_re = $("#mboPassword2").val();

        if (password != password_re) {
            $("#registration-password-re-check").css("display", "block");
            $("#registration-password-re-check").css("color", "red");
            $("#registration-password-re-check").text("비밀번호가 다릅니다.");
        }
        else {
            $("#registration-password-re-check").css("display", "block");
            $("#registration-password-re-check").css("color", "blue");
            $("#registration-password-re-check").text("사용가능");

            _register_password_check = true;
        }

        if (password_re.length == 0) {
            $("#registration-password-re-check").css("display", "none");
        }

    },setMemberJoinForm:function(){ //회원등록
		var form = $("#memberJoinForm");
		
		if (_register_ripple_address_check == false) {
	        alert("유효하지 않은 리플주소입니다.");
	        $("##rippleAddres").focus();
	        return;
	    }
		/**
		 * 패스워드 확인
		 * */
		if($("#mboPassword").length){
			if($("#mboPassword1").val() != $("#mboPassword2").val()){
				common.alert({content:"비밀번호가 서로 일치하지 않습니다."});
				return false;
			}else{
				$("#mboPassword").val($("#mboPassword2").val());
			}
		}
		
		
		if(member.setMemberFormData(form)){
			if(common.valid(form)){
				
				/*if(exrp.getEmailChk() > 0){
					alert("중복된 이메일이 있습니다.");
					$("#mbEmail1").val("");
					$("#mbEmail1").focus();
					return;
				}*/
				if ($("#bank").val() == "") {
			        alert("은행을 입력하세요.");
			        $("#bank").focus();
			        return;
			    }
				
				if ($("#mbAccount").val() == "") {
			        alert("계좌번호을 입력하세요.");
			        $("#mbAccount").focus();
			        return;
			    }
				
			    if (jQuery.isNumeric($("#mbAccount").val()) == false) {
			        alert("잘못된 계좌번호 입니다.");
			        $("#mbAccount").focus();
			        return;
			    }
			    
			    if ($("#mbBirthDay").val() == "") {
			        alert("생년월일을 입력하세요.");
			        $("#mbBirthDay").focus();
			        return;
			    }
			   
			    if($("#mbNiceCheck").val() == "Y"){
			    	$("#mbClass").val("3"); //gold
			    }else{
			    	if($("#mbImage").val != ""){
			    		$("#mbClass").val("2"); //silver
			    	}else{
			    		$("#mbClass").val("1"); //bronze
			    	}
			    }
			    
			    
				common.confirm({content:"요청하신 작업을 계속진행하시겠습니까?",action:function(){
					
					$(form).attr({method:"post",action:"/member/public/memberJoinForm/proc.do"});
					common.ajaxSubmit({form:form,paramType:"text",action:function(data){
						try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
						if(data["result"] == "1"){
							location.replace("/?MID=memberComplete");
						}else{
							common.alert({content:"회원가입에 실패하였습니다. 관리자에게 문의 바랍니다.",action:function(){
								//location.reload();
							}});
						}
					}});
					return true;
				}});
			}
		}
	},setMyInfoCfg:function(){
		
		//#password 가 활성화 되어 있으면 비밀번호 변경  else 기본항목/부가항목
		var formVal = $("#password").css("display") != "none" ? "memberPasswordFrm" : "memberForm";
		var form = $("#" + formVal);
		
		/** 미사용 **/
		if(formVal == "memberForm"){
			
			if(member.setMemberFormData(form)){
				if(common.valid(form)){
					var mbPhon = $("#mbPhon1").val() + "-" + $("#mbPhon2").val() + "-" + $("#mbPhon3").val();
					var mbPhonChk = $("#mbPhonChk").val();
		
					if(mbPhon != mbPhonChk){
						if($("#mbNiceCheck").val() == "N"){
							alert("핸드폰 변경시 본인인증이 필요합니다.");
							$("#mbPhon1").focus();
							return;
						}
					}
					
					if ($("#bank").val() == "") {
				        alert("은행을 입력하세요.");
				        $("#bank").focus();
				        return;
				    }
					
					if ($("#mbAccount").val() == "") {
				        alert("계좌번호을 입력하세요.");
				        $("#mbAccount").focus();
				        return;
				    }
					
				    if (jQuery.isNumeric($("#mbAccount").val()) == false) {
				        alert("잘못된 계좌번호 입니다.");
				        $("#mbAccount").focus();
				        return;
				    }
				    if ($("#mbBirthDay").val() == "") {
				        alert("생년월일을 입력하세요.");
				        $("#mbBirthDay").focus();
				        return;
				    }
				    
					common.confirm({content:"요청하신 작업을 계속진행하시겠습니까?",action:function(){
						$(form).attr({method:"post",action:"/member/onlineMember/myInfoCfg/proc.do"});
						common.ajaxSubmit({form:form,paramType:"json",action:function(data){
							if(data["result"] == "1"){
								common.alert({content:"회원정보가 정상적으로 수정되었습니다.",action:function(){
									location.reload();
								}});
							}else{
								common.alert({content:"회원정보수정에 실패하였습니다.",action:function(){
									location.reload();
								}});
							}
						}});
						return true;
					}});
				}
			}
		}else{
			if(common.valid(form)){
				$(form).attr({method:"post",action:"/member/onlineMember/changePassword/proc.do"});
				if($(form).find("input[name='mboPassword1']").val() != $(form).find("input[name='mboPassword2']").val()){
					common.alert({content:"비밀번호가 서로 일치하지 않습니다.",action:function(){
//						common.closeLayout();
						$(form).find("input[name='mboPassword1']").focus();
					}});
					return false;
				}else if($(form).find("input[name='mboPassword']").val() == $(form).find("input[name='mboPassword1']").val()){
					common.alert({content:"<p>현재 비밀번호 동일합니다.</p><p>변경하실 비밀번호를 다르게 입력해주세요.</p>",action:function(){
						common.closeLayout();
						$(form).find("input[name='mboPassword1']").focus();
					}});
					return false;
				}
				
				common.confirm({content:"요청하신 작업을 계속진행하시겠습니까?",action:function(){
					common.ajaxSubmit({form:form,paramType:"text",action:function(data){
						try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
						if(data["result"] == "1"){
							common.alert({content:"비밀번호가 변경되었습니다.",action:function(){
								common.confirm({content:"로그아웃 후 다시 로그인 하시겠습니까?",action:function(){
									common.loginOut(form);
								}});
								common.closeLayout();
//								form.reset();
							}});
						}else if(data["result"] == "-1"){
							common.alert({content:"비밀번호가 일치하지 않습니다.",action:function(){
								common.closeLayout();
//								form.reset();
							}});
						}else{
							common.alert({content:"<p>비밀번호 변경에 실패하였습니다.</p>",action:function(){
								location.reload();
							}});
						}
						return false;
						
					}});
					return true;
				}});
			}
		}
	},
	getEmailChk: function(){
		
		try{	
			var form = document.memberJoinForm;
			if($("#mbEmail1").val() != "" && $("#mbEmail2").val() != ""){
				if($("#mbEmail2").val().indexOf(".") < 0){
					alert("이메일 주소가 형식에 맞지 않습니다.");
					$("#mbEmail2").focus();
					return;
				}
				$(form).attr({method:"post",action:"/member/public/getEmailChk.do"});
				common.ajaxSubmit({form:form,paramType:"text",action:function(data){
					try{data = jQuery.parseJSON(data);}catch (e) {data = 0;}
					
					var cnt = parseInt(data);
					if(cnt > 0) {
						alert("중복된 이메일이 있습니다.");
						$("#mbEmail1").val("");
						$("#mbEmail1").focus();
					}
					
				}});	
				
			}
			return true;
		}catch (e) {
			return false;
		}
		return false;
	},
	deleteDeposit:function(info){
		
		form = $("#depositListForm");
		var checkboxInfo = common.checkboxInfo("TNO");
		if(checkboxInfo.checked < 1){
			common.alert({content:"삭제 대상을 선택해주세요.",action:function(){checkboxInfo.firstNode.focus();}});
			return false;
		}

		common.confirm({content:"선택한 데이타를 삭제하시겠습니까??",action:function(){
			$(form).attr({method:"post",action:"/exrp/deposite/deleteDeposit.do"});
			common.ajaxSubmit({form:form,paramType:"text",action:function(data){
				try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
				if(parseInt(data) > 0){
					common.alert({content:"선택한 대상이 삭제되었습니다.",action:function(){location.reload();}});
				}else{
					common.alert({content:"자료삭제에 실패하였습니다.",action:function(){location.reload();}});
				}
			}});
			return true;
		}});
	},
	deleteWithdrawal:function(info){
		
		form = $("#withdrawalList");
		
		var checkboxInfo = common.checkboxInfo("TNO");
		if(checkboxInfo.checked < 1){
			common.alert({content:"삭제 대상을 선택해주세요.",action:function(){checkboxInfo.firstNode.focus();}});
			return false;
		}
		
		common.confirm({content:"선택한 데이타를 삭제하시겠습니까??",action:function(){
			$(form).attr({method:"post",action:"/exrp/withdrawal/deleteWithdrawal.do"});
			common.ajaxSubmit({form:form,paramType:"text",action:function(data){
				try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
				if(parseInt(data) > 0){
					common.alert({content:"선택한 대상이 삭제되었습니다.",action:function(){location.reload();}});
				}else{
					common.alert({content:"자료삭제에 실패하였습니다.",action:function(){location.reload();}});
				}
			}});
			return true;
		}});
	},getWithdrawalDetail:function(info){ //출금 상세 내역 조회

		$.ajax({
			type:'post',
			//url: "/member/administrator/memberManager/memberManagerInfo.do",
			url: "/exrp/withdrawal/getWithdrawalDetail.do",
			dataType: "text",
			data: "ID="+info.ID+"&TNO="+info.tno+"&MID="+info.MID,
			success: function(data) {
			
				if(info.STEP == "N"){
					if($(data).attr("id") == "withdrawalPop"){
						common.layout({
							id:"withdrawalPop"
							,title:$(data).attr("title")
							,content:$(data)
							,action:exrp.updateWithdrawalForm
							,width:$(data).attr("width")
						});
					}else{
						//location.reload();
					}
				}else{
					if($(data).attr("id") == "withdrawalPop"){
						common.layout({
							id:"withdrawalPop"
							,title:$(data).attr("title")
							,content:$(data)
							,width:$(data).attr("width")
						});
					}else{
						//location.reload();
					}
				}
		  	}
		});
	},getDepositDetail:function(info){ //예탁 상세 내역 조회
//		alert("조회중");
		$.ajax({
			type:'post',
			//url: "/member/administrator/memberManager/memberManagerInfo.do",
			url: "/exrp/deposit/getDepositDetail.do",
			data: "ID="+info.ID+"&TNO="+info.tno+"&MID="+info.MID,
			dataType: "text",
//			url: "https://www.exrp.co.kr/?MID=depositList",
//			data: "&ID="+info.ID+"&TNO="+info.tno,
			success: function(data) {
			  alert(info.STEP);
				 if(info.STEP == "N"){
					common.layout({
						id:"depositPop"
						,title:$(data).attr("title")
						,content:$(data)
						,action:exrp.updateDepositForm
						,width:$(data).attr("width")
					});
				}else{
					common.layout({
						id:"depositPop"
						,title:$(data).attr("title")
						,content:$(data)
						,width:$(data).attr("width")
					});
				}
				
		  	}
		});
	},getFeePolicyDetail:function(info){ //예탁 상세 내역 조회
		$.ajax({
			type:'post',
			//url: "/member/administrator/memberManager/memberManagerInfo.do",
			url: "/exrp/fee/getFeePolicyDetail.do",
			dataType: "text",
			data: "FEE_INDEX="+info.idx+"&MID="+info.MID,
			success: function(data) {
					common.layout({
						id:"feePop"
						,title:$(data).attr("title")
						,content:$(data)
						,action:exrp.setFeeForm
						,width:$(data).attr("width")
					});
		  	}
		});
	},feePolicyRegPop:function(info){ //예탁 상세 내역 조회
		$.ajax({
			type:'post',
			//url: "/member/administrator/memberManager/memberManagerInfo.do",
			url: "/exrp/fee/feePolicyRegPop.do",
			dataType: "text",
			data: "MID="+info.MID,
			success: function(data) {
					common.layout({
						id:"feePop"
						,title:$(data).attr("title")
						,content:$(data)
						,action:exrp.setFeeForm
						,width:$(data).attr("width")
					});
		  	}
		});
	},setFeeForm:function(){
		try{
			var form = $("#depositForm");
			if(common.valid(form)){
				common.confirm({content:"요청하신 작업을 계속진행하시겠습니까?",action:function(){
					$(form).attr({method:"post",action:"/exrp/fee/setFee.do"});
					common.ajaxSubmit({form:form,paramType:"text",action:function(data){
						try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
						common.closeLayout("feePop");
						if(parseInt(data) == 1){
							common.alert({content:"수수료 작업을 완료하였습니다.",action:function(){
								location.reload();
							}});
						}else{
							common.alert({content:"수수료 작업에 실패하였습니다.",action:function(){
								
							}});
						}
						return true;
					}});
					return true;
				}});
					
			}
				
		}catch (e) {
			alert(e);
			return false;
		}
		return false;
	},
	deleteFeePolicy:function(info){
		
		form = $("#depositListForm");
		var checkboxInfo = common.checkboxInfo("FEE_INDEX");
		if(checkboxInfo.checked < 1){
			common.alert({content:"삭제 대상을 선택해주세요.",action:function(){checkboxInfo.firstNode.focus();}});
			return false;
		}

		common.confirm({content:"선택한 데이타를 삭제하시겠습니까??",action:function(){
			$(form).attr({method:"post",action:"/exrp/fee/deleteFeePolicy.do"});
			common.ajaxSubmit({form:form,paramType:"text",action:function(data){
				try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
				if(parseInt(data) > 0){
					common.alert({content:"선택한 대상이 삭제되었습니다.",action:function(){location.reload();}});
				}else{
					common.alert({content:"자료삭제에 실패하였습니다.",action:function(){location.reload();}});
				}
			}});
			return true;
		}});
	},onlyNumberInput:function(id) {
		var code = window.event.keyCode;
		if ((code > 34 && code < 41) || (code > 47 && code < 58)
				|| (code > 95 && code < 106) || code == 8 || code == 9
				|| code == 13 || code == 46) {
			window.event.returnValue = true;
			return;
		}
	
		$("#"+id).val("");
		window.event.returnValue = false;
	},updateWithdrawalForm:function(){
		try{
			var form = $("#withdrawalForm");
			
			if ($("#FEE").val() == "") {
		        alert("수수료를 입력하세요.");
		        $("#FEE").focus();
		        return;
		    }
			if ($("#PRICE").val() == "") {
		        alert("출금액을 입력하세요.");
		        $("#PRICE").focus();
		        return;
		    }
		
			if ($("#ENDDATE1").val() == "") {
		        alert("출금날짜를  입력하세요.");
		        $("#ENDDATE1").focus();
		        return;
		    }
			
			if ($("#ENDTIME2").val() == "") {
		        alert("출금날짜 분을  입력하세요.");
		        $("#ENDDATE2").focus();
		        return;
		    }
			
			if ($("#ENDTIME3").val() == "") {
		        alert("출금날짜 초를  입력하세요.");
		        $("#ENDDATE3").focus();
		        return;
		    }
			var enddate = $("#ENDDATE1").val() + " " + $("#ENDTIME").val() + ":" + $("#ENDTIME2").val() + ":" + $("#ENDTIME3").val();
			$("#ENDDATE").val(enddate);
			if(common.valid(form)){
				common.confirm({content:"요청하신 작업을 계속진행하시겠습니까?",action:function(){
					$(form).attr({method:"post",action:"/exrp/withdrawal/updateWithdrawal.do"});
					common.ajaxSubmit({form:form,paramType:"text",action:function(data){
						try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
						common.closeLayout("withdrawalPop");
						if(parseInt(data) == 1){
							common.alert({content:"출금상세 내역 작업을 완료하였습니다.",action:function(){
								location.reload();
							}});
						}else{
							common.alert({content:"출금상세 내역 작업에 실패하였습니다.",action:function(){
								
							}});
						}
						return true;
					}});
					return true;
				}});
					
			}
				
		}catch (e) {
			alert(e);
			return false;
		}
		return false;
	},updateDepositForm:function(){
		try{
			var form = $("#depositForm");
			
			if ($("#FEE").val() == "") {
		        alert("수수료를 입력하세요.");
		        $("#FEE").focus();
		        return;
		    }
			if ($("#PRICE").val() == "") {
		        alert("출금액을 입력하세요.");
		        $("#PRICE").focus();
		        return;
		    }
		
			if ($("#ENDDATE1").val() == "") {
		        alert("출금날짜를  입력하세요.");
		        $("#ENDDATE1").focus();
		        return;
		    }
			
			if ($("#ENDTIME2").val() == "") {
		        alert("출금날짜 분을  입력하세요.");
		        $("#ENDDATE2").focus();
		        return;
		    }
			
			if ($("#ENDTIME3").val() == "") {
		        alert("출금날짜 초를  입력하세요.");
		        $("#ENDDATE3").focus();
		        return;
		    }
			var enddate = $("#ENDDATE1").val() + " " + $("#ENDTIME").val() + ":" + $("#ENDTIME2").val() + ":" + $("#ENDTIME3").val();
			$("#ENDDATE").val(enddate);
			if(common.valid(form)){
				common.confirm({content:"요청하신 작업을 계속진행하시겠습니까?",action:function(){
					$(form).attr({method:"post",action:"/exrp/deposit/updateDeposit.do"});
					common.ajaxSubmit({form:form,paramType:"text",action:function(data){
						try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
						common.closeLayout("withdrawalPop");
						if(parseInt(data) == 1){
							common.alert({content:"예탁 상세 내역 작업을 완료하였습니다.",action:function(){
								location.reload();
							}});
						}else{
							common.alert({content:"예탁 상세 내역 작업에 실패하였습니다.",action:function(){
								
							}});
						}
						return true;
					}});
					return true;
				}});
					
			}
				
		}catch (e) {
			alert(e);
			return false;
		}
		return false;
	},setFee:function(amount, id){
	
		var fee = $('#'+id).val();
		var amount = parseFloat(amount);

		if(amount ==  0){
			amount = $('#AMOUNT').val();
		}

		if(amount == 0 || amount == ""){
			alert("금액을 입력해 주세요!!");
			$('#AMOUNT').focus();
			return;
		}
		var price;
		if(fee != ''){
			fee = parseFloat(fee);
			price = amount - fee;
			$('#PRICE').val(price);
		}
	},setPrice:function(amount){
		var rate = $('#RATE').val();
		
		
		if(amount == ""){
			amount = $('#AMOUNT').val();
		}
	
		if(amount == ""){
			alert("금액이 없습니다.");
			return;
		}
		if(rate == ""){
			alert("수수료율이 없습니다.");
			return;
		}
		var amount = parseFloat(amount);
		var fee = amount * parseFloat(rate) /100 ;
		var price = 0;

		$('#FEE').val(fee);
		price = amount - fee;
		$('#PRICE').val(price);
		
	},setUserPrice:function(mode){
		
		var amount;
		if(mode == 'D'){
			amount = $("#AMOUNT1").val();
		}
		else if(mode == 'W'){
			amount = $("#AMOUNT2").val();
		}
			
		var rate = $('#RATE').val();
		
		
		if(amount == ""){
			alert("금액이 없습니다.");
			return;
		}
		if(rate == ""){
			alert("수수료율이 없습니다.");
			return;
		}
		var fee = parseFloat(amount) * parseFloat(rate) /100 ;
		var price;
		
		$('#FEE').val(fee);
		price = amount - fee;
		
		if(mode == 'D'){
			$('#PRICE1').val(price);
		}
		else if(mode == 'W'){
			$('#PRICE2').val(price);
		}
		
		
	},
	depositRegPop:function(info){ //예탁 등록 팝업
		$.ajax({
			type:'post',
			//url: "/member/administrator/memberManager/memberManagerInfo.do",
			url: "/exrp/deposit/depositRegPop.do",
			dataType: "text",
			data: "MID="+info.MID,
			success: function(data) {			
				
				if($(data).attr("id") == "depositPop"){
					common.layout({
						id:"depositPop"
						,title:$(data).attr("title")
						,content:$(data)
						,action:exrp.setDepositRegPop
						,width:$(data).attr("width")
					});
				}else{
					//location.reload();
				}
				
		  	}
		});
	},
	regularDepositRegPop:function(info){ //정기예탁 등록 팝업
		
		$.ajax({
			type:'post',
			//url: "/member/administrator/memberManager/memberManagerInfo.do",
			url: "/exrp/deposit/regularDepositRegPop.do",
			data: "MID="+info.MID,
			success: function(data) {			
				if($(data).attr("id") == "depositPop"){
					common.layout({
						id:"depositPop"
						,title:$(data).attr("title")
						,content:$(data)
						,action:exrp.setRegularDepositRegPop
						,width:$(data).attr("width")
					});
				}else{
					//location.reload();
				}
				
		  	}
		});
	},
	getRegularDepositDetail:function(info){ //정기예탁 상세 팝업
		
		$.ajax({
			type:'post',
			url: "/exrp/deposit/getRegularDepositDetail.do",
			dataType: "text",
			data: "MID="+info.MID+"&TNO="+info.TNO,
			success: function(data) {			
				if($(data).attr("id") == "depositPop"){
					common.layout({
						id:"depositPop"
						,title:$(data).attr("title")
						,content:$(data)
						,action:exrp.setRegularDepositRegPop
						,width:$(data).attr("width")
					});
				}else{
					//location.reload();
				}
				
		  	}
		});
	},setRegularDepositRegPop:function(){
		try{
			var form = $("#depositForm");
			if(common.valid(form)){
				common.confirm({content:"요청하신 작업을 계속진행하시겠습니까?",action:function(){
					$(form).attr({method:"post",action:"/exrp/deposit/setRegularDeposit.do"});
					common.ajaxSubmit({form:form,paramType:"text",action:function(data){
						try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
						common.closeLayout("depositPop");
						if(parseInt(data) == 1){
							common.alert({content:"예탁 내역 작업을 완료하였습니다.",action:function(){
								location.reload();
							}});
						}else{
							common.alert({content:"예탁 내역 작업에 실패하였습니다.",action:function(){
								
							}});
						}
						return true;
					}});
					return true;
				}});
					
			}
				
		}catch (e) {
			alert(e);
			return false;
		}
		return false;
	},
	deleteRegularDeposit:function(info){
		
		form = $("#depositListForm");
		var checkboxInfo = common.checkboxInfo("TNO");
		if(checkboxInfo.checked < 1){
			common.alert({content:"삭제 대상을 선택해주세요.",action:function(){checkboxInfo.firstNode.focus();}});
			return false;
		}

		common.confirm({content:"선택한 데이타를 삭제하시겠습니까??",action:function(){
			$(form).attr({method:"post",action:"/exrp/deposite/deleteRegularDeposit.do"});
			common.ajaxSubmit({form:form,paramType:"text",action:function(data){
				try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
				if(parseInt(data) > 0){
					common.alert({content:"선택한 대상이 삭제되었습니다.",action:function(){location.reload();}});
				}else{
					common.alert({content:"자료삭제에 실패하였습니다.",action:function(){location.reload();}});
				}
			}});
			return true;
		}});
	},
	setRate:function(obj) {
		var rateVal = $("#"+obj).val();
		var rateArr;
		var term;
		
		if(rateVal != ""){
			rateArr = rateVal.split(":")
			$("#RATE").val(rateArr[0]);
			$("#TERM").val(rateArr[1]);
		}else{
			$("#RATE").val("");
			$("#TERM").val("");
		}
	}
	,withdrawalRegPop:function(info){ //예탁 등록 팝업
		$.ajax({
			type:'post',
			//url: "/member/administrator/memberManager/memberManagerInfo.do",
			url: "/exrp/withdrawal/withdrawalRegPop.do",
			dataType: "text",
			data: "MID="+info.MID,
			success: function(data) {			
				
				if($(data).attr("id") == "depositPop"){
					common.layout({
						id:"depositPop"
						,title:$(data).attr("title")
						,content:$(data)
						,action:exrp.setDepositRegPop
						,width:$(data).attr("width")
					});
				}else{
					//location.reload();
				}
				
		  	}
		});
	},
	withdrawalRegPop:function(info){ //예탁 등록 팝업
		$.ajax({
			type:'post',
			//url: "/member/administrator/memberManager/memberManagerInfo.do",
			url: "/exrp/withdrawal/withdrawalRegPop.do",
			dataType: "text",
			data: "MID="+info.MID,
			success: function(data) {			
				
				if($(data).attr("id") == "depositPop"){
					common.layout({
						id:"depositPop"
						,title:$(data).attr("title")
						,content:$(data)
						,action:exrp.setWithdrawalRegPop
						,width:$(data).attr("width")
					});
				}else{
					//location.reload();
				}
				
		  	}
		});
	},memberManagerPop:function(info){
	    w = 1200;    //팝업창의 너비
	    h = 700;    //팝업창의 높이

	    var LeftPosition=(screen.width-w)/2;
	    var TopPosition=(screen.height-h)/2;

		  	
		window.open('', 'popupChk', "width="+ w + ",height="+ h +"scrollbars=yes,top="+TopPosition+",left="+LeftPosition+", fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no");
        document.memberManagerPop.target = 'popupChk';
        document.memberManagerPop.method = 'post';
        document.memberManagerPop.action = "/exrp/member/memberManagerPop.do";
        document.memberManagerPop.submit();
        
		//window.open("/exrp/member/memberManagerPop.do","","");
		/*$.ajax({
			type:'post',
			url: "/exrp/member/memberManagerPop.do",
			dataType: "text",
			data: "MID="+info.MID,
			success: function(data) {			
				alert(data)
				if($(data).attr("id") == "memberManager"){
					common.layout({
						id:"memberManager"
						,title:$(data).attr("title")
						,content:$(data)
						//,action:common.getPage
						,width:$(data).attr("width")
					});
				}else{
					//location.reload();
				}
				
		  	}
		});*/
	},
	getMemberManagerPop:function(){ // 회원리스트 회원검색
		var form = $("#memberManagerListPopForm");
		form.action = "/exrp/member/memberManagerPop.do";
		form.method = "get";
		form.submit();
	}
	,setMemberInfoPop:function(mbIdx,mboId,mbName,aId,bank,account,rippleAddress,email){
	
		if(opener.depositForm != undefined){
			opener.depositForm.mbIdx.value = mbIdx;
			opener.depositForm.mboId.value = mboId;
			opener.depositForm.NAME.value = mbName;
			opener.depositForm.ID.value = mboId;
			opener.depositForm.AID.value = aId;
			opener.depositForm.R_ADDR.value = rippleAddress;
			
			if(opener.depositForm.EMAIL != undefined)
				opener.depositForm.EMAIL.value = email;
			
			if(opener.depositForm.BANK != undefined){
				opener.depositForm.BANK.value = bank;
				opener.depositForm.ACCOUNT.value = account;
			}
		}else if(opener.csBoardForm != undefined){			
			opener.csBoardForm.csMboId.value = mboId;
		}
		self.close();
	},setDepositRegPop:function(){
		try{
			var form = $("#depositForm");
			if ($("#AMOUNT").val() == "") {
		        alert("입금액을 입력하세요.");
		        $("#FEE").focus();
		        return;
		    }
			if ($("#FEE").val() == "") {
		        alert("수수료를 입력하세요.");
		        $("#FEE").focus();
		        return;
		    }
			if ($("#PRICE").val() == "") {
		        alert("가격을 입력하세요.");
		        $("#PRICE").focus();
		        return;
		    }
		
			
			if(common.valid(form)){
				common.confirm({content:"요청하신 작업을 계속진행하시겠습니까?",action:function(){
					$(form).attr({method:"post",action:"/exrp/deposit/setDeposit.do"});
					common.ajaxSubmit({form:form,paramType:"text",action:function(data){
						try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
						common.closeLayout("withdrawalPop");
						if(parseInt(data) == 1){
							common.alert({content:"예탁 내역 작업을 완료하였습니다.",action:function(){
								location.reload();
							}});
						}else{
							common.alert({content:"예탁 내역 작업에 실패하였습니다.",action:function(){
								
							}});
						}
						return true;
					}});
					return true;
				}});
					
			}
				
		}catch (e) {
			alert(e);
			return false;
		}
		return false;
	},
	setWithdrawalRegPop:function(){
		try{
			var form = $("#depositForm");
			
			if ($("#BANK").val() == "") {
		        alert("은행을 선택하세요.");
		        $("#BANK").focus();
		        return;
		    }
			if ($("#ACCOUNT").val() == "") {
		        alert("계좌번호를  입력하세요.");
		        $("#ACCOUNT").focus();
		        return;
		    }
			
			if ($("#AMOUNT").val() == "") {
		        alert("신청 금액을 입력하세요.");
		        $("#FEE").focus();
		        return;
		    }
			if ($("#FEE").val() == "") {
		        alert("수수료를 입력하세요.");
		        $("#FEE").focus();
		        return;
		    }
			if ($("#PRICE").val() == "") {
		        alert("가격을 입력하세요.");
		        $("#PRICE").focus();
		        return;
		    }
		
			
			if(common.valid(form)){
				common.confirm({content:"요청하신 작업을 계속진행하시겠습니까?",action:function(){
					$(form).attr({method:"post",action:"/exrp/withdrawal/setWithdrawal.do"});
					common.ajaxSubmit({form:form,paramType:"text",action:function(data){
						try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
						common.closeLayout("withdrawalPop");
						if(parseInt(data) == 1){
							common.alert({content:"인출 내역 작업을 완료하였습니다.",action:function(){
								location.reload();
							}});
						}else{
							common.alert({content:"인출 내역 작업에 실패하였습니다.",action:function(){
								
							}});
						}
						return true;
					}});
					return true;
				}});
					
			}
				
		}catch (e) {
			alert(e);
			return false;
		}
		return false;
	},myRippleDeposit:function(info){
		try{
			var form = $("#myRippleForm");
			if ($("#AMOUNT1").val() == "") {
		        	alert("입금액을 입력하세요.");
		        	$("AMOUNT1").focus();
		        	return;
			
		    	}

			if (eval($("#AMOUNT1").val()) < 100000) {
		        	alert("최소 100,000원 이상 예탁 하셔야 됩니다.");
		        	$("AMOUNT1").focus();
		        	return;
			
		    	}
			
			$("#AMOUNT").val($("#AMOUNT1").val());
			$("#PRICE").val($("#PRICE1").val());
		
			common.confirm({content:"요청하신 작업을 계속진행하시겠습니까?",action:function(){
				$(form).attr({method:"post",action:"/exrp/deposit/setDeposit.do"});
				common.ajaxSubmit({form:form,paramType:"text",action:function(data){
					try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
					common.closeLayout("withdrawalPop");
					if(parseInt(data) == 1){
						common.alert({content:"예탁 내역 작업을 완료하였습니다.",action:function(){
							location.reload();
						}});
					}else{
						common.alert({content:"예탁 내역 작업에 실패하였습니다.",action:function(){
							
						}});
					}
					return true;
				}});
				return true;
			}});
					
			
				
		}catch (e) {
			alert(e);
			return false;
		}
		return false;
	}
	,myRippleWithdrawal:function(info){
		try{
			var form = $("#myRippleForm");
			var amount = $("#AMOUNT2").val();
			if (amount == "") {
		        	alert("출금 신청 금액을 입력하세요.");
		        	$("AMOUNT2").focus();
		        	return;
		   	}
			
			if (eval(amount) < 30000) {
		        	alert("최소 30,000원 이상 인출 하셔야 됩니다.");
		        	$("AMOUNT2").focus();
		        	return;
		   	}
			
			var myprice = exrp.uncommify($("#TOTAL").val());
			
			if(parseFloat(myprice) < parseFloat(amount)) {
				alert("출금 신청액이 보유액보다 큽니다. 확인 바랍니다.!!");
		        $("AMOUNT2").focus();
		        return;
			}
			$("#AMOUNT").val(amount);
			$("#PRICE").val($("#PRICE2").val());
			common.confirm({content:"요청하신 작업을 계속진행하시겠습니까?",action:function(){
				$(form).attr({method:"post",action:"/exrp/withdrawal/setWithdrawal.do"});
				common.ajaxSubmit({form:form,paramType:"text",action:function(data){
					try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
					common.closeLayout("withdrawalPop");
					if(parseInt(data) == 1){
						common.alert({content:"예탁 내역 작업을 완료하였습니다.",action:function(){
							location.reload();
						}});
					}else{
						common.alert({content:"예탁 내역 작업에 실패하였습니다.",action:function(){
							
						}});
					}
					return true;
				}});
				return true;
			}});
					
			
				
		}catch (e) {
			alert(e);
			return false;
		}
		return false;
	},
	drawingChart:function(offset, day, time ) {
		var data = [];
		var receiveData;
		var address = "https://api.ripplecharts.com/api/offers_exercised";

	    var dtNow = exrp.getWorldDate(0, 0);
	    var dtNowDiff5 ;
	    if(time != 0){
	    	dtNowDiff5 = exrp.getTimeAdd(time);
	    }else{
	     	dtNowDiff5 = exrp.getWorldDate(offset, day);
	    }
		//alert(dtNow + "---------" + dtNowDiff5)
	    var send_opts = { //JSON Format 생성
	        base: { currency: "XRP" },
	        //counter: { currency: "KRW", issuer: "rUkMKjQitpgAM5WTGk79xpjT38DEJY283d" },
	        counter: { currency: "KRW", issuer: "rPxU6acYni7FcXzPCMeaPSwKcuS2GTtNVN" },
	        startTime: dtNowDiff5,  //"2015-02-16",
	        endTime: dtNow,    //"2015-02-17",
	        timeIncrement: "hour",
	        format: "json"
	    };

	    var request_register = $.ajax({
	        type: "POST",
	        url: address, 
	        data: JSON.stringify(send_opts),
	        contentType: "application/json; charset=utf-8",
	        dataType: "json"
	    });

	    request_register.success(function (done) {      //등록성공
	        var _offersData = JSON.stringify(done);
	        receiveData = JSON.parse(_offersData);
	        //var iLength = receiveData["results"].length;
	        //for (i = 0; i < iLength; i++) {
				//data.push(receiveData["results"][i].startTime,receiveData["results"][i].close);
	            //result_data.startTime.push(receiveData["results"][i].startTime);
	           // result_data.close.push(receiveData["results"][i].close);
	       // }
		   var chart;
			chart = new Highcharts.Chart({
				chart: {
					renderTo: 'container',
					type: 'spline',
					marginRight: 10,
					events: {
						load: function() {
							// set up the updating of the chart each second
							var series = this.series[0];  
						}
					}
				},
				title: {
					text: ''
				},
				xAxis: {
					type: 'datetime',
					tickPixelInterval: 150,
	                maxZoom: 20 * 1000
				},
				yAxis: {
					title: {
						text: 'Price'
					},
					plotLines: [{
						value: 0,
						width: 1,
						color: '#FF5E00'
					}]
				},
				tooltip: {
					formatter: function() {
							return '<b>'+ this.series.name +'</b><br/>'+
							Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
							Highcharts.numberFormat(this.y, 2) + ' XRP';
					}

				},
				legend: {
					enabled: false

				},
				exporting: {
					enabled: true
				},
				series: [{
					name: 'EXRP Currency',
					data: (function() {
						// generate an array of random data
						//    var time = (new Date()).getTime(),
						//    i;

					   // for (i = -19; i <= 0; i++) {
					   //     data.push({
					   //         x: time + i * 1000,
						//        y: Math.random()
						//    });
							var len = receiveData["results"].length;
							for (var i = 0; i < len; i++) {
								//alert(receiveData["results"][i].startTime);
								//alert(receiveData["results"][i].close);
								 data.push({
									 x: new Date(receiveData["results"][i].startTime),
									 y: receiveData["results"][i].close
								 });
							}
					   
							return data;

					})()

				}]

			});
	    });

	    request_register.error(function (done) {              //등록실패 JSon Format error, -1, false 리턴  
	       // alert("Data Failed");
	    });

	    Highcharts.setOptions({
	        global: {
	            useUTC: true
	        }
	    }); 
	},
	drawingChart2:function(offset, day, time ) {
		var data = [];
		var receiveData;
		var address = "https://api.ripplecharts.com/api/offers_exercised";

	    var dtNow = exrp.getWorldDate(0, 0);
	    var dtNowDiff5 ;
	    if(time != 0){
	    	dtNowDiff5 = exrp.getTimeAdd(time);
	    }else{
	     	dtNowDiff5 = exrp.getWorldDate(offset, day);
	    }
		//alert(dtNow + "---------" + dtNowDiff5)
	    var send_opts = { //JSON Format 생성
	        base: { currency: "XRP" },
	        //counter: { currency: "KRW", issuer: "rUkMKjQitpgAM5WTGk79xpjT38DEJY283d" },
	        counter: { currency: "KRW", issuer: "rPxU6acYni7FcXzPCMeaPSwKcuS2GTtNVN" },
	        startTime: dtNowDiff5,  //"2015-02-16",
	        endTime: dtNow,    //"2015-02-17",
	        timeIncrement: "hour",
	        format: "json"
	    };

	    var request_register = $.ajax({
	        type: "POST",
	        url: address, 
	        data: JSON.stringify(send_opts),
	        contentType: "application/json; charset=utf-8",
	        dataType: "json"
	    });

	    request_register.success(function (done) {      //등록성공
	        var _offersData = JSON.stringify(done);
	        receiveData = JSON.parse(_offersData);
	        //var iLength = receiveData["results"].length;
	        //for (i = 0; i < iLength; i++) {
				//data.push(receiveData["results"][i].startTime,receiveData["results"][i].close);
	            //result_data.startTime.push(receiveData["results"][i].startTime);
	           // result_data.close.push(receiveData["results"][i].close);
	       // }
		   var chart;
			chart = new Highcharts.Chart({
				chart: {
					renderTo: 'container2',
					type: 'spline',
					marginRight: 10,
					events: {
						load: function() {
							// set up the updating of the chart each second
							var series = this.series[0];  
						}
					}
				},
				title: {
					text: ''
				},
				xAxis: {
					type: 'datetime',
					tickPixelInterval: 150,
	                maxZoom: 20 * 1000
				},
				yAxis: {
					title: {
						text: 'Price'
					},
					plotLines: [{
						value: 0,
						width: 1,
						color: '#FF5E00'
					}]
				},
				tooltip: {
					formatter: function() {
							return '<b>'+ this.series.name +'</b><br/>'+
							Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+
							Highcharts.numberFormat(this.y, 2) + ' XRP';
					}

				},
				legend: {
					enabled: false

				},
				exporting: {
					enabled: true
				},
				series: [{
					name: 'EXRP Currency',
					data: (function() {
						// generate an array of random data
						//    var time = (new Date()).getTime(),
						//    i;

					   // for (i = -19; i <= 0; i++) {
					   //     data.push({
					   //         x: time + i * 1000,
						//        y: Math.random()
						//    });
							var len = receiveData["results"].length;
							for (var i = 0; i < len; i++) {
								//alert(receiveData["results"][i].startTime);
								//alert(receiveData["results"][i].close);
								 data.push({
									 x: new Date(receiveData["results"][i].startTime),
									 y: receiveData["results"][i].close
								 });
							}
					   
							return data;

					})()

				}]

			});
	    });

	    request_register.error(function (done) {              //등록실패 JSon Format error, -1, false 리턴  
	        //alert("Data Failed");
	    });

	    Highcharts.setOptions({
	        global: {
	            useUTC: true
	        }
	    }); 
	},
	csBoardRegPop: function (info){
		$.ajax({
			type:'post',
			//url: "/member/administrator/memberManager/memberManagerInfo.do",
			url: "/exrp/csboard/csBoardRegPop.do",
			dataType: "text",
			data: "MID="+info.MID,
			success: function(data) {			
				
				if($(data).attr("id") == "csBoardPop"){
					common.layout({
						id:"csBoardPop"
						,title:$(data).attr("title")
						,content:$(data)
						,action:exrp.setcsBoardRegPop
						,width:$(data).attr("width")
					});
				}else{
					//location.reload();
				}
				
		  	}
	});
  },
  getCsResBoardRegPop: function (info){
	  
		$.ajax({
			type:'post',
			//url: "/member/administrator/memberManager/memberManagerInfo.do",
			url: "/exrp/csboard/getCsResBoardRegPop.do",
			dataType: "text",
			data: "MID="+info.MID+"&csIdx="+info.csIdx,
			success: function(data) {			
				
				if($(data).attr("id") == "csBoardPop"){
					
					if(info.csStep == "진행"){
						common.layout({
							id:"csBoardPop"
							,title:$(data).attr("title")
							,content:$(data)
							,action:exrp.setCsResBoardRegPop
							,width:$(data).attr("width")
						});
					}else {
						common.layout({
							id:"csBoardPop"
							,title:$(data).attr("title")
							,content:$(data)
							,width:$(data).attr("width")
						});
					}
				}else{
					//location.reload();
				}
				
		  	}
	});
  },
  setcsBoardRegPop:function(){
	  try{
		
		  var form = $("#csBoardForm");
		  if(common.valid(form)){
			
			if ($("#csContent").val() == "") {
		        alert("내용을 입력하세요.");
		        $("#csContent").focus();
		        return;
		    }
			var regDate = $("#csRegDate1").val() + " " + $("#csRegTime").val() + ":" + $("#csRegTime2").val() + ":" + $("#csRegTime3").val();
		
			$("#csRegDate").val(regDate);
			
			common.confirm({content:"요청하신 작업을 계속진행하시겠습니까?",action:function(){
				$(form).attr({method:"post",action:"/exrp/csboard/setCsBoard.do"});
				common.ajaxSubmit({form:form,paramType:"text",action:function(data){
					try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
					common.closeLayout("csBoardPop");
					if(parseInt(data) == 1){
						common.alert({content:"예탁 내역 작업을 완료하였습니다.",action:function(){
							location.reload();
						}});
					}else{
						common.alert({content:"예탁 내역 작업에 실패하였습니다.",action:function(){
							
						}});
					}
					return true;
				}});
				return true;
			}});
					
		  }
				
		}catch (e) {
			alert(e);
			return false;
		}
		return false;
  },
  setCsResBoardRegPop:function(){
	  try{
		
		  var form = $("#csBoardForm");
		  if(common.valid(form)){
			
			if ($("#crContent").val() == "") {
		        alert("내용을 입력하세요.");
		        $("#crContent").focus();
		        return;
		    }
			var regDate = $("#crRegDate1").val() + " " + $("#crRegTime").val() + ":" + $("#crRegTime2").val() + ":" + $("#crRegTime3").val();
			
			$("#crRegDate").val(regDate);
			
			common.confirm({content:"요청하신 작업을 계속진행하시겠습니까?",action:function(){
				$(form).attr({method:"post",action:"/exrp/csboard/setCsResBoard.do"});
				common.ajaxSubmit({form:form,paramType:"text",action:function(data){
					try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
					common.closeLayout("csBoardPop");
					if(parseInt(data) == 1){
						common.alert({content:"예탁 내역 작업을 완료하였습니다.",action:function(){
							location.reload();
						}});
					}else{
						common.alert({content:"예탁 내역 작업에 실패하였습니다.",action:function(){
							
						}});
					}
					return true;
				}});
				return true;
			}});
					
		  }
				
		}catch (e) {
			alert(e);
			return false;
		}
		return false;
  },deleteCsBoard :function(){
	  
	  	form = $("#csBoardListForm");
		var checkboxInfo = common.checkboxInfo("csIdx");
		if(checkboxInfo.checked < 1){
			common.alert({content:"삭제 대상을 선택해주세요.",action:function(){checkboxInfo.firstNode.focus();}});
			return false;
		}

		common.confirm({content:"선택한 데이타를 삭제하시겠습니까??",action:function(){
			$(form).attr({method:"post",action:"/exrp/board/deleteCsBoard.do"});
			common.ajaxSubmit({form:form,paramType:"text",action:function(data){
				try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
				if(parseInt(data) > 0){
					common.alert({content:"선택한 대상이 삭제되었습니다.",action:function(){location.reload();}});
				}else{
					common.alert({content:"자료삭제에 실패하였습니다.",action:function(){location.reload();}});
				}
			}});
			return true;
		}});
  },exrpDepositExcel: function (){
	  
	  var form = $("#depositListForm");
	  $.ajax({
		  	type:"POST",	
		    async: true,
		    dataType: "JSON",
		    paramType: "JSON",
		    url : "/exrp/homeSys/getDepositExcel.do",
		    data : form.serialize(),
		    complete : function(){},
		    success : function(dataVal){
	  	
		    	if(dataVal.RsltCd == "0000"){    		
		    		
		    		//callback함수 선언
					exrp.fn_FileDown(dataVal.EXCEL_FILE_DISP_NM,dataVal.EXCEL_FILE_NM,"Y");
		    	}
		    },
		    error : function(xhr,st,err){
	          alert("파일명 생성중 오류 발생","st:" + st, "xhr" + xhr, "err:" + err);
		    }
	  });
   },exrpWithdrawalExcel: function (){
		  
		  var form = $("#withdrawalListForm");
		  $.ajax({
			  	type:"POST",	
			    async: true,
			    dataType: "JSON",
			    paramType: "JSON",
			    url : "/exrp/homeSys/getWithdrawalExcel.do",
			    data : form.serialize(),
			    complete : function(){},
			    success : function(dataVal){
		  	
			    	if(dataVal.RsltCd == "0000"){    		
			    		
			    		//callback함수 선언
						exrp.fn_FileDown(dataVal.EXCEL_FILE_DISP_NM,dataVal.EXCEL_FILE_NM,"Y");
			    	}
			    },
			    error : function(xhr,st,err){
		          alert("파일명 생성중 오류 발생","st:" + st, "xhr" + xhr, "err:" + err);
			    }
		  });
   },exrpMemberExcel: function (){
		  
		  var form = $("#memberManagerListForm");
		  $.ajax({
			  	type:"POST",	
			    async: true,
			    dataType: "JSON",
			    paramType: "JSON",
			    url : "/exrp/member/getMemberExcelList.do",
			    data : form.serialize(),
			    complete : function(){},
			    success : function(dataVal){
		  	
			    	if(dataVal.RsltCd == "0000"){    		
			    		
			    		//callback함수 선언
						exrp.fn_FileDown(dataVal.EXCEL_FILE_DISP_NM,dataVal.EXCEL_FILE_NM,"Y");
			    	}
			    },
			    error : function(xhr,st,err){
		          alert("파일명 생성중 오류 발생","st:" + st, "xhr" + xhr, "err:" + err);
			    }
		  });
   },
   fn_FileDown: function(disFileNm, fileNm, deleteYN) {/*실제 파일 다운로드*/
		if(deleteYN != "Y"){deleteYN = "N";};
		
		var formId = 'DownForm';

		if ($("#" + formId) != null && $("#" + formId).attr("id") != null) {
			$("#" + formId).remove();
		}

		var form = $('<form action="/exrp/download/downloadFile.do" method="post" name="' + formId + '" id="' + formId + '"></form>');
		$(form).appendTo('body');
		
		$('<input type="hidden" name="FILE_DISP_NM" value="'+ encodeURIComponent(disFileNm) + '" />').appendTo(form);
		$('<input type="hidden" name="FILE_NM" value="'+ encodeURIComponent(fileNm) + '" />').appendTo(form);
		$('<input type="hidden" name="FILE_DELETE_YN" value="'+deleteYN+ '" />').appendTo(form);	
		
		form.submit();
	},exrpRegularDepositExcel: function (){
		  
		  var form = $("#depositListForms");
		  $.ajax({
			  	type:"POST",	
			    async: true,
			    dataType: "JSON",
			    paramType: "JSON",
			    url : "/exrp/homeSys/getRegularDepositExcel.do",
			    data : form.serialize(),
			    complete : function(){},
			    success : function(dataVal){
		  	
			    	if(dataVal.RsltCd == "0000"){    		
			    		
			    		//callback함수 선언
						exrp.fn_FileDown(dataVal.EXCEL_FILE_DISP_NM,dataVal.EXCEL_FILE_NM,"Y");
			    	}
			    },
			    error : function(xhr,st,err){
		          alert("파일명 생성중 오류 발생","st:" + st, "xhr" + xhr, "err:" + err);
			    }
		  });
	   },getMemberAccountBalance: function (){
					 
			  $.ajax({
				  	type:"POST",	
				    async: true,
				    dataType: "JSON",
				    paramType: "JSON",
				    url : "/exrp/home/getMemberAccountBalance.do",
				    data : '',
				    complete : function(){},
				    success : function(dataVal){		  	
				    	if(dataVal.RsltCd == "0000"){    
				    
				    		$("#myripplevol").html(dataVal.myripplevol);
				    		$("#mykrwvol").html(dataVal.mykrwvol);
				    		$("#myusdvol").html(dataVal.myusdvol);
				    	}
				    },
				    error : function(xhr,st,err){
			          alert("","st:" + st, "xhr" + xhr, "err:" + err);
				    }
			  });
		   },
	setCalcBuyRipple:function (myprice, mbname){
		
		var rate = 5;
		if(myprice == '0'){
			alert("예탁금액이 없습니다. 예탁하여 주세요!!");
			return;
		}
		var myprice = parseFloat(price);
		var req = $("#REQ_AMOUNT").val();
		
		if(req == "" || parseInt(req) < 10000){
			alert("최소 구매수량은 10,000XRP 입니다.");
			return;
		}else{
			req = parseFloat(req);
		}
		
		var buyperripple = parseFloat($("#BUY_PER_RIPPLE").val());
		
		var amount = buyperripple * req;
		
		$("#AMOUNT").val(amount);
		
		var fee = req *  parseFloat(rate) /100 ; ;
		$("#FEE").val(fee);
		
		var price = req - fee;
		
		$("#POSSIBLE_AMOUNT").val(price);
		
		if(price > amount){
			alert(mbname +"님께서는 " + req +" XRP 구매가 불가능합니다. 예탁금을 더 예탁해 주시기 바랍니다.");
			$("#AUTH").val("N");
		}else{
			alert(mbname +"님께서는 " + req +" XRP 구매가 가능합니다.");
			$("#AUTH").val("Y");
		}
	},
	setBuyRipple:function (info){
		try{
			var form = $("#buyMoneyForm");
			if ($("#REQ_AMOUNT").val() == "") {
		        alert("구매대행리플수량(XRP)를 입력하세요.");
		        $("#FEE").focus();
		        return;
		    }
			if ($("#AUTH").val() == "N") {
		        alert("리플구매대행이 불가능합니다. 확인버튼 클릭을 해주세요.");
		        $("#REQ_AMOUNT").focus();
		        return;
		    }
			
			if(common.valid(form)){
				common.confirm({content:"요청하신 작업을 계속진행하시겠습니까?",action:function(){
					$(form).attr({method:"post",action:"/exrp/myripple/setMyRippleBuy.do"});
					common.ajaxSubmit({form:form,paramType:"text",action:function(data){
						try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
						common.closeLayout("withdrawalPop");
						if(parseInt(data) == 1){
							common.alert({content:"리플구매대행 내역 작업을 완료하였습니다.",action:function(){
								location.reload();
							}});
						}else{
							common.alert({content:"리플구매대행 작업에 실패하였습니다.",action:function(){
								
							}});
						}
						return true;
					}});
					return true;
				}});
					
			}
				
		}catch (e) {
			alert(e);
			return false;
		}
		return false;
	},deleteBuyRipple:function (info){
		form = $("#depositListForm");
		var checkboxInfo = common.checkboxInfo("TNO");
		if(checkboxInfo.checked < 1){
			common.alert({content:"삭제 대상을 선택해주세요.",action:function(){checkboxInfo.firstNode.focus();}});
			return false;
		}

		common.confirm({content:"선택한 데이타를 삭제하시겠습니까??",action:function(){
			$(form).attr({method:"post",action:"/exrp/buyripple/deleteBuyRipple.do"});
			common.ajaxSubmit({form:form,paramType:"text",action:function(data){
				try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
				if(parseInt(data) > 0){
					common.alert({content:"선택한 대상이 삭제되었습니다.",action:function(){location.reload();}});
				}else{
					common.alert({content:"자료삭제에 실패하였습니다.",action:function(){location.reload();}});
				}
			}});
			return true;
	}});
	},getBuyRippleDetail:function(info){ //리플구매대행

		$.ajax({
			type:'post',
			//url: "/member/administrator/memberManager/memberManagerInfo.do",
			url: "/exrp/buyripple/getBuyRippleDetail.do",
			dataType: "text",
			data: "TNO="+info.TNO,
			success: function(data) {
			
				if(info.STEP == "N"){
					if($(data).attr("id") == "buyMoneyPop"){
						common.layout({
							id:"buyMoneyPop"
							,title:$(data).attr("title")
							,content:$(data)
							,action:exrp.setBuyRipple
							,width:$(data).attr("width")
						});
					}else{
						//location.reload();
					}
				}else{
					if($(data).attr("id") == "buyMoneyPop"){
						common.layout({
							id:"buyMoneyPop"
							,title:$(data).attr("title")
							,content:$(data)
							,width:$(data).attr("width")
						});
					}else{
						//location.reload();
					}
				}
		  	}
		});
	},
	getBuyFeePop: function (info){
		$.ajax({
			type:'post',
			//url: "/member/administrator/memberManager/memberManagerInfo.do",
			url: "/exrp/buymoney/getBuyFeePop.do",
			dataType: "text",
			data: "MID="+info.MID,
			success: function(data) {   
				
					common.layout({
						id:"buyMoneyPop"
						,title:$(data).attr("title")
						,content:$(data)
						,action:exrp.setBuyPolicy
						,width:$(data).attr("width")
					});
				
				
		  	}
		});
	},
	setBuyPolicy:function () {
		form = $("#buyMoneyForm");
		if(common.valid(form)){
			common.confirm({content:"요청하신 작업을 계속진행하시겠습니까?",action:function(){
				$(form).attr({method:"post",action:"/exrp/myripple/setBuyPolicy.do"});
				common.ajaxSubmit({form:form,paramType:"text",action:function(data){
					try{data = jQuery.parseJSON(data);}catch (e) {data = {"result":0};}
					common.closeLayout("withdrawalPop");
					if(parseInt(data) == 1){
						common.alert({content:"리플구매대행 내역 작업을 완료하였습니다.",action:function(){
							location.reload();
						}});
					}else{
						common.alert({content:"리플구매대행 작업에 실패하였습니다.",action:function(){
							
						}});
					}
					return true;
				}});
				return true;
			}});
				
		}
	},
	regularDateAdd: function (sDate, nDay, sObj, eObj, cObj, caObj){
		
	  var sdarr = nDay.split(":");
	  var sd = sdarr[0];
	  var rate = sdarr[1];
	  var ed = "";
	  $("#RATE").val(rate);
	  if(sDate == "") sDate = $("#"+sObj).val();
	  if(sDate == ""){
		  alert("정기예탁일을 입력하세요!!");
		  return;
	  }
	  
	  $("#TERM").val(sd);
	  var yy = parseInt(sDate.substr(0, 4), 10);
	  var mm = parseInt(sDate.substr(5, 2), 10);
	  var dd = parseInt(sDate.substr(8), 10);
	  d = new Date(yy, mm - 1, dd + parseInt(sd));
	  
	  yy = d.getFullYear();
	  mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
	  dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
	 
	  ed = '' + yy + '-' +  mm  + '-' + dd;
	  
	  $("#"+eObj).val(ed);
	  
	  var yy2 = parseInt(sDate.substr(0, 4), 10);
	  var mm2 = parseInt(sDate.substr(5, 2), 10);
	  var dd2 = parseInt(sDate.substr(8), 10);
	  etc = new Date(yy2, mm2 - 1, dd2 + (parseInt(sd)-1));
	
	  yy2 = etc.getFullYear();
	  mm2 = etc.getMonth() + 1; mm2 = (mm2 < 10) ? '0' + mm2 : mm2;
	  dd2 = etc.getDate(); dd2 = (dd2 < 10) ? '0' + dd2 : dd2;
	 
	  etc = '' + yy2 + '-' +  mm2  + '-' + dd2;
	  
	  $("#"+cObj).val(etc);
	  var yy3 = parseInt(sDate.substr(0, 4), 10);
	  var mm3 = parseInt(sDate.substr(5, 2), 10);
	  var dd3 = parseInt(sDate.substr(8), 10);
	  
	  etc3 = new Date(yy3, mm3 - 1, dd3 + (parseInt(sd)+2));
	
	  yy3 = etc3.getFullYear();
	  mm3 = etc3.getMonth() + 1; mm3 = (mm3 < 10) ? '0' + mm3 : mm3;
	  dd3 = etc3.getDate(); dd3 = (dd3 < 10) ? '0' + dd3 : dd3;
	 
	  etc3 = '' + yy3 + '-' +  mm3  + '-' + dd3;
	  $("#"+caObj).val(etc3);
	  
	  /*예탁기간 3,4,5개월
	  : [수량(XRP)+[{(90일(3개월)/365일)*수량(XRP)}*1%]]-
	    [[[[수량(XRP)+[{(90일(3개월))/365일)*수량(XRP)}*1%]]-(수량(XRP))]*3.3%]

	  예탁기간 6,7,8,9,10,11개월
	  : [수량(XRP)+[{(180일(6개월)/365일)*수량(XRP)}*2.4%]]-
	    [[[[수량(XRP)+[{(180일(6개월))/365일)*수량(XRP)}*2.4%]]-(수량(XRP))]*3.3%]

	  12개월 이상
	  :{수량(XRP)+(수량(XRP)*5%)}-
	    [{(수량(XRP)+(수량(XRP)*5%)}-{(수량(XRP)*3.3%}]*/
	  var amount = $("#AMOUNT").val();
	  if(amount == ''){
		  alert('리플수량을 입력하세요!!');
		  return;
	  }
	  amount = parseFloat(exrp.uncommify(amount));
	 
	  rate   = parseFloat(rate);
	  sd     = parseFloat(sd);
	  var result = 0.0;
	  var tax    = 15.4;
	  if(rate == 1){
		  /*result = amount + ((sd/365) * (amount *(1/100)));
		  result = result - (result - (amount * (3.3/100)));*/
		  result = amount +((amount * rate/100)* 0.846 * sd/365);
	  }else if(rate == 2.4){
		  /*
		  result = amount + ((sd/365) * (amount *(2.4/100)));
		  result = result - (result - (amount * (3.3/100)));*/
		  result = amount +((amount * rate/100)* 0.846 * sd/365);
	  }else if(rate == 5){
		 // result = (amount + (amount * (5/100))) - ((amount + (amount * (5/100))) - (amount * (3.3/100)));
		  /*alert((amount + (amount * (5/100))))
		  alert(((amount + (amount * (5/100))) - (amount * (3.3/100))))*/
		  result = amount +((amount * rate/100)* 0.846 * sd/365);
	  }
	 
	  var total = parseFloat(result).toFixed(0);
	  //alert("result:"+ (amount + result))
	  $("#RIPPLE_AMOUNT").val( total);
	  $("#CLOSE_AMOUNT").val( total);
	  $("#CLOSE_A_AMOUNT").val( total);
	}
};

//START 리플유효성검사 추가 20150221
/*BigInteger.valueOf = nbv;
BigInteger.prototype.toByteArrayUnsigned = function () {
    var ba = this.toByteArray();
    if (ba.length) {
        if (ba[0] == 0)
            ba = ba.slice(1);
        return ba.map(function (v) {
            return (v < 0) ? v + 256 : v;
        });
    } else
        return ba;
};*/

var Ripple = {};

/*(function () {
    var B58 = Ripple.Base58 = {
        alphabet: "rpshnaf39wBUDNEGHJKLM4PQRST7VWXYZ2bcdeCg65jkm8oFqi1tuvAxyz",
        base: BigInteger.valueOf(58),
        decode: function (input, minLength) {
            var bi = BigInteger.valueOf(0);
            for (var i = 0; i < input.length; i++) {
                var alphaIndex = B58.alphabet.indexOf(input[i]);
                if (alphaIndex < 0)
                    throw "Invalid character";
                bi = bi.multiply(B58.base).add(BigInteger.valueOf(alphaIndex));
            }
            var bytes = bi.toByteArrayUnsigned();
            while (bytes.length < minLength)
                bytes.unshift(0);
            return bytes;
        }
    };

    var browser = navigator.userAgent.toLowerCase();
        if (browser.indexOf("msie") != -1 && getInternetExplorerVersion() <= 8) {
            $("#registration-ie8").css("display","block");
        }        
})();*/

Ripple.Address = function (bytes) {
    if ("string" == typeof bytes)
        bytes = Ripple.Address.decodeString(bytes);
    this.hash = bytes;
};
Ripple.Address.decodeString = function (string) {
    var bytes = Ripple.Base58.decode(string, 25);
    var hash = bytes.slice(0, 21);
    var checksum = Crypto.SHA256(Crypto.SHA256(hash, { asBytes: true }), { asBytes: true });
    if (checksum[0] != bytes[21] ||
                checksum[1] != bytes[22] ||
                checksum[2] != bytes[23] ||
                checksum[3] != bytes[24])
        throw "Checksum validation failed!";
    var version = hash.shift();
    if (version != 0)
        throw "Version " + version + " not supported!";
    return hash;
};

function check_address(address) {
    try {
        Ripple.Address(address);
        return true;
    } catch (err) {
        
        //console.log(err);
        return false;
    }
} 
//END


$("#rippleAddres").focusin(function () {
//    var receiver = document.getElementById('registerModule').contentWindow;
//    receiver.RippleWebSocket();
});
$("#rippleAddres").focusout(function () {
    InspectReppleAddress();
});

function InspectReppleAddress() {
    $("#registration-ripple-address-confirm").css("color", "black");
    $("#registration-ripple-address-confirm").text("유효성 검사 중 ...");

    var ripple_address = $("#rippleAddress").val();

    ripple_address = $.trim(ripple_address);

    if (check_address(ripple_address)) {
        $("#registration-ripple-address-confirm").css("color", "black");
        $("#registration-ripple-address-confirm").text("중복 검사 중 ...");

        ReciveRippleAddress(1);
    }
    else {
        ReciveRippleAddress(0);
    }
}

function CheckRippleAddress() {

    _register_ripple_address = $("#rippleAddres").val();
    _register_ripple_address = $.trim(_register_ripple_address);
    exrp.getMUserRippleAddressChk(_register_ripple_address);
}

function ReciveRippleAddress(index) {
 
    if (index == 0) {
        $("#registration-ripple-address-confirm").css("color", "red");
        $("#registration-ripple-address-confirm").text("유효하지 않은 리플주소입니다.");
        _register_ripple_address_check = false;
    }
    else {
        CheckRippleAddress();
    }
}
