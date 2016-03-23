<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<%@ include file="../tiles/total/middleTop.jsp" %>

<div class="con_title">
	  <li>
      	<img src="/images/sub/marketprice_title.png" />
      </li>
  </div> 
<div class="content">
    	<div class="content_in">
            <div class="con_info">
            <!-- 데이타 갱신 버튼 시작 
            <ul class="time" style="margin-left:40px">
				<li><a href="#2222" onclick="drawingChart(0, 0, -1)">1h</a></li>
				<li><a href="#2222" onclick="drawingChart(0, 0, -4)">1h</a></li>
				<li><a href="#2222" onclick="drawingChart(0, -1, 0)">1h</a></li>
				<li><a href="#2222" onclick="drawingChart(0, -7, 0)">1h</a></li>
			</ul>
			-->
<!-- 데이타 갱신 버튼 종료 -->
            	<div class="marketprice_box" id="container" >
                
                </div>
                
                <div class="market_info">
                	<div class="market_info_box">
                    	<li class="market_title"><img src="/images/sub/price_1.png" /></li>
                        <li class="no_box"><p id="close"></p></li>
                    </div>
                    
                    <div class="market_info_box">
                    	<li class="market_title"><img src="/images/sub/price_2.png" /></li>
                        <li class="no_box"><p id="high"></p></li>
                    </div>
                    
                    <div class="market_info_box">
                    	<li class="market_title"><img src="/images/sub/price_3.png" /></li>
                        <li class="no_box"><p id="low"></p></li>
                    </div>
                </div>
                
                <div class="market_info">
                	<div class="market_info_box_down">
                    	<li class="market_title"><img src="/images/sub/price_4.png" /></li>
                        <li class="no_box"><p id="base" class="numberic"></p></li>
                    </div>
                    
                    <div class="market_info_box_down">
                    	<li class="market_title"><img src="/images/sub/price_5.png" /></li>
                        <li class="no_box"><p id="asks"></p></li>
                    </div>
                    
                    <div class="market_info_box_down">
                    	<li class="market_title"><img src="/images/sub/price_6.png" /></li>
                        <li class="no_box"><p id="bids"></p></li>
                    </div>
                </div>
            </div>
        </div>    
    </div>

<script type="text/javaScript" language="javascript">

	$(document).ready(function(){
	    /* drawingChart(0,-7,0);
	    exrp.GetRippleCurrentData();
	    exrp.GetRippleChartData();
	    exrp.asks(1, 'M');
	    exrp.a sks(2, 'M');
	    */
	    sendPost("${contextPath}/main/selectXrpTradeInfo.do", "", "fn_setXrpTradeInfo");
	});
	
	function fn_setXrpTradeInfo(data){
		
		if(data.isSuccess){
			$("#asks").html(data.xrpVo.asksVolume);
			$("#bids").html(data.xrpVo.bidsVolume);
			$("#base").html(data.xrpVo.baseVolume);
			//$("#counterVolume").html(data.xrpVo.counterVolume + '<img src="/images/common/krw_small.png" />');
			$("#high").html(data.xrpVo.highVolume);
			$("#low").html(data.xrpVo.lowVolume);
			$("#close").html(data.xrpVo.closeVolume );
			
			//gapClose = data.xrpVo.closeVolume - data.xrpVo.beforeCloseVolume;
        	
        	//$("#gapVolume").html(exrp.r8round(gapClose,2));
        	//$("#gapVolumePer").html(exrp.r8round(gapClose*10,2));
        	
        	//$("#spreadVolume").html(fn_numberRound(data.xrpVo.bidsVolume - data.xrpVo.asksVolume,4));
        	
		} else {
			alert("조회 실패");
		}
	}
	
	/* function getWorldDate(txOffSet, dayDiff) {
	  var now = new Date();
	  var tz = now.getTime() + (now.getTimezoneOffset() * 60000) + (txOffSet * 3600000);
	  now.setTime(tz);
	  now.setDate(now.getDate() + dayDiff);
	  var s =
		leadingZeros(now.getFullYear(), 4) + '-' +
		          leadingZeros(now.getMonth() + 1, 2) + '-' +
		          leadingZeros(now.getDate(), 2)+ ' ' +
	
		          leadingZeros(now.getHours(), 2) + ':' +
		          leadingZeros(now.getMinutes(), 2) + ':' +
		          leadingZeros(now.getSeconds(), 2);
	
	  return s;
	}
	
	function KoreaTimeFromWorldTime(dtTime) {
		var now = new Date(dtTime);
		var tz = now.getTime() + (now.getTimezoneOffset() * 60000) + (9 * 3600000);
		now.setTime(tz);
	
		var s =
		leadingZeros(now.getFullYear(), 4) + '-' +
		          leadingZeros(now.getMonth() + 1, 2) + '-' +
		          leadingZeros(now.getDate(), 2)+ ' ' +
	
		          leadingZeros(now.getHours(), 2) + ':' +
		          leadingZeros(now.getMinutes(), 2) + ':' +
		          leadingZeros(now.getSeconds(), 2);
	
		return s;
	}
	
	function leadingZeros(n, digits) {
		var zero = '';
		n = n.toString();
	
		if (n.length < digits) {
			for (i = 0; i < digits - n.length; i++)
				zero += '0';
		}
		return zero + n;
	}
	
	function drawingChart(offset, day, time ) {
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
		        alert("Data Failed");
		    });
	
		    Highcharts.setOptions({
		        global: {
		            useUTC: true
		        }
		    }); 
		} */


</script>

