<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/taglib.jsp" %>

<style type="text/css">
#slide_wrap { width:100%;  height:417px; float:left;  overflow:hidden; }
#main_bn { height:417px; }
#main_bn li {  float:left; }
 
</style>
	<!--본문 시작-->
<div id="slide_wrap">
	<div id="main_bn">
        <li><img src="images/main/main_visual01.png" width="100%" alt="" /></li>
        <li><img src="images/main/main_visual02.png" width="100%" alt="" /></li>
        <li><img src="images/main/main_visual03.png" width="100%"alt="" /></li>
    </div>
</div>
<!-- 미들 탑 임포트 -->
    <%@ include file="../tiles/total/middleTop.jsp" %>
    
    <div class="icon_menu">
    	<div class="icon_menu_in">
	        <p>리플 공식 한국 거래소 XRP GATE는 고객중심의 최상의 시스템 안정성과 <br>검증된 기술을 기반으로 리플 거래를 선도합니다.</p>
            <div class="icon_menu_img">
            	<li><img src="images/main/icon_nav00.png" /></li>
                <li><a href="${contextPath}/trade/callAccountTransactions.do"><img src="images/main/icon_nav01.png" /></a></li>
                <li><a href="${contextPath}/trade/callAccountTransactions.do"><img src="images/main/icon_nav02.png" /></a></li>
                <li>
                	<a href="https://signin.gatehub.net/oauth/authorize?response_type=token&client_id=6e7f0384-2fa1-4ec2-92ea-cfe5f3725c79&redirect_uri=https:%2F%2Fwallet.gatehub.net%2F%23%2Ftoken&scope=public&state=" target="_blank">
                	<img src="images/main/icon_nav03.png" />
                	</a>
                </li>
                <li><a href="${contextPath}/company/rippleintro.do"><img src="images/main/icon_nav04.png" /></a></li>
            </div>
        </div>
    </div>
    
    <div class="trade_price">
    	<p><img src="images/main/trade_price.png" /></p>
        <!--시세 그래프 시작-->
        <div class="trade_btn">
            <li><a href="#" name="btnChart" data-type="d"><img src="images/main/graph_1d.png" /></a></li>
            <li><a href="#" name="btnChart" data-type="w"><img src="images/main/graph_1w.png" /></a></li>
            <li><a href="#" name="btnChart" data-type="m"><img src="images/main/graph_1m.png" /></a></li>
            <li><a href="#" name="btnChart" data-type="y"><img src="images/main/graph_1y.png" /></a></li>
        </div>
        <div class="trade_graph" id="container">
        
        </div>
        <!--시세그래프 끝-->
    </div>
    
    <div class="ripple_world">
    	<p><a href="#"><img src="images/main/ripple_world.png" width="100%" /></a></p>    
    </div>
    
    <div class="tranding_record">
    	<div class="tranding_record_in">
            <div class="table_box">
                <p><img src="images/main/tranding_record.png" /></p>
                <div class="record_table">
                	<table width="350px;" cellpadding="0" cellspacing="0" >
                        <tr class="table_title">
                            <td>체결시각</td>
                            <td>거래량</td>
                            <td>체결가</td>
                        </tr>
                        <c:forEach var="result" items="${completeTrade}" varStatus="status">
                    	<tr class="table_con data" >
                    		<td class="con_right">${result.requestDt}</td>
                        	<td class="con_center numberic">${result.requestQty}</td>
                            <td class="con_right numberic">${result.requestMoney}</td>
                        </tr>
                    	</c:forEach>
                    </table>
                </div>
            </div>
            
            <div class="table_box">
                <p><img src="images/main/buy.png" /></p>
                <div class="record_table">
                	<table width="350px;" cellpadding="0" cellspacing="0" >
                        <tr class="table_title">
                            <td>누적(XRP)</td>
                            <td>가격(KRW)</td>
                            <td>수량(XRP)</td>
                        </tr>
                        <c:forEach var="result" items="${buyTrade}" varStatus="status">
                    	<tr class="table_con data" >
                    		<td class="con_right numberic">${result.rowSum}</td>
                        	<td class="con_center numberic">${result.requestMoney}</td>
                            <td class="con_right numberic">${result.requestQty}</td>
                        </tr>
                    	</c:forEach>
                    </table>
                </div>
            </div>
            
            <div class="table_box">
                <p><img src="images/main/sell.png" /></p>
                <div class="record_table">
                	<table width="350px;" cellpadding="0" cellspacing="0" >
                        <tr class="table_title">
                            <td>수량(XRP)</td>
                            <td>가격(KRW)</td>
                            <td>누적(XRP)</td>
                        </tr>
                        <c:forEach var="result" items="${sellTrade}" varStatus="status">
                    	<tr class="table_con data" >
                    		<td class="con_right numberic">${result.requestQty}</td>
                        	<td class="con_center numberic">${result.requestMoney}</td>
                            <td class="con_right numberic">${result.rowSum}</td>
                        </tr>
                    	</c:forEach>
                    </table>
                </div>
            </div>
    	</div>
    </div>
	<!--본문 끝-->

<script type="text/javaScript" language="javascript">

	$(document).ready(function(){
		$('#main_bn').ulslide({          
			statusbar: true,
			height: 417,        // 슬라이드 배너의 세로크기 조절
			affect: 'slide',      // fade로 변경시 서서히 사라지고 나타나는 형태로 바뀜
			axis: 'y',              // y로 변경시 세로슬라이드로 바뀜
			//navigator: '#main_bn_bt a',
			duration: 400,        // 배너 바뀌는 속도
			autoslide: 3000,       // 배너 바뀌는 딜레이 조절
			current : 1
		});
		
	});

	$(function(){
		$("#loginForm").attr({action:"${contextPath}/login/actionLogin.do", target:""});
// 		$("#loginForm input[name=userSe]").val("GNR");
		
		$('#password').keypress(function(e){
			if(e.which == 13){
				$("#loginForm").submit();
				return false;
			}
		});
		
		$("#button_login").bind("click", function(){
			if($("#loginForm #id").val() == ""){
				 alert("아이디를 입력하세요");
			}else if($("#loginForm #password").val() == ""){				
				alert("비밀번호를 입력하세요");
			} else{
				$("#loginForm").submit();
			}
		});
		
		$("#phoneForm").attr({action:"${contextPath}/customer/insertPhoneCouncelArticle.do", target:""});
		
		$( "#moblphonNoHead, #moblphonNoMiddle,  #moblphonNoTail" ) .change(function () {
			$("#moblphonNo").val(  $( "#moblphonNoHead" ).val() +'-'+ $( "#moblphonNoMiddle" ).val() +'-'+ $( "#moblphonNoTail" ).val() );
		});
		
		$("#button_Phone").bind("click", function(){
				$("#phoneForm").submit();
		});
		
		//전체 리플뉴스조회
 		jsonRippleNewList();
 		//전체 리플공지조회
 		jsonRippleNoticeList();
 		
 		$("[name=btnChart]").click(function(e){
 			e.preventDefault();
 			var chartType = $(this).data("type");
 			var param = {
 					chartType : chartType
 			}
 			sendPost("${contextPath}/main/selectXrpChartData.do", param, "fn_chartData");
 		});
	
	});
	
	function jsonRippleNewList(){
		var params = $("form[name=formNotice").serialize();
		BIT.callAjax('${contextPath}/main/jsonRippleNewList.do'
				, 'post'
				, params
				, function(responseText) {
					var $body = $('#potalRippleNewsContents');
					//초기화 처리
					$body.html("");
					
					var dataList = responseText.Data;
					var html = '';
					var size = dataList.length;
					//공지사항 section에 display될 갯수 제한
					if(size > 3)
						size = 3;
					for (var i = 0 ; i < size ; i++) {
						var j = i+1
						var $li = $('<div id="section04_'+j+'"></div>');
						html = '';
						html += '   <p id="p4">';
						html +=     dataList[i].nttSj.substring(0,12) + '...';     
						html += '   </p>';
						html += '   <div id="section04_'+j+'_1"><a href="<c:url value="/customer/rippleNewsInqire.do?nttId="/>'+dataList[i].nttId+'">';
						html += '   <p id="p2">+더보기</p></a></div>';
						$li.append(html);
						$body.append($li);	
					}
				}
		)
	}
	
	function jsonRippleNoticeList(){
		var params = $("form[name=formNotice").serialize();
		BIT.callAjax('${contextPath}/main/jsonRippleNoticeList.do'
				, 'post'
				, params
				, function(responseText) {
					var $body = $('#potalRippleNoticeContents');
					//초기화 처리
					$body.html("");
					
					var dataList = responseText.Data;
					var html = '';
					var size = dataList.length;
					//공지사항 section에 display될 갯수 제한
					if(size > 3)
						size = 3;
					for (var i = 0 ; i < size ; i++) {
						var j = i+1
						var $li = $('<div id="section08_'+j+'"></div>');
						html = '';
						html += '   <p id="p4">';
						html +=     dataList[i].nttSj.substring(0,12) + '...';     
						html += '   </p>';
						html += '   <div id="section08_'+j+'_1"><a href="<c:url value="/customer/rippleNoticeInqire.do?nttId="/>'+dataList[i].nttId+'">';
						html += '   <p id="p2">+더보기</p></a></div>';
						$li.append(html);
						$body.append($li);	
					}
				}
		)
	}
	
</script>


        