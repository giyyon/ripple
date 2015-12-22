<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/taglib.jsp" %>

<link href="/css/style4.css" rel="stylesheet" type="text/css">

<!--타이틀시작-->
<div id="header3"><img src="/img/title0006.jpg" width="400" height="35" />
<!-- </div> -->
<!--타이틀끝-->

<div id="aside">  
  <div id="aside01"><img src="/img/s5.jpg" width="788" height="640" usemap="#Map_myInfo" border="0" />
    <map name="Map_myInfo" id="Map_myInfo">
      <area shape="rect" coords="180,14,250,35" href="/login/actionLogout.do" />
      <area shape="rect" coords="527,197,773,231" href="/myInfo/myRippleTradeList.do" />
      <area shape="rect" coords="592,582,773,629" href="/myInfo/callMyInfoModifyPage.do" />
    </map>
    <map name="Map" id="Map">
      <area shape="rect" coords="527,198,772,232" href="#" />
      <area shape="rect" coords="591,583,773,629" href="#" />
      <area shape="rect" coords="5,7,236,91" href="#" />
  </map>
  <div id="aside04_1"><p><c:out value='${mberManageVO.mberNm}'/>고객님</p></div>
  <div id="aside04_2"><p id="p2">(최근접속: <c:out value='${mberManageVO.loginDe}'/>)</p>
  </div>
  <div id="aside04_3">
<!--   	<p>리플구매예약금액: 0원</p> -->
  </div>
  <div id="aside04_4"><p>리플구매예약금액: <c:out value='${tradeVO.requestBuyMoney}'/>원</p></div>
  <div id="aside04_5">
  <p>리플판매예약수량: <c:out value='${tradeVO.requestSellQty}'/> &nbsp;(단위 : 리플)</p>
<!--     <p>이름:  홍 길 동</p> -->
  </div>
  <div id="aside04_6">
    <p>이메일: <c:out value='${mberManageVO.mberEmailAdres}'/></p></div>
  <div id="aside04_7">
    <p>아이디: <c:out value='${mberManageVO.mberId}'/></p></div>
  <div id="aside04_8">
    <p>휴대폰번호: <c:out value='${mberManageVO.moblphonNo}'/></p></div>
  <div id="aside04_9">
    <p>자택전화번호: <c:out value='${mberManageVO.areaNo}'/>-<c:out value='${mberManageVO.middleTelno}'/>-<c:out value='${mberManageVO.endTelno}'/></p></div>
  </div>
</div>

	<!--우측메뉴 시작-->
	<%@ include file="../include/rightMenu.jsp" %>

  <script> 
   function linkListPage(){
	   $('#frm').attr('action', '${contextPath}/admin/rippleNoticeList.do'); 
	   $("#frm").submit();
   }
	
	$('[name=btnFileDownload]').click(function(e) {
		e.preventDefault();
		var category = $(this).attr('data_category');
		var $imgId = $(this).parent().find(':hidden');
		COM.openFileListPopup(category, $imgId.val());
	});
  </script> 

