<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../include/taglib.jsp" %>

<!-- 미들 탑 시작 -->
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="<c:url value='/js/exrp.js'/>"></script>

<div class="middle_top">
    	<div class="middle_in">
            <div class="middle_left">
            	<div class="volume">
                	<div class="middle_title"><img src="/images/common/volume_blue.png" /></div>
                    <div class="volume_number">
                    	<li id="counterVolume" class="numberic"><img src="/images/common/krw_small.png" /></li>
                        <li id="baseVolume" class="numberic"><img src="/images/common/xrp_small.png" /></li>
                    </div>
                    <div class="kakao">
					<img src="/images/common/kakao.png" />
				</div>
                </div>
				
                <div class="present">
                	<div class="present_title"><img src="/images/common/present_value.png" /></div>
                    <div class="present_number">
                    	<li id="closeVolume" class="numberic"><img src="/images/common/krw_big.png" /></li>                        
                    </div>    
                    <div class="contrast">
                    	<li class="contrast_title"><img src="/images/common/24h_contrast.png" /></li>
                        <li class="contrast_number" style="margin-left:35px;"><p id="gapVolume"></p>KRW</li>
                        <li class="contrast_number"><p id="gapVolumePer"></p>%</li>
                    </div>                    
                </div>
                
                <div class="price">
                	<div class="price_title"><img src="/images/common/market_price.png" /></div>
                    <div class="price_graph" id="container2">                    </div>
                </div>
            </div>
            <div class="middle_right">
            	<div class="chart_number">
                	<div class="chart_1">
                    	<li><img src="/images/common/high_value.png" /></li>
                        <li id="highVolume" class="numberic"></li>
                    </div>
                    
                    <div class="chart_1" style="margin-right:0;">
                    	<li><img src="/images/common/low_value.png" /></li>
                        <li id="lowVolume" class="numberic"></li>                    
                    </div>
                    <div class="chart_1">
                    	<li><img src="/images/common/bid.png" /></li>
                        <li id="asksVolume" class="numberic"></li>
                    </div>
                    
                    <div class="chart_1" style="margin-right:0;">
                    	<li><img src="/images/common/offer.png" /></li>
                        <li id="bidsVolume" class="numberic"></li>                    
                    </div>
                    <div class="chart_2">
                    	<li><img src="/images/common/volume.png" /></li>
                        <li id="baseVolume1" class="numberic"></li>                    
                    </div>
                    <div class="chart_2">
                    	<li><img src="/images/common/spread.png" /></li>
                        <li id="spreadVolume" class="numberic" ></li>                     
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 미들 탑 종료 -->
    
<script type="text/javaScript" language="javascript">
$(document).ready(function(){
	
    /* exrp.GetRippleChartData();
    exrp.asks(1,'S');
    exrp.asks(2,'S');
    exrp.GetRippleCurrentData();
	exrp.drawingChart(0,-7,0);
	exrp.drawingChart2(0,-1,0); */
	

	sendPost("${contextPath}/main/selectXrpTradeInfo.do", "", "fn_selectXrpTradeInfo");
	var param = {
				chartType : 'w'
		}
	sendPost("${contextPath}/main/selectXrpChartData.do", param, "fn_chartData");
	
});

	function fn_selectXrpTradeInfo(data){
		
		if(data.isSuccess){
			$("#asksVolume").html(data.xrpVo.asksVolume);
			$("#bidsVolume").html(data.xrpVo.bidsVolume);
			$("#baseVolume1").html(data.xrpVo.baseVolume);
			$("#baseVolume").prepend(data.xrpVo.baseVolume );
			$("#counterVolume").prepend(data.xrpVo.counterVolume);
			$("#highVolume").html(data.xrpVo.highVolume);
			$("#lowVolume").html(data.xrpVo.lowVolume);
			$("#closeVolume").prepend(data.xrpVo.closeVolume );
			
			gapClose = data.xrpVo.closeVolume - data.xrpVo.beforeCloseVolume;
        	
        	$("#gapVolume").html(exrp.r8round(gapClose,2));
        	$("#gapVolumePer").html(exrp.r8round(gapClose*10,2));
        	
        	$("#spreadVolume").html(fn_numberRound(data.xrpVo.bidsVolume - data.xrpVo.asksVolume, 4));
        	
		} else {
			alert("조회 실패");
		}
	}
	
	function fn_chartData(data){
		if(data.isSuccess){
			var $container = $("#container");
			if($container.length > 0){
				fn_drawingChart(data.chartDataW , 'container');
			}
			
			var $container2 = $("#container2");
			if($container2.length > 0){
				fn_drawingChart(data.chartDataD , 'container2');
			}
			
		} else {
			
		}
	}
	
	function fn_drawingChart(chartData, objId){
		var data = [];
		var chart;
		Highcharts.setOptions({
			global: {
				useUTC: true
			}
		});
		chart = new Highcharts.Chart({
			chart: {
				renderTo: objId,
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
                //maxZoom: 20 * 1000
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
				name: 'XRPGATE Currency',
				data: (function() {
					
						var len = chartData.length;
						for (var i = 0; i < len; i++) {
							//var dateStr = new Date(chartData[i].startTime);
							var dateStr = chartData[i].startTime;
							var a=dateStr.split(" ");
							var d=a[0].split("-");
							var t=a[1].split(":");
							var startTime = new Date(d[0],(d[1]-1),d[2],t[0],t[1],t[2]);
							var sTime = Date.UTC(d[0],(d[1]-1),d[2],t[0],t[1],t[2]);
							 data.push({
								 x: sTime,
								 y: chartData[i].closeVolume
							 });
						}
				   
						return data;

				})()

			}]

		});
		
	}
</script>
