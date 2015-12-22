<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../include/taglib.jsp" %>

<link href="/css/style.css" rel="stylesheet" type="text/css">

<!--섹션시작-->
<div id="section"> 
	<!--좌측메뉴시작-->
	<div id="aside"> 
	
		<security:authorize access="isAnonymous()">
			<form id="loginForm" action ="<c:url value='/login/actionLogin.do'/>" method="post">
			<input name="userSe" type="hidden" value="GNR">
			    <div id="aside01">
			    	<img src="/img/m2.jpg" width="255" height="120"  usemap="#Map_login" />
				   <map name="Map_login" id="Map_login">
				     <area shape="rect" coords="210,45,248,67" alt="로그인" id="button_login"/>
				     <area shape="rect" coords="5,85,147,112" alt="ID/비번찾기" href="#" />
				     <area shape="rect" coords="165,89,233,111" alt="회원가입" href="${contextPath}/join/joinStep1.do" />
				   </map>			    	
			    	
					<div style="position: absolute; top: 46px; left: 5px; width: 95px; height:18px;">
					<input type="text" name="id" id="id" style=" width:95px; height:18px;"/>
		<!-- 		      <input type="text" name="mberId" id="mberId" style="position: absolute; top: 46px; left: 5px; width: 95px; height:18px;" onclick="javascript:alert('a');"/> -->
					</div>
			   
			    	<div style="position: absolute; top: 46px; left: 107px; width: 95px; height: 18px;">
			     	 <input type="password" name="password" id="password" style=" width:95px; height:18px;"/>
			    	</div>
			    </div>	
			</form>
		      
		    <div id="aside02">
		    <form:form commandName="searchVO"  id="phoneForm">
				<input type="hidden" name="bbsId" value="<c:out value='${searchVO.bbsId}'/>" />
				<input type="hidden" name="nttId"  value="<c:out value="${searchVO.nttId}"/>" />
				<input type="hidden" name="ntcrId"  value="<c:out value="${searchVO.ntcrId}"/>" /> <!--작성자id -->
				<input type="hidden" id="moblphonNo"  name="moblphonNo"  value="<c:out value="${searchVO.moblphonNo}"/>" > <!--핸드폰번호 -->
		    	<img src="/img/m3.jpg" width="255" height="400" usemap="#Map3" border="0" />
				<map name="Map3" id="Map3">
					<area shape="rect" coords="91,315,156,374" id="button_Phone" />
				</map>
				<div style="position: absolute; top: 138px; left: 16px; width: 200px; height: 18px;">
					<label for="name"></label>
					<input type="text" name="name2" id="name" style=" width:200px; height:18px;" />
			    </div>
				<div style="position: absolute; top: 196px; left: 16px; width: 200px; height: 18px;">
					<label for="select"></label>
				    <select name="moblphonNoHead" id="moblphonNoHead" style="width:48px; height:20px;">
				      <option>010</option>
				      <option>011</option>
				      <option>016</option>
				      <option>017</option>
				      <option>018</option>
				      <option>019</option>
				    </select>
				    -
				    <label for="textfield"></label>
				    <input type="text" name="moblphonNoMiddle" id="moblphonNoMiddle" style=" width:52px; height:18px;"/>
				    -
				    <label for="textfield2"></label>
				    <input type="text" name="moblphonNoTail" id="moblphonNoTail" style=" width:52px; height:18px;" />
				</div>
			</form:form>
		    </div>
		    <div id="aside03">
		    	<img src="/img/m50005.jpg" width="255" height="120" usemap="#Map18" border="0" />
				<map name="Map18" id="Map18">
					<area shape="rect" coords="7,7,244,112" href="http://xrpgate.com/customer/rippleNoticeInqire.do?nttId=212" />
				</map>
		    </div>
	    </security:authorize>
	
		<security:authorize access="isAuthenticated()">
		<form:form commandName="mberManageVO"  id="form">   
			<div id="aside04">
				<img src="/img/m9.jpg" width="255" usemap="#Map_logOut"  height="515" />
				<map name="Map_logOut" id="Map_logOut">
					<area shape="rect" coords="170,2,244,25"    alt="로그아웃"  onmouseover=""  class='handPnt'   href="/login/actionLogout.do" />
					<area shape="rect" coords="34,325,165,341"    alt="마이페이지"  onmouseover=""  class='handPnt'   href="/myInfo/myInfoInqire.do" />
					<area shape="rect" coords="34,361,165,378"    alt="리플구매신청하기"  onmouseover=""  class='handPnt'   href="/trade/callRippleTradeBuyModify.do" />
					<area shape="rect" coords="34,395,165,411"    alt="리플판매신청하기"  onmouseover=""  class='handPnt'   href="/trade/callRippleTradeSellModify.do" />
					<area shape="rect" coords="34,430,165,447"    alt="리플구매/판매조회"  onmouseover=""  class='handPnt'   href="/myInfo/myRippleTradeList.do" />
				</map>
   
				<div id="aside04_1"><p><c:out value='${mberManageVO.mberNm}'/>고객님</p>
				</div>
				<div id="aside04_2"><p id="p2">최근접속: <c:out value='${mberManageVO.loginDe}'/></p>
				</div>
				<div id="aside04_3"><p>리플구매예약금액 : <fmt:formatNumber type="number" value="${tradeVO.requestBuyMoney}"/>원</p></div>
				<div id="aside04_4"><p>리플판매예약수량 : <fmt:formatNumber type="number" value="${tradeVO.requestSellQty}"/> 개</p></div>
			</div>
				   
		    <div id="aside03 ">
		    <img src="/img/m50005.jpg" width="255" height="120" usemap="#Map18"  border="0" />
		    <map name="Map18" id="Map18"><area shape="rect" coords="7,7,244,112" href="http://xrpgate.com/customer/rippleNoticeInqire.do?nttId=212" /></map>
		    </div>	
		</form:form>
		</security:authorize>	    
	</div>
	<!--좌측메뉴 끝-->

	<!--본문시작-->
	<form id='formNotice'></form>
	<div id="section00"> 
	  <div id="section01"><img src="/img/m40001.jpg" width="255" height="250" /></div>
	  <div id="section02"><img src="/img/m40002.jpg" width="255" height="250" /></div> 
	  <div id="section03"><img src="/img/m50001.jpg" width="255" height="120" /></div> 
	  <div id="section04"><img src="/img/m50002.jpg" width="255" height="120" />
		<div id='potalRippleNewsContents'>
        </div>
	  </div> 
	   
	  <div id="section05"><img src="/img/m50003.jpg" width="255" height="120" usemap="#Map14" border="0" />
	    <map name="Map14" id="Map14">
	      <area shape="rect" coords="8,6,246,113" href="#" />
	    </map>
	  </div> 
	  <div id="section06"><img src="/img/m50004.jpg" width="255" height="120" usemap="#Map15" border="0" />
	    <map name="Map15" id="Map15">
	      <area shape="rect" coords="6,6,248,113" href="#" />
	    </map>
	  </div>                                         
	  <div id="section07">

	  		<ul class="bt-roll" style="z-index: 2">
				<li><a href="#"><img src="/img/btn_circle_.png" alt=""></a></li>
				<li><a href="#"><img src="/img/btn_circle.png" alt=""></a></li>
				<li><a href="#"><img src="/img/btn_circle.png" alt=""></a></li>
			</ul>

			<div class="album-wrap" style="z-index: 1">
				<ul class="album clfix">
					<li><a href="http://xrpgate.com/customer/rippleNoticeInqire.do?nttId=222"><img src="/img/m50008_1.jpg" alt=""></a></li>
					<li><a href="http://xrpgate.com/customer/rippleNoticeInqire.do?nttId=223"><img src="/img/m50008_2.jpg" alt=""></a></li>
					<li><a href="http://xrpgate.com/customer/rippleNoticeInqire.do?nttId=221"><img src="/img/m50008_3.jpg" alt=""></a></li>
				</ul>
			</div>	  
	  
<!-- 	  <embed src="/resource/contents/intro.swf" quality="high" pluginspage="http://www.macromedia.com/go/getfashplayer" type="application/x-shockwave-flash" width="255" height="120"> -->
	  </div> 
	  <div id="section08"><img src="/img/m50007.jpg" width="255" height="120" border="0" />
		<div id='potalRippleNoticeContents'>
        </div>
	  </div>  
	 </div>
	<!--본문 끝-->

	<!--우측메뉴 시작-->
	<%@ include file="../include/rightMenu.jsp" %>

</div>

<script type="text/javaScript" language="javascript">
	//설명 동영상용 이미지 롤링 기능 <-Start->
	var $list = $('ul.album');
	var size = $list.children().outerWidth();
	var len =  $list.children().length;
	var speed = 2000;
	var timer = null;
	var auto = true;
	var cnt = 1;
	
	$list.css('width',len*size);
	
	if(auto) timer = setInterval(autoSlide, speed);
	
	$list.children().bind({
		'mouseenter': function(){
			if(!auto) return false;
			clearInterval(timer);
			auto = false;
		},
		'mouseleave': function(){
			timer = setInterval(autoSlide, speed);
			auto = true;
		}
	})
	
	$('.bt-roll').children().bind({
		'click': function(){
			var idx = $('.bt-roll').children().index(this);
			cnt = idx;
			autoSlide();
			return false;
		},
		'mouseenter': function(){
			if(!auto) return false;
			clearInterval(timer);
			auto = false;
		},
		'mouseleave': function(){
			timer = setInterval(autoSlide, speed);
			auto = true;
		}
	});			
	//설명 동영상용 이미지 롤링 기능 <-End->

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
	function autoSlide(){
		if(cnt>len-1){
			cnt = 0;
		}

		$list.animate({'left': -(cnt*size)+'px' },'normal');

		var source2 = $('.bt-roll').children().find('img').attr('src').replace('_.png','.png');
		$('.bt-roll').children().find('img').attr('src',source2);

		var source = $('.bt-roll').children().find('img').attr('src').replace('.png','_.png');
		$('.bt-roll').children().eq(cnt).find('img').attr('src',source);

		cnt++;
	}
</script>
        