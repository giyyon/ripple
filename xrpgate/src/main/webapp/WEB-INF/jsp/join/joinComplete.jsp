<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<link href="/css/style2.css" rel="stylesheet" type="text/css">

<!--타이틀시작-->
<div id="header"><img src="/img/title0005.jpg" width="400" height="35" />
</div>
<!--타이틀끝-->

<!--섹션시작-->
<div id="section"> 

<!--본문시작-->
<div id="section00"><img src="/img/s4.jpg" width="790" height="250" border="0" />
	<div id="text01">
		<p><c:out value='${mberManageVO.mberNm}'/>님 Club MFC 회원으로 가입해주셔서 감사합니다.</p>
		<p> 회원님께서는 이제 Club MFC을 통해 자유롭게 다양한 리플정보 및 거래를 하실 수 있습니다.</p>
	</div>
</div>
<!--본문 끝-->

<!--우측메뉴 시작-->
<div id="rightmenu">
    <div id="rightmenu01"><img src="/img/m60015.jpg" width="95" height="120" usemap="#Map4" border="0" />
      <map name="Map4" id="Map4">
        <area shape="rect" coords="7,8,86,116" href="/" />
      </map>
    </div>
    <div id="rightmenu02"><img src="/img/m60016.jpg" width="95" height="120" usemap="#Map5" border="0" />
      <map name="Map5" id="Map5">
        <area shape="rect" coords="8,13,88,116" href="/customer/callPhoneCouncelModify.do" />
      </map>
    </div>
    <div id="rightmenu03"></div>
    <div id="rightmenu04"></div>
</div>

</div>


</body>

</html>
