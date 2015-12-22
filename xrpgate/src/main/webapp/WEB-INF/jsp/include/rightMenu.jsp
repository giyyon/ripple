<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>
<%
	egovframework.com.cmm.LoginVO user = (egovframework.com.cmm.LoginVO)egovframework.com.cmm.util.EgovUserDetailsHelper.getAuthenticatedUser();

	String id = "";
	String pw = "";	
	if(user != null){
// 		id = user.getId();
// 		pw = user.getId();
	
		id = "sssang79";
		pw = "1234";
	}
%>
	<!-- 마이페이지 -->
	<form name="form_mall" id="form_mall" method="post" target="_blank"">
		<input type="hidden" id="member_id" name="member_id"  value='<%=id %>'>
		<input type="hidden" id="member_pwd" name="member_pwd" value='<%=pw %>'>	
	</form>
	<div id="rightmenu">
	    <div id="rightmenu01"><img src="/img/m60001.jpg" width="95" height="120" usemap="#Map4" border="0" />
	      <map name="Map4" id="Map4">
	        <area shape="rect" coords="7,8,86,116" href="/myInfo/myInfoInqire.do" />
	      </map>
	    </div>
	    <!-- 공지사항 -->
	    <div id="rightmenu02"><img src="/img/m60002.jpg" width="95" height="120" usemap="#Map5" border="0" />
	      <map name="Map5" id="Map5">
	        <area shape="rect" coords="8,13,88,116" href="/customer/rippleNoticeList.do" />
	      </map>
	    </div>
	    <!-- 구매신청 -->
	    <div id="rightmenu03"><img src="/img/m60003.jpg" width="95" height="120" usemap="#Map6" border="0" />
	      <map name="Map6" id="Map6">
	        <area shape="rect" coords="9,11,85,115" href="/trade/callRippleTradeBuyModify.do" />
	      </map>
	    </div>
	    <!-- 판매신청 -->
	    <div id="rightmenu04"><img src="/img/m60004.jpg" width="95" height="120" usemap="#Map7" border="0" />
	      <map name="Map7" id="Map7">
	        <area shape="rect" coords="11,14,82,114" href="/trade/callRippleTradeSellModify.do" />
	      </map>
	    </div>
	    <!-- 전화신청 -->
	    <div id="rightmenu05"><img src="/img/m60005.jpg" width="95" height="120" usemap="#Map8" border="0" />
	      <map name="Map8" id="Map8">
	        <area shape="rect" coords="13,13,82,115" href="/customer/callPhoneCouncelModify.do"" />
	      </map>
	    </div>
	    <!-- QnA -->
	    <div id="rightmenu06"><img src="/img/m60006.jpg" width="95" height="120" usemap="#Map9" border="0" />
	      <map name="Map9" id="Map9">
	        <area shape="rect" coords="9,17,82,112" href="/customer/callQnAModify.do" />
	      </map>
	    </div>
	    <!-- 전화/QnA  신청현황-->
	    <div id="rightmenu07"><img src="/img/m60007.jpg" width="95" height="120" usemap="#Map10" border="0" />
	      <map name="Map10" id="Map10">
	        <area shape="rect" coords="9,10,88,115" href="/customer/phoneQnAList.do" />
	      </map>
	    </div>
	    <!-- 리플뉴스 -->
	    <div id="rightmenu08"><img src="/img/m60008.jpg" width="95" height="120" usemap="#Map11" border="0" />
	      <map name="Map11" id="Map11">
	        <area shape="rect" coords="7,11,86,113" href="/customer/rippleNewsList.do" />
	      </map>
	    </div>
	    <!-- 쇼핑몰 -->
	    <div id="rightmenu09"><img src="/img/m60009.jpg" width="95" height="120" usemap="#Map12" border="0" />
	      <map name="Map12" id="Map12">
	        <area shape="rect" coords="12,7,90,115"  onclick="go_login_proc(); return false;"/>
	      </map>
	    </div>
	    <!-- 신한 덤포인트 카드 신청방법 -->
	    <div id="rightmenu10"><img src="/img/m60014.jpg" width="95" height="120" usemap="#Map13" border="0" />
	      <map name="Map13" id="Map13">
	        <area shape="rect" coords="9,11,87,116" href="http://xrpgate.com/customer/rippleNoticeInqire.do?nttId=212" />
	      </map>
	    </div>
	</div>
	
<script type="text/javaScript" language="javascript">
   $(function(){
		$("#form_mall").attr("action", "http://rippleclub.co.kr/loginProc.do");
   })
   
   function go_login_proc(){
		if($("#member_id").val() == ""){
			$("#form_mall").attr("action", "http://rippleclub.co.kr");
		}
		$("#form_mall").submit();
	}
  </script>